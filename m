Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1KeWRb010324
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 15:40:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB1KeVqY027624
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 20:40:31 GMT
Received: from glaurung.green-gryphon.com (host-12-107-230-171.dtccom.net [12.107.230.171])
        by jazzband.ncsc.mil  with ESMTP id hB1KeT0o027621 for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 20:40:29 GMT
To: selinux@tycho.nsa.gov
Subject: Re: patched wdm (new API)
References: <20031002145936.A16412@lemuria.org>
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Mon, 01 Dec 2003 14:34:16 -0600
In-Reply-To: <20031002145936.A16412@lemuria.org> (tom@lemuria.org's message
 of "Thu, 2 Oct 2003 14:59:39 +0200")
Message-ID: <8765h0e0qf.fsf@glaurung.green-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

On Thu, 2 Oct 2003 14:59:39 +0200, Tom  <tom@lemuria.org> said: 

> Hi everyone - I have patched the current wdm version so we have
> again an SELinux-aware graphical login available.

> I have submitted the patch upstream for inclusion into the wdm tree.

On 08 Oct 2003 08:30:21 -0400, Stephen Smalley <sds@epoch.ncsc.mil> said: 

> there is a patched gdm available from Dan's site, under
> ftp://people.redhat.com/dwalsh/SELinux, that will obtain and use the
> user's default context.

	Well, I have a nice xdm greeter setup, and I don't run
 Gnome/KDE/Windowmaker,  and I was disinclined to use startx just
 because I wanted to secure my laptop. So I went ahead and patched xdm
 from X 4.3.0 for SELinux.  I have examined the patches for wdm/gdm,
 and this xdm patch provides the same capabilities as the other
 patches do.

        This patch has been tested with and without SELinux support,
 and on SELinux kernels, and vanilla kernels.  This patch is against
 the CVS version of the Debian XFree86 code (significant, since the
 patches applied by Debian increase the fuzz (and may even require the
 patch to be manually applied on vanilla X 4.3.0).

	I am working with Debian's XFree86 maintainer to get this
 patch incorporated into Debian's X packages.

        As implemented, the patch merely provides a capability, which
 has to be explicitly turned on at compile time with -DHasSELinux=YES.
 If one does not compile with -DHasSELinux=YES, the patch is a no-op.
 Since none of the code is compiled in, there is no change in
 behaviour, nor is there any performance hit.

        If you do turn on the SELinux compatibility with -DHasSELinux,
 you would need libselinux at build time.  In other words, the
 mainline X build does not build depend on SELinux; the dependency is
 only invoked if you explicitly pass a parameter to imake. 

        Even when SELinux compatibility is compiled in, on a non
 SELinux kernel it is dead code; there is no change in functionality,
 apart from a single check to see if SELinux is available at each
 login. The SELinux code paths are not exercised on non-SELinux
 kernels.

        The patch is fairly minimal (only 160 lines or so), and it
 should be easy to check that is would not impact anything else.

        manoj


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=selinux-patch
Content-Description: SELinux support for xdm

diff -uBbwr xfree86-4.3.0-0.2003.11.30/xc/config/cf/Imake.tmpl xfree86-4.3.0-0.2003.11.30.sel/xc/config/cf/Imake.tmpl
--- xfree86-4.3.0-0.2003.11.30/xc/config/cf/Imake.tmpl	2003-11-30 22:44:35.000000000 -0600
+++ xfree86-4.3.0-0.2003.11.30.sel/xc/config/cf/Imake.tmpl	2003-12-01 13:26:29.000000000 -0600
@@ -2033,17 +2033,21 @@
  * EXTRA_INCLUDES contains project-specific includes set in project incfiles
  * INCLUDES contains client-specific includes set in Imakefile
  * LOCAL_LDFLAGS contains client-specific ld flags flags set in Imakefile
+ * SELINUX_INCLUDES contains SELinux-specific includes set in the appropriate .cf file
+ * SELINUX_LDFLAGS  contains SELinux-specific ld flags set in the appropriate .cf file
+ * SELINUX_CFLAGS  contains SELinux-specific compiler flags set in the .cf file
+ * SELINUX_LIBS   contains SELinux-specific libraries to link with set in the .cf file
  */
-      ALLINCLUDES = $(INCLUDES) $(EXTRA_INCLUDES) $(TOP_INCLUDES) $(INSTALLED_INCLUDES) $(STD_INCLUDES)
+      ALLINCLUDES = $(INCLUDES) $(EXTRA_INCLUDES) $(TOP_INCLUDES) $(INSTALLED_INCLUDES) $(STD_INCLUDES) $(SELINUX_INCLUDES)
        ALLDEFINES = $(ALLINCLUDES) $(STD_DEFINES) $(PROTO_DEFINES) $(THREADS_DEFINES) $(MODULE_DEFINES) $(DEFINES) $(EXTRA_DEFINES)
-           CFLAGS = $(CDEBUGFLAGS) $(CCOPTIONS) $(THREADS_CFLAGS) $(MODULE_CFLAGS) $(ALLDEFINES)
+           CFLAGS = $(CDEBUGFLAGS) $(CCOPTIONS) $(THREADS_CFLAGS) $(SELINUX_CFLAGS) $(MODULE_CFLAGS) $(ALLDEFINES)
         LINTFLAGS = $(LINTOPTS) -DLINT $(ALLDEFINES) $(DEPEND_DEFINES)
          LDPRELIB = LdPreLib $(INSTALLED_LIBS)
         LDPOSTLIB = LdPostLib
-        LDOPTIONS = $(CDEBUGFLAGS) $(CCOPTIONS)  $(EXTRA_LDOPTIONS) $(THREADS_LDFLAGS) $(LOCAL_LDFLAGS) $(LDPRELIBS)
+        LDOPTIONS = $(CDEBUGFLAGS) $(CCOPTIONS)  $(EXTRA_LDOPTIONS) $(THREADS_LDFLAGS) $(SELINUX_LDFLAGS) $(LOCAL_LDFLAGS) $(LDPRELIBS)
      CXXLDOPTIONS = $(CXXDEBUGFLAGS) $(CXXOPTIONS) $(EXTRA_LDOPTIONS) $(THREADS_CXXLDFLAGS) $(LOCAL_LDFLAGS) $(LDPRELIBS)
 
-           LDLIBS = $(LDPOSTLIBS) $(THREADS_LIBS) $(SYS_LIBRARIES) $(EXTRA_LIBRARIES)
+           LDLIBS = $(LDPOSTLIBS) $(THREADS_LIBS) $(SELINUX_LIBS) $(SYS_LIBRARIES) $(EXTRA_LIBRARIES)
 #if HasBrokenCCForLink
            CCLINK = LdCmd
 #else
diff -uBbwr xfree86-4.3.0-0.2003.11.30/xc/config/cf/linux.cf xfree86-4.3.0-0.2003.11.30.sel/xc/config/cf/linux.cf
--- xfree86-4.3.0-0.2003.11.30/xc/config/cf/linux.cf	2003-11-30 22:44:36.000000000 -0600
+++ xfree86-4.3.0-0.2003.11.30.sel/xc/config/cf/linux.cf	2003-12-01 13:28:31.000000000 -0600
@@ -1006,3 +1012,57 @@
 #ifndef XFree86ServerOSDefines
 # define XFree86ServerOSDefines
 #endif
+
+/* 
+ *     SELinux support
+ */
+#ifndef HasSELinux
+# define HasSELinux NO
+#endif
+
+#ifndef SELinuxDefines
+# if HasSELinux
+#  define SELinuxDefines -DHAVE_SELINUX
+# else
+#  define SELinuxDefines /**/
+# endif
+#endif
+
+#ifndef SELinuxIncludeFlags
+# if HasSELinux
+#   define SELinuxIncludeFlags -I/usr/include/selinux
+# else
+#   define SELinuxIncludeFlags /**/
+# endif
+#endif
+
+#ifndef SELinuxCompileFlags
+# define SELinuxCompileFlags /**/
+#endif
+
+#ifndef SELinuxLoadFlags
+# define SELinuxLoadFlags SELinuxCompileFlags
+#endif
+
+#ifndef SELinuxLibraries
+# if HasSELinux
+#  define SELinuxLibraries -lselinux
+# else
+#  define SELinuxLibraries /**/
+# endif
+#endif
+
+#if HasSELinux
+# ifndef SELINUX_LDFLAGS
+   SELINUX_LDFLAGS = SELinuxLoadFlags
+# endif
+# ifndef SELINUX_INCLUDES
+   SELINUX_INCLUDES = SELinuxIncludeFlags
+# endif
+# ifndef SELINUX_CFLAGS
+   SELINUX_CFLAGS = SELinuxCompileFlags SELinuxDefines
+# endif
+# ifndef SELINUX_LIBS
+   SELINUX_LIBS = SELinuxLibraries
+# endif
+#endif
diff -uBbwr xfree86-4.3.0-0.2003.11.30/xc/programs/xdm/session.c xfree86-4.3.0-0.2003.11.30.sel/xc/programs/xdm/session.c
--- xfree86-4.3.0-0.2003.11.30/xc/programs/xdm/session.c	2003-11-30 22:44:35.000000000 -0600
+++ xfree86-4.3.0-0.2003.11.30.sel/xc/programs/xdm/session.c	2003-12-01 03:01:31.000000000 -0600
@@ -60,6 +60,11 @@
 # include <krb5/krb5.h>
 #endif
 
+#ifdef HAVE_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/get_context_list.h>
+#endif /* HAVE_SELINUX */
+
 #ifndef GREET_USER_STATIC
 # include <dlfcn.h>
 # ifndef RTLD_NOW
@@ -241,6 +246,34 @@
     SessionExit (d, RESERVER_DISPLAY, TRUE);
 }
 
+#ifdef HAVE_SELINUX
+/* This should be run just before we exec the user session */
+static int
+xdm_selinux_setup (const char *login)
+{
+  security_context_t scontext;
+  /* If selinux is not enabled, then we don't do anything */
+  if ( ! is_selinux_enabled ())
+    return TRUE;
+
+  if (get_default_context((char*) login,0, &scontext) < 0) {
+    LogError ("SELinux: unable to obtain default security context for %s.\n",
+	      login);
+    return FALSE;
+  }
+
+  if (setexeccon (scontext) != 0) {
+    freecon (scontext);
+     LogError ("SELinux: unable to set executable context %s.\n",
+	      (char *)scontext);
+    return FALSE;
+  }
+  freecon (scontext);
+  return TRUE;
+}
+#endif /* HAVE_SELINUX */
+
+
 /*
  * We need our own error handlers because we can't be sure what exit code Xlib
  * will use, and our Xlib does exit(1) which matches REMANAGE_DISPLAY, which
@@ -725,6 +758,19 @@
 #endif /* K5AUTH */
 	bzero (passwd, strlen (passwd));
 	SetUserAuthorization (d, verify);
+
+#ifdef HAVE_SELINUX
+	/*
+	 * for Security Enhanced Linux,
+	 * set the default security context for this user.
+	 */
+	if ( ! xdm_selinux_setup (name)) {
+	  LogError ("failed to set Security context\n");
+	  exit (UNMANAGE_DISPLAY);
+	  return (0);
+	}
+#endif /* HAVE_SELINUX */
+
 	home = getEnv (verify->userEnviron, "HOME");
 	if (home)
 	    if (chdir (home) == -1) {

--=-=-=


-- 
If you keep anything long enough, you can throw it away.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024R/C7261095 print CB D9 F4 12 68 07 E4 05  CC 2D 27 12 1D F5 E8 6E
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
