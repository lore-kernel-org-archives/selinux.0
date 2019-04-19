Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5133C282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FB5217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cfFR5oAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfDSAsk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:40 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:39642 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726759AbfDSAsk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634918; bh=5GP2CrxJNDp2BFUDQ+U49VHnhWLXKi0Sb6zMHU3zI00=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=cfFR5oAwRYBuMHDo16c4QJxZmtDC/aQjSpnczmsp86AxNVrjnLc0Db3pp7s68qMzYYwRSRNOiWrPz9Cx4Stfa1NxSlDt1IMGggMBLO0W+Mesi8aXZhGcci7jApH/jOZajgk5RdncQB1tQoWUnMOJujFp4H1mftC2cb6rQZrcrb6Snm0hf/gIMqThgfm0NS6XuhUl3SNtsIv6Fd1vZAULj0QRIsaKnFhAVs8/gEE4KJj70Nn1jHfJub0YrwQNf3rK7+7XTyH1GBY0swF0+A7axPpnfSqNlIpUaWOhECrMXdOhQ7bB6dhrXeaZhuB22oyggDxWNzq0TL9LRYLX/sJzxA==
X-YMail-OSG: 8LMeScEVM1n.V18L23_YrMgVF1dxFdx6_FRN1ePdj4X5cEkqBogTj13R1M80FfQ
 vwn1DEuTWdWH23CHgixyB0o2L4ZUMw3NfG4Hzf3m.Dv7pwt6LPWNl7DbIH4iZmv8RZkqcUdzVKQ2
 aEFx68t.BHk_e2HiJj.XrU0OuNI0os3ziWk9mk_mKE.15GHruLjbr2liVrZ.W01Ub3p5l2Ikb0dE
 G9FCilb3zD86l9KSlXS4vGf5ILjYL9X35CrcQuz6WhsGyOc.K5IvN2K2SNMs1isH2z93xsYpg7Pt
 _XeqNyaKrIc4g7VQSc3DhNTKyEyHny7lFrU7G8wDNDEKN5dg3q_D.nWJpB8GOaEoWzK_ZPyNtafn
 Fzn0AJKXPw0zK0AD6CK3hIi6R6vqF2uaJ1f4KNb27hxsmQg4x_f.p1Qj8Dxb7dM5xDoJBY69lpoM
 Akj1dv.AzJLnlOVSOi2xWTEfvgkFPEsNYouvjYULh8CEwTjJk9BDU5r0aA3751U8cZn_WTredbVl
 79VFm_DG7CdYoUAmD1hagMoPfPOhjN.gUbZJuqXXDqvmfyny7yWXbBf_TGYai30.eUR21poygU5e
 GmnWtbStZpEveeaAkooY61z4gLL65ugiq0bh7x0Jom4nPiaqoUBvnAGZ7kPM1TvrzPnFqNdOJsuV
 qplMm87xf1lerf8S0e4LTr0yPIKnQjkRaxx3OR6MuSP298dAp5P7_5hFy0oTnxpAFIqmZitEsM80
 L1VcQo3RKETLt5_AZZJxRn7XzNV04iM4RFEfgJLOHt6vfWHyp63kc38NfQgBfOxDLKwOT.MZrbxh
 F7pwIX8OkA9ivwaF_k5XFtQHAn.j8eEWXiyqwx1OJsGio0ySkTUNRkhps7KJoErNydCfqhFnqS7U
 NH.8wbs6hmMtoVC.JVcpJNYWS4j76w5pWgNuaINGxV5ppoKB2AzCJBYG0kt2LbdX1hRhuOP1Evv9
 W5BIdPoNc.i0I51Rn3G8mrJ0ATluejHw_uiOrQoySLHK_95utFkPLJSu4.zyX.xT0vlDWwcIFi1s
 .CWnJ00bw15MoTg4HEw75BGADYi.r8ISgGLi_1zOiMjZ_S.FeVuPeOjzkFbC9mkU83sRtrNc.WdI
 5Q1N8KENpHlSru3cbNI4_TK37Rqqavv0o4Nul.fJGSxmIw7IjNY_v.L3pcM753wkSlF0Z2kfrNub
 DoG5LhoZkLU_4fg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:38 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 828306e040049ab0082b23fbf6722cca;
          Fri, 19 Apr 2019 00:48:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 58/90] LSM: Specify which LSM to display
Date:   Thu, 18 Apr 2019 17:45:45 -0700
Message-Id: <20190419004617.64627-59-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
 security/security.c | 110 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ddef482f1334..7bf70e041315 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "display",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index b05265ec24f0..4af99077572d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -46,7 +46,9 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_task = sizeof(struct lsm_one_hooks),
+};
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -577,6 +579,7 @@ static int lsm_task_alloc(struct task_struct *task)
 	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
 	if (task->security == NULL)
 		return -ENOMEM;
+
 	return 0;
 }
 
@@ -736,7 +739,10 @@ int lsm_superblock_alloc(struct super_block *sb)
 
 #define call_one_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
-	if (lsm_base_one.FUNC.FUNC)				\
+	struct lsm_one_hooks *LOH = current->security;		\
+	if (LOH->FUNC.FUNC)					\
+		RC = LOH->FUNC.FUNC(__VA_ARGS__);		\
+	else if (LOH->lsm == NULL && lsm_base_one.FUNC.FUNC)	\
 		RC = lsm_base_one.FUNC.FUNC(__VA_ARGS__);	\
 	RC;							\
 })
@@ -1569,13 +1575,22 @@ int security_file_open(struct file *file)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
+	struct lsm_one_hooks *odisplay = current->security;
+	struct lsm_one_hooks *ndisplay;
 	int rc = lsm_task_alloc(task);
 
 	if (rc)
 		return rc;
+
 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
 	if (unlikely(rc))
 		security_task_free(task);
+	else if (odisplay) {
+		ndisplay = task->security;
+		if (ndisplay)
+			*ndisplay = *odisplay;
+	}
+
 	return rc;
 }
 
@@ -1945,10 +1960,28 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	struct lsm_one_hooks *loh = current->security;
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
@@ -1958,10 +1991,83 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
+	struct lsm_one_hooks *loh = current->security;
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
2.19.1

