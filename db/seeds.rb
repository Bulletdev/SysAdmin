# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create or update sample admin user (idempotent)
admin_user = User.find_or_initialize_by(email: 'admin@example.com')
admin_user.assign_attributes(
  full_name: 'Admin User',
  password: 'password123',
  password_confirmation: 'password123',
  role: 'admin',
  job_role: 'Head de TI',
  department: 'Tecnologia'
)
admin_user.save!

# Create sample regular users
job_roles = ['Analista', 'Desenvolvedor', 'Product Manager', 'Designer', 'Suporte']
departments = %w[Tecnologia Produto Operações Marketing CX]

5.times do |i|
  email = "user#{i + 1}@example.com"
  user = User.find_or_initialize_by(email: email)
  user.assign_attributes(
    full_name: "User #{i + 1}",
    password: 'password123',
    password_confirmation: 'password123',
    role: 'no_admin',
    job_role: job_roles[i % job_roles.length],
    department: departments[i % departments.length]
  )
  user.save!
end

puts 'Seeded database with:'
puts '- Admin user: admin@example.com (password: password123)'
puts '- 5 regular users: user1@example.com through user5@example.com (password: password123)'
