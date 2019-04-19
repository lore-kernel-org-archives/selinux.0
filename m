Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42D7C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8094121736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GXuAJzjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfDSArg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:36 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:42744 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbfDSArg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634854; bh=KYlupIPcbLYAYHDyLLLdG0LtZrXeMUYE6GpZUguvURc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GXuAJzjXvha7gsCV4j04dpBTBFYBhmbMVdvNcPQkci+v3lWgmVfkfhHlmBDE62K2D3bTPARW6qtaQCe70B/q/wL2Sl8upxfN72yEuC6W8sJ1E45vMwAPRuuP1dzkuxiiu0uBC+V4wJdimXEKWbMq/sr+4oP6BE8WrTl3lf06gUmX4RIcFdgNmxw6wKrAHzwTeX6yLaUzNxy9GUMrC7i+nDsr283LIxVwgquGFPvU1uWh5BZUgImDPzXXUhAwEejS4Au2XzXdFQkCfnmqYuL9SzAhuR4C2bGaRh0Uxsf/6sNgbFpmDi/54IC+L1PnFDCxYLWBOQKgP6aM6QkjoWyOUw==
X-YMail-OSG: UwbwAmUVM1mTQMRUslcZq3H_MMBh0oKs7e5Vn4E0Zddkjye19ZR_4rehEaQAyf8
 cflCEiQmSnrsfbbLlDalz5YOX4omkfSQ7XeszUPWvCw1xH8O.3lYcAy1yUbHZ.wIX2RWYUQmRZbH
 3uaOfyHIA73KzAfCEiVKvNDTaYHvgqTD40H0S7dZJNPIED7tyoOIOQw7Yi7ISaJcTfhnHin6EaRg
 cvRzVyziLJh1h7My5lB4CCPKvPjBgV_1c5VqRp8a4nM91unocBtOQ.eaE1bzT5Aclk9YHZ1_XkjU
 cYEO9VgZElQbAAjV.qygUHH4uLHDFDAI1ssveG6LIsH2aLkahKFJaKKHYmkLWQKSmQYKwqrPk0ba
 HaECAj.xR_CNqdCCwwXj3kJzcbvHHs.ed3uHueQqBL_2X__2eciFI33ERtyGR6NRdZ4lGt5YeSu7
 ZMlfxSxNhdm6hSUpDZnKYophziuHGgGXYBY2Ltn9SoIz0AcdaL61Kl9ngw45yuX70DXy41SkFKL7
 BMRt4yNBHEjXllxpEiwEqpAW6fWqwRcS8Mkc0Y7u4TM6nkbp.2eUXSQFgPUqRZ8n195ECP9PPGR8
 HGkCcYOLHYL1FXtwYoxxJq5LzHRCZi1xop.qWMWUUe772PFOGEarHCTMbJfWUL5LD0MYsLqwKfU6
 MPBUHiiiRH.6C0vBTNvfGkROWmr10W5pjuhZi6Ln2hEEusNG7n3MhrqtiP3B7w7bQ0MZSuyJTv24
 z9kFOz0Jks0tPZIMpP92ydH9oBQ_y9rCzqYlRDDW7rBJwuKfBIdichsZX7kRiwGWiFDUWPvRRNsA
 5XedMfMQgedSmsI80LwPT59usN0geZfQYmKJPTLlQg5L3mUc_mMSi.DeAssytdMZPOO4a0QvtmVy
 xZ.RzRYSRo0jVcLRMFCHlMY2YtL4ClwG_coA_W0o4VrEE6sJ.eIU4FfnD0BLy74Ch3FRPwBfLX2M
 TOCLdhrcT8rdXmYKPx5vJX6TQV1Wbg7kY64AlPyMa_QRYLRDQFxLDR3Wznfql80cIWQGp2VKN7xt
 jWumWPOjxYRNAQuUWqbuJGAOdRlI7JwNHFjQCg8YmMW2JZOgAFSot1uUYQxb.dT.nK2vd2yMhlg4
 mm8ROGmEkA9aLlP1QDGYFR.XzQ9wOtfmCRCgbgXNqIeg1WmUtZ31Hw6tgwKJYIQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3136423b19635411d73e92b6945decf9;
          Fri, 19 Apr 2019 00:47:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 30/90] NET: Remove netfilter scaffolding for lsm_export
Date:   Thu, 18 Apr 2019 17:45:17 -0700
Message-Id: <20190419004617.64627-31-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

