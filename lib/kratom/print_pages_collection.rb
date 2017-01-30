module Kratom
  class PrintPagesCollection < PagesCollection
    resource_class PrintPage
    def resources
      super.filter {|p| config.print_pages.include?(p.name) }
    end
  end
end
