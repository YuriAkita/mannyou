FactoryBot.define do
  factory :user do
    id { "100" }
    name { "test1" }
    email { "test1@email.com" }
    password { "test123" }
    password_confirmation { "test123" }
    admin { "false" }
  end

  factory :second_user, class: User do
    name { "admin_user" }
    email { "admin_user@mail.com" }
    password { "9999999" }
    admin { "true" }
  end
end
