require "konf"

class StrictKonf < Konf
  VERSION = '0.0.1'

  class UnknownKeys < StandardError; end

  def initialize(source, root, required_keys)
    super(source, root)
    @required_keys = required_keys

    validate_required_keys
    validate_provided_keys
  end

  private

  def validate_required_keys
    @required_keys.each { |key| public_send(key) }
  end

  def validate_provided_keys
    extra = keys.map(&:to_sym) - @required_keys
    if extra.any?
      raise UnknownKeys, "Unknown keys in config: #{extra}"
    end
  end
end
