Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D02C35240
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A3F214AF
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hpfVRXFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgAXAYc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:24:32 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:39373
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729504AbgAXAYc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825471; bh=ca0Tfp0NFYK0VSV67i7qhfcA343IR62LEkNUbdBthlE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=hpfVRXFNmJrWPWsubhWGvFCZTMHODoXlM0R1Xf+b1jF4d0vgrxiKPyRulYjDL/n/+j6vryGzwhNQpKM0+mkbVzaX1cm5gNa37TOUFyN4XQd9+irS8la+5nmcNpBy9EAE2ffhe51RQYRF5qV4GXDT+U8AHGjqSS7JxS/b6rMQcazsMrUHQhBFgZTYrGF9NZ6GmwrqttMem3xnVw2wB4A1TjD1TWoPDZ5rCX631glwOF60KlTgbMsimIq4m/m2MHhyJVG9afdbzi/fLkRUVR6LVOkz/xT/vDXp6rwqnYiB/UlNKEhw6qFC9PEMk87J0XA3MQI8uYP/DznK/O+gmfj+Jg==
X-YMail-OSG: k5w_EOAVM1kFbjhU6f287C1trFuTPrvtBzN2E8wl0TWbuhw7AvDVjMLS5Yu_AGy
 o.tV_tkAzeFBh_FpgmvwyzlAFhLnq1QDwAtbEHoJ78xp60dZfsIgLZJTwqr67sIhJTc2qZ17JoIP
 fH2.KRJpruJWw3t8Lt04OOgEvX8hPtWilOsAi_W8XsnZjjt4L4.R9tlacNrzGpoYVSiu0mkPbagN
 aGycgleyFARz9h0Trb83bEb9FhYBN4kDvcyfCJmp3C1CIFVeqMJ_DC65Hr4M5J5ZZ7FJRRGkRuRS
 QUgdkeg4O7dbLSadImqaVXRqLJQfGp5Wb89fxkP8NvMGautDvBp0LmNCM3K4i19NAshrtDouKynr
 70.C9i4m8JWzmTI.wOjn6e2YHSUF9BQ894eGVjDCQn4o2fJNg.btMdOoNAdkvSv0L_gLyOSPpwQz
 59Lao9EwlO2A8CXxeB7e_gKW9TBXKS0vl68h6nBv1mKwvkWEJnqAW2fCAAR.U.0xWvpvyFBUQ1md
 2IqgADgHyIll43WD3P3ca8aga2ZwCOXkV8uBR9rHR1WSXwHZAyQkaNw.y6eKaEc_wL0ZXJms9fzV
 bmpcF2pDB949t1E79gnomqcX9VN3NWGgKxLsmYibu28g37dJHvy7eyYp0uyLi..rGAfmGANLSLOK
 Nllkcbmox2tWK.40PLkSgUG2Y8FZfooe3ffPhOFR0GAW03VPF4DtxpWA.IwHl0uro5AQZKQKqnMr
 .gYuPwqlSLCf3jeiBovRYXsvp.7aesDdh9RmdMhEscKogECiMa8S1UmWjsiqiCko2l663PL5m0bF
 c9sCEAWvjRkVVTBVb_NpzjlU65eGHPZezx2.WbCSlSL9QYhVkfzkM_RxWqJoUpae2iaFhh5XaUkh
 XHYq3E1zlOsP1HSYiGyOQDQ9Qs8eN4cxJLWi.C9HTcr3eEM_hxo4XlWwELM3dWnaDt9njkAiB.mk
 CxsRssRk2qaQ6yF1A.Nl1LuyCl4dkME51vuapkDsBF8ri4Xx0V_Lk.qfBa.bY0MXpHQx6jKIhTyj
 nXgy87_bl8M.alh.sHTlblNeaNpI23MQv6Xi5lButOVN0whcskNmah3KY7il7hiKD3ugActp0bd9
 BYktKuIOsXCFSFfbPfJBYGaKoQMXxMuoZmDjESNy9wFbVYtPktfnD8aTtj0uth2vG4JSbLDshja5
 QV68NAP0OWkdmnKVBk69SN0KNRhUqSQfxkxZR4GvToJ58BtlrouiKWdHClKuN9qZYLF1H2TixcX4
 4cC.NDi9R1rJzlWP6.zhxX6usYtcil5XciF9LsEgM.kBsqywf9iWvvGIP1op480vUzWBJAxgVP25
 6cFWqZtMBPA.yyieI18oVZHUPs4xFDm6rbAvwjajr5E.TLkZXxQXsDv3mfB6cAa83PwYMA6.x30N
 EAQLu4Crj6HfyacTVKFTsJV5iVdBJl5k2Am1BP6i6KF7CYJY8bJmspoA5D90ti01V
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:24:31 +0000
Received: by smtp424.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 759da4ea465ce667781c92ca655afefe;
          Fri, 24 Jan 2020 00:24:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 08/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Thu, 23 Jan 2020 16:22:51 -0800
Message-Id: <20200124002306.3552-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
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
index 556660941e5d..5444302d2576 100644
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
index 553d8e05be0c..9e80e55fad6a 100644
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
2.24.1

