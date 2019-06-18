Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F8BC31E5B
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971C820873
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fj1bBN3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfFRXHQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:07:16 -0400
Received: from sonic311-31.consmr.mail.gq1.yahoo.com ([98.137.65.212]:46162
        "EHLO sonic311-31.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730962AbfFRXHQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899235; bh=++CaieMSRv4veMEbDiEHUIVkZKF2NKTQzkXG3D9YccE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fj1bBN3+G2HKypK0iO9n5Crz7IxUNe6x2uU4HBgShq4+FAjaXRCdBNTOyEiOolGq1/zca2K0QWwlFs8YUR0GCUgiTrlCDLWzEVndb40+8T60JLlH1Hbpu+nL/F+wu1+bA4/L8sd1M8e9w6UBopIv9H5QAsCF341aWvjEkAiFefOg7FE4eBt+e7KD+a13O+y0qZFkvsnJmcgDohe6hHL2v51w+/ZiwGZxW58WB3KP7HiEJtgoFMVbH9P3IGFJTAFik4JlKQ9bkb2bpJ5hTyhoQN5pwqgXDll8E8ksZKicIrhYIFSi8E6C21TsDYyvpIKwUZWnOwAZtnttP1Nd4iXPnw==
X-YMail-OSG: 6_Z5LI8VM1mkVTYrj3buYpLpMiRX1tflTsQ9WnVqN7bXwUyrIG6c165Tdml0TiE
 JUZrnFRxX0T1q8mtyNr12Vh9Sn49jJICBmlxX1cMYRcUUM5yxIwneocXi5BIVWNMihaKsNYNLXHC
 OC97h_1ctsXlnkmpeoYEIMgO11YJW43K0hkazBx2JBuccgxxiZL27pZxdPC.Mg1_AP.qbGIWkbxV
 8zMk0W1895IjKQ_flwAjb5rZ0l8nzZIVI8HnIn7CMkxuLigEUiFnVDzkZGE48EViEaHvfkl.bC.i
 Ag02pZQ2BW1As._40XKSHLAgMYJyXhnaaj.8oDUuQeal2TQY_NakcCCFnrxrldeuzygR6VY1C.7I
 mWNRAb9O92fqWsS2BT6q7y9OzBIimVl5lYRbLvuFO1A6gZ1bnST5m3M_2wfJr_Fm_7Th84uYP4sm
 PPmx3gntWdgat2SEQ0BK7PgdNMOO_gsYnh4gLzj15seb8U3u9g_DCGx4x73UtuzlfN6ta3dmw2Z7
 rJBvXtiJU0z1garTsSqoJMxWLIxBq6dvxcqtdi0hkHMKlnvlODQxQR4Gl6mp_JhrQ_DLaS9pCnTt
 p_1gO0k_zij2uVig13SktEuKJ3MqXtNncbwnJUlz3ci3Qt4bUtJP4PJK45bs3k1e4Pd13GMt7AEz
 KgVioGFimwgnB.Baclu_h5Ni_xN2nkyPQ5ZqPQfXl4eCciC4QtcsNSbIEWg8hdvKtM7qsXl5c5YN
 WK.qptcLN_jYBAEXtCuTSoKFj1nEzpN17qlvQJqfMgzhxjGfi_vwDfPJwW456ad0FbCGLoQxHZle
 q9KNK2LAnLz0pmAIgU1gtPPAwfEG52PdzEQupGomAZQXhQf_ZnOgfVXWiLRLGNowJXYIQ8zbl.TZ
 9RPWOuoPbU4kuxqt.4vGzHb0KP.KxMfHvhS_5fKRzAB_y4YbmFFtkZZcPeDPLUr4GFOyH5auCBEN
 0X0Gn8IeGNL9LgwxVj7RbgOkC9DlDq94k27ltLAA8Pi.yNuIWEXcPPZ4CsAkY.k6DdnGoiB1e0Im
 3JOErSs.Tx2JLqy_4JZOxtXeB5MpQ1Hulqek04N6PvhraUTenWp2q8dc9CfjHxebTYMnvjfMA_mZ
 4NPSW15eZo6rJQLzAHxpLyqpDKL445W3SU_0pYAqaBNAdEebFSO8JfLtExhpqxtkNeFMvk2S7CXl
 ZJdaGljg1tIWMpCCtcTZQn3Gs0tT6JldUxWHHZWjJGvm4GL9qU_ZNqzRlx_Bnj0BxNdQ9L48a0EN
 EAl_zNMafTLDlWlZiQtxtS.3MlhVeFAnuY5IxbEei2P7t.UNO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:07:15 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp407.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 63d042c01c7ef77757fc0dff1b9276c8;
          Tue, 18 Jun 2019 23:07:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 20/25] LSM: security_secid_to_secctx in netlink netfilter
Date:   Tue, 18 Jun 2019 16:05:46 -0700
Message-Id: <20190618230551.7475-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change netlink netfilter interfaces to use lsmcontext
pointers, and remove scaffolding.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nfnetlink_queue.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 60948538711b..71d202fdf832 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -305,12 +305,10 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 	return -1;
 }
 
-static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
+static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
 {
-	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
 	struct lsmblob le;
-	struct lsmcontext context;
 
 	if (!skb || !sk_fullsock(skb->sk))
 		return 0;
@@ -318,15 +316,16 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
 	if (skb->secmark) {
+		/* Any LSM might be looking for the secmark */
 		lsmblob_init(&le, skb->secmark);
-		security_secid_to_secctx(&le, &context);
-		*secdata = context.context;
+		security_secid_to_secctx(&le, context);
 	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
-	seclen = context.len;
+	return context->len;
+#else
+	return 0;
 #endif
-	return seclen;
 }
 
 static u32 nfqnl_get_bridge_size(struct nf_queue_entry *entry)
@@ -402,8 +401,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	enum ip_conntrack_info uninitialized_var(ctinfo);
 	struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
-	struct lsmcontext scaff; /* scaffolding */
-	char *secdata = NULL;
+	struct lsmcontext context;
 	u32 seclen = 0;
 
 	size =    nlmsg_total_size(sizeof(struct nfgenmsg))
@@ -470,7 +468,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
-		seclen = nfqnl_get_sk_secctx(entskb, &secdata);
+		seclen = nfqnl_get_sk_secctx(entskb, &context);
 		if (seclen)
 			size += nla_total_size(seclen);
 	}
@@ -605,7 +603,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	    nfqnl_put_sk_uidgid(skb, entskb->sk) < 0)
 		goto nla_put_failure;
 
-	if (seclen && nla_put(skb, NFQA_SECCTX, seclen, secdata))
+	if (seclen && nla_put(skb, NFQA_SECCTX, context.len, context.context))
 		goto nla_put_failure;
 
 	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
@@ -633,10 +631,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	nlh->nlmsg_len = skb->len;
-	if (seclen) {
-		lsmcontext_init(&scaff, secdata, seclen, 0);
-		security_release_secctx(&scaff);
-	}
+	if (seclen)
+		security_release_secctx(&context);
 	return skb;
 
 nla_put_failure:
@@ -644,10 +640,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	kfree_skb(skb);
 	net_err_ratelimited("nf_queue: error creating packet message\n");
 nlmsg_failure:
-	if (seclen) {
-		lsmcontext_init(&scaff, secdata, seclen, 0);
-		security_release_secctx(&scaff);
-	}
+	if (seclen)
+		security_release_secctx(&context);
 	return NULL;
 }
 
-- 
2.20.1

