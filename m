Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A496C282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49323217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oBQDZGUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfDSAtU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:20 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:41352 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727055AbfDSAtT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634958; bh=OEjphbUXy3t+0v5Gfp0GLJ88lfThjCKhTnnmvu7zDGk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oBQDZGUf9lLI+E1JC3uHauUVhSUo2WbmY6CwG2FwmWJ59T3oahBvNGKN2YVVrPe0l4lbyOY6dx1Y15+bE/hZiPcNOVGyT53TocCDM49Ec/JSJFvn4Sb551MNhGbGyZkKHL1LJXYfGyxSpaKrWj/6YAJ9DKIVsu38MwbjEK74RPeQDudxcNqYiMoYRKThSc1+8TQqBrLR5JIwQT2zKl7DZW1toRWf7Zw7uhL466dPRkGszIrmXvXy3stMJLnOJMHb+ZHuNFDOweNxd1Dz846ZpxK5JKjE996abyjoHDsDylmhaS4sIuFGMN0y/xddzB9Xv9y9r13VF10iyB5YewPYHw==
X-YMail-OSG: 4m2u2KgVM1koF0jfHfdeQwqxMu8t0gV9AnDlt.9ThOr9TM1QzTlT8gryKeDJap5
 P2j_i.TM._aF_EFGWwrpy7G.s5IG5hCiXDUHsRpRlZOcNBYvkp9yW4fai9xpHXqf.oJPDIS8GikV
 AVoBubB_JJx.h6EhTLsulvhj5DHXVzx0IyhSMEaBqE0Y1y3riXuSdwsUwG6Ic2wMBrlXVFWYg4KC
 KohyihwevlXmO_H0w2n1VwRBB6R1gGY9eosPFOJsCNFkmJ47x6bLgYUqP_A4J9l9WdCL6ieNqlx2
 CKC92x4LoaRMA_80xK04cAR2jSmeL7AqnZO4noSt6hUA2S9_kOiUpy.3BnbittyDZJoBozSmJv49
 ricbEDuyYKfiNIMPQu7ryCeKLm7wr9_dgBmy8d.5o47j0p2NWtRHtiGFPlEVfneTYKiU.cXkfvm2
 _TbSr2tbfUrg36EHNGhcD1aHiRMHxx.yeAZD2HpdrkAnJfBmG1ngfmKNWkjgWM2oRupp2wnljAPR
 pCz1zBX3CtrPvl9tx_.V89oeFqWnxG2Vjf9AxEDhDW5GtHpTBpAHDissyx0M6RNaSs9KB6IvQ4W4
 bpgzaA8AdNob.kkv43OinxSlfheaxL.Eo2SVqxcS9noq2HGgvaVCkl0vIBiPTVQEg0bo_Uqvu7HM
 QlQtkpRpsI.uCyst8d1FuzruDhGtdfHsqTWXho2Mhu0qX9.MCRGi_AtZA4FvcwXVAzlXBj7lMulI
 2p985kjl9.2DKWxKKNCwvEmqjP95H49vT4tX3jz74lLoLoHoqwDuAcM6E5o5mqwATCxqGiq3p156
 53yLDck.ZRz3ZqrCrmHSPX226EQ4X9x6c7cmE3luZaKNgqlZjVUhiswt2yV5sAItJl0rYhTjWfxv
 .Hds_W5r8mA0l6cKL7a0Yn5Q.sB27r9KFcIJV34wf9taOOTa0GxVa8idYRU0.wcxkpIllABKxx1y
 SfnGyL3f2YoUmE01UMTM4oY5n23lY1suPV_CoSmo60WZKUQulKsl5okBS8iXht39ubS.SEHWBsM0
 NGZcREKRqg7mU2dkcUTE9713ToPIXJpobsn.lFu.0cZBvfBEwmGFqprWscChbOUcOugXBvDCaPNf
 u9vpeZEG9UsTCGSoCMYRcb29mAU_xwyZlw1oRt5WVRVZVBZ1WzRpaSn_wMf8SpxC_i4RwMu0XMtk
 3e7LvvY6eTtmICw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b2fce6e68c800904f23626e111be9fc8;
          Fri, 19 Apr 2019 00:49:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 77/90] Netlabel: Add a secattr comparison API function
Date:   Thu, 18 Apr 2019 17:46:04 -0700
Message-Id: <20190419004617.64627-78-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a new API function netlbl_secattr_equal() that
determines if two secattr structures would result in the
same on-wire representation.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/net/netlabel.h       |  8 ++++++
 net/netlabel/netlabel_kapi.c | 50 ++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 546c75f27d05..00000d53cdcd 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -472,6 +472,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 			  u32 offset,
 			  unsigned long bitmap,
 			  gfp_t flags);
+bool netlbl_secattr_equal(const struct netlbl_lsm_secattr *secattr_a,
+			  const struct netlbl_lsm_secattr *secattr_b);
 
 /* Bitmap functions
  */
@@ -623,6 +625,12 @@ static inline int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 {
 	return 0;
 }
+static inline bool netlbl_secattr_equal(
+				const struct netlbl_lsm_secattr *secattr_a,
+				const struct netlbl_lsm_secattr *secattr_b)
+{
+	return true;
+}
 static inline int netlbl_enabled(void)
 {
 	return 0;
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 849064422e0b..648103ecc48b 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1461,6 +1461,56 @@ int netlbl_cache_add(const struct sk_buff *skb, u16 family,
 	return -ENOMSG;
 }
 
+/**
+ * netlbl_secattr_equal - Compare two lsm secattrs
+ * @secattr_a: one security attribute
+ * @secattr_b: the other security attribute
+ *
+ * Description:
+ * Compare two lsm security attribute structures.
+ * Don't compare secid fields, as those are distinct.
+ * Returns true if they are the same, false otherwise.
+ *
+ */
+bool netlbl_secattr_equal(const struct netlbl_lsm_secattr *secattr_a,
+			  const struct netlbl_lsm_secattr *secattr_b)
+{
+	struct netlbl_lsm_catmap *iter_a;
+	struct netlbl_lsm_catmap *iter_b;
+
+	if (secattr_a == secattr_b)
+		return true;
+	if (!secattr_a || !secattr_b)
+		return false;
+
+	if ((secattr_a->flags & NETLBL_SECATTR_MLS_LVL) !=
+	    (secattr_b->flags & NETLBL_SECATTR_MLS_LVL))
+		return false;
+
+	if ((secattr_a->flags & NETLBL_SECATTR_MLS_LVL) &&
+	    secattr_a->attr.mls.lvl != secattr_b->attr.mls.lvl)
+		return false;
+
+	if ((secattr_a->flags & NETLBL_SECATTR_MLS_CAT) !=
+	    (secattr_b->flags & NETLBL_SECATTR_MLS_CAT))
+		return false;
+
+	iter_a = secattr_a->attr.mls.cat;
+	iter_b = secattr_b->attr.mls.cat;
+
+	while (iter_a && iter_b) {
+		if (iter_a->startbit != iter_b->startbit)
+			return false;
+		if (memcmp(iter_a->bitmap, iter_b->bitmap,
+			   sizeof(iter_a->bitmap)))
+			return false;
+		iter_a = iter_a->next;
+		iter_b = iter_b->next;
+	}
+
+	return !iter_a && !iter_b;
+}
+
 /*
  * Protocol Engine Functions
  */
-- 
2.19.1

