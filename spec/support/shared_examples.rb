# frozen_string_literal: true

RSpec.shared_examples 'serializable' do |clazz, obj, source, same, different, str|
  describe '#serialize' do
    it 'serialize self to string' do
      expect(obj.serialize).to eq(source.chomp)
    end
  end

  describe '::deserialize' do
    it 'deserialize source to object' do
      expect(clazz.deserialize(source)).to eq(obj)
    end
  end

  describe '#==' do
    it 'return true only when all props are equal' do
      if same.is_a? Array
        same.each do |other|
          expect(obj).to eq(other)
        end
      else
        expect(obj).to eq(same)
      end
    end

    it 'not equals to other problem at least one props mismatch' do
      if different.is_a? Array
        different.each do |other|
          expect(obj).not_to eq(other)
        end
      else
        expect(obj).not_to eq(different)
      end
    end
  end

  describe '#to_s' do
    it 'turns obj to string' do
      expect(obj.to_s).to eq(str)
    end
  end
end
