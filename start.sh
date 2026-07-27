#!/bin/bash

SESSION=furrysmp

# 既存セッションがあれば接続
if tmux has-session -t "$SESSION" 2>/dev/null; then
    exec tmux attach -t "$SESSION"
fi

# 新規セッション作成
tmux new-session -d -s "$SESSION"

# 左: 1.8
tmux send-keys -t "$SESSION:0.0" "cd server-1.8 && java -Xms512M -Xmx2G -jar server.jar nogui" C-m

# 真ん中: 1.12
tmux split-window -h -t "$SESSION:0.0"
tmux send-keys -t "$SESSION:0.1" "cd server-1.12 && java -Xms512M -Xmx2G -jar server.jar nogui" C-m

# 右: Waterfall
tmux select-pane -t "$SESSION:0.1"
tmux split-window -h
tmux send-keys -t "$SESSION:0.2" "cd waterfall && java -Xms512M -Xmx2G -jar waterfall.jar" C-m

# 横3分割を均等にする
tmux select-layout even-horizontal

# 接続
exec tmux attach -t "$SESSION"