# Pi-hole

DNS ベースの広告・トラッカーブロッカー。

## アクセス

- 管理画面: http://\<server-ip\>:8080/admin

## データディレクトリ

| パス | 用途 |
|------|------|
| `etc-pihole/` | Pi-hole の設定・データベース（.gitignore 対象） |
| `etc-dnsmasq.d/` | DNS 追加設定 |

## バックアップ

```bash
# 設定のエクスポート（管理画面から）
# Settings > Teleporter > Backup
```
