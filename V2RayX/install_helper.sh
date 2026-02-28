#!/bin/sh

#  install_helper.sh
#  V2RayX
#
#  Copyright © 2016年 Cenmrev. All rights reserved.

cd `dirname "${BASH_SOURCE[0]}"`
sudo mkdir -p "/Library/Application Support/V2RayXL/"
sudo cp v2rayxl_sysconf "/Library/Application Support/V2RayXL/"
sudo chown root:admin "/Library/Application Support/V2RayXL/v2rayxl_sysconf"
sudo chmod +s "/Library/Application Support/V2RayXL/v2rayxl_sysconf"

echo done
