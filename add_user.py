from app import create_app, db
from app import User

app = create_app()
with app.app_context():
    db.create_all()

    # 新しいユーザーの追加
    username = 'testuser'
    password = 'password123'
    if User.query.filter_by(username=username).first() is None:
        user = User(username=username)
        user.set_password(password)
        db.session.add(user)
        db.session.commit()
        print(f'User {username} added.')
    else:
        print(f'User {username} already exists.')
