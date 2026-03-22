# WireGuard

VPN サーバー。外部から安全にサーバーにアクセスするために使用。

## ポート

- UDP 51820（ルーターのポートフォワーディングが必要）

## クライアント設定の確認

```bash
# QR コードを表示（スマートフォン向け）
docker exec wireguard /app/show-peer peer1

# 設定ファイルの場所（コンテナ内）
# /config/peer_*/peer_*.conf
```

## データディレクトリ

`config/` ディレクトリには秘密鍵が含まれるため .gitignore 対象。
サーバー移行時は別途バックアップが必要。
