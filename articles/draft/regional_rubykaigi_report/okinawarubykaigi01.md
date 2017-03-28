##はじめに

沖縄で毎週開催されている Okinawa.rb の発起人である @yasulab さんが中心となって、沖縄初の「沖縄Ruby会議01」が開催されました。

### 開催日

2013年3月1日 13:00-18:00

### 開催場所

琉球大学 工学部１号館 大教室 322 (本会場) & 321 (サテライト会場)


### 主催

![okinawarb-logo](okinawarubykaigi01/okinawarb-logo.png)

![ryudairb-logo](okinawarubykaigi01/ryudairb-logo.png)

![ryukyurb-logo](okinawarubykaigi01/ryukyurb-logo.png)


### 協力

日本Rubyの会、ギークハウス沖縄、株式会社レキサス、特定非営利活動法人軽量Rubyフォーラム、ウェブペイ株式会社

### 公式タグ・Twitter

\#okrk01

* [沖縄Ruby会議のtweetまとめ](http://togetter.com/li/636273)

## Lightning Talks 1 + Sponsored Session (各10分)

### 「Rubyによるバッチ業務のストリーム処理化の設計と実装」@bash0C

* 発表者
    * [@bash0C7](https://twitter.com/bash0C7)
* 資料
    * [Rubyによるバッチ業務のストリーム処理化の設計と実装](https://speakerdeck.com/bash0c7/design-and-implement-batch-stream-processing-application-for-ruby)

ログ収集ツールとして注目される[fluentd](http://fluentd.org)を使いストリームにバッチ業務を処理する手法を紹介して頂きました。
通常はログ収集のみにつかわれることが多いfluentdですが、入出力のプラグインを自作することで解析されたwebストリームを受けて進捗確認のツールとして使用することが出来るそうです。
プラグインは[RubyGem](https://www.ruby-lang.org/ja/libraries/)の形式で導入することが出来るため、手軽に機能を追加する出来るということをおっしゃていました。  

### 「Emacsの普通の使い方」@libkinjo

* 発表者
    * [@libkinjo](https://twitter.com/libkinjo)
* 資料
    * [Emacsの普通の使い方](http://kinjo.github.io/okrk01/#/title)

Rubyにはirbやpryを使って対話式にプログラムを記述することが出来ますが、libkinjoさんはEmacsのscratchバッファでeLispと対話するようにRubyとも対話したいと考えました。
comint.elとinf-ruby.elを使いEmacsバッファ内でRubyのコードを実行し結果を受け取るデモを実際に動かして頂きました。
また「scratchバッファはEmacsと対話する聖域（サンクチュアリ）」や「Emacsはロマンの積み木」などカッコいい名言で会場を盛り上げて頂きました。  

###「RyukyuFrogsとLexues Academyの話」株式会社レキサス

* 発表者
    * 山崎さん[株式会社レキサス](http://lexues.co.jp)

沖縄県内の学生を育成するプロジェクト[RyukyuFrogs](http://www.ryukyu-frogs.com)と[Lexues Academy](http://academy.lexues.co.jp)の紹介でした。

## 沖縄県内のコミュニティ活動の紹介

動画: [県内コミュニティ活動の紹介 (各3分〜5分)](http://www.ustream.tv/recorded/44349362)

沖縄のRubyコミュニティだけでなく、県内で活動するコミュニティ紹介のLTも行いました。
ものづくりのコミュニティから、エンジニアの集うシェアハウスまでの計5つのコミュニティの発表を行いました

### Ryukyu Rubyist Rookies
[@repserc](https://twitter.com/repserc)さんによる[Ryukyu Rubyist Rookies](https://www.facebook.com/groups/ruby.okinawa/)の紹介でした。(発表資料: [Ryukyu Rubyist Rookies 紹介 @ 沖縄Ruby会議01](http://www.slideshare.net/repserc/ryukyu-rubyist-rookies))

「最終的な目標として"Good bye blue monday"、月曜日をRubyで楽しく過ごして行きましょう!」とおっしゃっていたのが印象的でした。
Rubyの初心者、プログラミング初心者が多いのが特徴で、「ベーマガ/Cマガみたいなお題をつくっていきたい」「初心者から中級者へ」と互いに教えあっている様子を紹介してくださいました。

後日、[沖縄Ruby会議で発表できなかったこと](http://repserc.hatenablog.com/entry/2014/03/04/164535)を教えていただきました。

### Ryudai.rb
[@_simanman](https://twitter.com/_simanman)さんによる[ryudai.rb](http://lingr.com/room/ryudairb)の紹介でした。

沖縄Ruby会議01の日がちょうど設立1周年。コミュニティの維持についての悩みを話していました。

### Okinawa.rb
[@yasulab](https://twitter.com/yasulab)さんによる[Okinawa.rb](https://www.facebook.com/groups/okinawarb/)の紹介でした。

毎週水曜日の夜、ギークハウス沖縄で行われているWeekly Meetupの様子と、ハッカソン、台風そん(台風の暴風域に入ってから抜けるまでの間行われているハッカソン、基本的に家で一人で行うのでエクストリーム・ボッチソンともいう)の様子を紹介していただきました。

Okinawa.rbでは毎週水曜日Weekly Meetupを開催しているので、沖縄へお越しの際はぜひご参加ください :) (参考: [那覇空港からギークハウス沖縄までの行き方](https://speakerdeck.com/yasulab/na-ba-kong-gang-karagikuhausuchong-nawa-madefalsexing-kifang))

### ハッカーズチャンプルー
沖縄県内IT系コミュニティの夏祭り、ハッカーズチャンプルーについて、[@k_nishijima](https://twitter.com/k_nishijima)さんに発表&告知して頂きました。(発表資料: [20140301ハッカーズチャンプルー告知lt](http://www.slideshare.net/KoichiroNishijima/20140301lt)、ブログ: [K Nishijimaのぶろぐ: 沖縄Ruby会議とMusic Atlas 2014に行ってきました](http://k-nishijima.blogspot.jp/2014/03/rubymusic-atlas-2014.html))

その場でMatzさん、増井さんに「また沖縄きたいですか?どうですか!?」と呼びかけ、OK(仮)をもらって盛り上がっていました。
ハッカーズチャンプルーは今年(2014年)7/18〜7/19に開催されるようです。

### gFab
又吉さんから、ものづくりコミュニティgFabの紹介でした。
楽しく作るデジタルファブリケーションの場、ということで、台風で吹き飛ばされてしまった看板を作りなおしたご自身の体験などを紹介していました。
「メーカーブームに乗ってレーザーカッターや、3Dプリンター買っちゃった、どうしよう」と困っているかたは、gFabのようなコミュニティをはじめてみると面白くなるかもしれませんね!

## ギークハウス沖縄 @kimihito_

* 発表者
    * [@kimihito_](https://twitter.com/kimihito_)
* 資料
    * [ギークハウス沖縄](https://speakerdeck.com/kimihito_/gikuhausuchong-nawa-in-chong-nawa-rubyhui-yi-01)

![geeoki](okinawarubykaigi01/geeoki.jpg)

エンジニアやインターネット好きが集うシェアハウスである[ギークハウス](http://geekhouse.tumblr.com/)の中でも日本最南端である、[ギークハウス沖縄](http://text.geeoki.com/)の活動のお話していただきました。Okinawa.rbの毎週のMeetupの会場になっていたり、Rubyでロボットの操作ができるフレームワークである[Artoo](http://artoo.io/)を使ってRubyでARDroneを飛ばしたりなど、部室のような空気が残るギークハウス沖縄の紹介でした。


## 「rcairoでものづくり」@mgwsuzuki

* 発表者
    * [@mgwsuzuki](https://twitter.com/mgwsuzuki)
* 資料
    * [rcairoでものづくり](http://www.slideshare.net/mgwsuzuki/ruby-kaigi-rcairo)

![rcairo](okinawarubykaigi01/rcairo.jpg)

2Dグラフィックス用のCライブラリである[cairo](http://cairographics.org/)をRubyでバインディングした[rcairo](https://github.com/rcairo/rcairo)を使って、自動設計するプログラムをRubyで作成、1時間20分ほどで完成することができたそうです。今後はGithubに自動設計のプログラム公開し、パラメータをPull Requestすることで簡単にハコを作れるようにしたいということをおっしゃっていました。


## 「きたのくにからこんにちぬー！」

* 発表者
    * [@PUPRL](https://twitter.com/PUPRL)
* 資料
    * [きたのくにからこんにちぬー](http://www.slideshare.net/AsamiImazu/okrk01-kitanokunikarakonnnichinu)

![nuruby](okinawarubykaigi01/nuruby.jpg)

北海道からお越しの[@PUPRL](https://twitter.com/PUPRL)さんは、「和室でぬるくRubyをもくもくする」[ぬRuby](http://nuruby.org/)という活動の紹介の地域Rubyに参加することの良さについて語ってくださいました。はじめてのLTであったにも関わらず、ぬRubyの魅力がしっかり伝わったようで、LT後にはぬRubyに参加したいとの言葉をたくさん見受けることができました。
