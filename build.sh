#!/bin/bash -e
echo "Generating ruby model using genrubyfrompy.py"
python genrubyfrompy.py || (echo "Failed to generate ruby model"; exit 1)

version=`cat pysdk/VERSION`

cat << EOF > lib/acirb/version.rb
module ACIrb
  VERSION = '${version}'
end
EOF

echo "Building gem"
gem build acirb.gemspec || (echo "Failed to build gem"; exit 1)
cp -v *.gem gems
echo "Generated gem for $version"
# sudo gem install --no-ri --no-rdoc acirb-${version}.gem
