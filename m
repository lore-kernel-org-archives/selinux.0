Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4J7jXRb008329
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 03:45:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4J7jUAR021638
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 07:45:30 GMT
Received: from smtp801.mail.ukl.yahoo.com (smtp801.mail.ukl.yahoo.com [217.12.12.138])
        by jazzband.ncsc.mil  with SMTP id i4J7jTHn021634 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 07:45:30 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 19 May 2004 07:45:19 -0000
Received: from highfield ([192.168.0.223]:32884 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQLoE-0008R7-CC
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 07:48:14 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQLis-0002Jf-C8
	for selinux@tycho.nsa.gov; Wed, 19 May 2004 07:42:42 +0000
Date: Wed, 19 May 2004 07:42:42 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: is this pretty much it (to patch kdm 3.2.2)?
Message-ID: <20040519074242.GK7348@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

is this pretty much all that's required???  compared to the 2.4 stuff
it's like tiny.

this is all that the patch to wdm does.  i'm just a little surprised
(pleasantly so).

l.

--- client.c.old	2004-05-19 07:40:58.000000000 +0000
+++ kdm/backend/client.c	2004-05-19 07:18:01.000000000 +0000
@@ -44,6 +44,12 @@
 #include <sys/stat.h>
 #include <pwd.h>
 #include <grp.h>
+
+#ifdef WITH_SELINUX
+#include <selinux/get_context_list.h>
+#include <selinux/selinux.h>
+#endif
+
 #ifdef SECURE_RPC
 # include <rpc/rpc.h>
 # include <rpc/key_prot.h>
@@ -1085,6 +1091,24 @@
 	   systemEnviron);
 
     /*
+     * for Security Enhanced Linux,
+     * set the default security context for this user.
+     */
+#ifdef WITH_SELINUX
+   if (is_selinux_enabled())
+   {
+        security_context_t scontext;
+        if (get_default_context(name,NULL,&scontext))
+             LogError("Failed to get default security context for %s.", name);
+        Debug("setting security context to %s", scontext);
+        if (setexeccon(scontext)) {
+             freecon(scontext);
+             LogError("Failed to set exec security context %s for %s.", scontext, name);
+        }
+        freecon(scontext);
+   }
+#endif
+    /*
      * for user-based authorization schemes,
      * add the user to the server's allowed "hosts" list.
      */
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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
