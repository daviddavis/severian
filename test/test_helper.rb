require 'minitest/autorun'
require 'mocha/setup'
require 'severian'

begin
  require 'pry'
rescue LoadError
  warn "warning: pry gem not found; skipping pry support"
end

