#!/bin/bash
CURR_DIR=`dirname "${BASH_SOURCE[0]}"`
mkdir -p ~/.config/nvim
cp -r ${CURR_DIR}/* ~/.config/nvim/
rm ~/.config/nvim/install.sh
