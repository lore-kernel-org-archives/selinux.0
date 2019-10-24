Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1902FCA9EAF
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22E021929
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LKpCiclB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfJXUxi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:53:38 -0400
Received: from sonic311-22.consmr.mail.bf2.yahoo.com ([74.6.131.196]:43004
        "EHLO sonic311-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728621AbfJXUxi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950417; bh=SzhkUBMInZW21eDTVaDgtuRnxZhqJtkvtFFiFP3irFg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LKpCiclBQSq8FB1ctpS3DF/mhXKOQ/DMzf/msNtJ3FTnS1PujSrZiQRtahHjY/osqW3pRaF7B97qDZlX8AHASr0+7K17chVTXmC6n3IXW/GIBp0rn1dVsmK6f3imxzre06Tyar7pB23YkpoJ09mRm4gBm1BgrJ+YgD1KguXILH+vrD5D250iqK2BDdzMTGeCK1mspm0jvetDgNddv34W2x08jJfLYY5qY0x5WjCLNqyeCl+2dCBxP2Dbk9EbCggYW8jGubXVJvgkC26ZvP/BklNrWu9BVobIMpXVmX91EuHT8UqakhPpxhMPw6xfIZYyIu8qNnIAbcZz6lUFzUThtQ==
X-YMail-OSG: 8qSAwakVM1noj51d8Dvm18NwaOe8KzMMtYdt0S7DBIl6mvgoET13wLr_04iyu3J
 DaoX7JAQEiTqzajQ6ie7RRlToVAf4cJCOvxhEeIFVXKAQFUkKGHwgG3YwxTesGNs77lovLP9_oYn
 QDUA2Jv41NmPUj.VMCJTa9R1j8HwlfQXch1.Xfeh1f0lGyOaxPfDM.fyK60vlTISVcKic9EokSr3
 HKSy9wOvyfI3Nt..PgRi0MPWv7FRypHmjStRBXT6NdVBBHQEYzzZygkIhym1lgtAbAVQmuSvy9e6
 4j.EaADHm2zH1bkthqaOzw18C1dYI60xw5VaR5xxTEBLR0bfwwzveaFBZw0ref_9cyzOxK5kJFX3
 a.Y_9Ffi1ZdA6HQY9PzYxwRvj5O8FOPI5o4EENfDBpsZ1ESFWXXy01ymxOxnJHs8eHlS5e8n30FT
 vUpbiv3wvpTZieODQk4CF1ideNbDYTj3KoiUJswUr28aj6E9zM5MI86nB0kxhFvaIcOJQsRRAAWI
 6qIazwtsZ0LsjBZu6y0G2XsdoqdhL20AEr6BBR0Q0r6oHKe0vmrx.DhdAMmF.wloRwenMPfjgyBc
 uF78jeU8yp5tIQpOhXUcgNOFMVNJODWQB5CPHMjz.rJysHmnUmvBePEaFu2nznuk74_UnjXJ.Nr1
 VWUxruQCVAuzwn7kLyZ572EdNAbWdetJ4utt090fIowK3OEUOL3maV38Jef.s38BZ0phjaV.8A0_
 vf5SaaUMbjtQoVoiGS7phBt4FwmQEOU40mponMlFNHdPo2ETT7Fhs99BNqyx30LB3Tq.0EbqLvOv
 nkEguIyuvoDFxhnD54a8g5.TtDb.t7Joia64SvCI3GGTbijDxHWnJayYvPbDgH8AnsYhZo9rT1JM
 xJfgp.ZlvZkbdl.fK0YOzY5hMzFpM8BMrO3LxDJzCUfrk6JRZO2JwfNz9p3M7Y0pgL7Zw1yhQuaj
 Am9evC4j6vl12uHhyHlCJr_EJpem66z4j.Qk7aUQLgfbjxFG4j3Pqrp5hogSMsqePxV.rUjetknr
 srVZoBXVUWi.R3dJ3DH1mkedRG1j7jnCjX0_Bm3graKh._oJ9l8K.3.A99KIu0lh6zf8m1ds3IAh
 vlc.sPxgu3ACl.SUDdj6Mm2Dhct.Y1SOeDj8l7Tdor6uZ1.Z8b0avRtYYAbHOQvwjn2c1LOwVxjq
 C8CIB5zaysxVivaVHzEn3p6deHWhUkBk4d4HYjajt2gh3Uw3VSwQvHaUnpYQA5Rqb78namUpFdwk
 2BkIb2wADqku6dHyMi11YrnmRm1gotLZoyZcqrKz4eypIaQG99E77k_0yEQFN2dDUA_qjq9dhrtP
 n5B.dtJF0zxn2gDxArrfSHDCjQKGei9u2kPjOQN5yvw9k5czKEZmuQTQVpA177bc1bODfKijumm1
 QC7yHGYeWxJhoXYuliH0QBw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Oct 2019 20:53:37 +0000
Received: by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0cc137411481ced1a298f2ec2316752a;
          Thu, 24 Oct 2019 20:53:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Thu, 24 Oct 2019 13:52:11 -0700
Message-Id: <20191024205228.6922-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
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
index 6add7925bfba..a1659fba6afe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -409,7 +409,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1094,9 +1094,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index d31914088a82..148733ec3c72 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2268,11 +2268,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index 121e395a39ff..e4b50ae05f6c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1734,10 +1734,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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

