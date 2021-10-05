class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  
  def  new
    @user = User.new
  end

  def edit
  end
  
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        # flash[:notice] = "Welcome to Alpha Blog"
        format.html {redirect_to articles_path, notice: "User #{@user.username} was successfully created"}
        #format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to articles_path, notice: "User was successfully updated." }
        #format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        #format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end


end