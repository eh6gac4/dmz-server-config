# DMZ Server Config

自宅 DMZ サーバーの構成管理リポジトリ。

## 構成

| サービス | 用途 | ポート |
|---------|------|--------|
| [Portainer](./portainer/README.md) | Docker コンテナ管理 Web UI | 9000, 9443 |
| [Cloudflared](./cloudflared/README.md) | Cloudflare Tunnel（外部公開） | - |
| [Pi-hole](./pihole/README.md) | DNS 広告ブロック | 53, 8080 |
| [WireGuard](./wireguard/README.md) | VPN サーバー | 51820/UDP |

## セットアップ

### 1. 環境変数の設定

```bash
cp .env.example .env
vi .env  # 各値を設定する
```

### 2. 起動

```bash
docker compose up -d
```

### 3. 初回設定

- **Portainer**: http://\<server-ip\>:9000 にアクセスして管理者アカウントを作成
- **Cloudflared**: [cloudflared/README.md](./cloudflared/README.md) を参照してトンネルを設定
- **Pi-hole**: http://\<server-ip\>:8080/admin にアクセス
- **WireGuard**: `docker exec wireguard /app/show-peer peer1` でクライアント設定を取得

## 運用

```bash
# 状態確認
./scripts/status.sh

# イメージ更新
./scripts/update.sh

# ログ確認
docker compose logs -f [サービス名]

# 停止
docker compose down
```

## ディレクトリ構成

```
.
├── docker-compose.yml      # メインの Compose ファイル
├── .env.example            # 環境変数テンプレート
├── .env                    # 環境変数（gitignore 対象）
├── cloudflared/
│   └── README.md
├── pihole/
│   ├── etc-pihole/         # Pi-hole データ（gitignore 対象）
│   ├── etc-dnsmasq.d/      # DNS 追加設定
│   └── README.md
├── portainer/
│   └── README.md
├── wireguard/
│   ├── config/             # WireGuard 設定・鍵（gitignore 対象）
│   └── README.md
└── scripts/
    ├── status.sh           # 状態確認
    └── update.sh           # イメージ更新
```
