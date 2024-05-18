#!/bin/bash

# 環境変数の設定
export FLASK_ENV=development
export FLASK_APP=wsgi.py

# データベースの初期化
poetry run flask db init
# マイグレーションファイルの作成
poetry run flask db migrate -m "Initial migration."
# マイグレーションの適用
poetry run flask db upgrade

# Flask開発サーバーの起動
poetry run flask run --host=0.0.0.0 --port=8000