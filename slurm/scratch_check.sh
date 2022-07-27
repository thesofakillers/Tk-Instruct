#!/bin/bash

# sets up scratch dir

source ~/.bashrc

# {{{ relevant scratch subdir exists
tk_inst_dir="/var/scratch/$USER/repos/tk-instruct"
echo ensuring $tk_inst_dir exists
mkdir -p $tk_inst_dir
# }}}

# {{{ cache folder exists
echo ensuring "$tk_inst_dir/cache" exists
mkdir -p "$tk_inst_dir/cache"
# }}}

# {{{ natural instructions download
if [ -d "$tk_inst_dir/data" ]
then
  echo Natural Instructions folder found, skipping download.
else
  git clone https://github.com/allenai/natural-instructions.git \
    "$tk_inst_dir/data"

  cd $HOME
  echo "done"
fi
# }}}

# {{{ natural instructions data splits
echo making dev splits
cd "$tk_inst_dir/data"
cp splits/default/test_tasks.txt splits/default/dev_tasks.txt
cp splits/xlingual/test_tasks.txt splits/xlingual/dev_tasks.txt

cd $HOME
echo "done"
# }}}
