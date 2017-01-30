require 'markdown_resource'

class Note < MarkdownResource
  MetaParseError = Class.new(Error)

  def meta
    @meta ||= (checked_meta_data || Hash.new).to_h
  end

  private

  def checked_meta_data
    if meta_data.kind_of?(Hash) or meta_data.kind_of?(FalseClass)
      meta_data
    else
      raise MetaParseError,
        "YAML meta data should be a hash. File: #{pathname}"
    end
  end

  def meta_data
    @meta_data ||= YAML.load(meta_text)
  rescue Psych::SyntaxError => e
    raise MetaParseError,
      "Markdown meta parse error in file #{pathname}: #{e.message}"
  end

  def meta_text
    if sep_index and sep_index > 0
      lines[0..(sep_index - 1)].join
    else
      ''
    end
  end

  def md_text
    if sep_index
      lines[(sep_index + 1)..-1].join
    else
      lines.join
    end
  end

  def sep_index
    @sep_index ||= lines.index("---\n")
  end

  def lines
    @lines ||= file_contents.lines
  end
end
