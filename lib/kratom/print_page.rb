module Kratom
  class PrintPage < Page
    def layout
      site.templates.get(config.print_layout)
    end

    def output_pathname
      config.output_dir.join("#{name}-print.html")
    end
  end
end
