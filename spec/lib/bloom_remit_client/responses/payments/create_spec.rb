require 'spec_helper'

module BloomRemitClient
  module Responses
    module Payments
      RSpec.describe Create, type: %i[virtus model] do

        it "inherits from Base" do
          expect(described_class < Base).to be true
        end

        describe "attributes" do
          subject { described_class }
          it { is_expected.to have_attribute(:payment) }
        end

      end
    end
  end
end
