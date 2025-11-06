# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }

  describe 'defaults' do
    it 'sets job_role to Visitante on create when not provided' do
      u = User.create!(email: 'visitante@example.com', password: 'password123', full_name: 'Visitante')
      expect(u.job_role).to eq('Visitante')
    end

    it 'sets role to no_admin on create when not provided' do
      u = User.create!(email: 'role.default@example.com', password: 'password123', full_name: 'Role Default')
      expect(u.role).to eq('no_admin')
    end
  end
end
