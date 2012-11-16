module TracksHelper
  def youtube_id(url)
    $regexp=/\=([a-zA-Z0-9_-]*)/
    $youtube_link = "http://www.youtube.com/v/#{$regexp.match(url)[1]}"
  end
end
