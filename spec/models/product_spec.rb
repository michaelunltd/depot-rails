require 'rails_helper'

describe Product do
  describe 'validations' do
    context 'when title is blank' do
      let!(:product) { FactoryGirl.build(:product, title: '')}

      it 'it becomes invalid' do
        expect(product.valid?).to be false
      end

      it 'returns an error message' do
        product.save
        expect(product.errors.count).to eq 1
      end
    end

    context 'when title already exists' do
      let!(:product) { FactoryGirl.create(:product, title: 'Shirt') }
      let(:product2) { FactoryGirl.build(:product, title: 'Shirt') }

      it 'becomes invalid' do
        expect(product2.valid?).to be false
      end

      it 'returns an error message' do
        product2.save
        expect(product2.errors.count).to eq 1
      end
    end
    
  end
end
