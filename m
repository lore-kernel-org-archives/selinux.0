Date: Wed, 21 Dec 2005 16:39:33 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Subject: [trivial patch] semanage: pwd.getpwname does not exist
Message-ID: <20051221223933.GA6431@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Needed the following trivial patch to fix "semanage user -a hallyn"
reporting that the "Linux User does not exist".

It doesn't help me to be able to log in in enforcing mode, but since
I'm running gentoo hardened with cvs selinux-usr and cvs sereference,
I assume I'm probably on my own.  Still I'm open to any suggestions for
how to get more debugging info.  I guess I'll try to tweak the policy
to let sysadm_t ptrace getty_t, login_t, and sshd_t.

thanks,
-serge

Index: policycoreutils/semanage/semanage
===================================================================
--- policycoreutils.orig/semanage/semanage	2005-12-21 16:25:15.000000000 -0600
+++ policycoreutils/semanage/semanage	2005-12-21 16:25:32.000000000 -0600
@@ -35,7 +35,7 @@ class loginRecords:
 		if exists:
 			raise ValueError("SELinux User %s mapping already defined" % name)
 		try:
-			pwd.getpwname(name)
+			pwd.getpwnam(name)
 		except:
 			raise ValueError("Linux User %s does not exist" % name)
 			

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
