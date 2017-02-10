require 'kratom/abstract_builder'
require 'kratom/exceptions'
require 'fileutils'
require 'set'

module Kratom
  class FileBuilder < AbstractBuilder
    ResourceType = Struct.new(:collection, :ext)

    def build
      build_directories
      Site.resource_types.each {|type| build_type(type) }
    end

    private

    def written_paths
      @written_paths ||= Set.new
    end

    def build_directories
      FileUtils.mkdir_p(config.output_dir)
    end

    def build_type(resource_type)
      if resource_type.buildable?
        site.resource_collection(resource_type.name).each do |r|
          write_output_file(r, resource_type)
        end
      end
    end

    def write_output_file(resource, resource_type)
      path = output_dir.join(resource.path)
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
