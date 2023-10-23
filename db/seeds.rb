Admin.find_or_create_by!(email: 'admin@email.com') do |admin|
 admin.password = 'admin_passwprd'
end

customer_data = [
  { email: "akiko@example.com", nickname: "あきちゃん", password: "123456", image_filename: "sample-user1.jpg" },
  { email: "keizi@example.com", nickname: "けいじさま", password: "123456", image_filename: "sample-user2.jpg" },
  { email: "miduki@example.com", nickname: "みー", password: "123456", image_filename: "sample-user3.jpg" },
  { email: "masato@example.com", nickname: "まっかー", password: "123456", image_filename: "sample-user4.jpg" },
  { email: "hokuto@example.com", nickname: "ほっくー", password: "123456", image_filename: "sample-user5.jpg" }
]

customer_data.each do |data|
  Customer.find_or_create_by!(email: data[:email]) do |c|
    c.nickname = data[:nickname]
    c.password = data[:password]
    c.birth_date = Faker::Date.birthday(min_age: 18, max_age: 65)
    image_path = File.join(Rails.root, "db/fixtures", data[:image_filename])
    c.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open(image_path), filename: data[:image_filename])
  end
end


tag_names = [
  "パプリカ", "ピーマン", "茄子", "簡単", "おつまみ",
  "餃子アレンジ", "鶏もも消費", "あっさり", "お家で中華", "中華料理",
  "炊き込みご飯", "炊飯器", "炊飯器レシピ", "ズボラレシピ", "和風レシピ",
  "汁物", "豚汁", "秋", "おやつ", "サラダ",
]

tag_names.each do |name|
  Tag.find_or_create_by!(name: name)
end


recipe_data = [
  { title: "夏野菜カレー", image_filename: "夏野菜カレー.jpg", customer_id: 1 },
  { title: "手羽餃子", image_filename: "手羽餃子.jpg", customer_id: 2 },
  { title: "油淋鶏", image_filename: "油淋鶏.jpg", customer_id: 3 },
  { title: "炊き込みご飯", image_filename: "炊き込みご飯.jpg", customer_id: 4 },
  { title: "豚汁", image_filename: "豚汁.jpg", customer_id: 5 },
  { title: "おさつバター", image_filename: "おさつバター.jpg", customer_id: 1 },
  { title: "かぼちゃサラダ", image_filename: "かぼちゃサラダ.jpg", customer_id: 1 },
  { title: "エリンギ豚巻", image_filename: "エリンギ豚巻.jpg", customer_id: 1 },
  { title: "塩ちゃんこ鍋", image_filename: "塩ちゃんこ鍋.jpg", customer_id: 1 }
]

recipe_data.each do |data|
  Recipe.find_or_create_by!(title: data[:title]) do |recipe|
    image_path = File.join(Rails.root, "db/fixtures", data[:image_filename])
    recipe.image = ActiveStorage::Blob.create_and_upload!(io: File.open(image_path), filename: data[:image_filename])
    recipe.title = data[:title]
    recipe.customer_id = data[:customer_id]
  end
end

tag_recipe_relations = [
  { recipe_id: 1, tag_ids: [1, 2, 3, 4] },
  { recipe_id: 2, tag_ids: [5, 6] },
  { recipe_id: 3, tag_ids: [5, 7, 8, 9, 10] },
  { recipe_id: 4, tag_ids: [11, 12, 13, 14, 15] },
  { recipe_id: 5, tag_ids: [15, 16, 17] },
  { recipe_id: 6, tag_ids: [4, 18, 19] },
  { recipe_id: 7, tag_ids: [18, 20] },
  { recipe_id: 8, tag_ids: [4] },
  { recipe_id: 9, tag_ids: [4] }
]

tag_recipe_relations.each do |relation|
  recipe_id = relation[:recipe_id]
  tag_ids = relation[:tag_ids]

  tag_ids.each do |tag_id|
    RecipeTagRelation.find_or_create_by!(recipe_id: recipe_id, tag_id: tag_id)
  end
end


ingredients_data = [
{ name: "茄子", recipe_id: 1, amount: "2本" },
{ name: "ピーマン", recipe_id: 1, amount: "2個" },
{ name: "パプリカ", recipe_id: 1, amount: "1/2個" },
{ name: "玉ねぎ", recipe_id: 1, amount: "1個" },
{ name: "挽肉", recipe_id: 1, amount: "250g" },
{ name: "トマト", recipe_id: 1, amount: "1個" },
{ name: "市販のカレールウ", recipe_id: 1, amount: "1/2箱" },
{ name: "水", recipe_id: 1, amount: "200ml" },
{ name: "鶏手羽先", recipe_id: 2, amount: "約15～16本" },
{ name: "ニラ", recipe_id: 2, amount: "少々" },
{ name: "キャベツ", recipe_id: 2, amount: "お好み" },
{ name: "挽肉", recipe_id: 2, amount: "150g" },
{ name: "ニンニクチューブ", recipe_id: 2, amount: "お好み" },
{ name: "生姜チューブ", recipe_id: 2, amount: "お好み" },
{ name: "麺つゆ", recipe_id: 2, amount: "大さじ1" },
{ name: "塩胡椒", recipe_id: 2, amount: "少々" },
{ name: "ガラスープの素", recipe_id: 2, amount: "小さじ1" },
{ name: "胡麻油", recipe_id: 2, amount: "小さじ1" },
{ name: "鶏もも肉", recipe_id: 3, amount: "1枚" },
{ name: "片栗粉", recipe_id: 3, amount: "大さじ3" },
{ name: "揚げ油", recipe_id: 3, amount: "適量" },
{ name: "生姜チューブ", recipe_id: 3, amount: "適量" },
{ name: "長ネギ", recipe_id: 3, amount: "1/2本" },
{ name: "(A)酒", recipe_id: 3, amount: "小さじ1" },
{ name: "(A)しょうゆ", recipe_id: 3, amount: "小さじ1" },
{ name: "(B)しょうゆ", recipe_id: 3, amount: "大さじ1強" },
{ name: "(B)砂糖", recipe_id: 3, amount: "大さじ1強" },
{ name: "(B)酢", recipe_id: 3, amount: "大さじ2" },
{ name: "(B)はちみつ", recipe_id: 3, amount: "小さじ1" },
{ name: "(B)水", recipe_id: 3, amount: "大さじ1.5" },
{ name: "(B)ごま油", recipe_id: 3, amount: "大さじ1" },
{ name: "鶏もも肉", recipe_id: 4, amount: "150g" },
{ name: "(お好みの)キノコ", recipe_id: 4, amount: "適量" },
{ name: "人参", recipe_id: 4, amount: "1/4本" },
{ name: "昆布", recipe_id: 4, amount: "あればお好みで" },
{ name: "油揚げ", recipe_id: 4, amount: "あればお好みで" },
{ name: "塩", recipe_id: 4, amount: "小さじ1/2" },
{ name: "しょうゆ・酒・みりん", recipe_id: 4, amount: "各大さじ2" },
{ name: "砂糖", recipe_id: 4, amount: "小さじ2" },
{ name: "ほんだし(顆粒)", recipe_id: 4, amount: "小さじ2" },
{ name: "水", recipe_id: 4, amount: "適量" },
{ name: "豚バラ", recipe_id: 5, amount: "100g" },
{ name: "サツマイモ", recipe_id: 5, amount: "適量" },
{ name: "(お好きな)キノコ類", recipe_id: 5, amount: "適量" },
{ name: "人参", recipe_id: 5, amount: "1/4本" },
{ name: "長ねぎ", recipe_id: 5, amount: "1/3本" },
{ name: "大根", recipe_id: 5, amount: "1/8本" },
{ name: "その他(お好きな具材)", recipe_id: 5, amount: "適量" },
{ name: "水", recipe_id: 5, amount: "500ml" },
{ name: "顆粒和風だし", recipe_id: 5, amount: "小さじ2" },
{ name: "酒", recipe_id: 5, amount: "大さじ1" },
{ name: "味噌", recipe_id: 5, amount: "大さじ2" },
{ name: "醤油", recipe_id: 5, amount: "小さじ1" },
{ name: "さつまいも", recipe_id: 6, amount: "中1/3本" },
{ name: "バターまたはマーガリン", recipe_id: 6, amount: "10g" },
{ name: "砂糖または黒糖", recipe_id: 6, amount: "小さじ1/2" },
{ name: "かぼちゃ", recipe_id: 7, amount: "1/4個" },
{ name: "玉ねぎ", recipe_id: 7, amount: "1個" },
{ name: "塩", recipe_id: 7, amount: "小さじ1/2" },
{ name: "(A)はちみつ", recipe_id: 7, amount: "大さじ2" },
{ name: "(A)マヨネーズ", recipe_id: 7, amount: "大さじ5" },
{ name: "豚バラ肉 (スライス)", recipe_id: 8, amount: "6枚" },
{ name: "エリンギ", recipe_id: 8, amount: "お好きな量" },
{ name: "片栗粉", recipe_id: 8, amount: "大さじ1" },
{ name: "(A)ポン酢", recipe_id: 8, amount: "大さじ3" },
{ name: "(A)はちみつ", recipe_id: 8, amount: "大さじ1" },
{ name: "ごま油", recipe_id: 8, amount: "大さじ1" },
{ name: "豚バラ肉 (薄切り)", recipe_id: 9, amount: "150g" },
{ name: "好みの食材", recipe_id: 9, amount: "お好きな量" },
{ name: "水", recipe_id: 9, amount: "600ml" },
{ name: "酒", recipe_id: 9, amount: "大さじ3" },
{ name: "みりん", recipe_id: 9, amount: "大さじ2" },
{ name: "鶏ガラスープの素", recipe_id: 9, amount: "小さじ2" },
{ name: "にんにくチューブ", recipe_id: 9, amount: "適量" },
{ name: "すりおろし生姜チューブ", recipe_id: 9, amount: "適量" },
{ name: "砂糖", recipe_id: 9, amount: "小さじ1" },
{ name: "塩", recipe_id: 9, amount: "小さじ1/2" },
{ name: "ごま油", recipe_id: 9, amount: "小さじ2" }
]

ingredients_data.each do |data|
ingredient = Ingredient.find_by(data.slice(:recipe_id, :name))
Ingredient.create!(data) unless ingredient
end

procedures_data = [
{ body: "材料を好みの大きさに切る", recipe_id: 1 },
{ body: "フライパンにサラダ油を熱し玉ねぎを炒め、火が通ったら挽肉を加えて炒めます。", recipe_id: 1 },
{ body: "残りの食材を加え炒めたら、水を加え、沸騰したらあくを取り中火で約5分煮ます。", recipe_id: 1 },
{ body: "一旦火を止め、ルウを割り入れて溶かし、再び弱火でかき混ぜながら約10分煮込みます。", recipe_id: 1 },
{ body: "最後に残りのトマトを加えてひと煮立ちさせて完成！", recipe_id: 1 },
{ body: "餃子の餡を作ります。", recipe_id: 2 },
{ body: "骨を抜いた手羽に餡を詰めます。", recipe_id: 2 },
{ body: "手羽餃子をフライパンで両面焼いて完成！", recipe_id: 2 },
{ body: "鶏もも肉の厚いところは開いて、厚みを均等にします。", recipe_id: 3 },
{ body: "手順1をボウルに入れ、(A)の調味料を馴染ませて、15分ほど置きます。", recipe_id: 3 },
{ body: "生姜と長ネギをみじん切りにし、(B)の調味料と合わせてたれを作ります。", recipe_id: 3 },
{ body: "手順2の水気をキッチンペーパーで取り、片栗粉を両面にまぶします。", recipe_id: 3 },
{ body: "フライパンに揚げ油を注ぎ、170℃に熱し、皮目を下にして手順4を入れて4分程揚げます。裏返して、皮目に油をかけながらさらに3分程揚げ、中に火が通ったら油を切ります。", recipe_id: 3 },
{ body: "お皿に盛り付け、手順3をかけて完成です。", recipe_id: 3 },
{ body: "具材を好きな大きさに切る。", recipe_id: 4 },
{ body: "炊飯器に調味料➝お米➝水の順番で入れる。", recipe_id: 4 },
{ body: "最後に具材を加え、炊飯のスイッチを入れる。炊き上がったらご飯を混ぜ、完成。", recipe_id: 4 },
{ body: "下準備が必要な具材は先に済ませておきます。（油揚げ、こんにゃく等）", recipe_id: 5 },
{ body: "具材は好みの大きさに切り、肉以外の具材を炒めます。", recipe_id: 5 },
{ body: "全体に火が通ったら水を入れ、中火のまま沸騰するまで加熱します。", recipe_id: 5 },
{ body: "お肉を入れ、中火でひと煮立ちするまで加熱し、アクを取り除きます。", recipe_id: 5 },
{ body: "和風だしと酒を加え、全体に火が通るまで中火で加熱します。", recipe_id: 5 },
{ body: "火を止めて味噌を溶かし入れ、醤油を入れます。", recipe_id: 5 },
{ body: "ふたたび中火で加熱し、沸騰直前まで温めたら火から下ろし、器に盛り付けて完成です。", recipe_id: 5 },
{ body: "さつまいもの皮を剥き、1㎝角くらいの棒状に切ります。5分ほど水にさらしてあく抜きします。", recipe_id: 6 },
{ body: "耐熱容器に入れてラップをかけ、レンジで1分ほど温めます。", recipe_id: 6 },
{ body: "アルミホイルにおいも、バター、砂糖を入れて、フライパンで中火で包み焼き♪", recipe_id: 6 },
{ body: "バターが溶けてさつまいもに軽く焦げ目がつくまで待ち、完成です！", recipe_id: 6 },
{ body: "(下準備)かぼちゃの種とワタをスプーンで取っておきます。", recipe_id: 7 },
{ body: "玉ねぎを薄切りにし、ボウルに入れて塩をふって、10分ほどおいたら、絞って水気を切ります。", recipe_id: 7 },
{ body: "かぼちゃの皮をそぎ落とし、耐熱ボウルに入れてラップをし、600Wの電子レンジで5分加熱します。", recipe_id: 7 },
{ body: "熱いうちにマッシャーで潰し、2と(A)を入れて混ぜ合わせます。お皿に盛り付け、完成！", recipe_id: 7 },
{ body: "エリンギは石づきを切り落とし、縦6等分に切ります。", recipe_id: 8 },
{ body: "豚バラ肉に手順1をのせて巻き、全体に片栗粉をまぶします。", recipe_id: 8 },
{ body: "中火で熱したフライパンにごま油をひき、手順2の巻き終わりを下にして3分焼きます。豚バラ肉に火が通るまで、転がしながら炒めます。", recipe_id: 8 },
{ body: "全体に焼き色がついたら余分な油をふき取り、(A)を入れ、煮絡めたら火からおろして完成です。", recipe_id: 8 },
{ body: "食材を好みの大きさに切る", recipe_id: 9 },
{ body: "鍋にスープの材料を全て入れて中火で煮立てる。具材を加えて中火で煮立てたら蓋をし、野菜が柔らかくなるまで加熱する。", recipe_id: 9 },
{ body: "ひと煮立ちさせたら、ごま油を加えて完成。", recipe_id: 9 }
]

procedures_data.each do |data|
procedure = Procedure.find_by(data.slice(:recipe_id, :body))
Procedure.create!(data) unless procedure
end