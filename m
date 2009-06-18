Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5I8UAF0001392
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 04:30:10 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5I8TvCm028055
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 08:29:57 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.160])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n5I8U8Pp019152
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 17:30:08 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id n5I8U8H28495 for selinux@tycho.nsa.gov; Thu, 18 Jun 2009 17:30:08 +0900 (JST)
Received: from mailsv.linux.bs1.fc.nec.co.jp (mailsv.linux.bs1.fc.nec.co.jp [10.34.125.2])
	by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id n5I8U8ds012743
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 17:30:08 +0900 (JST)
Received: from [10.19.71.82] (unknown [10.19.71.82])
	by mailsv.linux.bs1.fc.nec.co.jp (Postfix) with ESMTP id DDF0CE482DD
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 17:30:07 +0900 (JST)
Message-ID: <4A39FB0F.4090701@ak.jp.nec.com>
Date: Thu, 18 Jun 2009 17:30:07 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [PATCH] cleanup in ss/services.c
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It is a cleanup patch to cut down a line within 80 columns.

 Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 security/selinux/ss/services.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 500e6f7..c601ea4 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -480,7 +480,7 @@ static int context_struct_compute_av(struct context *scontext,
 		if ((constraint->permissions & (avd->allowed)) &&
 		    !constraint_expr_eval(scontext, tcontext, NULL,
 					  constraint->expr)) {
-			avd->allowed = (avd->allowed) & ~(constraint->permissions);
+			avd->allowed &= ~(constraint->permissions);
 		}
 		constraint = constraint->next;
 	}
@@ -499,8 +499,8 @@ static int context_struct_compute_av(struct context *scontext,
 				break;
 		}
 		if (!ra)
-			avd->allowed = (avd->allowed) & ~(PROCESS__TRANSITION |
-							PROCESS__DYNTRANSITION);
+			avd->allowed &= ~(PROCESS__TRANSITION |
+					  PROCESS__DYNTRANSITION);
 	}

 	/*

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
