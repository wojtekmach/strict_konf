require "konf"

class StrictKonf < Konf
  VERSION = File.read(File.dirname(__FILE__) + '/../VERSION').strip

  class UnknownKeys < StandardError; end

  def initialize(source, root, required_keys)
    super(source, root)
    @required_keys = required_keys

    _validate_required_keys
    _validate_provided_keys
  end

  def method_missing(name, *args, &block)
    result = super
    if result.is_a? Konf
      StrictKonf.new(result, nil, _normalize_keys.fetch(name))
    else
      result
    end
  end

  private

  def _validate_required_keys
    keys = @required_keys
    keys = keys.keys if keys.is_a? Hash

    keys.each { |key|
      if key.is_a? Symbol
        public_send(key.to_s)
      end
    }
  end

  def _validate_provided_keys
    required = @required_keys
    required = required.keys if keys.is_a? Hash
    required = required.map { |key| key.is_a?(Hash) ? key.keys : key }
    required = required.flatten.map(&:to_s)

    extra = keys - required
    if extra.any?
      raise UnknownKeys, "Unknown keys in config: #{extra}"
    end
  end

  def _normalize_keys
    @required_keys.each_with_object({}) {|key, hash|
      if key.is_a? Hash
        hash.merge!(key)
      elsif key.is_a? Array
        hash[key[0]] = key[1]
      else
        hash[key] = true
      end
    }
  end
end
