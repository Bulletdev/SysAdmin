# frozen_string_literal: true

class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Your account has been successfully deleted.'
  end

  private

  def set_user
    @user = current_user
  end

  def authorize_user
    return if current_user == @user || current_user.admin?

    redirect_to root_path, alert: 'You can only edit your own profile.'
  end

  def user_params
    if current_user.admin?
      params.require(:user).permit(:full_name, :email, :avatar_image, :role, :job_role, :department)
    else
      params.require(:user).permit(:full_name, :email, :avatar_image)
    end
  end
end