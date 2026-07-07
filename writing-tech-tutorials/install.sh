#!/bin/bash
set -e

SKILL_NAME="writing-tech-tutorials"
# Auto-detect Agent skill directory by common conventions; fallback to default
if [ -n "$SKILL_INSTALL_ROOT" ]; then
    SKILL_ROOT="$SKILL_INSTALL_ROOT"
elif [ -n "$CODEX_HOME" ]; then
    SKILL_ROOT="$CODEX_HOME/skills"
elif [ -d "$HOME/.codex" ] || [ -d "$HOME/.codex/skills" ]; then
    SKILL_ROOT="$HOME/.codex/skills"
elif [ -d "$HOME/._agent-cn/skills" ]; then
    SKILL_ROOT="$HOME/._agent-cn/skills"
elif [ -d "$HOME/.trae-cn/skills" ]; then
    SKILL_ROOT="$HOME/.trae-cn/skills"
elif [ -d "$HOME/.claude/skills" ]; then
    SKILL_ROOT="$HOME/.claude/skills"
else
    SKILL_ROOT="$HOME/.codex/skills"
fi

TARGET="$SKILL_ROOT/$SKILL_NAME"
SOURCE="$(cd "$(dirname "$0")" && pwd)"

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
    echo "已存在：$TARGET"
    read -p "是否覆盖 (y/N)? " ans
    if [ "$ans" != "y" ] && [ "$ans" != "Y" ]; then
        echo "取消安装"
        exit 0
    fi
    rm -f "$TARGET"
fi

mkdir -p "$SKILL_ROOT"
ln -s "$SOURCE" "$TARGET"

echo "✅ 已 symlink：$TARGET → $SOURCE"
echo "触发方式：Use Skill: $SKILL_NAME"
echo "自定义安装位置：SKILL_INSTALL_ROOT=<path> ./install.sh"
