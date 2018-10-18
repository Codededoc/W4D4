# == Schema Information
#
# Table name: bands
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Band < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  belongs_to :users,
    primary_key: :id,
    foreign_key: :user_id, 
    class_name:  :User

end
