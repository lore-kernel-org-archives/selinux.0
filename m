Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D677C433FF
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C6F217D9
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CW2xbmvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbfHGWnI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:08 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:43183
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389465AbfHGWnF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217784; bh=evHJC9ncZObZWsdV91mJQaWQp4N06lnEHXTrDE9oCuc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=CW2xbmvbhlYyynwAUK1ud2SAar7PCSAPO44543smpShkW6n0HQlgwksf2rqFieVfJqQTHLo1uIXewB98ff+50kNXkzR0IS80JND6yZ5II22nvrvorZQZMvLwFq1dbsidvl9JcetX+6M2CfJsAr5RnWbBlJ2RJvkHRamh3OfWRblIeICt1TfYxSd8wxnqbzDrNH9ClUoSopoO6Wis2TFFsaBnhJ+dq6P61NKsW7BsqJxLLDAtochVz5F3eynBPVRBzISfyIbWucx/hwuPscIjh43erYIgULsL9vdTSClvA0o08KVuyMwC3MtJ2eB3nmekCc4GJH9SY30ixrjTT7gkgg==
X-YMail-OSG: tMsMKFEVM1lz3O0wuaHoBI5w4.BNw1iRowAqdMqTOt5y.HeKcxkFbdh7M_jHM6R
 y4CYDhyuzf4u8HKE2PmRj7v33JkO0nGHBRZeWjvikjwXo6UOrhNt2QVMasMfzgAFdcalmSzqJpPJ
 loXWWHHIOUEbKBaTW1AK6iSTVURYYl92w351TvnTx34v_fA3uKyS5hGQUFYmxon8Tuiaxg7NNyDq
 fptE8jgt5Lhrb70a1mzpQig3Ysfk.o5jquYiJPsvJ2enUqaMLonCcmGc7yrIE3BKPjFgYA4hC6hI
 E5HjFNYLmT81BhzC_F12ThMWMSeOBZ4LGNxWG_DOyO.tNEDDlGKNCUB_Hnit3XHhgCDo_.t6Sy5q
 nWGLM2DGwGI6pnk_Viri7c9P87MCvNQMVOd_fNQsY_EPY0ZvsSnF2sKNfRfqlokStGRzqD0BCJIN
 WQLlBoWP09M4Y.VW.oXmoVXhGNeIr.Of.gS81aTSAmkVh570DKZPbrpWdHThBl9FOH2aNSYQUDZ1
 EbyFjTFIs85jBIKVA1Q8Vg08_7HLTfqkjMND8h3OoehZY.8YeDDgC8inWRDmlVU_zXNdeRtRR.eP
 UQj8CuUZ.xztACr3cL5kty.9ssXf8madAV3.yPBwrOudJMRz6yXbKuGzF2DLEusQ7zASFbXs0iUM
 VCXAb6goQVAKYiBwgIu5ksbbBca2.4A5zELaWr78GL39rCWcvPfGOGTBKQhHTNuVe.uD73Wn1pdK
 jDNhVWGeUVUyPcEU88EWWfZVxenEcTZoTbDQeAlo2Z6U2II9_V5f09bZFpK_0Si2vubLBk_DkAhy
 HtSEsIPmLf1KDBe81yGIQFA6qczGGpEZFqPZYiirPB1mMIl_mTReKyrSLKOCsN_3jCgRF9Ra5x.L
 HPnUjEFNJwDLi9zcvRfj3Br1dJj9._A91azrAC6DJpxY.tdzADzn1qI.lnx8ynB31HudBAoRNfD7
 JrFLKZmQDsVCtmuqCVx4QvmLFfyAayGuiCqdQeV.a50unU7IVR_lDnEvSLAKFKAFlcj_874Xmqw0
 1sx5QIGWn7ntrMJMc6zCQabOYvBrMN_RQbTX.b33aKRZmpPwrEKGd5lpo9HgerfQYBaHRnoBLxXe
 0kosn8W1ovcgD0zUKwNJk9yRuzTsVILPRsVcz_mqkpdt85bfLM3YAWGumc.U.sD00_KzznT0BvTR
 JWI7WL52eRBj6HAWlPeu6brk25X7K2zCikMzE9z56raM_tNqk4p2P.LhCNvtE.llxbDxrilvlrKY
 Svy2HQq3dr0pAgWpI7wVw7W2sxKdRmUXwFHjVzMqqRjbvin2N4_WoCXZqMHDpzgM2B6IrYGiQTjS
 uoWnn
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:04 +0000
Received: by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a922c1f55dc5f6c930e3c4333b468534;
          Wed, 07 Aug 2019 22:43:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 07/16] LSM: Correct handling of ENOSYS in inode_setxattr
Date:   Wed,  7 Aug 2019 15:42:36 -0700
Message-Id: <20190807224245.10798-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index c71ddae6760e..e3ea48c87dba 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1397,24 +1397,24 @@ int security_inode_getattr(const struct path *path)
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
index 5e7d61754798..021694b4aca7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3125,13 +3125,10 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
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
index 341a9927ed5c..f253d569dee6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1264,7 +1264,7 @@ static int smack_inode_setxattr(struct dentry *dentry, const char *name,
 		    strncmp(value, TRANS_TRUE, TRANS_TRUE_SIZE) != 0)
 			rc = -EINVAL;
 	} else
-		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+		rc = -ENOSYS;
 
 	if (check_priv && !smack_privileged(CAP_MAC_ADMIN))
 		rc = -EPERM;
@@ -1278,11 +1278,11 @@ static int smack_inode_setxattr(struct dentry *dentry, const char *name,
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
2.20.1

