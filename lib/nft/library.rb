# frozen_string_literal: true

require 'ffi'

module NFT
  module Library
    extend FFI::Library
    ffi_lib 'nftables'

    NFT_CTX_DEFAULT = 0

    NFT_DEBUG_SCANNER       = 0x1
    NFT_DEBUG_PARSER        = 0x2
    NFT_DEBUG_EVALUATION    = 0x4
    NFT_DEBUG_NETLINK       = 0x8
    NFT_DEBUG_MNL           = 0x10
    NFT_DEBUG_PROTO_CTX     = 0x20
    NFT_DEBUG_SEGTREE       = 0x40

    attach_function :nft_ctx_new, %i[int], :pointer
    attach_function :nft_ctx_free, %i[pointer], :void
    attach_function :nft_run_cmd_from_buffer, %i[pointer string], :int
    attach_function :nft_ctx_output_set_flags, %i[pointer int], :void
    attach_function :nft_ctx_output_set_debug, %i[pointer int], :void
  end
end
