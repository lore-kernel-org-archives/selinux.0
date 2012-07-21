Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6LDDmZR012539
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2012 09:13:49 -0400
Received: from [192.168.1.64] (151.76.19.83) by cp-out8.libero.it (8.5.133)
        id 5007ADF60054D7D0 for selinux@tycho.nsa.gov; Sat, 21 Jul 2012 15:13:45 +0200
Message-ID: <1342876424.2430.7.camel@vortex>
Subject: [PATCH]: fix symbolic links creation to the shared libraries
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@tycho.nsa.gov
Date: Sat, 21 Jul 2012 15:13:44 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

The current Makefiles for the userspace libraries only install correct
symbolic links to the shared libraries when a two-level (relatively to
the root directory) SHLIBDIR is used.

The attached patch can be easily modified to avoid using sed at no
functional difference (it would not be able to remove multiple
consecutive slash).

Fix the creation of symbolic links to the shared libraries during installation.

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

---
 libselinux/src/Makefile  |    2 +-
 libsemanage/src/Makefile |    2 +-
 libsepol/src/Makefile    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- selinux-20072012-new/libselinux/src/Makefile	2012-07-20 17:53:02.813866482 +0200
+++ selinux-20072012/libselinux/src/Makefile	2012-07-21 15:03:10.021932875 +0200
@@ -153,7 +153,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	cd $(LIBDIR) && ln -sf `echo $(SHLIBDIR)/$(LIBSO) | sed 's/\/\/\{1,\}/\//g'` $(TARGET)
 
 install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
--- selinux-20072012-new/libsepol/src/Makefile	2012-06-18 18:54:45.693499604 +0200
+++ selinux-20072012/libsepol/src/Makefile	2012-07-21 15:03:26.511290822 +0200
@@ -43,7 +43,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	cd $(LIBDIR) && ln -sf `echo $(SHLIBDIR)/$(LIBSO) | sed 's/\/\/\{1,\}/\//g'` $(TARGET)
 
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
--- selinux-20072012-new/libsemanage/src/Makefile	2012-07-20 17:59:42.522639128 +0200
+++ selinux-20072012/libsemanage/src/Makefile	2012-07-21 15:03:39.064560974 +0200
@@ -146,7 +146,7 @@ install: all
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
 	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	cd $(LIBDIR) && ln -sf `echo $(SHLIBDIR)/$(LIBSO) | sed 's/\/\/\{1,\}/\//g'` $(TARGET)
 
 install-pywrap: pywrap 
 	test -d $(PYLIBDIR)/site-packages || install -m 755 -d $(PYLIBDIR)/site-packages


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
