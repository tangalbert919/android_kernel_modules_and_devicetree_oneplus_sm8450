README.txt

To compile these kernel modules, you must clone them alongside other repos:

`repo init -u https://github.com/tangalbert919/kernel-build -b gki --git-lfs`
`repo sync`

Apply the patches found in the "patches" folder. Then run:

./build.sh taro