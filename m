Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4QBvgRb025047
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 07:57:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4QBtAar021456
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 11:55:10 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4QBt9Qu021453
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 11:55:10 GMT
Subject: Re: [PATCH][RFC] Allow administrator control over
	per-user	default_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, Valdis.Kletnieks@vt.edu,
   selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <40B38D50.1080901@redhat.com>
References: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil>
	 <200405212213.i4LMDLZM005446@turing-police.cc.vt.edu>
	 <200405240612.15645.russell@coker.com.au>
	 <1085402633.26446.45.camel@moss-spartans.epoch.ncsc.mil>
	 <1085496496.30578.92.camel@moss-spartans.epoch.ncsc.mil>
	 <40B38D50.1080901@redhat.com>
Content-Type: multipart/mixed; boundary="=-1CPAL8iwWZnOU9D3AHFE"
Message-Id: <1085572620.31854.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 May 2004 07:57:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1CPAL8iwWZnOU9D3AHFE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-05-25 at 14:15, Daniel J Walsh wrote:
> I see very little reason to continue supporting ~/.default_contexts.  I 
> think that the new design allows for specific users to have different 
> context but that is controlled by the admin.  Users most likely will not 
> understand the contents of the .default_contexts files and those that do 
> can probably get an admin to change the system wide one.  The amount of 
> headaches of maintaining .default_contexts under a correct security 
> context and having the user screw up his file is great.  I vote to just 
> get rid of it.

That would simplify matters.  Below is an updated patch that drops the
old ~/.default_contexts logic entirely, and only checks for
/etc/security/default_contexts.user/$USER for the per-user
default_contexts configuration.  As with the prior patch, the location
is likely to change due to the reorganization of the SELinux
configuration file layout proposed by Dan.  From Dan's posting, it looks
like it will become /etc/selinux/(strict|targeted)/contexts/users/$USER.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-1CPAL8iwWZnOU9D3AHFE
Content-Disposition: attachment; filename=libselinux-usercon.patch3
Content-Type: text/x-patch; name=libselinux-usercon.patch3; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/get_context_list.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/get_context_list.h,v
retrieving revision 1.3
diff -u -r1.3 get_context_list.h
--- libselinux/include/selinux/get_context_list.h	6 Oct 2003 19:55:18 -0000	1.3
+++ libselinux/include/selinux/get_context_list.h	26 May 2004 11:43:47 -0000
@@ -4,6 +4,7 @@
 #include <selinux/selinux.h>
 
 #define _DEFCONTEXT_PATH "/etc/security/default_contexts"
+#define _DEFCONTEXT_USER_PATH "/etc/security/default_contexts.user"
 #define _FAILSAFECONTEXT_PATH "/etc/security/failsafe_context"
 #define SELINUX_DEFAULTUSER "user_u"
 
Index: libselinux/src/get_context_list.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/get_context_list.c,v
retrieving revision 1.15
diff -u -r1.15 get_context_list.c
--- libselinux/src/get_context_list.c	16 Apr 2004 19:22:24 -0000	1.15
+++ libselinux/src/get_context_list.c	26 May 2004 11:49:52 -0000
@@ -208,50 +208,21 @@
     FILE *config_file;    /* The configuration file                    */
     char *fname = 0;      /* The name of the user's configuration file */
     size_t fname_len;     /* The length of fname                       */
-    struct passwd pwdbuf, *pwd = &pwdbuf;   
-    char *buf;
     int retval;           /* The return value                          */
-    long buflen;
 
     if (which == USERPRIORITY)
     {
-        /* Get the password structure in order to find the home directory.
-	   Use getpwnam_r to avoid clobbering any existing pwd struct obtained
-	   by the caller. */
-	buflen = sysconf(_SC_GETPW_R_SIZE_MAX);
-	if (buflen < 0)
-		return -1;
-	buf = malloc(buflen);
-	if (!buf)
-		return -1;
-	retval = getpwnam_r (user, pwd, buf, buflen, &pwd );
-	while (retval < 0 && errno == ERANGE) {
-		char *newbuf;
-		errno = 0;
-		buflen *= 2;
-		newbuf = realloc (buf, buflen);
-		if (!newbuf) {
-			free(buf);
-			return -1;
-		}
-		buf = newbuf;
-		retval = getpwnam_r (user, pwd, buf, buflen, &pwd );
-	}
-        if (retval < 0 || !pwd) {
-		free(buf);
-		return -1;
-        }
-        fname_len = strlen (pwd->pw_dir) + 20;
-        fname = malloc (fname_len);
-        if (!fname) 
-        {
-	    free(buf);
-            return -1;
-        }
-        sprintf (fname, "%s%s", pwd->pw_dir, "/.default_contexts");
-        config_file = fopen (fname, "r");
-	free (fname);
-        free(buf);
+	    fname_len = sizeof(_DEFCONTEXT_USER_PATH) + strlen(user) + 1;
+	    fname = malloc (fname_len);
+	    if (!fname) 
+		    return -1;
+	    retval = snprintf (fname, fname_len, "%s/%s", _DEFCONTEXT_USER_PATH, user);
+	    if (retval < 0 || (size_t)retval >= fname_len) {
+		    free(fname);
+		    return -1;
+	    }
+	    config_file = fopen (fname, "r");
+	    free (fname);
     }
     else if (which == SYSTEMPRIORITY)
     {

--=-1CPAL8iwWZnOU9D3AHFE--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
