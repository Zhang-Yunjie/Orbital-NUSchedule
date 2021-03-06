class UserModsController < ApplicationController
    def new
      @user_mods = User_mods.new
    end

    def create
      @user_mod = UserMod.new(user_mod_params)
      if @user_mod.save
        flash[:success] = "Module #{@user_mod.mod.module_code} was successfully added to your modules."
      else
	flash[:danger] = @user_mod.errors.full_messages.first
      end
      redirect_to mod_path(id: params[:user_mod][:mod_id])
    end

    def index
      @user_mods = UserMod.all.order("created_at DESC")
    end

    def show
        @user_mod = UserMod.find(params[:id])
    end

    def destroy
      mod = Mod.find(params[:id])
      semester = Semester.find(params[:id])
      @user_mod = UserMod.where(user_id: current_user.id, mod_id: mod.id, semester_id: semester.id).first
      @user_mod.destroy
      flash[:notice] = "Module was successfully deleted from this semester."
      redirect_to mod_path(id: params[:user_mod][:mod_id])
    end

    private
    def user_mod_params
      params.require(:user_mod).permit(:user_id, :mod_id, :semester_id)
    end
end
