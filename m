Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04C4C4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901F82184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="f4NNmsTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfB1WU1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:27 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:37575
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731833AbfB1WU1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392425; bh=lPuf/l+w96dL9OLn/Q22XVCX10YN/72ynTjEzrbMVJA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=f4NNmsTij6rpVuqNTUBKrJIA+A/9pf5UmZZHyD2LA5m94wOtYvXdLNHRuKUWxy92Ndy+Era6lRzySMAhQzU2Eg7q9B6L2E8s7WslKUsBnz/ut0LRsnTLDxP4vXe5qBIN0xqS/pHIgQRLAFr9dgEVme7Ieu0NZtJZm4kFuttTI2rctAJf9zq06dG9NVeYkoCdQIo+0Nk6qC1zZqUVSUwGTwORjtaJkr3rX+2aig4L9yPsBz/H/qFC5iPG0ywQlBDdUVmMY3Vdcrj0TDcscN/HRaFil/tFx4HqkQjQwFNAUUr/O8VnjHQ7ftqcUtgBbG1+NVJ7/caOnThA+VLmhDl4ng==
X-YMail-OSG: FrbthSMVM1nSxm6h.woOMAFWTmColLjNC89xk9qZqNxjDcYI1s.V6p5SOY1zkbr
 Ro2YFcvO.KRCzikaF138GqYe1IQ0zBFODEngwubKBdUE4lZmKzJqMVM7eR0.cLIrfjKRByD1ooU1
 YnyvIeqiUeA47TwHCO1wzQt.2zlExtF.IFLFpLz0Nz5nUiqw73p172F4QtPCpN88yqoVLvSnSQkl
 ApueqrS_l8d2SiGccZU4O2q2Gir9zuKJFtjSims3wzptS83XG404X.0fKOrFeKcDCvZnZOOeMaF9
 vd_t5faTuxGYXd4RRlvjnsiX_5gB0Wz0CBAdCM64XrcDMbJvdhKYqpYt3W.FhCjLjWMLLV3W7iv1
 lUeHbAccLuQMc4CIBzTYWGRaNTpka8S4nlJQ01VRX_3VX_mmjATucJDjFRXEVMV5FXdNKacL9fvA
 hT1OaQ0hXa2Ty0VDmrPYRoAhHLS1PHJ7oGd78gSn0R_TtIKe.Yo7BV8HLP_Gro8uOjHtVTpuOiU4
 0931W87z9anEkrHRVuH9aabrvlI1xl0gToXot7cNRrDGkDU2puiPl8twfBFZL7969GzBpDP6t.g5
 CW2S0jXszmjUiEAU1AEo.tr7FVxXiYHRp8TnMH5p1HMkLgInMJAMUdGT2bL__fLUSUy0jDOqQSri
 1rMX1wqmlmNjmnZ7d3hV3tPOoiCC22mui0LG48SsFNn4AR4UuFpeJ0wDSY0filTjgu4.rdccTpwY
 Cau4fzrwVdjQZxqdrkyB7t2qnja30HDW43fBi44Yrvyxf4Ns7dao44Alwn71XQGOMfv7Bwqx5vzt
 Tye7.u2cCms8tPz.Cer7Wgq0GRwXVj4ic5GMNN6ZG8ZlC6cKT4DZh6OVuO0CmNk3VYkFTMA7ugiQ
 t6_Tf5wuoYV.bIUiPa9E.7jr4RWz2tL404pBj9TuivtZ0xPo6IPXn2TA2raukWa394OmJ.QAvWtZ
 5aP0KNmPL1hagBqEC5cJJCRkyhL6skeYDd6goe3XbnYUZkisAX25bEy4UMopQy8.3LOmEPnfEWOO
 s4U4sZWoQc6FboYLeym4LYJP8QihL_Cdz8f4FxUaoI59gOEUm3LEPOMv29dw496f7CSra.6nsHYU
 etV6rHUvuORS8I7mmSoR7au76kTgaBj2tmxtIAgxQh5aqwC4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d90148b291d74b44c78573c559ceeae0;
          Thu, 28 Feb 2019 22:20:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 64/97] LSM: Specify which LSM to display with  /proc/self/attr/display
Date:   Thu, 28 Feb 2019 14:19:00 -0800
Message-Id: <20190228221933.2551-65-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new entry "display" in /proc/.../attr for controlling
which LSM security information is displayed for a process.
The name of an active LSM that supplies hooks for human readable
data may be written to "display" to set the value. The name of
the LSM currently in use can be read from "display".

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/proc/base.c      |   1 +
 security/security.c | 123 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c9d775fd24ef..632ec6b6d3d5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2637,6 +2637,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "display",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index 217fa9d98699..1259b3f50066 100644
--- a/security/security.c
+++ b/security/security.c
@@ -47,9 +47,13 @@ static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
 
-/* Socket blobs include infrastructure managed data */
+/*
+ *	Socket blobs include infrastructure managed data
+ *	Cred blobs include context display instructions
+ */
 static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
 	.lbs_sock = sizeof(struct lsm_export),
+	.lbs_cred = sizeof(struct lsm_one_hooks),
 };
 
 /**
@@ -747,7 +751,10 @@ int lsm_superblock_alloc(struct super_block *sb)
 
 #define call_one_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
-	if (lsm_base_one.FUNC.FUNC)				\
+	struct lsm_one_hooks *LOH = current_cred()->security;	\
+	if (LOH->FUNC.FUNC)					\
+		RC = LOH->FUNC.FUNC(__VA_ARGS__);		\
+	else if (LOH->lsm == NULL && lsm_base_one.FUNC.FUNC)	\
 		RC = lsm_base_one.FUNC.FUNC(__VA_ARGS__);	\
 	RC;							\
 })
@@ -1603,6 +1610,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 
 void security_cred_free(struct cred *cred)
 {
+	struct lsm_one_hooks *loh;
 	/*
 	 * There is a failure case in prepare_creds() that
 	 * may result in a call here with ->security being NULL.
@@ -1612,26 +1620,44 @@ void security_cred_free(struct cred *cred)
 
 	call_void_hook(cred_free, cred);
 
+	loh = cred->security;
+	kfree(loh->lsm);
 	kfree(cred->security);
 	cred->security = NULL;
 }
 
+static int copy_loh(struct lsm_one_hooks *new, struct lsm_one_hooks *old,
+		    gfp_t gfp)
+{
+	*new = *old;
+	if (old->lsm) {
+		new->lsm = kstrdup(old->lsm, gfp);
+		if (unlikely(new->lsm == NULL))
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 {
 	int rc = lsm_cred_alloc(new, gfp);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 
 	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
 	if (unlikely(rc))
 		security_cred_free(new);
+	else
+		rc = copy_loh(new->security, old->security, gfp);
+
 	return rc;
 }
 
 void security_transfer_creds(struct cred *new, const struct cred *old)
 {
 	call_void_hook(cred_transfer, new, old);
+	WARN_ON(copy_loh(new->security, old->security, GFP_KERNEL));
 }
 
 void security_cred_getsecid(const struct cred *c, struct lsm_export *l)
@@ -1946,10 +1972,28 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	struct lsm_one_hooks *loh = current_cred()->security;
+	char *s;
+
+	if (!strcmp(name, "display")) {
+		if (loh->lsm)
+			s = loh->lsm;
+		else if (lsm_base_one.lsm)
+			s = lsm_base_one.lsm;
+		else
+			return -EINVAL;
+
+		*value = kstrdup(s, GFP_KERNEL);
+		if (*value)
+			return strlen(s);
+		return -ENOMEM;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsm))
 			continue;
+		if (lsm == NULL && loh->lsm && strcmp(loh->lsm, hp->lsm))
+			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
 	return -EINVAL;
@@ -1959,10 +2003,83 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
+	struct lsm_one_hooks *loh = current_cred()->security;
+	bool found = false;
+	char *s;
+
+	/*
+	 * End the passed name at a newline.
+	 */
+	s = strnchr(value, size, '\n');
+	if (s)
+		*s = '\0';
+
+	if (!strcmp(name, "display")) {
+		union security_list_options secid_to_secctx;
+		union security_list_options secctx_to_secid;
+		union security_list_options socket_getpeersec_stream;
+
+		if (size == 0 || size >= 100)
+			return -EINVAL;
+
+		secid_to_secctx.secid_to_secctx = NULL;
+		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
+				     list) {
+			if (size >= strlen(hp->lsm) &&
+			    !strncmp(value, hp->lsm, size)) {
+				secid_to_secctx = hp->hook;
+				found = true;
+				break;
+			}
+		}
+		secctx_to_secid.secctx_to_secid = NULL;
+		hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid,
+				     list) {
+			if (size >= strlen(hp->lsm) &&
+			    !strncmp(value, hp->lsm, size)) {
+				secctx_to_secid = hp->hook;
+				found = true;
+				break;
+			}
+		}
+		socket_getpeersec_stream.socket_getpeersec_stream = NULL;
+		hlist_for_each_entry(hp,
+				&security_hook_heads.socket_getpeersec_stream,
+				     list) {
+			if (size >= strlen(hp->lsm) &&
+			    !strncmp(value, hp->lsm, size)) {
+				socket_getpeersec_stream = hp->hook;
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			return -EINVAL;
+
+		/*
+		 * The named lsm is active and supplies one or more
+		 * of the relevant hooks. Switch to it.
+		 */
+		s = kmemdup(value, size + 1, GFP_KERNEL);
+		if (s == NULL)
+			return -ENOMEM;
+		s[size] = '\0';
+
+		if (loh->lsm)
+			kfree(loh->lsm);
+		loh->lsm = s;
+		loh->secid_to_secctx = secid_to_secctx;
+		loh->secctx_to_secid = secctx_to_secid;
+		loh->socket_getpeersec_stream = socket_getpeersec_stream;
+
+		return size;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsm))
 			continue;
+		if (lsm == NULL && loh->lsm && strcmp(loh->lsm, hp->lsm))
+			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
 	return -EINVAL;
-- 
2.17.0

