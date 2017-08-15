## はじめに

「Ruby を始めたい！」

そんな方のために本稿では次の内容を説明します。

- 対象読者
- Ruby のインストール
- 学習方法
- ライブラリ (RubyGems)
- 情報の入手方法
- コミュニティ / 勉強会

本稿は Rubyist Magazine 常設記事です。

## 対象読者

今までなんらかのプログラミング言語を触ったことのある方を対象とします。
基本的なプログラミング自体の解説はしませんので、適宜プログラミングの入門書等にあたってください。


## Ruby のインストール

まずは Ruby でプログラムが書ける環境を整えましょう。

インストールする前にちょっと Ruby を味見してみたいと言う方は [TryRuby](http://tryruby.org) を試してみると良いかもしれません。

### Ruby の種類について

Ruby の処理系にはいくつかの種類があります。

- CRuby（単に "Ruby" と言った場合はほとんどこれを指す）
- [JRuby](http://jruby.org/)
- [Rubinius](http://rubini.us/)
- [mruby](https://github.com/mruby/mruby)

特に理由が無ければ CRuby を入れておけば間違いないです。

現在最新の安定版の Ruby は [Ruby 公式サイトのダウンロードページ](https://www.ruby-lang.org/ja/downloads/) から確認できます。

まだまだ 1.9.3 も多い状況ですが、これから Ruby を学び始めるのであれば、最新の安定版で問題ないと思います。

Ruby に限らず最近のスクリプト系言語 (LL: Lightweight Language と呼ばれたりする。perl, python, node.js...etc.) で開発をしている人の多くは複数のバージョンを切り替えて扱えるようなツールを使っています。

Ruby で言うと、以下の2つが主流です。

- [rvm](http://rvm.io/)
- [rbenv](https://github.com/rbenv/rbenv) + [ruby-build](https://github.com/rbenv/ruby-build)

最近人気が高まってきているのは rbenv の方ですが、
身近に教えてくれる人がいるのなら、その方に合わせるのをおすすめします。

### 主なインストールの手段

#### Windows

- [RubyInstaller](http://rubyinstaller.org)
- [RailsInstaller](http://railsinstaller.org)

自分で Ruby をビルドしたい方は [Ruby環境構築講座 Windows編 - 達人出版会](http://tatsu-zine.com/books/winrubybuild) を参照されるのが良いかと思います。

#### Mac OS X

デフォルトで Ruby が入っていますが、OS X Mountain Lion(10.8)以前のものはバージョンが 1.8 系と大変古いです。
OS X Mavericks(10.9)では 2.0.0 系が入っています。これを使うのもいいですが、最新の安定版を入れるのをお勧めします。

新しいバージョンの Ruby は以下の方法などでインストールができます。

- [RailsInstaller](http://railsinstaller.org)

バージョン切り替えが必要な場合は RailsInstaller と一緒にインストールされる [RVM](https://rvm.io) を利用したり、 [rbenv](https://github.com/rbenv/rbenv/) + [ruby-build](https://github.com/rbenv/ruby-build) 等の導入を検討してください。

rbenv を使ったインストール方法については [OS X で rbenv を使って ruby 1.9.3 or 2.0.0 の環境を作る](http://qiita.com/items/9dd797f42e7bea674705) が参考になります。

#### Linux 等の Unix 系 OS

各ディストリビューションのパッケージマネージャ (apt, yum... etc.) でインストールできる Ruby は 1.8 系の古いものであることが多いです。

[RVM](https://rvm.io) や [rbenv](https://github.com/rbenv/rbenv/) + [ruby-build](https://github.com/rbenv/ruby-build) 等の導入を検討してください。

導入方法はそれぞれのサイトを参照してください。

[OS X で rbenv を使って ruby 1.9.3 or 2.0.0 の環境を作る](http://qiita.com/items/9dd797f42e7bea674705) が参考になりますが、Mac 環境向けの記事なので、
以下 Ubuntu を対象に補足します。Ubuntu 以外の Linux, Unix 系 OS でも同様ですが、パッケージマネージャごとにパッケージ名が異なります。

- brew, Xcode は Mac 用なので、インストール *しないでください*
- デフォルトで GCC や Git などが入っていないので sudo apt-get install build-essential git autoconf でインストールします
- ビルド時に必要なライブラリを sudo apt-get zlib1g-dev libyaml-dev libreadline-dev libssl-dev でインストールします
- Linux では /etc/paths はありませんので、無視してください
- **ruby-build を使う** の部分は以下のように読み替えてください (RUBY_CONFIGURE_OPTS の指定が不要です)

```
$ rbenv install 1.9.3-p395
$ rbenv install 2.0.0-p0
$ rbenv shell 1.9.3-p395
```

### エディタ

以下のエディタが人気のようです。
ぜひ色々試して自分に合ったエディタを探してください。

- vim
- emacs
- [Atom](https://atom.io/)
- [Sublime Text 2](http://www.sublimetext.com/2)

### IDE

IDE を使いたい方は [RubyMine](http://www.jetbrains.com/ruby/) を検討されると良いでしょう。


## 学習方法

手っ取り早く体系立てて学ぶには本を読むのがいいと思います。Ruby の書籍はたくさんありますが、中でもおすすめの2冊を紹介します。

他の言語を学んだことがある方は、[「初めての Ruby」](https://www.oreilly.co.jp/books/9784873113678/)がおすすめです。薄い本なのですが、Ruby らしい考え方のエッセンスが詰まっています。

Ruby の文法や文字列操作、配列、メソッド定義などの基本的な内容に加え、ブロックやメタプログラミングの入り口まで含まれています。

さらに深く学びたい方は[「メタプログラミング Ruby 第 2 版」](https://www.oreilly.co.jp/books/9784873117430/)がおすすめです。

メタプログラミングの知識があることで、より効率よくプログラミング出来るようになります。


## ライブラリ (RubyGems)

アプリケーションを作ろうとしたとき、必ずしも全機能を自分で実装する必要はありません。すでに色んな種類の定番ライブラリがありますので、その辺をうまく活かしていくのも素早くアプリケーションを作るコツです。

### [RubyGems](https://rubygems.org)

Ruby 本体に gem コマンドが付属しているのですぐに使うことができます。

    $ gem search [検索文字列] # ライブラリの検索
    $ gem install [ライブラリ名]
    $ gem update # ライブラリのアップデート
    $ gem uninstall [ライブラリ名]

### [Bundler](http://gembundler.com/)

これもライブラリの管理ツールですが、アプリケーション固有で必要になるライブラリの管理に使います。
Rails や Padrino 等でアプリケーション開発をする場合はこれを使用する前提となっています。


## 情報の入手方法

**[オブジェクト指向スクリプト言語 Ruby リファレンスマニュアル](http://docs.ruby-lang.org/ja/2.3.0/doc/index.html)**

まずは公式のドキュメントです。

文法などの確認はこちらで。あと、標準添付ライブラリも便利なものがたくさんあるのでどんなものがあるのか、一通り見ておくと良いです。

---

**[最速 Ruby リファレンスマニュアル検索！ | るりまサーチ](http://doc.ruby-lang.org/ja/search/)**

マニュアルの検索はこちら。

---

**[Rubyist Magazine](http://magazine.rubyist.net/)**

本誌。通称るびま。

Web で発行されている Rubyist 向け雑誌です。
技術的な情報のみならず、インタビューやエッセイが掲載されていたりもします。

---

**[RubyDoc.info](http://rubydoc.info/)**

gem の API ドキュメントが見られるサイトです。


## コミュニティ／勉強会

Ruby はコミュニティ活動が非常に活発です。

勉強会やコミュニティに参加するようになると、新しい情報や実務に基づいた詳しい情報なども入手することができるようになります。

まずは [地域Rubyの会](https://github.com/ruby-no-kai/official/wiki/RegionalRubyistMeetUp) を探してみるといいと思います。


## おわりに

本稿があなたの Ruby ライフの一助になれば幸いです。
