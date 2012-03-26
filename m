Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QJnJF6025128
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:49:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id EE43B1A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:49:17 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id amgdJ+0AL96x for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 21:49:16 +0200 (CEST)
Received: from fornost.bigon.be (fornost.bigon.be [IPv6:2001:6f8:303:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id B618E1A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:49:15 +0200 (CEST)
Date: Mon, 26 Mar 2012 21:49:08 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/8] setools -- Do not build java module with a soname and
 do not generate symlinks
Message-ID: <20120326214908.585b001c@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Again no soname and symlink

Cheers,
Laurent Bigonville

Description: Do not build java module with a soname and do not generate symlinks
Author: Laurent Bigonville <bigon@debian.org>
Date: Tue, 13 Mar 2012 21:54:24 +0100

--- a/libapol/swig/java/Makefile.am
+++ b/libapol/swig/java/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = libjapol.so.@libapol_version@
+wrappedso_DATA = libjapol.so
 wrappedso_SONAME = @libapol_jswig_soname@
 short_name = libjapol.so
 wrappedsodir = $(libdir)
@@ -79,9 +79,7 @@ $(firstword $(BUILT_SOURCES)): $(dist_no
 $(wordlist 2,$(words $(BUILT_SOURCES)), $(BUILT_SOURCES)): $(firstword $(BUILT_SOURCES))
 
 $(wrappedso_DATA): $(filter %.c, $(BUILT_SOURCES))
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_JAVA_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ $(short_name)
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_JAVA_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 # Intentionally do not include SWIGTYPE_p_void.java below so that the
 # Java compiler uses the one created in package
@@ -107,8 +105,6 @@ $(wrappedjar_DATA): $(classes)
 	$(JAR) cfm $@ MANIFEST.MF $^
 
 install-data-hook:
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(wrappedso_SONAME)
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(short_name)
 	$(mkdir_p) $(DESTDIR)$(javadir) && cd $(DESTDIR)$(javadir) && $(LN_S) -f $(wrappedjardir)/$(wrappedjar_DATA)
 
 uninstall-local:
--- a/libpoldiff/swig/java/Makefile.am
+++ b/libpoldiff/swig/java/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = libjpoldiff.so.@libpoldiff_version@
+wrappedso_DATA = libjpoldiff.so
 wrappedso_SONAME = @libpoldiff_jswig_soname@
 short_name = libjpoldiff.so
 wrappedsodir = $(libdir)
@@ -54,9 +54,7 @@ $(firstword $(BUILT_SOURCES)): $(dist_no
 $(wordlist 2,$(words $(BUILT_SOURCES)), $(BUILT_SOURCES)): $(firstword $(BUILT_SOURCES))
 
 $(wrappedso_DATA): $(filter %.c, $(BUILT_SOURCES))
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_JAVA_CFLAGS) -DSWIGJAVA=1 $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ $(short_name)
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_JAVA_CFLAGS) -DSWIGJAVA=1 $(AM_LDFLAGS) $(LDFLAGS)
 
 # Intentionally do not include SWIGTYPE_p_void.java below so that the
 # Java compiler uses the one created in package
@@ -82,8 +80,6 @@ $(wrappedjar_DATA): $(classes)
 	$(JAR) cfm $@ MANIFEST.MF $^
 
 install-data-hook:
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(wrappedso_SONAME)
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(short_name)
 	$(mkdir_p) $(DESTDIR)$(javadir) && cd $(DESTDIR)$(javadir) && $(LN_S) -f $(wrappedjardir)/$(wrappedjar_DATA)
 
 uninstall-local:
--- a/libqpol/swig/java/Makefile.am
+++ b/libqpol/swig/java/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = libjqpol.so.@libqpol_version@
+wrappedso_DATA = libjqpol.so
 wrappedso_SONAME = @libqpol_jswig_soname@
 short_name = libjqpol.so
 wrappedsodir = $(libdir)
@@ -64,9 +64,7 @@ $(firstword $(BUILT_SOURCES)): $(dist_no
 $(wordlist 2,$(words $(BUILT_SOURCES)), $(BUILT_SOURCES)): $(firstword $(BUILT_SOURCES))
 
 $(wrappedso_DATA): $(filter %.c, $(BUILT_SOURCES))
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_JAVA_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ $(short_name)
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_JAVA_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 classes = $(patsubst %.java,$(package_dir)/%.class,$(filter %.java, $(BUILT_SOURCES)))
 
@@ -86,8 +84,6 @@ $(wrappedjar_DATA): $(classes)
 	$(JAR) cfm $@ MANIFEST.MF $^
 
 install-data-hook:
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(wrappedso_SONAME)
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(short_name)
 	$(mkdir_p) $(DESTDIR)$(javadir) && cd $(DESTDIR)$(javadir) && $(LN_S) -f $(wrappedjardir)/$(wrappedjar_DATA)
 
 uninstall-local:
--- a/libseaudit/swig/java/Makefile.am
+++ b/libseaudit/swig/java/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = libjseaudit.so.@libseaudit_version@
+wrappedso_DATA = libjseaudit.so
 wrappedso_SONAME = @libseaudit_jswig_soname@
 short_name = libjseaudit.so
 wrappedsodir = $(libdir)
@@ -51,9 +51,7 @@ $(firstword $(BUILT_SOURCES)): $(dist_no
 $(wordlist 2,$(words $(BUILT_SOURCES)), $(BUILT_SOURCES)): $(firstword $(BUILT_SOURCES))
 
 $(wrappedso_DATA): $(filter %.c, $(BUILT_SOURCES))
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_JAVA_CFLAGS) -DSWIGJAVA=1 $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ $(short_name)
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_JAVA_CFLAGS) -DSWIGJAVA=1 $(AM_LDFLAGS) $(LDFLAGS)
 
 # Intentionally do not include SWIGTYPE_p_void.java below so that the
 # Java compiler uses the one created in package
@@ -79,8 +77,6 @@ $(wrappedjar_DATA): $(classes)
 	$(JAR) cfm $@ MANIFEST.MF $^
 
 install-data-hook:
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(wrappedso_SONAME)
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(short_name)
 	$(mkdir_p) $(DESTDIR)$(javadir) && cd $(DESTDIR)$(javadir) && $(LN_S) -f $(wrappedjardir)/$(wrappedjar_DATA)
 
 uninstall-local:
--- a/libsefs/swig/java/Makefile.am
+++ b/libsefs/swig/java/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = libjsefs.so.@libsefs_version@
+wrappedso_DATA = libjsefs.so
 wrappedso_SONAME = @libsefs_jswig_soname@
 short_name = libjsefs.so
 wrappedsodir = $(libdir)
@@ -46,9 +46,7 @@ $(firstword $(BUILT_SOURCES)): $(dist_no
 $(wordlist 2,$(words $(BUILT_SOURCES)), $(BUILT_SOURCES)): $(firstword $(BUILT_SOURCES))
 
 $(wrappedso_DATA): $(filter %.cc, $(BUILT_SOURCES))
-	$(CXX) -shared -o $@ $^ $(AM_CXXFLAGS) $(CXXFLAGS) $(SWIG_JAVA_CFLAGS) -DSWIGJAVA=1 $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ $(short_name)
+	$(CXX) -shared -o $@ $^ $(AM_CXXFLAGS) $(CXXFLAGS) $(SWIG_JAVA_CFLAGS) -DSWIGJAVA=1 $(AM_LDFLAGS) $(LDFLAGS)
 
 # Intentionally do not include SWIGTYPE_p_void.java below so that the
 # Java compiler uses the one created in package
@@ -74,8 +72,6 @@ $(wrappedjar_DATA): $(classes)
 	$(JAR) cfm $@ MANIFEST.MF $^
 
 install-data-hook:
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(wrappedso_SONAME)
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(short_name)
 	$(mkdir_p) $(DESTDIR)$(javadir) && cd $(DESTDIR)$(javadir) && $(LN_S) -f $(wrappedjardir)/$(wrappedjar_DATA)
 
 uninstall-local:

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
