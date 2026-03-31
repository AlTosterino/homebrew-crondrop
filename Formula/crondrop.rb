class Crondrop < Formula
  desc "Desktop eye-drop reminder app with a CLI-first workflow"
  homepage "https://github.com/AlTosterino/crondop"
  license "MIT"
  version "0.1.4"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.4/crondrop-macos-aarch64.tar.gz"
    sha256 "feb2adf95a73a9b41e402d36765af99c29ac63a67ab03985beeb94cd8e3c8f2c"
  end

  on_linux do
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.4/crondrop-linux-x86_64.tar.gz"
    sha256 "74b574f1ced8c242121774636c0624aaf159d4a432d9d31b42be8458c0dd566b"
  end

  def install
    bin.install Dir["*/crondrop"].fetch(0)

    readme = Dir["*/README-packaging.md"].first
    doc.install readme if readme

    summary = Dir["*/SUMMARY.MD"].first
    doc.install summary if summary

    plist = Dir["*/com.crondrop.plist"].first
    prefix.install plist if OS.mac? && plist

    desktop = Dir["*/crondrop.desktop"].first
    prefix.install desktop if OS.linux? && desktop
  end

  test do
    assert_match "A friendly CLI-first eye drop reminder", shell_output("#{bin}/crondrop --help")
  end
end
