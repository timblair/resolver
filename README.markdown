# Resolver

[Resolver](http://resolver.heroku.com/) is an incredibly simple REST-style DNS resolver web service, built with [Sinatra](http://www.sinatrarb.com/) and [Net::DNS](http://github.com/bluemonk/net-dns).

It returns a JSON array of relevant results (or a JSONP packet if given a `callback` query string parameter) for the given domain and record type.  The default record type is `A` for domains, but other types can be requested (see examples below); IP addresses perform a reverse lookup.

## Web Service

The service [runs on Heroku](http://resolver.heroku.com/), and makes use of HTTP caching on all requests (requests are cached for 5 minutes).

## Usage Examples

	GET /tim.bla.ir
	GET /google.com?callback=announce
	GET /google.com/MX
	GET /www.google.com/CNAME
	GET /74.125.148.11

## Licensing and Attribution

Resolver was developed by [Tim Blair](http://tim.bla.ir/) and has been released under the MIT license as detailed in the LICENSE file that should be distributed with this library; the source code is [freely available](http://github.com/timblair/resolver).
