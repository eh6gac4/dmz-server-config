#!/bin/bash
# すべてのサービスのイメージを更新して再起動する

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_DIR="$(dirname "$SCRIPT_DIR")"

cd "$COMPOSE_DIR"

echo "==> イメージを更新中..."
docker compose pull

echo "==> サービスを再起動中..."
docker compose up -d --remove-orphans

echo "==> 古いイメージを削除中..."
docker image prune -f

echo "==> 完了"
docker compose ps
