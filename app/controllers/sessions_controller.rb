class SessionsController < ApplicationController
  # GET /users/new
  def new
    @session = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @session = User.new(user_params)
    user = User.find_by_email(user_params[:email])
    respond_to do |format|
      if user&.authenticate(user_params[:password])
        reset_session
        session[:user_id] = user.id
        format.html { redirect_to root_path, notice: 'User successfully logged in.' }
        format.json { render :show, status: :created, location: root_path }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    reset_session
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User successfully logged out.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
