Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB3C282E1
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAFF20820
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="p4Jyosje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDITTe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:34 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:38209
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbfDITTT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837558; bh=KYlupIPcbLYAYHDyLLLdG0LtZrXeMUYE6GpZUguvURc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=p4JyosjeSbLDfODgDfManUkPi3MeCMOsfDIXxAZxkTopYo15bp4OOoTXlvXjDM9DHeQ5MRtJH2vQ+Iorxi4L0AsqESTz96hbCke57t6lDHmUGG2/SH+W9hU4LSRyEAgaUK31dY3sfMo+3LID7wCRoyOePjHiKDOHyEk1Qd8NUPjOTno5dV6w5Q5RaiH7+RWfzkYoZQn3gNAu1ohpVMKDbUipfjPz/vG6nq31YEa32kR1cXkiIQDYuQmKnJx3k13hPuX1mlD0QsCmRwkaVjpHTPA7uD9Wcq9k1kcIviiitiMZvg5ABTlxt+2CpHuIEHHgd0RZ3CQisFBXFGbiTo/QVQ==
X-YMail-OSG: XVbOrfoVM1mIl8KF0.he596RFCzFdz1l4q3jr38tFoIE13XWOLSSzg_XUb5uvC4
 KrS27y66KTRqwf2KwEH1m2LZlTEN6JzOlCJNfvELHgiWDMNU3AcGudSXMwZOTI9PDAs.Wleiair2
 tubH7Fb28GU_RpRzpkY7oVlSg4Qn2tCbwlemNuSi5OBEUGFrzMGalIvaIgTq68eSlyOzsgVXxSbq
 MmxWnXBOJhZeH9S1rlfuFQdgeny21TRWiU7N2YnYcWdAbhxD3Am7qj097K.SPLZthMoj64yGQ49K
 6l9rjylNob5bLHMbGdMfwY3sB1lk84ASFcnfuOFTuNvoQSunjc3U5fNpSd5v3xXJyIOndP1QduXi
 cnWOjByQr1pZoSAKOv2xsDm6HL_PJ_82N_qmnmhKml1b.Nc2EmccLydK435Z1WQ7w2OCQOHcii6A
 Yg3YuCJQz_3TB9ZFD71FrHwruXwPtweqiNR53Wc2QhgCE4aUMfhWIeXE0EWjXHiLDJPwsrfqAXqo
 pm9qs9TbsE8XEJntInnGhBMsYunzsa_TO7FkA3m4zBigEhXP6uA2A4trVlsBhNb9VnmrWIz831yM
 9uTLjAy7Yv.VqsVnZRvAyLqNK6bApEn9wADVVN9ICgS.MTDE3jymziTJEjoP5jkmvwwzBNiomPHQ
 SVIO1JI65BPcvh4W.YWZptiQNG4hXnGfPE6p2Il8UwW_pRSz6h_5QyFxZAzzfvz5SUk8G9XCryU8
 3cTVLeCMl9BB254KK1Jw0FuBVVgS3NqOJWbgwrqO2eIoOpIIhzxmPXK3XWoiKhx2OiqEZU4PWjYs
 tokgT99TrEXN7aycoZ.oPIBWFRGpyHTrwwC2lI8TUmLUed0KAZrIE6rVk3GmHhQ0tXyZPOuQh6HR
 3y2720s90INYGQUnkx9bywWQdO6tFj_k3OHSfhJx3kscUvIg31z.c5TYy_5lsQAgvRqdawxgF24K
 XbhsFoIjPIfXiohPfXMpVjpUTPTZ_liSNdWrRNzIKxk8mnVONUc3B2aH9PwcMvwMOF1_cFIFRO8E
 xWRjrRMYOlY4EzN8rSoGxnmXLrvQdZ3Rg2UkfPy.2JcBGvMkogbb6ATX1Oh2EBgW0LARgcoeGSN.
 nwUO4csoIAx.xSMgJbhUaSwttUwC..UHGTgYYELz1F_KVGNWQvxOzZ54-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 564a224fa9abd9f41816cac9472f1914;
          Tue, 09 Apr 2019 19:19:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 30/59] NET: Remove netfilter scaffolding for lsm_export
Date:   Tue,  9 Apr 2019 12:18:19 -0700
Message-Id: <20190409191848.1380-31-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove scaffolding functions from the netfilter code.
Replace with direct access to lsm_export fields so as
to be explicit about how the secmarks are being
handled.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nf_conntrack_netlink.c    | 12 ++++++++++--
 net/netfilter/nf_conntrack_standalone.c |  7 ++++++-
 net/netfilter/nfnetlink_queue.c         |  6 +++++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index b069277450c5..d10cc1924e46 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -332,7 +332,11 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	char *secctx;
 	struct lsm_export le;
 
-	lsm_export_to_all(&le, ct->secmark);
+	lsm_export_init(&le);
+	le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK;
+	le.selinux = ct->secmark;
+	le.smack = ct->secmark;
+
 	ret = security_secid_to_secctx(&le, &secctx, &len);
 	if (ret)
 		return 0;
@@ -619,7 +623,11 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 	int len, ret;
 	struct lsm_export le;
 
-	lsm_export_to_all(&le, ct->secmark);
+	lsm_export_init(&le);
+	le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK;
+	le.selinux = ct->secmark;
+	le.smack = ct->secmark;
+
 	ret = security_secid_to_secctx(&le, NULL, &len);
 	if (ret)
 		return 0;
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 12318026d8d4..d353f3efc5a5 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -177,7 +177,12 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	char *secctx;
 	struct lsm_export le;
 
-	lsm_export_to_all(&le, ct->secmark);
+	/* Whichever LSM may be using the secmark */
+	lsm_export_init(&le);
+	le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK;
+	le.selinux = ct->secmark;
+	le.smack = ct->secmark;
+
 	ret = security_secid_to_secctx(&le, &secctx, &len);
 	if (ret)
 		return;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 4c74c383e26b..a0670137477b 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -317,7 +317,11 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
 	if (skb->secmark) {
-		lsm_export_to_all(&le, skb->secmark);
+		/* Whichever LSM may be using the secmark */
+		lsm_export_init(&le);
+		le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK;
+		le.selinux = skb->secmark;
+		le.smack = skb->secmark;
 		security_secid_to_secctx(&le, secdata, &seclen);
 	}
 
-- 
2.19.1

