# frozen_string_literal: true

Fabricator(:user) do
  email { FFaker::Internet.email }
  password { 'testtest' }
  password_confirmation { 'testtest' }
end
