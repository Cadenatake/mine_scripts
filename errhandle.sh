#!/usr/bin/env bash

# 実行した処理を標準出力に記録する
set -x

# エラーになったときに実行したい関数
function error_handler() {
  # 何か起きたことを標準エラー出力に書く
  echo "ERROR" >&2
  # スクリプトを終了する
  exit 1
}

# コマンドの返り値が非ゼロのときハンドラを実行するように指定する
trap error_handler ERR

# 例として非ゼロを返すコマンドを実行する
false

