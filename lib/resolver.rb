require 'rubygems'
require 'sinatra/base'
require 'erb'
# http://rubygems.org/gems/net-dns
require 'net/dns/resolver'

module Resolver

  class Application < Sinatra::Base
    mime_type :text, 'text/plain'

    def initialize
      super
      @r = Net::DNS::Resolver.new
    end

    before do
      # cache all responses for 5 minutes
      expires 300, :public
    end

    get '/' do
      erb :index
    end

    get '/:question/?:type?' do
      content_type :text
      @r.send(params[:question], params[:type]).answer.collect { |a| a.type_inspect }.join("\n")
    end

  end
end


#
# The individual Net::DNS::RR instances have different accessor methods
# for the "host" part of the answer; this monkey patch effectively just
# exposes a (currently private) method so we can do something like:
# 
#   packet.answer.each do |answer|
#     hosts << answer.type_inspect
#   end
#
# instead of evilness like:
#
#   packet.answer.each do |answer|
#     hosts << answer.address  if answer.class == Net::DNS::RR::A
#     hosts << answer.cname    if answer.class == Net::DNS::RR::CNAME
#     hosts << answer.nsdname  if answer.class == Net::DNS::RR::NS
#     hosts << answer.ptrdname if answer.class == Net::DNS::RR::PTR
#     hosts << "#{answer.preference} #{answer.exchange}" if answer.class == Net::DNS::RR::MX
#   end
#
module Net
  module DNS
    class RR
      def type_inspect
        get_inspect
      end
    end
  end
end
