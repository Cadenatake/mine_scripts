#!/bin/bash

cd $(dirname ${0}) && CURRENTDIR=`pwd`
source ./config.sh
PROGNAME=$(basename $0)

# エラー発生時の処理を設定
# 終了コード1 2 3 15の場合に第一引数のコマンドが走る
trap 'tmux send-keys -t "0" "save-on" ENTER; tmux send-keys -t "0" "say Minecraft Restart Error" ENTER; exit 1' 1 2 3 15

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
cd ${WORLDDATAPATH}
pwd

# ログ成形
echo ''

# ゲーム内バックアップ開始メッセージ
tmux send-keys -t "0" "say Restart this server after 5min." ENTER
tmux send-keys -t "0" "say Players are requested to log out. You can ignore it and play." ENTER
tmux send-keys -t "0" "say The restart process takes about 3 minutes." ENTER

#################### gitへのバックアップ処理 ####################
tmux send-keys -t "0" "save-all" ENTER
cp -r ${WORLDDATAPATH} ${GITPATH}
#################### gitへのバックアップ処理 ####################

sleep 4m
tmux send-keys -t "0" "say Restart this server after 1min." ENTER
tmux send-keys -t "0" "say The restart process takes about 2 minutes." ENTER
sleep 50
tmux send-keys -t "0" "say 10..." ENTER
sleep 1
tmux send-keys -t "0" "say 9..." ENTER
sleep 1
tmux send-keys -t "0" "say 8..." ENTER
sleep 1
tmux send-keys -t "0" "say 7..." ENTER
sleep 1
tmux send-keys -t "0" "say 6..." ENTER
sleep 1
tmux send-keys -t "0" "say 5..." ENTER
sleep 1
tmux send-keys -t "0" "say 4..." ENTER
sleep 1
tmux send-keys -t "0" "say 3..." ENTER
sleep 1
tmux send-keys -t "0" "say 2..." ENTER
sleep 1
tmux send-keys -t "0" "say 1..." ENTER
sleep 1
tmux send-keys -t "0" "say Restart!!" ENTER
tmux send-keys -t "0" "say See you again ;3" ENTER
tmux send-keys -t "0" "say The restart process takes about 2 minutes." ENTER
sleep 1

#################### 再起動処理 ####################
tmux send-keys -t "0" "stop" ENTER &&\
sleep 30 &&\
tmux send-keys -t "0" "bash run.sh" ENTER &&\
sleep 30
#################### 再起動処理 ####################

if [ $? -gt 0 ]; then
    error_exit "Lines:$LINENO: An error has occurred."
fi

# ゲーム内再起動完了メッセージ
tmux send-keys -t "0" "say Restart Done." ENTER
tmux send-keys -t "0" "say Thank you for wating." ENTER

# ログ成形
echo ''
date '+%Y/%m/%d %T'
echo '----------------END----------------'

exit 0