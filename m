Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C99C67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957FB20672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="prTrZXqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957FB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeLKWoR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:44:17 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:46129
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbeLKWoI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568246; bh=Il9GpnbV91+fys2zxOGbpdhryeWPuMQjgXeEO7Bfh2k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=prTrZXqGqFzroyYtN+YEBDGdQnSIA3W/hmx83yDeGBfeAv4/BsYS/xCJ/2moR2Jp8UgpqSLZO0uHrY1DOX8QS21DsyyFHf1WSeRR3IFIJg1fjh3QhDZLFHrjOYc9nNdltM9UN5nOhYeBPEopUBsR4HnBaNz00klAn3IPJXg8K5NjtKGgc1uIGva5PP3L6lreGo2CB1ciqOqAaXA2qltYcXx3Ti34JltQek47lwxmHNMykxholCVtyzkUGGs8JgdJB0iSlkvKfdw+tbzFh7qJFmGClqmF4gZNVBUgoCBDp3GyWV5a7u32HRpLF8ZtFlxsZIJXb4un3I9Nd2LAWTl6lA==
X-YMail-OSG: GULJ65IVM1lK.OjqGz8yqzFzTBJXMoEKqNyElswLU5IL9QqZIgQWc3Ar1PIXMQd
 y4z7mx4uiMaPI_zM5PhTtKSo7U9njstHLyYY1qd4rC88I2EScqGp.C_0BblbfBINxlkq.QXLfqmE
 J.VmGeOkGfN.A1V4MwTbWbKHBywNkifpIs.ZwV1bNGKX_TiSITqsjhOOLR0jAm23TsKXFyoIifNX
 Bfp8P.nCvhD17cDiy_zAIBroN8K7PmVbGiyqLgLdmhw1anI.olzAVY8MaidTgNEBX.stGFx78hE8
 fnL2qWQkcF4Fngku_A8l4IAQaZmTUEX3c.qH3Pd6dPf_lWW7cc7L5AAZlsiHCvSzDfr69xDL.tfI
 IkpwaXF1SrMaVufm4jYQn82qRNavPfqi9rTYtGVJKyyyLkSws7vOjid53q9KRjxPZl_zEy0wYjq_
 lI8K7hbA49Q9ecm9XR17KqhgLU3ZD_U4k8CeZHdesTHtgWd.ZqIo8xpY36Dn3wtC4P7x8QWSmnwP
 rT.PjBNVbvTUOi9o1yYpznzvWAa6D1wA.XRh15e4I4XEAPGxZuYY0h0NPXfksGBehlSnCFzWziar
 vC6m9YMAXvj2ygD9yRkUaxW76NjPope.7W.x.0pXzwTcdNVv5mSEjpxJyK_1G3n_7J8wc70zAcH8
 9fbCbFYYxaTZB1fMfNrnod_KL4Bl1d.SCY_6Unx8oB9DirmGas6NM3Kem026CGYpoe9PASXpM.IO
 ptmUztRMJ3TK8btBztwBmQMRpMy4o5RwC0qfhlIYToplywEWgY1O.SLg5LqlQ2JtcIPisPVes7ce
 z0W1oB.qWD0__7KMJz5yf4D_7lm0aAyU3ANLpNvjMO63M4pD1oBqDSnroT4pgfY1Rs8NQaflqW7z
 OTwv_O.vga4D0HFiHWKIOSL5wgJP01DZSfSmx975f3x8oHA_k3vN.Z8U6heci1g1zljKA7X97EJz
 X96JRcqHOcDpKU73WbY48hz85vfGJlzYDg2FvrKuFzcW3A_wAQb1BS4jPvadw9XnluERdURul1lb
 IF_27fWcyogbmKH1wb4CYrk2yC50wY8h_.21PrNl3RawY3pZ8uI_m.hphUd9JFFokJ_9o9PKBu5p
 kXwswsHIcmcL2e1xt6FoLnAFZ9pkZWBPvCnpROg7U0GI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:44:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6f4a30c5671782919fad3da3c826f035;
          Tue, 11 Dec 2018 22:44:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 36/38] Smack: Abstract use of ipc security blobs
Date:   Tue, 11 Dec 2018 14:43:12 -0800
Message-Id: <20181211224314.22412-37-casey@schaufler-ca.com>
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
 security/smack/smack.h     | 11 +++++++++++
 security/smack/smack_lsm.c | 14 +++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index bf0abc35ca1c..0adddbeecc62 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -24,6 +24,7 @@
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/lsm_audit.h>
+#include <linux/msg.h>
 
 /*
  * Use IPv6 port labeling if IPv6 is enabled and secmarks
@@ -373,6 +374,16 @@ static inline struct inode_smack *smack_inode(const struct inode *inode)
 	return inode->i_security + smack_blob_sizes.lbs_inode;
 }
 
+static inline struct smack_known **smack_msg_msg(const struct msg_msg *msg)
+{
+	return (struct smack_known **)&msg->security;
+}
+
+static inline struct smack_known **smack_ipc(const struct kern_ipc_perm *ipc)
+{
+	return (struct smack_known **)&ipc->security;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9ff185af378a..ceda326a6e47 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2918,7 +2918,9 @@ static void smack_msg_msg_free_security(struct msg_msg *msg)
  */
 static struct smack_known *smack_of_ipc(struct kern_ipc_perm *isp)
 {
-	return (struct smack_known *)isp->security;
+	struct smack_known **blob = smack_ipc(isp);
+
+	return *blob;
 }
 
 /**
@@ -2929,9 +2931,9 @@ static struct smack_known *smack_of_ipc(struct kern_ipc_perm *isp)
  */
 static int smack_ipc_alloc_security(struct kern_ipc_perm *isp)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known **blob = smack_ipc(isp);
 
-	isp->security = skp;
+	*blob = smk_of_current();
 	return 0;
 }
 
@@ -3243,7 +3245,8 @@ static int smack_msg_queue_msgrcv(struct kern_ipc_perm *isp, struct msg_msg *msg
  */
 static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 {
-	struct smack_known *iskp = ipp->security;
+	struct smack_known **blob = smack_ipc(ipp);
+	struct smack_known *iskp = *blob;
 	int may = smack_flags_to_may(flag);
 	struct smk_audit_info ad;
 	int rc;
@@ -3264,7 +3267,8 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
  */
 static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
 {
-	struct smack_known *iskp = ipp->security;
+	struct smack_known **blob = smack_ipc(ipp);
+	struct smack_known *iskp = *blob;
 
 	*secid = iskp->smk_secid;
 }
-- 
2.14.5

