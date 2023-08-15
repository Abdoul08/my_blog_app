FactoryBot.define do
  factory :article do
    user
    categorie
    title { "Titre" }
    content { "Contenu" }
    after :create do |article|
      article.image.attach(io: File.open(Rails.root.join("spec/fixtures/acteur.png")), filename: "acteur.png")
    end
    
  end
end
