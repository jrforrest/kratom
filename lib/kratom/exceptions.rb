module Kratom
  Error = Class.new(StandardError)
  FileError = Class.new(Error)
  NameError = Class.new(Error)
  SyntaxError = Class.new(Error)
  MetaParseError = Class.new(Error)
  MissingResourceError = Class.new(Error)
  ResourceConflict = Class.new(Error)
  ResourceTypeError = Class.new(Error)
  MissingMetaData = Class.new(Error)
end
