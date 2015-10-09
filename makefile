VERSION=3.0.0

compile:
	mkdir -p src/openshift
	cd src/openshift && git clone git://github.com/openshift/origin  # Replace <forkid> with the your github id
	cd src/openshift/origin && make clean build
	cp -Rv src/openshift/origin/_output/local/bin/linux/amd64 build/opt/miracle
	mv build/opt/miracle/amd64 build/opt/miracle/openshift

package-rpm:
	cd build && fpm --before-install=../before_install.sh --after-install=../after_install.sh --after-remove=../after_remove.sh --rpm-user=openshift --rpm-group=openshift -n openshift -v ${VERSION} -s dir -t rpm opt etc
	mv build/openshift-${VERSION}-1.x86_64.rpm .
