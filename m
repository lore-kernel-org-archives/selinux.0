Subject: RE: Patching SRPM utilities produces rejects on RH9
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Kratzer, James R." <JamesK@xetron.com>
Cc: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A36@s3cin>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A36@s3cin>
Content-Type: text/plain
Message-Id: <1063309671.16884.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 11 Sep 2003 15:47:51 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-09-11 at 15:32, Kratzer, James R. wrote:
> I don't believe that the SRPMS are already patched and here is why.  Of the
> 9 hunks in the patch, 8 are successful and 1 fails.  Comparing the original
> source file (login.c.orig) to the patched source file (login.c) I can see
> that applying the patch has added "#ifdef WITH_SELINUX" blocks to the
> original source file.  If the original soruce files (those SRPMS included
> with the userland archive) are already patched, where are the "#ifdef
> WITH_SELINUX" blocks in the original file? What am I missing here?

$ wget http://www.nsa.gov/selinux/archives/selinux-usr-2003081307.tgz
<snip>
15:42:46 (122.47 KB/s) - `selinux-usr-2003081307.tgz' saved [23578929/23578929]

$ tar xzf selinux-usr-2003081307.tgz
$ cd selinux-usr/SRPMS
$ rpm -ivh util-linux-2.11y-19.src.rpm
<snip>
1:util-linux             ########################################### [100%]

$ grep selinux /usr/src/redhat/SPECS/util-linux.spec
Patch132: util-linux-selinux.patch
%patch132 -p1 -b .selinux

$ ls -l /usr/src/redhat/SOURCES/util-linux-selinux.patch
-rw-rw-r--    1 root     root        14372 Jul  9 13:19 /usr/src/redhat/SOURCES/util-linux-selinux.patch

$ cd /usr/src/redhat/SPECS
$ rpmbuild -bp util-linux.spec
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.74796
+ umask 022
+ cd /usr/src/redhat/BUILD
+ LANG=C
+ export LANG
+ cd /usr/src/redhat/BUILD
+ rm -rf util-linux-2.11y
+ /usr/bin/bzip2 -dc /usr/src/redhat/SOURCES/util-linux-2.11y.tar.bz2
+ tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd util-linux-2.11y
+ /usr/bin/gzip -dc /usr/src/redhat/SOURCES/kbdrate.tar.gz
+ tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ /usr/bin/gzip -dc /usr/src/redhat/SOURCES/floppy-0.12.tar.gz
+ tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
++ /usr/bin/id -u
+ '[' 0 = 0 ']'
+ /bin/chown -Rhf root .
++ /usr/bin/id -u
+ '[' 0 = 0 ']'
+ /bin/chgrp -Rhf root .
+ /bin/chmod -Rf a+rX,g-w,o-w .
+ echo 'Patch #0 (util-linux-2.11y-rhconfig.patch):'
Patch #0 (util-linux-2.11y-rhconfig.patch):
+ patch -p1 -b --suffix .rhconfig -s
+ echo 'Patch #1 (util-linux-2.11r-nochkdupexe.patch):'
Patch #1 (util-linux-2.11r-nochkdupexe.patch):
+ patch -p1 -b --suffix .nochkdupexe -s
+ echo 'Patch #2 (util-linux-2.11a-gecossize.patch):'
Patch #2 (util-linux-2.11a-gecossize.patch):
+ patch -p1 -b --suffix .gecos -s
+ echo 'Patch #4 (util-linux-2.11n-mount.patch):'
Patch #4 (util-linux-2.11n-mount.patch):
+ patch -p1 -b --suffix .mount -s
+ echo 'Patch #21 (util-linux-2.9v-nonroot.patch):'
Patch #21 (util-linux-2.9v-nonroot.patch):
+ patch -p1 -b --suffix .nonroot -s
+ echo 'Patch #27 (util-linux-2.11w-moretc.patch):'
Patch #27 (util-linux-2.11w-moretc.patch):
+ patch -p1 -b --suffix .moretc -s
+ echo 'Patch #70 (util-linux-2.11r-miscfixes.patch):'
Patch #70 (util-linux-2.11r-miscfixes.patch):
+ patch -p1 -b --suffix .miscfixes -s
+ cp /usr/src/redhat/SOURCES/cramfs.h /usr/src/redhat/SOURCES/mkcramfs.c .
+ echo 'Patch #100 (mkcramfs.patch):'
Patch #100 (mkcramfs.patch):
+ patch -p1 -b --suffix .mkcramfs -s
+ echo 'Patch #101 (mkcramfs-quiet.patch):'
Patch #101 (mkcramfs-quiet.patch):
+ patch -p1 -b --suffix .quiet -s
+ echo 'Patch #102 (util-linux-2.11n-mkcramfs-pgsize.patch):'
Patch #102 (util-linux-2.11n-mkcramfs-pgsize.patch):
+ patch -p1 -b --suffix .blksize -s
+ cp /usr/src/redhat/SOURCES/nologin.c /usr/src/redhat/SOURCES/nologin.8 .
+ echo 'Patch #206 (mount-2.10r-kudzu.patch):'
Patch #206 (mount-2.10r-kudzu.patch):
+ patch -p1 -b --suffix .kudzu -s
+ sed -e 's:^MAN_DIR=.*:MAN_DIR=/usr/share/man:' -e 's:^INFO_DIR=.*:INFO_DIR=/usr/share/info:' MCONFIG
+ mv MCONFIG.new MCONFIG
+ echo 'Patch #103 (util-linux-2.11r-ownerumount.patch):'
Patch #103 (util-linux-2.11r-ownerumount.patch):
+ patch -p1 -b --suffix .ownerumount -s
+ echo 'Patch #106 (util-linux-2.11w-swaponsymlink-57300.patch):'
Patch #106 (util-linux-2.11w-swaponsymlink-57300.patch):
+ patch -p1 -b --suffix .swaponsymlink -s
+ echo 'Patch #107 (util-linux-2.11y-procpartitions-37436.patch):'
Patch #107 (util-linux-2.11y-procpartitions-37436.patch):
+ patch -p1 -b --suffix .procpartitions -s
+ echo 'Patch #109 (util-linux-2.11f-rawman.patch):'
Patch #109 (util-linux-2.11f-rawman.patch):
+ patch -p1 -b --suffix .rawman -s
+ echo 'Patch #113 (util-linux-2.11r-ctty3.patch):'
Patch #113 (util-linux-2.11r-ctty3.patch):
+ patch -p1 -b --suffix .ctty3 -s
+ echo 'Patch #116 (util-linux-2.11n-loginutmp-66950.patch):'
Patch #116 (util-linux-2.11n-loginutmp-66950.patch):
+ patch -p1 -b --suffix .loginutmp -s
+ echo 'Patch #117 (util-linux-2.11y-moremisc.patch):'
Patch #117 (util-linux-2.11y-moremisc.patch):
+ patch -p1 -b --suffix .moremisc -s
+ echo 'Patch #120 (util-linux-2.11y-skipraid2.patch):'
Patch #120 (util-linux-2.11y-skipraid2.patch):
+ patch -p1 -b --suffix .skipraid2 -s
+ echo 'Patch #123 (util-linux-2.11y-blkgetsize-81069.patch):'
Patch #123 (util-linux-2.11y-blkgetsize-81069.patch):
+ patch -p1 -b --suffix .blkgetsize -s
+ echo 'Patch #124 (util-linux-2.11y-umount-75421.patch):'
Patch #124 (util-linux-2.11y-umount-75421.patch):
+ patch -p1 -b --suffix .umount -s
+ echo 'Patch #125 (util-linux-2.11y-umask-82552.patch):'
Patch #125 (util-linux-2.11y-umask-82552.patch):
+ patch -p1 -b --suffix .umask -s
+ echo 'Patch #126 (util-linux-2.11y-multibyte.patch):'
Patch #126 (util-linux-2.11y-multibyte.patch):
+ patch -p1 -b --suffix .multibyte -s
+ echo 'Patch #127 (util-linux-2.11y-mcookie-83345.patch):'
Patch #127 (util-linux-2.11y-mcookie-83345.patch):
+ patch -p1 -b --suffix .mcookie-dumbness -s
+ echo 'Patch #128 (util-linux-2.11y-ipcs-84243-86285.patch):'
Patch #128 (util-linux-2.11y-ipcs-84243-86285.patch):
+ patch -p1 -b --suffix .ipcs -s
+ echo 'Patch #129 (util-linux-2.11y-s390x.patch):'
Patch #129 (util-linux-2.11y-s390x.patch):
+ patch -p1 -b --suffix .s390x -s
+ echo 'Patch #130 (util-linux-2.11y-login-32bit-lastlog-88574.patch):'
Patch #130 (util-linux-2.11y-login-32bit-lastlog-88574.patch):
+ patch -p1 -b --suffix .login32bitcompat -s
+ echo 'Patch #131 (util-linux-2.11y-sysmap-85407.patch):'
Patch #131 (util-linux-2.11y-sysmap-85407.patch):
+ patch -p1 -b --suffix .sysmap -s
+ echo 'Patch #132 (util-linux-selinux.patch):'
Patch #132 (util-linux-selinux.patch):
+ patch -p1 -b --suffix .selinux -s
+ exit 0

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
