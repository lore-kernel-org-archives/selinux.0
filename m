Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58A7C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A08E26FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ccmxFVpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfEaXO2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:14:28 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:45516 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbfEaXO1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344466; bh=+QxXCb9k4EN0+MlvBQu1WP28VNVY6EbCswDSvfqvDU8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ccmxFVpCB2X5fZTdglzjgqc+Ta9QU/awanROgc/gF7BHwN6SlOpfSRXhj+rVU10UqEeRr707tOog0w8HPBoV/s52hyLf0eWcT92XoM+IhnepIChaOTDuhZeB09220loAYoqptI2eGYtIpwlHDPvh2ZN3j7HnztyPD1Hzsdt+EVS/dBjzONIn6BeQOPe51inbN5yItvxn1+E+d4r75IJcsPWzesNdTsn77pZL0aze92HQ1MN2r6cO1R/kYG2lf+wZmkkWrY3Lyqw1SZ0eEETl7lMItet3XFwjnCKxy26z9OaLpy57b3vdK+ja/uVndLkw5nuCYjaVJPc0T9PRgMivMg==
X-YMail-OSG: ZBn.6KkVM1kT1Ybk6yzFOXpo8qjplVJbfaRpNXcY8c66dkfwG43I6n2f9BUDnsm
 p20GI4AqTvEXJnDx7q3S.6kSRUBZTzMwsT1UrfVSu0pN6sB.KhfXADaPA3n4EkRtyKvmpKDdakL_
 zpPpLFNfHsbzXGF5HPk2iVdpsUMTmAz81chcvJ42mvDgmixAr1T2NW11tqGS.i2iORL9RrbCqJLG
 20QA25.2VqqOEXAwh50Sjn3xrDP9vJp7R7e.bvLnuGQaIVSa5bc3Exb0QuS9MV64R8VkIVOFSZtU
 OlcGfKHwsEknlxQRhagEbdSQSNDYuVyjWxHvv6pS8ELaTtGTKD4zDDpzEg0_g7Uj3QaSxQzgjcNc
 T339gnQXne_E5sc3CPd06AKItBWh2KbVTBjfUkJpi_QrwZBSdpcca8Nmx9QfnLC10F1G5FGfByaR
 aOoW47Rfc1s76qFfhfo5aQq4BUkQc.IOeIqXWnHxdnznD48kIjXHvzl74NxoJ38d0zH6nCSFNRFm
 XeUJuxoXAHtL.lK6ndd.Y2KXjcwBVwl35PXiMw6JEgFwO.9yj_bR37i0VOgtEj5mox_Z4M_LRIiA
 HRVxV7biK9F4sMgORD2O7CE2M5V8C75zlwJDtaB3t9aazYniC80K2bSWRi9SSZB3xE95RAT29Kx8
 SukhljbgCvU9xRnsfxB3EAQA8.LaRGiSUFI6H6rXiL3dgcIzDfvSCXIlxv0MhJ94YXt7sG2ERnrm
 v825kjSwSD2KF46NqzP2XGiO1yupF_iQ8PjVKYTGsJjb6dJZV4sIuBfXpItCsW_Q5A8FKYZsE5MK
 qpMxOm3dbJYFjxmCTgeh9A2PGEoj9YLPGkUox57u5jIGmvjiioPHmHWSLGFn1Hqq0ErEjyqY0AmO
 GIOsl.SMj_4XQFT5htZK7ShWz2BJ9C3pO0F8OO7deQ90K3k9mAQdzXIi9wEGH1YSTqeHt6oVALme
 qY36U2iKW5ZzqNr6PeYRF77EzInX9mwqDOqgi8kqfmPLD8SeGNLTUkjMLfpsJSlVH2fq39JjSkMi
 fX0YnSMC96hkAA2Zxoog6rq6tUnOHI1VfKlwODf8USgsrplMCXRGh1lpmWR49vWfuPZLb0adOC2u
 YYM0TxhlB5cywH_9Cx3eXZ_QRDvrj8qmtLxRHtavGJq..CvwNI3yt7.ol12S0J56HG3Y7LRTtpRV
 AAePfR_yddFLWIuwHAo7YRulox3u.GxtSim7P2jV6pDVZcDETx2og6.H9dbuhKLd6vICadwdqWjk
 fKgOx1zqhyQsPaatqePRZTspRCoIyrNLP88fAV7KX4WkF.E_HMlTHD.08
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:14:26 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 93f12d8cf3f8020e3b32ef1a52c7253a;
          Fri, 31 May 2019 23:14:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 26/58] NET: Change the UNIXCB from a secid to an lsm_export
Date:   Fri, 31 May 2019 16:09:48 -0700
Message-Id: <20190531231020.628-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

