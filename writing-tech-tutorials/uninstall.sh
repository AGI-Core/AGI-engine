#!/bin/bash

SKILL_NAME="writing-tech-tutorials"
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

if [ -L "$TARGET" ]; then
    rm "$TARGET"
    echo "✅ 已移除 symlink：$TARGET"
elif [ -e "$TARGET" ]; then
    echo "⚠️  警告：$TARGET 不是 symlink，未删除。请手动检查后再删除。"
    exit 1
else
    echo "未找到安装：$TARGET"
fi
