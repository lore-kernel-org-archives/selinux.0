Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA5LOFVD004762
 for <selinux@tycho.nsa.gov>; Sat, 5 Nov 2016 17:24:15 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 7C57F5648C1
 for <selinux@tycho.nsa.gov>; Sat,  5 Nov 2016 22:24:13 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libselinux,
 libsemanage: remove *swig_python_exception.i if its creation failed
Date: Sat,  5 Nov 2016 22:24:03 +0100
Message-Id: <20161105212403.30462-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When compiling libselinux with CC=clang, "make pywrap" reports the
following message:

    bash exception.sh > selinuxswig_python_exception.i
    clang-3.9: error: no such file or directory: 'temp.aux'
    awk: fatal: cannot open file `temp.aux' for reading (No such file or
    directory)

This does not make the build fail as exception.sh returns an "OK"
status. Use "bash -e" with this script to make it return an error value.

In order not to keep an empty selinuxswig_python_exception.i file after
a build fails (which would make a second run of "make pywrap" incorrectly
succeed), remove the file when exception.sh fails.

As libsemanage uses the same code to build
semanageswig_python_exception.i, modify its Makefile too.

By the way, on Linux clang does not seem to currently support -aux-info
so it cannot be used to craft selinuxswig_python_exception.i.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/Makefile  | 2 +-
 libsemanage/src/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index b92fe1c8f5f9..24946cee8a01 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -140,7 +140,7 @@ $(LIBPC): $(LIBPC).in ../VERSION
 	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 selinuxswig_python_exception.i: ../include/selinux/selinux.h
-	bash exception.sh > $@ 
+	bash -e exception.sh > $@ || (rm -f $@ ; false)
 
 $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 55e3f469b0ba..cd29a8abf5ab 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -98,7 +98,7 @@ $(LIBPC): $(LIBPC).in ../VERSION
 	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 semanageswig_python_exception.i: ../include/semanage/semanage.h
-	bash exception.sh > $@
+	bash -e exception.sh > $@ || (rm -f $@ ; false)
 
 conf-scan.c: conf-scan.l conf-parse.h
 	$(LEX) $(LFLAGS) -t $< > $@
-- 
2.10.2
