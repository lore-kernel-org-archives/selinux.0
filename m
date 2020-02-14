Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51A8C35242
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6441324649
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="q5HqUqDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgBNXnz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:43:55 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:36699
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727979AbgBNXnz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723833; bh=u6fnRIvxVpCx3zktmvDIcWNsrnFJMt9iY6RLJaZIX6E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=q5HqUqDNbK6cz6Wlo2XbDZ3Ox/xArDa/Z559sTIrmls8mkHu7QFap1jNoc9nkDc1EJya2b9k/H29MtdYgTgpDgoabGKdsyOCycgR7chRrToKhRh7wJjNLlJr5CWm82uKmPxSAAzr7YPKeshqodfTth0MG1wR3rzP6tqm+RNKaf6lHQehAlic19ncMrllmSptJO0ztQJnxodKBP0qa8FIZgRLDOwweTCTXuPQQnimpuSVH3RxAZ/Wmw8Y6mV9WtEVaCGy0nY/GKN/EIAv+Xz1UdYM88X0O2TOAqZzD2VGw+K9xy+MbnNgh30XgNx0rq75MJ2lLQ8H3keC3Lg2uUkSTQ==
X-YMail-OSG: .3DRc4IVM1mi1c3bGpIAHaW3iGLb_5ugykLV93EwDabrjxmyMYxq725Tyzw8DtQ
 eZXURHjjQeqnRw.vlTZYXBxpsKjKPnlNpWGVQjecwhuvcT9clSgZRexbWM6ft.MdFa_uherGZSoV
 2e7IlmaeIPjQWFs2hztcCw_GPumsE.ckJsThig3nPagFDbth4tN.Xq39Iac8uECrK0zsP.hBMuyR
 ijCzN_mBQRMuJg.Gn3MjrRWbish0DsnEov1tDSMhNOVRihNXj9EChxoh9IiNt5xx7q70oj2zzDTg
 6GgpKmiuKJrkdycetxxHV3BaFFOTzQv2z2fc0CrJLgRklDvLEZzYwsJ.ZJsPQnkbArl0kT1HvYX_
 8hhirc27C5Dr6KZaN4RyU2HtdQHvraHIQJdgWniQUYfmBmUetbn9VjPVzLiBdb_t.UrVWA2RMtj3
 5mrRZRiNdJeyTyG45GcznWx2sl5wnvsPkIUhH5LuO3JvKdivXAkGcGN3WOjS.St50KzDphvBFcBt
 T2JjQ6Z9eW7x4PS5XF6yT5EPrLcoSVrYZbA3GuV_2JctvP1y3yGR2H08H6ePpVuMpHm6h5J2DhPL
 UGr0l74iKNOouhi5VwnMXJD9mY90platm4mBABF4jrNIUQuijPcvZA4zyyLq5x6xuGKkdMFTPqH0
 jyNhXijqT7WfKJpEU2h0eR4DT8Pcs7rE6DdV6b9Kw6caj5m6IJL2m9MmgU7QXwW_bkJNPIV4YlX9
 W2YeV_BVz9KNw48gZeOYJAUzmbo1ncjqaMZ1Q5k6Uvz8QU4qGotiJMdTiyRgRSuur_huU.hOXyb9
 coMWK7l_Rm9bhAFYfnpunCZ9BeNWIxuymPR30ctb4y2HaWJ5dxJ9mj6GyPhc08Yn6ln8fpOAFesb
 yIZ38wPwC9IF2UI.OOSzjGQvTllTm2Ft2U0IxxVvTJQTvThmG0V6jioRtdzKcEt5lO0B6dIVHeIw
 5hYq4JbuPiNM_BuJsMnteZLKxh0HQxJQrzqN.D2aQC4PCYwX81LPUdTw7zmhZd_s7weMQpPuqsKE
 7EYRP5MbvKWcYSMhCGhiegeY0fTHBSypKF1juAt2ak4OHda.WJ1Y8rIefwJkWqfrviOpDxNHFKYJ
 KbVtDNUDk92WpSvzUF1WxHJIO83SvUUPsBPPuBkSz5460WwmgFRpTWpoIalAx4HC2C92vff_FHgs
 2kayar97DXu.Y9L6KqhUAKzYcycPVHpOSA7ggNmpmZ0Tr41eQ1y4ZaKUXYJZmhJSTviITaNGsVul
 Q9P0n.G6pp_n4RtGXZwkl__ZXwORJljbipcsvR2qbw7AgVX5dj9008_2bhBTISGIOeW6NnKzHxY.
 _pcccu.MFliqv.jjvCiXT0BGKy_OwvpTOvAhhNlyFi7IIPgKUbM2rNRH4J1KkBvhQ6b4Sq5z8Tos
 GgelXt.sJ_67rKRWqYVRSS75RZY2PFfD4tdjGQmTwNwfFoX2njWRg8_Yfke7BDWb68fVYM.Xgfis
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:43:53 +0000
Received: by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 57fdd4c7e447fc43d9116acb36d9c5de;
          Fri, 14 Feb 2020 23:43:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 10/23] LSM: Use lsmblob in security_inode_getsecid
Date:   Fri, 14 Feb 2020 15:41:50 -0800
Message-Id: <20200214234203.7086-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_inode_getsecid() interface to fill in a
lsmblob structure instead of a u32 secid. This allows for its
callers to gather data from all registered LSMs. Data is provided
for IMA and audit.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b5ffb2286bcf..62e095c34bcf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -411,7 +411,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -926,9 +926,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getsecid(struct inode *inode,
+					   struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 3e5ccb7a46d1..b55e66c2451d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1931,13 +1931,17 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
+	struct lsmblob blob;
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
+	security_inode_getsecid(inode, &blob);
+	/* scaffolding until osid is updated */
+	name->osid = blob.secid[0];
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ad48b7b60cff..5c3270050dd8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -475,7 +475,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob blob;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
@@ -488,8 +487,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			lsmblob_init(&blob, osid);
+			security_inode_getsecid(inode, &blob);
 			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
diff --git a/security/security.c b/security/security.c
index 85cdd24abcd6..116800662a0f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1418,9 +1418,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.inode_getsecid(inode, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
-- 
2.24.1

