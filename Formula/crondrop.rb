class Crondrop < Formula
  desc "Desktop eye-drop reminder app with a CLI-first workflow"
  homepage "https://github.com/AlTosterino/crondop"
  license "MIT"
  version "0.1.7"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.7/crondrop-macos-aarch64.tar.gz"
    sha256 "e35428dd3384c2a225e062509d6da03086ba5bd4e664a8a4f9152f90642a9bfa"
  end

  on_linux do
    url "https://github.com/AlTosterino/crondop/releases/download/v0.1.7/crondrop-linux-x86_64.tar.gz"
    sha256 "593a0642f154402d2b5497de1dcd4543bd2f5013d341dd4be1a1f7a4ff030fd7"
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
