Return-Path: <SRS0=GjD/=DB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00664C2D0E2
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 08:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55A123787
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 08:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="V6LYn+Nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgIXIvM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Sep 2020 04:51:12 -0400
Received: from mailomta19-sa.btinternet.com ([213.120.69.25]:35093 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726840AbgIXIvM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Sep 2020 04:51:12 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20200924085108.YTZV4112.sa-prd-fep-045.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Thu, 24 Sep 2020 09:51:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1600937468; 
        bh=gfshxmOa7pyOBPfnZC73Pf8y0/WY1PIHuQRoM6dbw24=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=V6LYn+NfiFITNcFXv8whY2tH2EpAa3w91PxQlayp+kzA4aPUH2m8EWuZYscF6TN/0RI0Fu/yz3KLhnheEYiLRs49qcTVMrre4ZG27Nr6/I6QqBF1pi32jUL+/CYYWoW7iQuSqNrwT4vAIHgHzykN7iqjO5XBncmoVF+NrJyc0TVfOyBp5jmQ8nOrBGsI5HfhLFM+umx0UwPAM9cJN2SlfCJ8IK+hY8Q/91o/35ZRB+UGR1baeO8s+x7lzBWsNQ2GJALCYbGwKsW97+p+MN2G0P82hy0rfPvvIPy8N7tX++v9+/ZV3pjjmMZkFt9lXN6h9MUdqy1Iq4QSlBe/ISphAA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.146.219.130]
X-OWM-Source-IP: 86.146.219.130 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudekgddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedttdelleehueeggfeihfeitdehueekffeviedtffegffeiueegleejgeevgfeinecukfhppeekiedrudegiedrvdduledrudeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeeirddvudelrddufedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeojhhmohhrrhhishesnhgrmhgvihdrohhrgheqpdhrtghpthhtohepoehlrghfohhrghgvsehgnhhumhhonhhkshdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoohhsmhhotghomhdqnhgvthdqghhprhhssehlihhsthhsrdhoshhmohgtohhmrdhorhhgqedprhgtphhtthhopeeo
        phgrsghlohesnhgvthhfihhlthgvrhdrohhrgheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsthgvphhhvghnrdhsmhgrlhhlvgihrdifohhrkhesghhmrghilhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.146.219.130) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE1282CF1D; Thu, 24 Sep 2020 09:51:08 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        osmocom-net-gprs@lists.osmocom.org
Cc:     stephen.smalley.work@gmail.com, paul@paul-moore.com,
        pablo@netfilter.org, laforge@gnumonks.org, jmorris@namei.org,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 2/3] gtp: Add LSM hooks to GPRS Tunneling Protocol (GTP)
Date:   Thu, 24 Sep 2020 09:51:01 +0100
Message-Id: <20200924085102.5960-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924085102.5960-1-richard_c_haines@btinternet.com>
References: <20200924085102.5960-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add security hooks to allow security modules to exercise access control
over GTP.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 drivers/net/gtp.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 21640a035..ee00b12ab 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -73,6 +73,8 @@ struct gtp_dev {
 	unsigned int		hash_size;
 	struct hlist_head	*tid_hash;
 	struct hlist_head	*addr_hash;
+
+	void			*security;
 };
 
 static unsigned int gtp_net_id __read_mostly;
@@ -663,6 +665,12 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 
 	gtp = netdev_priv(dev);
 
+	err = security_gtp_dev_add(&gtp->security);
+	pr_debug("security_gtp_dev_add() ptr: %p err: %d\n",
+		 gtp->security, err);
+	if (err < 0)
+		return err;
+
 	err = gtp_encap_enable(gtp, data);
 	if (err < 0)
 		return err;
@@ -705,7 +713,15 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct gtp_dev *gtp = netdev_priv(dev);
 	struct pdp_ctx *pctx;
-	int i;
+	int i, err;
+
+	err = security_gtp_dev_del(gtp->security);
+	pr_debug("security_gtp_dev_del() ptr: %p err: %d\n",
+		 gtp->security, err);
+	if (err < 0) {
+		pr_err("Failed security_gtp_dev_del_link() err: %d\n", err);
+		return;
+	}
 
 	for (i = 0; i < gtp->hash_size; i++)
 		hlist_for_each_entry_rcu(pctx, &gtp->tid_hash[i], hlist_tid)
@@ -1076,6 +1092,12 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		goto out_unlock;
 	}
 
+	err = security_gtp_dev_cmd(gtp->security, GTP_CMD_NEWPDP);
+	pr_debug("security_gtp_dev_cmd(GTP_CMD_NEWPDP) ptr: %p err: %d\n",
+		 gtp->security, err);
+	if (err < 0)
+		goto out_unlock;
+
 	if (version == GTP_V0)
 		sk = gtp->sk0;
 	else if (version == GTP_V1)
@@ -1139,6 +1161,7 @@ static struct pdp_ctx *gtp_find_pdp(struct net *net, struct nlattr *nla[])
 static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pdp_ctx *pctx;
+	struct gtp_dev *gtp;
 	int err = 0;
 
 	if (!info->attrs[GTPA_VERSION])
@@ -1152,6 +1175,13 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 		goto out_unlock;
 	}
 
+	gtp = netdev_priv(pctx->dev);
+	err = security_gtp_dev_cmd(gtp->security, GTP_CMD_DELPDP);
+	pr_debug("security_gtp_dev_cmd(GTP_CMD_DELPDP) ptr: %p err: %d\n",
+		 gtp->security, err);
+	if (err < 0)
+		goto out_unlock;
+
 	if (pctx->gtp_version == GTP_V0)
 		netdev_dbg(pctx->dev, "GTPv0-U: deleting tunnel id = %llx (pdp %p)\n",
 			   pctx->u.v0.tid, pctx);
@@ -1208,6 +1238,7 @@ static int gtp_genl_get_pdp(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pdp_ctx *pctx = NULL;
 	struct sk_buff *skb2;
+	struct gtp_dev *gtp;
 	int err;
 
 	if (!info->attrs[GTPA_VERSION])
@@ -1221,6 +1252,13 @@ static int gtp_genl_get_pdp(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
+	gtp = netdev_priv(pctx->dev);
+	err = security_gtp_dev_cmd(gtp->security, GTP_CMD_GETPDP);
+	pr_debug("security_gtp_dev_cmd(GTP_CMD_GETPDP) ptr: %p err: %d\n",
+		 gtp->security, err);
+	if (err < 0)
+		goto err_unlock;
+
 	skb2 = genlmsg_new(NLMSG_GOODSIZE, GFP_ATOMIC);
 	if (skb2 == NULL) {
 		err = -ENOMEM;
@@ -1250,6 +1288,7 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 	struct net *net = sock_net(skb->sk);
 	struct pdp_ctx *pctx;
 	struct gtp_net *gn;
+	int err;
 
 	gn = net_generic(net, gtp_net_id);
 
@@ -1263,6 +1302,14 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 		else
 			last_gtp = NULL;
 
+		err = security_gtp_dev_cmd(gtp->security, GTP_CMD_GETPDP);
+		pr_debug("security_gtp_dev_cmd(GTP_CMD_GETPDP) ptr: %p err: %d\n",
+			 gtp->security, err);
+		if (err < 0) {
+			rcu_read_unlock();
+			return err;
+		}
+
 		for (i = bucket; i < gtp->hash_size; i++) {
 			j = 0;
 			hlist_for_each_entry_rcu(pctx, &gtp->tid_hash[i],
-- 
2.26.2

