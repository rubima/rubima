最近gitやrubyなど、プログラミング関連のあれこれを教える機会が増えてきました。

今自分が一番使っているプログラミング言語は[Ruby](http://www.ruby-lang.org/)ですが、これをどうやって効率的に学習すればいいのかなぁということを考えてみました。

情報の入手の仕方なども盛り込んで、今後自力で使いこなしていくために必要そうなノウハウをなるべく盛り込んでみました。  
これからrubyを学ぼうという方の参考になれば幸いです。

また「これからプログラミングを覚えて何かWebアプリを作ってみたいけれど、とっかかりが見つからない。」という方にとっても何かしらきっかけを与えることができたなら幸いです。

**ご注意**

- 僕自身はWeb系のプログラマのため、そちらの分野に偏った内容となっています。
- この分野の情報はすぐに古くなります。1ヶ月後にはトレンドが全く変わってしまっている可能性がありますので、新しい情報を常に参照するように気をつけてください。(自戒をこめて)

#### 目次

- [開発環境の構築](#environment)
- [おすすめの学習方法](#howtostudy)
- [知っておくべきライブラリやフレームワークの軽い紹介](#libraries)
- [情報の入手方法](#information)
- [コミュニティ／勉強会](#communities)
- [まとめ](#conclusion)

<a id="#environment"></a>
#### 開発環境の構築

まずは開発できる環境を整えたいと思います。

ここでは執筆時点で最もモダンだと僕の考える方法で環境構築をしてみます。

##### マシンの準備

Windowsでも動きますが、Macユーザーが極端に多いです。特に初級者の場合は教えてくれる人がなるべく多い環境を選ぶ方がいいのでMacをおすすめします。

勉強会で大人気のMacBook Airですが、だいぶ安く買えるようになりました。  
ruby系の勉強会に行くと、参加者の9割はMacで、そのうち半数以上がAirということもざらです。

<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=223soft-22&o=9&p=8&l=as4&m=amazon&f=ifr&ref=ss_til&asins=B005DPEWNS" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>

ここから先はMac OS X 10.7 (Lion)の環境を対象にして進めてしまいます。

##### Xcode

rubyのコンパイルや、一部のライブラリのインストール時に必要になります。  
また、データベースなどの開発に必要なミドルウェアのインストールにも使われます。  
デフォルトでは入っていませんので、App StoreからXcodeをインストールしてください。（無料です。）

[App Storeへのリンク](http://itunes.apple.com/jp/app/xcode/id448457090?mt=12)

##### Homebrew

[Homebrew](http://mxcl.github.com/homebrew/)

パッケージ管理システムと呼ばれるソフトウェアの一つで、開発に必要なソフトウェアの管理に使います。

従来は[MacPorts](http://www.macports.org/)が主流だったのですが、今はかなり多くの開発者がHomebrewに移行しています。

ターミナルで以下のように打ち込むことでインストールできます。  

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

##### バージョン管理

rubyの場合、実質gitがデファクトスタンダードです。GitHub上で開発されているライブラリもたくさんありますし。

Lionの場合、Xcodeをインストールすれば一緒に入るはずです。

コマンドラインでの操作が苦手な方も、GUIのGitクライアントも増えてきましたので安心です。

- [SourceTree](http://www.sourcetreeapp.com/)
- [GitHub for Mac](http://mac.github.com/)
- [Tower](http://www.git-tower.com/)

あとは`git gui`とすると、GUIのクライアントが立ち上がると思います。

##### rubyのインストール

現在最新の安定版のrubyはバージョン1.9.2ですが、まだまだ1.8.7も多い状況です。OS Xに始めから入っているrubyも1.8.7です。  
これから何か新しいプログラムを書くのであれば、1.9.2で問題ないと思います。

ちなみにrubyのインタプリタ（ソースコードを解釈して実行してくれるプログラム）にはいくつかの種類があります。

- MRIまたはCRuby（特に何も指示や記載がなければほとんどこれを指す）
- [JRuby](http://jruby.org/)
- [Rubinius](http://rubini.us/)
- [Ruby Enterprise Edition](http://www.rubyenterpriseedition.com/)

特に理由が無ければMRIを入れておけば間違いないです。

rubyに限らず最近のスクリプト系言語(LL: Lightweight Languageと呼ばれたりする。perlとか、pythonとか、node.jsとか)の開発者の多くは複数のバージョンを切り替えて扱えるようなツールを使っています。

rubyで言うと、以下の2つが主流です。

- [rvm](http://beginrescueend.com/)
- [rbenv](https://github.com/sstephenson/rbenv) + [ruby-build](https://github.com/sstephenson/ruby-build)

最近人気が高まってきているのはrbenvの方ですが、まだまだユーザーはrvmの方が多いと思います。  
身近に教えてくれる人がいるのなら、その方に合わせてください。  
いないようなら、とりあえずはユーザーの多いrvmがいいと思います。

[RVM: Ruby Version Manager - Installing RVM](http://beginrescueend.com/rvm/install/) のページの"Single-User installations"の手順に従って作業をすれば、それだけでruby 1.9.2を使うモダンな環境が出来上がります。

またrbenv + ruby-buildは僕の個人的なおすすめです。こちらにチャレンジする方は以下のエントリーを参考にしてください。

[rbenv + ruby-buildのインストール方法](http://www.223soft.net/50)

##### エディタ

以下のものが人気が高いみたいです。自分に合ったエディタを探してください。

- [macvim-kaoriya](http://code.google.com/p/macvim-kaoriya/)
- emacs
- [TextMate](http://macromates.com/)
- [Sublime Text 2](http://www.sublimetext.com/2)
- [CotEditor](http://sourceforge.jp/projects/coteditor/)

##### サーバー

Webアプリケーションを作ったとして、それを動作させるサーバーがないと一般公開できません。  
幸い、今は無料でアプリケーションを素早く公開することもできるようになりました。

今ruby開発者の間でもっとも広く愛用されているのは[heroku](http://www.heroku.com/)です。  
gitでpushするだけでアプリケーションを公開でき、無料でもかなり使えますのでまずはこれを使う方向でいいと思います。

サーバー構築ができる方はVPSやIaaSも検討されるといいと思います。  
apache or nginx + [passenger](http://www.modrails.com/)がお手軽です。

ちなみにこのブログは<a href="http://px.a8.net/svt/ejp?a8mat=1O9JBT+2M2M7U+D8Y+BWVTE" target="_blank">さくらのVPS</a>
<img border="0" width="1" height="1" src="http://www10.a8.net/0.gif?a8mat=1O9JBT+2M2M7U+D8Y+BWVTE" alt="">にインストールしたapache + passengerで動いています。

<a id="#howtostudy"></a>
#### おすすめの学習方法

手っ取り早く体系立てて学ぶには本を読むのがいいと思います。rubyの書籍はたくさんありますが、中でもおすすめの2冊を紹介します。

他の言語を学んだことがある方は、「<a href="http://www.amazon.co.jp/gp/product/4873113679/ref=as_li_ss_tl?ie=UTF8&tag=223soft-22&linkCode=as2&camp=247&creative=7399&creativeASIN=4873113679">初めてのRuby</a><img src="http://www.assoc-amazon.jp/e/ir?t=223soft-22&l=as2&o=9&a=4873113679" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />」がおすすめです。薄い本なのですが、rubyらしい考え方のエッセンスが詰まっています。

rubyの文法や文字列操作、配列、メソッド定義などの基本的な内容に加え、ブロックやメタプログラミングの入り口まで含まれています。

<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=223soft-22&o=9&p=8&l=as4&m=amazon&f=ifr&ref=ss_til&asins=4873113679" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>

基礎を固めたあとは「<a href="http://www.amazon.co.jp/gp/product/4048687158/ref=as_li_ss_tl?ie=UTF8&tag=223soft-22&linkCode=as2&camp=247&creative=7399&creativeASIN=4048687158">メタプログラミングRuby</a><img src="http://www.assoc-amazon.jp/e/ir?t=223soft-22&l=as2&o=9&a=4048687158" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />」がおすすめです。

例えばActiveRecordなど、rubyのよく使われるライブラリはメタプログラミング（通称：黒魔術）を駆使して書かれていることが多く、メタプログラミングの知識無しでは使いこなすことが困難です。

<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=223soft-22&o=9&p=8&l=as4&m=amazon&f=ifr&ref=ss_til&asins=4048687158" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>

あとはせっかくherokuもあるしアプリケーションを書いてみるのがいいのですが、いきなりrailsにいくと覚えることの多さに挫折してしまうかもしれません。  
個人的にはまずsinatraで作った簡単なマッシュアップ程度のアプリケーションを公開してみるのが手軽かつ面白いと思います。  
例えば以下のようなアプリケーションを作ってみるのはいかがでしょうか？

- [ATND](http://atnd.org)のイベントを検索するサイト - [API](http://api.atnd.org/)はここ
- 楽天やYahooショッピング, amazonを横断して商品検索ができるサイト
- 自分のツイートからURL付きのツイートを抜き出すサイト
- Instagramに投稿された写真をタグや位置情報をもとに検索するサイト

初級レベルではsinatraだとDBに接続するまでがちょっと難しいので、DBを使う段階になったらrailsやpadrinoに行くといいかもしれません。

DBを使うプログラムの場合、ブログや一行チャット、Todoを作ってみるのが定番だと思います。  
ただ、ログインの機能をつけようと思うととたんに難しくなりますので、とりあえずbasic認証とか、認証無しで。

実際、一番いいのは教えてくれる人を早めに見つけることです。  
身近でruby勉強会などが開催されていないか、ぜひ探してみてください。  
あとはtwitterやfacebookなどで教えてくれる人を探すのもいいかもしれません。

<a href="#libraries"></a>
#### 知っておくべきライブラリやフレームワークの軽い紹介

アプリケーションを作ろうとしたとき、必ずしも全機能を自分で実装する必要はありません。すでに色んな種類の定番ライブラリがありますので、その辺をうまく活かしていくのも素早くアプリケーションを作るコツです。

##### 基本編

**RubyGems**

ライブラリの管理ツールです。1.9以降はruby本体に付属しているので特にインストールせずに使えます。

    $ gem search [検索文字列] -r # ライブラリの検索
    $ gem install [ライブラリ名]
    $ gem update # ライブラリのアップデート
    $ gem uninstall [ライブラリ名]

---

**[Bundler](http://gembundler.com/)**

これもライブラリの管理ツールですが、アプリケーション固有で必要になるライブラリの管理に使います。  
railsをやるときや、herokuにアップロードするアプリケーションを作るときに触れることになります。

簡単に説明すると、Gemfileというファイルにそのアプリケーションを動かすのに必要なライブラリを列挙します。  
そして`bundle install`コマンドでそれらのライブラリがインストールされます。  
そのライブラリはカレントディレクトリ以下の任意のディレクトリにインストールすることができるので、システムにごちゃごちゃとライブラリがインストールされること無く、アプリケーションごとにきれいに管理できるという利点もあります。

---

**rack**

直接rackを意識することはあまりないかもしれませんが、sinatraやrailsといったWebアプリケーションフレームワークはこれを利用して作られています。  
rackのおかげで、thinやpassenger, unicornなどのどのサーバーを利用してもちゃんとアプリケーションを動かせるわけです。

##### Webアプリケーションフレームワーク編

**[Ruby on Rails](http://rubyonrails.org/)**

言わずと知れた超有名ruby製フレームワーク。これを使いたいがためにrubyを勉強しようという方も多いのではないでしょうか。  
簡単なブログ程度ならあっという間に作れるのですが、ちょっと踏み込むと高機能であるが故に覚えることもたくさんあります。

書籍もたくさんありますが、バージョンに気をつけて選んでください。今の段階だとおすすめは以下です。

- [はじめる！ Rails3（１）](http://tatsu-zine.com/books/rails3) (電子書籍)
- [Agile Web Development with Rails (4th edition)](http://pragprog.com/book/rails4/agile-web-development-with-rails) (電子書籍、英語)
- <a href="http://www.amazon.co.jp/gp/product/4797363827/ref=as_li_ss_tl?ie=UTF8&tag=223soft-22&linkCode=as2&camp=247&creative=7399&creativeASIN=4797363827">Rails3レシピブック 190の技</a><img src="http://www.assoc-amazon.jp/e/ir?t=223soft-22&l=as2&o=9&a=4797363827" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />

<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=223soft-22&o=9&p=8&l=as4&m=amazon&f=ifr&ref=ss_til&asins=4797363827" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>

あと、公式のGuidesは必読です。

- [Ruby on Rails Guides](http://guides.rubyonrails.org/)

---

**[Sinatra](http://www.sinatrarb.com/)**

非常にシンプルなフレームワークです。

railsで挫折してしまった人もこちらなら十分理解できるくらい覚えることが少なく、とっつきやすいです。

個人的には、これからプログラムを勉強してみたいという人にはこれを一番に推します。Webアプリの仕組みを勉強するのにもとても向いていると思います。  
ちなみに次点はレンタルサーバーを借りることを前提としてPHPでしょうか。

---

**[Padrino](http://jp.padrinorb.com/)**

最近これをテーマとした勉強会も開かれ、勢いがあります。

railsでは大きすぎるし、sinatraではちょっと足りない、そんなニーズに応えるものです。管理画面が作りやすいのも特長ですね。


##### データベースアクセス編

**ActiveRecord**

railsの一部のように思われがちですが、単独で使うこともできます。なのでsinatraで利用することなどもできます。

---

**[DataMapper](http://datamapper.org/)**

特長はMongoDBやredisなどのNoSQLのアダプタもあることでしょうか。  
ruby製の人気CMSである[Lokka](http://lokka.org)でもこのライブラリを使っています。

---

**Sequel**

ActiveRecordやDataMapperよりももうちょっと生のSQLに近いAPIのライブラリという印象です。  
SQLがわかっていると、とてもわかりやすいAPIだと思います。

[cheat sheet](http://sequel.rubyforge.org/rdoc/files/doc/cheat_sheet_rdoc.html)

---

**Mongoid**

MongoDBを使う際、今一番使われているライブラリだと思います。

ほぼActiveRecordと同じようなAPIが準備されているので、すんなり使い始めることができます。  
それでいて、ちゃんとEmbedded DocumentなどのMongoDBの特長も活かせるような作りになっています。

---

**Redis**

高機能NoSQLのRedisのアダプタです。


##### テンプレートエンジン編

**ERB**

railsのデフォルトのテンプレートエンジンがこれです。  
PHPみたいに、HTMLの中にrubyのコードを混ぜて書くことができます。

    <div id="profile">
      <div class="left column">
        <div id="date"><%= print_date %></div>
        <div id="address"><%= current_user.address %></div>
      </div>
      <div class="right column">
        <div id="email"><%= current_user.email %></div>
        <div id="bio"><%= current_user.bio %></div>
      </div>
    </div>

---

**[Haml](http://haml-lang.com/)**

慣れると簡潔にHTMLが書けるようになります。階層関係をインデントで表すので、あとからのメンテナンスもしやすいです。

好き嫌いはあると思いますが、僕はこれを使い始めたらhtmlを書くのがめんどくさくなりました。

上のERBのサンプルコードは実は[http://haml-lang.com/](http://haml-lang.com/)から持ってきたもので、hamlで書くと以下のようになります。

    #profile
      .left.column
        #date= print_date
        #address= current_user.address
      .right.column
        #email= current_user.email
        #bio= current_user.bio

---

**[Slim](http://slim-lang.com/)**

Hamlから記号などを除いたらslimになるイメージです。  
Node.jsでよく使われるjadeと似ているので、そっちもやっている人にはおすすめかも。

ちなみに、hamlっぽく`#`とか`.`とかを使って書くこともできます。

    div id="profile"
      div class="left column"
        div id="date"= print_date
        div id="address"= current_user.address
      div class="right column"
        div id="email"= current_user.email
        div id="bio"= current_user.bio

---

**[Sass](http://sass-lang.com/)**

CSSをよりスマートに書くための文法です。

Sassでは、hamlみたいにインデントで階層構造を表現するsassという書き方と、従来のCSSとほぼ同じように書けるscssという書き方の2種類があり、rails 3.1から標準でサポートされたのはscssの方です。

セレクタの入れ子ができたり、mix-inという関数みたいな仕組みや、変数をCSS中で使うことができるのが特長です。

同種のものにlessというものもあります。

##### テストフレームワーク編

rubyはソフトウェアテストの文化がとても深く根付いている言語だと思います。

勉強会などに参加しても必ずテストが話題にのぼるくらいです。テストでよく使われるライブラリのうち、いくつか定番を挙げます。

**RSpec**

現状、rubyでテストと言ったらこれがデファクトスタンダードのようになっています。うかつに検索すると古いサイトが出てきてしまいますので、これを学ぶには以下のサイトがおすすめです。

- [RSpec の入門とその一歩先へ](http://d.hatena.ne.jp/t-wada/20100228/p1)

"RSpecの写経"と言われたら、上記のサイトのことです。一通りこなすといいと思います。

あとはRSpecのAPIなどは以下を見ましょう。

- [RSpec Documentation - Relish](https://www.relishapp.com/rspec)
- [RSpec Core](http://rubydoc.info/gems/rspec-core/2.4.0/frames)
- [RSpec Expectations](http://rubydoc.info/gems/rspec-expectations/2.4.0/frames)
- [RSpec Mocks](http://rubydoc.info/gems/rspec-mocks/2.4.0/frames)

個人的にはRelishを一番頻繁に見ていて、モックを使おうとしたときにMocksを参照することがたまにある感じです。

---

**[test-unit](http://test-unit.rubyforge.org/index.html.ja)**

他言語のxUnit(PHPUnitとか、JUnitとか)にあたるのがこれです。

ruby 1.8の頃は標準添付でしたが、今は代わりにminitestというのが標準添付となっています。

標準添付ではなくなってからも活発に更新されているようです。

---

**[shoulda](https://github.com/thoughtbot/shoulda)**

shoulda-matcherとshoulda-contextの2つのgemに分かれているのですが、Test::Unitでもcontextを使ってRSpecみたいにテストケースを整理することができたり、rails開発に便利なマッチャー（検証用のメソッド）が提供されていたりします。

僕は使っていないので詳しくわからないのですが、根強いファンがいるようです。

---

**[Capybara](https://github.com/jnicklas/capybara)**

ブラウザでの動作をエミュレートしてくれるライブラリです。テストフレームワーク？って感じですが一応ご紹介。

    visit '/top'
    fill_in_with 'email', :with => 'user@example.com'
    fill_in_with 'password', :with => 'password'
    click_button 'Login'

こんな感じに書けます。seleniumを使うことにより、実際にFirefoxが立ち上がって動いたりして、なかなか面白いです。

---

他にもmockのライブラリとかテストデータの作成に便利なライブラリとか色々ありますが、そこまで進む頃にはすでに初心者じゃないと思いますので割愛します。

<a href="#information"></a>
#### 情報の入手方法

**[オブジェクト指向スクリプト言語 Ruby リファレンスマニュアル](http://doc.ruby-lang.org/ja/1.9.2/doc/index.html)**

まずは公式のドキュメントです。

文法などの確認はこちらで。あと、標準添付ライブラリも便利なものがたくさんあるのでどんなものがあるのか、一通り見ておくといいです。

---

**[最速Rubyリファレンスマニュアル検索！ | るりまサーチ](http://doc.ruby-lang.org/ja/search/)**

マニュアルの検索はこちら。

---

**[Rubyist Magazine](http://jp.rubyist.net/magazine/)**

通称るびま。

Webで発行されているRubyist向け雑誌です。  
技術的な情報のみならず、インタビューやエッセイが掲載されていたりもします。

---

**[The Ruby Toolbox](https://www.ruby-toolbox.com/)**

人気のあるライブラリを探すことができます。

最近リニューアルされて、カテゴリ検索に加えてキーワード検索もついて使いやすくなりました。

---

**[RubyDoc.info](http://rubydoc.info/)**

ライブラリのAPIドキュメントが見られるサイトです。個人的にとても重宝しています。

---

**[Ruby5](http://ruby5.envylabs.com/)**

英語ですが、ruby関連の情報を流しているPodcastです。  
英語の勉強を兼ねて通勤中によく聴いています。

---

**[RailsCasts](http://railscasts.com/)**

これも英語ですが、railsのスクリーンキャストです。  
これもiPhoneに入れて通勤中に見たりしています。

---

あとは勉強会やコミュニティに参加するようになると、新しい情報や実務に基づいた詳しい情報なども入手することができるようになります。  
あとはブログなどで自分からも情報を発信するようにすることで、色んな人とのコミュニケーションができるようになり、結果色んな情報が集まるようになったりもします。

あんまり優良な情報を発信しようと無理に意気込むのではなく、とりあえず自分が試してみたことやうまくいかなかったことなどを気軽にメモるようにしておくと、結構教えてもらえたりします。

<a href="#communities"></a>
#### コミュニティ／勉強会

ということで、コミュニティや勉強会です。

まずは [地域Rubyの会](https://github.com/ruby-no-kai/official/wiki/RegionalRubyistMeetUp) を探してみるといいと思います。  
まぁ、やっぱり首都圏が多いですよね。

遠方の方は、自分で始めちゃうのが一番いいのかもしれません。あとはオンラインでしょうか・・・。ちょっとオンラインで継続されているコミュニティの例を僕が知らないのでこの辺はよくわかりません。

僕は横浜在住ではないのですが、Yokohama.rbによく参加しています。片道1時間以上かかりますが。

rubyにこだわらずに勉強会に参加してみるのもいいと思います。そこから得られる刺激は他では得難いものですし、人とのつながりが増えていくのはとても楽しいことです。

勉強会を探すなら、[IT勉強会カレンダー](https://www.google.com/calendar/embed?src=fvijvohm91uifvd9hratehf65k%40group.calendar.google.com)をチェックです。

あとはTwitter経由で勉強会の情報を得ることが多いので、ブログなどで見かけた活発に活動されている人を片っ端からフォローするのがいいのではないでしょうか。

<a href="#conclusion"></a>
#### まとめ

思いついたことをどんどん書いていたら結構長くなってしまいましたが、少しでも参考になりましたら幸いです。  
ここに書いたくらいの内容を事前に知っておけば、突然rubyの人の中に放り込まれても話が全く分からなくてぼっちというおそれは無いと思います。

あとはブログ + twitter + githubは現代のWeb系プログラマにとっては必須だと思います。たとえ趣味のプログラムだとしても。

ブログは無料のレンタルブログでかまいません。プログラマには[はてなダイアリー](http://d.hatena.ne.jp/)が人気です。もうすぐ"はてなブログ"になるそうですが。

勉強会などに行って名刺を交換しても、twitterとかfacebookとかのアカウントが書いていない場合はあんまりその後の交流が持てないことが多いです。  
正直、twitterアカウントはメールアドレスよりも重要かもしれません。

ということで、このエントリをきっかけに自分でWebサービスを作ってみようと思う人や勉強会やコミュニティに参加してみようという人、面白いサービスが増えたりすると嬉しいなと思います。

