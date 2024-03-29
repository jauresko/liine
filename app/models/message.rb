class Message < ApplicationRecord
  after_create :broadcast_message, :mail_message
  belongs_to :user
  belongs_to :chat_room
  validates :content, presence: true, allow_blank: false

  def from?(some_user)
    user == some_user
  end

  def broadcast_message
    ActionCable.server.broadcast("chat_room_#{chat_room.id}", {
      message_partial: ApplicationController.renderer.render(
        partial: "../views/shared/messages",
        locals: { message: self, user_is_messages_author: false }),
        current_user_id: user.id
    })
  end

  def mail_message
    mail = MessageMailer.with(receiver: user ).message
    mail.deliver_now
  end
end
