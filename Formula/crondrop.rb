class Crondrop < Formula
  desc "Desktop eye-drop reminder app with a CLI-first workflow"
  homepage "https://github.com/AlTosterino/crondop"
  license "MIT"
  version "0.1.8"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.8/crondrop-macos-aarch64.tar.gz"
    sha256 "ae5aad009794e9b35b2652b6a80aebd0918ef1eff7176ff6650180c1f57db19a"
  end

  on_linux do
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.8/crondrop-linux-x86_64.tar.gz"
    sha256 "e1996a82af4effb82a084099a8f91ad83c05267ce433d9f7a210965b5af29405"
  end

  def install
    binary = Dir["crondrop", "*/crondrop"].find { |path| File.file?(path) }
    odie "crondrop binary not found in release archive" unless binary

    bin.install binary => "crondrop"

    readme = Dir["README-packaging.md", "*/README-packaging.md"].find { |path| File.file?(path) }
    doc.install readme if readme

    summary = Dir["SPEC.md", "SUMMARY.MD", "*/SPEC.md", "*/SUMMARY.MD"].find { |path| File.file?(path) }
    doc.install summary if summary

    plist = Dir["com.crondrop.plist", "*/com.crondrop.plist"].find { |path| File.file?(path) }
    prefix.install plist if OS.mac? && plist

    desktop = Dir["crondrop.desktop", "*/crondrop.desktop"].find { |path| File.file?(path) }
    prefix.install desktop if OS.linux? && desktop
  end

  test do
    assert_match "A friendly CLI-first eye drop reminder", shell_output("#{bin}/crondrop --help")
  end
end
