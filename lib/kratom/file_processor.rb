class FileTransform
  attr_reader :input_pattern, :output_ext

  def initialize(input_pattern:, output_ext:, base_path:)
    @input_pattern, @output_ext, @base_path =
      input_pattern, output_ext, base_path
  end

  def apply
    raise NotImplementedError
  end
end

class SlimTransform
  def initialize(
    input_pattern:, base_path:, output_ext:, layout:, snippets: {}
  )
    super(
      input_pattern: input_pattern,
      output_ext: output_ext,
      base_path: base_path)
    @layout = layout
  end

  def apply
    input_tilts.each { |template| render(layout) { render(template } }
  end

  private

  def render(template, &block = nil)
    if block
      template.render(nil, snippets: snippets, &block)
    else
      template.render(nil, snippets: snippets)
    end
  end

  def input_tilts
    input_paths.map {|p| Tilt.new(p) }
  end

  def input_paths
    Dir[base_path.join('pages', '*.slim')]
  end

  def page(path)
    Tilt.new(path)
  end

  def layout
    @layout ||= Tilt.new(base_path.join('layouts').join("#{layout}.slim")
  end
end
