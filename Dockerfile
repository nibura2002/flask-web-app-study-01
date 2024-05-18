# ベースイメージ
FROM python:3.11-slim

# 作業ディレクトリの設定
WORKDIR /app

# Poetryのインストール
RUN pip install poetry

# プロジェクトファイルを作業ディレクトリにコピー
COPY pyproject.toml poetry.lock ./

# 依存関係のインストール
RUN poetry config virtualenvs.create false && poetry install --no-dev

# アプリケーションコードをコピー
COPY . .

# ポートの公開
EXPOSE 8000

# アプリケーションの実行
CMD ["poetry", "run", "flask", "run", "--host=0.0.0.0", "--port=8000"]
