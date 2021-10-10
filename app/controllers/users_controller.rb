class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index 
    #@users = User.all
    @users = User.paginate(page: params[:page], per_page: 3)
  end 

  def  new
    @user = User.new
  end

  def edit
  end

  def show
    @articles = @user.articles
  end
  
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        # flash[:notice] = "Welcome to Alpha Blog"
        format.html {redirect_to @user, notice: "User #{@user.username} was successfully created"}
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
        format.html { redirect_to @user, notice: "User was successfully updated." }
        #format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        #format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path , notice: "Account and all associated articles successfully deleted"
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

    def require_same_user
      if current_user != @user
        redirect_to @user, notice: "You can edit only your own account"
      end
    end


end