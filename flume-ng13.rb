require 'formula'

class FlumeNg13 < Formula
  homepage 'https://github.com/apache/flume'
  url 'http://apache.cs.utah.edu/flume/1.3.1/apache-flume-1.3.1-bin.tar.gz'
  version "1.3.1"
  md5 '09362a5a8ed92c6fb0bfbdb2802301db'

  def install
    system "mvn", "compile"
    libexec.install %w[bin conf lib]
    (bin/"flume-ng").write <<-EOS.undent
      #!/bin/bash
      export FLUME_CONF_DIR=${FLUME_CONF_DIR-#{libexec}/conf}
      exec #{libexec}/bin/flume-ng "$@"
    EOS
    system "wget", "-O #{libexec}/lib/jets3t-0.7.1.jar", "http://repo1.maven.org/maven2/net/java/dev/jets3t/jets3t/0.7.1/jets3t-0.7.1.jar"
  end

  def caveats; <<-EOS.undent
    See https://cwiki.apache.org/FLUME/getting-started.html for example configurations.
    Your flume config dir is #{libexec}/conf/

    If you intend to sink data to S3, you will need to download a missing JAR:
        wget -O #{libexec}/lib/jets3t-0.7.1.jar http://repo1.maven.org/maven2/net/java/dev/jets3t/jets3t/0.7.1/jets3t-0.7.1.jar
    EOS
  end

  def test
    system "#{bin}/flume-ng"
  end
end
