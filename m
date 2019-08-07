Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE6DC433FF
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340DC21743
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mnyB5sIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbfHGWnM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:12 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:34341
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389611AbfHGWnM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217789; bh=cZckcKroyE9hVppfJuatCczXzPUypk7t5AekfRZYxm4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mnyB5sIrudKmrfDmYoVW24HoAzrrbAOFZ1YmDenl5IrX96IO2f3peedzuIh/FwGbkKhhSVT6ytm+RXsHC5IzYCGG63zA+Hs8fztGKHEHBpRG5X7ZsS+PU82xK3GOAnKeF68Xf+l1VelbgAixim7NIBSYsyMoSKg7tHOKD4r2j2LlHVTM2+swI2Kd7vaip8fZDOq7Y/Su6t9RRDSwJNG8/ba5TITbFywaG58RRdZe2n/ijxI0O2s6CojtQjgkrucozPEzqSdLl0LO20ldy2H7700EiaamX/fz9OcCLKwPJrx+ci0ShVfxDYk+I7LG62QHUAhZJCdBBMyyMfjxzY/ECA==
X-YMail-OSG: ucejMUwVM1kooXv3VSHOHDUQVsucoTAfXnNhzYANz5ob.dxrRL5jYYPpY8aPTHl
 _qoz5pLWSq.OnbVA14PmM.CMB6O4p0fKZsD_l5l4y.O6io6281gbjd5pg3cOv3CGI1jQKbFo7ZMx
 yQFUrlD2i1kYgVmE82DxTuPR98aJDLu2E2w..qUOI7se3iyTmXARUa_smq.B4prqJ_IsClDFyTYk
 EUajYOQ.2omtuvvGJfhAUUOWQJeqRBYyAXtFkK4UfXhu4bIOdxxjcmQGgGOeuPlmTA8xcVvOhCUC
 46HS00sSvdDSX5UFIwbejYeT1f6CN0BxtBXQzLlYUo.WxaoKGDFj2j4p1JQt6G9EgoLH1U9UCL1l
 7I8FlS8jKoPSWcSPlohAyxLD_9rjarb6aHd.kNbD2ANGzcqQMilurLcUikHse5ufjL3AKQlA6RdW
 sfrLKTqYfSrqnPHaGTXYNG2rMRPFYz348vStER4YQqOpdRcVN2DNPFTNO.532_TL.dYwaFLju9YH
 0tVwlmWycQORBEeW36eytilFmF53Z3KGhVjwi_1grtu_CsIHbElVfiE989Zdu9RkWvYqM_j0DXd8
 OUgS31.g3nZ48cIXa5Q_mSoe79H0pbe5V0FjK6gK70g9YlKR77PU8DNuwpBHHbYLr0SDYNz5Pvzq
 LC39XqUNPVgJD1KOW4b0mSXLGRkZDVWkNNrWbXi520v_2WkA4JGvmphV8cx7stlPuWpmeET.ReWe
 7r0wsT9gLq9ZDDtWzz1TlTKWSx8tbXA3YOS_qFLfD_pOhc6bgxJrDLE97uGC0hRYOKuEIdNtb1gg
 chQqA4JJB2nQ6p_3afGsVIS_Hn7xxSuFj.1n0I6uR6kNeUv5JfqiNgAcVgr0Yb0d0zXpR_4I3TY.
 4QgRVuN_kPP9H8la8JEK.wcTalfAugguiwduTLsHxIbViN9bB950txKC4rwkaPYApBHIOYJRH3hN
 yG.IRiqGwQjtm0_e8WDxwP4BM.cTJmV3huRwbYV.ZgDgat5C32stwFwN8cBeLAPpEyXRTzJ0krbh
 S.O5KSzf6LgRMJwdXt67fUnH.onOuT_Jo0tuRkqXGuoJm1KIQ7v_NN6CnB0LywOBNWEhmh7n83Dr
 OtFgwMYyx7gXF9pELZa2vOME9vuLjJtmWXpWA9YU0qCeuyIbjCYPyBagD82v0KYIn5NafKoidCRY
 JkkUdu07kk9_.JOOyNCTFCHftadPlq7JoEnVbEyIc5IVHkaHPoviBMhdPVORCd1IX48ynLSFkRJH
 bOoyDrQXEO.qynlkpCNlknFFK.azA_rDN2zzIzE.hlVmQ5dTbzr0Al.EmiZMTG2rGjfnK2Wki4NX
 CUi0dG5ot
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:09 +0000
Received: by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 90d0e6b59b40235a6b1cae6254f016be;
          Wed, 07 Aug 2019 22:43:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 11/16] Netlabel: Add a secattr comparison API function
Date:   Wed,  7 Aug 2019 15:42:40 -0700
Message-Id: <20190807224245.10798-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 6c550455e69f..fc4fca7d65d3 100644
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
index 724d44943543..a0996bdc8595 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1462,6 +1462,56 @@ int netlbl_cache_add(const struct sk_buff *skb, u16 family,
 	return -ENOMSG;
 }
 
+/**
+ * netlbl_secattr_equal - Compare two lsm secattrs
+ * @secattr_a: one security attribute
+ * @secattr_b: the other security attribute
+ *
+ * Description:
+ * Compare two lsm security attribute structures.
+ * Don't compare security blobs, as those are distinct.
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
2.20.1

