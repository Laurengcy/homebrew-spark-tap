class ApacheSparkAT246 < Formula
    desc "Engine for large-scale data processing"
    homepage "https://spark.apache.org/"
    url "https://www.apache.org/dyn/closer.lua?path=spark/spark-2.4.6/spark-2.4.6-bin-hadoop2.7.tgz"
    mirror "https://archive.apache.org/dist/spark/spark-2.4.6/spark-2.4.6-bin-hadoop2.7.tgz"
    version "2.4.6"
    sha256 "7174fee30057fbf226698ebfcfa7c2944a26197e149053aa29b26b250d1e1eba"
    head "https://github.com/apache/spark.git", branch: "master"
  
    bottle do
      cellar :any_skip_relocation
    end
  
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