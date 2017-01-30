class Site
  MissingFile = Class.new(StandardError)

  def initialize(config)
    @config = config
  end

  attr_reader :config

  def pages
    @pages ||= PageCollection.new(self)
  end

  def print_pages
    @print_pages ||= PrintPagesCollection.new(self, config.pages_pattern)
  end

  def templates
    @templates ||= TemplateCollection.new(self, config.templates_pattern)
  end

  def stylesheets
    @stylesheets ||= StylesheetCollection.new(self, config.sheets_pattern)
  end

  def snippets
    @snippets ||= SnippetsCollection.new(self, config.snippets_pattern)
  end

  def notes
    @docs ||= Notes.new(config)
  end

  def generate
    pages.generate_all
  rescue Errno::ENOENT => e
    raise MissingFile, e.message
  end
end
