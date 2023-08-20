

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

# Générer des articles avec des images
5.times do
  article = Article.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraphs.join("\n\n"),
    categorie_id: categorie_ids.sample,
    user_id: random_user_id
  )
  
  # Utilise Rack::Test::UploadedFile pour créer un objet téléchargé
  image_path = Rails.root.join('app', 'assets', 'images', 'acteur.png')
  article.image.attach(io: File.open(image_path), filename: 'acteur.png', content_type: 'image/png')

  # Générer des favoris pour chaque article
  rand(1..3).times do
    Favori.create!(
      user: User.where(admin: 'false').sample,
      article: article
    )
  end
end
