require 'formula'

class FlumeNg14 < Formula
  homepage 'https://github.com/apache/flume'
  url 'http://apache.cs.utah.edu/flume/1.4.0/apache-flume-1.4.0-bin.tar.gz'
  version "1.4.0"
  sha1 '4a23ae9c5f377b3121d7b46dfb1df5137e9dc151'

  def install
    libexec.install %w[bin conf lib]
    (bin/"flume-ng").write <<-EOS.undent
      #!/bin/bash
      export FLUME_CONF_DIR=${FLUME_CONF_DIR-#{libexec}/conf}
      exec #{libexec}/bin/flume-ng "$@"
    EOS
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
