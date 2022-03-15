# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_role = Role.create(name: 'admin', description: 'System Admin')
user_role = Role.create(name: 'user', description: 'User')
admin = User.create(email: "admin_user@mail.com", password: "password", password_confirmation: "password")

admin.user_roles.create(role_id: admin_role.id)
