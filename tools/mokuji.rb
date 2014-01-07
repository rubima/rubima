#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
=begin
= 使用例
 $ ruby tools/mokuji.rb
 name: admin
 password:
 セッションを再利用するには以下のように環境変数を設定してください:
 export RUBIMA_SESSION_ID=session_id=xxxxxxxxxxxxxxxx
 何号の表紙から目次を作りますか? (例: 0010): 0010
 * [[0010-ForeWord]]
 * [[FirstStepRuby]]
 * [[0010-Hotlinks]]
 * [[0010-RubyRefactoringBrowser]]
 * [[0010-CodeReview]]
 * [[0010-YAML]]
 * [[0010-PackageManagement]]
 * [[0010-Legwork]]
 * [[0010-BundledLibraries]]
 * [[0010-YarvManiacs]]
 * [[0010-Present]]
 * [[0010-RubyNews]]
 * [[0010-RubyEventCheck]]
 * [[0010-EditorsNote]]
 $ export RUBIMA_SESSION_ID=session_id=xxxxxxxxxxxxxxxx
 $ ruby tools/mokuji.rb
 何号の表紙から目次を作りますか? (例: 0010): 0010
 * [[0010-ForeWord]]
 * [[FirstStepRuby]]
 * [[0010-Hotlinks]]
 * [[0010-RubyRefactoringBrowser]]
 * [[0010-CodeReview]]
 * [[0010-YAML]]
 * [[0010-PackageManagement]]
 * [[0010-Legwork]]
 * [[0010-BundledLibraries]]
 * [[0010-YarvManiacs]]
 * [[0010-Present]]
 * [[0010-RubyNews]]
 * [[0010-RubyEventCheck]]
 * [[0010-EditorsNote]]
 $ ruby tools/mokuji.rb 0010
 * [[0010-ForeWord]]
 * [[FirstStepRuby]]
 * [[0010-Hotlinks]]
 * [[0010-RubyRefactoringBrowser]]
 * [[0010-CodeReview]]
 * [[0010-YAML]]
 * [[0010-PackageManagement]]
 * [[0010-Legwork]]
 * [[0010-BundledLibraries]]
 * [[0010-YarvManiacs]]
 * [[0010-Present]]
 * [[0010-RubyNews]]
 * [[0010-RubyEventCheck]]
 * [[0010-EditorsNote]]
 $
=end

require 'cgi/util'
require 'net/http'
require 'uri'

class RubiMa
  attr_reader :cookie

  def initialize(cookie=nil)
    @cookie = cookie || fetch_cookie
  end

  def build_params
    require 'io/console'
    params = {}
    STDERR.write 'name: '
    params['name'] = STDIN.gets.chomp
    STDERR.write 'password: '
    params['password'] = STDIN.noecho(&:gets).chomp
    puts
    params
  end

  def fetch_cookie(params=build_params)
    login_uri = URI('http://magazine.rubyist.net/?c=login')
    res = Net::HTTP.post_form(login_uri, params)
    body = res.body
    charset = res.type_params['charset']
    body.force_encoding(Encoding::UTF_8)
    if /ユーザ名またはパスワードが間違っています。/ =~ body
      raise "ユーザ名またはパスワードが間違っています。"
    end
    res.fetch('set-cookie')
  end

  def get(uri)
    http = Net::HTTP.new(uri.hostname, uri.port)
    http.set_debug_output($stderr) if $DEBUG
    req = Net::HTTP::Get.new(uri)
    req['Cookie'] = cookie
    http.request(req)
  end

  def get_src(page)
    res = get(URI("http://magazine.rubyist.net/?c=edit;p=#{page}"))
    res.value
    body = res.body
    charset = res.type_params['charset']
    body.force_encoding(charset)
    contents = body[/<textarea.*?>(.*?)</m, 1]
    unless contents
      if /Permission denied/ =~ body
        raise "Permission denied"
      end
      raise "Unknown Error"
    end
    if contents.empty?
      raise "空のページです。"
    end
    CGI.unescapeHTML(contents)
  end
end

if __FILE__ == $0
  cookie = ENV['RUBIMA_SESSION_ID']
  rubima = RubiMa.new(cookie)
  unless cookie
    puts "セッションを再利用するには以下のように環境変数を設定してください:"
    puts "export RUBIMA_SESSION_ID=#{rubima.cookie}"
  end

  page = ARGV.shift
  unless page
    STDERR.write "何号の表紙から目次を作りますか? (例: 0010): "
    page = STDIN.gets.chomp
  end
  body = rubima.get_src(page)
  body.scan(/^!!.+\[\[(?:.+\|)?(.+)\]\]/) do
    puts "* [[#{$1}]]"
  end
end
