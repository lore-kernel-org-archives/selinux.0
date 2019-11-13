Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E3C43141
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0981206EE
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kVuVOYo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfKMSUJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:20:09 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:46715
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728281AbfKMSUJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669207; bh=6IK8Jmd19p+jg8RRRWD/snF1OW5tAad5UhaaNLHME/M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kVuVOYo+Fc7gbyrkf5ID8gEM8Uk4aIt1z2e0jf7rHw2N9qihfhiJ7mTcwu8Gq7LQpEAmD/dttATXtpA9IB4hzMi+/P5HPA+PJHghUA+UxwsWrkCo2oGu9DFczp4L2psQfeIJ0xanUuj9Z1zX+TJ/3Me9ExJZHkDkGffM1RA0rYWoOHP8wIhVkInF6sIjb/Fick5NjeIjIk5TQcxUXd/tLJEhSJ3saASg/WNjn+3oMhdLOVC2+WlWwTFc1A08CLhXTaPs6JpVox+CAgspjfabchdzBhW8lk1Bo1yuaxQUdu92eFuE2q1/vorS0o8lBZdj1ENoUevAAY+t7+q2Xgu1MQ==
X-YMail-OSG: 1EeQsQwVM1nXXGoV6NA4m.RrxZ6KbTv5vnjFDjz2lQtHroCOTX58KrT6AjN1wzT
 tYQ8dTbKOkL1NcM06BrPnZNrlh4sX7wHN3dB2rZrR7DBNSt31TkrQbzPrzbF9MdLIKHFmFwH.WfF
 WHQv5_ksVcU.NZTAW2p7i6AMAt5iIYzyH0kM5_esGbwgcuHkRKZFYAgmZFsDcQeClpz43bmHOtsE
 kBG7J9dDL_iJ.ChPVKmIr9W0AQ2qpWc6JVpJYJNuCUqC8BefJlVdOlOEq8moPYVs9CtJY5Ih5f2H
 RQFiUXYZEjJVNO93m1mRoJz__knwfCdCS6aRmaZJQ5SyJ.1D_U41hajMbM9zNhYQR2buQg.NKq_j
 ZYyyCPwHyr8nm.dCsN4rqZW5mCDZrF5MY8sY0L7RyjqSKrkAwralArq9Q8EHtVYwatxYTd1xfe8s
 SUDMyxZmd7wySxT20LchT9subYINS5folipUTaQsekJGInpwFCsYgbgz8FFYUFn.6yhyqSqHo6qX
 5UeKffufUT9wSPfvwastUgCGldb5upnLEX4Qbmq8hHkeOLO5tSlcdd1AxAtirm9nNJ4dZFuoDjzt
 vyNkM6tvWY5zKE.DscSAUCAe4FCmqh4ojVqHvvdIw0vvVU8tBUN7HURHxsGgVfkpJnB7GBnneHtl
 iCFIsEQOOzgogJqcfGPi.S1.NfYtzLiNzSMu0k47mpsTFABkg532ktb2LYO36MAtl0jxvmvvlBC_
 RGDMx825k2d9aLxr_QQaQL7U46c4L9mHfT1vUJVILDtG8cMwGpntOvjmySh2TB.c9bHLCovyVe9h
 d9vUd1q.tfLLJ9IE1FQVEI3uaUepLmq9kipRSsMD_uFO0R3oSCqLfpjctJBFMLzqXXbBv9B_Jsy6
 1tBgrhHxm4ZNuUtSh5cz4aPONZyT37NwPmwvNHb7Q1in1NSCjnFdqKOegan4xrlUslrfJpFx5rRw
 iLl9EwBNmDpgyCzysntOJwHyJ1_buOV3eSFlc933FRj2W4nKW9oZuMJZMzzdODkSR6nFBxwQqxnZ
 3BBYr55Tao_kfEI8BCTIRNzctf4_rNOzN3OXMpd.GYM9B_Msi_3WOWImwwDuOomUtO9tmR_b55Kk
 tphlXcEYMJ0vRyfIoInlTCpbG25uoFLyW1I2Zoipg8K4Po7v21fLleU.hVT.kVHW_cZf39YdbHwB
 T4B1TSSGeIeuRgX1fIrFZagy91a.ac4gg_NhW1Ab6g0l86hKyKjJEKrofenRF0S6A4lgdyEm2rp7
 eRjx0jLltK42wPAgEJhYSf2mptpGnQvoOW.HMCLQyjRM.12KVB9toxlJfS2dcz9XUUAac.Iy4Ey8
 IjfocZPcOe8Yj3qUnHryeu5xzIvVyk3A5JqsYhJSqYsUQPRufwPnJ1WIfXGv1jeE7UbjSY80ZCJ2
 CupZPdCH4LMZoIBhV9S5eZnfCweWVwghLxdqQOoqr0UqDRRXqr_m3QPRIq3bVtwes
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:20:07 +0000
Received: by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b1a61182257f10df38d21beca379be88;
          Wed, 13 Nov 2019 18:20:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed, 13 Nov 2019 10:19:08 -0800
Message-Id: <20191113181925.2437-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113181925.2437-1-casey@schaufler-ca.com>
References: <20191113181925.2437-1-casey@schaufler-ca.com>
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
index a3e99bccb1bb..9519b4fb43ae 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -464,7 +464,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1172,9 +1172,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 0fc75a31a6bb..b60c6a51f622 100644
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

