Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A91EC282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCCD21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BJpwsZVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfDSAtK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:10 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:40971 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbfDSAtK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634948; bh=d5byK4DqcfIbnPzz1tahUCb++vs0/VJdTyNADlEhXIU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=BJpwsZVIvYS9aYB03aAKhjPXSzNKLWdN/On8bVn3ODMBJIKo4BlAcycNsHCtArTR/xQoMGZWfGntxEw0dzOtYNOgTXn7mLCGM51xvfdGvBAoZ0w+kWk3jnEYklec6BMQT+zTi01tqg4+uTSfusU9g33aBju1d8YRs6rx3xnhhd6p4i7abV5+FHmRrIuMO34FhTt6OB9sjGeNvdYjd8l+elJsaG/hi+Rw9SfUsTDH2eJoTVL7/x5rhDp5CwvLhOSFm8rfR9HaoKRh008VuYaq/mxaq4YEXRpNf7CmVRSKIAfZhGmbpwWtlFiciI61F1bJ1ejzDerXCr6sINCvSMl6rg==
X-YMail-OSG: MOU0_ZIVM1kNMn74rzxah3yXPnQ.Fr_ruvhCE5lG1wLRMGWo9qL.aPv9mTEgkSF
 eMauBQEMj10DoiR8hsrcySZJaxNqlnOGK4FG00jIqJhEEfkfxYpxZmHmfXcQIxdjeziHp2dH17Uh
 XymZCnxE53VwSMgNMWBVRFgVsCCx3qprglxMtuTiRCEFp2GrcbM4Y.F0Y_TMmhSlaEyqmohAp8Zf
 QSr.CuZFkOP_N7xvTQ7U1wlWOJ0Az4RgS4mZh_VkQ2p_v2g6wwhfquieEzBpyPTsegwA6SJVyS.c
 IbuMgR7RvvEemDv2FUjISTrVAuE3txP6I.o6HDZybDKz6NqeTLO1SnbM0438EGuwgT5wu1JkdZ5P
 s1Cayvp7s7nuT74QbLimAOQC7unD_na.Hae1_lx2gx.cql3xsrTt2Urv3sw2EdJAjYHxQenbPMp4
 kTBsvqGVpPWmWzliu1K3PT5q3DMmCvg1ACiPvkYhx8L_iCiyBAMcruqq.RPHx_iJYNGBbYPOmdFg
 AcltW2f7V6yiQiZcADz0MsCuuGqYoAOIsYKQtk0ZnvQOqLPvKJxMYfqedg6V2dYmSSOKw_sW69dA
 nuzQBljEVnGvM7r2F6MegmALgb.ryo5e9kCWlG81uNKVwcOPME30Mr.E5wCiJtwuMATMF1aT1PlO
 PYTyoH.xn4e0BzXF.roXuXD04gYMZVVoxRdJoqOQ6LUgEvLIRnGgny3bv1PyIIzD67u7XI6N3wb6
 vL7GIpDndAjx5Q3xCZLZoCP8V7ikA9YrPpto3U6eUjHYgAE9hgNC5a6RsIyTj2wbJhFdRJ9bWFoe
 sKsD26yzz7E_rVB1xenyfwfUtWVyoAJrc0NQGu1QWFn.rhpBpTgE9jveshorbZKgvcK8uQ0VPNNE
 eL.qTGr7LdNmizLemcIs_b65rgDYEdO_cJqzpEoTLmAi0HwrOO2MFNxf3EPRRqu4jM0CQjaFit10
 mSyAekJdM4Oq1ruCMoJ.bpiJKb_VpZda3RsbYNbZ68LzAQMNBZ9C1uA9OPNknQJiYd2KJvBSJIEA
 AGerMHOrlk6LdgUlUXd.J1i3pw4PI7afIl5byFXLAzEwYQ0gXhNGQ4H4TvGAubDAVjyYZyxqTUJy
 H5wzpJwmV1sDkcwpe_luALHl1HkIgkAgbcjQBIrOwUoQ4oF.PEhfioZ6FFdVCeLbCetI6LfAUEMr
 Xxq5rKHA6HS29
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 524225efee00edb3a1e75559f6c5c8ed;
          Fri, 19 Apr 2019 00:49:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 70/90] LSM: Correct handling of ENOSYS in inode_setxattr
Date:   Thu, 18 Apr 2019 17:45:57 -0700
Message-Id: <20190419004617.64627-71-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The usual "bail on fail" behavior of LSM hooks doesn't
work for security_inode_setxattr(). Modules are allowed
to return -ENOSYS if the attribute specifed isn't one
they manage. Fix the code to accomodate this unusal case.
This requires changes to the hooks in SELinux and Smack.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c        | 28 ++++++++++++++--------------
 security/selinux/hooks.c   |  7 ++-----
 security/smack/smack_lsm.c | 10 +++++-----
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/security/security.c b/security/security.c
index 05a19b28e105..f1e2ffe81829 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1341,24 +1341,24 @@ int security_inode_getattr(const struct path *path)
 int security_inode_setxattr(struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
-	int ret;
+	struct security_hook_list *hp;
+	int rc = -ENOSYS;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	/*
-	 * SELinux and Smack integrate the cap call,
-	 * so assume that all LSMs supplying this call do so.
-	 */
-	ret = call_int_hook(inode_setxattr, 1, dentry, name, value, size,
-				flags);
 
-	if (ret == 1)
-		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	ret = ima_inode_setxattr(dentry, name, value, size);
-	if (ret)
-		return ret;
+	hlist_for_each_entry(hp, &security_hook_heads.inode_setxattr, list) {
+		rc = hp->hook.inode_setxattr(dentry, name, value, size, flags);
+		if (rc != -ENOSYS)
+			break;
+	}
+	if (rc == -ENOSYS)
+		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+	if (rc)
+		return rc;
+	rc = ima_inode_setxattr(dentry, name, value, size);
+	if (rc)
+		return rc;
 	return evm_inode_setxattr(dentry, name, value, size);
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index af0d98f4dd37..17ba47f9f4e2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3097,13 +3097,10 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	int rc = 0;
 
 	if (strcmp(name, XATTR_NAME_SELINUX)) {
-		rc = cap_inode_setxattr(dentry, name, value, size, flags);
-		if (rc)
-			return rc;
-
 		/* Not an attribute we recognize, so just check the
 		   ordinary setattr permission. */
-		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+		rc = dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+		return rc ? rc : -ENOSYS;
 	}
 
 	sbsec = selinux_superblock(inode->i_sb);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index d76aa0fc37a4..0e2f68e5b895 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1281,7 +1281,7 @@ static int smack_inode_setxattr(struct dentry *dentry, const char *name,
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
 	} else
-		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+		rc = -ENOSYS;
 
 	if (check_priv && !smack_privileged(CAP_MAC_ADMIN))
 		rc = -EPERM;
@@ -1295,11 +1295,11 @@ static int smack_inode_setxattr(struct dentry *dentry, const char *name,
 			rc = -EINVAL;
 	}
 
-	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
-	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
-
 	if (rc == 0) {
-		rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
+		smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+		smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+		rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)),
+				MAY_WRITE, &ad);
 		rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
 	}
 
-- 
2.19.1

