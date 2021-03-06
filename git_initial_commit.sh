#!/bin/bash

cd $(dirname ${0}) && CURRENTDIR=`pwd`
source ./config.sh
PROGNAME=$(basename $0)

# エラー発生時の処理を設定
# 終了コード1 2 3 15の場合に第一引数のコマンドが走る
trap 'tmux send-keys -t "0" "save-on" ENTER; tmux send-keys -t "0" "say GitReset Error" ENTER; exit 1' 1 2 3 15

function error_exit
{

#   ----------------------------------------------------------------
#   Function for exit due to fatal program error
#       Accepts 1 argument:
#           string containing descriptive error message
#   ---------------------------------------------------------------- 

    echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
    exit 1
}

# ログ成形
echo ''
echo '---------------START---------------'
date '+%Y/%m/%d %T'

# ディレクトリ移動
cd ${GITDATAPATH}
pwd

# ログ成形
echo ''

# ゲーム内バックアップ開始メッセージ
tmux send-keys -t "0" "say GitReset Start!!" ENTER
sleep 1
tmux send-keys -t "0" "say You can play Minecraft :3" ENTER

tmux send-keys -t "0" "save-off" ENTER
tmux send-keys -t "0" "save-all" ENTER

#################### git処理 ####################
cp -r ${WORLDDATAPATH} ${GITPATH} &&\
git checkout --orphan latest_branch &&\
git add -A &&\
git commit -am "initial commit" &&\
git branch -D main &&\
git branch -m main &&\
git push -f origin main
#################### git処理 ####################

if [ $? -gt 0 ]; then
    error_exit "Lines:$LINENO: An error has occurred."
fi

# ゲーム内バックアップ終了メッセージ
tmux send-keys -t "0" "save-on" ENTER
tmux send-keys -t "0" "say GitReset Done." ENTER

# ログ成形
echo ''
date '+%Y/%m/%d %T'
echo '----------------END----------------'

exit 0