Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98FKhrT022374
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 11:20:43 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98FKgZ2008624
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 15:20:42 GMT
Subject: [PATCH][SELINUX] Retain ptracer SID across fork
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
   lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1097248647.16641.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 08 Oct 2004 11:17:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch against 2.6.9-rc3-mm3 fixes a bug in SELinux to retain the
ptracer SID (if any) across fork.  Otherwise, SELinux will always deny
attempts by traced children to exec domain-changing programs even if the
policy would have allowed the tracer to trace the new domains as well. 
Please apply.

Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by: James Morris <jmorris@redhat.com>

 security/selinux/hooks.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -X /home/sds/dontdiff -rup linux-2.6.9-rc3-mm3/security/selinux/hooks.c linux-2.6.9-rc3-mm3-ptrace/security/selinux/hooks.c
--- linux-2.6.9-rc3-mm3/security/selinux/hooks.c	2004-10-08 09:16:48.000000000 -0400
+++ linux-2.6.9-rc3-mm3-ptrace/security/selinux/hooks.c	2004-10-08 09:44:51.705623352 -0400
@@ -2622,6 +2622,11 @@ static int selinux_task_alloc_security(s
 	tsec2->exec_sid = tsec1->exec_sid;
 	tsec2->create_sid = tsec1->create_sid;
 
+	/* Retain ptracer SID across fork, if any.
+	   This will be reset by the ptrace hook upon any 
+	   subsequent ptrace_attach operations. */
+	tsec2->ptrace_sid = tsec1->ptrace_sid;
+
 	return 0;
 }
 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
