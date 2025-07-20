class Post < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  has_many :post_products, dependent: :destroy
  has_many :products, through: :post_products

  accepts_nested_attributes_for :post_products, allow_destroy: true

  # 投稿ステータス
  enum status: {
    progressing: 0, #進行中
    completed: 1, #完了
    canceled: 2 #キャンセル
  }

  # 商談結果
  enum result_status: {
    negotiating: 0, #商談中
    ordered: 1, #受注
    lost: 2, #失注
    pending: 3, #保留
    postponed: 4, #延期
    aborted: 5, #中止
    no_response: 6 #反応なし
  }

  # 顧客の反応
  enum reaction: {
    very_positive: 0,
    positive: 1,
    neutral: 2,
    negative: 3,
    very_negative: 4
  }
  
  # 投稿ステータスの日本語表示化
  def status_i18n
    I18n.t("activerecord.attributes.post.statuses.#{status}")
  end
  
  # 商談結果の日本語表示化
  def result_status_i18n
    I18n.t("activerecord.attributes.post.result_statuses.#{result_status}")
  end
  
  # 顧客反応の日本語表示化
  def reaction_i18n
    I18n.t("activerecord.attributes.post.reactions.#{reaction}")
  end

end
