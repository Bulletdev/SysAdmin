# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true,
                    uniqueness: true,
                    length: { maximum: 255 }

  validates :password, presence: true, length: { minimum: 6 }, if: :new_record?
  validates :full_name, presence: true
  validates :role, presence: true

  enum role: { no_admin: 'no_admin', admin: 'admin' }

  before_validation :set_default_role, on: :create
  before_validation :set_default_job_role, on: :create

  private

  def set_default_role
    self.role ||= 'no_admin'
  end

  def set_default_job_role
    self.job_role ||= 'Visitante'
  end
end
