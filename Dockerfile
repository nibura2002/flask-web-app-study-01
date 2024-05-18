# ベースイメージを指定
FROM python:3.11-slim

# 作業ディレクトリを設定
WORKDIR /app

# Poetryをインストール
RUN pip install poetry

# Poetryの設定ファイルをコピー
COPY pyproject.toml poetry.lock* /app/

# 依存関係をインストール
RUN poetry install --no-root

# アプリケーションのソースコードをコピー
COPY . /app

# コンテナが起動する際に実行されるコマンドを設定
CMD ["poetry", "run", "python", "app.py"]
