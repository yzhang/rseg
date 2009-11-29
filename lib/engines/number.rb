NUMBER_SYMBOLS  = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
                  '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', 
                  '零', '〇', '百', '千', '壹', '贰', '叁', '肆', '柒', '捌',
                  '玖', '拾', '之', '%', '¥', '分', '$', '.', '点', '第', '每']
SUBUNIT_SYMBOLS = ['多', '公', '英', '厘', '毫', '微', '纳', '海', '平', '立', 
                   '方', '摄', '华', '氏', '美', '日', '澳', '港', '台', '新',
                   '个', '百', '佰', '千', '仟', '万', '萬', '亿', '兆', '吉']
UNIT_SYMBOLS    = ['刻', '章', '回', '节', '名', '个', '届', '次', '集', '元', 
                   '角', '例', '人', '斤', '克', '吨', '米', '里', '升', '码',
                   '尺', '寸', '杆', '顷', '亩', '磅', '镑', '桶', '度', '秒',
                   '分', '卡', '焦', '瓦', '匹', '圆', '币', '年', '月', '日', 
                   '时', '秒', '点', '百', '佰', '仟', '千', '万', '萬', '亿', 
                   '兆', '吉', '块', '半', '岁', '家', '所', '期', '场', '投',
                   '中', '辆', '只', '头']
            
class Number < Engine
  def initialize
    @word = ''
    @number = ''
    @unit = false
    @subunit = false
    super
  end
  
  def process(char)
    match = false
    word = nil
    
    if (!@subunit || @unit) && NUMBER_SYMBOLS.include?(char)
      @number << char
      match = true
      @unit = false
      @subunit = false
    elsif (@number != '' || @unit) && SUBUNIT_SYMBOLS.include?(char)
      @number << char
      match = true
      @subunit = true
    end
    
    if (@number != '' || @subunit) && UNIT_SYMBOLS.include?(char)
      @word << @number
      @word << char if !match
      @number = ''
      @unit = true
      match = true
    end
    
    if !match
      word = (@word != '') ? @word : @number
      @word = ''
      @number = ''
      match = false
      @unit = false
      @subunit = false
    end
    
    [match, word]
  end
end