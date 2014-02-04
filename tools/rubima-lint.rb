#!/usr/bin/ruby -Ku
# -*- coding: utf-8 -*-
# 正規表現エンジンに鬼車必須
# [ruby-list:41932]を参考にした。
#使い方 チェックしたい Hiki ソースをテキスト(例 hoge.txt) に保存。
#$ ruby rubima-lint.rb hoge.txt でエラー行数・エラー内容が出力されます。

非ascii = '[^[:ascii:]]'
ascii = '[\w&&[:ascii:]]'
開き丸括弧 = '[(]'
閉じ丸括弧 = '[)]'
疑問符・感嘆符 = '[？！]'
句読点 = "[、。#{疑問符・感嘆符}]"
開き括弧類 = '[「『]'
閉じ括弧類 = '[』」]'
三点リーダ = '[…]'
その他ok文字 = "[#{三点リーダ}〜：　]"
asciiの直前ok文字 = "[#{句読点}#{開き括弧類}#{その他ok文字}]"
asciiの直後ok文字 = "[#{句読点}#{閉じ括弧類}#{その他ok文字}]"
発言頭 = "'''　"
非asciiの直後にascii = /(?<=#{非ascii})(?=#{ascii})(?<!#{asciiの直前ok文字})(?<!#{発言頭})/o
asciiの直後に非ascii = /(?<=#{ascii})(?=#{非ascii})(?!#{asciiの直後ok文字})/o
空白抜け = /#{非asciiの直後にascii}|#{asciiの直後に非ascii}/o

丸括弧前後ok文字 = "[ [[:ascii:]&&[:graph:]]#{句読点}#{開き括弧類}#{閉じ括弧類}#{三点リーダ}]"

union = [
  /(?<!^)(?<!#{発言頭})(?<!#{丸括弧前後ok文字})#{開き丸括弧}/o,
  /#{閉じ丸括弧}(?!#{丸括弧前後ok文字})(?!$)/o,
  文末で括弧を閉じる場合 = /。#{閉じ丸括弧}。/o,
  括弧笑の後の句点 = /笑#{閉じ丸括弧}。$/o,
  単独の三点リーダ = /(?<!#{三点リーダ})#{三点リーダ}(?!#{三点リーダ})/o,
  文末の三点リーダ = /#{三点リーダ}$/o,
  段落中の疑問符・感嘆符 = /#{疑問符・感嘆符}(?!$)(?![　#{疑問符・感嘆符}#{閉じ括弧類}])/o,
  全角括弧 = /[（）]/o,
]
invalid_pattern = Regexp.union(*union)

括弧の前後にあると空白を入れない文字 = "[#{句読点}#{開き括弧類}#{閉じ括弧類}]"
union = [
  /#{三点リーダ} #{開き丸括弧}/o,
  /#{括弧の前後にあると空白を入れない文字} #{開き丸括弧}/o,
  /#{閉じ丸括弧} #{括弧の前後にあると空白を入れない文字}/o,
]
不要な空白 = Regexp.union(*union)

count = 0
fn = false
last_hrule = false
toc_check = false
STDOUT.set_encoding(Encoding.locale_charmap)
ARGF.each do |line|
  matched = false
  line.gsub!(空白抜け) do
    matched = true
    count += 1
    "\e[7m \e[m"
  end
  line.gsub!(invalid_pattern) do
    matched = true
    count += 1
    "\e[31m#{$&}\e[m"
  end
  line.gsub!(不要な空白) do
    matched = true
    count += 1
    "\e[32m#{$&}\e[m"
  end
  line.gsub!(/TODO/) do
    matched = true
    count += 1
    "\e[33m#{$&}\e[m"
  end
  line.gsub!(/(?<left>\[\[(.*?\|)?)(?<link>.*)(?<right>\]\])/) do
    m = $~
    case m[:link]
    when %r!\Ahttps?://!
      $&
    when /[^0-9A-Za-z\-_]/
      matched = true
      count += 1
      "#{m[:left]}\e[34m#{m[:link]}\e[m#{m[:right]}"
    else
      $&
    end
  end
  line.gsub!(/\{\{toc\}\}/) do
    matched = true
    count += 1
    toc_check = true
    "\e[35m#{$&}\e[m"
  end
  if matched
    puts "#{ARGF.lineno}:#{line}"
  end

  if /\{\{fn/ =~ line
    fn = true
  end
  if /^----$/ =~ line
    last_hrule = true
  elsif /\S/ =~ line
    last_hrule = false
  end
end

if fn and not last_hrule
  count += 1
  puts "\e[7m脚注があるのに末尾に「----」がない。\e[m"
elsif not fn and last_hrule
  count += 1
  puts "\e[7m脚注がないのに末尾に「----」がある。\e[m"
end

puts "\e[35m{{toc}}\e[mの代わりに\e[35m{{toc_here}}\e[mを使ってください" if toc_check

if 0 < count
  puts "#{count} warning(s)"
  exit(false)
end
