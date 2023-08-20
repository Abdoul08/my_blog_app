class Users::SessionsController < Devise::SessionsController
  def new_guest
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
      user.password = SecureRandom.hex(10)
      user.password_confirmation = user.password
      user.name = 'Guest User'
      user.admin = false
    end
    sign_in user
    redirect_to root_path, notice: "Connecté(e) en tant qu'utilisateur(trice) invité !"
  end

  def new_admin_guest
    user = User.find_or_create_by(email: 'admin_guest@example.com') do |user|
      user.password = SecureRandom.hex(10)
      user.password_confirmation = user.password
      user.name = 'Guest Admin'
      user.admin = true
    end
    sign_in user
    redirect_to root_path, notice: "Connecté(e) en tant qu'administrateur(trice) invitée!"
  end
end
