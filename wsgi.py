import os
from app import create_app

app = create_app()

if __name__ == '__main__':
    # 環境変数 PORT が設定されている場合、それを使用
    port = int(os.environ.get('PORT', 8000))
    app.run(host='0.0.0.0', port=port)
