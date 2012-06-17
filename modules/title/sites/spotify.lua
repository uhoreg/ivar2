local simplehttp = require'simplehttp'
local html2unicode = require'html'

customHosts['open.spotify.com'] = function(queue, info)
	local path = info.path

	if(path and path:match'/(%w+)/(.+)') then
		simplehttp(
			info.url,

			function(data, url, response)
				local title = html2unicode(data:match'<title>(.-) on Spotify</title>')
				local uri = data:match('property="og:audio" content="([^"]+)"')

				queue:done(string.format('%s: %s', title, uri))
			end
		)

		return true
	end
end
