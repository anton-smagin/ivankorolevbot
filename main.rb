# Телеграм-бот

# Этот код необходим при использовании русских букв на Windows
# if (Gem.win_platform?)
#   Encoding.default_external = Encoding.find(Encoding.locale_charmap)
#   Encoding.default_internal = __ENCODING__

#   [STDIN, STDOUT].each do |io|
#     io.set_encoding(Encoding.default_external, Encoding.default_internal)
#   end
# end
###

require 'telegram/bot'

TOKEN = '312322718:AAHmzp2WRQljmVIlh_gPKHD0TAWo4qMqpIE'#ENV['TELEGRAM_BOT_API_TOKEN']

# путь к файлу с ответами
philosophy_path = "#{File.dirname(__FILE__)}/data/philosophy.txt"
react_names_path = "#{File.dirname(__FILE__)}/data/react_names.txt"
react_places_path = "#{File.dirname(__FILE__)}/data/react_places.txt"
who_is_it_path = "#{File.dirname(__FILE__)}/data/who_is_it.txt"
where_are_you_path = "#{File.dirname(__FILE__)}/data/where_are_you.txt"
# открываю файл с ответами

begin
  philosophy = File.open(philosophy_path, "r:utf-8")
rescue Errno::ENOENT => e
  puts "Файл с философией не найден"
  abort e.message
end

philosophy_lines = philosophy.readlines
philosophy.close

# открываю файл с приветствием
begin
  react_names = File.open(react_names_path, "r:utf-8")
rescue Errno::ENOENT => e
  puts "Файл с именами не найден"
  abort e.message
end

react_names_lines = react_names.readlines
react_names.close

begin
  react_places = File.open(react_places_path, "r:utf-8")
rescue Errno::ENOENT => e
  puts "Файл с именами не найден"
  abort e.message
end

react_places_lines = react_places.readlines
react_places.close

begin
  who_is_it = File.open(who_is_it_path, "r:utf-8")
rescue Errno::ENOENT => e
  puts "Файл с именами не найден"
  abort e.message
end

who_is_it_lines = who_is_it.readlines
who_is_it.close

begin
  where_are_you = File.open(where_are_you_path, "r:utf-8")
rescue Errno::ENOENT => e
  puts "Файл с именами не найден"
  abort e.message
end

where_are_you_lines = where_are_you.readlines
where_are_you.close

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
      when '/start', '/start start'
        bot.api.send_message(
            chat_id: message.chat.id,
            text: "Здравствуй, #{message.from.first_name}."
        )
      else
        react_names_lines.each do |name|
          if /#{name}/i =~ message.text
            bot.api.send_message(chat_id: message.chat.id, text: who_is_it_lines.sample) 
            break
          end
        end
        react_places_lines.each do |place|
          if /#{place}/i =~ message.text
            bot.api.send_message(chat_id: message.chat.id, text: where_are_you_lines.sample) 
            break
          end
       end
      bot.api.send_message(chat_id: message.chat.id, text: philosophy_lines.sample) if rand() < 1
    end
  end
end