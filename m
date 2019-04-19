Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362F9C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DA021736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QNBa1R6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDSArT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:19 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:43879 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbfDSArT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634838; bh=j+cuqymh91xxGIirxxPJDUSMb0L9mw21aX8dKstwmqI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QNBa1R6qbNWMI92q4dKg5aWf6MEL7odOtm6l+OlcxqiknqlP/H2P0lAgGAOJICJMgaR9V0ISASSuiM+pOzDzMPkUWlDR+j1LAMLC+2Z67QLU67FBQiwVY2eMpS1ZqJ86IDeUhH3FY5fqvXWfd0y2LKwAj6zKkT77I2Q4AvHUuRY1CS2jSnd379j77FPc7KBj9GRH2ZFSxyW62O8YLbXC2y5sxxfk1561zJrICBbXZmXpX+KU0+MOgJ/6uoRvrOGF3o31fC53nO0eK1K6Y9MXRbFROKyvuan0t3Ko3iihdScN0NU8GS1tBbZ4s2hI7VpVe06BTDOx7d7VwMeZxh3UKA==
X-YMail-OSG: WMnyVKcVM1mfOVn_k.AKGOolCyDcZ8koJWNktiawnZ.00Qgl1VWGN0lDB_JE7He
 5gLuDLGiGNGpLNyYmEyCFItaG1MXMclfHYJXm6oJQlL3eqSLLHfj_fhY1XvjRBU5gcYPzQHiptwX
 eCHt.bIv7dub1ywh88NMw6Xo8T51u4bdr052rYziYADue91mBq5zcmJNUGjSZvGR2p3AqYgvdxAx
 gGD8PGC9D1CxgD29TO7UHKWfuUBWjFh7VnrtkXW065nUw7RqpL5sli3B_vpU7iih3vBQA9gcwN4K
 1oG4Wcc0KdC1HqP2B_xBipvL6uvW3lMdjwc.cR8a07JOHPqSpBbeO8HzUBOLpIKWRkHaL9w838zr
 pMlw3PqniVKzPy_helWaHHwHxWeqUcuzt2.GLk_AAShCyp5TPiwr1oE8v_etN1WkmBHt1He1d1Mp
 YfG_xNWW9PisqrULO0gxH8E3SWZ8njZQeJHouwcnodZBxUah_DDFARcEUD6FbU_JgvTel4FPkZHa
 6jQUhrcB_yvqV6nK1FQulMdYnluwNbRiSG3cuGD9XUg7.qAJ4hJHc52yJUUEf9zqpcoBVqVzwwNF
 orCe16Ua39uo3gA2QFpGqAsFrFoCdCZadx.DbVSzbA9lYUScAhxJGSxLcSqSjnyIeU40SZQhG5nl
 wJR8hLnNaj2Vnbc9afgcqel1gvpjQRkRPf1A3DyLV31YuVCuuJ6sO4bj5ePf_mi63uijIs67jIeE
 F80hU.q.JcZ8nVqfNSRmURQNZdpJLJJVdobd.TOaTHrQ3w9D0qGFh.RttzJSNEOl9yFbwrWe5KNZ
 ARjWwh8H54j.WrRHUP4nOGlo_wqoJ1OGKDm80yoTMJwUfDE81m_HPOLYMAdEQP7oCy7_1ovz0kC2
 NBLjl14SKDeFFQzR8wNSGgGliP7l.0YKlKQnzXnlCXgTEyIhGj0.8DkA1i01wBBbG4Fr.FUk1SBz
 r90nbuHOnzXkZOxEriELI5yXlXU65tl3T.34fU4id621giho3p3_OUKKEp3wS9dWJlFjr2XWGpqR
 B1wrsTKlKRlNatLLknTXgKb_m0DWgofdiPxlCQRqQ3sPrsoOs_cA.dQC08dYTDh.35y1DiabQBdS
 bA47u7DQuaLgOp3RpLvq5.whXg_9UvK8G8IDW1qUElbRNvz5jz0vhRy5HuilBXUK7gDShmvwUz5M
 n6FErnbHxesJi
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2b98cff5dd7fb51e7c7719cd11eecc1a;
          Fri, 19 Apr 2019 00:47:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 23/90] Audit: Change audit_sig_sid to audit_sig_lsm
Date:   Thu, 18 Apr 2019 17:45:10 -0700
Message-Id: <20190419004617.64627-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove lsm_export scaffolding around audit_sig_sid by
changing the u32 secid into an lsm_export structure named
audit_sig_lsm.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  7 +++++++
 kernel/audit.c           | 18 ++++++++----------
 kernel/audit.h           |  2 +-
 kernel/auditsc.c         |  3 +--
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 40aa7b9f3c83..e76d7a9dbe50 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -93,6 +93,13 @@ static inline void lsm_export_init(struct lsm_export *l)
 	memset(l, 0, sizeof(*l));
 }
 
+static inline bool lsm_export_any(struct lsm_export *l)
+{
+	return (((l->flags & LSM_EXPORT_SELINUX) && l->selinux) ||
+		((l->flags & LSM_EXPORT_SMACK) && l->smack) ||
+		((l->flags & LSM_EXPORT_APPARMOR) && l->apparmor));
+}
+
 /**
  * lsm_export_secid - pull the useful secid out of a lsm_export
  * @data: the containing data structure
diff --git a/kernel/audit.c b/kernel/audit.c
index fa4c5544eb37..5226e2af9498 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -135,9 +135,9 @@ static u32	audit_backlog_limit = 64;
 static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 
 /* The identity of the user shutting down the audit system. */
-kuid_t		audit_sig_uid = INVALID_UID;
-pid_t		audit_sig_pid = -1;
-u32		audit_sig_sid = 0;
+kuid_t			audit_sig_uid = INVALID_UID;
+pid_t			audit_sig_pid = -1;
+struct lsm_export	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1429,23 +1429,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 	}
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
-		if (audit_sig_sid) {
-			struct lsm_export le;
-
-			lsm_export_to_all(&le, audit_sig_sid);
-			err = security_secid_to_secctx(&le, &ctx, &len);
+		if (lsm_export_any(&audit_sig_lsm)) {
+			err = security_secid_to_secctx(&audit_sig_lsm, &ctx,
+						       &len);
 			if (err)
 				return err;
 		}
 		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
 		if (!sig_data) {
-			if (audit_sig_sid)
+			if (lsm_export_any(&audit_sig_lsm))
 				security_release_secctx(ctx, len);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
-		if (audit_sig_sid) {
+		if (lsm_export_any(&audit_sig_lsm)) {
 			memcpy(sig_data->ctx, ctx, len);
 			security_release_secctx(ctx, len);
 		}
diff --git a/kernel/audit.h b/kernel/audit.h
index 958d5b8fc1b3..64498850c52b 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -338,7 +338,7 @@ extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
 
 extern pid_t audit_sig_pid;
 extern kuid_t audit_sig_uid;
-extern u32 audit_sig_sid;
+extern struct lsm_export audit_sig_lsm;
 
 extern int audit_filter(int msgtype, unsigned int listtype);
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 71daead619e5..41f540037a93 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2398,8 +2398,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid(current, &le);
-		lsm_export_secid(&le, &audit_sig_sid);
+		security_task_getsecid(current, &audit_sig_lsm);
 	}
 
 	if (!audit_signals || audit_dummy_context())
-- 
2.19.1

