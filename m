Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0AMc9Xf018105
	for <selinux@tycho.nsa.gov>; Tue, 10 Jan 2006 17:38:10 -0500 (EST)
Received: from web51501.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k0AMb4Il014215
	for <selinux@tycho.nsa.gov>; Tue, 10 Jan 2006 22:37:04 GMT
Message-ID: <20060110223808.66858.qmail@web51501.mail.yahoo.com>
Date: Tue, 10 Jan 2006 14:38:08 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: [PATCH] newrole cleanup
To: SE-Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1615797696-1136932688=:65249"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1615797696-1136932688=:65249
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

I've been reviewing newrole in preparation for another patch to add auditing to
it. The patch is fairly self-explanatory. Some highlights:

- little const cleanup
- pass tty to pam
- add a function to verify the shell is in fact known to /etc/shells
- make sure no signals are blocked
- If in enforcing mode and error: getting tty context, computing new context, or
setting new context  then exit with -1.
- Loop the wait call to handle EINTR
- open the tty read only or write only depending on stdin, stdout, stderr.
- pass return from pam_* functions to pam_end

The patch is attached.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1615797696-1136932688=:65249
Content-Type: text/x-patch; name="policycoreutils-1.29.5-newrole-cleanup.patch"
Content-Description: 4054889167-policycoreutils-1.29.5-newrole-cleanup.patch
Content-Disposition: inline; filename="policycoreutils-1.29.5-newrole-cleanup.patch"

diff -ur policycoreutils-1.29.5.orig/newrole/newrole.c policycoreutils-1.29.5/newrole/newrole.c
--- policycoreutils-1.29.5.orig/newrole/newrole.c	2006-01-10 16:21:20.000000000 -0500
+++ policycoreutils-1.29.5/newrole/newrole.c	2006-01-10 17:31:05.000000000 -0500
@@ -93,7 +93,8 @@
 static char *
 build_new_range(char *newlevel, const char *range)
 {
-  char *newrangep = NULL, *tmpptr;
+  char *newrangep = NULL;
+  const char *tmpptr;
   size_t len;
 
   /* a missing or empty string */
@@ -147,7 +148,7 @@
 
 #define SERVICE_NAME "newrole"    /* the name of this program for PAM */
 
-int authenticate_via_pam( const struct passwd * );
+int authenticate_via_pam( const struct passwd *, const char * );
 
 /* authenticate_via_pam()
  *
@@ -165,10 +166,12 @@
  *
  */
 
-int authenticate_via_pam( const struct passwd *pw ) {
+int authenticate_via_pam( const struct passwd *pw, const char *ttyn ) {
 
   int result = 0;    /* our result, set to 0 (not authenticated) by default */
+  int rc;	     /* pam return code */
   pam_handle_t *pam_handle;      /* opaque handle used by all PAM functions */
+  const char *tty_name;
 
   /* This is a jump table of functions for PAM to use when it wants to *
    * communicate with the user.  We'll be using misc_conv(), which is  *
@@ -180,26 +183,41 @@
 
   /* Make `p_pam_handle' a valid PAM handle so we can use it when *
    * calling PAM functions.                                       */
-  if( PAM_SUCCESS != pam_start( SERVICE_NAME,
-				pw->pw_name,
-				&pam_conversation,
-				&pam_handle ) ) {
+  rc = pam_start( SERVICE_NAME,
+		pw->pw_name,
+		&pam_conversation,
+		&pam_handle );
+  if( rc != PAM_SUCCESS ) {
     fprintf( stderr, _("failed to initialize PAM\n") );
     exit( -1 );
   }
 
+  if( strncmp(ttyn, "/dev/", 5) == 0 )
+    tty_name = ttyn+5;
+  else
+    tty_name = ttyn;
+
+  rc = pam_set_item( pam_handle, PAM_TTY, tty_name );
+  if( rc != PAM_SUCCESS ) {
+    fprintf( stderr, _("failed to set PAM_TTY\n") );
+    goto out;
+  }
+
   /* Ask PAM to authenticate the user running this program */
-  if( PAM_SUCCESS == pam_authenticate(pam_handle,0) ) {
-    result = 1;  /* user authenticated OK! */
+  rc = pam_authenticate(pam_handle,0);
+  if( rc != PAM_SUCCESS ) {
+    goto out;
   }
 
   /* Ask PAM to verify acct_mgmt */
-  if( PAM_SUCCESS != pam_acct_mgmt(pam_handle,0) ) {
-    result = 0;  
-  }
+  rc = pam_acct_mgmt(pam_handle,0);
+  if( rc == PAM_SUCCESS ) {
+    result = 1;  /* user authenticated OK! */
+  } 
 
   /* We're done with PAM.  Free `pam_handle'. */
-  pam_end( pam_handle, PAM_SUCCESS );
+out:
+  pam_end( pam_handle, rc );
  
   return( result );
 
@@ -277,6 +295,33 @@
 
 #endif /* if/else USE_PAM */
 
+/*
+ * This function checks to see if the shell is known in /etc/shells.
+ * If so, it returns 1. On error or illegal shell, it returns 0.
+ */
+static int verify_shell(const char *shell_name)
+{
+  int found = 0;
+  const char *buf;
+
+  if( !shell_name )
+    return found;
+
+  while( (buf = getusershell()) != NULL ) {
+    /* ignore comments */
+    if( *buf == '#' )
+      continue;
+
+    /* check the shell skipping newline char */
+    if( ! strcmp (shell_name, buf) ) {
+      found = 1;
+      break;
+    }
+  }
+  endusershell();
+  return found;
+}
+
 /************************************************************************
  *
  * All code used for both PAM and shadow passwd goes in this section.
@@ -285,13 +330,13 @@
 
 int main( int argc, char *argv[] ) {
 
-  security_context_t new_context=NULL;          /* our target security context */
+  security_context_t new_context=NULL;	   /* our target security context */
   security_context_t old_context=NULL;	   /* our original securiy context */
   security_context_t tty_context=NULL;	   /* The current context of tty file */
-  security_context_t new_tty_context=NULL;	   /* The new context of tty file */
+  security_context_t new_tty_context=NULL; /* The new context of tty file */
   security_context_t chk_tty_context= NULL;
 
-  context_t context;		 	   /* manipulatable form of new_context */
+  context_t context;		 	 /* manipulatable form of new_context */
 
 
   const char *se_username;  /* SELinux user identity */
@@ -300,7 +345,7 @@
 
   int clflag;                        /* holds codes for command line flags */
   int flag_index;                    /* flag index in argv[] */
-  struct option long_options[] = {   /* long option flags for getopt() */
+  const struct option long_options[] = {   /* long option flags for getopt() */
     { "role", 1, 0, 'r' },
     { "type", 1, 0, 't' },
     { "level", 1, 0, 'l' },
@@ -311,7 +356,13 @@
   char *level_s = NULL;              /* level spec'd by user in argv[] */
   char *ttyn   = NULL;		     /* tty path */
   pid_t childPid=0;			     
-  int fd=0;
+  int fd;
+  int enforcing;
+  sigset_t empty;
+
+  /* Empty the signal mask in case someone is blocking a signal */
+  sigemptyset( &empty );
+  (void) sigprocmask( SIG_SETMASK, &empty, NULL );
 
   /* Terminate on SIGHUP. */
   signal(SIGHUP, SIG_DFL);
@@ -334,6 +385,11 @@
 	     _("Sorry, newrole may be used only on a SELinux kernel.\n") );
     exit(-1);
   }
+  enforcing = security_getenforce();
+  if (enforcing < 0) {
+    fprintf(stderr, _("Could not determine enforcing mode.\n"));
+    exit(-1);
+  }
 
   while (1) {
     clflag=getopt_long(argc,argv,"r:t:l:",long_options,&flag_index);
@@ -452,11 +508,23 @@
   pw->pw_dir = xstrdup(pw->pw_dir);
   pw->pw_shell = xstrdup(pw->pw_shell);
 
+  if (verify_shell(pw->pw_shell) == 0) {
+	fprintf(stderr, _("Error!  Shell is not valid.\n"));
+	exit(-1);
+  }
+
+  /* Get the tty name. Pam will need it. */
+  ttyn=ttyname(0);
+  if (!ttyn || *ttyn == '\0') {
+	fprintf(stderr, _("Error!  Could not retrieve tty information.\n"));
+	exit(-1);
+  }
+
   printf(_("Authenticating %s.\n"),pw->pw_name);
 
   /* Authenticate the user running this program. */
 #ifdef USE_PAM
-  if( !authenticate_via_pam(pw) ) 
+  if( !authenticate_via_pam(pw, ttyn) ) 
 #else /* !USE_PAM */
   if( !authenticate_via_shadow_passwd(pw) ) 
 #endif /* if/else USE_PAM */
@@ -548,31 +616,30 @@
    *
    */
 
-  /* Fetch TTY information */
-  ttyn=ttyname(0);
-  if (!ttyn || *ttyn == '\0') {
-	fprintf(stderr, _("Warning!  Could not retrieve tty information.\n"));
-	exit(-1);
-  }
-
+  /* Re-open TTY descriptor */
   fd = open(ttyn, O_RDWR);
   if (fd < 0) {
-	fprintf(stderr, _("Warning!  Could not open %s.\n"), ttyn);
+	fprintf(stderr, _("Error!  Could not open %s.\n"), ttyn);
 	exit(-1);
   }
 
   tty_context = NULL;
-  if (fgetfilecon(fd, &tty_context) < 0)
-	fprintf(stderr, _("Warning!  Could not get current context for %s, not relabeling.\n"), ttyn);
-    
+  if (fgetfilecon(fd, &tty_context) < 0) {
+	fprintf(stderr, _("%s!  Could not get current context for %s, not relabeling tty.\n"), enforcing ? "Error" : "Warning", ttyn);
+        if (enforcing)
+	  exit(-1);
+  }
 #ifdef CANTSPELLGDB
   if (tty_context)
     printf("Your tty %s was labeled with context %s\n", ttyn, tty_context);
 #endif
 
   new_tty_context = NULL;
-  if (tty_context && (security_compute_relabel(new_context,tty_context,SECCLASS_CHR_FILE,&new_tty_context) < 0))
-       fprintf(stderr, _("Warning!  Could not get new context for %s, not relabeling.\n"), ttyn);
+  if (tty_context && (security_compute_relabel(new_context,tty_context,SECCLASS_CHR_FILE,&new_tty_context) < 0)) {
+       fprintf(stderr, _("Error!  Could not get new context for %s, not relabeling tty.\n"), ttyn);
+       if (enforcing)
+         exit(-1);
+  }
 
 #ifdef CANTSPELLGDB
   if (new_tty_context)
@@ -581,9 +648,11 @@
 
   if (new_tty_context) {
     if (fsetfilecon(fd,new_tty_context) < 0) {
-      fprintf(stderr, _("Warning!  Could not set new context for %s\n"), ttyn);
+      fprintf(stderr, _("%s!  Could not set new context for %s\n"), enforcing ? "Error" : "Warning", ttyn);
       freecon(new_tty_context);
       new_tty_context = NULL;
+      if (enforcing)
+        exit(-1);
     }
   }
 
@@ -592,12 +661,18 @@
   if( childPid<0 ) {
     int errsv=errno;
     fprintf(stderr,_("newrole: failure forking: %s"),strerror(errsv));
+    if (fsetfilecon(fd,tty_context) < 0)
+      fprintf(stderr, _("Warning!  Could not restore context for %s\n"), ttyn);
+    freecon(tty_context);
     exit(-1);
   } else if (childPid) {
     /* PARENT */
-    wait(NULL);
+    int rc;
+    do {
+      rc = wait(NULL);
+    } while (rc < 0 && errno == EINTR);
 
-    if (!new_tty_context)
+    if (!new_tty_context||!tty_context)
       exit(0);
 
     /* Verify that the tty still has the context set by newrole. */
@@ -634,15 +709,15 @@
       fprintf(stderr,_("Could not close descriptors.\n"));
       exit(-1);
     }
-  fd = open(ttyn,O_RDWR);
+  fd = open(ttyn,O_RDONLY);
   if (fd != 0) {
       exit(-1);
   }
-  fd = open(ttyn,O_RDWR);  
+  fd = open(ttyn,O_WRONLY);  
   if (fd != 1) {
       exit(-1);
   }
-  fd = open(ttyn,O_RDWR);  
+  fd = open(ttyn,O_WRONLY);  
   if (fd != 2) {
       exit(-1);
   }

--0-1615797696-1136932688=:65249--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
