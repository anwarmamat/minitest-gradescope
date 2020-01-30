apt-get -y install ruby

cd /autograder/source/minitest-gradescope-plugin
gem install gradescope
cd /
export GRADESCOPE_PATH=/autograder/source/
