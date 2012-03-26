Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QJmDNF025057
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:48:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id B0EA11A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:48:12 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kO5Pwur2t0h for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 21:48:10 +0200 (CEST)
Received: from fornost.bigon.be (fornost.bigon.be [IPv6:2001:6f8:303:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 994801A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:48:10 +0200 (CEST)
Date: Mon, 26 Mar 2012 21:48:07 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/8] setools -- Do not build tcl module with a soname and do
 not generate symlinks
Message-ID: <20120326214807.7cb3b06a@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Same as the python module, tcl module shound't have a soname and the
symlinks are useless.

Description: Do not build tcl module with a soname and do not generate symlinks
Author: Laurent Bigonville <bigon@debian.org>
Date: Tue, 13 Mar 2012 21:51:04 +0100

--- a/libapol/swig/tcl/Makefile.am
+++ b/libapol/swig/tcl/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = libtapol.so.@libapol_version@
+wrappedso_DATA = libtapol.so
 wrappedso_SONAME = @libapol_tswig_soname@
 short_name = libtapol.so
 wrappedsodir = $(libdir)/setools/apol
@@ -21,9 +21,7 @@ $(BUILT_SOURCES): $(dist_noinst_DATA) $(
 	$(SWIG) $(SWIG_TCL_OPT) -pkgversion @libapol_version@ -o $@ -I$(top_srcdir)/libapol/include -I$(top_srcdir)/libqpol/swig $<
 
 $(wrappedso_DATA): $(BUILT_SOURCES)
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ $(short_name)
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 $(package_SCRIPTS): $(wrappedso_DATA)
 	echo "pkg_mkIndex . $^" | LD_LIBRARY_PATH=$(top_builddir)/libqpol/src:$(top_builddir)/libapol/src $(TCLSH_PROG)
--- a/libpoldiff/swig/tcl/Makefile.am
+++ b/libpoldiff/swig/tcl/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = libtpoldiff.so.@libpoldiff_version@
+wrappedso_DATA = libtpoldiff.so
 wrappedso_SONAME = @libpoldiff_tswig_soname@
 short_name = libtpoldiff.so
 wrappedsodir = $(libdir)/setools/poldiff
@@ -22,9 +22,7 @@ $(BUILT_SOURCES): $(dist_noinst_DATA) $(
 	$(SWIG) $(SWIG_TCL_OPT) -pkgversion @libpoldiff_version@ -o $@ -I$(top_srcdir)/libpoldiff/include -I$(top_srcdir)/libapol/include -I$(top_srcdir)/libapol/swig -I$(top_srcdir)/libqpol/swig $<
 
 $(wrappedso_DATA): $(BUILT_SOURCES)
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ $(short_name)
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 $(package_SCRIPTS): $(wrappedso_DATA)
 	echo "pkg_mkIndex . $^" | LD_LIBRARY_PATH=$(top_builddir)/libqpol/src:$(top_builddir)/libapol/src:$(top_builddir)/libpoldiff/src $(TCLSH_PROG)
--- a/libqpol/swig/tcl/Makefile.am
+++ b/libqpol/swig/tcl/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = libtqpol.so.@libqpol_version@
+wrappedso_DATA = libtqpol.so
 wrappedso_SONAME = @libqpol_tswig_soname@
 short_name = libtqpol.so
 wrappedsodir = $(libdir)/setools/qpol
@@ -18,9 +18,7 @@ $(BUILT_SOURCES): $(dist_noinst_DATA) $(
 	$(SWIG) $(SWIG_TCL_OPT) -pkgversion @libqpol_version@ -o $@ $<
 
 $(wrappedso_DATA): $(BUILT_SOURCES)
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ $(short_name)
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 libdirs = $(top_builddir)/libqpol/src
 
--- a/libseaudit/swig/tcl/Makefile.am
+++ b/libseaudit/swig/tcl/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = libtseaudit.so.@libseaudit_version@
+wrappedso_DATA = libtseaudit.so
 wrappedso_SONAME = @libseaudit_tswig_soname@
 short_name = libtseaudit.so
 wrappedsodir = $(libdir)/setools/seaudit
@@ -22,9 +22,7 @@ $(BUILT_SOURCES): $(dist_noinst_DATA) $(
 	$(SWIG) $(SWIG_TCL_OPT) -pkgversion @libseaudit_version@ -o $@ -I$(top_srcdir)/libseaudit/include -I$(top_srcdir)/libapol/include -I$(top_srcdir)/libapol/swig -I$(top_srcdir)/libqpol/swig $<
 
 $(wrappedso_DATA): $(BUILT_SOURCES)
-	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ $(short_name)
+	$(CC) -shared -o $@ $^ $(AM_CFLAGS) $(CFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 $(package_SCRIPTS): $(wrappedso_DATA)
 	echo "pkg_mkIndex . $^" | LD_LIBRARY_PATH=$(top_builddir)/libqpol/src:$(top_builddir)/libapol/src:$(top_builddir)/libseaudit/src $(TCLSH_PROG)
--- a/libsefs/swig/tcl/Makefile.am
+++ b/libsefs/swig/tcl/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = libtsefs.so.@libsefs_version@
+wrappedso_DATA = libtsefs.so
 wrappedso_SONAME = @libsefs_tswig_soname@
 short_name = libtsefs.so
 wrappedsodir = $(libdir)/setools/sefs
@@ -22,9 +22,7 @@ $(BUILT_SOURCES): $(dist_noinst_DATA) $(
 	$(SWIG) -c++ $(SWIG_TCL_OPT) -pkgversion @libsefs_version@ -o $@ -I$(top_srcdir)/libsefs/include -I$(top_srcdir)/libapol/include -I$(top_srcdir)/libapol/swig -I$(top_srcdir)/libqpol/swig $<
 
 $(wrappedso_DATA): $(BUILT_SOURCES)
-	$(CXX) -shared -o $@ $^ $(AM_CXXFLAGS) $(CXXFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
-	$(LN_S) -f $@ $(wrappedso_SONAME)
-	$(LN_S) -f $@ $(short_name)
+	$(CXX) -shared -o $@ $^ $(AM_CXXFLAGS) $(CXXFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 $(package_SCRIPTS): $(wrappedso_DATA)
 	echo "pkg_mkIndex . $^" | LD_LIBRARY_PATH=$(top_builddir)/libqpol/src:$(top_builddir)/libapol/src:$(top_builddir)/libsefs/src $(TCLSH_PROG)
--- a/apol/Makefile.am
+++ b/apol/Makefile.am
@@ -1,4 +1,4 @@
-wrappedso_DATA = libapol_tcl.so.@libapol_version@
+wrappedso_DATA = libapol_tcl.so
 wrappedso_SONAME = $(wrappedso_DATA)
 wrappedsodir = $(libdir)/setools/apol_tcl
 
@@ -85,7 +85,7 @@ apol_tcl_wrap.cc: apol_tcl.i $(DEPENDENC
 	-I$(top_srcdir)/libqpol/swig $<
 
 $(wrappedso_DATA): apol_tcl.cc apol_tcl_wrap.cc
-	$(CXX) -shared -o $@ $^ $(AM_CXXFLAGS) $(CXXFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(wrappedso_SONAME)
+	$(CXX) -shared -o $@ $^ $(AM_CXXFLAGS) $(CXXFLAGS) $(SWIG_TCL_CFLAGS) $(AM_LDFLAGS) $(LDFLAGS)
 
 $(package_SCRIPTS): $(wrappedso_DATA) mkIndex.tcl
 	cat mkIndex.tcl | LD_LIBRARY_PATH=$(top_builddir)/libqpol/src:$(top_builddir)/libapol/src:$(top_builddir)/libsefs/src $(TCLSH_PROG)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
