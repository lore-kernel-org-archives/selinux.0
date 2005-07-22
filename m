Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MFg5gA006582
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:42:05 -0400 (EDT)
Received: from e6.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MFaVKk009250
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:36:31 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j6MFbJ5f007830
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:37:19 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j6MFbJVY245902
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:37:19 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j6MFbJPi008016
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:37:19 -0400
Received: from localhost (sig-9-48-47-45.mts.ibm.com [9.48.47.45])
	by d01av01.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j6MFbHTP007966
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:37:19 -0400
Date: Fri, 22 Jul 2005 11:37:15 -0400 (Eastern Daylight Time)
From: Janak Desai <janak@us.ibm.com>
To: selinux@tycho.nsa.gov
Subject: [RFC][PATCH] newrole - support for polyinstantiated directories
Message-ID: <Pine.WNT.4.63.0507221135090.1000@IBM-AIP3070F3AM>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Patch Summary:
This patch adds a pam session management hook in the 
newrole command.

Patch Justification:
This patch is needed to provide polyinstantiated directories.
Polyinstantiated directories are needed to achieve greater 
information separation for public use directories such 
as /tmp and /var/tmp, and provide users with writeable home 
directories as they transition roles, types or mls level.
Currently, the newrole command uses pam for authentication only.
Addition of the pam session management hook allows newrole to
unmount existing polyinstantiated directories and setup 
appropriate polyinstantiation based on the new security
context that is being entered through newrole.


Overall Approach:
The pam session management hook is placed in the child process
that newrole forks. The hooks is placed after the call to 
setexeccon(), which sets setcurity context of the next exec'ed
process.

Testing:
The patch has been unit tested on uni-processor i386 architecture
based Fedora Core 3 system running 2.6.12 kernel.

Signed-off-by: Janak Desai

-------------------------------------------------------------------
diff -Naurp newrole/newrole.c newrole-namespace/newrole.c
--- newrole/newrole.c	2005-07-22 11:48:04.000000000 +0000
+++ newrole-namespace/newrole.c	2005-07-22 14:33:08.000000000 +0000
@@ -151,7 +151,7 @@ int authenticate_via_pam( const struct p
 
 /* authenticate_via_pam()
  *
- * in:     pw - struct containing data from our user's line in 
+ * in:     pw - struct containing data from our user's line in
  *                         the passwd file.
  * out:    nothing
  * return: value   condition
@@ -200,6 +200,59 @@ int authenticate_via_pam( const struct p
 
 } /* authenticate_via_pam() */
 
+
+int namespace_via_pam( const struct passwd * );
+
+/* namespace_via_pam()
+ *
+ * in:     pw - struct containing data from our user's line in
+ *                         the passwd file.
+ * out:    nothing
+ * return: value   condition
+ *         -----   ---------
+ *           1     PAM thinks that the namespace setup was successful
+ *           0     otherwise
+ *
+ * This function uses PAM to setup namespace if polyinstantiated
+ * directories are configured on the system.
+ *
+ */
+
+int namespace_via_pam( const struct passwd *pw ) {
+
+  int result = 0;    /* our result, set to 0 (namespace not set) by default */
+  pam_handle_t *pam_handle;      /* opaque handle used by all PAM functions */
+
+  /* This is a jump table of functions for PAM to use when it wants to *
+   * communicate with the user.  We'll be using misc_conv(), which is  *
+   * provided for us via pam_misc.h.                                   */
+  struct pam_conv pam_conversation = {
+    misc_conv,
+    NULL
+  };
+
+  /* Make `p_pam_handle' a valid PAM handle so we can use it when *
+   * calling PAM functions.                                       */
+  if( PAM_SUCCESS != pam_start( SERVICE_NAME,
+				pw->pw_name,
+				&pam_conversation,
+				&pam_handle ) ) {
+    fprintf( stderr, _("failed to initialize PAM\n") );
+    exit( -1 );
+  }
+
+  /* Ask PAM to setup session for the user running this program */
+  if( PAM_SUCCESS == pam_open_session(pam_handle,0) ) {
+    result = 1;  /* Namespace setup OK! */
+  }
+
+  /* We're done with PAM.  Free `pam_handle'. */
+  pam_end( pam_handle, PAM_SUCCESS );
+
+  return( result );
+
+} /* namespace_via_pam() */
+
 #else /* else !USE_PAM */
 
 
@@ -663,6 +716,10 @@ int main( int argc, char *argv[] ) {
        fprintf(stderr, _("Could not set exec context to %s.\n"), new_context);
        exit(-1);
   }
+
+#ifdef USE_PAM
+  if( namespace_via_pam(pw) )
+#endif /* USE_PAM */
   execv(argv[optind-1],argv+optind-1);
 
   /* If we reach here, then we failed to exec the new shell. */
diff -Naurp newrole/newrole.pamd newrole-namespace/newrole.pamd
--- newrole/newrole.pamd	2005-07-22 11:48:04.000000000 +0000
+++ newrole-namespace/newrole.pamd	2005-07-22 14:14:00.000000000 +0000
@@ -3,4 +3,5 @@ auth       required	/lib/security/$ISA/p
 account    required	/lib/security/$ISA/pam_stack.so service=system-auth
 password   required	/lib/security/$ISA/pam_stack.so service=system-auth
 session    required	/lib/security/$ISA/pam_stack.so service=system-auth
+session    required	/lib/security/$ISA/pam_namespace.so unmnt_first
 session    optional	/lib/security/$ISA/pam_xauth.so


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
