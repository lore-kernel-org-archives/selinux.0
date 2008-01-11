Message-ID: <4787BF20.1050105@redhat.com>
Date: Fri, 11 Jan 2008 14:10:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Stefan Schulze Frielinghaus <stefan@seekline.net>,
        Todd Miller <Tmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Sudo Changes for SELinux
References: <4784EFE8.9050106@redhat.com>	 <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>	 <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>	 <478670A8.5080902@redhat.com> <1199995291.3707.15.camel@vogon>	 <47877F43.5030401@redhat.com>	 <1200065528.29816.66.camel@moss-spartans.epoch.ncsc.mil> <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050500000003040605000309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050500000003040605000309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is the old patch to Sudo for SELinux FC4
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeHvx4ACgkQrlYvE4MpobNrDQCfSGWfpxqCks32in1mYtNtCE3I
tPUAoJmCxmT86d9r3Rb85GMHJlt8/ZI2
=un/s
-----END PGP SIGNATURE-----

--------------050500000003040605000309
Content-Type: text/plain;
 name="sudo-1.6.8p8-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sudo-1.6.8p8-selinux.patch"

--- /dev/null	2005-03-07 11:59:46.679193192 +0100
+++ sudo-1.6.8p8/sesh.c	2005-04-12 12:53:01.000000000 +0200
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
--- sudo-1.6.8p8/sudo.c.selinux	2005-03-25 02:56:41.000000000 +0100
+++ sudo-1.6.8p8/sudo.c	2005-04-12 14:04:01.765372148 +0200
@@ -92,6 +92,17 @@
 #include "interfaces.h"
 #include "version.h"
 
+#ifdef WITH_SELINUX
+#include <selinux/flask.h>             /* for SECCLASS_CHR_FILE */
+#include <selinux/selinux.h>           /* for is_selinux_enabled() */
+#include <selinux/context.h>           /* for context-mangling functions */
+#include <selinux/get_default_type.h>
+char *role_s = NULL;                  /* role spec'd by user in argv[] */
+char *type_s = NULL;                  /* type spec'd by user in argv[] */
+security_context_t new_tty_context=NULL; /* security context to change to while running command*/
+security_context_t tty_context=NULL;  /* current security context of tty */
+#endif
+
 #ifndef lint
 static const char rcsid[] = "$Sudo: sudo.c,v 1.370 2004/08/24 18:01:13 millert Exp $";
 #endif /* lint */
@@ -141,7 +152,151 @@
 sigaction_t saved_sa_int, saved_sa_quit, saved_sa_tstp, saved_sa_chld;
 void (*set_perms) __P((int));
 
+#ifdef WITH_SELINUX
+security_context_t setup_tty_context(int fd, char *ttyn, security_context_t new_context) {
+  security_context_t tty_context=NULL;  /* current sid of tty */
+
+  tty_context = NULL;
+  if (fgetfilecon(fd,&tty_context) <0 ) 
+    fprintf(stderr, "Warning!  Could not get current context for %s, not relabeling.\n", ttyn);
+  
+#ifdef CANTSPELLGDB
+  if (tty_context)
+    printf("Your tty %s was labeled with context %s\n", ttyn, tty_context);
+#endif
+  
+  new_tty_context = NULL;
+  if (tty_context && security_compute_relabel(new_context,tty_context,SECCLASS_CHR_FILE,&new_tty_context) < 0)
+    fprintf(stderr, "Warning!  Could not get new context for %s, not relabeling.\n", ttyn);
+  
+#ifdef CANTSPELLGDB
+  if (new_tty_context)
+    printf("Relabeling tty %s to context %s\n", ttyn, new_tty_context);
+#endif
+  
+  if (new_tty_context) {
+    if( fsetfilecon(fd,new_tty_context)!=0 ) {
+      fprintf(stderr,"sudo: error: setfilecon on %s to %s",ttyn,new_tty_context);
+    }
+  }
+  return tty_context;
+}
+security_context_t get_exec_context(char *role_s, char *type_s) {
+
+  security_context_t old_context=NULL;	/* our original securiy ID ("old_context") */
+  security_context_t new_context=NULL;  /* our target security ID ("sid") */
+
+  /*
+   *	
+   * Step 1:  Handle command-line arguments.
+   *
+   */
+  
+  security_context_t context_s;      /* our security context as a string */
+  int context_length;
+  context_t context;                 /* manipulatable form of context_s */
+  
+  
+  /*
+   * Get the SID and context of the caller, and extract
+   * the username from the context.  Don't rely on the Linux
+   * uid information - it isn't trustworthy.
+   */
+  
+  /* Put the caller's SID into `old_context'. */
+  if( 0!=(getprevcon(&old_context)) ) {
+    fprintf(stderr,"failed to get old_context.\n");
+    exit(-1);
+  }
+  
+#ifdef CANTSPELLGDB
+  printf( "Your old context was %s\n", old_context );
+#endif
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
+  /* Set the SELinux user identity to root */
+  context_user_set(context, "root");
+  
+  /* If the user specified a new role on the command line (if `role_s'   *
+   * is set), then replace the old role in `context' with this new role. */
+  if( role_s ) {
+    if( !type_s ) {
+      if( get_default_type(role_s,&type_s) )
+	{
+	  fprintf(stderr,"Couldn't get default type.\n");
+	  exit(-1);
+	}
+#ifdef CANTSPELLGDB
+      printf( "Your type will be %s.\n", type_s );
+#endif  
+    }
+    
+    if( context_role_set(context,role_s)) {
+      fprintf(stderr,"failed to set new role %s\n",role_s);
+      exit(-1);
+    }
+#ifdef CANTSPELLGDB
+    printf("Your new role is %s\n",context_role_get(context));
+#endif
+    
+    /* If the user specified a new type on the command line (if `type_s'   *
+     * is set), then replace the old type in `context' with this new type. */
+    if( type_s ) {
+      if( context_type_set(context,type_s)) {
+	fprintf(stderr,"failed to set new type %s\n",type_s);
+	exit(-1);
+      }
+#ifdef CANTSPELLGDB
+      printf("Your new type is %s\n",context_type_get(context));
+#endif
+    } /* if user specified new type */
+    
+    /* The second step in creating the new SID is to convert our modified *
+     * `context' structure back to a context string and then to a SID.    */
+    
+    /* Make `context_s' point to a string version of the new `context'.  */
+    if( !(new_context=strdup(context_str(context)))) {
+      fprintf(stderr,"failed to convert new context to string\n" );
+      exit(-1);
+    }
+    
+  } /* if user specified new role */
+  else {
+    if (get_default_context(context_user_get(context),
+			    NULL,
+			    &new_context)) {
+      fprintf(stderr,"failed to get default context\n" );
+      exit(-1);
+    }
+  }
+  context_free(context);
+  freecon(old_context);
+
+  if (security_check_context(new_context) < 0) {
+    fprintf(stderr, "%s is not a valid context\n", new_context);
+    exit(-1);
+  }
+
+  return new_context;
+}
 
+#endif
 int
 main(argc, argv, envp)
     int argc;
@@ -149,10 +304,10 @@
     char **envp;
 {
     int validated;
-    int fd;
     int cmnd_status;
     int sudo_mode;
     int pwflag;
+    int fd;
     char **new_environ;
     sigaction_t sa;
     extern int printmatches;
@@ -203,9 +358,6 @@
     /* Setup defaults data structures. */
     init_defaults();
 
-    /* Load the list of local ip addresses and netmasks.  */
-    load_interfaces();
-
     pwflag = 0;
     if (ISSET(sudo_mode, MODE_SHELL))
 	user_cmnd = "shell";
@@ -219,6 +371,8 @@
 		    putchar('\n');
 		    dump_auth_methods();
 		    dump_defaults();
+		    /* Load the list of local ip addresses and netmasks.  */
+		    load_interfaces();
 		    dump_interfaces();
 		}
 		exit(0);
@@ -445,8 +599,44 @@
 #ifndef PROFILING
 	if (ISSET(sudo_mode, MODE_BACKGROUND) && fork() > 0)
 	    exit(0);
-	else
-	    EXECV(safe_cmnd, NewArgv);	/* run the command */
+#ifdef WITH_SELINUX
+	if( is_selinux_enabled() >0) {
+	  int fd;
+	  char *ttyn   = NULL;	                /* tty path */
+	  security_context_t new_context=NULL;  /* our target security ID ("sid") */
+	  security_context_t chk_tty_context= NULL;
+
+	  new_context=get_exec_context(role_s,type_s);
+#ifdef CANTSPELLGDB
+	  printf("Your new context is %s\n",new_context);
+#endif
+
+	  if (setexeccon(new_context) < 0) {
+	    fprintf(stderr, "Could not set exec context to %s.\n", new_context);
+	    exit(-1);
+	  }
+	  freecon(new_context);
+	  {
+	    /* 
+	       SELinux will only not transition properly with the following
+	       code.  Basically if the user chooses to use a different security
+	       context.  We need to start the selinux shell, before executing 
+	       the command.  This way the process transition will happen 
+	       correctly. For example if they user wants to run rpm from 
+	       sysadm_r.  Sudo will exec the /usr/sbin/sesh followed by the 
+	       specified command.*/
+	    char **dst, **src = NewArgv+1;
+	    NewArgv = (char **) emalloc2((++NewArgc + 1), sizeof(char *));
+	    NewArgv[0] = estrdup("/usr/sbin/sesh");
+	    NewArgv[1] = safe_cmnd;
+	    safe_cmnd = estrdup("/usr/sbin/sesh");
+	    /* copy the args from Argv */
+	    for (dst = NewArgv + 2; (*dst = *src) != NULL; ++src, ++dst)
+	      ;
+	  }
+	}
+#endif
+	EXECV(safe_cmnd, NewArgv);	/* run the command */
 #else
 	exit(0);
 #endif /* PROFILING */
@@ -734,6 +924,30 @@
 		NewArgv++;
 		break;
 #endif
+#ifdef WITH_SELINUX
+	    case 'r':
+		/* Must have an associated SELinux role. */
+		if (NewArgv[1] == NULL)
+		    usage(1);
+
+		role_s = NewArgv[1];
+
+		/* Shift Argv over and adjust Argc. */
+		NewArgc--;
+		NewArgv++;
+		break;
+	    case 't':
+		/* Must have an associated SELinux type. */
+		if (NewArgv[1] == NULL)
+		    usage(1);
+
+		type_s = NewArgv[1];
+
+		/* Shift Argv over and adjust Argc. */
+		NewArgc--;
+		NewArgv++;
+		break;
+#endif
 #ifdef HAVE_LOGIN_CAP_H
 	    case 'c':
 		/* Must have an associated login class. */
@@ -1119,6 +1333,9 @@
 #ifdef HAVE_BSD_AUTH_H
 	" [-a auth_type]",
 #endif
+#ifdef WITH_SELINUX
+	" [-r role] [-t type] ",
+#endif
 #ifdef HAVE_LOGIN_CAP_H
 	" [-c class|-]",
 #endif
--- sudo-1.6.8p8/configure.selinux	2004-11-26 21:04:30.000000000 +0100
+++ sudo-1.6.8p8/configure	2005-04-12 12:53:01.000000000 +0200
@@ -1608,7 +1608,7 @@
 insults=off
 root_sudo=on
 INSTALL_NOEXEC=
-PROGS="sudo visudo"
+PROGS="sudo visudo sesh"
 test -n "$MANTYPE" || MANTYPE="man"
 test -n "$mansrcdir" || mansrcdir="."
 test -n "$SUDOERS_MODE" || SUDOERS_MODE=0440
--- sudo-1.6.8p8/configure.in.selinux	2004-11-25 18:31:20.000000000 +0100
+++ sudo-1.6.8p8/configure.in	2005-04-12 12:53:01.000000000 +0200
@@ -98,7 +98,7 @@
 dnl Initial values for Makefile variables listed above
 dnl May be overridden by environment variables..
 dnl
-PROGS="sudo visudo"
+PROGS="sudo visudo sesh"
 test -n "$MANTYPE" || MANTYPE="man"
 test -n "$mansrcdir" || mansrcdir="."
 test -n "$SUDOERS_MODE" || SUDOERS_MODE=0440
--- sudo-1.6.8p8/sudo.man.in.selinux	2005-03-11 20:11:31.000000000 +0100
+++ sudo-1.6.8p8/sudo.man.in	2005-04-12 12:53:01.000000000 +0200
@@ -157,6 +157,7 @@
 \&\fBsudo\fR \fB\-K\fR | \fB\-L\fR | \fB\-V\fR | \fB\-h\fR | \fB\-k\fR | \fB\-l\fR | \fB\-v\fR
 .PP
 \&\fBsudo\fR [\fB\-HPSb\fR] [\fB\-a\fR\ \fIauth_type\fR] [\fB\-c\fR\ \fIclass\fR|\fI\-\fR]
+[\fB\-r\fR \fIrole\fR ] [\fB\-t\fR \fItype\fR ]
 [\fB\-p\fR\ \fIprompt\fR] [\fB\-u\fR\ \fIusername\fR|\fI#uid\fR]
 {\fB\-e\fR\ file\ [...]\ |\ \fB\-i\fR\ |\ \fB\-s\fR\ |\ \fIcommand\fR}
 .PP
@@ -235,6 +236,16 @@
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
 .IP "\-S" 4
 .IX Item "-S"
 The \fB\-S\fR (\fIstdin\fR) option causes \fBsudo\fR to read the password from
--- sudo-1.6.8p8/Makefile.in.selinux	2005-03-11 20:08:52.000000000 +0100
+++ sudo-1.6.8p8/Makefile.in	2005-04-12 12:53:01.000000000 +0200
@@ -43,7 +43,8 @@
 # Libraries
 LIBS = @LIBS@
 NET_LIBS = @NET_LIBS@
-SUDO_LIBS = @SUDO_LIBS@ @AFS_LIBS@ $(LIBS) $(NET_LIBS)
+SELINUX_LIBS = -lselinux 
+SUDO_LIBS = @SUDO_LIBS@ @AFS_LIBS@ $(LIBS) $(NET_LIBS) $(SELINUX_LIBS)
 
 # C preprocessor flags
 CPPFLAGS = -I. -I$(srcdir) @CPPFLAGS@
@@ -90,7 +91,7 @@
 sudoers_mode = @SUDOERS_MODE@
 
 # Pass in paths and uid/gid + OS dependent defined
-DEFS = @OSDEFS@ -D_PATH_SUDOERS=\"$(sudoersdir)/sudoers\" -D_PATH_SUDOERS_TMP=\"$(sudoersdir)/sudoers.tmp\" -DSUDOERS_UID=$(sudoers_uid) -DSUDOERS_GID=$(sudoers_gid) -DSUDOERS_MODE=$(sudoers_mode)
+DEFS = @OSDEFS@ -D_PATH_SUDOERS=\"$(sudoersdir)/sudoers\" -D_PATH_SUDOERS_TMP=\"$(sudoersdir)/sudoers.tmp\" -DSUDOERS_UID=$(sudoers_uid) -DSUDOERS_GID=$(sudoers_gid) -DSUDOERS_MODE=$(sudoers_mode) -DWITH_SELINUX
 
 #### End of system configuration section. ####
 
@@ -104,7 +105,7 @@
        parse.c parse.lex parse.yacc set_perms.c sigaction.c snprintf.c \
        strcasecmp.c strerror.c strlcat.c strlcpy.c sudo.c sudo_noexec.c \
        sudo.tab.c sudo_edit.c testsudoers.c tgetpass.c utimes.c visudo.c \
-       zero_bytes.c $(AUTH_SRCS)
+       zero_bytes.c $(AUTH_SRCS) sesh.c
 
 AUTH_SRCS = auth/afs.c auth/aix_auth.c auth/bsdauth.c auth/dce.c auth/fwtk.c \
 	    auth/kerb4.c auth/kerb5.c auth/pam.c auth/passwd.c auth/rfc1938.c \
@@ -126,6 +127,8 @@
 
 VISUDOBJS = visudo.o fileops.o gettime.o goodpath.o find_path.o $(PARSEOBJS)
 
+SESH_OBJS = sesh.o
+
 TESTOBJS = interfaces.o testsudoers.o $(PARSEOBJS)
 
 LIBOBJS = @LIBOBJS@ @ALLOCA@
@@ -145,7 +148,7 @@
 BINFILES= BUGS CHANGES HISTORY LICENSE README TODO TROUBLESHOOTING \
 	  UPGRADE install-sh mkinstalldirs sample.syslog.conf sample.sudoers \
 	  sudo sudo.cat sudo.man sudo.pod sudoers sudoers.cat sudoers.man \
-	  sudoers.pod visudo visudo.cat visudo.man visudo.pod
+	  sudoers.pod visudo visudo.cat visudo.man visudo.pod sesh
 
 BINSPECIAL= INSTALL.binary Makefile.binary libtool
 
@@ -177,6 +180,9 @@
 visudo: $(VISUDOBJS) $(LIBOBJS)
 	$(CC) -o $@ $(VISUDOBJS) $(LIBOBJS) $(LDFLAGS) $(LIBS) $(NET_LIBS)
 
+sesh: $(SESH_OBJS) 
+	$(CC) -o $@ $(SESH_OBJS) $(LDFLAGS) $(LIBS)
+
 testsudoers: $(TESTOBJS) $(LIBOBJS)
 	$(CC) -o $@ $(TESTOBJS) $(LIBOBJS) $(LDFLAGS) $(LIBS) $(NET_LIBS)
 
@@ -215,6 +221,7 @@
 set_perms.o: set_perms.c $(SUDODEP)
 tgetpass.o: tgetpass.c $(SUDODEP)
 visudo.o: visudo.c $(SUDODEP) version.h
+sesh.o: sesh.c 
 sudo.o: sudo.c $(SUDODEP) interfaces.h version.h
 interfaces.o: interfaces.c $(SUDODEP) interfaces.h
 testsudoers.o: testsudoers.c $(SUDODEP) parse.h interfaces.h
@@ -306,6 +313,7 @@
 	ln $(DESTDIR)$(sudodir)/sudo $(DESTDIR)$(sudodir)/sudoedit
 
 	$(INSTALL) -O $(install_uid) -G $(install_gid) -M 0111 -s visudo $(DESTDIR)$(visudodir)/visudo
+	$(INSTALL) -O $(install_uid) -G $(install_gid) -M 0111 -s sesh $(DESTDIR)$(visudodir)/sesh
 
 install-noexec: sudo_noexec.la
 	$(LIBTOOL) --mode=install $(INSTALL) sudo_noexec.la $(DESTDIR)$(noexecdir)

--------------050500000003040605000309
Content-Type: application/octet-stream;
 name="sudo-1.6.8p8-selinux.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sudo-1.6.8p8-selinux.patch.sig"

iEYEABECAAYFAkeHvx4ACgkQrlYvE4MpobM5/gCgj7Ytr2UoWg+1iF58/lli0Acx10cAnA7m
BlGHt8lSwLZJmLJUXg8HwGR3
--------------050500000003040605000309--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
