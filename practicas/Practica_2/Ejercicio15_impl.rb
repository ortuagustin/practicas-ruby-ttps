module Countable
  module ClassMethods
    def count_invocations_of(sym)
      alias_method(:"o_#{sym}", sym)
      define_method "#{sym}" do
        self.invocations[sym] += 1
        self.send(:"o_#{sym}")
      end
    end
  end

  def invocations
    @invocations ||= Hash.new 0
  end

  def invoked?(sym)
    self.invoked(sym) > 0
  end

  def invoked(sym)
    self.invocations[sym]
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end