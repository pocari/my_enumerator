class MyEnumerator
  def initialize(&b)
    @fiber = Fiber.new do
      b.call(self)
    end
  end

  def <<(x)
    Fiber.yield(x)
  end

  def next
    @fiber.resume
  end
end

eee1 = MyEnumerator.new do |y|
  [1, 2, 3].each do |e|
    p [:hoge1, e]
    y << e
  end
end

p eee1.next
p eee1.next
p eee1.next
p eee1.next

eee2 = MyEnumerator.new do |y|
  [1, 2, 3].each do |e|
    p [:hoge2, e]
    y << e
  end
end

p eee2.next
p eee2.next
p eee2.next
p eee2.next
