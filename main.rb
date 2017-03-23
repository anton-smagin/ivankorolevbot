# Телеграм-бот
# encoding=utf-8 

require 'telegram/bot'

TOKEN = '312322718:AAHmzp2WRQljmVIlh_gPKHD0TAWo4qMqpIE'#ENV['TELEGRAM_BOT_API_TOKEN']

# путь к файлу с ответами
require "./data/chat"
require "./data/react"
#require "#{File.dirname(__FILE__)}/data/react_places.rb"
#require "#{File.dirname(__FILE__)}/data/who_is_it.rb"
#require "#{File.dirname(__FILE__)}/data/where_are_you.rb"

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
      when '/start', '/start start'
        bot.api.send_message(
            chat_id: message.chat.id,
            text: "Здравствуй, #{message.from.first_name}."
        )
      else      
        React::NAMES.each do |name|
          if /.*#{name}.*/iu =~ message.text
            bot.api.send_message(chat_id: message.chat.id, text: Chat::WHO_IS_IT.sample) 
            break
          end
        end
        React::PLACES.each do |place|
          if /#{place}/iu =~ message.text
            bot.api.send_message(chat_id: message.chat.id, text: Chat::WHERE_ARE_YOU.sample) 
            break
          end
       end
      # Chat::PHILOSOPHY.sample
      rand_num = rand()
      bot.api.send_message(chat_id: message.chat.id, text: rand_num) 
    end
  end
end