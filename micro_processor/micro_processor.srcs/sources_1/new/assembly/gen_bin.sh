#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Usage: gen_bin.sh ASM_FILE"
fi

perl as.pl $1 > $(echo $1 | sed 's/.asm/.bin/')
