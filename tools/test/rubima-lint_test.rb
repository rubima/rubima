require 'minitest/spec'
require 'minitest/autorun'
require 'open3'

describe "Rubima-Lint" do

   describe "アスキー文字の前後にスペース" do
      describe "アスキー文字の前にスペースがないとき" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "アスキー文字の前にスペースabc が必要です"
               stdin.close
               stdout.read.must_match /1 warning/m
            }
         end
      end

      describe "アスキー文字の後にスペースがないとき" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "アスキー文字の前にスペース abcが必要です"
               stdin.close
               stdout.read.must_match /1 warning/m
            }
         end
      end

      describe "アスキー文字の前後にスペースがないとき" do
         it "2つ警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "アスキー文字の前後にスペースabcが必要です"
               stdin.close
               stdout.read.must_match /2 warning/m
            }
         end
      end
   end

   describe "invalid pattern" do

      describe "開き丸括弧" do
         describe "開き丸括弧の前に文字がある場合" do
            it "警告が出ること" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "本文("
                  stdin.close
                  stdout.read.must_match /1 warning/m
               }
            end
         end

         describe "開き丸括弧が先頭にある場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "(先頭に開き丸括弧"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end

         describe "開き丸括弧の前に発言頭がある場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "'''　(開き丸括弧の前に発言頭"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end

         describe "開き丸括弧の前に句読点がある場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "。(開き丸括弧の前に句読点、("
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end

         describe "開き丸括弧の前に開き括弧類がある場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "「(開き丸括弧の前に開き括弧類『("
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end

         describe "開き丸括弧の前に閉じ括弧類がある場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "」(開き丸括弧の前に閉じ括弧類』("
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end

         describe "開き丸括弧の前に三点リーダがある場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "……(開き丸括弧の前に三点リーダ"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end
      end

      describe "閉じ丸括弧" do
         describe "閉じ丸括弧の後に文字がある場合" do
            it "警告が出ること" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts ")本文"
                  stdin.close
                  stdout.read.must_match /1 warning/m
               }
            end
         end

         describe "閉じ丸括弧が末尾にある場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "閉じ丸括弧)"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end

         describe "閉じ丸括弧の後に句読点がある場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts ")。閉じ丸括弧の後に句読点)、"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end

         describe "閉じ丸括弧の後に開き括弧類がある場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts ")「閉じ丸括弧の後に開き括弧類)『"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end

         describe "閉じ丸括弧の後に閉じ括弧類がある場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts ")」閉じ丸括弧の後に閉じ括弧類)』"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end

         describe "閉じ丸括弧の後に三点リーダがある場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts ")……閉じ丸括弧の後に三点リーダ"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end
      end

      describe "文末で括弧を閉じる" do
         describe "句点 + 閉じ括弧 + 句点となっている場合" do
            it "警告が出ること" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "本文 (追加の文。)。"
                  stdin.close
                  stdout.read.must_match /1 warning/m
               }
            end
         end

         describe "句点以外 + 閉じ括弧 + 句点となっている場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "本文 (追加の文)。"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end

         describe "句点 + 閉じ括弧となっている場合" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "本文。(追加の文。) です。"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end
      end

      describe "括弧笑の後の句点" do
         describe "顔文字やそれに準じるものの後に句点があるとき" do
            it "警告が出ること" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "笑)。"
                  stdin.close
                  stdout.read.must_match /1 warning/m
               }
            end
         end

         describe "顔文字やそれに準じるものの後に句点がないとき" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "笑)"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end
      end

      describe "三点リーダ" do
         describe "単独で使っている時" do
            it "警告が出ること" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "単独の三点リーダ…です。"
                  stdin.close
                  stdout.read.must_match /1 warning/m
               }
            end
         end

         describe "2文字で使っている時" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "二文字の三点リーダ……です。"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end

         describe "文末で使い句点がない時" do
            it "警告が出ること" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "二文字の三点リーダ……"
                  stdin.close
                  stdout.read.must_match /1 warning/m
               }
            end
         end

         describe "文末で使い句点がある時" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "二文字の三点リーダ……。"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end
      end

      describe "段落中の疑問符・感嘆符" do
         describe "疑問符・感嘆符の次に全角スペースがないとき" do
            it "警告が出ること" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  # 半角スペースを含めている
                  stdin.puts "疑問符？ 感嘆符"
                  stdin.close
                  stdout.read.must_match /1 warning/m
               }
            end
         end

         describe "疑問符・感嘆符の次に全角スペースがあるとき" do
            it "警告が出ないこと" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "感嘆符！　疑問符"
                  stdin.close
                  stdout.read.must_equal ""
               }
            end
         end
      end

      describe "全角括弧" do
         it "開き全角括弧が使われているときは警告が出ること" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "全角（括弧テスト。"
                  stdin.close
                  stdout.read.must_match /1 warning/m
               }
         end

         it "閉じ全角括弧が使われているときは警告が出ること" do
               Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
                  stdin.puts "全角括弧）テスト。"
                  stdin.close
                  stdout.read.must_match /1 warning/m
               }

         end
      end
   end

   describe "不要な空白" do
      describe "三点リーダ + 空白 + 開き丸括弧" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "あああ…… (いいい"
               stdin.close
               stdout.read.must_match /1 warning/m
            }
         end
      end

      describe "句読点 + 空白 + 開き丸括弧" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "あああ、 (いいい。 (ううう"
               stdin.close
               stdout.read.must_match /2 warning/m
            }
         end
      end

      describe "開き括弧類 + 空白 + 開き丸括弧" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "あああ「 (いいい『 (ううう"
               stdin.close
               stdout.read.must_match /2 warning/m
            }
         end
      end

      describe "閉じ括弧類 + 空白 + 閉じ丸括弧" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "あああ」 (いいい』 (ううう"
               stdin.close
               stdout.read.must_match /2 warning/m
            }
         end
      end

      describe "閉じ丸括弧 + 空白 + 句読点" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "あああ) 、いいい) 。ううう"
               stdin.close
               stdout.read.must_match /2 warning/m
            }
         end
      end

      describe "閉じ丸括弧 + 空白 + 開き括弧類" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "あああ) 「いいい) 『ううう"
               stdin.close
               stdout.read.must_match /2 warning/m
            }
         end
      end

      describe "閉じ丸括弧 + 空白 + 閉じ括弧類" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "あああ) 」いいい) 』ううう"
               stdin.close
               stdout.read.must_match /2 warning/m
            }
         end
      end
   end

   describe "TODO" do
      it "文中にあれば警告が出ること" do
         Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
            stdin.puts "備忘録を表す TODO がある場合は警告を出す。"
            stdin.close
            stdout.read.must_match /1 warning/m
         }
      end
   end

   describe "{{toc}}" do
      it "文中にあれば警告が出ること" do
         Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
            stdin.puts "目次を表す {{toc}} がある場合は警告を出す。"
            stdin.close
            stdout.read.must_match /1 warning/m
         }
      end
   end

   describe "リンク" do
      describe "[[名前|https://foo.bar]]形式の時" do
         it "警告が出ないこと" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "リンク[[名前|https://foo.bar]]"
               stdin.close
               stdout.read.must_equal ""
            }
         end
      end

      describe "[[名前|名前]]形式の時" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "リンク[[名前|名前]]"
               stdin.close
               stdout.read.must_match /1 warning/m
            }
         end
      end

      describe "[[名前|abc]]形式の時" do
         it "警告が出ないこと" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "リンク[[名前|abc]]"
               stdin.close
               stdout.read.must_equal ""
            }
         end
      end
   end

   describe "脚注" do
      describe "{{fnがあって----がある場合" do
         it "警告が出ないこと" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "脚注テスト{{fn('脚注')}}"
               stdin.puts "----"
               stdin.close
               stdout.read.must_equal ""
            }
         end
      end

      describe "{{fnがあって----がない場合" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "脚注テスト{{fn('脚注')}}"
               stdin.puts "---"
               stdin.close
               stdout.read.must_match /1 warning/m
            }
         end
      end

      describe "{{fnがなくて----がある場合" do
         it "警告が出ること" do
            Open3.popen3("ruby rubima-lint.rb") { |stdin, stdout, stderr|
               stdin.puts "脚注テスト{{fb('あいう')}}"
               stdin.puts "----"
               stdin.close
               stdout.read.must_match /1 warning/m
            }
         end
      end
   end
end

