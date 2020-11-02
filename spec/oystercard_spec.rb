require 'oystercard'

describe Oystercard do

  it 'it has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'responds with 1 argument' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
    it 'adds money to the card' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up 1 }.to raise_error 'Top up limit reached'
    end
  end

  describe '#deduct' do
    it 'responds with 1 argument' do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it 'deducts money from the card' do
      subject.top_up(2)
      expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
    end
  end
end
