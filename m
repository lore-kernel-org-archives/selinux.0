Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B10EC282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5732B21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NIAaceYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfDSAtN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:13 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:36094 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727075AbfDSAtL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634950; bh=XgvZ3rj387jRjl/mTxiiNwjJyuYQ67qm2e5z9K9Qfis=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=NIAaceYRZuG1Bb1pZ40MysyMH/6hvvgPHX6MMA5yY9dMSfbnFgXW/Mral9I+eT/Ks9rcCvge+qMUTJOMWHMRPUpdTeVbTgOT+UPZwQb4bCa7lwAGhY/IzXbRaKMkU7hmLkAxx9hqKa2MyeymTJJ8Rv7vPTOHyBKv8sfDGRIg+3yBegBU75O5PthXtPJdvVfgK/18/YOTdNO5WXiTdlg0LsRZFCkKOdfP8Yc0+NuRJZ8gQGczIfHemPmbMg1egJejCxKd6Jk/Hy8En1As0t7m851bTsm3For+hpZ22xCGxP+7QacSMW7oZmP9FgdBw8tyF7wE5bz33vTHEQwVpgXbjw==
X-YMail-OSG: UCEo2GQVM1kc2pf3KtfEYPnj9xYYlnK2hjhZPqRtnNRLzwxNkAorR59Ma82e2V2
 9KCB2k2A6upDFQJ2DppKQIbL6QFG.8ddibkHciDoEk5WYOtbYlA8nNKQe1StHt7ksAWLopj9Lhv1
 wX6f.JrY1CwXA3w2EDSh2A9B1vRBz9nxECqQQSgy7sgohZT5uDstcJt4fx1anuvL.VZyTsTtrBPA
 YqVF7ce1i5bX6pmpNBaXN.FDok2t6OD7SO1yytj8NYL90Q1DlaWGhmGS1gTzduff0viL1XZl1FrV
 c3NJqaD2zzU.U6kL1JcwlcQquEdIAuvvzvkH33vOklMyIqoqtsF6WeKD35.7kYLCvVyUtwgh_3TS
 l5yncG1teILzMYrIQZhE.2AJ_IbmSW91Iu300eAWKciqd4CTcExGjB7MlfjqC0CoUz_F1dJ5mbKn
 WtXhCNWJv6KQSuvmwOiFj0ih3tB1nVILAmw5BmCDybK3O5HD5BZidITZ1z2C3a4S2xpWJuCsPbid
 7ipWbNbzA4CSUNYCCNDRTyf.aNC1NWMvBNO6.o5G0AtSQzDJcGByNtk4kPuN_p6M_4RERx843Xk5
 .ZUqL5W9EeZ0o6MgdanDB5KOtXCuEHlo8hH1HJimisOu6wbx5fLIQ3sviz0Yw7ir_Ab0eBMvAF18
 MkjzypjCyWjWn369YZB5_UwvA.EloqADDFN7TKu36U0r_Ijuu8zrfVUYOHdg2ZGE_pdyweWhbLGV
 UsrEXqQIc3VoIxjTeFYCouQCcDUQnKQW._jt8h_NxhKWhxjM0w6f.gtzrh3T6q_z938oaAfDoYCA
 4xf0b0xDLmRARrUHanwNlyNNI_YcXYIAMFzqiRnd6ndHKdBm6iV9507DUDldsKXhmXlPzpMBQ.8N
 1NLtg5gUNs3Ot8J4Dijue.1R8IvaZo9tkgnxrtHP87ZFb4l0fbYW8Sqdq1kQK3b9KL54emP6v2jb
 rDt3xbGJUxWRR2TbixZeo6JdvSaEaNH8Hzs.K07tWb46UEsBGRXBKu5SHq.TCdAyu7vYxU8AuWVC
 oghdPP8w4A1SV3hVfQR_sTKE3J.U1U_DVMFn_S9VfuYCVicn2GLmTMp3ms.WYObjvtpXzW.2zIEh
 OarGnx8afrT.NLVGGS3j4w5uWsKUgY1dRSTG0dPxvOfQpSMdYmblgp2wBcuuX14gO8zlPuTOVTfz
 _0yscGdMyI931Jw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:10 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 524225efee00edb3a1e75559f6c5c8ed;
          Fri, 19 Apr 2019 00:49:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 72/90] LSM: Fix for security_init_inode_security
Date:   Thu, 18 Apr 2019 17:45:59 -0700
Message-Id: <20190419004617.64627-73-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The code assumes you can call evm_init_inode_security more
than once for an inode, but that won't work because security.evm
is a single value attribute. This does not make EVM work properly,
but does allow the security modules to initialize their attributes.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/security/security.c b/security/security.c
index 63b001e60b59..1a54e7b1196e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1102,11 +1102,24 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
-	if (!initxattrs)
-		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
-				     dir, qstr, NULL, NULL, NULL);
+	if (!initxattrs) {
+		rc = -EOPNOTSUPP;
+		hlist_for_each_entry(p,
+				     &security_hook_heads.inode_init_security,
+				     list) {
+			rc = p->hook.inode_init_security(inode, dir, qstr,
+							 NULL, NULL, NULL);
+			if (rc == -EOPNOTSUPP) {
+				rc = 0;
+				continue;
+			}
+			if (rc)
+				break;
+		}
+		return rc;
+	}
 
-	repo = kzalloc((LSM_COUNT * 2) * sizeof(*repo), GFP_NOFS);
+	repo = kzalloc((LSM_COUNT + 1) * sizeof(*repo), GFP_NOFS);
 	if (repo == NULL)
 		return -ENOMEM;
 
@@ -1117,18 +1130,20 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		rc = p->hook.inode_init_security(inode, dir, qstr,
 						 &repo[i].name, &repo[i].value,
 						 &repo[i].value_len);
+		if (rc == -EOPNOTSUPP)
+			continue;
 		if (rc)
 			goto out;
 
-		rc = evm_inode_init_security(inode, &repo[i], &repo[i + 1]);
-		if (rc)
-			goto out;
-
-		i += 2;
+		i++;
 	}
+	rc = evm_inode_init_security(inode, &repo[i], &repo[i + 1]);
+	if (rc)
+		goto out;
+
 	rc = initxattrs(inode, repo, fs_data);
 out:
-	for (i-- ; i >= 0; i--)
+	for (i++ ; i >= 0; i--)
 		kfree(repo[i].value);
 	kfree(repo);
 	return (rc == -EOPNOTSUPP) ? 0 : rc;
-- 
2.19.1

