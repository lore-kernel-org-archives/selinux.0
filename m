Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JEgERb010769
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 10:42:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4JEdmB2019243
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 14:39:48 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
	by jazzswing.ncsc.mil  with SMTP id i4JEdlwi019234
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 14:39:47 GMT
Date: Wed, 19 May 2004 14:39:30 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>, 249784@bugs.debian.org
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
Message-ID: <20040519143930.GJ4221@lkcl.net>
References: <20040519074242.GK7348@lkcl.net> <200405200005.52165.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
In-Reply-To: <200405200005.52165.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 20, 2004 at 12:05:52AM +1000, Russell Coker wrote:
> On Wed, 19 May 2004 17:42, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > is this pretty much all that's required??? ?compared to the 2.4 stuff
> > it's like tiny.
> 
> In addition to the issues Steve mentioned, there is (or was) another problem.  
> There were compilation problems with the SE Linux headers last time I tried 
> to compile kdm.  As kdm is in the middle of a huge package that takes ages to 
> compile I hadn't got around to trying to compile it recently.  In your 
> message you didn't mention whether you successfully compiled the code with 
> the patch in question.  Does it compile?
 
 well, it does now, because i cheated.

 i don't have automake-1.8.3 installed and if you install automake 1.8.5
 it corrupts things (misses out a .moc file, aclocal bitches about some
 incompatibilities, and it all just goes horribly pearshaped)

 if you _don't_ run automake then any modifications to Makefile.am
 of course don't get propagated into Makefiles.in and of course
 then configure --enable-selinux doesn't work.


 ... so i cheated:

 after doing an apt-get source kdm and apt-get build-dep kdm:

 1) i installed automake 1.8.5

 2) i made the necessary patches to configure.in, configure.in.in,
 kdm/backend/Makefile.am

 3) i ran aclocal; autoheader; automake --add-missing; autoconf

 4) i made a backup of kdm/backend/Makefile.in and .am and other
    modified fils

 5) i DELETED the entire kdebase-3.2.2 tree

 6) i REINSTALLED the kdebase-3.2.2 tree

 7) i COPIED the backups BACK to their locations

 8) i ran autoconf (NOT automake and NOT aclocal)

 9) i did a dpkg-buildpackage

 repeat 9) darn it to heck because i hadn't added SessionExit at
 the appropriate points if get_default_context() failed, and
 also the username is stored in a variable curuser whereas in
 the wdm patch it's stored in a different local variable arg.

 l.


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=g

--- ../orig/kdebase-3.2.2/kdm/backend/client.c	2004-02-11 13:42:31.000000000 +0000
+++ kdm/backend/client.c	2004-05-19 13:15:20.000000000 +0000
@@ -44,6 +44,12 @@
 #include <sys/stat.h>
 #include <pwd.h>
 #include <grp.h>
+
+#ifdef WITH_SELINUX
+#include <selinux/get_context_list.h>
+#include <selinux/selinux.h>
+#endif
+
 #ifdef SECURE_RPC
 # include <rpc/rpc.h>
 # include <rpc/key_prot.h>
@@ -1085,6 +1091,28 @@
 	   systemEnviron);
 
     /*
+     * for Security Enhanced Linux,
+     * set the default security context for this user.
+     */
+#ifdef WITH_SELINUX
+   if (is_selinux_enabled() > 0)
+   {
+        security_context_t scontext;
+        if (get_default_context(curuser,NULL,&scontext))
+		{
+             LogError("Failed to get default security context for %s.", curuser);
+             SessionExit (EX_NORMAL);
+		}
+        Debug("setting security context to %s", scontext);
+        if (setexeccon(scontext)) {
+             freecon(scontext);
+             LogError("Failed to set exec security context %s for %s.", scontext, curuser);
+             SessionExit (EX_NORMAL);
+        }
+        freecon(scontext);
+   }
+#endif
+    /*
      * for user-based authorization schemes,
      * add the user to the server's allowed "hosts" list.
      */
--- ../orig/kdebase-3.2.2/configure.in.in	2004-01-09 15:20:36.000000000 +0000
+++ configure.in.in	2004-05-19 12:36:01.000000000 +0000
@@ -196,3 +196,24 @@
 #define AVOID_XKB                 /* for konsole to avoid XKB and XTEST */
 #endif
 ])
+
+AC_MSG_CHECKING(for SELinux support)
+AC_ARG_ENABLE(selinux,
+   AC_HELP_STRING([--enable-selinux], [enable SELinux support]),
+   [
+       AC_MSG_RESULT(yes)
+       AC_CHECK_LIB(selinux, is_selinux_enabled, [SELINUX_LDFLAGS="-lselinux"
+           AC_DEFINE_UNQUOTED(HAVE_SELINUX_LIB, 1, [Define if libselinux is installed])
+               AC_DEFINE(WITH_SELINUX, 1, [Define if you want wdm to be compiled with SELinux support])
+               SELINUX_CFLAGS="-DWITH_SELINUX -I/usr/include/selinux"
+               ],
+               [
+               AC_MSG_WARN([libselinux not found, compiling without SELinux support])
+               ])
+   ],
+   [
+       AC_MSG_RESULT(no)
+   ])
+AC_SUBST(SELINUX_LDFLAGS)
+AC_SUBST(SELINUX_CFLAGS)
+
--- ../orig/kdebase-3.2.2/configure.in	2004-04-09 06:43:53.000000000 +0000
+++ configure.in	2004-05-19 12:36:23.000000000 +0000
@@ -261,6 +263,27 @@
 #define AVOID_XKB                 /* for konsole to avoid XKB and XTEST */
 #endif
 ])
+
+AC_MSG_CHECKING(for SELinux support)
+AC_ARG_ENABLE(selinux,
+   AC_HELP_STRING([--enable-selinux], [enable SELinux support]),
+   [
+       AC_MSG_RESULT(yes)
+       AC_CHECK_LIB(selinux, is_selinux_enabled, [SELINUX_LDFLAGS="-lselinux"
+           AC_DEFINE_UNQUOTED(HAVE_SELINUX_LIB, 1, [Define if libselinux is installed])
+               AC_DEFINE(WITH_SELINUX, 1, [Define if you want wdm to be compiled with SELinux support])
+               SELINUX_CFLAGS="-DWITH_SELINUX -I/usr/include/selinux"
+               ],
+               [
+               AC_MSG_WARN([libselinux not found, compiling without SELinux support])
+               ])
+   ],
+   [
+       AC_MSG_RESULT(no)
+   ])
+AC_SUBST(SELINUX_LDFLAGS)
+AC_SUBST(SELINUX_CFLAGS)
+
 dnl =======================================================
 dnl FILE: ./kappfinder/configure.in.in
 dnl =======================================================
--- ../orig/kdebase-3.2.2/debian/rules	2004-02-27 22:11:15.000000000 +0000
+++ debian/rules	2004-05-19 12:45:04.000000000 +0000
@@ -72,7 +72,7 @@
 
 	# run configure with build tree $(objdir)
 	cd $(objdir) && \
-	../configure $(configkde) --enable-final \
+	../configure $(configkde) --enable-final --enable-selinux \
 	--with-shadow --without-java \
 	--with-pam=kde --with-kcp-pam=kcheckpass \
 	--with-kdm-pam=kdm --with-kss-pam=kscreensaver

--5vNYLRcllDrimb99--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
