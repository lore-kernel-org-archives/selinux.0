Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4K8jmRb017083
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 04:45:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4K8hMB2010243
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 08:43:22 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
	by jazzswing.ncsc.mil  with SMTP id i4K8hLwi010240
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 08:43:21 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 20 May 2004 08:45:43 -0000
Received: from highfield ([192.168.0.223]:33130 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQjEI-00011h-12
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 08:48:42 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQj8s-0001Ow-Px
	for selinux@tycho.nsa.gov; Thu, 20 May 2004 08:43:06 +0000
Date: Thu, 20 May 2004 08:43:06 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: start of patch to dpkg's start-stop-daemon
Message-ID: <20040520084306.GL24597@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

steve, russell, would you mind taking a quick look at this?

it's a patch to dpkg 1.10.21's utils/start-stop-daemon.c
which causes a context switch just before
the setuid/setgid calls.

now, whether this is required behaviour or not, i cannot say.

what i do believe is that if start-stop-daemon is used with -u UID
instead of username, and there _is_ no username associated with
that UID, then the resultant failure will, on an SE/Linux system,
be a Good Thing.

hey, maybe it isn't good, maybe people expect a fallback to
user_u context, i don't know.

maybe there should be an extra option to start-stop-daemon
to specify the context separately: again, i don't know.


i put the context execution switch in after the opening of
/dev/ttyX and after the chroot, but before the setgid/setuid/setgroups.

and without doing anything to the file handle of the /dev/ttyX.

oh, and also after, and without doing anything to, the opening
of the /var/run/daemon_name.pid file.

... is that right?  should those file handles be in and remain
in the initrd_t context?

should the user-context-switch be done at all??

sincerely,

l.

--- start-stop-daemon.c.old	2004-05-20 08:32:31.000000000 +0000
+++ start-stop-daemon.c	2004-05-20 08:32:34.000000000 +0000
@@ -93,6 +93,11 @@
   #include <hurd/ihash.h>
 #endif
 
+#ifdef WITH_SELINUX
+#include <selinux/get_context_list.h>
+#include <selinux/selinux.h>
+#endif
+
 static int testmode = 0;
 static int quietmode = 0;
 static int exitnodo = 1;
@@ -1245,6 +1250,37 @@
 	if (chdir(changedir) < 0)
 		fatal("Unable to chdir() to %s", changedir);
 	if (changeuser != NULL) {
+
+    /*
+     * for Security Enhanced Linux,
+     * set the default security context for this user.
+     */
+#ifdef WITH_SELINUX
+   if (is_selinux_enabled() > 0)
+   {
+        security_context_t scontext;
+
+		/* changeuser could be specified as a uid, so we need to look
+		 * up the username.  this _could_ be expected to fail if someone
+		 * is deliberately using a uid with no username associated with
+		 * it, in which case, tough: this is SE/Linux not Unix.
+		 */
+		struct passwd *pw = getpwnam(runas_uid);
+		if (pw == NULL || pw->pw_name == NULL)
+			fatal("uid `%d' not found username\n", runas_uid);
+
+        if (get_default_context(pw->pw_name,NULL,&scontext))
+		{
+             fatal("Failed to get default security context for %s.", curuser);
+		}
+        Debug("setting security context to %s", scontext);
+        if (setexeccon(scontext)) {
+             freecon(scontext);
+             fatal("Failed to set exec security context %s for %s.", scontext, curuser);
+        }
+        freecon(scontext);
+   }
+#endif
  		if (setgid(runas_gid))
  			fatal("Unable to set gid to %d", runas_gid);
 		if (initgroups(changeuser, runas_gid))
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
