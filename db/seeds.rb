region_names = [
  'Москва',
  'Санкт-Петербург',
  'Московская область',
  'Ленинградская область',
  'Калининградская область',
  'Ростовская область',
  'Воронежская область',
  'Волгоградская область',
  'Саратовская область',
  'Краснодарский край',
  'Ставропольский край',
  'Астраханская область',
  'Волгоградская область',
  'Рязанская область',
  'Тамбовская область',
  'Пензенская область',
  'Саратовская область',
  'Ульяновская область',
  'Самарская область',
  'Оренбургская область',
  'Башкортостан',
  'Татарстан',
  'Чувашия',
  'Мордовия',
  'Марий Эл',
  'Удмуртия',
  'Кировская область',
  'Нижегородская область',
  'Костромская область',
  'Ивановская область',
  'Владимирская область',
  'Ярославская область',
  'Тверская область',
  'Новгородская область',
  'Псковская область',
  'Смоленская область',
  'Брянская область',
  'Калужская область',
  'Тульская область',
  'Орловская область',
  'Липецкая область',
  'Тамбовская область',
  'Воронежская область',
  'Белгородская область',
  'Курская область',
  'Северная Осетия',
  'Чечня',
  'Ингушетия',
  'Дагестан',
  'Кабардино-Балкария',
  'Карачаево-Черкесия',
  'Адыгея',
  'Краснодарский край',
  'Ставропольский край',
  'Астраханская область',
  'Волгоградская область',
  'Ростовская область',
  'Кемеровская область',
  'Новосибирская область',
  'Омская область',
  'Томская область',
  'Тюменская область',
  'Ханты-Мансийский автономный округ',
  'Ямало-Ненецкий автономный округ',
  'Челябинская область',
  'Курганская область',
  'Свердловская область',
  'Тюменская область',
  'Хабаровский край',
  'Приморский край',
  'Амурская область',
  'Магаданская область',
  'Сахалинская область',
  'Еврейская автономная область',
  'Чукотский автономный округ',
  'Камчатский край',
  'Мурманская область',
  'Архангельская область',
  'Вологодская область',
  'Калининградская область',
  'Ленинградская область',
  'Московская область',
  'Новгородская область',
  'Псковская область',
  'Смоленская область',
  'Тверская область',
  'Ярославская область'
]

regions = region_names.map { |name| { name: } }
Region.upsert_all(regions)

admin = FactoryBot.create(:user, :admin, first_name: 'admin', email: 'admin@admin.com')
admin.password = 'admin'
admin.save(validate: false)

FactoryBot.create_list(:user, 40, :with_posts)
