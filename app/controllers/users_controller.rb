class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_required, except: %i[ show ]
    before_action :set_user, only: %i[ show edit update destroy ]

    def index
        @users = User.all
    end

    def show
        @user = current_user
    end

    def edit
    end
  
    def update
      if @user.update(user_params)
        redirect_to users_path, notice: "L'utilisateur a été modifier avec succès"
      else
        render :edit
      end
    end
  
    def destroy
      @user.destroy
      redirect_to users_path, notice: "L'utilisateur a été supprimé avec succès."
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def admin_required
        unless current_user&.admin?
            flash[:alert] = "Seul l'admin peut accéder à cette page"
            redirect_to root_path
        end
    end
end