require 'spec_helper'

RSpec.describe "Create txn preview" do

  it "asks for deposit target details", vcr: {record: :once} do
    config = CONFIG.slice(*%i[partner_id api_secret])
    client = BloomRemitClient.new(config)

    response = client.create_txn_preview(
      amount: 500,
      payout_method: "BPI"
    )

    expect(response).to be_success, response.raw_response.body

    expect(response.errors).to be_empty

    txn_preview = response.txn_preview

    expect(txn_preview.amount).to eq 500
    expect(txn_preview.payout_method).to eq "BPI"
    expect(txn_preview.total_fees).not_to be_nil
    expect(txn_preview.maximum_wait_time_in_minutes).not_to be_nil
    expect(txn_preview.minimum_wait_time_in_minutes).not_to be_nil
    expect(txn_preview.days_available).not_to be_empty
    expect(txn_preview.maximum_amount).not_to be_nil
  end

  context "response has errors" do
    it "contains errors", vcr: {record: :once} do
      config = CONFIG.slice(*%i[partner_id api_secret])
      client = BloomRemitClient.new(config)

      response = client.create_txn_preview(
        amount: 500,
        payout_method: "ABSD#12341234"
      )

      expect(response).to be_success, response.raw_response.body

      expect(response.errors).to be_a Array
      expect(response.errors)
        .to include "Cannot find deposit target with slug ABSD#12341234"
    end
  end
end
