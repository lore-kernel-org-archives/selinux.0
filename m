Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F677C6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C4820672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="enHTj/9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C4820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeLKWpf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:45:35 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:37620
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbeLKWn4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568235; bh=OVmMPLMFIEQe7/xmXls0TKHgNoRAVpp7J85y53TwffI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=enHTj/9YELtIFEzwY3nxBncHZgDFGrJQ+s5H3kJSe8sX3IPdfgsbJ8gArf73UANTE21WKG3/pIw9tIXhCg8PeC2zaPau4x0lTXCHgGB6xiG7PVb7zFNGCuehgm/AIymNgn+Y8TC9/LVENDdjDj/A2UNeDMDwTIGJMH6cXkJrXfZm2/GLWvGV5K5JTso/6DxiC1KTyrecah79+K1XZfKrCSEtv/WPjf6WzHJ5c5aJbnQOPv+OpNkqj3WCZ2MhtXimuyHtZyCe1xXcxJq2091u15SgcqadG247BkX9B2C4PUG1ijt59tcpSusqiRvYNVk0uY9fy37FMjQcWB0AVHhPNA==
X-YMail-OSG: phSwpIkVM1mrZPZppe1tOr8Uo.5TJPiS1o1EmiL.gu0.owdo9SApHQHNUehHmXg
 hkzutMBOO3.upVX8SidomT5WFsnQ2eUKH3NPGNjM0EVRvrwZmrobU6vdKIWJfCmtWOV50GubAxAX
 CyYgHkn5k5qkTva1MHa3Fnredlg70FMxktrJ4cOO3Dw430zuxDwgF4DCWU._5QVQyNIziurJnks6
 g4fmI6WKfYLvBs76Bd9CXbuFtuqfyHIxio4BLy1uxaeCiTxL6oaDdBSXt6.R0i.rpJrlKH6DMKdx
 T1C8f2jVrI3xijpDj4Be4yj63vFs9X5yxZYquAloyxy20Bj6L3VS1KPEa6ThWsDeGZQuOHrHA7le
 gznCpQ9R1Y2ku0SVV9x9p5tzqPtzhfWUtqAWj5kQp2DWmpOhG6t1u.6SCbdRh0m6EatcqLp3gB6J
 BMezrONMSqMUHdARqrisvorLKHdfGpsxfICCW3HbkExmcGUnYkk6GT7vEWJlHBA_vO55ngmGiLsp
 Br1AWsNNJjVx8JAtN66awt2cJZxSlKVUO0jWxJkI7zZFcYTq7eKJL9u9AZ0l8M22LdLj9iaWVl5X
 DhyijW_dch5hfUR.rMI8auY9VaAqg6Y4eTPJe.jv1c4lM3LodNo62.xutQlvmXSG2H6tXeobX6rD
 TtTrvAnzkyy8owau.yzgjI6O8Qo5gb748M3d.5S8zcsAldtdwH5Y5FdfXCuY0beDCcYiXrCgOuGv
 RvZ1OruXnEaySp93e0ND_zKOBfG5UAKYyo9A5ML4zFzv8W_L7z966.iULDvnohPXTNZ4Kp5h4TCJ
 iKkHbqGU7aLdKyLW9_J_v2kaKDAglNMDa30ozHcMOMi68hann0qUPV_YpUvITkJYNIVz2HtX_I4_
 eFBJXE55Qt8JUCto4F9zkalwL_sLvLjPeGbdBzz9QitS8LCTB1.D9ngEJidG3cEWSTJH9zOWJnFO
 EKAE0BQeCe0KoHusNVnsYMdiWwCqUALbq1vIBfb_QIY3fG2bMEKSy5dmoxVJCcoKDDgTvWni9_xS
 zO3y0NTWzSccb59AI36_mB7Z4paNduLA7P0h.DUUFh5UJ0xkLIrJ8Ql4OSC4u1YphhNV0PIqI1WQ
 5BehD6RDMXulRalwzyodBDccfstDqoxHuR.vwsQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f4847c15ff2a33ea2e557120f9f24e5;
          Tue, 11 Dec 2018 22:43:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 25/38] AppArmor: Abstract use of cred security blob
Date:   Tue, 11 Dec 2018 14:43:01 -0800
Message-Id: <20181211224314.22412-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Don't use the cred->security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[kees: adjusted for ordered init series]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/apparmor/domain.c       |  2 +-
 security/apparmor/include/cred.h | 16 +++++++++++++++-
 security/apparmor/lsm.c          | 10 +++++-----
 security/apparmor/task.c         |  6 +++---
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 08c88de0ffda..726910bba84b 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -975,7 +975,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 	}
 	aa_put_label(cred_label(bprm->cred));
 	/* transfer reference, released when cred is freed */
-	cred_label(bprm->cred) = new;
+	set_cred_label(bprm->cred, new);
 
 done:
 	aa_put_label(label);
diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index 265ae6641a06..a757370f2a0c 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -23,8 +23,22 @@
 #include "policy_ns.h"
 #include "task.h"
 
-#define cred_label(X) ((X)->security)
+static inline struct aa_label *cred_label(const struct cred *cred)
+{
+	struct aa_label **blob = cred->security;
+
+	AA_BUG(!blob);
+	return *blob;
+}
 
+static inline void set_cred_label(const struct cred *cred,
+				  struct aa_label *label)
+{
+	struct aa_label **blob = cred->security;
+
+	AA_BUG(!blob);
+	*blob = label;
+}
 
 /**
  * aa_cred_raw_label - obtain cred's label
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e8b40008d58c..803ec0a63d87 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -59,7 +59,7 @@ DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
 static void apparmor_cred_free(struct cred *cred)
 {
 	aa_put_label(cred_label(cred));
-	cred_label(cred) = NULL;
+	set_cred_label(cred, NULL);
 }
 
 /*
@@ -67,7 +67,7 @@ static void apparmor_cred_free(struct cred *cred)
  */
 static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
-	cred_label(cred) = NULL;
+	set_cred_label(cred, NULL);
 	return 0;
 }
 
@@ -77,7 +77,7 @@ static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
 				 gfp_t gfp)
 {
-	cred_label(new) = aa_get_newest_label(cred_label(old));
+	set_cred_label(new, aa_get_newest_label(cred_label(old)));
 	return 0;
 }
 
@@ -86,7 +86,7 @@ static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void apparmor_cred_transfer(struct cred *new, const struct cred *old)
 {
-	cred_label(new) = aa_get_newest_label(cred_label(old));
+	set_cred_label(new, aa_get_newest_label(cred_label(old)));
 }
 
 static void apparmor_task_free(struct task_struct *task)
@@ -1484,7 +1484,7 @@ static int __init set_init_ctx(void)
 	if (!ctx)
 		return -ENOMEM;
 
-	cred_label(cred) = aa_get_label(ns_unconfined(root_ns));
+	set_cred_label(cred, aa_get_label(ns_unconfined(root_ns)));
 	task_ctx(current) = ctx;
 
 	return 0;
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index c6b78a14da91..4551110f0496 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -81,7 +81,7 @@ int aa_replace_current_label(struct aa_label *label)
 	 */
 	aa_get_label(label);
 	aa_put_label(cred_label(new));
-	cred_label(new) = label;
+	set_cred_label(new, label);
 
 	commit_creds(new);
 	return 0;
@@ -138,7 +138,7 @@ int aa_set_current_hat(struct aa_label *label, u64 token)
 		return -EACCES;
 	}
 
-	cred_label(new) = aa_get_newest_label(label);
+	set_cred_label(new, aa_get_newest_label(label));
 	/* clear exec on switching context */
 	aa_put_label(ctx->onexec);
 	ctx->onexec = NULL;
@@ -172,7 +172,7 @@ int aa_restore_previous_label(u64 token)
 		return -ENOMEM;
 
 	aa_put_label(cred_label(new));
-	cred_label(new) = aa_get_newest_label(ctx->previous);
+	set_cred_label(new, aa_get_newest_label(ctx->previous));
 	AA_BUG(!cred_label(new));
 	/* clear exec && prev information when restoring to previous context */
 	aa_clear_task_ctx_trans(ctx);
-- 
2.14.5

