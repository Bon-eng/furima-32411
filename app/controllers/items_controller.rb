class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :find_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path unless current_user.id == @item.user_id
  end

  #updateができたらroot_pathにredirect
  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  #destroyができたらroot_pathにredirect
  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  # itemsテーブルとusersテーブルを結び付けないと保存ができないのでmergeを使う。二時間ハマったで？？
  def item_params
    params.require(:item).permit(
      :image, :name, :introduction, :price, :category_id, :status_id,
      :postage_id, :prefecture_id, :days_to_ship_id
    ).merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

end
