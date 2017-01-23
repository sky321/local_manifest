This is the local manifest for Nvertigo/OSS for oneplus3t.

The repos are optimized for oneplus3t and does NOT work
for oneplus3.

git clone this wherever you want and make symblic links
to .repo/local_manifest for xml file/files.

oneplus3t.xml: imports all neccessary files (including
               blobs) to build oss for oneplus3t

zz-remove-unused.xml: removes darwin and hammerhead-kernel;
                      it's not mandatory, but makes syncs
		      smaller

my_build.sh: build script (CCACHEDIR points to ~/.ccache;
             size is set to 50 Gb; it generates otapackage)

pull_library.sh: pulls blobs from
                 /usr/local/src/oxygen-4.0.2/[system|boot]
		 instead of adb
