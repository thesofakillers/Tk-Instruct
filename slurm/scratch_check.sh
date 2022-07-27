#!/bin/bash

# sets up scratch dir

source ~/.bashrc

# {{{ conda is installed
if [ ! -d "/var/scratch/$USER/miniconda3" ]
then
  echo "Conda is not installed. Downloading"
  cd "/var/scratch/$USER"
  curl https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh \
    --output miniconda.sh

  echo "Installing conda"
  bash miniconda.sh -b -p "/var/scratch/$USER/miniconda3"

  cd $HOME
  echo "done."
else
  echo "Conda is installed. Skipping"
fi
#}}}

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
  echo "done."
fi
# }}}

# {{{ natural instructions data splits
echo making dev splits
cd "$tk_inst_dir/data"
cp splits/default/test_tasks.txt splits/default/dev_tasks.txt
cp splits/xlingual/test_tasks.txt splits/xlingual/dev_tasks.txt

cd $HOME
echo "done."
# }}}
