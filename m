Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3KFaURb015578
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2004 11:36:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3KFYOKr002395
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2004 15:34:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i3KFYNvW002391
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2004 15:34:23 GMT
Subject: [PATCH][SELINUX] Remove hardcoded policy assumption from
	get_user_sids logic
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
   lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1082475370.7481.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 20 Apr 2004 11:36:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch against 2.6.6-rc1-mm1 removes a hardcoded policy assumption
from the get_user_sids logic in the SELinux module that was preventing
it from returning contexts that had the same type as the caller even if
the policy allowed such a transition.  The assumption is not valid for
all policies, and can be handled via policy configuration and userspace
rather than hardcoding it in the module logic.

 security/selinux/ss/services.c |    2 --
 1 files changed, 2 deletions(-)

diff -X /home/sds/dontdiff -ru linux-2.6.old/security/selinux/ss/services.c linux-2.6/security/selinux/ss/services.c
--- linux-2.6.old/security/selinux/ss/services.c	2004-04-20 10:11:03.000000000 -0400
+++ linux-2.6/security/selinux/ss/services.c	2004-04-20 10:48:30.772189123 -0400
@@ -1341,8 +1341,6 @@
 			if (!ebitmap_get_bit(&role->types, j))
 				continue;
 			usercon.type = j+1;
-			if (usercon.type == fromcon->type)
-				continue;
 			mls_for_user_ranges(user,usercon) {
 				rc = context_struct_compute_av(fromcon, &usercon,
 							       SECCLASS_PROCESS,


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
