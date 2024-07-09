admin = FactoryBot.create(:user, :admin, first_name: 'admin')
admin.password = 'admin'
admin.email = 'admin@admin.com'
admin.save(validate: false)

FactoryBot.create_list(:region, 20, :with_users)
