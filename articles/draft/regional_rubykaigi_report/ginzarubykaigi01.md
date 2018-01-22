# RegionalRubyKaigi レポート (NN) ぎんざ Ruby 会議 01

## RegionalRubyKaigi レポート ぎんざ Ruby 会議 01

- 開催日時 -- 2017 年 8 月 5 日 (土) 13:00-18:00
- 開催場所 -- 株式会社 みんなのウェディング 会議室
- 主催 -- Ginza.rb
- 参加者 -- およそ 80 名
- 公式サイト -- [https://ginzarb.github.io/kaigi01/](https://ginzarb.github.io/kaigi01/)
- 公式ハッシュタグ -- #ginzarb (通常ミートアップと同一)

## はじめに

Ginza.rb は 2013 年 6 月に発足し、毎月第 3 火曜日にミートアップを開催しています。 2017 年 8 月に 50 回目のミートアップを迎える事を記念して、 ぎんざ Ruby 会議 01 が開催されました。その様子についてレポートします。

## 開会挨拶

[[ken1flan.jpg]]

いつもミートアップ告知ページで愛嬌のある猫のイラストを書かれている ([@ken1flan](https://github.com/ken1flan)) さんによると、 Ruby on Rails 4 が出る頃に、ランチで話をしている間に「Rails 4 を勉強しなきゃね」という話題になり、 Ginza.rb が始まったそうです。Ruby on Rails 周辺の話題が多く聞けるミートアップという印象がありましたが、その理由を知ることができました。

## 基調講演「Rails コミュニティの話」 from 松田 明 ([@a_matsuda](https://github.com/amatsuda))

[[a_matsuda.jpg]]

Ruby と Rails 両方のコミッターである松田さんから「 Ginza.rb というコミュニティが Rails 4.0 以降に始まったので、それ以前の Rails のコミュニティについて、語ろうかな」と話されました。

Ruby on Rails のトップページ ( [http://rubyonrails.org/](http://rubyonrails.org/) には、メニューからは飛べないリンクがあるそうです。そのページ ([http://rubyonrails.org/community/](http://rubyonrails.org/community/)) によると Rails コミュニティとは、 Ruby on Rails ユーザではなく、 Ruby on Rails 開発者のことを指すそうです。Rails コミュニティは以下の 3 つの役割ごとにチームに分かれているそうです。

- Committers チーム
- GitHub のプルリクエストや Issue に一次対応する Issue チーム
- Rails Guides を扱う docrails チーム

また、 Rails コミュニティには卒業制度があり、開発を離れた人は The Alumni となり、 Rails コミュニティ自体も健全に新陳代謝しているそうです。こういったドキュメントを整備してメンテナンスしているのは Ruby 開発者コミュニティにはない特徴だそうです。

Rails にコミットを残すと名前が載る、[Rails Contributors](http://contributors.rubyonrails.org/) があります。このサイト自身も OSS になっているため、松田さんは、今回の講演のためにパッチを当てて、各バージョンごとに活躍した開発者のコミットを集計したそうです。集計結果をメジャーバージョンごとに見ていきながら、

- 当時活躍したコミッタの担当範囲や、人柄
- 当時新しく入った機能や消えた機能
- 当時の技術トレンド

などについて松田さんの視点で語られました。講演の最後に、「人を知ると、プロダクトの見え方や GitHub 上での SNS 活動のリアリティが変わります。日本にいても Rails のコミュニティには会えません。海外に出ていきましょう。」との言葉で締められました。

## 発表

### 「ActiveSupport::Multibyte::Unicode::UnicodeDatabase を消したかった」 from 松島 史秋  ([@mtsmfm](https://github.com/mtsmfm))

[[mtsmfm.jpg]]

[資料](https://speakerdeck.com/mtsmfm/remove-as-mb-unicode-unicodedatabase)

Rails を使っている方は Rails で 1 番大きなファイルが何かご存知でしょうか？ 松島さんによると、Unicode正規化処理のモジュール (ActiveSupport::Multibyte::Unicode::UnicodeDatabase) が使用している (unicode_tables.dat) だそうです。

ちょうど直前に基調講演をされた松田さんの Rails Conf 2016 での[講演資料](https://speakerdeck.com/a_matsuda/3x-rails) をヒントに、 Unicode 正規化について理解を深めながら、前述の処理を Ruby 本体のメソッドで置き換えていき、この巨大ファイルを使った処理を削減する挑戦について発表されました。最終的に Rails 本体に送ったプルリクエスト [#26743](https://github.com/rails/rails/pull/26743) ですが、 Rails 5 がサポートする Ruby のバージョンが比較的古いために、マージすることができないそうです。Rails 6.0 でマージされるのを楽しみにしたいと思います。

### 「マイクロサービス指向 Rails API 開発ガイド」 from 森 久太郎 ([@qsona](https://github.com/qsona))

[[qsona.jpg]]

[資料](https://speakerdeck.com/qsona/building-rails-api-on-microservices)

森さんは、勤務先の会社のビジネス上、 Web API や マイクロサービスを大事にして開発されているそうです。Web API でよくある失敗を避けるために「強いリソース指向」というものを取り決めて開発しているということでした。強いリソース指向で定義したリソースを BFF (Backends For Frontend) でまとめあげる例が、実際に開発したスマートフォンアプリの画面で示されていました。 UI の柔軟さに対応するためにもドメインモデルの考察が重要だということでした。そして、 Rails で実装する詳細について話されました。

### 「Rails を仕事にする会社で新卒が1年間学んだこと」 from 小林 純一 ([@junk0612](https://github.com/junk0612))

[[junk0612.jpg]]

[資料](https://speakerdeck.com/junk0612/railswoshi-shi-nisuruhui-she-dexin-zu-ga1nian-jian-xue-ndakoto)

新卒の立場から、どんなことを学び、考えてきたのかを情報共有したい、という趣旨で以下のトピックについて話されました。

- Ruby の面白さ
- Rails に早く乗るには
- Pull Request で考えておくといいこと
- Git でコード外の意図を伝える

この発表は、前月に行われたイベント [Rails Developers Meetup #3](https://rails-developers-meetup.connpass.com/event/60765/) で発表された、勤務先の先輩である伊藤浩一さんの発表([資料](https://www.slideshare.net/koic/stairway-to-the-pragmatic-rails-programmer)) と対をなすそうです。プルリクエストのレビューで同じ指摘をされないために、プルリクエストを出す前にチームメンバーになりきってレビューしてみたり、自分の性格を考慮して詳細が伝わるコミットを書く習慣づけをしたりといった工夫をされているそうです。新人エンジニアでなくとも役立ちそうでした。

### 「Spring Framework と比較して学ぶ、Web アプリケーションフレームワークの責務分担」 from 鈴木 雄大 ([@onigra](https://github.com/onigra))

[[onigra.jpg]]

[資料](https://speakerdeck.com/onigra/ginza-ruby-kaigi-01)

Ruby on Rails という Webアプリケーションフレームワークには、批判が割りと多いそうです。鈴木さんは、現在お勤めの会社に転職後、 Java + Spring Framework (Spring Boot) に触れたことから、 Spring Framework との比較を通して、 Ruby on Rails への批判の内容を理解しようという発表をされました。2 つのフレームの機能を比較していくと、Rails はユースケースを絞って割り切った設計をしていて、マッチしないビジネス要件にはつらみが出ることもあるそうです。一方、 Spring Framework は、はじめから広いユースケースに対応するように設計されているため、複雑なビジネス要件や長期的な拡張性を考慮したユースケースに適しているが、その分、あらかじめ理解しなくてはいけないことも多いそうです。最後に、「どちらが優れていると優劣をつけるのではなく、フレームワークやアーキテクチャの思想とユースケースを理解して、適切な技術選定をしましょう」と締められました。

### 「Railsアプリケーションのパフォーマンス改善手法」 from 国分 崇志 ([@k0kubun](https://github.com/k0kubun))

[[k0kubun.jpg]]

[資料](https://speakerdeck.com/k0kubun/number-ginzarb)

テンプレートエンジンの高速化などで、 Rails を使う人ならきっと恩恵を受けているであろう、国分さんから以下について話されました。

- パフォーマンス改善の失敗パターン、原因分析と対策
- 各種プロファイリングツールの仕組みとメリット・デメリット
- 実際にコードレビューで見た非効率なコードとその改善例

文字列操作やメソッド呼び出しのバイパスなど、テンプレートエンジンの高速化を手がける国分さんならではと思わされるトピックも多くありました。パフォーマンス改善は、計測自体がとても難しいことがあるというのが印象的でした。プロファイラの使い方などをどうやって調べたり、憶えていくのかと疑問に思った著者が発表後に個人的にお話を伺ったところ、憶えていられないのでラッパーのスクリプトやコマンドを書いていて、その時に覚えてしまったり、覚える必要がなくしてしまうという回答をいただきました。

## LT Time

以下の豪華メンバーによる LT が行われました。

- 「Application Templateのススメ」 from [@onk](https://github.com/onk) さん
  - [資料](https://www.slideshare.net/takafumionaka/applicationtemplate)
- 「Railsフロントエンドの modernizeにおける一事例 ~ decaffeinateからES2015移行まで ~」 from [@treby](https://github.com/treby) さん
  - [資料](https://www.slideshare.net/treby/rails-modernize-decaffeinatees2015)
- 「歴史あるPHPアプリケーションのジョブキューシステムのリプレース」 from [@hypermkt](https://github.com/hypermkt) さん
  - [資料](https://speakerdeck.com/hypermkt/replace-for-historic-job-queue-system) さん
- サービス中断を伴うメンテナンスを極力避けてゲームの運用をしている話 by [@tkeo](https://github.com/tkeo) さん
- 似非サービスクラスの殺し方 from [@joker1007](https://github.com/joker1007) さん
  - [資料](https://speakerdeck.com/joker1007/number-ginzarb) さん

## 基調Q&A from 上薗 竜太 ([@kamipo](https://github.com/kamipo))

[[kamipo_and_willnet.jpg]]

上薗さん (左) と聞き手の前島さん ([@willnet](https://github.com/willnet)) (右)

Rails の ActiveRecord ライブラリに数多くのコミットを残していることで有名な上薗さんが、 事前に集めた質問に答えていく形で、Q&Aが展開されました。思い出深い Rails へのプルリクエストからよく行く飲み屋までざっくばらんに回答されていました。

「active_record のコードを理解するためにおすすめの読み方、順序はあるでしょうか」という質問にたいしては、自分が修正をしたいかったコネクションプールのあたりから周辺を徐々に読んでいったので、自分の関心のあるところから読むとよいのではないかいうことでした。

思い出深いプルリクエストとして [#30000](https://github.com/rails/rails/pull/30000) が挙げられていました。キリがよいのは偶然ではなく、上薗さんは、自分が解決したい問題の認知を高めるために、GitHub のプルリクエストでキリ番を取るということを実践されているそうです。 active_record でクエリを生成する際に ID に巨大な数値を指定すると RangeError を上手くハンドリングできないという問題があります。上薗さんはこの問題を修正したプルリクエストを 30000 番にしようと、 29996 から 30000 まで 5 連続でプルリクエストを出されていて、会場では驚嘆の声が漏れていました。

普段から手元に数多くのコミットを作っておき、どの順番でプルリクエストを出せばレビュワーのコミッタが納得してマージしてくれるか、戦略を練るそうです。 Rails には Cosmetic Changes のプルリクエストは受け付けないというポリシーがありますが、「 trailing space (行末のスペース) を消す Cosmetic Changes をしたいがために、そのファイルを弄れる修正を考える」こともあるそうです。とてもすごい情熱です。その結果として、この会議の直後には Rails のコミッタに就任されました。

## 謝辞

以下の企業様にスポンサーして頂きました。ありがとうございました。(50音順)

- 株式会社永和システムマネジメント
- 株式会社ドリコム
- 株式会社みんなのウェディング

## スタッフ
- Organizers: [@ken1flan](https://github.com/ken1flan), [@willnet](https://github.com/willnet), [@y-yagi](https://github.com/y-yagi)
- Illustration: [@ken1flan](https://github.com/ken1flan)
- Design: [@ken_c_lo](https://github.com/ken_c_lo)

## 著者について

[@suginoy](https://github.com/suginoy) -- フリーランスで Web エンジニアを数年やっています。最近は Ruby on Rails を使ったサービスの開発に関わることが多いです。
