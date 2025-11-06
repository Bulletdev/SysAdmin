# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    # Render sempre a página inicial, mesmo autenticado
    # Usuários podem acessar o dashboard/admin pelos links de navegação
  end
end