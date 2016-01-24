require 'spec_helper'

describe Polarity do
	describe "#polarity_class" do
		it "returns 'positive' for POSITIVE" do
			expect(Polarity.polarity_class(POSITIVE)).to eql("positive")
		end
		it "returns 'negative' for NEGATIVE" do
			expect(Polarity.polarity_class(NEGATIVE)).to eql("negative")
		end
		it "returns 'neutral' if it isn't POSITIVE or NEGATIVE" do
			expect(Polarity.polarity_class(NEUTRAL)).to eql("neutral")
		end
	end
end
