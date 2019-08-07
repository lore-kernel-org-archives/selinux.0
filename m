Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436F2C32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147BE21743
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TZYEE9/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbfHGWm7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:42:59 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:41949
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388945AbfHGWm7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217778; bh=Mz/r1EdVusIgzmEqbr7D59R74gOyqNM4yG4MYLC8IaA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=TZYEE9/bkTsqOdI5hEdPVDz49UxEYL4ylTs2s48e7XqtZ5DzzJneEtreugf28AbMrHhtQ/I8xtTBFYVSLfsmX+v7nBPq1CY1xJI8HUIZZzzUQEgLBxNGx+prHbWX1Zn22R8vy0IEtE8SL8bUF8dU1GsdwOmOwRWMFPV3sZZDlkQeAo9fqer8owl7Ax3LmIDcOH/mJjFSh5topL7KQHZTjjgyxOXdGK/aNSFpV4dHcAVDQ3tAZ4H6hD5DS+tSnOvEvb2cCfBPslYLuoU2N+abtZeJ6vEFwrrdw29XsOiYitxJPnDvOqZHE3nED2DfW1HcBXGwzQ2RNPTe6snx03Kdnw==
X-YMail-OSG: .YRS4hMVM1lSKcjmTg0YwlYoPxN8uGGZjFHggUj8vjKSV0mHERgruSv8qQZKodP
 eKnLfx8xZwirVSZpsZUmoC.DgZamA6jN_6LOmeuyxUKuV2riM.__kHfCnnKb4vEB9ECNLmR3QP7I
 Ei3BVwDXbjGLCB619akC2eZCohmqJmQYWrFzQyEiRWICsqVwOJjbngm8I6LY2meUjcxpM1qA53DJ
 9nfxpcj00EKlIgOg32WEUNb5rONwreZBJq10Ttm6Jk8yxSAJn.VhHSUhDmTgL5VayYmwPe5_mPxl
 Vx5qlMhqImTLtJtBqZr_l.KDID2oF_AUI8VEih06f3VnGtjZHfhGL8pIkdBFyCjBM3NjyZ37GoYz
 S5ZY.k3kLaulx9uub11qNooCUiAx.wIGMpkw4ww_s5wp5kEbFqdJ0S8pFYaGFB3Fus9lGtsG6t65
 8rdiuUIKY2aKn0XXGrDrcnOevSllg_CC2Xqmm.pEZ9ls857ehlXxLgPO6d9ewSw.BE13qEVy2JPD
 PgUDeGMp5MsrD9CVr.21.dGNU1FAZK5o7Cjh9aoma3ds.ZQuVLHdqkpXAsWFWn5OO2_lOrRgSxfj
 tX8eoX7_XXJmWOLZHo7n7_WKE.dyfJC.Ca3QoO2FmX94V5ng8K4WHzOTkzpA4KAA3HpEJpa_lM7O
 .W76uJzfdKYXoCBPJS3NuFMr9n3QraYSEwEN9uh_Js7Y4Wmkjc05OmgvonovWj43JhYuiT3kQ12k
 Aw4EKQZmvRcXacV2Ov4zq5UXcRsX.9pxi00YGNtgrDxTSOQit4_m_zREEZP_AIT3NDumlcgyueSp
 3ESpLnWqRExibE.mdfynRr3NixEApwvyvAaX9ccTlmSRPIaArYxNl2G7jfOG4iB7ii3HtAPXpGIE
 tF_FAMfuObSRwZ4hlX68PQNrGutWIdqJ5NYXfldKokw9oVQ0CYwyJYmmaG4QXZ6y67QD9ujht55G
 fy5JvNNTGH3aVXv160Jg7I2uvdq40OY8TwaUd8OyHD0c60TtUlB4DwzESJYoNoU7i3is3EkHSFqT
 6ga3fc5u8S1nx4SLeeWMKpUinVGwRGBlbz34ybBXML.rPJ7be3mGFjWo9txsUCzKgyNAERu2V6a1
 gpcKJvFOvxhR3anHauKjmsz5K5XDxiAL9wB7eE.mGGbA765feYAenxL5PmcCb3qP7AMqZzclTRZS
 dKEFOHvw9NRUwAWyI6Bf.ihS1Vsqq92Vwv2s6q16JKbd5kjvWIxe9Qw1ut8NxNNHLfIvfvXbLvQd
 ePtKaCzF9k0WpqbMUn2zuhLuExKGxZR7CvRro0f37WFmLRDZslMT8TxBMSW9cZzbqh9qOUULbQ0m
 BfsmpMZd4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 22:42:58 +0000
Received: by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 824faaf1f4a5ffbf9b87c6192a4b2124;
          Wed, 07 Aug 2019 22:42:55 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 03/16] LSM: Support multiple LSMs using inode_init_security
Date:   Wed,  7 Aug 2019 15:42:32 -0700
Message-Id: <20190807224245.10798-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 0467f194d87d..a58e60970035 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1096,9 +1096,10 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
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
@@ -1106,24 +1107,33 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
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
2.20.1

