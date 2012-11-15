require 'formula'

class Hive < Formula
  homepage 'http://hive.apache.org'
  url 'http://archive.cloudera.com/cdh/3/hive-0.7.1-cdh3u5.tar.gz' 
  sha1 '79e9db5b8216873c7ba49eb5d35f913920460c30'

  depends_on 'hadoop-cdh3'
  def install
    rm_f Dir["bin/*.bat"]
    libexec.install %w[bin conf examples lib ]
    libexec.install Dir['*.jar']
    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  def caveats; <<-EOS.undent
    Hadoop must be in your path for hive executable to work.
    After installation, set $HIVE_HOME in your profile:
      export HIVE_HOME=#{libexec}

    You may need to set JAVA_HOME:
      export JAVA_HOME="$(/usr/libexec/java_home)"
    EOS
  end
end
