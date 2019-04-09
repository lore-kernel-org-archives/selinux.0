Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796CAC282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8E82084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z5fn5Gnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDIUA3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:29 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:42925
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726850AbfDIUA3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840028; bh=KYlupIPcbLYAYHDyLLLdG0LtZrXeMUYE6GpZUguvURc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Z5fn5Gnjh0Ze3UVH6heh1o1erQmP6WHtc4XxoMnRrAqsvft2zJeYFSC4fg/zkjqqUZMt9QqjxwxobbVVPbVeAet+VqzsQMr7oifUjn6s4cIrQ4jUk6ELy0RlraSaI7BxycQFuGE55nsR336vLJS/qNAuV6nlmQzw1x92HeETz5yMolaF3878bj2SnWUYBvjR+XSA7vz5SFkCNh22VtG9UzoYQ2EuYr7vwfEYvFKiTDDT+/ZvWf4CG+ac6aqwYT6DskHr2c4Mf3i5+7dvWCRVfI9Ih/2BgRi94mqkQYhRpnzBVa3rmAeoWg69pw995jFLsYfGskpU8T2+UTgpHdciew==
X-YMail-OSG: 5pNhyP8VM1kjQP5LAZGyGUgVYlkZqrqp6BElb1VodVrV9v0R0qoBWXCCnDgWKjH
 LEIpftq2Dixq9jsu0Sbeq5UgpS9kYn1vLkrUD70wmSFTKOA.dLa7kTZeVTtPebiYJVza_GiZxPOD
 ldvsYdsEfJFmlz5ndjSxhJJ1W9bl7RP_eLhgYepwy735TPcwi5GHbwacRwCZOR4XrPXAQdHZWU_g
 zNQb2XCKSDuAqREOb9ZMysUAOVHZ6bvrLE2yDJURKlOzBXRjvuTnNLDqkWSUD06hWGWh5s7WYYc7
 eAW0wf7EoZOeueGdHSH8qSGufhokUQG3cpX064gHSaFs_BZ_oAinuMoLINoC9wFaZLGEJyXas1pv
 YQ.Save1odCOHZfChiI2vyqYOVMv4hVzZ86n8cLGBeYRT126rlXCrGQoMsp2y4LU.gDpUc8zsxMF
 N8KMpmul6LqQmlOU3OOb2ucJXngCjIZm1zZyCghDv65xXgtlFWQlw.z6f_0TD71Xo9XUQ55D8nKW
 aShgCHAf9dmltY3cKXfmByTRIwV8kZKS.SpevDZ9LBKPhlzRd9r2aDSrKscrcSYqwgBexox.EYM1
 yXQ_s4GesXEa.v4yxpyJotkCW1j8t6nxxR8oSSC_Zs5lB4X5B0p6bxW5HTF3i6QOyJpm4NykObhx
 F6T3vXQrdTYPP9J.1twiKGfhpIR7QxuDVV_YX8fSUBZ4HixOWAsV64A8ehMZOar1nQDeE4k0Kplj
 2LGH3rmV3FoY938a7F43ug5QP0miLbwSo9jB0KPZKQMkNEGmfCO2uz.yUPVGeMa7d6Na_8m_A6NP
 2053QY6HU6L4b3KtWFB3lPTb6My4Yav.O8fPutf_k_9D98o5_k8Ud79g7PxNwWO.ZbWcZO73omtF
 olzJds6C2C3k7J2yID6fkOoNfiXROh4yLhLOalp.TxhcplDlsmcR.qGd1.xuptR.x8qVajTp8cEy
 KnIIa2b67xZZjaM56gf7jlkQN3wbBT0IxGUHxie6.wgK88qHLDjR6ORtmCqXTehKMDut4QBuG9jA
 eloxk92KoAppaE6wJvlZtFmcZil3NJJNPYuYxdybNFU_uJezSt6f.RPei63IYA4ngAhlYVPJ8meZ
 N4a5bpSGnMG8uxGWy8UpNpEWILVIPwYeuPX6xuDbJduaOvAeFUoqSR1IPZD29
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 102fe805e930c993b64b67f47c5c2e96;
          Tue, 09 Apr 2019 20:00:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 30/59] NET: Remove netfilter scaffolding for lsm_export
Date:   Tue,  9 Apr 2019 12:58:55 -0700
Message-Id: <20190409195924.1509-31-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

