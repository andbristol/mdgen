require 'forwardable'

require 'mdgen/markdown/table'
require 'mdgen/markdown'
require 'mdgen/dsl'
require 'mdgen/version'

module MDGen

  extend self

  def md(&block)
    raise ArgumentError, 'Must pass a block' unless block
    dsl = DSL::Basic.new
    dsl.instance_eval(&block)
  end

  def document(&block)
    raise ArgumentError, 'Must pass a block' unless block
    dsl = DSL::Document.new
    dsl.instance_eval(&block)
    dsl.elements.join("\n")
  end
end
