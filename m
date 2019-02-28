Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C62C10F09
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F479206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EtenEfHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfB1WoQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:16 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:37984 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728438AbfB1WoP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393853; bh=dTAYj+IK39gdMMwT3fRNtH6BcvhJsD291Guvs8GW0sU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=EtenEfHE/P/Og+PfebECs6XqThIVdsafi/9nqtsA2b+miU/lymdsMuOyw2LMPlKlBda/INa+zrmYTioZmzFIX+HoTB7qzPmnkrCqwAvU8VrVvz54mrTxUJMzbt8YTM0GOyBfnBY/uY4N7QCKxZ98jrsnFnXAQSsKrR+etkqKRHP8JJjR3uh0kip74Knds6K5MpqRhTODMrzONnhn1oQB+o3J26VJysR7fmmPpMdTdbn384AhbG4zaH0WO7YXiYYYuY9DsAt7u6aUSYu9n+vLn8jJGu2wo0Im2zabLHljJHuBBupTxeLo/YKKFdVqp0YpXcj3gHBEm+TpfBHQsdtgdQ==
X-YMail-OSG: s8TE8eQVM1l2WwXyVfNGH.5L047n_523bp_R9U6e.xm6T18opYOlntdh0ezATFa
 w69uPOKlFUvQaKA1XJEND406xgaM0TklWM8ExzrsDeJ.McrwzdBCOUTN.PIVYfMag2hXZC0T3yF8
 4Cr9.Pjab.SmuoxrF8iLea.N5nwuDqUoB2OxyQWze_I3hv2apcRPcGCCUOQz1HJVmxXzSWd00IPG
 9SgkJ9dGCLpmqP0WpX94D9JE0GzXYEX0qnocWD_YK7UzZeUpnck.peZTu1uG5Z6GhxFDpussx.XQ
 zKRmXzPG8om.QxpxCcW1tzgqTlAjQ2ml6mQ9Y84K.AElNTfkOgWpnxl5MTEWqLv3d7PRWLjwpLF3
 Pjts4JGrCPRTNcHt5.Jm7.0EOITCcmolM8b27eDNJI3wFm9TK69iSorw6DvLBDuSP4sl4B7UcSZA
 E68IrpsT3PfQ3gCJuBWIpk9jDL_dE1eFvzcHRfjDq2LdZepOEil9I8RozMOmNOJcKE06OolbKk4x
 7ewkZcJFno78ozpHH3zMslXJgwr0rsz6NsdV74.GxSuOwgv0QnvCjNVmtuSKf2.1Vz7x_bb1p1Hn
 vMzXo8XjEdlix8rVGm66CysJoGWRSVZIeOvRnLjnlTna_CAA12Z421dE22uTeA5_rf4SjG_qq5IL
 McmCa1hg.LKErmcqerIK_RqBSTyBBpZslSVCwRbE1m5AGFtCW0wm8SmE6hwYXImIO3SbVfEoAoN0
 5jG.iZJFO1PYowJc1BPb7gyMxPXzRGiNHzJlHs5rvjGrNCc9ZaVQ1zmwfbgjT_4k_h2L5ioDyWit
 w8PZUaGJy7HS4D0c3EhRlV0GBSCuNDgOtizhcgwR2SnQQj7zR6tfpZOlhz2p42K1Pzxpgc8uJh41
 _PTBBpR7HUb2q2MtNX2TG4EEKxBDPC_nodRsWdOfSJb2qxl327NplF6mYx1DVl704P_7grfnFmrm
 fADtlGzkH1uJQ0aIg7g_fUdc.AtRDaGh3GmHXmwTjV4Fpt.dBTnHPqYBIJzAO.MQCavOIy5VXV3T
 kDA65u6dVIF0AbPTYQm45yFqwlfd.SGLriHk0ch_OrhtSrz.2oH._xns6VT1GNMVGCajQ_ggniha
 AAiV09B6hgmcLictCKuoMruSyQqPZnho6Z.RuN79QLQI2RAaZoU57gLSZ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:13 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 731ec5e129ec3fdeedd3a533970a7e62;
          Thu, 28 Feb 2019 22:44:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 75/97] LSM: Support multiple LSMs using inode_init_security
Date:   Thu, 28 Feb 2019 14:43:34 -0800
Message-Id: <20190228224356.2608-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Refactor security_inode_init_security() so that it can
do the integrity processing for more than one LSM.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 48 +++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/security/security.c b/security/security.c
index 66bc1a580d48..16ff98c86414 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1066,9 +1066,10 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
-	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
-	struct xattr *lsm_xattr, *evm_xattr, *xattr;
-	int ret;
+	struct security_hook_list *p;
+	struct xattr *repo;
+	int rc;
+	int i;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
@@ -1076,24 +1077,33 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!initxattrs)
 		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
 				     dir, qstr, NULL, NULL, NULL);
-	memset(new_xattrs, 0, sizeof(new_xattrs));
-	lsm_xattr = new_xattrs;
-	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-						&lsm_xattr->name,
-						&lsm_xattr->value,
-						&lsm_xattr->value_len);
-	if (ret)
-		goto out;
 
-	evm_xattr = lsm_xattr + 1;
-	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
-	if (ret)
-		goto out;
-	ret = initxattrs(inode, new_xattrs, fs_data);
+	repo = kzalloc((LSM_COUNT * 2) * sizeof(*repo), GFP_NOFS);
+	if (repo == NULL)
+		return -ENOMEM;
+
+	i = 0;
+	rc = -EOPNOTSUPP;
+	hlist_for_each_entry(p, &security_hook_heads.inode_init_security,
+			     list) {
+		rc = p->hook.inode_init_security(inode, dir, qstr,
+						 &repo[i].name, &repo[i].value,
+						 &repo[i].value_len);
+		if (rc)
+			goto out;
+
+		rc = evm_inode_init_security(inode, &repo[i], &repo[i + 1]);
+		if (rc)
+			goto out;
+
+		i += 2;
+	}
+	rc = initxattrs(inode, repo, fs_data);
 out:
-	for (xattr = new_xattrs; xattr->value != NULL; xattr++)
-		kfree(xattr->value);
-	return (ret == -EOPNOTSUPP) ? 0 : ret;
+	for (i-- ; i >= 0; i--)
+		kfree(repo[i].value);
+	kfree(repo);
+	return (rc == -EOPNOTSUPP) ? 0 : rc;
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
-- 
2.17.0

