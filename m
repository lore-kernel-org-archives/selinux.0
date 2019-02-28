Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A234C10F0B
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8972184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kTkod6nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfB1WUM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:12 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:43158
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729783AbfB1WUG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392405; bh=t41F8yAeWdEONiYDCZmM0kjDJ4tBt5I/NGfNVjC2m+0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kTkod6nuazArdhQmAAMF3Ygv188kQlqpctiV3dJgIrLfFc5KBu3IhrQ+jzKHq2Na1bCBopkKOrGbTM2g25tPh3dNcGHb6IeC192pcauFt4PV6op2bmVKDSt4UPOUfopvL6oCtVRkMklskERw48UFBOqbMP25/KLtHyA3oCkoBA7o2up4RdJSQAxVaw3O9HIQSQfpALi5rFWVFQDlnhy7tnMV0G+V/JJ0J3oMI/kwPabDx/ni+Yo+LjKVDb46Scf8ZnTWtaT8Sqn/rozjGQIIbl3MAG/foUdpraBrvofbjEhen04bBy2rnaye7GdN/7OXK5rHlVZZvsLEos8ChewnSg==
X-YMail-OSG: o58FMNgVM1mgh88wDnk.3W3rDIZEhs8YKd76o2p0xDGCiYftKBz477kLq66s0Y7
 tOweYSORsLufHFuRtgylSb6NWYxs11mC4pniTDSfoW4F_KwnqBUpZrO8l74RyaG8xIi.b7gsjpD.
 0AetP8WfVx5mGtZmmaAeFhrW1eCgXMkDhQs71xaGl9uNMC.3pNYgLfVngEOKF0f0FhPNtkh0b6BU
 OB6gwuEty4GwyNJt2BcC321oGLcxEHIT3vmeUyXZKf5ePTUqeceJcz1ixCz.c9p2ESxgUQ1u9X7v
 iHb8h2d1N9SZb4.Y_C9Rlmvifeo7Uom2ECd8UX1aW.gX.sTCSEL1ydVjLe2UZX8hb3WIU7RhKHkI
 Ac3d0NCotNuvuqFlMhOO4qW0N08PafhZ4X_yPya6sfmvZYNMoR8iydnTipMQr07.DdgYqrBx4wmF
 nchFZ7DSnGYKMEKs6hXQj.JXq9xJVWyO3vGS4NT7lw2NrJ7PQxm8CVSnK8u89jpNRqPqY2kbTwNb
 8fB9IfXtueU3GqyMQvwDQHqUVH_ThbFqDxRV2Hi_mSKABfgj6HczWluh9o_JI6q.5rY4bcAsq0Xm
 i3t7k9LAP.svPSEa2593EoqY9.urK3OQ6Dv8qrChEqLQZtri2zvXOGaDxS1ClUeIU3vB8CAZp14J
 T98pd6eeqt0ouOOfJO7UTuSi6zBayCAPmrXyf7RxAEZjJIL6RGGE8E9gVEueuacdVKqqHeI.DCe6
 uRqHtY7pY2GedQ9l_cDNf8DZMF..5R2V2EVwcx61rvOEchwzbGU9X93udm68pbsdjMB2ruxL38g7
 p8zbe8BHBlJtVVT3LvljjINWpCoLc9eHlO69xaogdTeAApHiOTAV5KpkKJNYBFerkkzd7ROZtjx1
 GNse4jIZz4dtiyjGmejzN8jFSPoOjx75UmUCPJOOeXlPA4tWng657CwLsyfNrM2O6DJFbvUg0Mx3
 z36FeRnibwApt5DSP3a8zAhIolg36XnjUAtCldRYtZZ0T1RNj2dC_jrdBF0TrdYxeKhI0Xr1fjNZ
 1lch8XviCugexx3UmOCq17xL18di6Yfbr4r1qdIWuJlXAuvEfv_st9rcJM.cj3r__wEEcm5N6zey
 wABEo9unbre.Hg0o0s2Ar.BCVBFEo6b8iH7rOGDGPu2Uwy4L3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:05 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5c7d685bea94a92cc9d12c4cc22f1f0e;
          Thu, 28 Feb 2019 22:20:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 29/97] Audit: Change audit_sig_sid to audit_sig_lsm
Date:   Thu, 28 Feb 2019 14:18:25 -0800
Message-Id: <20190228221933.2551-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 87085ff519bf..ae79b24f076d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -90,6 +90,13 @@ static inline void lsm_export_init(struct lsm_export *l)
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
index 4b1fe327145d..f89fc60b34d3 100644
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
@@ -1417,23 +1417,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
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
index 91421679a168..06c732e0f301 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -330,7 +330,7 @@ extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
 
 extern pid_t audit_sig_pid;
 extern kuid_t audit_sig_uid;
-extern u32 audit_sig_sid;
+extern struct lsm_export audit_sig_lsm;
 
 extern int audit_filter(int msgtype, unsigned int listtype);
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8f0748395ae7..c57c2e346c6d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2295,8 +2295,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid(current, &le);
-		lsm_export_secid(&le, &audit_sig_sid);
+		security_task_getsecid(current, &audit_sig_lsm);
 	}
 
 	if (!audit_signals || audit_dummy_context())
-- 
2.17.0

