This is the local manifest for Nvertigo/LineageOS cm-14.1 for oneplus3t.

The repos are optimized for oneplus3t and does NOT work
for oneplus3.

git clone this wherever you want and make symblic links
to .repo/local_manifest for xml file/files.

oneplus3t.xml: imports all neccessary files (including
               blobs and toolchains) to build laos for op3t

zz-remove-unused.xml: removes darwin build environment;
                      it's not mandatory, but makes syncs
		      smaller

