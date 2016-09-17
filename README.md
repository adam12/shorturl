# URL Shortener

Am I late to the party? These were all the rage back a few years ago.

Oh well...


## Features

- Single dependency (Rack)
- Short and concise (30 lines of code)
- Easy enough to run as a CGI script (remember those? they're still around)
- No external database dependency

## Why

Why not? I thought about building one for a while, never really had a need. Who
needs short URLs anyways?

Except it's come to my attention I need people to copy a URL off a projector,
and maybe I can make my URLs shorter than a Github Gist URL.

I wanted something that wasn't built in Rails, ran on PHP, or needed a database.

## Installation

1. Upload to server that supports CGI
2. Install rack

		gem install rack

   or

		gem install -g Gemfile


## License

MIT
