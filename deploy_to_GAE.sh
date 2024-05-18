#!/bin/bash

# 必要な引数の確認
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <project-id> <expected-status-code>"
    exit 1
fi

# 引数からプロジェクトIDと期待されるステータスコードを設定
PROJECT_ID=$1
EXPECTED_STATUS_CODE=$2 # 200 for http

# Poetry環境を初期化
echo "Initializing Poetry environment..."
poetry install

# requirements.txtを生成
echo "Exporting requirements to requirements.txt..."
poetry export -f requirements.txt --output requirements.txt --without-hashes

# ローカル環境でのテスト
echo "Testing application locally..."
poetry run python wsgi.py &

# 少し待ってアプリケーションが起動するのを待つ
sleep 5

# ローカルでのテスト結果を確認
ACTUAL_STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000)

if [ "$ACTUAL_STATUS_CODE" -eq "$EXPECTED_STATUS_CODE" ]; then
  echo "Local test passed with status code $ACTUAL_STATUS_CODE."
else
  echo "Local test failed. Expected status code $EXPECTED_STATUS_CODE but got $ACTUAL_STATUS_CODE. Stopping the script."
  kill $GUNICORN_PID
  exit 1
fi

# Gunicornプロセスを終了
kill $GUNICORN_PID

# Google App Engineにデプロイ
echo "Deploying to Google App Engine..."
gcloud app deploy --project=$PROJECT_ID

echo "Deployment completed."
