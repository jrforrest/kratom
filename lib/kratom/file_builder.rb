require 'kratom/abstract_builder'
require 'kratom/exceptions'
require 'fileutils'
require 'set'

module Kratom
  class FileBuilder < AbstractBuilder
    ResourceType = Struct.new(:collection, :ext)

    def build
      build_directories
      resource_types.each { |type| build_type(type) }
    end

    private

    def written_paths
      @written_paths ||= Set.new
    end

    def build_directories
      FileUtils.mkdir_p(config.output_dir)
    end

    def resource_types
      [ [site.pages, 'html'],
        [site.notes, 'html'],
        [site.stylesheets, 'css']
      ].map {|a| ResourceType.new(*a) }
    end

    def build_type(resource_type)
      resource_type.collection.each {|r| write_output_file(r, resource_type) }
    end

    def write_output_file(resource, resource_type)
      path = resource_path(resource, resource_type.ext)

      if written_paths.include?(path)
        raise ResourceConflict,
          "There's already an output file named #{path.basename}.  "\
          "The #{resource.class} resource named #{resource.name} will have to "\
          "be renamed to resolve the conflict."
      else
        path.write(resource.output)
        written_paths << path
      end
    end

    def resource_path(resource, extension)
      output_dir.join("#{resource.name}.#{extension}")
    end

    def output_dir
      Pathname.new(config.output_dir)
    end
  end
end
