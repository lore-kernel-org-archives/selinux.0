Subject: Re: API for getting loginuid, for use by newrole and run_init
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: redhat-lspp@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux-dev@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <200601241004.37638.sgrubb@redhat.com>
References: <1138109451.20815.205.camel@moss-spartans.epoch.ncsc.mil>
	 <200601241004.37638.sgrubb@redhat.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 08:27:55 -0500
Message-Id: <1138195675.20815.318.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-24 at 10:04 -0500, Steve Grubb wrote:
> On Tuesday 24 January 2006 08:30, Stephen Smalley wrote:
> > Are there plans to add an API for getting the loginuid of the current
> > process (e.g. getluid() or getloginuid()) either to glibc or in a
> > separate library so that we can easily create and/or modify programs to
> > get and use the loginuid without needing to directly replicate the code
> > to read and parse /proc/self/loginuid each time?
> 
> 
> These have been in libaudit for quite some time:
> 
> extern uid_t audit_getloginuid(void);
> extern int  audit_setloginuid(uid_t uid);

First cut at patches below.  The Makefile diffs use the same approach
that was used for the conditional pam support, as policycoreutils
doesn't use auto* and I'm not inclined to change that.  With these
patches applied, I can use newrole -r sysadm_r when my Linux user is
mapped to staff_u via seusers; it properly re-authenticates me as sds.
Look sane?

Index: policycoreutils/newrole/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/newrole/Makefile,v
retrieving revision 1.16
diff -u -p -r1.16 Makefile
--- policycoreutils/newrole/Makefile	19 Oct 2005 18:49:27 -0000	1.16
+++ policycoreutils/newrole/Makefile	25 Jan 2006 12:56:34 -0000
@@ -5,6 +5,7 @@ MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR = /usr/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
+AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
@@ -16,7 +17,10 @@ else
 	override CFLAGS += -D_XOPEN_SOURCE=500
 	LDLIBS += -lcrypt
 endif
-
+ifeq (${AUDITH}, /usr/include/libaudit.h)
+	override CFLAGS += -DUSE_AUDIT
+	LDLIBS += -laudit
+endif
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
Index: policycoreutils/newrole/newrole.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/newrole/newrole.c,v
retrieving revision 1.11
diff -u -p -r1.11 newrole.c
--- policycoreutils/newrole/newrole.c	13 Jan 2006 13:00:49 -0000	1.11
+++ policycoreutils/newrole/newrole.c	25 Jan 2006 12:57:18 -0000
@@ -62,6 +62,9 @@
 #include <selinux/get_default_type.h>
 #include <selinux/get_context_list.h> /* for SELINUX_DEFAULTUSER */
 #include <signal.h>
+#ifdef USE_AUDIT
+#include <libaudit.h>
+#endif
 #ifdef USE_NLS
 #include <locale.h>			    /* for setlocale() */
 #include <libintl.h>			    /* for gettext() */
@@ -339,7 +342,6 @@ int main( int argc, char *argv[] ) {
   context_t context;		 	 /* manipulatable form of new_context */
 
 
-  const char *se_username;  /* SELinux user identity */
   struct passwd *pw;                 /* struct derived from passwd file line */
   struct passwd pw_copy;
 
@@ -356,6 +358,7 @@ int main( int argc, char *argv[] ) {
   char *level_s = NULL;              /* level spec'd by user in argv[] */
   char *ttyn   = NULL;		     /* tty path */
   pid_t childPid=0;			     
+  uid_t uid;
   int fd;
   int enforcing;
   sigset_t empty;
@@ -487,17 +490,25 @@ int main( int argc, char *argv[] ) {
   }
 
   freecon(old_context);
-  /* Make `pw' point to a structure containing the data              *
-   * from our user's line in the passwd file.  If the current user's
-   * SELinux user identity is the default (SELINUX_DEFAULTUSER), then
-   * we authenticate using the user's UID.  Otherwise we use the SELinux
-   * user identity.
+
+  /*
+   * Determine the Linux user identity to re-authenticate.
+   * If supported and set, use the login uid, as this should be more stable.
+   * Otherwise, use the real uid.
+   * The SELinux user identity is no longer used, as Linux users are now
+   * mapped to SELinux users via seusers and the SELinux user identity space
+   * is separate.
    */
-  se_username = context_user_get(context);
-  if (!strcmp (se_username, SELINUX_DEFAULTUSER))
-    pw = getpwuid(getuid());
-  else
-    pw=getpwnam(se_username);
+#ifdef USE_AUDIT
+  uid = audit_getloginuid();
+  if (uid == (uid_t)-1)
+	  uid = getuid();
+#else
+  uid = getuid();
+#endif    
+  
+  /* Get the passwd info for the Linux user identity. */
+  pw = getpwuid(uid);
   if( !pw ) {
     fprintf(stderr,_("cannot find your entry in the passwd file.\n"));
     exit(-1);
@@ -522,7 +533,12 @@ int main( int argc, char *argv[] ) {
 
   printf(_("Authenticating %s.\n"),pw->pw_name);
 
-  /* Authenticate the user running this program. */
+  /* 
+   * Re-authenticate the user running this program.
+   * This is just to help confirm user intent (vs. invocation by
+   * malicious software), not to authorize the operation (which is covered
+   * by policy).  Trusted path mechanism would be preferred.
+   */
 #ifdef USE_PAM
   if( !authenticate_via_pam(pw, ttyn) ) 
 #else /* !USE_PAM */
Index: policycoreutils/run_init/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/run_init/Makefile,v
retrieving revision 1.17
diff -u -p -r1.17 Makefile
--- policycoreutils/run_init/Makefile	19 Oct 2005 18:49:27 -0000	1.17
+++ policycoreutils/run_init/Makefile	25 Jan 2006 12:56:32 -0000
@@ -6,6 +6,7 @@ MANDIR ?= $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR ?= /usr/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
+AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
@@ -17,6 +18,10 @@ else
 	override CFLAGS += -D_XOPEN_SOURCE=500
 	LDLIBS += -lcrypt
 endif
+ifeq (${AUDITH}, /usr/include/libaudit.h)
+	override CFLAGS += -DUSE_AUDIT
+	LDLIBS += -laudit
+endif
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
Index: policycoreutils/run_init/run_init.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/run_init/run_init.c,v
retrieving revision 1.7
diff -u -p -r1.7 run_init.c
--- policycoreutils/run_init/run_init.c	21 Jan 2005 12:55:20 -0000	1.7
+++ policycoreutils/run_init/run_init.c	25 Jan 2006 12:59:13 -0000
@@ -50,6 +50,9 @@
 #include <fcntl.h>
 #include <ctype.h>
 #include <limits.h>
+#ifdef USE_AUDIT
+#include <libaudit.h>
+#endif
 #ifdef USE_NLS
 #include <libintl.h>
 #include <locale.h>
@@ -220,28 +223,39 @@ int authenticate_via_shadow_passwd( cons
 int authenticate_user() {
 
 #define INITLEN 255
-  security_context_t old_context;     /* original security context as a string */
-  context_t ocontext;                 /* manipulatable form of context_s */
-
   struct passwd *p_passwd_line;      /* struct derived from passwd file line */
+  uid_t uid;
 
-  /* Put our osid into `osid'. */
-  if( 0!=(getprevcon(&old_context)) ) {
-    fprintf(stderr,"failed to get old_context.\n");
-    exit(-1);
-  }
+  /*
+   * Determine the Linux user identity to re-authenticate.
+   * If supported and set, use the login uid, as this should be more stable.
+   * Otherwise, use the real uid.
+   * The SELinux user identity is no longer used, as Linux users are now
+   * mapped to SELinux users via seusers and the SELinux user identity space
+   * is separate.
+   */
+#ifdef USE_AUDIT
+  uid = audit_getloginuid();
+  if (uid == (uid_t)-1)
+	  uid = getuid();
+#else
+  uid = getuid();
+#endif      
 
-  ocontext=context_new(old_context);                                
-  freecon(old_context);
-  if( !(p_passwd_line=getpwnam(context_user_get(ocontext))) ) {
+  p_passwd_line = getpwuid(uid);
+  if (!p_passwd_line) {
     fprintf(stderr, "cannot find your entry in the passwd file.\n");
     return(-1);
   }
-  context_free( ocontext );
   
   printf("Authenticating %s.\n",p_passwd_line->pw_name);
 
-  /* Authenticate the user running this program. */
+  /* 
+   * Re-authenticate the user running this program.
+   * This is just to help confirm user intent (vs. invocation by
+   * malicious software), not to authorize the operation (which is covered
+   * by policy).  Trusted path mechanism would be preferred.
+   */
 #ifdef USE_PAM
   if( !authenticate_via_pam(p_passwd_line) ) {
 #else /* !USE_PAM */

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
