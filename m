Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6C6C282DE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F012082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lgxS5vGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDIVks (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:48 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:36524
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbfDIVkq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846044; bh=KYlupIPcbLYAYHDyLLLdG0LtZrXeMUYE6GpZUguvURc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lgxS5vGuums+xUhsjlm8yNCpNC1F9tITlLecE3y5g0g0Add9R4VriKQpkIlnvJVGUSNfaqvfOU0Aob1xiwGMpk4gFPZpqJvLILvM/Fe1QKeJ7bYPklOIx2yqiCOD/FbBmBSMXUs8WOPOLlItrZuasbGUxkvVknlNrZyZ4HVG80F3TD7HQOGDRJFAXJ6PrQXeMbb8zsMKVWrDNSSJUSlvaWlJocdlm8uvogsfBsf+1CoL5Ac+GejczMUyPb5LANGx7XjXLtSrr+AQMspj4FYuEkdEIfsyUOVRglnKMDZZEWp2tMBFI0mqHt7OeBcUlZ391oa5056CVnxAIkWj3PCv2g==
X-YMail-OSG: MzTA5XYVM1kZloBqQh6x9S08SaNyyYDbP72IafmDf2sFgDZu2mX57kJzS.qUpnb
 i9tKzd0aIG7EX5oSJmSVtf1f7DtGBLLifp9HdMD2Hsmjf7jxavWgeA_SGAlyXGXQL85wC_eAFP64
 F5lq1CmnLhPeUDVUiLIJVXfaL4XiCVHsMWbkPe72rKTTKDcIkt1jB8IOVWsBTTzFjqu4vbWks5X5
 nnMpFxoHasS9UC69AUM3Uzk0dYK00N_3sO6GONd1his2nSuwCWVU9jVK3792.OM2ljglBxF6k8pN
 Minxupm_PLflQ8XkWTf_P7bHxeZIi2WajhlsSNso7kHYIgacmtfBgCXSKx.jMGRF7hmSY4Bf8M8d
 gpk0I2M521iGUAutPEQTYtSpedrVCMcyoCgYL2rh2lZk.cW3F1g1kTowdVqq6a67cVhQys.Nfsth
 FvxWB4OhQb3Ynz7_NhyjnoLeB6C1eR1NOQ2kYHPLFz1O1IT3yo3IMdyu7waH3QxWK_4B6qBQdQRK
 wqPgRm1ka_RBUe1VoVWNEDtwCvFGRpeZ3l1YRIpKvzp7Y4YiL2fh.LRDXjTnrtDNWBIMkYwabk9B
 ywfTKWXNuRTabaaTAy2p_O.axKJUgHd4kjQNaoVFksJAiQBJE2TIsRReBLvDfzT4Fb9.qQMeLrB8
 hH1crusqzwWQFCbOHuRR7p5RDjziQW7L5Lcxam2EJ2Qwpr1b3ae9k7_HibzWRoj_JjLf4sZddyhR
 Rb.uglc9dWM1tNe0.c1TpUNezu84Y7Gy4nIVZin.6VwTuCmikeBAlcXpFy5n3bUo89TIBzWrp7mM
 hUXbnw4d.S6Q_Nwsf1tUEN840P_fiLvzYNZmPrEk1AxmjsqJ2qbSAZuYaECM7Qs405eOxLkd_oMk
 SKlwfG7wyJ3o_krQ48N1xvbZsjw7srhRDFVp5.T3e2YVhyI6NlrAfWIolRiH9REt2YLE4Ul0k1E8
 34ZtWWLIFZSADNXmZsHDwH811HIWk.dvJzpLlJmLqEXLCaox6mafwQiMMTgaLs5W7J7Yfr8hhlR6
 XT_rDF_m4ZGZlUYRA_a72h7Hh2OFGyATNPse.FJtm1EVpwokAcTa6IhzEAvz.iBAgHeSkbIpo3u9
 KZDnzdwDzFQ5hQK0giauHk7Nq1sDE6rHqL6df4Xp09EKTBJiIsixAKcm.D_YLng--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4c017142cf03fa35170466cff726262b;
          Tue, 09 Apr 2019 21:40:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 30/59] NET: Remove netfilter scaffolding for lsm_export
Date:   Tue,  9 Apr 2019 14:39:17 -0700
Message-Id: <20190409213946.1667-31-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

