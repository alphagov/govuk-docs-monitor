require_relative './../lib/runner'

require "spec_helper"
require "vcr"
require "webmock/rspec"

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.describe Runner do
  it "generates the correct message" do
    VCR.use_cassette "fresh" do
      payloads = Runner.new.message_payloads

      expect(payloads).to match([
        {
          username: "Corinne the Doctrine Penguin",
          icon_emoji: ":penguin:",
          text: "Hello :wave:, this is your friendly penguin of doctrine.\n\n- <https://docs.publishing.service.gov.uk/manual/alerts/asset-master-attachment-processing.html|asset master attachment processing> should be reviewed now\n",
          mrkdwn: true,
          channel: "#2ndline",
        }
      ])
    end
  end
end
