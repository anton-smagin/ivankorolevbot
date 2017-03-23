# Телеграм-бот
# encoding: UTF-8
# Этот код необходим при использовании русских букв на Windows
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
###

require 'telegram/bot'

TOKEN = '312322718:AAHmzp2WRQljmVIlh_gPKHD0TAWo4qMqpIE'#ENV['TELEGRAM_BOT_API_TOKEN']

# путь к файлу с ответами
require "./data/chat"
require "./data/react"
class Message
  attr_accessor :text
end
message = Message.new 
message.text= gets.chomp

React::NAMES.each do |name|
  if /.*#{name}.*/iu =~ message.text
    p ("<Text: %s>" % Chat::WHO_IS_IT.sample).encode(Encoding.default_external, :undef => :replace)
    break
  end
end
React::PLACES.each do |place|
  if /#{place}/i =~ message.text
    p ("<Text: %s>" % Chat::WHERE_ARE_YOU.sample).encode(Encoding.default_external, :undef => :replace)
    break
  end
end 
#p ("<Text: %s>" % philosophy_lines.sample).encode(Encoding.default_external, :undef => :replace) #if  rand() < 1    


