# frozen_string_literal: true

require 'spec_helper'

require 'tempfile'

require 'nft'

RSpec.describe NFT do
  before do
    uid = Etc.getpwuid.uid
    skip 'You must be root to run this test' unless uid.zero?
  end

  describe '.run' do
    context 'when the command is valid' do
      it 'returns successful' do
        expect(described_class.run('list tables')).to be_an(Array)
      end
    end

    context 'when the command is invalid' do
      it 'raises an error' do
        expect { described_class.run('list tables foo') }.to raise_error(RuntimeError)
      end
    end

    context 'with debug enabled' do
      let(:stderr) { Tempfile.new('nft.debug') }

      around do |example|
        described_class.debug = NFT::Library::NFT_DEBUG_MNL

        org = $stderr.clone
        $stderr.reopen(stderr)

        example.run
      ensure
        $stderr.reopen(org)
        stderr.close
        stderr.unlink
      end

      it 'returns successful and prints debug info on stderr', :aggregate_failures do
        expect(described_class.run('list tables')).to be_an(Array)

        stderr.rewind
        err = stderr.read
        expect(err).to be_a(String)
        expect(err).not_to be_empty
      end
    end
  end
end
