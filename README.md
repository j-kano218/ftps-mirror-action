# ftps-mirror-action

このアクションは、GitHub Actions で生成した静的ページなどを FTP over TLS でレンタルサーバーなどにアップロードします。

lftp で FTP over TLS を使いつつ並列アップロードできるアクションが欲しかったので作成しました。

FTP サーバー側で海外からの FTP 接続を遮断している場合は使用できません。

現在、スターサーバーの有料プランでのみ動作を確認しています。

## 入力

| キー | 必須 | デフォルト | 説明 |
| :--- | :---: | :---: | :--- |
| host | * | なし | FTP ホスト |
| username | * | なし | FTP アカウントのユーザー名 |
| password | * | なし | FTP アカウントのパスワード |
| port | | 21 | FTP ホストのポート番号 |
| debug | | false | lftp に -d オプションを付けて実行するか |
| check | | true | true なら set ssl:check-hostname yes |
| local | | . | アップロードするフォルダ。Nuxt.js なら dist |
| remote | | . | アップロード先のフォルダ。public_html とか |
| options | | | lftp mirror コマンドに渡すオプション。<br>-R は実行ファイル側で付けているので不要です。<br>--parallel=n で並列アップロードができます。|

## 使用例

```
jobs:
  deploy:
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - uses: actions/checkout@master

      - uses: j-kano218/ftps-mirror-action@master
        with:
          host: ${{ secrets.FTP_HOST }}
          username: ${{ secrets.FTP_USERNAME }}
          password: ${{ secrets.FTP_PASSWORD }}
          local: dist
          options: --parallel=8
```

## 免責
このアクションを使うことで生じた損害等について、作者は何ら責任を負いません。
