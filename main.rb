# Телеграм-бот
# encoding=utf-8 

require 'telegram/bot'

TOKEN = ENV['TELEGRAM_TOKEN']

require "./data/chat"
require "./data/react"

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
      rand_num = rand()
      bot.api.send_message(chat_id: message.chat.id, text: Chat::PHILOSOPHY.sample) if rand_num < 0.01 
    end
  end
end
