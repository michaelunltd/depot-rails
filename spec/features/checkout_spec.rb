require 'rails_helper'

describe 'Checkout Process', type: :feature do
  describe 'Cart Page' do
    context 'when there is one product in the store' do
      let!(:product) { FactoryGirl.create(:product, title: 'TicketBase generic ticket') }

      before do
        visit '/'
        click_button 'Add to Cart'
      end

      it 'diplays the product in the cart' do
        expect(page).to have_content 'TicketBase generic ticket'
      end

      it 'displays the quantity of the product' do
        expect(page).to have_content '1 ×'
      end

      it 'displays the total of the cart' do
        expect(page).to have_content 'Total P 5.00'
      end

      context 'and the user presses the Empty Cart button' do
        before do
          click_button 'Empty Cart'
          page.driver.accept_js_confirms!
        end

        it 'empties the cart', js: true do
          expect(page).to have_content 'Your cart is currently empty'
        end
      end
    end

    context 'when there are multiple products in the store' do
      let!(:product) { FactoryGirl.create(:product, title: 'TicketBase generic ticket') }
      let!(:product2) { FactoryGirl.create(:product, title: 'TicketBase unique ticket') }

      before do
        visit '/'
        find_button(id: "product#{product2.id}").click
      end

      it 'displays the products in the cart' do
        expect(page).to have_content 'TicketBase unique ticket'
      end
    end
  end

  describe 'Checkout Page' do
    let!(:product) { FactoryGirl.create(:product, title: 'Shirt')}

    context 'when user has no line items' do
      before do
        visit "/orders/new"
      end

      it 'redirects to the home page' do
        expect(page).to have_content 'Your cart is empty'
      end
    end

    context 'when user has line items' do
      before do
        visit '/'
        click_button 'Add to Cart'
        click_button 'Checkout'
        fill_in 'Name', with: 'Test User'
        fill_in 'Address', with: 'Test Address'
        fill_in 'Email', with: 'test@example.com'
        select 'Purchase Order', from: 'Pay type'
        click_button 'Place Order'
      end

      it 'places an order' do
        expect(page).to have_content 'Thank you for your order'
      end

      it 'sends an email' do
        expect(OrderMailer).to receive(:received)
      end
    end
  end
end
