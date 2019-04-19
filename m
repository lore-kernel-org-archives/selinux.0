Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E350C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1B9217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Q235N0EY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDSAtB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:01 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:37985 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727039AbfDSAtB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634940; bh=irB6ChJAf0NNvtmr1bddnxr04exdAr8I2+tqVZgLMNg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Q235N0EYNG6m5+fx6S+Zn43wJ7OT3VA2EFf31xRgkmvnyUZyxiKbViSJeVbw0+wzJSqUHuNFlrTzhat0/pyG+7SVyUzySTnWFrR95YOJ8lXzXiI+PtjTpxOpB/1Yso8vq8TKqJDGpYhl66LwnW2RHRg0gYQo5LV0Dz5+yEW0eqvo4oID2q0N7ETE99g2OGTSVCDqiB6j5q4xO7j6+cA+rXb30AmLS0KVLHc5viIv8j3+DCkW2/igKYRTBKXI5bNcotQ7s6iGL388jLq2zdLS3ecLUBApiCgp8ziU9thkML+GS2R5KO5dd+MlMBIMhPm+dJG+tRNbpvP/k9O4BsBAmg==
X-YMail-OSG: c9wQnyUVM1k9pQVTsezXwlikkYOi2Y.ex2yAm3pyWjKD5Gvpp_W53bUzODJ0EYm
 MQbnlx5876SgcD4ClRmRaEG29rxI_h4gRFRzAfd.A6fuO4XO6R0hAzHfVQDyFWLPZUMXKJhbaqaR
 Z3Vx1RxwgwEIMFQDJBLI2v2xlU4mZCQoXvdAEknwB7se1hpVi6wTVb8cLaGZPcVtTZANJ3Pk1nvJ
 yKQ5xzKSSoTLnZTnriihGoJd2_2pyA140nd3_ClJTIF9rIvYS1QwLmBqPDOosEhhYQqvvPuFCto0
 _63KH6t1zqx2twRx7wPDVGKxDrvv0jJ9WKboqRFb3r5YFkNRuvx353EcyytLCKQt.1K.qQ_JmOMN
 fgi.eJBuShOC9XWG5aj6zfGjTQh2a0kFupcQUU5KD2sKBHebjggxVF0qNrud6QW9cbAt.avsqBLn
 XXmhjFfXpBNWUEWbe_OwD6r17THsS3LuNu8v.r.wDUst.5KTTb60vxmhWAMK8ZnGZ4fIrNo2JSWg
 1HZkDWaOEB.KOeKqtlFVJ.WlK1ZslvEh7pDk7O_GDLmy788GLDCAcx8p3hCIby0bKS1t0MUzgrhy
 eHcg0hXDyL.p6x.cV50rIxOltL.keZmdrxOMcOGDBwp8iQq_bayqv80jzPGmPewt6o40BJFgogIp
 TelEGmL9Z58VQXjDwle0ZkDwhRw7aeVTQxZe0p8RgWLrfnwh9vZq4iWq48ucmcfkb4vuibkHe_0A
 .RdPvK6O86wBw9y2lDFgH7enz.sCerbC1Bv4B9LaV9Uq3A5C4f69DCOxJqxrPuV76OY.vkFhW5G_
 ButU0f5qeavr9tXewurmr6RSNc8Z4xIJ9rsmFr5dmve3pmMiGxiHYtiHQbvaN4jyvK64dQphPdIy
 f_mKDZf1GRqz4_5nSiHMxK1AqFq0n2yGKmIadxAZ7pC__l_2DniA9ldP4kPhWzNf7GW3HveEfhZA
 ICGYJTkPaX72xXmfWBisXqDTZkj9J3e5SfTBmzwZbxHQy52lnxljOhypSowfIYAI5sVWl6rEiSkU
 34T8F0Jvht8HcnwJ8KgnX4PsGBff.nnrxTJjELKgHk7KlIen2YGLtXBjYuBcs.E2cDUfL6oG85qq
 xKlbdCXKWrGGYi59DfLD9GrrPb_go4P64pTwQZ3JFBucXPqbL0wGOx2V440X5WL4uBb0.Zb5SyGj
 VZCs3oVFadbbDFA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:00 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 406f9efc49df2aab5b39f3872aa73829;
          Fri, 19 Apr 2019 00:48:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 68/90] LSM: Support multiple LSMs using inode_init_security
Date:   Thu, 18 Apr 2019 17:45:55 -0700
Message-Id: <20190419004617.64627-69-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 0c749816fb7b..b8c90e7c4554 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1064,9 +1064,10 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
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
@@ -1074,24 +1075,33 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
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
2.19.1

