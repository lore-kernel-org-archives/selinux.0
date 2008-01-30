Message-ID: <47A08F44.20308@redhat.com>
Date: Wed, 30 Jan 2008 09:52:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Resend: Sudo Changes for SELinux
References: <4784EFE8.9050106@redhat.com>	 <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>	 <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>	 <478670A8.5080902@redhat.com> <1199995291.3707.15.camel@vogon>	 <47877F43.5030401@redhat.com>	 <1200065528.29816.66.camel@moss-spartans.epoch.ncsc.mil> <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil> <4787BF20.1050105@redhat.com>
In-Reply-To: <4787BF20.1050105@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------040904080300000008050104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040904080300000008050104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is an update selinux patch for sudo potentially for rawhide.  I
have updated selinux policy to work with it.  A lot of it was copied
from newrole.

So now you can execute
# grep dwalsh /etc/sudoers
dwalsh	ALL=(ALL) 	ALL

$ id -Z
staff_u:staff_r:staff_t:s0
# sudo -r unconfined_r -t unconfined_t id -Z
staff_u:unconfined_r:unconfined_t:s0
# sudo -r webadm_r -t webadm_t id -Z
staff_u:webadm_r:webadm_t:s0

$ sudo -r unconfined_r -t unconfined_t sh
# /usr/sbin/semanage user -l | grep staff_u
staff_u         staff      s0         s0-s0:c0.c1023
system_r sysadm_r staff_r unconfined_r webadm_r

$ sudo -r webadm_r -t webadm_t sh
# /sbin/service httpd start
Starting httpd:                                            [  OK  ]
# ps -eZ | grep http
staff_u:system_r:httpd_t:s0     11870 ?        00:00:00 httpd
staff_u:system_r:httpd_t:s0     11872 ?        00:00:00 httpd
staff_u:system_r:httpd_t:s0     11874 ?        00:00:00 httpd
staff_u:system_r:httpd_t:s0     11875 ?        00:00:00 httpd
staff_u:system_r:httpd_t:s0     11876 ?        00:00:00 httpd
staff_u:system_r:httpd_t:s0     11877 ?        00:00:00 httpd
staff_u:system_r:httpd_t:s0     11878 ?        00:00:00 httpd
staff_u:system_r:httpd_t:s0     11879 ?        00:00:00 httpd
staff_u:system_r:httpd_t:s0     11880 ?        00:00:00 httpd

# /sbin/service ntp start
ntp: unrecognized service

# touch /dan.html
touch: cannot touch `/dan.html': Permission denied
# touch /var/www/html/dan.html
# ls
# ls -lZ /var/www/html/dan.html
- -rw-r--r--+ root root staff_u:object_r:httpd_sys_content_t:s0
/var/www/html/dan.html

With this patch and the correct selinux policy(rawhide), I can do
everything I want with sudo, for RBAC controls.  The problem is the
administrator needs to know the correct commands to enter to select the
correct roles.  I would rather put this in the sudoers file.  So what
would be the correct context to say when dwalsh runs any app the shell
he starts is running webadm_r:webadm_t?

One controversial part of the sudo patch is the addition of a new shell
/usr/sbin/sesh.  This shell is only to make sure all transitions happen
properly.  So the role/type selected apply to a shell and not to the
command entered on the sudo line.  This prevents the admin from
executing sudo -r webadm_r -t webadm_t rpm -i ...
And rpm running as webadm_t instead of doing a transition to rpm_t.
(if webadm_t has a transition to rpm_t).  We could force this to always
use /bin/bash but there could be problems there.  And not all shells
work the same way, so potentially using the login shell could cause
problems.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkegj0MACgkQrlYvE4MpobM7XACgg1uIbEGvNaTSNzpGYEw04kMN
lIIAnjpjW3I5UtSs9HfyKdyucDCgSApT
=8aRF
-----END PGP SIGNATURE-----

--------------040904080300000008050104
Content-Type: text/plain;
 name="sudo-1.6.9p4-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sudo-1.6.9p4-selinux.patch"

diff -up sudo-1.6.9p4/configure.in.selinux sudo-1.6.9p4/configure.in
--- sudo-1.6.9p4/configure.in.selinux	2008-01-29 15:25:02.000000000 -0500
+++ sudo-1.6.9p4/configure.in	2008-01-29 15:25:02.000000000 -0500
@@ -101,7 +101,7 @@ dnl
 dnl Initial values for Makefile variables listed above
 dnl May be overridden by environment variables..
 dnl
-PROGS="sudo visudo"
+PROGS="sudo visudo sesh"
 : ${MANTYPE='man'}
 : ${mansrcdir='.'}
 : ${SUDOERS_MODE='0440'}
diff -up /dev/null sudo-1.6.9p4/selinux.c
--- /dev/null	2008-01-29 07:07:11.771655674 -0500
+++ sudo-1.6.9p4/selinux.c	2008-01-29 15:34:17.000000000 -0500
@@ -0,0 +1,425 @@
+/*
+ * Copyright (c) 2008 Dan Walsh <dwalsh@redhat.com>
+ *
+ * Borrowed heavily from newrole source code
+ * Authors:
+ *      Anthony Colatrella
+ *	Tim Fraser
+ *	Steve Grubb <sgrubb@redhat.com>
+ *	Darrel Goeddel <DGoeddel@trustedcs.com>
+ *	Michael Thompson <mcthomps@us.ibm.com>
+ *	Dan Walsh <dwalsh@redhat.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+#ifdef WITH_SELINUX
+#include <config.h>
+#include <sys/types.h>
+#include <stdio.h>
+#ifdef STDC_HEADERS
+# include <stdlib.h>
+# include <stddef.h>
+#else
+# ifdef HAVE_STDLIB_H
+#  include <stdlib.h>
+# endif
+#endif /* STDC_HEADERS */
+#ifdef HAVE_STRING_H
+# if defined(HAVE_MEMORY_H) && !defined(STDC_HEADERS)
+#  include <memory.h>
+# endif
+# include <string.h>
+#else
+# ifdef HAVE_STRINGS_H
+#  include <strings.h>
+# endif
+#endif /* HAVE_STRING_H */
+#ifdef HAVE_UNISTD_H
+# include <unistd.h>
+#endif /* HAVE_UNISTD_H */
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+
+#ifdef WITH_AUDIT
+#include <libaudit.h>
+#endif
+
+#include "sudo.h"
+
+#include <sys/wait.h>
+
+#ifdef USE_AUDIT
+#include <libaudit.h>
+#endif
+
+#include <selinux/flask.h>             /* for SECCLASS_CHR_FILE */
+#include <selinux/selinux.h>           /* for is_selinux_enabled() */
+#include <selinux/context.h>           /* for context-mangling functions */
+#include <selinux/get_default_type.h>
+#include <selinux/get_context_list.h>
+
+/**
+ * This function attempts to revert the relabeling done to the tty.
+ * fd   - referencing the opened ttyn
+ * ttyn - name of tty to restore
+ * tty_context     - original context of the tty
+ * new_tty_context - context tty was relabeled to
+ *
+ * Returns zero on success, non-zero otherwise
+ */
+static int restore_tty_label(int fd, const char *ttyn,
+			     security_context_t tty_context,
+			     security_context_t new_tty_context)
+{
+	int rc = 0;
+	security_context_t chk_tty_context = NULL;
+
+	if (!ttyn)
+		goto skip_relabel;
+
+	if (!new_tty_context)
+		goto skip_relabel;
+
+	/* Verify that the tty still has the context set by newrole. */
+	if ((rc = fgetfilecon(fd, &chk_tty_context)) < 0) {
+		fprintf(stderr, "Could not fgetfilecon %s.\n", ttyn);
+		goto skip_relabel;
+	}
+
+	if ((rc = strcmp(chk_tty_context, new_tty_context))) {
+		fprintf(stderr, "%s changed labels.\n", ttyn);
+		goto skip_relabel;
+	}
+
+	if ((rc = fsetfilecon(fd, tty_context)) < 0)
+		fprintf(stderr,
+			"Warning! Could not restore context for %s\n", ttyn);
+      skip_relabel:
+	freecon(chk_tty_context);
+	return rc;
+}
+
+/**
+ * This function attempts to relabel the tty. If this function fails, then
+ * the fd is closed, the contexts are free'd and -1 is returned. On success,
+ * a valid fd is returned and tty_context and new_tty_context are set.
+ *
+ * This function will not fail if it can not relabel the tty when selinux is
+ * in permissive mode.
+ */
+static int relabel_tty(const char *ttyn, security_context_t new_context,
+		       security_context_t * tty_context,
+		       security_context_t * new_tty_context)
+{
+	int fd;
+	int enforcing = security_getenforce();
+	security_context_t tty_con = NULL;
+	security_context_t new_tty_con = NULL;
+
+	if (!ttyn)
+		return 0;
+
+	if (enforcing < 0) {
+		fprintf(stderr, "Could not determine enforcing mode.\n");
+		return -1;
+	}
+
+	/* Re-open TTY descriptor */
+	fd = open(ttyn, O_RDWR | O_NONBLOCK);
+	if (fd < 0) {
+		fprintf(stderr, "Error!  Could not open %s.\n", ttyn);
+		return fd;
+	}
+	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+
+	if (fgetfilecon(fd, &tty_con) < 0) {
+		fprintf(stderr, "%s!  Could not get current context "
+				  "for %s, not relabeling tty.\n",
+			enforcing ? "Error" : "Warning", ttyn);
+		if (enforcing)
+			goto close_fd;
+	}
+
+	if (tty_con &&
+	    (security_compute_relabel(new_context, tty_con,
+				      SECCLASS_CHR_FILE, &new_tty_con) < 0)) {
+		fprintf(stderr, "%s!  Could not get new context for %s, "
+				  "not relabeling tty.\n",
+			enforcing ? "Error" : "Warning", ttyn);
+		if (enforcing)
+			goto close_fd;
+	}
+
+	if (new_tty_con)
+		if (fsetfilecon(fd, new_tty_con) < 0) {
+			fprintf(stderr,
+				"%s!  Could not set new context for %s\n",
+				enforcing ? "Error" : "Warning", ttyn);
+			freecon(new_tty_con);
+			new_tty_con = NULL;
+			if (enforcing)
+				goto close_fd;
+		}
+
+	*tty_context = tty_con;
+	*new_tty_context = new_tty_con;
+	return fd;
+
+      close_fd:
+	freecon(tty_con);
+	close(fd);
+	return -1;
+}
+
+security_context_t get_exec_context(security_context_t old_context, char *role_s, char *type_s) {
+
+  /* our target security ID ("sid") */
+  security_context_t new_context=NULL; 
+
+  /* manipulatable form of context_s */
+  context_t context;                 
+  
+  if( !role_s ) {
+    fprintf(stderr,"You must specify a role.\n");
+    return NULL;
+  }
+	  
+  
+  /*
+   * Get the SID and context of the caller, and extract
+   * the username from the context.  Don't rely on the Linux
+   * uid information - it isn't trustworthy.
+   */
+  
+  /* 
+   * Create a context structure so that we extract and modify 
+   * components easily. 
+   */
+  context=context_new(old_context);
+  
+  /*
+   *
+   * Step 3:  Construct a new SID based on our old SID and the
+   *          arguments specified on the command line.
+   *
+   */
+  
+  /* The first step in constructing a new SID for the new shell we  *
+   * plan to exec is to take our old context in `context' as a   *
+   * starting point, and modify it according to the options the user *
+   * specified on the command line.                                  */
+
+  /* If the user specified a new role on the command line (if `role_s'   *
+   * is set), then replace the old role in `context' with this new role. */
+  if( !type_s ) {
+    if( get_default_type(role_s,&type_s) )
+      {
+        fprintf(stderr,"Couldn't get default type.\n");
+	goto err;
+      }
+    }
+    
+  if( context_role_set(context,role_s)) {
+    fprintf(stderr,"failed to set new role %s\n",role_s);
+    goto err;
+  }
+    
+  /* If the user specified a new type on the command line (if `type_s'   *
+   * is set), then replace the old type in `context' with this new type. */
+  if( type_s ) {
+    if( context_type_set(context,type_s)) {
+      fprintf(stderr,"failed to set new type %s\n",type_s);
+      goto err;
+    }
+  } /* if user specified new type */
+    
+  /* The second step in creating the new SID is to convert our modified *
+   * `context' structure back to a context string and then to a SID.    */
+    
+  /* Make `context_s' point to a string version of the new `context'.  */
+  if( !(new_context=strdup(context_str(context)))) {
+    fprintf(stderr,"failed to convert new context to string\n" );
+    goto err;
+  }
+
+  if (security_check_context(new_context) < 0) {
+    fprintf(stderr, "%s is not a valid context\n", new_context);
+    goto err;
+  }
+
+#ifdef DEBUG
+  printf("Your new context is %s\n",new_context);
+#endif
+
+  context_free(context);
+  return new_context;
+
+ err:
+  context_free(context);
+  freecon(new_context);
+  return NULL;
+
+}
+
+void selinux_exec(char *role_s, char *type_s, char *safe_cmd, int NewArgc, char **NewArgv, char **environ){ 
+  pid_t childPid = 0;
+  int ttyfd = -1;
+  /* our original securiy ID ("old_context") */
+  security_context_t old_context=NULL;	
+
+  /* security context to change to while running command*/
+  security_context_t new_tty_context=NULL; 
+  /* current security context of tty */
+  security_context_t tty_context=NULL;  
+
+  char *ttyn = NULL;	/* tty path */
+  
+  /* our target security ID ("sid") */
+  security_context_t new_context=NULL;
+  /* Put the caller's SID into `old_context'. */
+  if (getprevcon(&old_context)) {
+    fprintf(stderr,"failed to get old_context.\n");
+    exit(-1);
+  }
+  
+#ifdef DEBUG
+  printf( "Your old context was %s\n", old_context );
+#endif
+  new_context=get_exec_context(old_context, role_s,type_s);
+  if (! new_context) {
+	  fprintf(stderr, "Could not set exec context to %s.\n", new_context);
+	  exit(-1);
+  }
+  
+  ttyn = ttyname(STDIN_FILENO);
+  if (!ttyn || *ttyn == '\0') {
+	  fprintf(stderr,
+		  "Warning!  Could not retrieve tty information.\n");
+  }
+  
+  ttyfd = relabel_tty(ttyn, new_context, &tty_context, &new_tty_context);
+  if (ttyfd < 0) {
+	  fprintf(stderr, "Could not setup tty context for %s.\n", new_context);
+	  exit(-1);
+  }
+
+#ifdef DEBUG
+  printf("Your old tty context is %s\n",tty_context);
+  printf("Your new tty context is %s\n",new_tty_context);
+#endif
+
+
+  childPid = fork();
+  if (childPid < 0) {
+	  /* fork failed, no child to worry about */
+	  int errsv = errno;
+	  fprintf(stderr, "newrole: failure forking: %s",
+		  strerror(errsv));
+	  if (restore_tty_label(ttyfd, ttyn, tty_context, new_tty_context))
+		  fprintf(stderr, "Unable to restore tty label...\n");
+	  if (close(ttyfd))
+		  fprintf(stderr, "Failed to close tty properly\n");
+	  goto err;
+  } else if (childPid) {
+	  /* PARENT
+	   * It doesn't make senes to exit early on errors at this point,
+	   * since we are doing cleanup which needs to be done.
+	   * We can exit with a bad rc though
+	   */
+	  pid_t pid;
+	  int exit_code = 0;
+	  int status;
+	  
+	  do {
+		  pid = wait(&status);
+	  } while (pid < 0 && errno == EINTR);
+	  
+	  /* Preserve child exit status, unless there is another error. */
+	  if (WIFEXITED(status))
+		  exit_code = WEXITSTATUS(status);
+	  
+	  if (restore_tty_label(ttyfd, ttyn, tty_context, new_tty_context)) {
+		  fprintf(stderr, "Unable to restore tty label...\n");
+		  exit_code = -1;
+	  }
+	  freecon(tty_context);
+	  freecon(new_tty_context);
+	  if (close(ttyfd)) {
+		  fprintf(stderr, "Failed to close tty properly\n");
+		  exit_code = -1;
+	  }
+	  exit(exit_code);
+  }
+  /* CHILD */
+  /* Close the tty and reopen descriptors 0 through 2 */
+  if (ttyn) {
+    if (close(ttyfd) || close(0) || close(1) || close(2)) {
+	    fprintf(stderr, "Could not close descriptors.\n");
+	    goto err;
+    }
+    ttyfd = open(ttyn, O_RDONLY | O_NONBLOCK);
+    if (ttyfd != 0)
+	    goto err;
+    fcntl(ttyfd, F_SETFL, fcntl(ttyfd, F_GETFL, 0) & ~O_NONBLOCK);
+    ttyfd = open(ttyn, O_RDWR | O_NONBLOCK);
+    if (ttyfd != 1)
+	    goto err;
+    fcntl(ttyfd, F_SETFL, fcntl(ttyfd, F_GETFL, 0) & ~O_NONBLOCK);
+    ttyfd = open(ttyn, O_RDWR | O_NONBLOCK);
+    if (ttyfd != 2)
+	    goto err;
+    fcntl(ttyfd, F_SETFL, fcntl(ttyfd, F_GETFL, 0) & ~O_NONBLOCK);
+  }
+  if (setexeccon(new_context)) {
+	  fprintf(stderr, "Could not set exec context to %s.\n",
+		  new_context);
+	  goto err;
+  }
+
+#ifdef USE_AUDIT
+  if (send_audit_message(1, old_context, new_context, ttyn)) 
+    goto err;
+#endif
+
+  {
+    /* 
+       SELinux will only not transition properly with the following
+       code.  Basically if the user chooses to use a different security
+       context.  We need to start the selinux shell, before executing 
+       the command.  This way the process transition will happen 
+       correctly. For example if they user wants to run rpm from 
+       sysadm_r.  Sudo will exec the /usr/sbin/sesh followed by the 
+       specified command.*/
+     char **dst, **src = NewArgv+1;
+     NewArgv = (char **) emalloc2((++NewArgc + 1), sizeof(char *));
+     NewArgv[0] = estrdup("/usr/sbin/sesh");
+     NewArgv[1] = safe_cmd;
+     safe_cmd = estrdup("/usr/sbin/sesh");
+     /* copy the args from Argv */
+     for (dst = NewArgv + 2; (*dst = *src) != NULL; ++src, ++dst)
+	     ;
+  }
+  freecon(old_context);
+  freecon(new_context);
+
+  execve(safe_cmd, NewArgv, environ);	/* run the command */
+  
+  perror("failed to exec shell\n");
+ err:
+  freecon(old_context);
+  freecon(new_context);
+  exit(-1);
+}
+#endif /* WITH_SELINUX */
diff -up /dev/null sudo-1.6.9p4/sesh.c
--- /dev/null	2008-01-29 07:07:11.771655674 -0500
+++ sudo-1.6.9p4/sesh.c	2008-01-29 15:25:02.000000000 -0500
@@ -0,0 +1,46 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <errno.h>
+
+main (int argc, char **argv) {
+  char buf[PATH_MAX];
+  pid_t pid;
+  if ( argc < 2 ) {
+    fprintf(stderr,"%s: Requires at least one argument\n", argv[0]);
+    exit(-1);
+  }
+
+  if ((pid = fork()) < 0) {
+    snprintf(buf, sizeof(buf), "%s: Couldn't fork",argv[0]);
+    perror(buf);
+    exit(-1);
+  } else if (pid > 0) {
+    /* Parent */
+    int status;
+    int ret;
+
+    do {
+      if ((ret = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
+        continue;
+      else if (ret < 0) {
+        perror("waitpid failed");
+        exit(1);
+      }
+    } while (0);
+
+    if (WIFEXITED(status))
+      exit(WEXITSTATUS(status));
+    else
+      exit(1);
+  } else {
+    /* Child */
+    execv(argv[1], &argv[1]);
+
+    snprintf(buf, sizeof(buf), "%s: Error execing %s", argv[0], argv[1]);
+    perror(buf);
+    exit(-1);
+  }
+}
diff -up sudo-1.6.9p4/sudo.man.in.selinux sudo-1.6.9p4/sudo.man.in
--- sudo-1.6.9p4/sudo.man.in.selinux	2007-08-15 10:16:58.000000000 -0400
+++ sudo-1.6.9p4/sudo.man.in	2008-01-29 15:25:02.000000000 -0500
@@ -159,6 +159,7 @@ sudo, sudoedit \- execute a command as a
 .PP
 \&\fBsudo\fR [\fB\-bEHPS\fR] [\fB\-a\fR\ \fIauth_type\fR]
 [\fB\-c\fR\ \fIclass\fR|\fI\-\fR] [\fB\-p\fR\ \fIprompt\fR] [\fB\-u\fR\ \fIusername\fR|\fI#uid\fR]
+[\fB\-r\fR \fIrole\fR ] [\fB\-t\fR \fItype\fR ]
 [\fB\s-1VAR\s0\fR=\fIvalue\fR] {\fB\-i\fR\ |\ \fB\-s\fR\ |\ \fIcommand\fR}
 .PP
 \&\fBsudoedit\fR [\fB\-S\fR] [\fB\-a\fR\ \fIauth_type\fR] [\fB\-c\fR\ \fIclass\fR|\fI\-\fR]
@@ -323,6 +324,16 @@ preserve the invoking user's group vecto
 \&\fBsudo\fR will initialize the group vector to the list of groups the
 target user is in.  The real and effective group IDs, however, are
 still set to match the target user.
+.IP "\-r" 4
+.IX Item "-r"
+The \fB\-r\fR (\fRrole\fR) option causes the new (SELinux) security context to have the role specified by
+\fIROLE\fR.
+.IP "\-t" 4
+.IX Item "-t" 
+The \fB\-t\fR (\fRtype\fR) option causes the new (SELinux) security context to have the have the type (domain)
+specified by
+\fITYPE\fR.
+If no type is specified, the default type is derived from the specified role.
 .IP "\-p" 4
 .IX Item "-p"
 The \fB\-p\fR (\fIprompt\fR) option allows you to override the default
diff -up sudo-1.6.9p4/Makefile.in.selinux sudo-1.6.9p4/Makefile.in
--- sudo-1.6.9p4/Makefile.in.selinux	2008-01-29 15:25:02.000000000 -0500
+++ sudo-1.6.9p4/Makefile.in	2008-01-29 15:25:02.000000000 -0500
@@ -43,7 +43,8 @@ INSTALL = $(SHELL) $(srcdir)/install-sh 
 # Libraries
 LIBS = @LIBS@
 NET_LIBS = @NET_LIBS@
-SUDO_LIBS = @SUDO_LIBS@ @AFS_LIBS@ $(LIBS) $(NET_LIBS)
+SELINUX_LIBS = -lselinux 
+SUDO_LIBS = @SUDO_LIBS@ @AFS_LIBS@ $(LIBS) $(NET_LIBS) $(SELINUX_LIBS)
 
 # C preprocessor flags
 CPPFLAGS = -I. -I$(srcdir) @CPPFLAGS@
@@ -90,7 +91,7 @@ sudoers_gid = @SUDOERS_GID@
 sudoers_mode = @SUDOERS_MODE@
 
 # Pass in paths and uid/gid + OS dependent defined
-DEFS = @OSDEFS@ -D_PATH_SUDOERS=\"$(sudoersdir)/sudoers\" -D_PATH_SUDOERS_TMP=\"$(sudoersdir)/sudoers.tmp\" -DSUDOERS_UID=$(sudoers_uid) -DSUDOERS_GID=$(sudoers_gid) -DSUDOERS_MODE=$(sudoers_mode)
+DEFS = @OSDEFS@ -D_PATH_SUDOERS=\"$(sudoersdir)/sudoers\" -D_PATH_SUDOERS_TMP=\"$(sudoersdir)/sudoers.tmp\" -DSUDOERS_UID=$(sudoers_uid) -DSUDOERS_GID=$(sudoers_gid) -DSUDOERS_MODE=$(sudoers_mode) -DWITH_SELINUX
 
 #### End of system configuration section. ####
 
@@ -104,7 +105,7 @@ SRCS = alloc.c alloca.c check.c closefro
        logging.c memrchr.c mkstemp.c parse.c parse.lex parse.yacc set_perms.c \
        sigaction.c snprintf.c strcasecmp.c strerror.c strlcat.c strlcpy.c \
        sudo.c sudo_noexec.c sudo.tab.c sudo_edit.c testsudoers.c tgetpass.c \
-       utimes.c visudo.c zero_bytes.c $(AUTH_SRCS)
+       utimes.c visudo.c zero_bytes.c $(AUTH_SRCS) selinux.c sesh.c
 
 AUTH_SRCS = auth/afs.c auth/aix_auth.c auth/bsdauth.c auth/dce.c auth/fwtk.c \
 	    auth/kerb4.c auth/kerb5.c auth/pam.c auth/passwd.c auth/rfc1938.c \
@@ -123,11 +124,13 @@ AUDIT_OBJS = audit_help.o 
 PARSEOBJS = sudo.tab.o lex.yy.o alloc.o defaults.o
 
 SUDOBJS = check.o env.o getspwuid.o gettime.o goodpath.o fileops.o find_path.o \
-	  interfaces.o logging.o parse.o set_perms.o sudo.o sudo_edit.o \
+	  interfaces.o logging.o parse.o set_perms.o sudo.o selinux.o sudo_edit.o \
 	  tgetpass.o zero_bytes.o @SUDO_OBJS@ $(AUTH_OBJS) $(PARSEOBJS) $(AUDIT_OBJS)
 
 VISUDOBJS = visudo.o fileops.o gettime.o goodpath.o find_path.o $(PARSEOBJS)
 
+SESH_OBJS = sesh.o
+
 TESTOBJS = interfaces.o testsudoers.o $(PARSEOBJS)
 
 LIBOBJS = @LIBOBJS@ @ALLOCA@
@@ -148,7 +151,7 @@ DISTFILES = $(SRCS) $(HDRS) BUGS CHANGES
 BINFILES= BUGS CHANGES HISTORY LICENSE README TODO TROUBLESHOOTING \
 	  UPGRADE install-sh mkinstalldirs sample.syslog.conf sample.sudoers \
 	  sudo sudo.cat sudo.man sudo.pod sudoers sudoers.cat sudoers.man \
-	  sudoers.pod visudo visudo.cat visudo.man visudo.pod
+	  sudoers.pod visudo visudo.cat visudo.man visudo.pod sesh
 
 BINSPECIAL= INSTALL.binary Makefile.binary libtool
 
@@ -180,6 +183,9 @@ sudo: $(SUDOBJS) $(LIBOBJS)
 visudo: $(VISUDOBJS) $(LIBOBJS)
 	$(CC) -o $@ $(VISUDOBJS) $(LIBOBJS) $(LDFLAGS) $(LIBS) $(NET_LIBS)
 
+sesh: $(SESH_OBJS) 
+	$(CC) -o $@ $(SESH_OBJS) $(LDFLAGS) $(LIBS)
+
 testsudoers: $(TESTOBJS) $(LIBOBJS)
 	$(CC) -o $@ $(TESTOBJS) $(LIBOBJS) $(LDFLAGS) $(LIBS) $(NET_LIBS)
 
@@ -221,6 +227,7 @@ logging.o: logging.c $(SUDODEP)
 set_perms.o: set_perms.c $(SUDODEP)
 tgetpass.o: tgetpass.c $(SUDODEP)
 visudo.o: visudo.c $(SUDODEP) version.h
+sesh.o: sesh.c 
 sudo.o: sudo.c $(SUDODEP) interfaces.h version.h
 interfaces.o: interfaces.c $(SUDODEP) interfaces.h
 testsudoers.o: testsudoers.c $(SUDODEP) parse.h interfaces.h
@@ -319,6 +326,7 @@ install-binaries: $(PROGS)
 	ln $(DESTDIR)$(sudodir)/sudo $(DESTDIR)$(sudodir)/sudoedit
 
 	$(INSTALL) -O $(install_uid) -G $(install_gid) -M 0111 -s visudo $(DESTDIR)$(visudodir)/visudo
+	$(INSTALL) -O $(install_uid) -G $(install_gid) -M 0111 -s sesh $(DESTDIR)$(visudodir)/sesh
 
 install-noexec: sudo_noexec.la
 	$(LIBTOOL) --mode=install $(INSTALL) sudo_noexec.la $(DESTDIR)$(noexecdir)

--------------040904080300000008050104
Content-Type: application/octet-stream;
 name="sudo-1.6.9p4-selinux.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sudo-1.6.9p4-selinux.patch.sig"

iEYEABECAAYFAkegj0MACgkQrlYvE4MpobM4qgCgk94U4/6e19xr6C4NRSIYGsYqW1gAoOY6
wNaUPh6sXKTsb18EWpL1MoCV
--------------040904080300000008050104--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
