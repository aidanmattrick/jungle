class AdminController < ApplicationController
  http_basic_authenticate_with(
    name: Rails.application.credentials.admin[:user],
    password: Rails.application.credentials.admin[:password]
  )
end
