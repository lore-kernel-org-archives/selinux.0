Subject: Re: file_type_auto_trans is not sufficient
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1117388699.21505.4.camel@localhost.localdomain>
References: <1117249760.19257.18.camel@localhost.localdomain>
	 <1117252045.19698.16.camel@localhost.localdomain>
	 <42980072.6090701@redhat.com>
	 <1117336632.24194.8.camel@localhost.localdomain>
	 <42999EF1.3020205@redhat.com>
	 <1117388699.21505.4.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-vynJp2IaqsYctK4VR2tf"
Date: Sun, 29 May 2005 23:03:57 -0400
Message-Id: <1117422237.9452.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vynJp2IaqsYctK4VR2tf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> The issue is - this interface is rather ugly - can anyone come up 
> with a better one, or should I go ahead and patch various programs like
> this. 

Sample patches attached. I also have to patch libICE. Fonts patch
works fine, but I can't get gnome/ORBit to compile because of docbook
problems. Any domain calling orbit_connect, ice_connect, read_fonts, 
or gnome_application (see my other mail - PATCH) 
executes the following macro:

################################################################
#
# can_restore_context(domain)
#
# Permissions for restoring the context
# of a file via setfscreatecon/getfscreatecon/matchpathcon
#

define(`can_restore_context', `

# Protect against double inclusion
ifdef(`can_restore_context_$1', `', `
define(`can_restore_context_$1')

can_setfscreate($1)
can_getsecurity($1)
r_dir_file($1, selinux_config_t)
r_dir_file($1, file_context_t)
allow $1 default_context_t:dir search;

') dnl ifdef can_restore_context_args
') dnl can_restore_context

It also makes virtually everything depend on libselinux.

I'm really starting to think that this is too ugly, and not an
acceptable solution, but I don't have another suggestion at this time.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-vynJp2IaqsYctK4VR2tf
Content-Disposition: attachment; filename=fontconfig-2.2.3-selinux_restore.patch
Content-Type: text/x-patch; name=fontconfig-2.2.3-selinux_restore.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur fontconfig-2.2.3.orig/configure.in fontconfig-2.2.3/configure.in
--- fontconfig-2.2.3.orig/configure.in	2004-06-30 14:53:39.000000000 -0400
+++ fontconfig-2.2.3/configure.in	2005-05-29 20:59:49.000000000 -0400
@@ -132,6 +132,17 @@
 CFLAGS="$fontconfig_save_cflags"
 LIBS="$fontconfig_save_libs"
 
+dnl Checks for SELinux
+AC_CHECK_LIB(selinux, security_switch_context, have_switch_context=yes)
+AC_CHECK_HEADER(selinux/selinux.h, have_selinux_h=yes)
+if test "x$have_switch_context" = "xyes" && test "x$have_selinux_h" = "xyes"; then
+  AC_DEFINE([WITH_SELINUX], 1, [define to enable SELinux support])
+  SELINUX_CFLAGS="-I/usr/include/selinux"
+  SELINUX_LDFLAGS="-lselinux"
+fi
+AC_SUBST(SELINUX_LDFLAGS)
+AC_SUBST(SELINUX_CFLAGS)
+
 #
 # Check expat configuration
 #
diff -aur fontconfig-2.2.3.orig/src/fccache.c fontconfig-2.2.3/src/fccache.c
--- fontconfig-2.2.3.orig/src/fccache.c	2005-05-28 21:56:57.000000000 -0400
+++ fontconfig-2.2.3/src/fccache.c	2005-05-29 21:27:36.000000000 -0400
@@ -23,6 +23,9 @@
  */
 
 #include "fcint.h"
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
 
 /*
  * POSIX has broken stdio so that getc must do thread-safe locking,
@@ -855,6 +858,10 @@
     FcGlobalCacheFile	*file;
     FcAtomic		*atomic;
 
+#ifdef WITH_SELINUX
+    security_context_t prev_ctx = NULL;
+#endif
+
     if (!cache->updated && cache->referenced == cache->entries)
 	return FcTrue;
     
@@ -866,16 +873,33 @@
     if (getuid () != geteuid ())
 	return FcFalse;
 #endif
-    
+
+#ifdef WITH_SELINUX
+    if (is_selinux_enabled()) {
+        prev_ctx = security_switch_context((char*) cache_file, 0200);
+
+            if ((prev_ctx == NULL) && security_getenforce()) 
+                 goto bail0;
+    }
+#endif
+
     atomic = FcAtomicCreate (cache_file);
     if (!atomic)
 	goto bail0;
     if (!FcAtomicLock (atomic))
 	goto bail1;
+
     f = fopen ((char *) FcAtomicNewFile(atomic), "w");
     if (!f)
 	goto bail2;
 
+#ifdef WITH_SELINUX
+    if (prev_ctx != NULL) {
+        setfscreatecon(prev_ctx);
+        freecon(prev_ctx);
+    }
+#endif
+
     for (dir_hash = 0; dir_hash < FC_GLOBAL_CACHE_DIR_HASH_SIZE; dir_hash++)
     {
 	for (dir = cache->ents[dir_hash]; dir; dir = dir->next)
diff -aur fontconfig-2.2.3.orig/src/Makefile.am fontconfig-2.2.3/src/Makefile.am
--- fontconfig-2.2.3.orig/src/Makefile.am	2004-03-30 12:28:44.000000000 -0500
+++ fontconfig-2.2.3/src/Makefile.am	2005-05-29 20:40:37.000000000 -0400
@@ -44,6 +44,7 @@
 INCLUDES = 						\
 	$(FREETYPE_CFLAGS)				\
 	$(EXPAT_CFLAGS)					\
+	$(SELINUX_CFLAGS)				\	
 	-DFONTCONFIG_PATH='"$(CONFDIR)"'		\
 	-I$(top_srcdir)					\
 	-I$(top_srcdir)/src
@@ -76,6 +77,7 @@
 lib_LTLIBRARIES = libfontconfig.la
 
 libfontconfig_la_LDFLAGS =			\
+	$(SELINUX_LDFLAGS)			\
 	-version-info @LT_VERSION_INFO@ $(no_undefined) $(export_symbols)
 
 libfontconfig_la_LIBADD = $(FREETYPE_LIBS) $(EXPAT_LIBS)

--=-vynJp2IaqsYctK4VR2tf
Content-Disposition: attachment; filename=fontconfig.spec.diff
Content-Type: text/x-patch; name=fontconfig.spec.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- fontconfig.spec.orig	2005-05-28 22:23:28.000000000 -0400
+++ fontconfig.spec	2005-05-29 20:44:19.000000000 -0400
@@ -41,10 +41,13 @@
 # https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=148748
 Patch30: fontconfig-2.2.3-add-sazanami.patch
 
+# Restore SELinux context of the global font cache
+Patch31: fontconfig-2.2.3-selinux_restore.patch
+
 BuildRequires: freetype-devel >= %{freetype_version}
 BuildRequires: expat-devel
 BuildRequires: perl
-# For nodocs patch
+BuildRequires: /usr/bin/autoconf
 BuildRequires: /usr/bin/automake-1.7
 
 PreReq: freetype >= %{freetype_version}
@@ -86,15 +89,16 @@
 
 %patch30 -p1 -b .sazanami
 
+%patch31 -p1 -b .selinux_restore
+
 %if %{disable_docs}
 %patch14 -p1 -b .nodocs
 %endif
 
 %build
-
-%if %{disable_docs}
+autoconf
 automake-1.7
-%endif
+autoheader
 
 %configure --with-add-fonts=/usr/X11R6/lib/X11/fonts/Type1,/usr/X11R6/lib/X11/fonts/OTF
 make

--=-vynJp2IaqsYctK4VR2tf
Content-Disposition: attachment; filename=libgnome-2.10.0-selinux_restore.patch
Content-Type: text/x-patch; name=libgnome-2.10.0-selinux_restore.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur libgnome-2.10.0.orig/configure.in libgnome-2.10.0/configure.in
--- libgnome-2.10.0.orig/configure.in	2005-03-07 04:53:04.000000000 -0500
+++ libgnome-2.10.0/configure.in	2005-05-29 20:59:02.000000000 -0400
@@ -94,6 +94,17 @@
 
 GNOME_COMPILE_WARNINGS
 
+dnl Checks for SELinux
+AC_CHECK_LIB(selinux, security_switch_context, have_switch_context=yes)
+AC_CHECK_HEADER(selinux/selinux.h, have_selinux_h=yes)
+if test "x$have_switch_context" = "xyes" && test "x$have_selinux_h" = "xyes"; then
+  AC_DEFINE([WITH_SELINUX], 1, [define to enable SELinux support])
+  SELINUX_CFLAGS="-I/usr/include/selinux"
+  SELINUX_LDFLAGS="-lselinux"
+fi
+AC_SUBST(SELINUX_LDFLAGS)
+AC_SUBST(SELINUX_CFLAGS)
+
 dnl Define GNOME_ENABLE_DEBUG if the --enable-debug switch was given.
 GNOME_DEBUG_CHECK
 
diff -aur libgnome-2.10.0.orig/libgnome/gnome-init.c libgnome-2.10.0/libgnome/gnome-init.c
--- libgnome-2.10.0.orig/libgnome/gnome-init.c	2005-05-28 20:28:38.000000000 -0400
+++ libgnome-2.10.0/libgnome/gnome-init.c	2005-05-29 19:37:30.000000000 -0400
@@ -53,6 +53,10 @@
 
 #include <libgnomevfs/gnome-vfs-init.h>
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
+
 /*****************************************************************************
  * bonobo
  *****************************************************************************/
@@ -266,6 +270,9 @@
 {
 	char *safe_pathname;
 	int len, ret;
+#ifdef WITH_SELINUX
+	security_context_t prev_ctx = NULL;
+#endif
 	
 	safe_pathname = g_strdup (pathname);
 	len = strlen (safe_pathname);
@@ -273,8 +280,25 @@
 	if (len > 1 && safe_pathname[len - 1] == '/')
 		safe_pathname[len - 1] = '\0';
 
+#ifdef WITH_SELINUX
+	if (is_selinux_enabled()) {
+		prev_ctx = security_switch_context(pathname, mode);
+
+		if ((prev_ctx == NULL) && security_getenforce()) {
+			ret = -1;	
+			goto exit;
+		}
+        }
+#endif
 	ret = mkdir (safe_pathname, mode);
 
+	exit:
+#ifdef WITH_SELINUX
+	if (prev_ctx != NULL) {
+		setfscreatecon(prev_ctx);
+		freecon(prev_ctx);
+	}
+#endif
 	g_free (safe_pathname);
 
 	return ret;
diff -aur libgnome-2.10.0.orig/libgnome/Makefile.am libgnome-2.10.0/libgnome/Makefile.am
--- libgnome-2.10.0.orig/libgnome/Makefile.am	2004-05-07 07:28:31.000000000 -0400
+++ libgnome-2.10.0/libgnome/Makefile.am	2005-05-28 20:40:04.000000000 -0400
@@ -17,6 +17,7 @@
 	-I$(srcdir)/..						\
 	$(WARN_CFLAGS)						\
 	$(LIBGNOME_CFLAGS)					\
+	$(SELINUX_CFLAGS)					\
 	-DG_DISABLE_DEPRECATED					\
 	-DLIBGNOME_PREFIX=\""$(prefix)"\"			\
 	-DLIBGNOME_LIBDIR=\""$(libdir)"\"			\
@@ -129,6 +130,7 @@
 	parse-path.cP
 
 libgnome_2_la_LDFLAGS = \
+	$(SELINUX_LDFLAGS)	\
 	-version-info $(LIBGNOME_CURRENT):$(LIBGNOME_REVISION):$(LIBGNOME_AGE) \
 	-no-undefined \
 	-export-symbols-regex "^[^_].*"

--=-vynJp2IaqsYctK4VR2tf
Content-Disposition: attachment; filename=libgnome.spec.diff
Content-Type: text/x-patch; name=libgnome.spec.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libgnome.spec.orig	2005-05-28 21:29:48.000000000 -0400
+++ libgnome.spec	2005-05-28 22:25:21.000000000 -0400
@@ -6,6 +6,7 @@
 %define gnome_vfs2_version 2.5.3
 %define orbit2_version 2.5.1
 %define esound_version 0.2.27
+%define automake17_version 1.7.9
 
 %define po_package libgnome-2.0
 
@@ -41,6 +42,8 @@
 BuildRequires:  libxslt-devel >= %{libxslt_version}
 BuildRequires:  intltool
 BuildRequires: gtk-doc
+BuildRequires: autoconf
+BuildRequires: automake17 >= %{automake17_version}
 
 Patch0: libgnome-2.7.2-default-gtk-theme.patch
 Patch1: libgnome-2.7.2-default-background.patch
@@ -50,6 +53,7 @@
 Patch5: libgnome-2.8.0-default-browser.patch
 Patch6: libgnome-2.8.0-stat-homedir.patch
 Patch7: libgnome-2.9.1-popt.patch
+Patch8: libgnome-2.10.0-selinux_restore.patch
 
 # Added to avoid the warning messages about utmp group, bug #24171
 # fixme, just libzvt?
@@ -103,8 +107,12 @@
 %patch5 -p1 -b .default-browser
 %patch6 -p1 -b .stat-homedir
 %patch7 -p1 -b .popt
+%patch8 -p1 -b .selinux_restore
 
 %build
+autoconf
+automake-1.7
+autoheader
 intltoolize -f
 %configure --enable-gtk-doc
 # Having strange problems adding it to CFLAGS. Oh well.

--=-vynJp2IaqsYctK4VR2tf
Content-Disposition: attachment; filename=libselinux-context_restore.patch
Content-Type: text/x-patch; name=libselinux-context_restore.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur libselinux-1.23.10.orig/include/selinux/selinux.h libselinux-1.23.10/include/selinux/selinux.h
--- libselinux-1.23.10.orig/include/selinux/selinux.h	2005-04-29 14:07:14.000000000 -0400
+++ libselinux-1.23.10/include/selinux/selinux.h	2005-05-29 19:27:22.000000000 -0400
@@ -307,6 +307,13 @@
    be relabeled . */
 extern int is_context_customizable (security_context_t scontext);
 
+
+/* Performs a context match (matchpathcon), and changes the file creation  
+ * context. On success, returns the old context. On failure, returns NULL.
+ * The context returned must be freed with freecon() */
+
+extern security_context_t security_switch_context(const char *pathname, mode_t mode);
+
 #ifdef __cplusplus
 }
 #endif
diff -Naur libselinux-1.23.10.orig/src/switch_context.c libselinux-1.23.10/src/switch_context.c
--- libselinux-1.23.10.orig/src/switch_context.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.23.10/src/switch_context.c	2005-05-29 19:28:35.000000000 -0400
@@ -0,0 +1,27 @@
+#include <stdlib.h>
+#include <sys/types.h>
+#include <selinux/selinux.h>
+
+security_context_t security_switch_context(const char* pathname, mode_t mode) {
+	security_context_t prev_ctx = NULL;
+	security_context_t tmp_ctx = NULL;
+
+	/* Attempt to get the current context. */
+	if (getfscreatecon(&prev_ctx) < 0)
+		return NULL;
+
+	/* Attempt a match. */
+	if (matchpathcon(pathname, mode, &tmp_ctx) >= 0) {
+
+		/* Successful match - switch context */
+		if (setfscreatecon(tmp_ctx) < 0) {
+			freecon(tmp_ctx);
+			freecon(prev_ctx);
+			return NULL;
+		}
+		freecon(tmp_ctx);
+	}
+
+	/* Return old context */
+	return prev_ctx;
+}

--=-vynJp2IaqsYctK4VR2tf
Content-Disposition: attachment; filename=libselinux.spec.diff
Content-Type: text/x-patch; name=libselinux.spec.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libselinux.spec.orig	2005-05-28 22:23:37.000000000 -0400
+++ libselinux.spec	2005-05-28 22:26:32.000000000 -0400
@@ -6,6 +6,7 @@
 Group: System Environment/Libraries
 Source: http://www.nsa.gov/selinux/archives/%{name}-%{version}.tgz
 Patch: libselinux-rhat.patch
+Patch1: libselinux-context_restore.patch
 
 BuildRoot: %{_tmppath}/%{name}-%{version}-buildroot
 
@@ -36,6 +37,7 @@
 %prep
 %setup -q
 %patch -p1 -b .rhat
+%patch1 -p1 -b .context_restore
 
 %build
 make CFLAGS="-g %{optflags}"

--=-vynJp2IaqsYctK4VR2tf
Content-Disposition: attachment; filename=ORBit2-2.12.1-selinux_restore.patch
Content-Type: text/x-patch; name=ORBit2-2.12.1-selinux_restore.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur ORBit2-2.12.1.orig/configure.in ORBit2-2.12.1/configure.in
--- ORBit2-2.12.1.orig/configure.in	2005-02-04 17:34:45.000000000 -0500
+++ ORBit2-2.12.1/configure.in	2005-05-29 20:59:20.000000000 -0400
@@ -128,6 +128,17 @@
 AC_SUBST(LOCAL_LINC_LIBS)
 AC_SUBST(LOCAL_LINC_CFLAGS)
 
+dnl Checks for SELinux
+AC_CHECK_LIB(selinux, security_switch_context, have_switch_context=yes)
+AC_CHECK_HEADER(selinux/selinux.h, have_selinux_h=yes)
+if test "x$have_switch_context" = "xyes" && test "x$have_selinux_h" = "xyes"; then
+  AC_DEFINE([WITH_SELINUX], 1, [define to enable SELinux support])
+  SELINUX_CFLAGS="-I/usr/include/selinux"
+  SELINUX_LDFLAGS="-lselinux"
+fi
+AC_SUBST(SELINUX_LDFLAGS)
+AC_SUBST(SELINUX_CFLAGS)
+
 dnl Checks for libraries.
 PKG_CHECK_MODULES(ORBIT, \
 	glib-2.0 >= $GLIB_REQUIRED \
diff -aur ORBit2-2.12.1.orig/src/orb/GIOP/giop.c ORBit2-2.12.1/src/orb/GIOP/giop.c
--- ORBit2-2.12.1.orig/src/orb/GIOP/giop.c	2005-02-01 15:48:58.000000000 -0500
+++ ORBit2-2.12.1/src/orb/GIOP/giop.c	2005-05-29 21:29:37.000000000 -0400
@@ -26,6 +26,10 @@
 #define mkdir(path, mode) _mkdir (path)
 #endif
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
+
 /* FIXME: need to clean this up at shutdown */
 static int      corba_wakeup_fds[2];
 #define WAKEUP_POLL  corba_wakeup_fds [0]
@@ -120,6 +124,37 @@
 	return cur_dir;
 }
 
+/* Performs a standard mkdir call, but restores
+ * the context of the directory being created from
+ * via matchpathcon */
+
+static int
+mkdir_restorecon(const char* pathname, mode_t mode) {
+	int status;
+
+#ifdef WITH_SELINUX
+	security_context_t prev_ctx = NULL;
+
+	if (is_selinux_enabled()) {
+		prev_ctx = security_switch_context(pathname, mode);
+
+		if ((prev_ctx == NULL) && security_getenforce()) 
+			return -1;
+	}
+#endif
+
+	status = mkdir(pathname, mode);
+
+#ifdef WITH_SELINUX
+	if (prev_ctx != NULL) {
+		setfscreatecon(prev_ctx);
+		freecon(prev_ctx);
+	}
+#endif
+	return status;
+}
+
+
 static void
 giop_tmpdir_init (void)
 {
@@ -161,7 +196,7 @@
 				"%s/%s-%4x", tmp_root, dirname, id.b);
 		}
 
-		if (mkdir (newname, 0700) < 0) {
+		if (mkdir_restorecon(newname, 0700) < 0) {
 			switch (errno) {
 			case EACCES:
 				g_error ("I can't write to '%s', ORB init failed",
diff -aur ORBit2-2.12.1.orig/src/orb/GIOP/Makefile.am ORBit2-2.12.1/src/orb/GIOP/Makefile.am
--- ORBit2-2.12.1.orig/src/orb/GIOP/Makefile.am	2003-05-30 11:55:00.000000000 -0400
+++ ORBit2-2.12.1/src/orb/GIOP/Makefile.am	2005-05-29 19:20:17.000000000 -0400
@@ -6,7 +6,8 @@
 	$(ORBIT_DEBUG_CFLAGS)		\
 	$(DISABLE_DEPRECATED_CFLAGS)	\
 	$(LOCAL_LINC_CFLAGS)		\
-	$(ORBIT_CFLAGS)
+	$(ORBIT_CFLAGS)			\
+	$(SELINUX_CFLAGS)
 
 noinst_LTLIBRARIES=libGIOP.la
 
diff -aur ORBit2-2.12.1.orig/src/orb/Makefile.am ORBit2-2.12.1/src/orb/Makefile.am
--- ORBit2-2.12.1.orig/src/orb/Makefile.am	2003-06-06 11:49:52.000000000 -0400
+++ ORBit2-2.12.1/src/orb/Makefile.am	2005-05-29 19:20:05.000000000 -0400
@@ -20,6 +20,7 @@
 	-version-info $(LT_VERSION)   \
 	-no-undefined		      \
 	$(ORBIT_LIBS)                 \
+	$(SELINUX_LDFLAGS)            \
 	-lpopt
 
 libORBit_2_la_LIBADD= \

--=-vynJp2IaqsYctK4VR2tf
Content-Disposition: attachment; filename=ORBit2.spec.diff
Content-Type: text/x-patch; name=ORBit2.spec.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- ORBit2.spec.orig	2005-05-28 22:23:22.000000000 -0400
+++ ORBit2.spec	2005-05-29 20:51:49.000000000 -0400
@@ -14,8 +14,11 @@
 BuildRequires: glib2-devel >= %{glib2_version}
 BuildRequires: pkgconfig >= 0.14
 BuildRequires: gtk-doc >= 1.1
+BuildRequires: autoconf
+BuildRequires: automake17 >= 1.7.9
 
 Patch0: ORBit2-2.12.1-reduce-size-of-io-thread-stack.patch
+Patch1: ORBit2-2.12.1-selinux_restore.patch
 
 %description
 ORBit is a high-performance CORBA (Common Object Request Broker 
@@ -52,8 +55,12 @@
 %setup -q
 
 %patch0 -p1 -b .reduce-size-of-io-thread-stack
+%patch1 -p1 -b .selinux_restore
 
 %build
+autoconf
+automake-1.7
+autoheader
 %configure --enable-gtk-doc
 make
 

--=-vynJp2IaqsYctK4VR2tf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
