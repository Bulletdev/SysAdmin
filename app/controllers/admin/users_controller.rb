# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_user, only: %i[show edit update destroy toggle_role]

    def index
      per_page = 20
      page = params[:page].to_i
      page = 1 if page < 1
      @users = User.order(created_at: :desc).offset((page - 1) * per_page).limit(per_page)
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_user_path(@user), notice: 'User was successfully created.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully deleted.'
    end

    def toggle_role
      # Ensure a valid role before toggling
      @user.role = 'no_admin' if @user.role.blank?
      @user.role = @user.admin? ? 'no_admin' : 'admin'
      @user.save!
      redirect_to admin_users_path, notice: "User role updated to #{@user.role}."
    end

    def import
      # Import functionality will be implemented here
      redirect_to admin_users_path, notice: 'Import functionality coming soon!'
    end

    def import_progress
      # Real-time import progress will be implemented here
      render json: { progress: 0, status: 'not_started' }
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :avatar_image, :role,
                                   :job_role, :department)
    end

    def require_admin
      return if current_user.admin?

      redirect_to root_path, alert: 'Access denied. Admin privileges required.'
    end
  end
end