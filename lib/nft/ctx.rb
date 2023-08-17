# frozen_string_literal: true

require_relative 'library'
require_relative 'misc/file_descriptor'

module NFT
  module Ctx
    include FileDescriptor

    private

    def ctx_create
      ctx = NFT::Library.nft_ctx_new(NFT::Library::NFT_CTX_DEFAULT)

      NFT::Library.nft_ctx_output_set_flags(ctx, 16)
      NFT::Library.nft_ctx_output_set_debug(ctx, @debug) if @debug

      @ctx = ctx
    end

    def ctx_free
      NFT::Library.nft_ctx_free(@ctx)
    end

    def ctx_run
      stdout_origin, stdout_tmpfile = fd_redirect($stdout)
      stderr_origin, stderr_tmpfile = fd_redirect($stderr)

      yield

      stdout_tmpfile.rewind
      stderr_tmpfile.rewind
      [stdout_tmpfile.read, stderr_tmpfile.read]
    ensure
      fd_restore($stdout, stdout_origin, stdout_tmpfile)
      fd_restore($stderr, stderr_origin, stderr_tmpfile)
    end

    def ctx_debug!(data)
      return data if @debug.nil?

      warn data.slice!(0, data.index('{"nftables":') || 0)
      data
    end
  end
end
