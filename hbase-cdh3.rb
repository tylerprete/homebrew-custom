require 'formula'

class Hbase < Formula
  homepage 'http://hbase.apache.org'
  url 'http://archive.cloudera.com/cdh/3/hbase-0.90.6-cdh3u5.tar.gz'
  sha1 '630f44a1f95cd28b78d631feef1552635591ddf3'

  depends_on 'hadoop-cdh3'

  def install
    rm_f Dir["bin/*.bat"]
    libexec.install %w[bin conf docs lib hbase-webapps]
    libexec.install Dir['*.jar']
    bin.write_exec_script Dir["#{libexec}/bin/*"]

    inreplace "#{libexec}/conf/hbase-env.sh",
      "# export JAVA_HOME=/usr/java/jdk1.6.0/",
      "export JAVA_HOME=\"$(/usr/libexec/java_home)\""
  end

  def caveats; <<-EOS.undent
    Requires Java 1.6.0 or greater.

    You must also edit the configs in:
      #{libexec}/conf
    to reflect your environment.

    For more details:
      http://wiki.apache.org/hadoop/Hbase
    EOS
  end
end
