Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0EED1Rb025962
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 09:13:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0EEBrxr004620
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 14:11:53 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0EEBqYc004617
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 14:11:52 GMT
Subject: Re: [patch] Change libselinux to use getpwnam_r
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20040114083800.GA7603@suse.de>
References: <1074008488.13586.20.camel@moss-spartans.epoch.ncsc.mil>
	 <20040114083800.GA7603@suse.de>
Content-Type: multipart/mixed; boundary="=-qSvbQHTGw5gJJiFAswDj"
Message-Id: <1074089570.13586.157.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 14 Jan 2004 09:12:50 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-qSvbQHTGw5gJJiFAswDj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-01-14 at 03:38, Thorsten Kukuk wrote:
> While _SC_GETPW_R_SIZE_MAX should return the max. size getpwnam_r
> needs for a buffer, in reallity this is often not enough. There is
> no limit, how long a line in /etc/passwd can be.
> So a better way is:
> 
> while (getpwnam_r (user, pwd, buf, buflen, &pwd) != 0
>          && errno == ERANGE)
>     {
>       errno = 0;
>       buflen *= 2;
>       buf = realloc (buf, buflen);
>     }

Thanks.  An updated patch for libselinux-1.4 is attached.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-qSvbQHTGw5gJJiFAswDj
Content-Disposition: attachment; filename=libselinux-getpwnam3.patch
Content-Type: text/x-patch; name=libselinux-getpwnam3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/get_context_list.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/get_context_list.c,v
retrieving revision 1.8
retrieving revision 1.10
diff -u -r1.8 -r1.10
--- libselinux/src/get_context_list.c	1 Dec 2003 19:28:32 -0000	1.8
+++ libselinux/src/get_context_list.c	14 Jan 2004 14:06:52 -0000	1.10
@@ -206,26 +206,50 @@
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
+	while (retval < 0 && errno == ERANGE) {
+		char *newbuf;
+		errno = 0;
+		buflen *= 2;
+		newbuf = realloc (buf, buflen);
+		if (!newbuf) {
+			free(buf);
+			return -1;
+		}
+		buf = newbuf;
+		retval = getpwnam_r (user, pwd, buf, buflen, &pwd );
+	}
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

--=-qSvbQHTGw5gJJiFAswDj--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
