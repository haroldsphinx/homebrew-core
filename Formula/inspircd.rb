class Inspircd < Formula
  desc "Modular C++ Internet Relay Chat daemon"
  homepage "https://www.inspircd.org/"
  url "https://github.com/inspircd/inspircd/archive/v3.9.0.tar.gz"
  sha256 "5bda0fc3d41908cda4580de39d62e8be4840da45f31e072cfca337b838add567"
  license "GPL-2.0-only"

  livecheck do
    url "https://github.com/inspircd/inspircd.git"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 arm64_big_sur: "704e9f33f97071ca2673b7d4e80b068cea5c48e7958bffefd701ac7f44c540f0"
    sha256 big_sur:       "aab78f20c01a81d9b8c5a153e5ba9d629e74d9156d0e0c077e266d18e97228b5"
    sha256 catalina:      "9eb14778f35342c7e9ca7b6e17db90ad0ec763da02318b8d4ff15c3b70232504"
    sha256 mojave:        "35d846f23095493edd191b76aa873176fe4dfda4d8fad99fb8a17a556f8b29fc"
  end

  depends_on "pkg-config" => :build

  skip_clean "data"
  skip_clean "logs"

  def install
    system "./configure", "--enable-extras=ldap"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match("ERROR: Cannot open config file", shell_output("#{bin}/inspircd", 2))
  end
end
