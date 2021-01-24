class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_index, except: [:index, :show]
  before_action :ensure_current_user, {only: [:edit, :update]}


  def index
    @prototypes = Prototype.includes(:user)
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def new
    @prototypes =  Prototype.new
  end

  def create
    @prototypes =  Prototype.new(prototype_params)
    if @prototypes.save
      redirect_to prototypes_path
    else
      render :new
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
    
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to prototypes_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def ensure_current_user
    @prototype = Prototype.find_by(id: params[:id])
    if @prototype.user.id != @current_user.id
      redirect_to root_path
    end
  end
end
