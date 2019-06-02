Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52245C28CC7
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281BB2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MUeiC9Om"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfFBQwn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:43 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:45641
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726970AbfFBQwl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494360; bh=+QxXCb9k4EN0+MlvBQu1WP28VNVY6EbCswDSvfqvDU8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MUeiC9OmZwew75uXcY6RQjEI58kywmJ6qZdzGzy/g0dC0dpI3/W1IL36JUKGeyQnY5ftu/Jajg8/9iRiAe6oa2QRRBCSASOZ0HtR+Y/QlnKWYHb5OcUZ4fT2yKUjgcgUABG4RcpULs7YtQKBgIXyHFmmUoYSy/fd/fikbVJxdOzWqqSddZUrBF2SLrUuuTOre52t3Gt4E3qAuLJJi3HyuUzyFMaMwDW3+2RNrz/F++Uk22o384O49b/vggbmUZKH9cEueQTSN+V0kDiKnOUO04GtvqhAGlrZ6uAmQnYfSKXr7RGRLmXKVwtqPqJUuEDeoDVPHko9vSR0wQ9nUxCMgw==
X-YMail-OSG: n7lNJ9wVM1kZZ5jiGK9Ufa.irin_wZVC.UGZszCGkgQzeDs5oBNq2yOB7CFTq2I
 2zGuC.nTOumcCSDsogZhh5gEGag6SaNyh30LGfp9kBRWUhWTzTsyjrQmQLm4DKE8PaTo2keY4dmn
 kl5aoD3deQ401JrAKscFYWswNA92iZRZNSP.aOra0uTNHGuqAE5DnyD2c5sjOq8I3Q0bSoEYjX2U
 L1DsSkvEvL8YoNBpY74xAJQXTbv_G12O9FHRUf_1zfNh9qfcJOhnk.hOXUoVGGyXNCyddL7vkLTh
 XyKj.Tddw1G1ZAoq35fVT.AtKxw3iTaPjAne_PZC58_dnbXPc83s1sRGD8F_aEsoD8HUg7pod3vT
 ImWAVY15CSxVggTJh75ygOLOZTYJzsgPlFoyr37swZx4iefKL3nAeDBsQUPSzsWdcc64lxXWlmcN
 uR8Kf7ku38HK5p.ukYrlM_gEriFWzYRRaXCSHXIeKpH5Tx.nBkdTC_VH7GP7DXSMzU5CSl84J_N0
 5P8rN3A8h_fItRlsTueLwo1cEi89SKSGRzmwzgnDlyfmcflV0Yi.si869r8l7jKkC5WnVvEi_xWo
 dZ2RKxpqiBc0hkdF_vMlAz74_1.MLmz1q.xKzYzHeTxQdK6arK.xOGOsC0Vs_dr9X17i19Jayl56
 E8MrsAVLRunpv6yDmlPEM4ZnWx4FbRl8R2UcMHBSOuFrxU26Wi6BH6HKu9rIf0oDa88sIpJLbTv9
 Wr3r.WbU2chTJdwUEMdJI3OrFMMbxBjjCXApHVpXhMa_ZhJexsAPph0i5AvCqb5PF7l2B0PH7Qkj
 STmBWoLa2NcYfU6XTjqySXEd1HogfFoCboZyFkqq6F7_7nDbj9Eo5158faeYrpfcJLgJSroiPIry
 TJQL9b75lOKrNjN_Uat5gUM5k0nDTJCd6B4DBTDIX21uR7T20Hs7T5biYeDLH_YG7rqJBv3pwmWk
 VTefSURU9cw_WUSgGIpHgcUJyB0gAwnsAM3Vmt_XOt2QRiLrllNeALyYZYJU7c9GP1ZnOfguql3k
 25DF05NbdFr6bf.Zh_t3s1A7mQgXUXH04XxJxRxoCTx3q.nfM.lH2yckGfJcDL1.kU4ZLS53ck5.
 ZY45bvKtg6_3SShJWb5B8L4CBRP1b2U12S_oFOy5kCQhv.IukYUCQnfpdpW_Rw9TKhGCQaSDBLGE
 _.bzcYkEn4QLGqrrJNmih4Of6J2J2R2pUh9lUx7aU8429p2N.wpQrIPyeLJ9IqQykYeRUPjb54VA
 UyBRkYTNCTm_uquZnNKRSKxBpvhhOG2lIiDIqOfOqeqGCVpVKMGPwtF4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:40 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 225d748664d0767f72d028f09ace7268;
          Sun, 02 Jun 2019 16:52:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 26/58] NET: Change the UNIXCB from a secid to an lsm_export
Date:   Sun,  2 Jun 2019 09:50:29 -0700
Message-Id: <20190602165101.25079-27-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

