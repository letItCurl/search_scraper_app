class MissionControlController < ApplicationController
  if Rails.application.credentials.mission_control
    http_basic_authenticate_with(
      name: Rails.application.credentials.mission_control[:username],
      password: Rails.application.credentials.mission_control[:password]
    )
  end
end