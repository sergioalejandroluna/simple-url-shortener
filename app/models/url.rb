class Url < ApplicationRecord
  validates :full, :format => { :with => URI::regexp(%w(http https)), :message => "Valid URL required"}
  validates_presence_of :full
  has_many :visits

  def shorted(url)
    "#{url}" "/" "#{token}"
  end
end
