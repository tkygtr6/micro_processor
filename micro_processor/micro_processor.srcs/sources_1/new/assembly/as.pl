#!/usr/bin/perl
# as.pl @ UTF-8 / tab=4sp
# CPU実験のプロセッサ用アセンブラ
# perl as.pl assembly.s [binary.txt]
# 分岐先にはラベルと即値の両方が利用可能
# 更新履歴
# v1:	2016/10/25 改造版を坂井アーキテクチャに戻す、ファイル出力・エラー出力対応、説明追加

use utf8;
use File::Basename;
use Cwd 'abs_path';

my $abspath = abs_path($0);
my $scriptName = basename($0, '');

# OS別処理
if ($abspath !~ m!^/!) {
	# windows (Cygwinでない)
	my $enc_os = 'cp932';
	binmode STDIN, ":encoding($enc_os)";
	binmode STDOUT, ":encoding($enc_os)";
	binmode STDERR, ":encoding($enc_os)";
}

if ($#ARGV < 0) {
	print STDERR <<"EOL";
usage: perl $scriptName <アセンブリファイル> [<出力ファイル>]
出力ファイル名を指定しない場合、標準出力に出力
アセンブリファイル形式:
  らべる: # ラベル名は数字や「-」で始めなければたぶんOK
          # マルチバイト文字の挙動は保証しない
        addi 3 2 1   # 字下げは自由に
        addi 3 3 4   # レジスタ番号のrは省略していい
        ADDI 3 3 4   # 命令は大文字でもいい
  test: j test       # アドレス指定はラベルでも即値でも
                     # このときラベルはオフセット計算される
  ; コメントは # ; // のいずれでも可能、空行は無視される
    lw 5 data(r2)    # 即値にラベルを使える
    lw 6 -2(r5)      # 即値に十進負数も使える
    lw 7 0xA(r6)     # 即値に16進数も使える
    add r3,r2 r1     # 引数区切りに「,」を使ってもよい
  data:              # ラベルは改行してもしなくても
    .long 4294967295 # データは10進正数32bit
    .long 0xff       # または0xで始まる16進32bit
    .long ffh        # あるいはhで終わる16進32bit
EOL
	exit;
}

# ラベルの取り込み
open(FH, "$ARGV[0]") or die "ERROR: Cannot open file {$ARGV[0]}";
$i = 0;
while ($line = <FH>) {
	# ラベル、カンマ、空白、タブの処理
	$line =~ s/,/ /g;
	$line =~ s/\t+/ /g;
	$line =~ s/\:/ : /g;
	#$line =~ s/\..*$//g;	# .コマンドを無視する
	$line =~ s/(#|;|\/\/).*$//g;	# コメントを無視する
	$line =~ s/^ +//g;
	$line =~ s/[\r\n]+\z//;
	@instruction = split(/ +/, $line);
	if ($instruction[1] eq ":") {
		$labels{$instruction[0]} = $i * 4;
		# ラベルのみでない
		if ($#instruction > 1) {
			$i++;
		}
	}
	# 空行を無視する
	elsif (length($line) > 0) {
		$i++;
	}
}
close(FH);

# アセンブル
open(FH, "$ARGV[0]") or die "ERROR: Cannot open file $ARGV[0]";
$i = 0;
$xi = 0;	# テキストファイル上の行数
$output = "";	# 出力用テキスト
# ヘッダー出力
while ($line = <FH>) {
	$xi++;
	$line =~ s/,/ /g;
	$line =~ s/\t+/ /g;
	$line =~ s/\:/ : /g;
	#$line =~ s/\..*$//g;	# .コマンドを無視する
	$line =~ s/(#|;|\/\/).*$//g;	# コメントを無視する
	$line =~ s/^ +//g;
	$line =~ s/[\r\n]+\z//;
	if (length($line) == 0) {next;}	# 空行無視
	@instruction = split(/ +/, $line);
	if ($instruction[1] eq ":") {# ラベルのある行をフィールドに分割する
		if ($#instruction == 1) {next;}	# ラベルのみの行
		$op = $instruction[2];
		$f2 = $instruction[3];
		$f3 = $instruction[4];
		$f4 = $instruction[5];
		$f5 = $instruction[6];
	}
	else {# ラベルのない行をフィールド分割する
		$op = $instruction[0];
		$f2 = $instruction[1];
		$f3 = $instruction[2];
		$f4 = $instruction[3];
		$f5 = $instruction[4];
	}
	# 機械語の出力
	if		($op=~/^add$/i)		{p_insn(r_b(6,0)  . r_r($f3) . r_r($f4) . r_r($f2) . r_b(11,0));}
	elsif	($op=~/^addi$/i)	{p_insn(r_b(6,1)  . r_r($f3) . r_r($f2) . r_im(16, 0, $f4));}
	elsif	($op=~/^sub$/i)		{p_insn(r_b(6,0)  . r_r($f3) . r_r($f4) . r_r($f2) . r_b(11, 2));}
	elsif	($op=~/^lui$/i)		{p_insn(r_b(6,3)  . r_r("0") . r_r($f2) . r_im(16, 0, $f3));}
	elsif	($op=~/^and$/i)		{p_insn(r_b(6,0)  . r_r($f3) . r_r($f4) . r_r($f2) . r_b(11, 8));}
	elsif	($op=~/^andi$/i)	{p_insn(r_b(6,4)  . r_r($f3) . r_r($f2) . r_im(16, 0, $f4));}
	elsif	($op=~/^or$/i)		{p_insn(r_b(6,0)  . r_r($f3) . r_r($f4) . r_r($f2) . r_b(11,9));}
	elsif	($op=~/^ori$/i)		{p_insn(r_b(6,5)  . r_r($f3) . r_r($f2) . r_im(16, 0, $f4));}
	elsif	($op=~/^xor$/i)		{p_insn(r_b(6,0)  . r_r($f3) . r_r($f4) . r_r($f2) . r_b(11,10));}
	elsif	($op=~/^xori$/i)	{p_insn(r_b(6,6)  . r_r($f3) . r_r($f2) . r_im(16, 0, $f4));}
	elsif	($op=~/^nor$/i)		{p_insn(r_b(6,0)  . r_r($f3) . r_r($f4) . r_r($f2) . r_b(11,11));}
	elsif	($op=~/^sll$/i)		{p_insn(r_b(6,0)  . r_r($f3) . r_r("0") . r_r($f2) . r_b(5, $f4) . r_b(6, 16));}
	elsif	($op=~/^srl$/i)		{p_insn(r_b(6,0)  . r_r($f3) . r_r("0") . r_r($f2) . r_b(5, $f4) . r_b(6, 17));}
	elsif	($op=~/^sra$/i)		{p_insn(r_b(6,0)  . r_r($f3) . r_r("0") . r_r($f2) . r_b(5, $f4) . r_b(6, 18));}
	elsif	($op=~/^lw$/i)		{p_insn(r_b(6,16) . r_f($f3) . r_r($f2) . r_o($f3));}
	elsif	($op=~/^lh$/i)		{p_insn(r_b(6,18) . r_f($f3) . r_r($f2) . r_o($f3));}
	elsif	($op=~/^lb$/i)		{p_insn(r_b(6,20) . r_f($f3) . r_r($f2) . r_o($f3));}
	elsif	($op=~/^sw$/i)		{p_insn(r_b(6,24) . r_f($f3) . r_r($f2) . r_o($f3));}
	elsif	($op=~/^sh$/i)		{p_insn(r_b(6,26) . r_f($f3) . r_r($f2) . r_o($f3));}
	elsif	($op=~/^sb$/i)		{p_insn(r_b(6,28) . r_f($f3) . r_r($f2) . r_o($f3));}
	elsif	($op=~/^beq$/i)		{p_insn(r_b(6,32) . r_r($f2) . r_r($f3) . r_im(16, 1, $f4));}
	elsif	($op=~/^bne$/i)		{p_insn(r_b(6,33) . r_r($f2) . r_r($f3) . r_im(16, 1, $f4));}
	elsif	($op=~/^blt$/i)		{p_insn(r_b(6,34) . r_r($f2) . r_r($f3) . r_im(16, 1, $f4));}
	elsif	($op=~/^ble$/i)		{p_insn(r_b(6,35) . r_r($f2) . r_r($f3) . r_im(16, 1, $f4));}
	elsif	($op=~/^j$/i)		{p_insn(r_b(6,40) . r_im(26, 0, $f2));}
	elsif	($op=~/^jal$/i)		{p_insn(r_b(6,41) . r_im(26, 0, $f2));}
	elsif	($op=~/^jr$/i)		{p_insn(r_b(6,42) . r_r($f2) . r_r("0") . r_r("0") . r_b(11, 0));} 
	elsif	($op=~/^halt$/i)		{p_insn(r_b(6,63) . r_im(26, 0, 0));} 
	elsif	($op=~/.long/i)		{p_insn(r_im(32, 0, $f2));}
	else {print STDERR "ERROR\@L$xi> $line\n Illegal Instruction!: $op\n";	exit;}
}
close(FH);
# ファイル出力
if ($#ARGV >= 1) {
	open(OUT, ">$ARGV[1]") or die "ERROR: Cannot open file $ARGV[1]";
	print OUT $output;
	close(OUT);
} else {
	print $output;
}

#  $numを2進数$digitsに変換して返す
sub r_b {
	($digits, $num) = @_;
	$num = $num + 0;
	if ($num < -(1 << ($digits - 1)) || (1 << $digits) <= $num) {
		print STDERR "ERROR\@L$xi> $line\n Invalid Range!:\n $num cannot be $digits bits!\n";
		exit;
	}
	if ($num >= 0) {
		return sprintf("%0".$digits."b_", $num);
	} else {
		my $r = sprintf("%b", $num);
		return substr($r, length($r) - $digits) . "_";	# perlビット数により長さが異なる
	}
}

# レジスタ番地をバイナリ列で返す
sub r_r {
	$_ = shift;
	s/^r//i;
	return r_b(5, $_);
}

#  ベースアドレスレジスタの番地を返す
sub r_base {
	$_ = shift;
	s/.*\(//;
	s/\)//;
	return($_); 
}

#  ベースアドレスレジスタをバイナリ列で返す
sub r_f {
	return r_r(r_base(shift));
}

# 変位を返す
sub r_dpl {
	$_ = shift;
	s/\(.*\)//;
	return($_); 
}

# 変位をバイナリ列で返す
sub r_o {
	return r_im(16, 0, r_dpl(shift));
}

# 即値(またはラベル)をバイナリ列で返す
sub r_im {
	my ($digits, $tooffsetlabel, $im) = @_;
	my $imn;
	if ($im =~ /^-?(0x([0-9a-fA-F]+))|(([0-9a-fA-F]+)h)$/) {
		# 16進数
		if ($im =~ /^-?0x([0-9a-fA-F]+)$/) {$imn = $1;}
		elsif ($im =~ /^-?([0-9a-fA-F]+)h$/) {$imn = $1;}
		$imn = hex($1);
		if ($im =~ /^-/) {
			$imn = - $imn;
		}
	} elsif ($im =~ /^-?([0-9]+)/) {
		# 10進数とする
		$imn = $im + 0;
	} elsif (exists($labels{$im})) {
		# ラベル
		$imn = $labels{$im};
		if ($tooffsetlabel) {
			$imn = $imn - $i * 4 - 4;
		}
	} else {
		print STDERR "ERROR\@L$xi> $line\n Invalid Immidiate!: $im\n";
		exit;
	}
	return r_b($digits, $imn);
}

# 出力データを蓄積
sub p_insn {
	my $bitstr = shift;
	my $exportstr = $bitstr;
	$exportstr =~ s/_//g;
	if (length($exportstr) != 32) {
		print STDERR "ERROR\@L$xi> $line\n Invalid Instruction length!: " . length($exportstr) . "\n$line -> \n$bitstr\n";
		exit;
	}
	$output = $output . $exportstr . "\n";
	$i++;
}
