# homebrew-spark-tap

## Installation
brew tap Laurengcy/spark-tap
brew install apache-spark@2.4.6


If you need to set SPARK_HOME, use $(brew --prefix apache-spark@VERSION_NUMBER)/libexec, e.g.:
```bash
export SPARK_HOME=$(brew --prefix apache-spark@2.2.0)/libexec
```