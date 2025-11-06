# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'john@example.com' }
    password { 'password' }
    encrypted_password { 'encrypted_password' }
    full_name { 'John Doe' }
    role { :no_admin }
  end
end
