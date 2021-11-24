Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BDDC433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 01:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbhKXB6Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:58:24 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:44123
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238749AbhKXB6W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 20:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718913; bh=VLwZDb1tdKx6yw+sD0e7cZyLT/6rM6QoGaGkqwB5xxg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=sCv7apefrtOW145ZbQt/QI6JPzQ4vFuMU5aEI4ALra39t2Zd1vjxb/RNvSrYG/vrt85thAEzD87t9qdLDlkQgBDbD0wFDF7H1Ylhg+Zaz/rUDZHKF3I6rgXEu5rJJ5LvNHoMFCXBEeix4XqFRqDv/f08bOcWb2JKjb8UDkSedpt9/hi5d84FIOWDuNe0e0ug0BWEYReEw8wxGjyoLAkWia5GuORbDhPUwAJFQUiB9ZLAJRoTMzhICuvmF5EeoGaG4eY2nNC5KgXAoUM8Z/D+O4QMdxA1taDKVB+EKRB4wuwkaIr+fJivww6VtK7V8y6jK4KP8pH62xOgJBhasE3fSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718913; bh=6/eosNwc54pMe1yCp5LmkoWD+kdSqc5F43imD8wswEq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Wc2ew20FhghwhKUtFx2ARcXPqopcUbXw3r3c1bGikKLYTfqgCBmOU96yUtdrMzfUAmA0VwSj5T3sFGoMtm6SHm7JLKtgsqz6173nhi4dasQiHeGxdvW6FRT3sS8MUNuAis+ZNZ3h2LIkpX/NNEoDpqNwmImcgLm/3HCqVNF3RsZ5QrYe3ElSDMfmsNeWlueQkjWl5bw5wPAidO07NH4hH8IByv4dQ1Yg0zlWe8AB7DR74vZLKusLCmZpiGm4slW/l2m3W8GyrUNpl1CMv+r+MdScj+7HmMKKAqzRxJsWLLjkY+wsW8Q6lTLzlXzi7jhgCOsZsW8vqKUf2oCEpZNwFw==
X-YMail-OSG: dykXSRQVM1my8mrgbC4dlFMY4_IgHecEOoPAWZHv9bP5Zgcj.tWnyyO9AnhzTmg
 FvpRLPtTkAznqoU7iMWXx9hsioT_SMSvHjv62Q2SJiX3gVod6UbDMe0nsdsaMcfx7bvPtcO2mHfv
 lVtrDmxrl4xM5SFwfZrVVMSnMRSiSEUlvPpioYE8RrDjNQSiIusiOEhug2QF8UyGiQATqOu6ckhO
 SH.7aIbnC9eXkYeVnijswyWHuvwQl6De_OyLxw457bNdVT4j51FjyiztGV33521IayOLvIRpDnow
 L2M.W_9QFYXSMyzobMw_kQnjOLWflJPJPTCynLqbCRXUTPve8bfHlgnNdRmaRcDNUKHQ.iZJw_Rj
 jOgw7Rl6eUGskrYJkb7Hf_JbqQtGEFu_d.KjLrUslrD5YA0G68TOho7_V4XEagrMCIs.d7zLcNMU
 5FfVGByfFm.em9RifsFoG8o199vv8uFN3dkrv0yh55Oo9tb_7VQjtn_IJMWxZX2UWqge4YOsL.6L
 C6mGnWHja1s3nY0oV.ALMzhooPmr75mAcX04ysfqYlAH_TWJvS6frDmls1oKGa8qPXAB5J7P_Izi
 K52c81OfHNmWX5b6_dR_DMhZpvBw9Lc9KYZ2iro19rrdUd4Q9N7SvLHoEZ2JcGMMzHD43NObJT9P
 1G97qBiNPyVSt1ve.MocDpLHxKaXud8I1JhiBoOk__4A1pHxI6JQLsQnVKx03eJ3lZn0IytHgqay
 t75k5sKC_IaGapQ_UD5M1c.HtQQG6X2h0bSqaSeKYYDqZW8vpU4xYg3FOyVcbPTPN6wJCmpUY.rY
 fbXEtYS6R00JnhdPFtYt8ZWEzS.l1WcG6hQtH8JMbBT18FUZM.16yET3scADxazekmjhIO0k1EH6
 80KmpGnbvEM4t6WrNc4t3TSfdoecJhMl1.DfVmabaUoOPsamvplobakYBB1swhhvApZdDjrtE4mk
 N40dklVfDcZZgmCAQIIIyarqThY.rmHYWtI35XvTtiIA9bqMpxm16SVSB94DoQeiPo2cc8ODdnNE
 difmqoaD.zyLCILYCEYukvk4G7wuorBMWFsBxe7oPy7Yztz3PMzyIL.uCdEXy71iFhB2EQhH_bRM
 6ykht3k3tYf9xpxrfYX7fz_gEGcnQarDxwlVcBVnZkgQuzhP1MldXwcmqz3GDdBIEguqQpM7ZQMt
 jjOj4tnG3p.63vcepzR_yzH9UKoVfn_DSA1NYOS1dSB8jZJDjflacCt4qc_x1k2TtsaDJ5l8RfZ7
 DAtHqei6sSiZ8ijBXAR3tNKm6qCkVlbMHC.6vAJBa2GZDoWix2RmjJGuuhAtIy9l665dqBd6q2J4
 6Y4YLwvmv4KyuG0MrOclq74fHMs6Bu4mnAam5Ia.OaF8IOB3I07NfeLTGMOPcESa5OQwVkBFPenK
 D6qonmj6qwD5MgCytKlIh4QAoj4nauW_swJLAYJuAUqhVIQV6h57y40L2bo7Avu6YNoRENZHL9eO
 2xn_qwgk4dVACckFw4.wBUkZhTNCh4YOwtXxqEyUmlVYTR7e.cjBX8BH1QYgWsYryVEXq_t83sjk
 mvmKw0xCTk9TJhd_F.HrcA.DF7sBEpEPVJDz09eEvSGXAaX3WyIOLIHggLgnxmfxns9v0UsJk1rq
 vrKRtBLm9fbyhJeHFxFYF2jru3leK_eKhq5H71IUCCUxdJio6bUMQ1f6BSAl0cMu1e.OMVuMjJT.
 R1z6EZ53Rb.zbsIutp416VjN26sS3zFC4jLM8YdOcNOTg5W7gaBoqcVC2.RfcAmexd0Qobh6mi_M
 xbnS4ZRCZueMbbmUlVQpZg7TGJa4C4B1vcmdx3KnKSVS74Keo213dJXopuY0yJ8.TDmGoYUklbwJ
 DOnFs5VGE6U2UjQPYMl0j8ViqKjB6Cqbsge2CdGQn7J1prm._AUhzOpw.2U_JYs.KpTGlhGbUf2p
 qhKxErefKHyYcHQpHML5KQLTQ2Q7vXBtdZrgXy6HwsjYw5MbJsXxFDhGFDFuibQRiKKMJ7ewHfu0
 h.KZ_1hLa6bb3s.XUQvt68j7QobTpOzTxbA.cm.9Br2GjWSflqv1kRKCxvaofN3S0Q6p2KT0N0j9
 62AeNF.2Z1Rq_B_KBDq88bWQLC_ECJ3ISPF31ogCaXxElfTkid_5sEq3it1a4jrnOAJt6VgIqmb5
 hyG2yBZctrbwEmXylwVUbYOJbGG4kYJzKe42QJ.FYGfHocCN9V.K69GfIoEjsxjjhvpEwg2J1FL2
 QiwiJ3wfMi2ZYsy4JcjYjObowVnFlzswadZrTnGg-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 01:55:13 +0000
Received: by kubenode502.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b96e5df6817e2f1cb8c030c23d93dbaf;
          Wed, 24 Nov 2021 01:54:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v30 10/28] LSM: Use lsmblob in security_ipc_getsecid
Date:   Tue, 23 Nov 2021 17:43:14 -0800
Message-Id: <20211124014332.36128-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index af712b61c949..42c99237786b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -521,7 +521,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1284,9 +1284,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index fccd4571db5a..bba31349ae3e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2601,12 +2601,17 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
+	/* context->ipc.osid will be changed to a lsmblob later in
+	 * the patch series. This will allow auditing of all the object
+	 * labels associated with the ipc object. */
+	context->ipc.osid = lsmblob_value(&blob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index cd3ac0a5673e..2e74e5e88d64 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1996,10 +1996,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
2.31.1

