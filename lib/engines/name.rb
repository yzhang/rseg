class Name < Engine
  @@last_names = %W(丁 卜 刁 七 弓 干 于 王 尤 孔 方 申 白 甘 田 包 石 左 平 司 皮 史 池 艾 年 匡 充 江 印
                  促 伊 伍 安 任 米 促 牟 向 吉 成 伏 吕 李 吴 沈 何 贝 狄 祁 杜 汪 阮 邢 汲 别 辛 冷 利 沃 谷
                  扶 步 那 沙 周 金 吕 花 孟 和 邵 房 抗 灰 明 屈 松 牧 宓 武 幸 卓 易 尚 邰 空 竺 岳 东 林 
                  施 姜 俞 查 封 秋 帅 祖 羿 柯 茅 柳 姚 纪 宣 咸 库 侯 洪 胡 哈 宣 郁 祝 苗 禹 娄 
                  秦 奚 倪 度 凌 宰 宦 师 徐 翁 班 马 时 晃 乌 夏 贡 柴 能 家 宫 敖 索 晏 桑 高 凌 桂 容 姬 劳 桑 桂 袁 时 祝 席 徐 高 夏 凌 洪 翁 家 芮 乌 祖 索 贡 
                  许 张 曹 戚 梅 屠 盛 崖 章 鱼 国 商 扈 寇 终 冯 苗 康 常 茅 闵 麻 胡 崔 邢 条 符 宿 堵 浦 习 鱼 
                  梁 富 曾 程 项 钮 舒 彭 费 童 云 喻 嵇 范 费 贺 毕 付 黄 邵 祁 阮 强 童 邱 解 贲 单 富 钮 荀 惠 邴 焦 班 甯 钭 景 邰 劳 茹 寇 荆 
                  莫 际 景 须 杨 詹 郎 雷 贾 路 骆 虞 经 裘 郁 滑 甄 靳 詹 闻 逄 雍 訾 郎 农 路 骆 虞 经 裘 郁 滑 靳 闻 逄 雍 
                  赵 黄 褚 凤 郝 齐 臧 熊 管 裴 荣 郗 韶 郜 黎 翟 寿 通 
                  卫 葛 鲁 乐 谈 董 樊 万 诸 刘 叶 都 满 广 殴 巩 养 
                  郭 钱 陈 陶 鲍 穆 郭 堆 卢 陆 龙 噪 鄂 阴 苍 燕 冀 衡 融 蒯 逯 
                  蒋 魏 谢 邹 潘 滕 邬 戴 钟 蔡 缪 应 储 糜 隗 历 蒲 慕 蔚 隆 鞠 关
                  韩 萧 颜 庞 麦 双 璩 濮 聂 丰 看 
                  郑 严 蓟 薄 谭 罗 买 蓝 蓬 怀 党 饶 顾 苏 龚 边 栾 权) #:nodoc:
                  
  @@first_names = %W(文 铭 菁 郁 怡 智 德 祥 志 华 孟 庆 雅 佩 晓 蓉 明 仁 宇 青 慧 豪 琪 安
                   惠 宗 信 盈 君 秀 敏 伶 佳 国 荣 忠 宏 育 丽 圣 淑 彦 龙 冠 后 静 娟 子
                   嘉 瑞 柏 弘 芳 正 玮 贞 如 凯 元 士 伟 杰 颍 霖 玲 仪 珮 英 建 政 真 珍
                   美 世 立 秋 婷 贤 瑜 中 玉 维 莹 翔 家 芬 昌 裕 雯 萍 永 成 宜 鸿 珊 民
                   欣 哲 良 伦 燕 梦 磊 丹 元 一 昌 红 健) #:nodoc:
  def initialize
    @word = ''
    @last = false
    super
  end
  
  def process(char)
    match = false
    word = nil
    
    if !@last && @@last_names.include?(char)
        @word << char
        match = true
        @last = true
    elsif @last && @word.chars.to_a.length < 3 && @@first_names.include?(char)
        @word << char
        match = true
        @unit = true
    else
      word = @word
      @word = ''
      @last = false
      match = false
    end

    [match, word]
  end
end