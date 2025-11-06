# frozen_string_literal: true

module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @total_users = User.count
      @users_by_role = User.group(:role).count
      # Séries básicas para gráfico de crescimento (placeholder com último ponto = total)
      @user_growth_labels = %w[Jun Jul Ago Set Out Nov]
      @user_growth_series = [12, 19, 15, 25, 22, @total_users]

      # Distribuições dinâmicas por função e setor
      @users_by_job_role = User.group(:job_role).count
      @users_by_department = User.group(:department).count

      # Proxy simples de atividade (usuarios atualizados/criados nas últimas 24h)
      @active_today = User.where('updated_at >= ?', 1.day.ago).count
    end

    private

    def require_admin
      return if current_user.admin?

      redirect_to root_path, alert: 'Access denied. Admin privileges required.'
    end
  end
end