require 'rails_helper'

describe 'product page navigation', type: :feature do
  describe 'Product Creation' do
    context 'when user input is valid' do
      before do
        visit '/products'
        click_link 'New product'
        fill_in 'Title', with: 'Shirt'
        fill_in 'Description', with: 'This is a good shirt'
        fill_in 'Image url', with: 'http://test.com/whatever.jpg'
        fill_in 'Price', with: '200'
        click_button 'Create Product'
      end

      it 'creates a product' do
        expect(page).to have_content 'Product was successfully created.'
      end
    end

    context 'when user input is invalid' do
      before do
        visit '/products'
        click_link 'New product'
      end

      context 'when the form is blank' do
        before do
          fill_in 'Title', with: 'Shirt'
          fill_in 'Description', with: 'This is a good shirt'
          fill_in 'Image url', with: 'http://test.com/whatever.jpg'
          fill_in 'Price', with: '200'
        end
        context 'when all fields are completely blank' do
          before do
            fill_in 'Title', with: ''
            fill_in 'Description', with: ''
            fill_in 'Image url', with: ''
            fill_in 'Price', with: ''
            click_button 'Create Product'
          end

          it 'returns an error for all fields' do
            expect(page).to have_content 'Title can\'t be blank'
            expect(page).to have_content 'Description can\'t be blank'
            expect(page).to have_content 'Image url can\'t be blank'
            expect(page).to have_content 'Price is not a number'
          end
        end

        context 'when Title is blank' do
          before do
            fill_in 'Title', with: ''
            click_button 'Create Product'
          end
          it 'returns an error for Title' do
            expect(page).to have_content 'Title can\'t be blank'
          end

          it 'will not return an error for other fields' do
            expect(page).not_to have_content 'Description can\'t be blank'
            expect(page).not_to have_content 'Image url can\'t be blank'
            expect(page).not_to have_content 'Price is not a number'
          end
        end

        context 'when Description is blank' do
          before do
            fill_in 'Description', with: ''
            click_button 'Create Product'
          end

          it 'returns an error for Description' do
            expect(page).to have_content 'Description can\'t be blank'
          end

          it 'will not return an error for other fields' do
            expect(page).not_to have_content 'Title can\'t be blank'
            expect(page).not_to have_content 'Image url can\'t be blank'
            expect(page).not_to have_content 'Price is not a number'
          end
        end

        context 'when Image url is blank' do
          before do
            fill_in 'Image url', with: ''
            click_button 'Create Product'
          end

          it 'returns an error for Image url' do
            expect(page).to have_content 'Image url can\'t be blank'
          end

          it 'will not return an error for other fields' do
            expect(page).not_to have_content 'Title can\'t be blank'
            expect(page).not_to have_content 'Description can\'t be blank'
            expect(page).not_to have_content 'Price is not a number'
          end
        end

        context 'when price is blank' do
          before do
            fill_in 'Price', with: ''
            click_button 'Create Product'
          end

          it 'returns an error for price' do
            expect(page).to have_content 'Price is not a number'
          end

          it 'will not return an error for other fields' do
            expect(page).not_to have_content 'Title can\'t be blank'
            expect(page).not_to have_content 'Description can\'t be blank'
            expect(page).not_to have_content 'Image url can\'t be blank'
          end
        end
      end

      context 'when form is not blank but has some invalid fields' do
        before do
          fill_in 'Title', with: 'Shirt'
          fill_in 'Description', with: 'This is a good shirt'
          fill_in 'Image url', with: 'http://test.com/whatever.jpg'
          fill_in 'Price', with: '200'
        end

        context 'when title has a duplicate' do
          it 'returns an error for title duplicate'
        end

        context 'when Image url is not valid' do
          before do
            fill_in 'Image url', with: 'http://test.com/whatever'
            click_button 'Create Product'
          end

          it 'returns an error for Image url validity' do
            expect(page).to have_content 'Image url must be a URL for GIF, JPG or PNG image'
          end
        end

        context 'when price is not valid' do
          before do
            fill_in 'Price', with: '0.0'
            click_button 'Create Product'
          end

          it 'returns an error for price invalid' do
            expect(page).to have_content 'Price must be greater than or equal to 0.01'
          end

          it 'will not return an error for other fields' do
            expect(page).not_to have_content 'Title can\'t be blank'
            expect(page).not_to have_content 'Description can\'t be blank'
            expect(page).not_to have_content 'Image url can\'t be blank'
          end
        end
      end

    end

  end
end
