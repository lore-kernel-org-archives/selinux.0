Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QJkrO4024977
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:46:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id ED4A81A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:46:51 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DDiE-HGXYVSx for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 21:46:49 +0200 (CEST)
Received: from fornost.bigon.be (fornost.bigon.be [IPv6:2001:6f8:303:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id A90371A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:46:49 +0200 (CEST)
Date: Mon, 26 Mar 2012 21:46:46 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/8] setools -- Do not built python module with a soname and
 do not create symlinks
Message-ID: <20120326214646.525d771b@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The python modules shouldn't be created with soname. Also the symlinks
are useless

Cheers,
Laurent Bigonville

Description: Do not built python module with a soname and do not create symlinks
Author: Laurent Bigonville <bigon@debian.org>
Date: Tue, 13 Mar 2012 21:15:31 +0100

--- a/libqpol/swig/python/Makefile.am
+++ b/libqpol/swig/python/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = _qpol.so.@libqpol_version@
+wrappedso_DATA = _qpol.so
 wrappedso_SONAME = @libqpol_pyswig_soname@
 wrappedsodir = $(pkgpyexecdir)
 
@@ -12,22 +12,16 @@ BUILT_SOURCES = qpol_wrap.c
 AM_CFLAGS = @DEBUGCFLAGS@ @WARNCFLAGS@ @PROFILECFLAGS@ @SELINUX_CFLAGS@ \
 	-I$(top_builddir) -fpic \
 	-I$(top_srcdir)/libqpol/include
-AM_LDFLAGS = @DEBUGLDFLAGS@ @WARNLDFLAGS@ @PROFILELDFLAGS@ @QPOL_LIB_FLAG@ @PYTHON_LDFLAGS@
+AM_LDFLAGS = @DEBUGLDFLAGS@ @WARNLDFLAGS@ @PROFILELDFLAGS@ @QPOL_LIB_FLAG@
 
 $(BUILT_SOURCES): $(dist_noinst_DATA) $(DEPENDENCIES)
 	$(SWIG) $(SWIG_PYTHON_OPT) -o $@ $<
 
 $(wrappedso_DATA): $(BUILT_SOURCES)
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_PYTHON_CPPFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ _qpol.so
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_PYTHON_CPPFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 $(wrappedpy_DATA): $(BUILT_SOURCES)
 
-install-data-hook:
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(wrappedso_SONAME)
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) _qpol.so
-
 uninstall-local:
 	-rm -rf $(DESTDIR)$(wrappedsodir)/$(wrappedso_SONAME) $(DESTDIR)$(wrappedsodir)/_qpol.so
 
--- a/libsefs/swig/python/Makefile.am
+++ b/libsefs/swig/python/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = _sefs.so.@libsefs_version@
+wrappedso_DATA = _sefs.so
 wrappedso_SONAME = @libsefs_pyswig_soname@
 wrappedsodir = $(pkgpyexecdir)
 
@@ -11,7 +11,7 @@ BUILT_SOURCES = sefs_wrap.cc
 AM_CXXFLAGS = @DEBUGCXXFLAGS@ @WARNCXXFLAGS@ @PROFILECFLAGS@ @SELINUX_CFLAGS@ \
 	@QPOL_CFLAGS@ @APOL_CFLAGS@ -I$(top_builddir) -fpic \
 	-I$(top_srcdir)/libsefs/include
-AM_LDFLAGS = @DEBUGLDFLAGS@ @WARNLDFLAGS@ @PROFILELDFLAGS@ @PYTHON_LDFLAGS@ \
+AM_LDFLAGS = @DEBUGLDFLAGS@ @WARNLDFLAGS@ @PROFILELDFLAGS@ \
 	@APOL_LIB_FLAG@ @QPOL_LIB_FLAG@ @SEFS_LIB_FLAG@ @XML_LIBS@
 DEPENDENCIES = $(top_builddir)/libqpol/src/libqpol.so \
 	$(top_builddir)/libapol/src/libapol.so \
@@ -23,16 +23,10 @@ $(BUILT_SOURCES): $(dist_noinst_DATA) $(
 	-I$(top_srcdir)/libqpol/swig -I$(top_srcdir)/libapol/swig $<
 
 $(wrappedso_DATA): $(BUILT_SOURCES)
-	$(CXX) -shared -o $@ $^ $(AM_CXXFLAGS) $(CXXFLAGS) $(SWIG_PYTHON_CPPFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ _sefs.so
+	$(CXX) -shared -o $@ $^ $(AM_CXXFLAGS) $(CXXFLAGS) $(SWIG_PYTHON_CPPFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 $(wrappedpy_DATA): $(BUILT_SOURCES)
 
-install-data-hook:
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(wrappedso_SONAME)
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) _sefs.so
-
 uninstall-local:
 	-rm -rf $(DESTDIR)$(wrappedsodir)/$(wrappedso_SONAME) $(DESTDIR)$(wrappedsodir)/_sefs.so
 
--- a/libapol/swig/python/Makefile.am
+++ b/libapol/swig/python/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = _apol.so.@libapol_version@
+wrappedso_DATA = _apol.so
 wrappedso_SONAME = @libapol_pyswig_soname@
 wrappedsodir = $(pkgpyexecdir)
 
@@ -20,16 +20,10 @@ $(BUILT_SOURCES): $(dist_noinst_DATA) $(
 	$(SWIG) $(SWIG_PYTHON_OPT) -o $@ -I$(top_srcdir)/libapol/include -I$(top_srcdir)/libqpol/swig $<
 
 $(wrappedso_DATA): $(BUILT_SOURCES)
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_PYTHON_CPPFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ _apol.so
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_PYTHON_CPPFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 $(wrappedpy_DATA): $(BUILT_SOURCES)
 
-install-data-hook:
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(wrappedso_SONAME)
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) _apol.so
-
 uninstall-local:
 	-rm -rf $(DESTDIR)$(wrappedsodir)/$(wrappedso_SONAME) $(DESTDIR)$(wrappedsodir)/_apol.so
 
--- a/libpoldiff/swig/python/Makefile.am
+++ b/libpoldiff/swig/python/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = _poldiff.so.@libpoldiff_version@
+wrappedso_DATA = _poldiff.so
 wrappedso_SONAME = @libpoldiff_pyswig_soname@
 wrappedsodir = $(pkgpyexecdir)
 
@@ -23,16 +23,10 @@ $(BUILT_SOURCES): $(dist_noinst_DATA) $(
 	-I$(top_srcdir)/libqpol/swig -I$(top_srcdir)/libapol/swig $<
 
 $(wrappedso_DATA): $(BUILT_SOURCES)
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_PYTHON_CPPFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ _poldiff.so
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_PYTHON_CPPFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 $(wrappedpy_DATA): $(BUILT_SOURCES)
 
-install-data-hook:
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(wrappedso_SONAME)
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) _poldiff.so
-
 uninstall-local:
 	-rm -rf $(DESTDIR)$(wrappedsodir)/$(wrappedso_SONAME) $(DESTDIR)$(wrappedsodir)/_poldiff.so
 
--- a/libseaudit/swig/python/Makefile.am
+++ b/libseaudit/swig/python/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = _seaudit.so.@libseaudit_version@
+wrappedso_DATA = _seaudit.so
 wrappedso_SONAME = @libseaudit_pyswig_soname@
 wrappedsodir = $(pkgpyexecdir)
 
@@ -23,16 +23,10 @@ $(BUILT_SOURCES): $(dist_noinst_DATA) $(
 	-I$(top_srcdir)/libqpol/swig -I$(top_srcdir)/libapol/swig $<
 
 $(wrappedso_DATA): $(BUILT_SOURCES)
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_PYTHON_CPPFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ _seaudit.so
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_PYTHON_CPPFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 $(wrappedpy_DATA): $(BUILT_SOURCES)
 
-install-data-hook:
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) $(wrappedso_SONAME)
-	cd $(DESTDIR)$(wrappedsodir) && $(LN_S) -f $(wrappedso_DATA) _seaudit.so
-
 uninstall-local:
 	-rm -rf $(DESTDIR)$(wrappedsodir)/$(wrappedso_SONAME) $(DESTDIR)$(wrappedsodir)/_seaudit.so
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
