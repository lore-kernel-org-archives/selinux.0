Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBKDbX9E014264
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2010 08:37:33 -0500
Received: from e31.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oBKDbJEK013583
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2010 13:37:20 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oBKDNSCu031875
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2010 06:23:28 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id oBKDbDSE166926
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2010 06:37:13 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id oBKDbBEx032352
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2010 06:37:12 -0700
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Safford <safford@watson.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
        Stable Kernel <stable@kernel.org>
Subject: [PATCH] ima: fix add LSM rule bug
Date: Mon, 20 Dec 2010 08:37:03 -0500
Message-Id: <1292852223-10312-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If security_filter_rule_init() doesn't return a rule, then not everything
is as fine as the return code implies.

This bug only occurs when the LSM (eg. SELinux) is disabled at runtime.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Cc: Stable Kernel <stable@kernel.org>
---
 security/integrity/ima/ima_policy.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index aef8c0a..d661afb 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -253,6 +253,8 @@ static int ima_lsm_rule_init(struct ima_measure_rule_entry *entry,
 	result = security_filter_rule_init(entry->lsm[lsm_rule].type,
 					   Audit_equal, args,
 					   &entry->lsm[lsm_rule].rule);
+	if (!entry->lsm[lsm_rule].rule)
+		return -EINVAL;
 	return result;
 }
 
-- 
1.7.2.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
