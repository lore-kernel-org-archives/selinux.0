Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i52HO6rT006206
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 13:24:06 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i53HNo0x021810
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 13:23:50 -0400 (EDT)
Subject: Re: issue with SE/Linux - sshd not giving access to /dev/pts/[n]
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200406021631.50230.russell@coker.com.au>
References: <20040601090345.GM8312@lkcl.net>
	 <200406021631.50230.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1086196986.15871.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Jun 2004 13:23:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-06-02 at 02:31, Russell Coker wrote:
> When you login the terminal must be given a type label that permits you access 
> to it.  Otherwise you can't access your terminal and get logged out.
> 
> There is a bug in the SE Linux pam code or in sshd which results in the 
> terminal not being correctly relabelled in some situations.  Someone (maybe 
> you) needs to debug this.  I would guess that the PAM code is doing the wrong 
> thing, the PAM code in question is in Fedora and in my repository for SE 
> Linux Debian packages.  It is not in the main-line PAM distribution because 
> nothing happens there.

I hadn't seen such a bug report previously - is this also true of the
RedHat openssh package (still based on 3.6.1p2) or is it new to 3.8?  If
using pam doesn't work with 3.8 (e.g. if they have moved the call to
pam_open_session such that it is no longer performed at the right point
in processing for us to set the exec context and relabel the pty), then
I would recommend going back to a direct patch for sshd.  The direct
patch for openssh 3.6 (prior to switching to using pam_selinux) is
below.

--- openssh-3.6.1p2/session.c.selinux	2003-10-13 10:22:17.975083901 -0400
+++ openssh-3.6.1p2/session.c	2003-10-13 10:22:34.399253449 -0400
@@ -58,6 +58,11 @@
 #include "session.h"
 #include "monitor_wrap.h"
 
+#ifdef WITH_SELINUX
+#include <selinux/get_context_list.h>
+#include <selinux/selinux.h>
+#endif
+
 #ifdef HAVE_CYGWIN
 #include <windows.h>
 #include <sys/cygwin.h>
@@ -1268,6 +1273,18 @@
 #endif
 	if (getuid() != pw->pw_uid || geteuid() != pw->pw_uid)
 		fatal("Failed to set uids to %u.", (u_int) pw->pw_uid);
+#ifdef WITH_SELINUX
+	if (is_selinux_enabled()>0)
+	  {
+	    security_context_t scontext;
+	    if (get_default_context(pw->pw_name,NULL,&scontext))
+	      fatal("Failed to get default security context for %s.", pw->pw_name);
+	    if (setexeccon(scontext)) {
+	      fatal("Failed to set exec security context %s for %s.", scontext, pw->pw_name);
+	    }
+	    freecon(scontext);
+	  }
+#endif
 }
 
 static void
--- openssh-3.6.1p2/sshpty.c.selinux	2003-02-23 19:54:10.000000000 -0500
+++ openssh-3.6.1p2/sshpty.c	2003-10-13 10:22:18.079072312 -0400
@@ -22,6 +22,12 @@
 #include "log.h"
 #include "misc.h"
 
+#ifdef WITH_SELINUX
+#include <selinux/flask.h>
+#include <selinux/get_context_list.h>
+#include <selinux/selinux.h>
+#endif
+
 /* Pty allocated with _getpty gets broken if we do I_PUSH:es to it. */
 #if defined(HAVE__GETPTY) || defined(HAVE_OPENPTY)
 #undef HAVE_DEV_PTMX
@@ -386,6 +392,37 @@
 	 * Warn but continue if filesystem is read-only and the uids match/
 	 * tty is owned by root.
 	 */
+#ifdef WITH_SELINUX
+	if (is_selinux_enabled()>0) {
+	  security_context_t 	  new_tty_context=NULL,
+	    user_context=NULL, old_tty_context=NULL; 
+
+	  if (get_default_context(pw->pw_name,NULL,&user_context))
+	      fatal("Failed to get default security context for %s.", pw->pw_name);
+
+	  if (getfilecon(ttyname, &old_tty_context)<0) {
+	    error("getfilecon(%.100s) failed: %.100s", ttyname,
+		  strerror(errno));
+	  }
+	  else 
+	    {
+	      if ( security_compute_relabel(user_context,old_tty_context,SECCLASS_CHR_FILE,&new_tty_context)!=0) {
+		error("security_compute_relabel(%.100s) failed: %.100s", ttyname,
+		      strerror(errno));
+	      } 
+	      else 
+		{
+		  if (setfilecon (ttyname, new_tty_context) != 0) {
+		    error("setfilecon(%.100s, %s) failed: %.100s",
+			  ttyname, new_tty_context, strerror(errno));
+		  }
+		  freecon(new_tty_context);
+		}
+	      freecon(old_tty_context);
+	    }
+	  freecon(user_context);
+	}
+#endif
 	if (stat(ttyname, &st))
 		fatal("stat(%.100s) failed: %.100s", ttyname,
 		    strerror(errno));
@@ -415,4 +452,5 @@
 				    ttyname, mode, strerror(errno));
 		}
 	}
+
 }
--- openssh-3.6.1p2/Makefile.in.selinux	2003-04-29 05:12:08.000000000 -0400
+++ openssh-3.6.1p2/Makefile.in	2003-10-13 10:22:18.080072200 -0400
@@ -40,7 +40,7 @@
 
 CC=@CC@
 LD=@LD@
-CFLAGS=@CFLAGS@
+CFLAGS=@CFLAGS@ -DWITH_SELINUX
 CPPFLAGS=-I. -I$(srcdir) @CPPFLAGS@ $(PATHS) @DEFS@
 LIBS=@LIBS@
 LIBPAM=@LIBPAM@
@@ -52,7 +52,7 @@
 SED=@SED@
 ENT=@ENT@
 XAUTH_PATH=@XAUTH_PATH@
-LDFLAGS=-L. -Lopenbsd-compat/ @LDFLAGS@
+LDFLAGS=-L. -Lopenbsd-compat/ @LDFLAGS@ -lselinux 
 EXEEXT=@EXEEXT@
 
 INSTALL_SSH_PRNG_CMDS=@INSTALL_SSH_PRNG_CMDS@

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
