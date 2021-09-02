require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "should not save url without full" do
    url = Url.new
    assert_not url.save
  end

  test "should save url wit full" do
    url = Url.new(:full => 'https://guides.rubyonrails.org/testing.html')
    assert url.save
  end

  test "should not save url with invalid full" do
    url = Url.new(:full => '00')
    assert_not url.save
  end
end
