Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0DFfURb019563
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 10:41:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0DFeMxr016100
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 15:40:22 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0DFeMYc016097
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 15:40:22 GMT
Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0DFfSAn017133
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 10:41:29 -0500 (EST)
Subject: [patch] Change libselinux to use getpwnam_r
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-mIEwZaDdm4lMsgKqHitf"
Message-Id: <1074008488.13586.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 13 Jan 2004 10:41:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-mIEwZaDdm4lMsgKqHitf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch against libselinux-1.4 changes it to use getpwnam_r
internally instead of getpwnam, so that it doesn't clobber any existing
pwd struct previously obtained by the caller.  This showed up as an
issue for the selinux-enabled gdm.  It doesn't appear to affect login or
sshd, since they make a copy of the pwd struct themselves.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-mIEwZaDdm4lMsgKqHitf
Content-Disposition: attachment; filename=libselinux-getpwnam.patch
Content-Type: text/x-patch; name=libselinux-getpwnam.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/get_context_list.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/get_context_list.c,v
retrieving revision 1.8
diff -u -r1.8 get_context_list.c
--- libselinux/src/get_context_list.c	1 Dec 2003 19:28:32 -0000	1.8
+++ libselinux/src/get_context_list.c	13 Jan 2004 12:36:21 -0000
@@ -206,26 +206,38 @@
     FILE *config_file;    /* The configuration file                    */
     char *fname = 0;      /* The name of the user's configuration file */
     size_t fname_len;     /* The length of fname                       */
-    struct passwd *pwd;   /* The user's passwd structure               */
+    struct passwd pwdbuf, *pwd = &pwdbuf;   
+    char *buf;
     int retval;           /* The return value                          */
+    long buflen;
 
     if (which == USERPRIORITY)
     {
-        /* Get the password structure in order to find the home directory */
-        pwd = getpwnam (user);
-        if (!pwd)
-        {
-            return -1;
+        /* Get the password structure in order to find the home directory.
+	   Use getpwnam_r to avoid clobbering any existing pwd struct obtained
+	   by the caller. */
+	buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (buflen < 0)
+		return -1;
+	buf = malloc(buflen);
+	if (!buf)
+		return -1;
+	retval = getpwnam_r (user, pwd, buf, buflen, &pwd );
+        if (retval < 0 || !pwd) {
+		free(buf);
+		return -1;
         }
         fname_len = strlen (pwd->pw_dir) + 20;
         fname = malloc (fname_len);
-        if (!fname)
+        if (!fname) 
         {
+	    free(buf);
             return -1;
         }
         sprintf (fname, "%s%s", pwd->pw_dir, "/.default_contexts");
         config_file = fopen (fname, "r");
 	free (fname);
+        free(buf);
     }
     else if (which == SYSTEMPRIORITY)
     {

--=-mIEwZaDdm4lMsgKqHitf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
