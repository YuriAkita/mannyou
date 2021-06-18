### 開発環境
ruby '3.0.1'
rails (6.1.3.2)
webpacker (~> 5.0)

| tasks           |
| --------------- |
| id              |
| task_labels_id  |
| users_id        |
| title:string    |
| content:text    |
| status:integer   |
| task_deadline:date   |
| priority:integer |

| task_lebels           |
| --------------------- |
| id                    |
| label_category:string |

| users                  |
| ---------------------- |
| id                     |
| name:string            |
| email:string           |
| password_dijest:string |

### herokuへのログイン
```
% heroku rogin
```
### herokuへのデプロイ
```
heroku create
rails assets:precompile RAILS_ENV=production
bundle lock --add-platform x86_64-linux
git add .
git commit -m "comment"
heroku buildpacks:set heroku/ruby #buildパックの追加
heroku buildpacks:add --index 1 heroku/nodejs #buildパックの追加
git push heroku [branchname]:master
```
###  herokuサイトへ遷移
```
heroku open
```
