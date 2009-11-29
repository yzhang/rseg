CONJUNCTIONS = %W(给 的 说 对 在 和 是 被 最 所 那 由 这 有 将 你 会 与 他 为 不 没 很 了 啊 哦 呵 把 去 从)

class Conjunction
  def self.filter(char)
    CONJUNCTIONS.include?(char) ? :conjunction : char
  end
end