# frozen_string_literal: true
# rbs_inline: enabled

class Annotation
  attr_reader :message #: ::Pronto::Message

  #: (::Pronto::Message) -> void
  def initialize(message)
    @message = message
  end

  # @rbs return: bool
  def line?
    !message.line.nil?
  end

  # @rbs return: { path: String, start_line: Integer, end_line: Integer, annotation_level: Symbol, message: String, title: String }
  def to_h
    lineno = message.line.new_lineno if message.line
    {
      path: message.path,
      start_line: lineno,
      end_line: lineno,
      annotation_level: level_for(message.level),
      message: message.msg,
      title: message.runner.title
    }
  end

  # @rbs return: String
  def to_markdown_s
    "| `#{message.commit_sha[0, 7]}` | `#{message.level}` | #{message.msg} |"
  end

  # @rbs (Symbol) -> Symbol
  def level_for(pronto_level)
    {
      info: :notice,
      warning: :warning,
      error: :failure,
      fatal: :failure
    }.fetch(pronto_level, :warning)
  end
end
