require 'forwardable'

require 'mdgen/dsl'
require 'mdgen/markdown/table'
require 'mdgen/markdown'
require 'mdgen/version'

module MDGen

  extend self

  def md(&block)
    raise ArgumentError, "Must pass a block" unless block
    dsl = DSL.new
    dsl.instance_eval(&block)
    dsl.elements.join("\n")
  end
end
