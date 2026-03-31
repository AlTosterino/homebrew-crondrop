class Crondrop < Formula
  desc "Desktop eye-drop reminder app with a CLI-first workflow"
  homepage "https://github.com/AlTosterino/crondop"
  license "MIT"
  version "0.1.3"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.3/crondrop-macos-aarch64.tar.gz"
    sha256 "12a05343c06186f9f87171eae70b2db88588af2f95fcee675d5f5fbe78c9bded"
  end

  on_linux do
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.3/crondrop-linux-x86_64.tar.gz"
    sha256 "f2c3c982303a9c9d26b6d9c6ea51084102b9ead4e76686b328c54d6df33a92b5"
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
