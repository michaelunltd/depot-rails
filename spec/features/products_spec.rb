require 'rails_helper'

describe 'product page navigation', type: :feature do
  describe 'Product Creation' do
    it 'creates a product' do
      visit '/products'
      click_link 'New product'
      fill_in 'Title', with: 'Shirt'
      fill_in 'Description', with: 'This is a good shirt'
      fill_in 'Image url', with: 'http://test.com/whatever.jpg'
      fill_in 'Price', with: '200'
      click_button 'Create Product'
      expect(page).to have_content 'Product was successfully created.'
    end
  end
end
