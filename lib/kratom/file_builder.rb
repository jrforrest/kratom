require 'abstract_builder'

class FileBuilder < AbstractBuilder
  ResourceType = Struct.new(:collection, :ext, :build)

  def build
    resource_types.each { |t| build_type(t) }
  end

  private

  def resource_types
    [ [site.pages, 'html', ->(b) { b.html }],
      [site.notes, 'html', ->(b) { b.html }],
      [site.print_pages, 'html', ->(b) { b.html }],
      [site.stylesheets, 'css', ->(b) { b.css }]
    ].map {|a| ResourceType.new(*a) }
  end

  def config
    site.config
  end

  def build_type(resource_type)
    resource_type.collection.each do |resource|
      content = resource_type.build.call(resource)
      write_output_file(resource.name, resource_type.extension, content)
    end
  end

  def write_output_file(name, extension, content)
    config.output_dir.join("#{name}.#{extension}").write(content)
  end
end
