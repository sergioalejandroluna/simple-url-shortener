class Url < ApplicationRecord
  validates_presence_of :full
  has_many :visits

  def shorted(url)
    "#{url}" "/" "#{token}"
  end
end
