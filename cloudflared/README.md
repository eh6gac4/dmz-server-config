# Cloudflared

Cloudflare Tunnel を使って、Pi-hole 管理画面を外部に安全に公開する。

## ファイル構成

| ファイル | 内容 |
|---------|------|
| `config.yml` | トンネルの ingress ルール（git 管理） |
| `creds.json` | トンネルの認証情報（**gitignore 対象**） |

## セットアップ手順

### 1. cloudflared をインストール（作業 PC またはサーバーで実行）

```bash
# Debian/Ubuntu
curl -L https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list
sudo apt update && sudo apt install cloudflared
```

### 2. Cloudflare にログイン

```bash
cloudflared tunnel login
```

### 3. トンネルを作成

```bash
cloudflared tunnel create dmz-server
```

出力例:
```
Created tunnel dmz-server with id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

### 4. 認証情報ファイルをコピー

```bash
# 生成された creds.json をこのディレクトリにコピー
cp ~/.cloudflared/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.json ./cloudflared/creds.json
```

### 5. DNS レコードを作成

```bash
cloudflared tunnel route dns dmz-server pihole.example.com
```

### 6. .env を設定

```bash
CLOUDFLARE_TUNNEL_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
CLOUDFLARE_DOMAIN=example.com
```

### 7. 起動

```bash
docker compose up -d cloudflared
```

## アクセス

設定後、`https://pihole.example.com/admin` で Pi-hole 管理画面にアクセスできる。

## 追加サービスの公開

`config.yml` の `ingress` に追記する:

```yaml
ingress:
  - hostname: pihole.example.com
    service: http://pihole:80

  # 追加例: Portainer
  - hostname: portainer.example.com
    service: https://portainer:9443
    originRequest:
      noTLSVerify: true

  - service: http_status:404
```
