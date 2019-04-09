Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB38C282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F82B2133D
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NnB7R/QS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfDIVlr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:47 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:44454
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbfDIVlq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846099; bh=wkVO2XcNDsJ9+Rl/WTZ53Df7Cu4YQ9uiXt+d9u6c1Uk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=NnB7R/QStkRgUEHNJRY8H7R2ncgOlRj+yzi+TnbwlXpHgMME5igwiiBX+1IjqvfQPAr7BScgpBja9RxUy67s+txSHZ8RhMWceytRdcaGK2D9RF++l4JgZ1UCGlG0BxUGBCRDkRGfX+0HON7zXHLdqbtZu7KtdNPuith7sSKbyfyHK4m7cRw6mcPgm4dOok+KLqF+25NOuwXjga9RCOO4ppiOX/J5vzvo76pEzxhTgsR4bmK79xmGEQglttmfhb5ZcclNH93+zBZY75p0BS9Lv8bJzV2uqU7B3rPWA7iheay3GWO6Fb8M4tLbMseHmzGj/3nrCoi4rv0A5D+gKMfJ9Q==
X-YMail-OSG: nFXl_pkVM1m1NkOiXQsnDAztfqZCPNTYlfgChedFi0S0OiNc.1ncBxVZ1rhoqxI
 Ufmnpxu8nRy3yrYdI9JCCr7.5jcC.7AMwBbTMFl3xifGGY0AG.k9VtJkbfQ09jo8iKIAqC01P6dG
 gvbkmh5bedTYpHFKW4n2rqTTPGjYruGXGZFi3efIRa3Rs9LH6D6dJdbnlmWM7lvK3U7E9_J_nUAT
 N4T.XQGguqYGAUhYpqihXKbeif07RNWtXWK0r85YCLk0QdsV23IilFL.3MvAmTyYoGKomK63X1kM
 WlqDCQqLY09xc9kS9ru.PrXxDf9jJBrkPcmqA8zq5j43ZSWHfW3XQZ5mz8wZVFH_nZuCNBcRaRFO
 wPEiLGMrOhoXz5E0qitgtXnL3h7m.6RtlGNfVjhDqJ.IPymZa4LwuxXnWY4IZmp8KAunyUZt2.SV
 n.vanjNsQMIJDsj_UBb6u5UtgUl7Rj5BtMpsUayfx5zMjB1aPBxD2kcgJUHcRGo.NSX_ddDAoYp.
 CoHEQTD.ZCu7icFH9lFd8SgJdN3iaZaxYXYq4cyG7NnOF1Qv_hcMvvBOc4kddOt7E1KQnRGM_qAv
 p2z05nm32oQUzkmoao1TwgZNW.Zqtj4xyuVu.0FMiVTj0zjDHMIbyADToXYHi1_iGNsbemFvO6xU
 zOk7dFNUtcBlhjNoZdqdlAyBxm807VzaOyksVWMcWmh3NxfneX787l9RCFzWrFDbqUOETma0PGhY
 2HXdFWRjB38xoNiKQVz37UZT496_4sC0uHi8vLDaXCavMZKD0qbcE_jyr9knQBESFMbML.w3vUEl
 1i_94ktSn_ItYKSpEiwXnSvxVW42AYS9agVuJWMfhQHcRoP9iev4UJ54chuwVc6ZbhAlSZ5ryTVH
 rt7QCZdyxhmjU2Hu02y9qY3Dp7zgc.cPpLLCzdRB1X4J4wNv5Sx9lA.knihGVhObgjrvBe32wlZe
 ysk9CBUsp8W7.eWOzP4rvvzwScJEfjDqwBdPkKVCTWafO3pBXlRF_.tSCZHKtESM.lgwEMEFdQlc
 12PwvOrAqi1caYfNSq3XnQhU1kPIba.ah2RKP8QYdK4sQNdoXOrgotDkIq.VEKnk5tSBE2nTKWBX
 qbQgvDYEPdqULCQ3Rk_WsHA.Z8NMC041ACGL_wix7MfrWYWkLwGIvRTldzQMTow--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:37 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3e563602cfa877b5908e791085320721;
          Tue, 09 Apr 2019 21:41:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 58/59] LSM: Specify which LSM to display with /proc/self/attr/display
Date:   Tue,  9 Apr 2019 14:39:45 -0700
Message-Id: <20190409213946.1667-59-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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
index 29149db3f78a..6e304aa796f9 100644
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
@@ -751,7 +755,10 @@ int lsm_superblock_alloc(struct super_block *sb)
 
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
@@ -1617,6 +1624,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 
 void security_cred_free(struct cred *cred)
 {
+	struct lsm_one_hooks *loh;
 	/*
 	 * There is a failure case in prepare_creds() that
 	 * may result in a call here with ->security being NULL.
@@ -1626,26 +1634,44 @@ void security_cred_free(struct cred *cred)
 
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
@@ -1960,10 +1986,28 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
@@ -1973,10 +2017,83 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
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
2.19.1

