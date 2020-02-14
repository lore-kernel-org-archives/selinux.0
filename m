Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E99C35242
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBCE222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="T9/Zv8aL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgBNXn3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:43:29 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:39642
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728033AbgBNXn3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723808; bh=N0JMRKHo4PzCnQoum1C1molfIvuCl39NYAfI87+Gfsw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=T9/Zv8aL1npMIkLC+Umc3b13TB+LYFPT8cnRihFh7T27v2WjY810HG5Wcwz5ZMLMY21bDT4ttdLuN21QngI5y4e5rDLxKT2dFb1lzIeDTAl0EdiQyOnHeRdZxI6SiGMSVFlVXzzpW5iORp7xqZoVBX9q5MrkEN/NJ5Y4g6Jjkxk1eGDJyGRNhPCuKj+GSbzvDTH6KtsVA8dn8Tu/U3ifUq8WZsO3IF8AqDMn30GqS8OU1RvqE43QKlCmJXZ9mo83fLh3W+PEhuXyRpY7klLlQc8rvdHGPn98IfNA1z0dn817G3aFa/6BurRMK2iEA155KQREZKtBWEamgDCzyWLb7w==
X-YMail-OSG: 7kbMmwAVM1lEvyOvy35W0vd00VCWJ0nZxiJqeTUW0N72tfgWuReglwyineaywAf
 2vW4UISV2cshCnNVOX3cTNadLWqF_nOZ.Pm0PvxZEVeq7gHcX4vdXp2SoGnzUcjDVTWsirKy3q3m
 q2fbSK1uASGXmr6HqRwYZGUp789_7tyYdYOFF_roAffKh1ALYzFEVRlrK.wEzBmO2CBwpYNM2eHQ
 wOIxJVls.cNPPF9dyAmIgAOTAzjVTVgDBqU7hkgMCPiQd5HNigawPbQIsJvq.QQZgQ9Xtz7aRakS
 iw.NPFezxkiiinEVrttzj3ADlfMO9teYVu0nMSOCjGsOHuFAnW2BCl4O01_ZWwJYHQQrBLMUyPsG
 TPPVJsEtAGvpxxd0CESPgkrnkjrHWt_WRGp3aGMkRUei1Kql.v2iv6JfLKYxx6fa8dmD34_FhuJV
 ZRnwL85Bu0D_hLGPq1kRsuEF3UX2209EYzrfc.97jyMloa8C7ff4eHj5E2Zd8z9pup8JQ15ZKyHo
 Ni61SFdAF93ferfLH6GU4LtTeaIUtHDSfU_zPRiFGW3BGSwy1fnrPVNhkLif_d7RNDxlD5vu.Uge
 5fPR1690q.eVoJgR512npqpDidrTB.pLu0thwoo3Wq3DQ_ifTdeob9ZzCIrPnucvmikN7q.zUG2U
 4SzIfLxwoK_RUSSEYMzeVjrMSWgVqYO_nni0CtMtRhOQJsuR0ajExkUEFJmeYD5Y6s1jRfIVYO8i
 ssxhJJfBTfLF4Q4tOuEs3vSt0OjU53RkzU7Eu3S_1dWGWdvhiBbk8J5sFfJTQCCjYvOxhlaD7iJ9
 wlfVIVtAQBxhhjQ2h7iHo1L5wGlG8KOisLUfCNGCNwwhF9dQA1RHFZCSe7qcvyEiFcKNdZEV5yRU
 QgfVaTIhh5XBJzPo39eFPzqhFBOuPIOD1e7ipVtg6i7l.LAd4RW.qpYixnVbutgVtoUUxMZjFqC_
 GhJnk86ednq7v4LKptx9NbNMd75lWsqi0cK19bA59csPf4IVgz2zXHus4FW81PDR9jcpyus8wvvq
 LeAa_L6OUQ7vk3DkEkPp6FduX1FSOtb8m6dzKRgE6kpht0a8JErtFmr8xPzS8F0nQj1jOsVz10wK
 Le8cl5ZicBfKenjFuKB9rzwqDHHnazA1fl5dC5Wd27R4kEs7o7P.aFM8zXnvdhQ2D6hwQjUhAURY
 F.cKTCtROCMqgQIjzSS1dliy5WitqG2RPBuRfsvJqNpBg1FxcvCh7AvJW5ucCzvo0GP_0TD8Auq0
 dvLza7fs1Pp5jgn9S6DxxnorbmNu8x.EcU22ilx2IFdNhLIUKAhwnvIAVcPluwswFgNZMhcTKBNT
 uBEiFbwxtgUE.9rd4rQbYdxn2QZE5rd6fFLT98sGV5bpBPkAsA7swAyH0mSz._IEQxTLFAbhLeT3
 DqVY4vgRGnhsO2uCWCtVF20Y_yM5zU27X..tKPT8aldC.6EtgwSrwTy9QK_ZxOxnp2N8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:43:28 +0000
Received: by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1b596ec9113447dd0b17d9e01e17ce29;
          Fri, 14 Feb 2020 23:43:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 08/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Fri, 14 Feb 2020 15:41:48 -0800
Message-Id: <20200214234203.7086-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  5 ++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index fdcba6e8d242..3ceea6c51bed 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -468,7 +468,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1176,9 +1176,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index d6723c225c7e..032cdb603ac0 100644
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
index dae86629a2f6..9d67db68f6f2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1815,10 +1815,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
2.24.1

