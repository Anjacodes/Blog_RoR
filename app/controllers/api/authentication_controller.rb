module Api
  class AuthenticationController < ApplicationController
    skip_before_action :verify_authenticity_token

    def login
      user = User.find_by(email: params[:email]).valid_password?(params[:password])
      if user
        @user = User.find_by(email: params[:email])
        @user.api_token = "#{@user.name}Ik6QfJgeQdtJ_KhGO5HrlxxA#{@user.id}%3A1649383515930"
        @user.save
        respond_to do |format|
          format.json { render json: @user.api_token, status: :ok }
        end
      else
        respond_to do |format|
          format.json { render json: 'Wrong email or password'.to_json, status: :ok }
        end
      end
    end

    def register
      new_user = User.new(name: params[:name], email: params[:email], password: params[:password])
      if new_user.save
        render json: { success: true, message: 'User created', data: { user: new_user } }, status: :created
      else
        render json: { success: false, errors: new_user.errors }, status: :unprocessable_entity
      end
    end
  end
end
