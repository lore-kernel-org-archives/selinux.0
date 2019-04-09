Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47680C282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1442A2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DO5u7/67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDIVlc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:32 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:32989
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727042AbfDIVlb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846085; bh=s293PbMAjW22h/8ubCAR0YEDBHbqaLOuUY2hFLr6/0s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=DO5u7/67y38MJVqO9ctbWi7C7ly/jeij8fXqy6Yw0aJBGObY1OpDiVW/Vu1fU/+kSVsxN1xHGNrvgLBIDR4EMFYIhKzDHUd4jUszX4iSQWw7ASc9UkaLxgUU3Q+NK3wQv8w++9XBMVqwlz/71OHNczUFHSw/2xKRMMPGQmgFXJtL0lX6fJLErES7fdyAt3J2azZXSLmxlUFHdpXvZJP79bAdR0jYBVTc32bafwjuVOwjHt27PpnlMhyMHmqShZyJG3297eA6dYEE1P3TPOju1zRdm5j1Lmk/vzIGkkIwVXNT9Rr4haUX4Zp8AHfErKtGRIiTqCi4Ih+GUEuNF5AzuQ==
X-YMail-OSG: FR6yTNkVM1nQIABLJsbzFlrlo6sEkcot9Bq2PxFlnmr8b0NTOBGmmFP2vmmIHdT
 ZK3BMkqwx85jnSi5flhtmPn3cu1x71yGtcxvswtIBXEE4HPixtDCfMraCxYNGrSjN7QnzLtzWkgC
 2YKEscmPgyuOH3DoHap62O8PE6.ukuNjIRCtwZkxkHELvv1MBjeVTve0ePnX4i_Ul49v2il918Ko
 tVHjn4cJrBn7Llwrz_zR_ZjWJYLvw0JBOtPhC9qWbBbog3Y09KxBdW89Mv2NYfZNWNH_d8qW82Cp
 _lASR.2CqyWdUyUSf0FNIJvutrWkoagh6JaUgbaSuN1SDvX73rH6Y.P1EM8p2Vd8ILj72uVo2mtS
 pAyIe..R_NJ2eh5ZoCZ9u8K14noxG1TKbRpswLwFHAOo80Sb9V9f400kRBj2CfG2SYbppBtacRUA
 1hdKUPlZjG8.VkaWwnsTL953ddE5h46qR57NX5vGzzclKi2zrCGFtxR.KHESKrjEOQFhXEXVUufs
 1icM.gn8i01F88ZDkgQyHlZ9OCS0.gqS1UKJPY08BTJjol5RJ4rEiae_MK2VtUV2l_WqLUxm7zcF
 jn3g2nxfteUbsv7RYboLhLgtVOi7leioQIhN4RdIcd57T8qLt5mSx2TMwYzlPZ7jeHyuqUjZ4gYR
 w5W1.PFtCPo5p3iWzyvMnHD..Fhgy3HB9LSNGhHPqlkpma088fUG3C9lm6TumFvWEGt1WeEB.yGD
 tYOK36zAQdcCZjhdvpNHTESYbz2t.Pu_geViaP7biIPLVrj8Ytdt4SUQ6PvnFmIXfVv2r503CT0O
 YPVnKMB_bDsK5XByx2.Sr6ZFjOBiuZ1Zi3.M_nTsFiGEocnVIYI8fWYI9f7SHGbldfBPbFLIUMub
 gbyYm0ZDkAx7X6VS7Bedw5Bb99YRepKG5qmXOGamZ.nKUWWFE32zhHpJp4ma.pi4MiXi2Cg51YNg
 QWWgy5BzU.DsslPMI3yNRuSqGS7HF.AtysRhuCREmXg3GwAJbbIWGYg5OOcgzUEXtB51rcgk_nLu
 85DX5bGFPrxRmnpnnQ_TE1QbsuIFT01PEn0O0ueES1nHjR7XJQ2O7ZE6zD2ztb6WicloWeIAbGkv
 cCmYJn7QYR2t6B56OPdSIFq6NiwAhV2OIcndrwpNfuje53lDQLZ4W4hRwtASsww--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp424.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ef161db9af8fc10234759f56f4c7a0ea;
          Tue, 09 Apr 2019 21:41:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 54/59] kernfs: remove lsm_context scaffolding
Date:   Tue,  9 Apr 2019 14:39:41 -0700
Message-Id: <20190409213946.1667-55-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the parameters to kernfs_node_setsecdata from a
data/length pair to a lsm_context struct as both the function
it calls and the function that calls it want that.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/inode.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 4c7da446d210..d6e25cd7bf21 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -135,20 +135,15 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	return error;
 }
 
-static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
-				  u32 *secdata_len)
+static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs,
+				  struct lsm_context *cp)
 {
-	void *old_secdata;
-	size_t old_secdata_len;
+	struct lsm_context old_context;
 
-	old_secdata = attrs->ia_context.context;
-	old_secdata_len = attrs->ia_context.len;
+	old_context = attrs->ia_context;
+	attrs->ia_context = *cp;
+	*cp = old_context;
 
-	attrs->ia_context.context = *secdata;
-	attrs->ia_context.len = *secdata_len;
-
-	*secdata = old_secdata;
-	*secdata_len = old_secdata_len;
 	return 0;
 }
 
@@ -363,7 +358,7 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
 		return error;
 
 	mutex_lock(&kernfs_mutex);
-	error = kernfs_node_setsecdata(attrs, (void **)&lc.context, &lc.len);
+	error = kernfs_node_setsecdata(attrs, &lc);
 	mutex_unlock(&kernfs_mutex);
 
 	if (lc.context)
-- 
2.19.1

