# なるほど Erlang プロセス

[なるほど Unix プロセス ― Ruby で学ぶ Unix の基礎](<http://tatsu-zine.com/books/naruhounix>)という本があります．

この本は私にとって謎の多かった Unix プロセスというものを，Ruby からのプロセス操作を通じてより良く理解できました．

今回はみなさんにとっても謎の多い（かもしれない） Erlang プロセスと，
それを利用したプログラミングというものを， Ruby に少し似た Elixir からの操作を通じてより良く理解してみましょう．

# Erlang とは

[Rubyist のための他言語探訪 【第 10 回】 Erlang](http://magazine.rubyist.net/?0017-Legwork) によい説明があるので省略します．

# Erlang プロセスは ID を持っている

Erlang プロセスは，ID を持っています．PID と呼ばれています． `self()` という関数で自身の PID を返します．

以下のプログラムでは Ruby の `p` に相当する Elixir の関数 `IO.inspect` を使って `self()` の値を表示しています．

    IO.inspect self()
    # => #PID<0.73.0>

オンライン上でコンパイル・実行ができるサービスwandbox上ではElixirが動作するため，
Elixirを手元のPCにインストールしなくてもコードを編集，実行できます．
今回のコードへのリンクを貼っておくのでもし興味があればコードを書き換えて試してみてください．
（書き換えて実行しても他の人やリンクには影響が出ないので安心してください）

[コード](https://wandbox.org/permlink/KY0OmfkBWbS3uB6a)

# Erlang プロセスは別のプロセスを作れる

Erlang プロセスは，別の Erlang プロセスを作ることができます． `spawn` という関数を利用します．

Ruby で lambda を `-> do ... end` や `-> x do ... end` と書けるように，
Elixir では無名関数を `fn -> ... end` や `fn x -> ... end` と書けます．

`spawn` は引数に無名関数を取り，作成した Erlang プロセスの上でその関数を実行します．

ですから，以下のプログラムではメインの Erlang プロセスの PID と， spawn で生成した Erlang プロセスでの PID が異なっています．

    IO.puts "プロセス #{inspect self()}"
    spawn(fn ->
      IO.puts "別プロセス #{inspect self()}"
    end)
    # => プロセス #PID<0.73.0>
    # => 別プロセス #PID<0.76.0>

[コード](https://wandbox.org/permlink/XdMnsoTvT4uQEhh5)

# Erlang プロセスは別の Erlang プロセスとやりとりできる

Erlang プロセスは，別の Erlang プロセスとの間でやりとりができます．
プロセスとプロセスの間でやりとりする値のことはメッセージと呼ばれています．

あるプロセスから別のプロセスへメッセージを送るには `send` という関数を利用します．
`send` の引数は送り先の PID と送りたいメッセージです．

プロセスへと送られてきたメッセージを取り出して読むには `receive` という関数を利用します．
`receive` の `do ... end` の中でメッセージを受けとることができます．

以下のプログラムでは Ruby の `Object#inspect` に相当する Elixir の関数 `inspect` と Ruby の `puts` に相当する Elixir の関数 `IO.puts` を使って，
送られてきたメッセージの値を表示しています．

    IO.puts "プロセス #{inspect self()}"

    other_pid = spawn(fn ->
      IO.puts "別プロセス #{inspect self()}"
      receive do
        message ->
          IO.puts "#{inspect self()} が #{inspect message} を受け取りました．"
      end
    end)

    send(other_pid, "こんにちは")
    Process.sleep(100)
    # => プロセス #PID<0.73.0>
    # => 別プロセス #PID<0.76.0>
    # => #PID<0.76.0> が "こんにちは" を受け取りました．

[コード](https://wandbox.org/permlink/8OxwzVa7cP24PGtN)

# Erlang プロセスはメッセージボックスを持つ

`send` でメッセージが送られてきたとき，受け手のプロセスでは明示的な処理は不要です．
もちろんメッセージを **取り出して読む** には先ほどの例のように `receive` を使わなければいけませんが，メッセージを **受けとる** には何も必要ありません．
全てのプロセスは，プロセスと一対一で結びついたキューを持っており，プロセスへ送られたメッセージはそのキューへと蓄積されます．
この，プロセスに結びついたメッセージを格納するためのキューのことはメッセージボックスと呼ばれています．

以下のプログラムではプロセスの状態を調べられる `Process.info` を使って，プロセスのメッセージボックスの内容を表示しています．

    message_receiver_pid = self()
    spawn(fn ->
       send(message_receiver_pid, "メッセージ0")
       send(message_receiver_pid, "メッセージ1")
       send(message_receiver_pid, "メッセージ2")
       send(message_receiver_pid, "メッセージ3")
       send(message_receiver_pid, "メッセージ4")
       {_, messages} = Process.info(message_receiver_pid, :messages)
       IO.puts "メッセージボックスには #{inspect messages} が入っています"
    end)
    Process.sleep(100)
    # => メッセージボックスには ["メッセージ0", "メッセージ1", "メッセージ2", "メッセージ3", "メッセージ4"] が入っています

[コード](https://wandbox.org/permlink/X0IFXSaId23qelUo)

# Erlang プロセスは並列に動ける

Erlang プロセスは並列に動作します．ハードウェアによる限りはありますが，プロセスそれぞれが同時に別の計算を行えるということです．

ある処理を1つだけ実行したときと，複数(今回は4つ)実行したときの，結果が得られるまでの時間を比較して検証しましょう．
例えば 2 つ並列に動かして，`1 つ動かしたときの時間 * 2` より小さいなら，並列に動いているといえるでしょう．

以下のプログラムでは Ruby の `sleep` のように処理をスリープさせられる Elixir の関数 `Process.sleep` を使って，処理に5秒かかるようにしています．
時間は Ruby の `DateTime.now` に似た Elixir の `DateTime.utc_now` で測ることにしました．

また，1 回の `receive` で受けとれるメッセージは常に 1 つなので，ここでは 2 つのメッセージを受けとるため 2 回 `receive` しています．

    IO.puts "#{DateTime.utc_now} 直列スタート"
    Process.sleep(5000)
    IO.puts "#{DateTime.utc_now} 1番目完了"
    Process.sleep(5000)
    IO.puts "#{DateTime.utc_now} 直列エンド"

    IO.puts "================"
    me = self()
    IO.puts "#{DateTime.utc_now} 並列スタート"
    spawn(fn ->
      Process.sleep(5000)
      send(me, DateTime.utc_now)
    end)
    spawn(fn ->
      Process.sleep(5000)
      send(me, DateTime.utc_now)
    end)

    receive do
      date_time ->
        IO.puts "#{date_time} 1番目完了"
    end
    receive do
      date_time ->
        IO.puts "#{date_time} 並列エンド"
    end
    # =>2017-08-16 16:13:42.073171Z 直列スタート
    # =>2017-08-16 16:13:47.089828Z 1番目完了
    # =>2017-08-16 16:13:52.105294Z 直列エンド
    # =>================
    # =>2017-08-16 16:13:52.105620Z 並列スタート
    # =>2017-08-16 16:13:57.121883Z 1番目完了
    # =>2017-08-16 16:13:57.121969Z 並列エンド

[コード](https://wandbox.org/permlink/X0IFXSaId23qelUo)

直列だと約 10 秒 (5 秒 * 2 回)かかって，並列だとほぼ 5 秒で終わっていますね．

# Erlang プロセスは軽量

Erlang プロセスを作るのには，プロセスのヒープ領域込みで 2500 バイト程度しか要しません．
この文のここまでの文字を UTF-8 として計算すると 7.8k バイトであるようなので，これでプロセス 3 つ分作れてしまうようです．

Ruby の `Enumerable#reduce` に似た Eliixr の関数 `Enum.reduce` を使って 10 万プロセスを畳み込み，生成と処理にかかる時間を計測しましょう．
また，Elixir からは Erlang の関数を直接呼び出せるので， Erlang の関数 `:erlang.memory(:total)` で 10 万プロセスが生きているときのメモリ使用量も計測しましょう．

    IO.puts "#{DateTime.utc_now} 計測開始"
    last_pid = Enum.reduce(1..100_000, self(), fn (_prev, send_to) ->
      spawn(fn ->
        receive do
          x ->
            # 受けとったメッセージの数値に1を足し，次のプロセスへメッセージを送る
            send(send_to, x + 1)
        end
      end)
    end)

    memory = :erlang.memory(:total)
    send(last_pid, 0) # n個の子プロセスの最初の1個を動かす
    receive do
      final_answer ->
        IO.puts "#{DateTime.utc_now} 計測終了．数値:#{final_answer}．メモリ量:#{memory}"
    end
    # => 2017-08-16 16:16:29.249655Z 計測開始
    # => 2017-08-16 16:16:33.040399Z 計測終了．数値:100000．メモリ量:282859376

[コード](https://wandbox.org/permlink/Jdddis6yA9QHH2ac)

プロセスを 10 万個生成して 1 ずつ足したので数値が計算結果が 10 万になっており，
そのときの生成と実行にかかった時間は 4 秒程度，メモリ使用量は約 2.8 Gバイトだったことがわかりますね．

# Erlang プロセス同士のかかわり

ここまでは Erlang プロセス自身の性質を見てきました．
ここからは Erlang プロセス同士の関係に関する性質を見ていきましょう．

プロセスを作り，そのプロセス上でエラーを起こしても，元のプロセスでは何も検知しません．

Ruby の `raise` に似た，Elixir の `raise` でエラーを起こしてみましょう．

    IO.puts "#{DateTime.utc_now} start"
    spawn(fn ->
      raise "boom!"
    end)

    Process.sleep(1000)
    IO.puts "\n#{DateTime.utc_now} done"
    # => 2017-08-16 16:23:20.787436Z start
    # =>
    # => 01:23:20.926 [error] Process #PID<0.76.0> raised an exception
    # => ** (RuntimeError) boom!
    # =>     prog.exs:3: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
    # =>
    # => 2017-08-16 16:23:21.804186Z done

[コード](https://wandbox.org/permlink/4ZoIEU5Q1sZxZldD)

エラーログはコンソールに出力されているものの，処理は正常に終わって done が表示されています．

# Erlang プロセスは link できる

Erlang プロセス同士を link する方法があります．
プロセス同士を繋げると，片方のプロセスで異常が起きたとき，もう一方へと知らせてくれます．

Elixir でプロセスを生成してすぐ link するには `spawn_link` という関数を使います．

    IO.puts "#{DateTime.utc_now} start"
    spawn_link(fn ->
      raise "boom!"
    end)

    Process.sleep(1000)
    IO.puts "\n#{DateTime.utc_now} done"
    # => 2017-08-16 16:25:15.395832Z start
    # =>
    # => ** (EXIT from #PID<0.73.0>) an exception was raised:
    # =>     ** (RuntimeError) boom!
    # =>         prog.exs:3: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
    # =>
    # =>
    # => 01:25:15.525 [error] Process #PID<0.76.0> raised an exception
    # => ** (RuntimeError) boom!
    # =>     prog.exs:3: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
    # =>

[コード](https://wandbox.org/permlink/owTt3cyR8nrhK3X6)

先程とは異なり done がコンソールに表示されていませんね．

生成してリンクしたプロセスにてエラーが発生，そのエラーが元のプロセスへ伝えられ，
元のプロセスでもエラーハンドリングしていないため，元のプロセスもエラーになりました．

# Erlang プロセスのエラーハンドリング

エラーを知らせてくれるのは便利ですけれども，エラーハンドリングしないと自分もエラーになってしまうのは不便ですね．

ある Erlang プロセスから別の Erlang プロセスへエラーを伝えるのは，特別なメッセージを送ることで行われています．そのメッセージの名前を `exitシグナル` といいます．
ErlangVM には `exit シグナル` を通常のメッセージとして受け付ける仕組みがあるので，それを利用してエラーハンドリングします．

あるプロセスに `Process.flag(:trap_exit, true)` と書くと `exit シグナル` を通常のメッセージとして扱えるようになります．

    IO.puts "#{DateTime.utc_now} start"
    Process.flag(:trap_exit, true)
    spawn_link(fn ->
      raise "boom!"
    end)

    Process.sleep(1000)
    receive do
      message ->
        IO.puts "exitシグナルを受信しました: #{inspect message}"
    end
    IO.puts "\n#{DateTime.utc_now} done"
    # => 2017-08-16 16:26:58.615378Z start
    # =>
    # => 01:26:58.680 [error] Process #PID<0.76.0> raised an exception
    # => ** (RuntimeError) boom!
    # =>     prog.exs:4: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
    # => exitシグナルを受信しました: {:EXIT, #PID<0.76.0>, {%RuntimeError{message: "boom!"}, [{:elixir_compiler_0, :"-__FILE__/1-fun-0-", 0, [file: 'prog.exs', line: 4]}]}}
    # =>
    # => 2017-08-16 16:26:59.741148Z done

[コード](https://wandbox.org/permlink/JEbFgmjGixoZ0rDZ)

exit シグナルを通常のメッセージとして受信し，その後 done になっていますね．

# Erlangプロセスを link するとどう嬉しいのか

こうしてプロセスを link しておくことにはどのような意味があるのでしょうか．
すごいErlangゆかいに学ぼう！第 12 章 - エラーとプロセス (P151) には以下のように記述がありました．

> もしエラーのあるプロセスがクラッシュしたけれど、
> それに依存しているプロセスが動き続けているとしたら、
> それら依存プロセスすべては依存先がなくなったことに対処しなければならなくなります。

link しておけば処理を実装するプログラマが考えなければいけない状態が一つ減ります．

また，link したプロセスが死んだことをすぐに検知できると，時間をおかずに新しいプロセスを作りなおすことができます．
エラー検知/再開を素早く行えると，一部の処理で不具合が起きても全体の動作には影響をほぼ与えずに復元することができ，全体の安定動作向上に寄与します．

# Erlang プロセスは monitor できる

Erlang プロセス同士を link するのではなく，片方がもう片方を見ておく方法があります．monitor といいます．
先程の link は link 元と link 先が対等の立場でしたが，monitor は見る方と見られる方で立場が異なります．

Elixir でプロセスを生成してすぐ繋げるには `spawn_monitor` という関数を使います．

    IO.puts "#{DateTime.utc_now} start"
    spawn_monitor(fn ->
      raise "boom!"
    end)

    Process.sleep(1000)
    receive do
      message ->
        IO.puts "メッセージを受信しました: #{inspect message}"
    end
    IO.puts "\n#{DateTime.utc_now} done"
    # => 2017-08-16 16:29:49.030618Z start
    # =>
    # => 01:29:49.072 [error] Process #PID<0.76.0> raised an exception
    # => ** (RuntimeError) boom!
    # =>     prog.exs:3: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
    # => メッセージを受信しました: {:DOWN, #Reference<0.2290368879.2564030465.30809>, :process, #PID<0.76.0>, {%RuntimeError{message: "boom!"}, [{:elixir_compiler_0, :"-__FILE__/1-fun-0-", 0, [file: 'prog.exs', line: 3]}]}}
    # =>
    # => 2017-08-16 16:29:50.086205Z done

[コード](https://wandbox.org/permlink/ams6gsRUJcQUdKbe)

link の際とは異なり `Process.flag(:trap_exit, true)` を使っていないプロセスでも受け取れていることに注意してください．
`exitシグナル` ではない，単なるメッセージが送られてきます．

# Erlang プロセスを monitor するとどう嬉しいのか

こうしてプロセスを monitor しておくことにはどのような意味があるのでしょうか．
すごいErlangゆかいに学ぼう！第 12 章 - エラーとプロセス (P151) には以下のように記述がありました．

> モニターは、プロセスが下位のプロセスで何が起きているかを知りたいけれど、お互いが致命的な影響を及ぼしてほしくないときに便利です。（略）
> 他のプロセスで何が起きているかを知る必要があるライブラリを書くときに活躍します。

私があまり monitor を使いこなしていないせいか， monitor がバチッとハマりそうな例はうまく思いつきませんでした．
すみませんm(\_\_)m．みなさんでよい例を知っていたり，おもいついたらブログなどに書いていただけると嬉しいです．

# Erlang プロセス同士の結びつきまとめ

以上のように，プロセス同士の結びつきの強度に応じていくつかの方法が提供されています．

- A が B を link した場合，A がエラーになったら B へ `exitシグナル` が行く．B がエラーになったら A へ `exitシグナル` が行く．
- A が B を monitor した場合，A がエラーになっても B は影響を受けない．B がエラーになったら A へ通常のメッセージが行く．
- それ以外の場合，他のプロセスで何が起きようと影響を受けない

# 壊れやすいタイマー

さてここまでプロセスの性質やプロセスのインタラクションについて説明してきたので，これらを組み合わせて簡単なアプリケーションを作ってみましょう．

壊れやすいタイマーというものを考えてみます．毎秒時刻を出力し，30% の割合で壊れてしまうタイマーを考えましょう．

Ruby の `module` に似た，Elixir の `defmodule` でモジュールを定義，
Ruby の `def` に似た，Elixir の `def` で関数を定義します．
また Elixir には while のようなループがなく，ループは再帰で表現します．

    defmodule FragileTimer do
      def loop do
        case :rand.uniform() do
          x when x < 0.3 ->
            exit("ガシャ")
          _x ->
            IO.puts "#{DateTime.utc_now}"
        end
        Process.sleep(1000)
        loop()
      end
    end

    FragileTimer.loop
    => 2017-08-16 16:33:14.767947Z
    => 2017-08-16 16:33:15.785176Z
    => 2017-08-16 16:33:16.786127Z
    => 2017-08-16 16:33:17.787063Z
    => 2017-08-16 16:33:18.788181Z
    =>
    => ** (exit) "ガシャ"
    =>     prog.exs:5: FragileTimer.loop/0
    =>     (elixir) lib/code.ex:376: Code.require_file/2

[コード](https://wandbox.org/permlink/7a8Tu7aK85jD5Q2p)

ここまでは意図通りに動くようです．
とはいえ，壊れてしまいタイマーが動かなくなると困るので，
タイマーが壊れたのを検知してすぐに新しいタイマーを起動する見張り役のプロセスを作り，
タイマーを安定動作させることを目指します．

    defmodule FragileTimer do
      def loop do
        case :rand.uniform() do
          x when x < 0.3 ->
            exit("ガシャ")
          _x ->
            IO.puts "#{DateTime.utc_now}"
        end
        Process.sleep(1000)
        loop()
      end
    end

    defmodule FragileTimerSupervisor do
      def loop(times) when 3 < times do
        IO.puts "3回壊れたのであきらめます"
      end

      def loop(times) do
        spawn_monitor(fn ->
          FragileTimer.loop
        end)
        IO.puts "#{DateTime.utc_now} にタイマー起動しました"
        receive do
          _down_message ->
            IO.puts "#{DateTime.utc_now} に壊れたのを検知しました"
            loop(times + 1)
        end
      end
    end

    FragileTimerSupervisor.loop(1)
    => 2017-08-16 16:35:34.013130Z にタイマー起動しました
    => 2017-08-16 16:35:34.017548Z
    => 2017-08-16 16:35:35.027242Z に壊れたのを検知しました
    => 2017-08-16 16:35:35.027497Z にタイマー起動しました
    => 2017-08-16 16:35:35.027560Z
    => 2017-08-16 16:35:36.028080Z
    => 2017-08-16 16:35:37.029087Z
    => 2017-08-16 16:35:38.030102Z に壊れたのを検知しました
    => 2017-08-16 16:35:38.030352Z にタイマー起動しました
    => 2017-08-16 16:35:38.030422Z
    => 2017-08-16 16:35:39.031359Z
    => 2017-08-16 16:35:40.033239Z
    => 2017-08-16 16:35:41.034229Z
    => 2017-08-16 16:35:42.035212Z
    => 2017-08-16 16:35:43.036179Z に壊れたのを検知しました
    => 3回壊れたのであきらめます

[コード](https://wandbox.org/permlink/1dWaw0nNjBlgQO8B)

壊れやすいタイマーと，見張り役を組み合わせることで多くの時間にはきちんと動くタイマーを作ることができましたね．

# Erlang プロセスを扱うライブラリ Erlang//OTP

これまで挙げたようなプロセスの協調動作を駆使するのが ErlangVM のプログラミングの面白く難しいところですが，
これらのプリミティブな性質を直接使うのではなく，便利に利用するためのライブラリ Erlang/OTP というものがあります．

わかりやすさのために，`spawn` や `link` や `monitor`を直接利用していましたが，
私がこれまで眺めたことのある Erlang/Elixir ライブラリたちではそれらはあまり使われず，OTP を使うものが多かったです．
プロダクションで利用するコードにはOTPを利用しましょう．

# 著者について

ヽ（´・肉・｀）ノ [@niku_name](https://twitter.com/niku_name)
札幌に住んでいて，お仕事や趣味で Ruby を書いています．
だいたい毎週木曜日に開催されている[サッポロビーム](http://sapporo-beam.github.io/)というErlangVMについて話す集まりに参加しています．
たまに RubySapporo.beam というイベント ( [#1](https://rubysapporo.doorkeeper.jp/events/50956), [#2](https://rubysapporo.doorkeeper.jp/events/57253) ) を開催しています．
