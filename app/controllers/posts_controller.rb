class PostsController < ApplicationController
  before_action :authenticate_user
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def room
    @post = Post.find_by(room_number: params[:id])
  end
  
  def show
    @post = Post.find_by(id: params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(
      room_number: params[:room_number],
      matches: "0",
      name_a: params[:name_a],
    )
    if @post.save
      flash[:notice] = "ルームを作成しました"
      redirect_to("/room/#{@post.room_number}")
    else
      render("posts/new")
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end
  
end
