Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9A9A7bw024388
 for <selinux@tycho.nsa.gov>; Sat, 10 Oct 2015 05:10:07 -0400
Received: by pablk4 with SMTP id lk4so108757224pab.3
 for <selinux@tycho.nsa.gov>; Sat, 10 Oct 2015 02:10:04 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Fix parallel build with swig python
Date: Sat, 10 Oct 2015 17:09:51 +0800
Message-Id: <1444468191-15852-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 966855d9a1f7b758 added selinux.py as a requirement for pywrap.
This file is generated during the swig step but there is no explicit
rule in the Makefile so parallel build fails. This adds another rule
so the ordering is correct.

jason@meriadoc ~/code/gentoo/selinux/libselinux $ make -j3 pywrap
.... SNIP ....
sed -e 's/@VERSION@/2.4/; s:@prefix@:/usr:; s:@libdir@:lib:; s:@includedir@:/usr/include:' < libselinux.pc.in > libselinux.pc
bash exception.sh > selinuxswig_python_exception.i
make[1]: *** No rule to make target 'selinux.py', needed by 'pywrap'.  Stop.
make[1]: *** Waiting for unfinished jobs....
make[1]: Leaving directory '/home/jason/code/gentoo/selinux/libselinux/src'
Makefile:36: recipe for target 'pywrap' failed
make: *** [pywrap] Error 2

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libselinux/src/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index a81acc7..feab561 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -29,11 +29,12 @@ LIBPC=libselinux.pc
 SWIGIF= selinuxswig_python.i selinuxswig_python_exception.i
 SWIGRUBYIF= selinuxswig_ruby.i
 SWIGCOUT= selinuxswig_wrap.c
+SWIGPYOUT= selinux.py
 SWIGRUBYCOUT= selinuxswig_ruby_wrap.c
 SWIGLOBJ:= $(patsubst %.c,$(PYPREFIX)%.lo,$(SWIGCOUT))
 SWIGRUBYLOBJ:= $(patsubst %.c,%.lo,$(SWIGRUBYCOUT)) 
 SWIGSO=$(PYPREFIX)_selinux.so
-SWIGFILES=$(SWIGSO) selinux.py
+SWIGFILES=$(SWIGSO) $(SWIGPYOUT)
 SWIGRUBYSO=$(RUBYPREFIX)_selinux.so
 LIBSO=$(TARGET).$(LIBVERSION)
 AUDIT2WHYLOBJ=$(PYPREFIX)audit2why.lo
@@ -135,6 +136,8 @@ $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
 $(SWIGCOUT): $(SWIGIF)
 	$(SWIG) $<
 
+$(SWIGPYOUT): $(SWIGCOUT)
+
 $(SWIGRUBYCOUT): $(SWIGRUBYIF)
 	$(SWIGRUBY) $<
 
@@ -154,7 +157,7 @@ install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
 	install -m 755 $(SWIGSO) $(PYLIBDIR)/site-packages/selinux/_selinux.so
 	install -m 755 $(AUDIT2WHYSO) $(PYLIBDIR)/site-packages/selinux/audit2why.so
-	install -m 644  selinux.py $(PYLIBDIR)/site-packages/selinux/__init__.py
+	install -m 644 $(SWIGPYOUT) $(PYLIBDIR)/site-packages/selinux/__init__.py
 
 install-rubywrap: rubywrap
 	test -d $(RUBYINSTALL) || install -m 755 -d $(RUBYINSTALL) 
-- 
2.4.9
