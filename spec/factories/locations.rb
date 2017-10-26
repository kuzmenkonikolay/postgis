FactoryBot.define do
  factory :location do |f|
    f.name 'Test'
    f.area 'POLYGON((-121 47, -120 45, -122 43, -121 47))'
  end
end