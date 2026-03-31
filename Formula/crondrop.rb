class Crondrop < Formula
  desc "Desktop eye-drop reminder app with a CLI-first workflow"
  homepage "https://github.com/AlTosterino/crondop"
  license "MIT"
  version "0.1.5"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.5/crondrop-macos-aarch64.tar.gz"
    sha256 "9b9100323ad44025f81e928b611d66234a687f1503c46fa5e8cb38596ad16c6e"
  end

  on_linux do
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.5/crondrop-linux-x86_64.tar.gz"
    sha256 "d859ae943858d3eef5073b9365ed9f014619ec8cb79f82a135dddb1623277a42"
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
