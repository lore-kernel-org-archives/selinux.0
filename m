Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68824C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA5E206E0
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kCjgQMDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfLPWe0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:34:26 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:45227
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727609AbfLPWeZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535663; bh=WHSWZ22nKp0hH/7/jZnFbGHSQ8a7TG9sYWeArSzn0QQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kCjgQMDAmxL0kA1O94Zxzr7QROVVSVkCays5MDHwTUQquveXzbmfCCugxmJBbTLedA14jEhE/feWSvs3U0BjKqySAj9dUflGpEOgFDclaN4PeQoAkvRCUle840CZ8aU/U/czENvKl8Ae+p0jrM+0hfc11xIB/Zu2soppc1F6xahyOejJ/cw3o4OxdK74rNDIVrjEY9NWei4hkjPsWjM0Yd7PVI9k8cBau0iFcMYGOSer5YisZJEB6l22HXiZlnur5EOnbp6PEbRPBnhE8eoZO1gr42e0RhXrMf2XZcodFiE4OE9twK6mDsH1Jr7rOj2/kVYA6DqSTi04hi+4RuY1bA==
X-YMail-OSG: GnFUzasVM1kLXIBik838FcH.IXFHi0X.NRDFYQ2oRlENe3O4_x2UcCgAZ0wcqpC
 CvNIATfkVNVGnbe45pF2eSCLCUgKFzQbShPESZ47e3_HVd4MT6B4FmKFlHVxhwAfGdxTaQBhKmHY
 AefQk7ArzBfeP54cCpKzf03b1_lbRWbXGt4jvwG8pYE35gqjgHIQ6sItwic81UZxRtmU2KgGDD1h
 P7.Y2NSTdzD5tpKQUaP9avkPtSGVz8wRX0rNH24yWu5W70p2urlNvssksAEYQ4wITQkLAWD.L7I9
 9oE5iyNGof7FdniltrMhL_UkFgmQcvTRG_aMIc1pYsgzXKRIefSt1FazxrwF9pYittLvhDZpXnyj
 ICjMyE5bhnmgRBjM9U.SNNogJ.yulwDH7fIOpwV9YcI.GiP2aOh6xMl0pWCTEBtwpXF1.PGjC8H3
 0LqSeBYGxS5hNcjNJTLDE4whEkINjpLJ.hzBqn6GJJeKSjg4uAWZ_YuUWZQQR0Ngs7gCItCXYpRk
 gyX3Ix6Hl.z9m2Lx1ghxn2fYh_R.fWlvu2t6YanbmqgricYNzOOD5iOY0285XXFdlsHRmnLJA4Q1
 6FcWj0858090zfV7JHFJ6IGtcWSAI.xn5DyZEPcyKGJZUEyBKmw_3f1f2f6.awbQUN_.h5.MKiXh
 2qERsVu1VEId7STw8W920pP8HCSAlpZ.mndLuTsIc_lcn0Ka8gVfWhIfOJHuUa1b32tWXXsRyrpv
 nFeEt2FbDXVeUrkWmq8Uo74BsAZ_hHlCLzvRR6n7BrDTl7rqO5.Sd.tNTcMNwIrnhZN7vEafMffY
 1EeOavdjUhLSn_jNt8CgmHVaoisn1XrnEQtNwzB8ZbHd8KpkkDMsBpYDK_0K.e0n5Poq9SnM3zjN
 yuqAQWWOdgKXjM7KqMHMaZ_QfTUipG4dSgHVJO0uZSzoJ46uVhVDoJqwxbOOspbpVb.bdbMu8j1F
 vuGBJbe2ycyejrHass7T3moGrwejxLJHO_ZBuq4MRofAc1ttCYwyvcd_WZGSMGUvXL7cr7GPiHNQ
 n.VVEn6Dbt8X5TToEdT04.Hox5ae9z6xUFbGdAFaz.rPZn.QAcN7pY7DPF.1IpOY0BEZSG7QplL5
 PyhPLQPrJkX5GkM4eLk7BGDwIsVwsovV4sBRCzfpPphMNXVjlHcXUbl_Rbw8gnJ9U.3D75QUWY9G
 hy08GOhfIvo9yM14gqLbQnRV799I1Sv4bPtxjfrMft8fYJBivnER.sbOuwAdvuqkrPrqlodCi1Zt
 MHLtLEFQXRwTeKoi6_JEsw7ujeqlmUHoHIGAfF.5.020JOA51MpJkH.7sGlWQ7StQySWq1BoVITV
 ArRyJDxRHGXQrrsfGoAqDXJ_Y_XVBVPkixNt6pUSbES09kWl5SLq_9QkT8uRW95u1emWi5ECXHwe
 ErLYu1GbLA3BOy0QuO5vU_h1wkeffA5QTQICmXBXzzw1XpywTV5Hy8gB4faskwgGp.A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:34:23 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 534f0963b73bb8eca427a24b6d6f3465;
          Mon, 16 Dec 2019 22:34:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon, 16 Dec 2019 14:33:28 -0800
Message-Id: <20191216223345.5066-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223345.5066-1-casey@schaufler-ca.com>
References: <20191216223345.5066-1-casey@schaufler-ca.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  5 ++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 26b8cee65c64..61a80afbbdba 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -466,7 +466,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1174,9 +1174,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 04803c3099b2..ce8bf2d8f8d2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2285,11 +2285,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &blob);
+	/* scaffolding on the [0] - change "osid" to a lsmblob */
+	context->ipc.osid = blob.secid[0];
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 61571f5c7c5f..0d87a2349552 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1783,10 +1783,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.20.1

