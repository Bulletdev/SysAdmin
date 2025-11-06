# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserProfile', type: :request do
  let(:user) do
    User.create!(email: 'user.profile@example.com', password: 'password123', full_name: 'User Profile',
                 job_role: 'Analista', department: 'Tecnologia')
  end

  it 'shows cargo (job_role) and setor (department) on profile page' do
    sign_in user
    get user_profile_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include('Cargo:')
    expect(response.body).to include('Analista')
    expect(response.body).to include('Setor:')
    expect(response.body).to include('Tecnologia')
  end
end