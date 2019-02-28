Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF857C10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C19B206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VLkHyKzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfB1Wq0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:46:26 -0500
Received: from sonic309-41.consmr.mail.bf2.yahoo.com ([74.6.129.215]:37519
        "EHLO sonic309-41.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728670AbfB1Wq0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393984; bh=v0/bLPt6a0S+kZ7bC0Nm9Gz1IfnCWpsX4z1i6JEy+dk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=VLkHyKzqp/T7ArjzTNQy/CxpFsReYawQxRipzV8TlhT0AOyL81b/nstxtMyvcBKwOPLtRGLdup7p/evMzYrgzZ1mT3BfAw5GokGgsaLbIOJvtvH3DtCTy6xm+F8j15tceOoLrZ3C/FH3U41Dbbqtlw5dklK2Z1wk1XOgd9RNUZRHNPzlCQFT8g5dUU1SBCWbBABiYChYDkFWNr1gWO3Rf31Rnr/hIDmGb24m8tSdclyNOmVHGl3yXwfQlF8W1SIlKDawWfyd4sIP1/e12JEZOmHuvYHew1ye0gs8+nEXdPIreRcjMJ1Dz+Cy+Yw+3IpgO46kl5rfwA9XT0Fv/H0lig==
X-YMail-OSG: fZrgIIoVM1lWTAHWwShGfA7FrT9Gt55SakmhDbWBxldYqT8yfCHzNisrY2fDpd1
 xkJ7A1jJOQA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:46:24 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 46c3ca42412e81058eafbaa96f791691;
          Thu, 28 Feb 2019 22:44:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 84/97] Netlabel: Add a secattr comparison API function
Date:   Thu, 28 Feb 2019 14:43:43 -0800
Message-Id: <20190228224356.2608-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
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
index 01b8006c7c55..db6bb1c037f9 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1460,6 +1460,56 @@ int netlbl_cache_add(const struct sk_buff *skb, u16 family,
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
2.17.0

