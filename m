Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KF4SRb019400
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 11:04:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KF21B2002479
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:02:02 GMT
Received: from smtp802.mail.ukl.yahoo.com (smtp802.mail.ukl.yahoo.com [217.12.12.139])
	by jazzswing.ncsc.mil  with SMTP id i4KF21wi002476
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:02:01 GMT
Date: Thu, 20 May 2004 15:01:47 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>, 249784@bugs.debian.org
Subject: updated - but irrelevant (with pam enabled) - SE/Linux patch
Message-ID: <20040520150147.GG8810@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yNb1oOkm5a9FJOVX"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

the attached patch to kdm/backends/client.c has been updated,
but is not relevant _if_ the line:

	session required pam_selinux.so

is added to /etc/pam.d/kdm.

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f

--- ../client.c	2004-05-20 14:55:49.000000000 +0000
+++ kdm/backend/client.c	2004-05-20 08:51:43.000000000 +0000
@@ -45,6 +45,11 @@
 #include <pwd.h>
 #include <grp.h>
 
+#ifdef WITH_SELINUX
+#include <selinux/get_context_list.h>
+#include <selinux/selinux.h>
+#endif
+
 #ifdef SECURE_RPC
 # include <rpc/rpc.h>
 # include <rpc/key_prot.h>
@@ -1086,6 +1091,29 @@
 	   systemEnviron);
 
     /*
+     * for Security Enhanced Linux,
+     * set the default security context for this user.
+     */
+#ifdef WITH_SELINUX
+   if (is_selinux_enabled() > 0)
+   {
+        security_context_t scontext;
+        if (p != NULL && p->pw_name != NULL &&
+			get_default_context(p->pw_name,NULL,&scontext))
+		{
+             LogError("Failed to get default security context for %s.", curuser);
+             SessionExit (EX_NORMAL);
+		}
+        Debug("setting security context to %s", scontext);
+        if (setexeccon(scontext)) {
+             freecon(scontext);
+             LogError("Failed to set exec security context %s for %s.", scontext, curuser);
+             SessionExit (EX_NORMAL);
+        }
+        freecon(scontext);
+   }
+#endif
+    /*
      * for user-based authorization schemes,
      * add the user to the server's allowed "hosts" list.
      */

--yNb1oOkm5a9FJOVX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
