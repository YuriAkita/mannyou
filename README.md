| tasks           |
| --------------- |
| id              |
| task_labels_id  |
| users_id        |
| title:string    |
| content:text    |
| status:string   |
| task_deadline   |
| priority:string |

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
| profile_image:text     |

デプロイ方法
heroku rogin
heroku create
bundle lock --add-platform x86_64-linux
git add .
git commit -m "comment"
git push heroku step2:master
heroku open
