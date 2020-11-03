require 'oystercard'

describe Oystercard do
  let(:station){ double :station }
  let(:another_station){ double :station }

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

# no longer needed
  #describe '#deduct' do
  #   it 'responds with 1 argument' do
  #     expect(subject).to respond_to(:deduct).with(1).argument
  #   end
  #
  #   it 'deducts money from the card' do
  #     subject.top_up(2)
  #     expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
  #   end
  # end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
    it 'can touch in' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end
    it 'can touch out' do
      subject.top_up(5) # adding value so no error raised. see line 54
      subject.touch_in(station) #making in journey = true
      subject.touch_out(another_station) #making in journey = false
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'raises an error if less than 1' do
      expect { subject.touch_in station}.to raise_error 'Insufficent Funds'
    end

    describe '#charging for journey' do
      it 'on touch out the user is charged the minimum fair' do
        subject.top_up(5)
        subject.touch_in(station)
        expect { subject.touch_out(another_station) }.to change{ subject.balance }.by -Oystercard::MINIMUM_FARE
      end
    end
  describe '#entry staion' do

    it 'stores the entry station' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end
  describe '#journey history' do
    it 'initializes an empty array' do
      expect(subject.journey_history).to eq []
    end
    it 'remember entry station' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.journey_history[0][:start]).to eq station
    end
    it 'remember exit station' do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(another_station)
      expect(subject.journey_history[0][:finish]).to eq another_station
    end
  end
end
end
