Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7BF4DrT010920
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2004 11:04:14 -0400 (EDT)
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i7BF4C5L009086
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2004 15:04:12 GMT
Subject: Bug in SE-coreutils=5.0.91-2.new.se1 ?
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
Cc: Toni Timonen <ttimonen@users.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-EfvenXVTEWEwZuTCuWme"
Message-Id: <1092236631.2790.226.camel@debby>
Mime-Version: 1.0
Date: Wed, 11 Aug 2004 17:03:51 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-EfvenXVTEWEwZuTCuWme
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi All

I tried to compile coreutils with selinux support:
It only worked after applying the coreutils-ftbfs.patch
from
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=259282 

--->    Toni Timonen:
Thanks for this patch: You definitely saved my day, as it seems. ....
:)     <---

The whole issue might be one of the "wrong" automake version: IIRC the
build that failed in the following used automake 1.8, whereas automake
1.7 seems to be used after applying Toni's patch, IINM .... But this is
a wild guess, without really knowing what's going on ... (I did't make
logs for the builds this time)


Details:
$ ls -l `which gcc`
lrwxrwxrwx  1 root root 7 Aug 11 14:24 /usr/bin/gcc -> gcc-3.3


              Building a default Debian coreutils successfully

# apt-get build-dep coreutils
Reading Package Lists... Done
Building Dependency Tree... Done
0 upgraded, 0 newly installed, 0 to remove and 159 not upgraded.

apt-get source coreutils 
cd coreutils-5.2.1
dpkg-buildpackage -rfakeroot

The above happily ends with these binaries:
coreutils_5.2.1-2_powerpc.deb
fileutils_5.2.1-2_all.deb
shellutils_5.2.1-2_all.deb
textutils_5.2.1-2_all.deb


                     Failed build of SE-coreutils:


I then tried to build the packages above with selinux support:

apt-get source coreutils=5.0.91-2.new.se1
cd coreutils-5.0.91/
dpkg-buildpackage -rfakeroot

Result: No binaries, but this error at the end of the build:

----------------------------------------------------------------
then mv -f ".deps/tail.Tpo" ".deps/tail.Po"; else rm -f ".deps/tail.Tpo"; exit 1; fi
powerpc-linux-gcc  -g -DSYSLOG_SUCCESS -DSYSLOG_FAILURE -DSYSLOG_NON_ROOT -O2   -o tail  tail.o ../lib/libfetish.a  ../lib/libfetish.a -lm  -lrt none required 
powerpc-linux-gcc: none: No such file or directory
powerpc-linux-gcc: required: No such file or directory
make[4]: *** [tail] Error 1
make[4]: Leaving directory `/home/shorty/coreut-default/coreutils-5.0.91/build-tree/coreutils-5.0.91/src'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/home/shorty/coreut-default/coreutils-5.0.91/build-tree/coreutils-5.0.91/src'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/shorty/coreut-default/coreutils-5.0.91/build-tree/coreutils-5.0.91'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/shorty/coreut-default/coreutils-5.0.91/build-tree/coreutils-5.0.91'
make: *** [build-stamp] Error 2
---------------------------------------------------------------

  

                        Happy End:

For this build I didn't download the SE-sources for the package again: 
I simply deleted anything but

coreutils_5.0.91-2.new.se1.diff.gz
coreutils_5.0.91-2.new.se1.dsc
coreutils_5.0.91.orig.tar.gz

in the dir and then did a 
apt-get source coreutils=5.0.91-2.new.se1
to unpack the source, as I hope ...

cd coreutils-5.0.91/
cp /home/shorty/uploads/coreutils-ftbfs.patch .

$ patch -p1 < coreutils-ftbfs.patch 
patching file debian/rules

dpkg-buildpackage -rfakeroot
then ended with these packages:

coreutils_5.0.91-2.new.se1_powerpc.deb
fileutils_5.0.91-2.new.se1_all.deb
shellutils_5.0.91-2.new.se1_all.deb
textutils_5.0.91-2.new.se1_all.deb

So what is this?

     1.  Was it my mistake when the unpatched build in "Failed build of
        SE-coreutils" above didn't work?
     2. Is the necessity to apply the coreutils-ftbfs.patch for a
        successful SE-coreutils build only one that applies to ppc? Or
        are there others with the same, or similar, error on different
        hardware?
     3. Is it a bad idea to patch the source in coreutils proper so
        people do not have the hassle of having to find out the cause of
        the build error I had? If not I'd simply offer the
        coreutils-ftbfs.patch on my download dir on
        <http://home.t-online.de/home/520050060325-0001/> ?
     4. Or is the whole coreutils_5.0.91-2.new.se1 so dated that it's
        better to not offer it for downloading and installing it?

Thanks in anticipation.

Best Regards
Wolfgang


PS: 
I tried my best to paste the commands I entered plus the output
resulting as correct as possible to this message: Please let me know if
you find inconsistencies in the above, as I'm not always sure what my
MUA ("Ximian Evolution") really is doing with every keystroke I'm
typing  ... 

-- System Information:
Debian Release: 3.1
  APT prefers unstable
  APT policy: (990, 'unstable')
Architecture: powerpc (ppc)
Kernel: Linux 2.4.25-ben1
Locale: LANG=C, LC_CTYPE=C

Versions of packages coreutils depends on:
pi  libacl1                     2.2.23-1     Access control list shared library
ii  libc6                       2.3.2.ds1-15 GNU C Library: Shared libraries an

-- no debconf information

-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer

--=-EfvenXVTEWEwZuTCuWme
Content-Disposition: attachment; filename=coreutils-ftbfs.patch
Content-Type: text/x-patch; name=coreutils-ftbfs.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -u coreutils-5.0.91/debian/rules coreutils-5.0.91/debian/rules
--- coreutils-5.0.91/debian/rules
+++ coreutils-5.0.91/debian/rules
@@ -29,7 +29,7 @@
 configure-stamp: $(patched)
 	dh_testdir
 
-	cd $(BUILD_TREE) && aclocal -I m4 && autoconf
+	cd $(BUILD_TREE) && aclocal-1.7 -I m4 && autoconf
 
 	cd $(BUILD_TREE) && CFLAGS=$(CFLAGS) \
 		LDFLAGS=$(LDFLAGS) ./configure \

--=-EfvenXVTEWEwZuTCuWme--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
