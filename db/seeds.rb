

# Générer des catégories
categories = []
5.times do
  categories << Categorie.create!(name: Faker::Book.genre)
  
end
categorie_ids = categories.pluck(:id)

# Générer des utilisateurs
5.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password' ,
    password_confirmation: 'password' ,
    admin: false
  )
end
# Obtenez un utilisateur au hasard
random_user = User.all.sample

# Obtenez l'identifiant de l'utilisateur au hasard
random_user_id = random_user.id


# Admin

admin = User.create!(
  name: 'Admin User',
  email: 'admin2@example.com',
  password: 'password' ,
  password_confirmation: 'password', # À remplacer par un vrai mot de passe
  admin: true
)

