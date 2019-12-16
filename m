Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C85C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5F521835
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="U7PUFPtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLPWhU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:37:20 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:36447
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726928AbfLPWhU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535838; bh=uQ2URDlGHwivvTFxlkJ4ZmBWhh8fhZMuYTKrwyBZ/Yc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=U7PUFPtqKDWd0UVYQWG9sXW+dS8dYleP+V/l8oXD+kKda9wvPtCdguXi97BKne5qXhC7tPHYZTU6l8Hi6g5v1LYnONSxnMbvcUFjHJqjZM2c9Xi8BdNfO8UPuJo66dxEgDbzuLNE5azJwwWvsROSDMrBXGgenfOmiyv6nIFm5apURQWesIc83+y/itOKblLJ3AlIFaBb5cI6R+j9+XNWIKg1T00c9A2fdRp17VEOCMphdYAEpz22A1OxFQrMo2HFEn2jo7JeO0DCCZDX6J4/wNUMU4ebFxzJnEhBA6utLJgDcmQ9mPTBUWQS2aB+J/CR0esVdxPrP2/M84+SrAkWHw==
X-YMail-OSG: xcPZ3ewVM1lhfAXj_aJro.ATGElX9igq6L0enhA4NyyflCM5UcjsWtB14i.SOaS
 CpeXTMhHgFazUfNWjRXqSMMSX3kqXcIVVpqTIyMVFhQyyRV90OBZWTvdVIt2oeLK0CTWIFgzV58H
 TY_z1Yj54o.vbeonIaFpi2FiToyYUmURV5NeAQGsHSzkorhQYesgmi8qR2Im05v33WbqzNKzghpl
 wPd6NkaZtH9.vlCoKdoe4BA5jek3gIVenRaD4282ksCAt_TGjjZSnRQ2DWlU77VXS5Hjq305OwVf
 HJf_TaWF.FZzuBXHLe8ujG3_X7jqS40R2UvPEC5BtuqNw3GQKU9vill60Fh8cg3YtSfypFpKTtRU
 vNOnbsx2qHfj_CyXUS9KI.8R9elE0IX0_Fg5.28RNMOxj2WRFrMwE_7fPwVa.XRYNmJKeLpUmMQU
 jo_Eoa5i.CbXcs0ri9xg64p3Qvp_JAglXaasuyQ0gcqoiIywSViKHuIWbLhohTs3hVPFleHD0UZp
 DtQh5Wy_CYRkXYYe.ZmZGbEgYIwuV.3uNAfvzoLFyUc5oXAXb0n_vQcVbGX_VIarkhD0jz9G4zhR
 uakVenwHT0WcSv9QBJFd9dXDxaL5xD.CutmJXcK5Yr2eKjWC8OnulkuQXO5sC9lal8BuDpFjkj9Q
 gVlq6JG4fIxAGaMurzeeWRVoWrxFrPUB0K4u_4PvmPFoEHU2KeO08YJj3f7blyJM9lGlvVj567ah
 h.BvupGAgkGW4Fjng6P4YmpJvC1HN4CcwjCaX3T3S83VGx7GOZUq0v4MAp_NUfjyRxAaupZ2afYi
 jF5UxJ8Lwx055OfFz35xr95zPDegX2KKr6eqKBiHG33ZvoLjLJhvUTx9d1lhwhUTUMfopE2Nw3Tz
 KnHagu9DSLW7jkP6fKl8jVS77qPML0CVl9pOuY_K9LoDrl.BeWUW2vcG4wdPGJtktEG8_Xrpa8UD
 SS2pJz.lmaPaA1jU5aHXN0srOnK3HGInXd6wpPdwJxdttKCW1wtfDuK8nlk0IGK._2.lwfTsWVAJ
 Ngbep2QGUVTKmyyHGOsV4tAAhCOZGW8tld5R57pjlhrp08w.tolonbyYm4EpwhDhqCAskNVGlj6A
 KR8ffjsjbiSe5H.iqXgbndeSndG.IpJcZs5NmJJmTzt7s6qzmzb5bcnkEZosAe23_qqwHadv17hl
 Mjwvhlk5QP3i_S9iptXM2yz6IwAE9..5UtBAK8W.q16giNFsMkmuSjjOa906QKvx2q3lNMZ0GjF2
 9Hx1QNXL3m_G6LWt7QbEK9t1eLZd8Fi0Ml3wrDQZpbdNYi0lsdmGwFcvNfV7wVmDVSSQ7kyP.p4R
 3aosX9hZwFnX7DnGv5a1sqxcJacC7m_I8taZazMEEUoM_2Hj3gzR_ot43KRVhgjhFHyMsmFocPkf
 lYrUVt60GeSf_tUZmlEK1m4I8m.TVPacmHK_eR3eHNH9mdFEv1E4wxUSZW0UMuONuZmif
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:37:18 +0000
Received: by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4c6acdb48f29824eb054cd3aa9a6ce09;
          Mon, 16 Dec 2019 22:37:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 10/25] LSM: Use lsmblob in security_inode_getsecid
Date:   Mon, 16 Dec 2019 14:36:06 -0800
Message-Id: <20191216223621.5127-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
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
cc: linux-integrity@vger.kernel.org
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  4 +---
 security/security.c                 | 11 +++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b6d5475f8196..e0acc09a79fe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -409,7 +409,7 @@ int security_inode_killpriv(struct dentry *dentry);
 int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -924,9 +924,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
index cccb681ad081..5752e51883d5 100644
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
index 193ddd55420b..c7d2ea47a326 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -413,7 +413,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
 		struct lsmblob blob;
 
 		if (!rule->lsm[i].rule)
@@ -423,8 +422,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
index c42573958630..66322a2a2beb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1386,9 +1386,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
2.20.1

