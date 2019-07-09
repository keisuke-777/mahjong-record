class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  # before_action :forbid_login_user, {only: [:signup, :create, :login_form, :login]}
  # 投稿したユーザと同じユーザのみ編集可能
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def index
    if @current_user.name == "MasterUserCanEdit"
      @users = User.all
    else
      redirect_to("/")
    end
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def signup
    @user = User.new
  end
  
  def create
    @user = User.new(
      name: params[:name],
      password: params[:password],
      rate: "0",
      winning: "0",
      matches: "0",
      total_score: "0",
      money: "0"
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("signup")
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def login_form
  end
  
  def login
    @user = User.find_by(name: params[:name], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/new")
    else
      @error_message = "ユーザー名またはパスワードが間違っています"
      @name = params[:name]
      @password = params[:password]
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  def finish
    @post = Post.find_by(room_number: params[:room_number])
    @post.finish = true
    if @post.save
      @user = User.find_by(name: @current_user.name)
      @user.winning += params[:win].to_i
      @user.total_score += params[:sum].to_i
      @user.matches += params[:matches].to_i
      @user.money += (params[:sum].to_i*params[:rate].to_i*100).to_i
      if @user.save
        flash[:notice] = "結果を記録し対局を終了しました"
        redirect_to("/users/#{@user.id}")
      else
        flash[:notice] = "記録の保存に失敗しました"
        redirect_to("/room/#{params[:room_number]}")
      end
    else
      flash[:notice] = "保存に失敗しました"
      redirect_to("/room/#{params[:room_number]}")
    end
  end
  
end
