Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4LG3URb028098
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 12:03:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4LG0lB2014934
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 16:00:48 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4LG0lwi014931
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 16:00:47 GMT
Subject: [PATCH][RFC] Allow administrator control over per-user
	default_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>,
   selinux-dev@tresys.com
Content-Type: multipart/mixed; boundary="=-CKTHsssm7ioHuql6JbDa"
Message-Id: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 21 May 2004 12:02:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-CKTHsssm7ioHuql6JbDa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

A Fedora user expressed a desire to be able to have the administrator
control the per-user default_contexts configuration rather than allowing
users to specify their own prioritization via $HOME/.default_contexts.
This patch implements such support by changing libselinux to check for
the existence of an /etc/security/default_contexts.user directory.  If
the directory is present, then libselinux will check for a file named by
the username in that directory and use that file if it exists for any
per-user default_contexts ordering.  Only if the directory is not
present will libselinux check for $HOME/.default_contexts and use it. 
Thus, an administrator can simply create the directory to prohibit any
use of $HOME/.default_contexts and can then optionally chose to create
per-user configurations under it if desired.

Note that the use of $HOME/.default_contexts has never been well
supported by policy, as login/sshd typically lack permission to read
user home directory files and a separate type was never introduced for
per-user default_contexts.  While Fedora Core 2 is using a
/root/.default_contexts file, that is naturally administratively
controlled and labeled with default_context_t so that it can be accessed
by login/sshd.  But if we truly wanted to allow ordinary users to create
their own $HOME/.default_contexts files, we would need a separate type
for this purpose, e.g. $1_default_context_t for each user domain, allow
the user domains to create/relabel such files, and allow login/sshd to
read such files.

Questions:

- Does this change seem reasonable?

- Should the policy include support for the $HOME/.default_contexts
files for ordinary users?

- Should Fedora transition to using
/etc/security/default_contexts.user/root instead of
/root/.default_contexts, thus prohibiting use of $HOME/.default_contexts
by default?  Administrators who want to allow $HOME/.default_contexts
would then need to copy the root entry to /root/.default_contexts and
remove the directory to enable such support.

- Should the support for $HOME/.default_contexts be retained at all?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-CKTHsssm7ioHuql6JbDa
Content-Disposition: attachment; filename=libselinux-usercon.patch
Content-Type: text/x-patch; name=libselinux-usercon.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/get_context_list.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/get_context_list.h,v
retrieving revision 1.3
diff -u -r1.3 get_context_list.h
--- libselinux/include/selinux/get_context_list.h	6 Oct 2003 19:55:18 -0000	1.3
+++ libselinux/include/selinux/get_context_list.h	21 May 2004 14:53:02 -0000
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
+++ libselinux/src/get_context_list.c	21 May 2004 14:59:45 -0000
@@ -213,8 +213,15 @@
     int retval;           /* The return value                          */
     long buflen;
 
-    if (which == USERPRIORITY)
-    {
+    if (which == USERPRIORITY && access(_DEFCONTEXT_USER_PATH, F_OK) == 0) {
+        fname_len = sizeof(_DEFCONTEXT_USER_PATH) + strlen(user) + 1;
+        fname = malloc (fname_len);
+        if (!fname) 
+            return -1;
+        sprintf (fname, "%s/%s", _DEFCONTEXT_USER_PATH, user);
+        config_file = fopen (fname, "r");
+	free (fname);
+    } else if (which == USERPRIORITY) {
         /* Get the password structure in order to find the home directory.
 	   Use getpwnam_r to avoid clobbering any existing pwd struct obtained
 	   by the caller. */

--=-CKTHsssm7ioHuql6JbDa--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
