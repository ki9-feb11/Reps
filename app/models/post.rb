class Post < ApplicationRecord
  belongs_to :user
  belongs_to :customer

  # 投稿ステータス
  enum status: {
    progress: 0, #進行中
    completed: 1, #完了
    canceled: 2 #キャンセル
  }

  # 商談結果
  enum result_status: {
    progress: 0, #商談中
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

end
