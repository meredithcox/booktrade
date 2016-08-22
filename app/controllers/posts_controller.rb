class PostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    
    
    def new
        @post = current_user.posts.build if logged_in?
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
          redirect_to @post
        else
          render 'edit'
        end
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        
        redirect_to posts_path
    end
    
    def index
        @posts = Post.all
        @user = current_user
        if params[:search]
            @posts = Post.search(params[:search]).order("created_at DESC")
        else
            @posts = Post.all.order("created_at DESC")
        end
    end
    
    def create
        @post = current_user.posts.build(post_params)
    
        if @post.save
          redirect_to @post
        else
          render 'new'
        end
    end
    
    def show
        @post = Post.find(params[:id])
    end
    

  private
  
  def post_params
    params[:post].permit(:id,:title,:author,:isbn,:subject,:description,:email)
  end
end
