# Cloudflared

Cloudflare Tunnel を使って、サーバーを外部に安全に公開する。

## トンネルの作成手順

```bash
# cloudflared をインストール（ローカル or サーバーで実行）
# https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/

# ログイン
cloudflared tunnel login

# トンネルを作成
cloudflared tunnel create dmz-server

# トークンを取得（Cloudflare Dashboard > Zero Trust > Networks > Tunnels）
# トークンを .env の CLOUDFLARE_TUNNEL_TOKEN に設定
```

## 設定

Cloudflare Zero Trust Dashboard でルーティングを設定する:
- `https://your.domain.com` -> `http://pihole:80`（Pi-hole 管理画面など）
