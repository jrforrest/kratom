module Kratom
  Error = Class.new(StandardError)
  FileError = Class.new(Error)
  SyntaxError = Class.new(Error)
end
