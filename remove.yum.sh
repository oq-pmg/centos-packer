for package in `cat remove.yum` ; do yum erase -y $package ; done
