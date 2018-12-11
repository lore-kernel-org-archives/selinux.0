Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F0CC6783C
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2964820672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fjFZ2X9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2964820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeLKWoa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:44:30 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:39486
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbeLKWoI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568246; bh=q3ZwNVKWIQFkGRgaOEndkUgGeJo8IZZCX1iJ8ynimVY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fjFZ2X9GGIpNL6bJWUjZb6TTsCyJ5CFFi5uAJJzwXpaYBZ82U5pQmZnCBPA1KVBuQbDsLKjpqaIrbNUB1npnQ45ckCFZeHDog5OL2FVEBIaGTCYIVPYv5sc30wuxtELZqlghYs0oi8CQnfH9WwhXwPvo71UMiY50afgL+GZSj0Q+I2rlDgjJ6vx4uxS1XL6J03V2dsoqT/EGbsrwolneJ+YUpGeV9wEfILwUB5IORsmBTynJDz3IcqY13iYbz7Or4mFAw4Xzr8yB26MAj6sLoTGhUHdcIYlZiZDx9Omj/83J23gD/3Sgzp+lW49UAnbit+J80kN/DU++cpxPjehAZg==
X-YMail-OSG: zZ6RMH8VM1nLG2Yho7WzsW8rJvcmzS3eKKzEGyn7TVIvfA3p3y81X2OU7Imncj8
 lROCobPX7ZCnzmTuHQDIDXTjX7SlCk8y2AqNltEYT0v1LUD0CkoILaHenld5ihyHE_AdfWdqmgdj
 4t7SVF1MBeYaB8DjaWeM8_IwZLHHM1jfLs28EKqMkAjh7EbFj1CtE3m1VGh2RVQ0zK9brdxvY2T5
 d64fIQ99AbXJng8.hWYk.Zmc4_c93ivA2.eOAY.5aui07DnXl44VtX5DQrW8ntw59RAwJnTajdO9
 andjJJiDQMMMD4V_.ynU5TWhL9NntQXZgV7mKK4EhbJcMpbmIXcFc1pFtIObFqKyYpxAcUclQH0K
 iydM8_9mIDCpsCZ9A_Yl7TjU3Q5ddkFe6Sry1NpK5RWUTlbkguwCglMUHEhs5mYlzh9g3H_5qxJ6
 k4yrWKgZeJ30vHIzmnQrjYNfbik_ZPfa6EpKmNsHIuzZ4A_dzFepaOwkxPkOZQIriTxdLeXUK6Ut
 jWcEJ1awVOXTSho4B47omn1sQC0a0QqDrTeJyl.b4QE8_rPlbpw26c4HyRd_6mBZlj2mHYz6ew6b
 5W2e_YcbYJBL48wn4TfNmTk7lt7TM6r3EYuaj0zzZ1ozioTSqgY0aRAtRWFFC6cBAraf9rGl.mjX
 XX8i_B2GrZEF5O5WLee_SKX4CNuvDQ._hm2q_AxfSOqZmYCE4DLpfrJMxv8TMCNEUxjbZVEtpyr0
 IosAAe1VWJpgDoRXuJz9QGryF4wDVFB06mFC3d2LhEqMpa_uWc0blzMmCkYOOObX891Ljsx6r_Tp
 g7zJMR6NPZW9z59nqUHco9tp1zTDB5ZhCAAemBhE7DBRYa2cMXDuzmhXYj0iTTknQTzc39NtB_JQ
 CqMR99Dc69CGt1YUSOR8yp0QsrEYzpGXAdH0q.lsqDMOC5W.ita0DTAD7GyXJgBcuPk0eKkz4Gkl
 vZj.ri2AtGUylZJJD7FSD9Xmpq6FLRf2UkA5h3pDKZTHD9Ocw25L6osi2_aSlr0UePnxWuPemNnF
 LmsKV0mYmUeHf_oedRSe9epoT8ZM5FJXy12CA2olzFyGa2FaSw.eeB2pAWVA5OQ4z3ERz12OpFlA
 dcQrzGVoKS.OVsvigC6ucD7ocpDDh5ImOrb7drw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:44:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6f4a30c5671782919fad3da3c826f035;
          Tue, 11 Dec 2018 22:44:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 35/38] SELinux: Abstract use of ipc security blobs
Date:   Tue, 11 Dec 2018 14:43:11 -0800
Message-Id: <20181211224314.22412-36-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Don't use the ipc->security pointer directly.
Don't use the msg_msg->security pointer directly.
Provide helper functions that provides the security blob pointers.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/hooks.c          | 18 +++++++++---------
 security/selinux/include/objsec.h | 13 +++++++++++++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f0e7ac26f3a9..1e56b036018a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5889,7 +5889,7 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = ipc_perms->security;
+	isec = selinux_ipc(ipc_perms);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
@@ -5946,7 +5946,7 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = msq->security;
+	isec = selinux_ipc(msq);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -5995,8 +5995,8 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
 	u32 sid = current_sid();
 	int rc;
 
-	isec = msq->security;
-	msec = msg->security;
+	isec = selinux_ipc(msq);
+	msec = selinux_msg_msg(msg);
 
 	/*
 	 * First time through, need to assign label to the message
@@ -6043,8 +6043,8 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 	u32 sid = task_sid(target);
 	int rc;
 
-	isec = msq->security;
-	msec = msg->security;
+	isec = selinux_ipc(msq);
+	msec = selinux_msg_msg(msg);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
@@ -6097,7 +6097,7 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = shp->security;
+	isec = selinux_ipc(shp);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
@@ -6194,7 +6194,7 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
 	struct common_audit_data ad;
 	u32 sid = current_sid();
 
-	isec = sma->security;
+	isec = selinux_ipc(sma);
 
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
@@ -6280,7 +6280,7 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
 static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	struct ipc_security_struct *isec = ipcp->security;
+	struct ipc_security_struct *isec = selinux_ipc(ipcp);
 	*secid = isec->sid;
 }
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 562fad58c56b..539cacf4a572 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -26,6 +26,7 @@
 #include <linux/in.h>
 #include <linux/spinlock.h>
 #include <linux/lsm_hooks.h>
+#include <linux/msg.h>
 #include <net/net_namespace.h>
 #include "flask.h"
 #include "avc.h"
@@ -175,4 +176,16 @@ static inline struct inode_security_struct *selinux_inode(
 	return inode->i_security + selinux_blob_sizes.lbs_inode;
 }
 
+static inline struct msg_security_struct *selinux_msg_msg(
+						const struct msg_msg *msg_msg)
+{
+	return msg_msg->security;
+}
+
+static inline struct ipc_security_struct *selinux_ipc(
+						const struct kern_ipc_perm *ipc)
+{
+	return ipc->security;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.14.5

