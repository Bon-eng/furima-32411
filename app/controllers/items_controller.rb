class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new

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

  private

  # itemsテーブルとusersテーブルを結び付けないと保存ができないのでmergeを使う。二時間ハマったで？？
  def item_params
    params.require(:item).permit(
      :image, :name, :introduction, :price, :category_id, :status_id,
      :postage_id, :prefecture_id, :days_to_ship_id
    ).merge(user_id: current_user.id)
  end
end
