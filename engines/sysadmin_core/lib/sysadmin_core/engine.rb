# frozen_string_literal: true

require 'rails/engine'

module SysadminCore
  class Engine < ::Rails::Engine
    isolate_namespace SysadminCore
  end
end
