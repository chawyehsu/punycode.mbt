// RFC3492 test cases
test "encode" {
  // Arabic (Egyptian) -> ASCII (Punycode)
  let raw = "ليهمابتكلموشعربي؟"
  let encoded = "egbpdaj6bu4bxfgehfvwxn"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  // Chinese (simplified) -> ASCII (Punycode)
  let raw = "他们为什么不说中文"
  let encoded = "ihqwcrb4cv8a8dqg056pqjye"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  // Chinese (traditional) -> ASCII (Punycode)
  let raw = "他們爲什麽不說中文"
  let encoded = "ihqwctvzc91f659drss3x8bo0yb"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  // Czech -> ASCII (Punycode)
  let raw = "Pročprostěnemluvíčesky"
  let encoded = "Proprostnemluvesky-uyb24dma41a"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  // Hebrew -> ASCII (Punycode)
  let raw = "למההםפשוטלאמדבריםעברית"
  let encoded = "4dbcagdahymbxekheh6e0a7fei0b"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  // Hindi (Devanagari) -> ASCII (Punycode)
  let raw = "यहलोगहिन्दीक्योंनहींबोलसकतेहैं"
  let encoded = "i1baa7eci9glrd9b2ae1bj0hfcgg6iyaf8o0a1dig0cd"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  // Japanese (kanji and hiragana) -> ASCII (Punycode)
  let raw = "なぜみんな日本語を話してくれないのか"
  let encoded = "n8jok5ay5dzabd5bym9f0cm5685rrjetr6pdxa"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  // Korean (Hangul syllables) -> ASCII (Punycode)
  let raw = "세계의모든사람들이한국어를이해한다면얼마나좋을까"
  let encoded = "989aomsvi5e83db1d2a355cv1e0vak1dwrv93d5xbh15a0dt30a5jpsd879ccm6fea98c"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  // Russian (Cyrillic) -> ASCII (Punycode)
  let raw = "почемужеонинеговорятпорусски"
  let encoded = "b1abfaaepdrnnbgefbadotcwatmq2g4l"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  // Spanish -> ASCII (Punycode)
  let raw = "PorquénopuedensimplementehablarenEspañol"
  let encoded = "PorqunopuedensimplementehablarenEspaol-fmd56a"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  // Vietnamese -> ASCII (Punycode)
  let raw = "TạisaohọkhôngthểchỉnóitiếngViệt"
  let encoded = "TisaohkhngthchnitingVit-kjcr8268qyxafd2f1b9g"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  // Mixed script -> ASCII (Punycode)
  let raw = "3年B組金八先生"
  let encoded = "3B-ww4c5e180e575a65lsy2b"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  let raw = "安室奈美恵-with-SUPER-MONKEYS"
  let encoded = "-with-SUPER-MONKEYS-pc58ag80a8qai00g7n9n"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  let raw = "Hello-Another-Way-それぞれの場所"
  let encoded = "Hello-Another-Way--fc4qua05auwb3674vfr0b"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  let raw = "ひとつ屋根の下2"
  let encoded = "2-u9tlzr9756bt3uc0v"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  let raw = "MajiでKoiする5秒前"
  let encoded = "MajiKoi5-783gue6qz075azm5e"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  let raw = "パフィーdeルンバ"
  let encoded = "de-jg4avhby1noc0d"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  let raw = "そのスピードで"
  let encoded = "d9juau41awczczp"
  @builtin.assert_eq!(Some(encoded), encode(raw))
  let raw = "-> $1.00 <-"
  let encoded = "-> $1.00 <--"
  @builtin.assert_eq!(Some(encoded), encode(raw))
}

test "decode" {
  // ASCII (Punycode) -> Arabic (Egyptian)
  let raw = "egbpdaj6bu4bxfgehfvwxn"
  let decoded = "ليهمابتكلموشعربي؟"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  // ASCII (Punycode) -> Chinese (simplified)
  let raw = "ihqwcrb4cv8a8dqg056pqjye"
  let decoded = "他们为什么不说中文"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  // ASCII (Punycode) -> Chinese (traditional)
  let raw = "ihqwctvzc91f659drss3x8bo0yb"
  let decoded = "他們爲什麽不說中文"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  // ASCII (Punycode) -> Czech
  let raw = "Proprostnemluvesky-uyb24dma41a"
  let decoded = "Pročprostěnemluvíčesky"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  // ASCII (Punycode) -> Hebrew
  let raw = "4dbcagdahymbxekheh6e0a7fei0b"
  let decoded = "למההםפשוטלאמדבריםעברית"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  // ASCII (Punycode) -> Hindi (Devanagari)
  let raw = "i1baa7eci9glrd9b2ae1bj0hfcgg6iyaf8o0a1dig0cd"
  let decoded = "यहलोगहिन्दीक्योंनहींबोलसकतेहैं"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  // ASCII (Punycode) -> Japanese (kanji and hiragana)
  let raw = "n8jok5ay5dzabd5bym9f0cm5685rrjetr6pdxa"
  let decoded = "なぜみんな日本語を話してくれないのか"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  // ASCII (Punycode) -> Korean (Hangul syllables)
  let raw = "989aomsvi5e83db1d2a355cv1e0vak1dwrv93d5xbh15a0dt30a5jpsd879ccm6fea98c"
  let decoded = "세계의모든사람들이한국어를이해한다면얼마나좋을까"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  // ASCII (Punycode) -> Russian (Cyrillic)
  let raw = "b1abfaaepdrnnbgefbadotcwatmq2g4l"
  let decoded = "почемужеонинеговорятпорусски"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  // ASCII (Punycode) -> Spanish
  let raw = "PorqunopuedensimplementehablarenEspaol-fmd56a"
  let decoded = "PorquénopuedensimplementehablarenEspañol"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  // ASCII (Punycode) -> Vietnamese
  let raw = "TisaohkhngthchnitingVit-kjcr8268qyxafd2f1b9g"
  let decoded = "TạisaohọkhôngthểchỉnóitiếngViệt"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  // ASCII (Punycode) -> Mixed script
  let raw = "3B-ww4c5e180e575a65lsy2b"
  let decoded = "3年B組金八先生"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  let raw = "-with-SUPER-MONKEYS-pc58ag80a8qai00g7n9n"
  let decoded = "安室奈美恵-with-SUPER-MONKEYS"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  let raw = "Hello-Another-Way--fc4qua05auwb3674vfr0b"
  let decoded = "Hello-Another-Way-それぞれの場所"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  let raw = "2-u9tlzr9756bt3uc0v"
  let decoded = "ひとつ屋根の下2"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  let raw = "MajiKoi5-783gue6qz075azm5e"
  let decoded = "MajiでKoiする5秒前"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  let raw = "de-jg4avhby1noc0d"
  let decoded = "パフィーdeルンバ"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  let raw = "d9juau41awczczp"
  let decoded = "そのスピードで"
  @builtin.assert_eq!(Some(decoded), decode(raw))
  let raw = "-> $1.00 <--"
  let decoded = "-> $1.00 <-"
  @builtin.assert_eq!(Some(decoded), decode(raw))
}
