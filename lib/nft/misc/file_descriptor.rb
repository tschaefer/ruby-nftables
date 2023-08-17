# frozen_string_literal: true

require 'tempfile'

module NFT
  module FileDescriptor
    private

    def fd_redirect(name)
      origin = name.clone
      tempfile = Tempfile.new("nft.#{(0...8).map { rand(65..90).chr }.join}")
      name.reopen(tempfile)

      [origin, tempfile]
    end

    def fd_restore(name, origin, tempfile)
      name.reopen(origin)
      tempfile.close
      tempfile.unlink
    end
  end
end
