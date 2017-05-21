module ApplicationHelper
  def favorite_text(item)
    item['favorite'] ? 'Unfavorite' : 'Favorite'
  end

  def display_address(address)
    yield address
  end
end
