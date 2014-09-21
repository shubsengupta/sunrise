class User < ActiveRecord::Base
  # id, username, next_alarm, created_at, updated_at

  scope :available, -> { where('next_alarm > ?', DateTime.now) }
end
