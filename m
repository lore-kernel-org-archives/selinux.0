Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4CKmeXU006315
 for <selinux@tycho.nsa.gov>; Thu, 12 May 2016 16:48:40 -0400
From: Julien Pivotto <roidelapluie@inuits.eu>
To: cpebenito@tresys.com, setools@tresys.com, selinux@tycho.nsa.gov
Subject: [PATCH] setools3: Allow to override PKG_CONFIG
Date: Thu, 12 May 2016 22:47:59 +0200
Message-Id: <1463086079-5456-1-git-send-email-roidelapluie@inuits.eu>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 configure.ac | 51 ++++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8de2b7e..d595f0c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -692,30 +692,27 @@ AC_ARG_WITH(test-policies,
 
 AC_CACHE_SAVE
 
-dnl check for pkg-config
-AC_CHECK_PROG(has_pkg_config, pkg-config, yes, no)
-if test ${has_pkg_config} = "no"; then
-   AC_MSG_ERROR([pkg-config not found])
-fi
+dnl check for ${PKG_CONFIG}
+PKG_PROG_PKG_CONFIG
 
 AC_MSG_CHECKING([for libxml])
-pkg-config --exists 'libxml-2.0'
+${PKG_CONFIG} --exists 'libxml-2.0'
 if test $? -ne 0 ; then
   AC_MSG_ERROR([setools requires libxml-2.0])
 fi
-XML_CFLAGS=`pkg-config --cflags libxml-2.0`
-XML_LIBS=`pkg-config --libs libxml-2.0`
+XML_CFLAGS=`${PKG_CONFIG} --cflags libxml-2.0`
+XML_LIBS=`${PKG_CONFIG} --libs libxml-2.0`
 AC_MSG_RESULT([yes])
 AC_SUBST(XML_CFLAGS)
 AC_SUBST(XML_LIBS)
 
 AC_MSG_CHECKING([for sqlite3])
-pkg-config --exists 'sqlite3 >= 3.2.0'
+${PKG_CONFIG} --exists 'sqlite3 >= 3.2.0'
 if test $? -ne 0 ; then
   AC_MSG_ERROR([setools requires sqlite3 3.2.0 or greater])
 fi
-SQLITE3_CFLAGS=`pkg-config --cflags sqlite3`
-SQLITE3_LIBS=`pkg-config --libs sqlite3`
+SQLITE3_CFLAGS=`${PKG_CONFIG} --cflags sqlite3`
+SQLITE3_LIBS=`${PKG_CONFIG} --libs sqlite3`
 AC_MSG_RESULT([yes])
 AC_SUBST(SQLITE3_CFLAGS)
 AC_SUBST(SQLITE3_LIBS)
@@ -727,47 +724,47 @@ gtk_version_2_8=1
 if test "x${build_gui}" = xyes; then
 
   AC_MSG_CHECKING([for GTK])
-  pkg-config --atleast-version=2.4 gtk+-2.0
+  ${PKG_CONFIG} --atleast-version=2.4 gtk+-2.0
   if test $? -ne 0; then
      AC_MSG_ERROR([setools requires GTK+ 2.4 or greater])
   fi
-  pkg-config --atleast-version=2.8 gtk+-2.0
+  ${PKG_CONFIG} --atleast-version=2.8 gtk+-2.0
   gtk_version_2_8=$?
-  GTK_CFLAGS=`pkg-config --cflags gtk+-2.0`
-  GTK_LIBS=`pkg-config --libs gtk+-2.0`
+  GTK_CFLAGS=`${PKG_CONFIG} --cflags gtk+-2.0`
+  GTK_LIBS=`${PKG_CONFIG} --libs gtk+-2.0`
   AC_MSG_RESULT([yes])
   AC_SUBST(GTK_CFLAGS)
   AC_SUBST(GTK_LIBS)
 
   AC_MSG_CHECKING([for libglade])
-  pkg-config --exists 'libglade-2.0'
+  ${PKG_CONFIG} --exists 'libglade-2.0'
   if test $? -ne 0; then
      AC_MSG_ERROR([setools requires libglade-2.0; make sure libglade2-devel is installed])
   fi
-  GLADE_CFLAGS=`pkg-config --cflags libglade-2.0`
-  GLADE_LIBS=`pkg-config --libs libglade-2.0`
+  GLADE_CFLAGS=`${PKG_CONFIG} --cflags libglade-2.0`
+  GLADE_LIBS=`${PKG_CONFIG} --libs libglade-2.0`
   AC_MSG_RESULT([yes])
   AC_SUBST(GLADE_CFLAGS)
   AC_SUBST(GLADE_LIBS)
 
   AC_MSG_CHECKING([for gdk-pixbuf])
-  pkg-config --exists 'gdk-pixbuf-2.0'
+  ${PKG_CONFIG} --exists 'gdk-pixbuf-2.0'
   if test $? -ne 0; then
      AC_MSG_ERROR([setools requires gdk-pixbuf-2.0])
   fi
-  PIXBUF_CFLAGS=`pkg-config --cflags gdk-pixbuf-2.0`
-  PIXBUF_LIBS=`pkg-config --libs gdk-pixbuf-2.0`
+  PIXBUF_CFLAGS=`${PKG_CONFIG} --cflags gdk-pixbuf-2.0`
+  PIXBUF_LIBS=`${PKG_CONFIG} --libs gdk-pixbuf-2.0`
   AC_MSG_RESULT([yes])
   AC_SUBST(PIXBUF_CFLAGS)
   AC_SUBST(PIXBUF_LIBS)
 
   AC_MSG_CHECKING([for gthread])
-  pkg-config --exists 'gthread-2.0'
+  ${PKG_CONFIG} --exists 'gthread-2.0'
   if test $? -ne 0; then
      AC_MSG_ERROR([setools requires gthread-2.0])
   fi
-  GTHREAD_CFLAGS=`pkg-config --cflags gthread-2.0`
-  GTHREAD_LIBS=`pkg-config --libs gthread-2.0`
+  GTHREAD_CFLAGS=`${PKG_CONFIG} --cflags gthread-2.0`
+  GTHREAD_LIBS=`${PKG_CONFIG} --libs gthread-2.0`
   AC_MSG_RESULT([yes])
   AC_SUBST(GTHREAD_CFLAGS)
   AC_SUBST(GTHREAD_LIBS)
@@ -795,13 +792,13 @@ AC_CHECK_LIB(bz2,
 )
 
 #AC_MSG_CHECKING([for FUSE])
-#pkg-config --exists fuse
+#${PKG_CONFIG} --exists fuse
 #if test $? -ne 0; then
 #   AC_MSG_WARN([FUSE not found; libsefs tests will not be built])
 #   have_fuse="no"
 #else
-#   FUSE_CFLAGS=`pkg-config --cflags fuse`
-#   FUSE_LIBS=`pkg-config --libs fuse`
+#   FUSE_CFLAGS=`${PKG_CONFIG} --cflags fuse`
+#   FUSE_LIBS=`${PKG_CONFIG} --libs fuse`
 #   AC_SUBST(FUSE_CFLAGS)
 #   AC_SUBST(FUSE_LIBS)
 #   have_fuse="yes"
-- 
2.6.1
