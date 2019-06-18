Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D954C31E5B
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45F12080C
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="p0+3LrnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfFRXGb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:31 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:34397
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730879AbfFRXGb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899189; bh=K1Jx88kv6vopdDK4ndmh9fkDcPNZPrtlwPAbkP/e4yQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=p0+3LrnPF6BUpbD8ZR/1voyqtOVWC3ToppEwRAZLmJdwfQIbICUz/dsoTgXE5r7JOtMWuGsq3mGXo7yjii6tUNc8iAIOIixKTC0zeCpJisf0ON8GU4lj5MU+0S3H68ULERLKXbVDVARL8L+9ordps03V4v3ZpDbX2XX/jUTfcawMCgkFdwieXh2zO3TEooUICIp0Rq4a3yPuuB5culLTkosD4nSf0AwhTrrWFGV9qKy1THXe4Q+L7H1WrOqZGDDQmOfguti16tMxr4HkIxBTso+kWpXjCojNucbKForIjCo/mU8X9vD6kMpvrtF8th1QOxd8t+UBhZewSp4+RBkMUw==
X-YMail-OSG: 4F7LHfMVM1nUdPZwQ2V3F3foGzWnaQXE1aqRLzZvkelFKMquhA2AuV1mL6mldjB
 WE5zA9u4ezeBK3KXZgGWYJQmr4levl_zpsVzlnWdOohl_qJu3K1hyznS63p_pWlzd0kMvQOfZG.0
 iwnahug1bVzoqkib4KDrkk_fP6tOrezQEF6xDH4Fn49tVsSo2vN4uvrD0gekTcaDGXMZpWY68C.N
 p7.wsEwCE6T1jvmR37Ji0kPYPJj6ZFX8o7eTONVsZJhpRAq39NusLpSlQGGUJRYqUUnaVMf.VMUf
 0CbZRCgWOdu_tysexJbnVziu5ZK92JdBrWKNGtl0aGJXtgt0tZHJB98ob8e6Gl2jpidD3m.G2qaG
 Bmdvvsh6eRdVXYeT.M9F_uIbFAuzh1U10.avWbTaZEilbH_333WYz9PkZhxdXV8klf6nDGhzMJMh
 pSGn2R_2oVy6A6MwFzTYZ27gc3mectBvVYBmRN7NTlJ2z_G__bimB.mD1LlzQl7kZKmQDYWoJyFq
 bmllPZg.36IuZNBY54N0MQeiQf3NH7YBO68IkYalnO79r0GsGB3ZlVd.seDTy6uX1Cnc.aWIvk8o
 hwI49CpwSXXlAMEmiA5hPfCG5LJ0PZPs_IxCOKDYWI80kddb6fW4gs1qvyVZ9RDsR67BugYFU650
 lyrI48VjmtDT8jRUm1j20jBDjgqgxB9dXeHgE2PGZG5KNry8lGgp3Jd.o9tcVuAC9t8RjEADmXOe
 kgJi5ddhNE9wisjBNZDErKtv5dK1jWeAph9mQjA88tZN_o6Lxo9DSi._RA_LSHwQS.t65Mp14alx
 Frv6au_qk8Uj8aFJKrAzwVK5cyIRLbR6gpW5yP2kIAZp0D8yGvhv5.k5W49ws6vTeYETLPQRBIkS
 0QQq7js5vu1lJ.2e8u7HsXDS5w.eM6aMdGIF1urYb3NiMXf5EyfZXcSPGrgoZltaNnFPhuYOhmXh
 73UkMSM2VF6G8W7hIrxPMgzSUr1lxvhhiIHquzgvN7lfxKmNIeHhpwxOyg5QmpGQt1KjCHj9gsRH
 hqKbfXY8vhisXyBJJ_0kAhaXEcCU09MruwAf.EemJXDmWF.TGw9Du2dikVwO06dAwVvaDm86e_S_
 HXzleldpAHHjEHqOi4fJpPtFWLUVe3G6DNevJQ8OKjzyqL.ycnJn7F9xKsV4iNvAGlQlELzQesyq
 Cz7.OdeUrdQ2TPp10E9AoIdjdyj_SWfhMEZwr4qPsbjzohFzTclCRKkYeHqkPGkDgf_U72UOFe.l
 .6a9rlEfQzdwAowg18uGZyo0Nw.IPJ.bUZvA.HMg_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Jun 2019 23:06:29 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 671694aa74794ae915ae1b1c311da411;
          Tue, 18 Jun 2019 23:06:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 10/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Tue, 18 Jun 2019 16:05:36 -0700
Message-Id: <20190618230551.7475-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There may be more than one LSM that provides IPC data
for auditing. Change security_ipc_getsecid() to fill in
a lsmblob structure instead of the u32 secid. The
audit data structure containing the secid will be updated
later, so there is a bit of scaffolding here.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 7 ++++---
 kernel/auditsc.c         | 5 ++++-
 security/security.c      | 9 ++++++---
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index c9ed83e57a97..ae448814f169 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -413,7 +413,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *l);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1098,9 +1098,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsmblob *l)
 {
-	*secid = 0;
+	lsmblob_init(l, 0);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 67d3f71a095a..a094f58aebbc 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2266,11 +2266,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob le;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &le);
+	/* scaffolding on the [1] - change "osid" to a lsmblob */
+	context->ipc.osid = le.secid[1];
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 561a41eccbd9..bd929866ce0d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1807,10 +1807,13 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *l)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(l, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list)
+		hp->hook.ipc_getsecid(ipcp, &l->secid[hp->slot]);
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.20.1

