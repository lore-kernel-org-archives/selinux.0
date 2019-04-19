Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F34DC282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C076217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IPX4t4T0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDSAr0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:26 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:38771 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbfDSAr0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634844; bh=+QxXCb9k4EN0+MlvBQu1WP28VNVY6EbCswDSvfqvDU8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=IPX4t4T09BJyu5doJ8MumfOvCYzwD8SpUED6pEjDF3JoEoLxQTFHZEHXJbctSOegTN1klncO+DBBL3H6Lksam5FqKwwMIfhzHBIhcanH71JhMwJhXZNHQckxjdQcvHWExVchk1WZv2EsI5Ab8CzZdG/1HMPEn30h5RPvQjxxXvY88M4RzQXSzB86suI/zr34AfbTtcleOrDNpOHb2bnqTZ+H1M9rdE9IXsL3pYY8UU1K6+ooQ3QRSbvZhcBO5/BmtUVaB6uSfY1i9tQ/X2q2RICvHHznvx4sgBj4iH4IcHxWZYKXrohb5K0T3HU5wn8flp1XLaIWooJZn9SAyIBJLw==
X-YMail-OSG: j50t5MkVM1lQ8_tAWS0oNfkVdilqiyg.0T1anNnX_kdBCgazwGujwnWnoFmwc3D
 RDfwH5qvezoAftjVcE9MdVzS493FEB7DeeAOEatan1Adn4NoU4VSJpt1tQHPVk4trpS5ibQcrh3Z
 9P6BfLcc9b4sXgJ.PoPmkG8lKOrhl811l5mHOZEhBlOiM.TD7QSBC.cQY4vyBPbKHfPwMipAw6DA
 KSsqR_NA577V7Dz5VUcIhVPu2tGwX_kRw8owez83NT0iinGRvHAgb7Nhs7eQmbvTzu.TxXjth8Bp
 uaZZPngT30cq73vIkkOyWtk8k7836nUkE_NG9.evnOo_Fpq4nd0wWKEhPhklYcsio.Xle1pYKWCf
 1ENEiq7wOOdKSu90pRs29c8zCMZkMT2_cp9lair5R21_OhOLH2h0V2JvUwbw1xUPZxCjZWHUsawh
 DludwQfCY.zvK2x1cwID0qk.RsnFGrVLmk14gkXxU_xTg.PpDr1wkhlls6G41e2D1qan8O.br1kb
 0Z_GJXFV8fN.LHJqbJFfQrlZG83R3Ym8T6A9vGTE5ncRoPvKe06wJDNxG0sYrDclczH9ZYSxbaAd
 UM7e3zkGG.8vs1lMqWm2fUsjxiYEOteKIaI9ZN_7hZsVdWWkfzsmUH79FqeFrc0qBPXEnJeZ1H93
 ThcwTqdY85S4yJox4gCUQvXoLpehG5PHxV33.6KTwzBEvrZFi9RM0sfldxqZ6NWAM3faTFfmxwjh
 fU0f8izU9otrF5KV1gHPIt7EjvbZ8peshcVpcX_WAQPtRgKoRdFOntfLwAkky8Sp98duk4wMYFQW
 vITBA35u_VqilxN4VGN6B6qy2nXRrxbGXq09xTht_luKC2R43Lhj9N4o7l08K6Xo90BOZ1Bctcu1
 ttkqN.eoQtot1.BfKPEqrfd2jbDs7Lvr9BxvPO3m63QvigEC59mVCEQdEgnwBBoFOEE3Xn0cX.gS
 DnXtIzwXmZIqEieqawdSr2N5pXuF5WzFCWPSa8hhQp1nFtJAZjlbbxU6CCYcp..6ATst2.dL5euJ
 xO5grbLI1sJf9xpxED6g.a6GbYU0M80n83gubA9TnoE.Q9JbS3GQPEPSpVJo5d8NKd7fba00OCTi
 nkOtnVeq3Nfm1bkVZbmKEghfJLs.YSNwfFfM2uc4Dtl8LpsNU7d6yaqI9MVBj4yEMF6.FJ8PAC9I
 Gw0sKm0lC7A2c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:24 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5d780a730ba98836fa707a31546db6ad;
          Fri, 19 Apr 2019 00:47:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 27/90] NET: Change the UNIXCB from a secid to an lsm_export
Date:   Thu, 18 Apr 2019 17:45:14 -0700
Message-Id: <20190419004617.64627-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Store a lsm_export structure in the UDS control information
instead of a single secid.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 16 ++++++++++++++++
 include/net/af_unix.h    |  2 +-
 net/unix/af_unix.c       |  9 +++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index e76d7a9dbe50..9d8115b3d679 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -100,6 +100,22 @@ static inline bool lsm_export_any(struct lsm_export *l)
 		((l->flags & LSM_EXPORT_APPARMOR) && l->apparmor));
 }
 
+static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
+{
+	if (l->flags != m->flags || l->flags == LSM_EXPORT_NONE)
+		return false;
+	if (l->flags & LSM_EXPORT_SELINUX &&
+	    (l->selinux != m->selinux || l->selinux == 0))
+		return false;
+	if (l->flags & LSM_EXPORT_SMACK &&
+	    (l->smack != m->smack || l->smack == 0))
+		return false;
+	if (l->flags & LSM_EXPORT_APPARMOR &&
+	    (l->apparmor != m->apparmor || l->apparmor == 0))
+		return false;
+	return true;
+}
+
 /**
  * lsm_export_secid - pull the useful secid out of a lsm_export
  * @data: the containing data structure
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 3426d6dacc45..c1612d4b191c 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -36,7 +36,7 @@ struct unix_skb_parms {
 	kgid_t			gid;
 	struct scm_fp_list	*fp;		/* Passed files		*/
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Security ID		*/
+	struct lsm_export	le;		/* LSM data		*/
 #endif
 	u32			consumed;
 } __randomize_layout;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4d4107927ba2..222929693867 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -143,20 +143,17 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 #ifdef CONFIG_SECURITY_NETWORK
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	lsm_export_secid(&scm->le, &(UNIXCB(skb).secid));
+	UNIXCB(skb).le = scm->le;
 }
 
 static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	lsm_export_to_all(&scm->le, UNIXCB(skb).secid);
+	scm->le = UNIXCB(skb).le;
 }
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	u32 best_secid;
-
-	lsm_export_secid(&scm->le, &best_secid);
-	return (best_secid == UNIXCB(skb).secid);
+	return lsm_export_equal(&scm->le, &(UNIXCB(skb).le));
 }
 #else
 static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
-- 
2.19.1

