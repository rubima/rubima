# RegionalRubyKaigiレポート 川崎Ruby会議01


* 開催日時 -- 2016年8月20日(土) 13:00-17:00
* 開催場所 -- 川崎市教育文化会館 4F 第1・2・3学習室
* 主催 -- kawasaki.rb
* 参加者 -- およそ70名
* 公式サイト -- [http://regional.rubykaigi.org/kwsk01/](http://regional.rubykaigi.org/kwsk01/)
* 公式ハッシュタグ -- `#kwsk01`
* Togetterまとめ -- [http://togetter.com/li/1014759](http://togetter.com/li/1014759)


# はじめに


2016年8月20日に川崎Ruby会議01を開催しましたので、その様子についてレポートします。


川崎Ruby会議01を主催するkawasaki.rbは、川崎で2013年から活動を続けている地域Rubyコミュニティです。
毎月1回のペースで勉強会を開催しており、川崎Ruby会議01まで過去38回の勉強会を開催してきました。


川崎Ruby会議01のコンセプトは「kwsk(かわさき)バザー」です。
日頃のkawasaki.rbの多様な活動を参加者の皆様にご覧いただくことを目的に、
基調講演、kawasaki.rbのメンバによる発表、LTを行いました。


* [基調講演「Ruby で高速なプログラムを書く」 from 遠藤侑介](#keynote)  
* 発表
  * [「mruby を C# に組み込んでみる」 from 秋山 亮介](#presentation1)
  * [「Rubyistを誘うScalaの世界 ver 2.0」 from ぺら](#presentation2)
  * [「RubyでRoombaをハックする」 from kon_yu](#presentation3)
  * [「Fat settings.ymlと向き合う」 from 1syo](#presentation4)
  * [「この1年くらいのRuby力の伸長状況」 from 蓑島 慎一](#presentation5)
  * [「Railsエンジニアがサーバーレスアーキテクチャに手を出したよ」 from 清水 雄太](#presentation6)
* LT
  * [「Big Data Baseball with Python」 from shinyorke(シンヨーク)](#lt1)
  * [「並行プログラミングと魔法の薬」 from 笹田耕一](#lt2)
  * [「７カ国をさすらうグローバルなお仕事顛末記(仮題)」 from kishima](#lt3)
  * [「浮動小数点数での分散の求め方」 from 村田賢太](#lt4)


# <a name="keynote">基調講演「Ruby で高速なプログラムを書く」 from 遠藤侑介</a>

![Photo keynote](keynote.jpg)

[GitHub](https://github.com/mame)
[Twitter](https://twitter.com/mametter)
[動画](https://www.youtube.com/watch?v=NHXaH3pkk-M&index=1&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K)
[スライド](http://www.slideshare.net/mametter/ruby-65182128)


まめさん（遠藤侑介さん）による基調講演は「Rubyで高速なプログラムを書く」でした。
内容はなんとRubyでファミコンエミュレータを実装したというもの。
東京Ruby会議でも同様の発表がありましたが今回は完全版とのことです。


実装した理由の一つとして、
Ruby3で3倍の実行速度を目指すRuby3x3というスローガンがありますが、
これに向けてベンチマークとなるようなプログラムを作ったとのことでした。


前半はファミコンのアーキテクチャとそれをどのようにRuby上のプログラムに置き換えていったかというお話、
後半はそれらをどのように最適化していったかというお話が中心でした。


中でも最適化の四か条という話はチューニングするプログラマすべてが見て損はない内容だと思います。
詳しくは発表の動画を見ていただきたいと思いますが、項目だけ抜粋します。


1. 目標値を設定せよ
2. ボトルネックをいじれ
3. アルゴリズム最適化を考えよ
4. 効果を検証せよ


どれも、きちんと計画建てた上で実証的にチューニングを進めていくことが重要だという内容で、
大変参考になりました。


また、あえてRubyでエミュレータを書いた理由として、
Rubyが遅くないというアピールや、
一つの言語にこだわって書くことのメリットをあげておられました。
まめさん曰く、多言語を勉強しなくてもよいというわけではないが、
広く浅くでは見えてこないものもあるとのこと。


確かに実際にエミュレータの高速化の事例を見せていただくと
言語を使い分けるより前に、
まずアルゴリズムの習熟やプロファイリングが重要だということがよくわかりました。


この基調講演を聞かせていただいて、
スタッフとして以前に一参加者としてすごくドキドキしたことを覚えています。
ディープな内容ながら初心者にも非常に参考になる内容で、
川崎Ruby会議のテーマにもぴったりの素晴らしい講演でした。




# 発表


普段からkawasaki.rbに参加しているメンバー6名が発表を行いました。


## <a name="presentation1">「mruby を C# に組み込んでみる」 from 秋山 亮介</a>

![Photo presentation1](presentation1.jpg)

[Twitter](https://twitter.com/kechako)
[動画](https://www.youtube.com/watch?v=GpEru8yI4cI&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K&index=2)
[スライド](http://www.slideshare.net/kechako/mruby-c)


秋山さんはkawasaki.rbのC#要員と言える方です。
今回はmrubyにC#を組み込む、という刺激的なタイトルで発表いただきました。




発表では、C#(.NET Framework)と組み込み用のRubyであるmrubyの仕組み、C++/CLIでmrubyのラッパを作ればC#にmrubyを組み込むことができることに続き、秋山さんが開発された[csharp-mruby](https://github.com/kechako/csharp-mruby)の概要を説明いただきました。


発表での宣言どおり9月に開催した[kawasaki.rb #40](https://medium.com/kawasakirb/kawasaki-rb-040%E3%82%92%E9%96%8B%E5%82%AC%E3%81%97%E3%81%BE%E3%81%97%E3%81%9F-kwskrb-22f9086bb76#.7ya1l8384)で、C#とmrubyで相互にメソッドの呼び出を行うデモを披露いただきました。


将来、秋山さんのcsharp-mrubyが完成すれば、C#から簡単にRubyが使えるようになる日が来るのかも知れません。


## <a name="presentation2">「Rubyistを誘うScalaの世界 ver 2.0」 from ぺら</a>

![Photo presentation2](presentation2.jpg)

[Twitter](https://twitter.com/Peranikov)
[動画](https://www.youtube.com/watch?v=GQCiJ-LF0p0&index=3&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K)
[スライド](http://www.slideshare.net/yutomatsukubo/rubyistscala-20-65178203)


ぺらさんからはプログラミング言語「Scala」の紹介をしていただきました。


川崎Ruby会議01では、発表テーマを募集する際、
Rubyistに向けた内容であればRuby言語にこだわらず自由にやろうと決めていました。
ぺらさんの発表も、テーマはScala言語ですが
Rubyist向けに親しみやすく解説していただけました。


Rubyと異なり静的型付け言語のScalaですが柔軟な型システムを持っており、
なるべく型を見せないような書き方ができることをアピールされていました。


また値はすべてオブジェクトであったり、豊富なリスト操作のメソッドを持ったりするなど、
Rubyとの共通点を多く紹介していただきました。


特に驚いたのが、
Rubyのオープンクラスと似たようなことをScalaの機能で実装できるという内容でした。


Rubyを主に使っているプログラマからすると、
静的型付け言語というのはときに制約が多く不便ではないかという先入観があったりしますが、
発表を見て、少なくともScalaはそれに当てはまらない非常に柔軟な言語であるという認識を強くしました。


## <a name="presentation3">「RubyでRoombaをハックする」 from kon_yu</a>

![Photo presentation3](presentation3.jpg)

[Twitter](https://twitter.com/kon_yu)
[動画](https://www.youtube.com/watch?v=6-YBuQ8n1OE&index=4&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K)
[スライド](http://www.slideshare.net/kon_yu/rubyroomba)


kon_yuさんからは
Webカメラを搭載したRoombaを遠隔操作するシステムを完成させるまでの過程を発表いただきました。
家に居る2匹の愛猫の様子を仕事や旅行の間に確認したいという動機で、このシステムの開発を始められたそうです。


Roombaがシリアル通信で制御できることに注目し、RoombaにWebカメラと制御用のRaspberry PIを搭載。
自作のRuby on Railsアプリケーションを通じて、
iPhoneのブラウザからRoombaを遠隔操作するシステムを完成させておられました。


[Roombaを遠隔操作して家の猫を追いかけるデモ動画](https://www.youtube.com/watch?v=NQ9qcvOxfJk)が上映されると、
Roombaをいぶかしむ猫のかわいさも手伝って、会場が笑いに包まれていました。


## <a name="presentation4">「Fat settings.ymlと向き合う」 from 1syo</a>

![Photo presentation4](presentation4.jpg)

[GitHub](https://github.com/1syo)
[動画](https://www.youtube.com/watch?v=FkEOuk0LJS4)
[スライド](https://speakerdeck.com/1syo/fat-settings-yml)


1syoさんからはRuby on Railsにおける設定ファイル管理の課題について発表していただきました。
config/settings.ymlの運用方法の一つとして、
ファイルの内容にAPIのキーなど機密情報が含まれるため、あえてコミットしないというやり方があるそうですが、
設定項目が増えてくると、項目の追加、変更漏れ、Rails.envの環境数の増加などの問題が出てきたとのことです。


1syoさんはこういった問題に対し、
設定ファイルを分割して管理しやすくしたり、
機密情報は環境変数から取りその他の設定はコミットしたりするなど、
一つ一つ対処法を提案されていました。


設定ファイルの運用法というのは地味ですが皆が悩むところです。
この問題についてかなり実践的な発表をしていただき、
特にRailsを運用しているエンジニアにとって大いに参考になったのではないかと思います。


## <a name="presentation5">「この1年くらいのRuby力の伸長状況」 from 蓑島 慎一</a>

![Photo presentation5](presentation5.jpg)

[Twitter](https://twitter.com/rojiuratech)
[動画](https://www.youtube.com/watch?v=gxLgNnWlMrI&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K&index=5)
[スライド](https://speakerdeck.com/rojiuratech/kawasaki-rubykaigi-slide)


蓑島さんはkawasaki.rbに積極的に参加いただいているメンバーです。
プログラミングに携わるエンジニアが1人しか居ない職場で日々奮闘されています。


ハッカソンで参加チームのほとんどがRuby on Railsを使っていたことに刺激を受け、Ruby on Railsのブートキャンプに参加したこと。
Ruby on Railsを触って得た知見を、仕事で活用したエピソードなどを紹介いただきました。


プログラミング言語やフレームワークによらず、良い設計でシステムを作ることの大切さを、ご自身の経験から一人称で語っておられました。


Web系の会社でRubyを使った開発をするのとは異なる生々しい内容で、会場がわきました。
kawasaki.rbの多様性を参加者の皆様にもご理解いただけたと思います。


## <a name="presentation6">「Railsエンジニアがサーバーレスアーキテクチャに手を出したよ」 from 清水 雄太</a>

![Photo presentation6](presentation6.jpg)

[Twitter](https://twitter.com/pachirel)
[動画](https://www.youtube.com/watch?v=6xurzhDR2Vs&index=6&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K)
[スライド](http://www.slideshare.net/YutaShimizu1/rails-ruby01)


清水さんからはサーバレス・アーキテクチャについて発表していただきました。
AWS Lambdaを例に実際にどのような構成で動いているかの紹介や、
Lambdaで社内の経費申請などのワークフローを処理するBOTを実装した話をしていただきました。
Slackのフック機能と、Amazon API Gatewayを組み合わせて、
Slack上に投げられた申請や承認をLambdaで処理できる仕組みを作ったそうです。


今話題のサーバーレス・アーキテクチャですが親しみやすい語り口で、
とてもわかりやすく解説していただけました。


発表を聞いて、清水さんの解説が分かりやすかったこともありますが、
思ったよりシンプルで扱いやすいアーキテクチャではないかと感じました。
今後小さな機能を実装する際にLambdaのようなサービスを利用する事例が増えていくのではないかと思います。


# LT(Lightning Talks)


事前募集で先着当選した4名の方がLTを行いました。
4名のうち2名がRubyコミッタという豪華なLTとなりました。


## <a name="lt1">「Big Data Baseball with Python」 from shinyorke(シンヨーク)</a>


[Twitter](https://twitter.com/shinyorke)
[GitHub](https://github.com/Shinichi-Nakagawa)
[動画](https://www.youtube.com/watch?v=NoH-_dIJo2E&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K&index=7)
[スライド](http://www.slideshare.net/shinyorke/big-data-baseball-with-python-ichiro-suzuki-hacks-kwsk01)
[動画](https://www.youtube.com/watch?v=OcdxLTzOnA8&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K&index=8)


shinyokeさんは野球のビッグデータを主にPythonを使用して分析されています。
kawasaki.rbでもその情熱的な分析結果を発表いただいてきました。


今回のLTでは、MLB一球速報のデータをJupyter + matplotlibで可視化し、イチローが直球に強いという分析を紹介していました。
LTの完全版は、[Pycon JP 2016](https://pycon.jp/2016/ja/schedule/presentation/75/)で発表されました。


## <a name="lt2">「並行プログラミングと魔法の薬」 from 笹田耕一</a>


[GitHub](https://github.com/kishima)
[Twitter](https://twitter.com/kishima)
[動画](https://www.youtube.com/watch?v=OcdxLTzOnA8&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K&index=8)


Rubyコミッタの笹田さんのLTは並行プログラミングがテーマでした。


Rubyや他のプログラミング言語が取り入れている並行プログラミングの仕組みを比較し、
Elixirの並行プログラミングの仕組みが他の言語の良いとこどりであることを説明。
ご自身の翻訳された「プログラミングElixir」を紹介いただきました。


コミッタさえRuby以外の言語の話をするという点で、kawasaki.rbの文化を象徴するLTでした。


## <a name="lt3">「７カ国をさすらうグローバルなお仕事顛末記(仮題)」 from kishima</a>


[GitHub](https://github.com/kishima)
[Twitter](https://twitter.com/kishima)


kishimaさんには、ご自身の海外の仕事の経験を紹介いただきました。
地域Ruby会議という性質上、テッキーな発表が多い中、働き方・考え方に踏み込んだLTに会場も聞き入っていました。


## <a name="lt4">「浮動小数点数での分散の求め方」 from 村田賢太</a>


[GitHub](https://github.com/mrkn)
[Twitter](https://twitter.com/mrkn)
[動画](https://www.youtube.com/watch?v=GX3iSiDuFss&index=9&list=PLFhrObr2eyduqJ6OgK0SXxWC6SE-3MJ7K)
[スライド](https://speakerdeck.com/mrkn/how-to-calculate-a-variance-of-floating-point-numbers)


村田さんはRubyコミッタとしてBigDecimalの開発に携わっておられます。


LTの内容は、統計要約量を求めるメソッドを提供するenumerable-statistics.gemについてです。
このgemの分散を高速に計算する処理について、数学的な背景とアルゴリズムを説明いただきました。
最後は"enumerable-statistics.gemを作ったのでみなさん使って下さい!"とLTを締めくくりました。


# まとめ


Rubyを中心としつつも他の言語・数学・ハードウェア・働き方まで多岐にわたる、盛りだくさんな地域Ruby会議となりました。
kawasaki.rbの日頃の活動をご覧いただくという「kwskバザー」のコンセプトを良い形で実現できたと思います。
川崎Ruby会議01をきっかけに、より多くの方にkawasaki.rbに足を運んでいただければ幸いです。


# 謝辞


川崎Ruby会議01のスポンサーとして素敵なTシャツを提供いただいた[株式会社spice life](http://spicelife.jp/)様、
そして川崎Ruby会議01の成功に向けてご助力いただいた皆様に、実行委員一同感謝いたします。


# 著者について


* 徳田農(@snowcrush) -- プログラマ。Ruby好きですがお仕事ではGo言語も書いていたり。
* 近藤悠太郎 -- 趣味でRubyを書いています。kawasaki.rbには2014年から参加。
