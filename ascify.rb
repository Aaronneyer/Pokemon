require 'RMagick'
include Magick

require 'open-uri'

urli = open(ARGV[0])

image = ImageList.new
image.from_blob(urli.read)

ascii = ''
image[0].each_pixel do |p,c,r|
	ascii << "\n" if c==0
	color = (p.red*0.2126 + p.green*0.7152 + p.blue*0.0722)/256 + p.opacity/256
	if color>250
		ascii << "."
	elsif color>230
		ascii << "`"
	elsif color>200
		ascii << ":"
	elsif color>175
		ascii << "*"
	elsif color>150
		ascii << "+"
	elsif color>125
		ascii << "#"
	elsif color>50
		ascii << "W"
	else
		ascii << "@"
	end
end
ascii.gsub!(/(^(\.*\n)*)|(\n\.*$)/, '')

puts ascii
