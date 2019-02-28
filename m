Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2B7C10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A4820851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Oh8/9Oc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfB1WUM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:12 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:41154
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729849AbfB1WUG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392406; bh=TqFt4zRbObQqWQnSyYrS5KX3V7rGzJAbZlzxUBMPhvA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Oh8/9Oc59baoezBg7S5fD9pK31vyr4Bi9muOMNVgbzF5cGH7OT8ZH401QpqC8sbqSfia1LjAMwGnxJ+GJgBaiqwT+uuZVF9KdljznKykwXP9GX62Lh+J/gPL+so64ui4seeh9w0hotBw/pBrTHlaA8ZCJ7ab+BCj+dN+FKUAITPG6bJYf4uypebxp4I7xyNCI7hW6vMZ0jjMUcCmpmmejKcHs4Ol8J1on8SBx/qowrB+WvMZVYs7Mxrc1OLVE89/Gf8hl3BHfN66XdXaWpwYDuI20RQ7pjQRNeFGMS9DbtasQh6Y+wwGgYcnRIK1hn51ycOElGw4opYXffdscO3hpQ==
X-YMail-OSG: LA_AOVYVM1lRl9SN1gg7iOKUP02Dclb5QmF36ebI.73RjsWkMsa5n4EnBEkY3YA
 HTb_QgP3HcewhvU6NRWtvaK9DRybRridJSPzB.AK6KPE7Xn0PHebt8h3ZByVmt1GTElDl2Ka5JUc
 AbeQY9.CBQzRhFhcm0gWFJrxfx.xefBF37rz0wS8t3i.pLNhLwYyxE2bZHznTev70h_Lz1kIFqs6
 HcYMJyFnMM8QA7LXeAIGJUwbGWmZsHOrB.Ybo6HxUpxFgslfls4Dvx38FwG2LgChmE3RaQ5xR_gS
 ybJHAwpmPlDiSpE0yn99Rz.uefNX.czqPSfWcKrnlVJWJGUwZXyfNpFqd9zyhpFwTPJmTKfSQKZD
 xsQHPix1h0IXGUc5p7S2IgphpR0kSYRHsR8BtpccSHYQWzpTVWbeb8E1DJjejtJn4vbE.r3r9LQE
 bjsbehKkeXXe9XiD6jMn4.U.y.uh5FzCh2L_JskZiq0TwIuLeZaspZXIBg_vgX_1UwtwgDBy.A1S
 XeK1ciUIus8T1C0VG2itGsMZygdUIqq.j7pwyzgze9lrHbzUgmLk9mr69RF9DpxTLJTh6dOQIEqn
 cfeXPDGSJbM3SW5H8UwHuQ6UcGYEuwQkSJjixQ2i6ro_zulYOFR0k4KydrRRGuXeyPyQV1Z9RQWM
 l_mlsLIx69ewifcO4jEdIxqfmpzCwmR_BJ6iaQElVOoQ_bFFnYqLYw3kldVFrFLp0V926kzk7Rqo
 rnvOGVwHCHR6ScsTClpIbRCQ0yJq8Iave7SpQ05FdvxaHLP93nkVFgtyKlG3jbyh_3UF9DOSGmBJ
 Uux4cMZPH0MufmISy1PPjfqzZaA_jmPbpTAZsm6KCgMtCHh5QiFq5mAzgqpBPZCXoSpWXxmeo.Wn
 rldt02pZOFTFUXFbJAtxheSYW2JJ3CDgsuu14TzMTaLBMe_t.jVA5G9Qmp6..Qg1OBA9vKj2uiLG
 FCTrgGK5JhBp4xS9THn6clry82wdrUoNdyhfZRuw5TyKv3Inv4vCazWYqNXp9WbDN_grPuacXue3
 Hpm5yAa8u2OoPcoBi6tPfSbYc7COB9OPeCRrznbRh71vGS6BZ9uPL5iENPUChdld0YtD8o17Z_0Y
 ZLpXDozwBhxYUjSC_KSZUX27WHNLPvqIiDEeLKVm3NGAraYY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e8fded081226753664bb344863181a7a;
          Thu, 28 Feb 2019 22:20:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 36/97] NET: Remove netfilter scaffolding for lsm_export
Date:   Thu, 28 Feb 2019 14:18:32 -0800
Message-Id: <20190228221933.2551-37-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
 net/netfilter/nf_conntrack_standalone.c |  9 +++++++--
 net/netfilter/nfnetlink_queue.c         |  8 ++++++--
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index d19092fc6580..65741838985f 100644
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
index 51dc1e390d84..b47ca79b8e14 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -173,8 +173,13 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	char *secctx;
 	struct lsm_export le;
 
-	lsm_export_to_all(&le, ct->secmark);
-	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
+	/* Whichever LSM may be using the secmark */
+	lsm_export_init(&le);
+	le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK;
+	le.selinux = ct->secmark;
+	le.smack = ct->secmark;
+
+	ret = security_secid_to_secctx(&le, &secctx, &len);
 	if (ret)
 		return;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 537effb6e5be..a0670137477b 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -317,8 +317,12 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
 	if (skb->secmark) {
-		lsm_export_to_all(&le, skb->secmark);
-		security_secid_to_secctx(skb->secmark, secdata, &seclen);
+		/* Whichever LSM may be using the secmark */
+		lsm_export_init(&le);
+		le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK;
+		le.selinux = skb->secmark;
+		le.smack = skb->secmark;
+		security_secid_to_secctx(&le, secdata, &seclen);
 	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
-- 
2.17.0

