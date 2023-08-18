# frozen_string_literal: true

require 'json'

require_relative 'nft/library'
require_relative 'nft/ctx'

##
# The NFT module is a foreign function interface for the high-level
# userspace netfilter nftables library.
#
# It provides a basic run method, to execute nftables commands. For valid
# commands see the +nftables+(8) manpage and the {nftables wiki}[https://wiki.nftables.org].
module NFT
  class << self
    include NFT::Ctx

    ##
    # Enable and control debugging output.
    #
    # For options see the libnftables(3) manpage.
    # The information is printed to stderr.
    #
    #    NFT.debug = NFT::Library::NFT_DEBUG_SCANNER | NFT::Library::NFT_DEBUG_PARSER
    attr_accessor :debug

    ##
    # Run given nftables command.
    #
    # The method returns an array of hashes if the command presents any output
    # or an empty array otherwise. On execution failure it raises a runtime
    # error.
    #
    #    NFT.run('list ruleset')
    def run(cmd)
      begin
        ctx_create
        rc = 0
        stdout, stderror = ctx_run { rc = NFT::Library.nft_run_cmd_from_buffer(@ctx, cmd) }
      ensure
        ctx_free
      end
      return raise stderror unless rc.zero?

      return [] if stdout.nil? || stdout.empty?

      stdout = ctx_debug!(stdout)
      stdout.split("\n").map(&:strip).reject(&:empty?).map { |line| JSON.parse(line) }
    end
  end
end
