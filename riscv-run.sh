#!/bin/bash
# 在 RISC-V 远程机器上执行命令
# 用法:
#   ./riscv-run.sh <命令>           # 执行单条命令
#   ./riscv-run.sh                  # 进入交互式 shell
#   ./riscv-run.sh "cd ~/Desktop/model-zoo-tts && make"   # 执行多命令

HOST="bianbu@10.0.90.157"

if [[ $# -eq 0 ]]; then
    # 无参数：交互式 shell
    exec ssh "$HOST"
else
    # 有参数：在远程执行
    exec ssh "$HOST" "$@"
fi
