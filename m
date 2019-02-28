Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D6C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED64206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tLbxfkwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfB1WoP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:15 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:35644 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727988AbfB1WoP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393853; bh=zCU06QfSnWUvOOQIGdDJQHUV0K+IFLQD3JU4exaaZTU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=tLbxfkwk2AtEcjygfcW+cDEPW6rsafDwz4kcKZlJZcjWo+7Le/5+mP6IytF+uHqPRyH9YuhkwJDfGqr8xHEKOFEgkjdGyL5ByEn5meewq/0EtFiy537rX5GAIWGH5miEN+AdH+ti/53V1Xy/yVSVdlaMoU8qElv8JBVlENrGn6zXzHE3lyqiI509H9wPwF3EdIEIVVi+auMDECH/LxakT6Svk0BZ9kf+xtFTpJWSAzipkRvHdIcHx4nKzVHhYI9oKp/1Q7PnWedy3gKcTjRutwUdSxruKRKOrvJM954SB7mTu3fHcBG9Qf5hUEv+Hu2kwlX1rb1RDppcBnMtXj0kOA==
X-YMail-OSG: 159ctkEVM1m4ULjRGYenhBlV1dKq5NLmo6jZqkudgpMZyVhq18J5KCnQTgWtVnL
 dDQ5dYie0uep73iaRa1uRPPDz7lIMt7qRvmS1FNQbonM6_6FBC4BTh1nY3N.5osPuDaC9udnPZPj
 n2j0gODITVdRnz2vBPDqr7I_WgFAyix9kvQuxhwvlPfilEp1twpXOeTY_9OPHYalHuCCRRg6R3b9
 O5ZPQK7PoeJwdt0H64.7Xq4BTCQmt92ZnVZE5c8nYLm6jRQVPxuELNcodPx3SfFDJBB40zizHOoM
 y_173FMNZbBgExjNFRgJmFH8DDQEhPGeYIaWcFD4F_FT27m8JpttknzKhUrZdCXbJtcpbW7WN.5L
 Iodm8DH_GtF4Wt.2dQIj001J1WMn4_DwDkKCdhgQ..Xe8KWVBMsoaKgr3XAutPz3Yhs3df8g.sZc
 Fyza.yymkwo0vCfLCV.9Dup0n.LAHlFkKhRcfCfVaNFFMBPjU1CoHnJnS8OcCFDet_7dzGr0nkSW
 irKg.4Yy8e1lFLhC07bHbfV.bnXPQSDH9FIbaTpkNjQiSFbr1wDa9igRSrVnXoAGE_Np4iX8dpiJ
 I420DcztfgB7XMraHWst.DnZfQ.g4XO9srgU9_fOyWPrpZd7CZKYl55vze4TBBtnF3P3sfE1Syoy
 nt281jfsNmCnZnN3Q2nsZm2DG43og9BvENHhSHwZC1FOwFwS47DCFlTzn4rswJnG7ngnfvfUHg75
 ivDNytZypcSTQfIGcZ8Vr62xutWT0a4pT.ZfWlS7IkyOxzWxzY1AyNJQgwVHCA0wWh0RtYX0ewkt
 Bp1pQjoSMyWNc9MSS33PS.tgwQLdo5nxxTghSLO.WK32QAIsDG8csK3FQOV_pX7sFTj0KjdLpUib
 1VEwmmBIuzn9o27n3WFFBmi8gK.GfgUutHhRxX_Zl8hEzbJvwwLj3LfFtos5IqcZmMeEGxcswB47
 qZo5ynI1lMYsxdqzLRMBq4Ks.JOjo.CnDxsAD5ojB1Tg5AR6IBVY0_kY9O5ynfCJgIWY17zN068P
 vG3JJfxZroUaUpJ9umjXfNsTa0oSSSNWacNTgyAzdN63mJF7mGMhxLr0JyrGGMuJEoiWLzAJ_ymm
 9fcJ7lKQH85hkEsf9.EyKjsfO5ViZGCJSR.dYH5RE0f72TXAMZrxGBEk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:13 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 731ec5e129ec3fdeedd3a533970a7e62;
          Thu, 28 Feb 2019 22:44:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 77/97] LSM: Correct handling of ENOSYS in inode_setxattr
Date:   Thu, 28 Feb 2019 14:43:36 -0800
Message-Id: <20190228224356.2608-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
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
index bb0eea873a7e..105b5ee22bcf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1343,24 +1343,24 @@ int security_inode_getattr(const struct path *path)
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
index f58c96e2b6c1..501aed18f100 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2998,13 +2998,10 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
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
index c45e2dc3f959..c84c71a31b80 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1194,7 +1194,7 @@ static int smack_inode_setxattr(struct dentry *dentry, const char *name,
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
 	} else
-		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+		rc = -ENOSYS;
 
 	if (check_priv && !smack_privileged(CAP_MAC_ADMIN))
 		rc = -EPERM;
@@ -1208,11 +1208,11 @@ static int smack_inode_setxattr(struct dentry *dentry, const char *name,
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
2.17.0

