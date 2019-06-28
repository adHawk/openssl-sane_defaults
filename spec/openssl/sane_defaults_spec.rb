# frozen_string_literal: true

RSpec.describe OpenSSL::SaneDefaults do
  it 'has a version number' do
    expect(OpenSSL::SaneDefaults::VERSION).not_to be nil
  end

  describe '.patch!' do
    before { described_class.patch! }

    %w[SSLv2 SSLv3 TLSv1 COMPRESSION].each do |opt|
      it "does not allow #{opt}" do
        flag = Object.const_get("OpenSSL::SSL::OP_NO_#{opt}")

        # Check that the flag is set
        opts = OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:options]
        expect(opts).to be_allbits(flag)
      end
    end
  end
end
