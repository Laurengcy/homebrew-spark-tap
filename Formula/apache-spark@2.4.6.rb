class ApacheSparkAT246 < Formula
    desc "Engine for large-scale data processing"
    homepage "https://spark.apache.org/"
    url "https://www.apache.org/dyn/closer.lua?path=spark/spark-2.4.6/spark-2.4.6-bin-hadoop2.7.tgz"
    mirror "https://archive.apache.org/dist/spark/spark-2.4.6/spark-2.4.6-bin-hadoop2.7.tgz"
    version "2.4.6"
    sha512 '3a9f401eda9b5749cdafd246b1d14219229c26387017791c345a23a65782fb8b25a302bf4ac1ed7c16a1fe83108e94e55dad9639a51c751d81c8c0534a4a9641'
    head "https://github.com/apache/spark.git", branch: "master"
  
    bottle :unneeded
  
    depends_on "openjdk"
  
    def install
      # Rename beeline to distinguish it from hive's beeline
      mv "bin/beeline", "bin/spark-beeline"
  
      rm_f Dir["bin/*.cmd"]
      libexec.install Dir["*"]
      bin.install Dir[libexec/"bin/*"]
      bin.env_script_all_files(libexec/"bin", JAVA_HOME: Formula["openjdk"].opt_prefix)
    end
  
    test do
      assert_match "Long = 1000",
        pipe_output(bin/"spark-shell --conf spark.driver.bindAddress=127.0.0.1",
                    "sc.parallelize(1 to 1000).count()")
    end
  end
  