require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Magickwand < AbstractPhp56Extension
  init
  desc "ImageMagick MagickWand API"
  homepage "http://www.magickwand.org"
  url "http://www.magickwand.org/download/php/MagickWandForPHP-1.0.9-2.tar.bz2"
  sha256 "05e5fe5bc52ab9169228bbbde38b222208d1ae19db718b66d2c7ac4180847727"
  revision 1

  bottle do
    sha256 "8e2a7968720ba00376b1ef468be7b1fdeab8dd30a6cfd856203616d986ea5be0" => :sierra
    sha256 "783c859b6ca3f07c74418d081bcecbe09915cc97ea048d8a8981ed6da150d0f3" => :el_capitan
    sha256 "d29f81c8c8bf22f0cdf2d5c32cbda4873fa683d33df8e5677e5c892431482aef" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick@6"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-magickwand=#{Formula["imagemagick@6"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/magickwand.so"
    write_config_file if build.with? "config-file"
  end
end
