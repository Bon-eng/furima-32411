class OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:index, :create]
  before_action :find_item, only: [:index, :create]

  def index
    @user_destination = UserDestination.new
    if current_user == @item.user || @item.purchase != nil   #出品者が自分の商品ページの購入URLにダイレクトに飛ぼうとするとトップページにリダイレクトさせる↪️
      redirect_to root_path                                  #売り切れている商品ページの購入URLにダイレクトに飛ぼうとするとトップページにリダイレクト（商品に紐ついている注文テーブルidが存在している場合という意味
    end                                                      #「||」を使い条件式①または②のときに処理をすると記述し、リダイレクトへの繰り返しを避ける
  end

  def create
    @user_destination = UserDestination.new(destination_params)
      if @user_destination.valid?                 #バリデーションを正常に通過したら決済処理を行う
        pay_item                                  #可読性向上のためprivateメソッドでpay_itemを定義
        @user_destination.save
        redirect_to root_path
      else
        render action: :index
      end
  end

  private

  def destination_params
    params.require(:user_destination).permit(
      :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :purchaser_id, :token)
      .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])   #paramsにtokenを追加してデータ保存可能にしていなかったのでエラーになってた
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]            #テスト秘密鍵から環境変数へ変更済
    Payjp::Charge.create(                              #Gem提供のクラスとインスタンスメソッド
      amount: @item.price,                             # 商品の値段
      card: destination_params[:token],                # カードトークン
      currency: 'jpy'                                  # 通貨の種類（日本円）
    )
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

end
