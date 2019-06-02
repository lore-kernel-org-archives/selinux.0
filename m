Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D38C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EF22794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="COGJbiyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfFBQw5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:57 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:45092
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbfFBQw4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494375; bh=KYlupIPcbLYAYHDyLLLdG0LtZrXeMUYE6GpZUguvURc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=COGJbiywFmH1VYicXCjFPRb8QmDYGRZlVLCAzu2C03hagL4GcEw9GvsfpkWlNEgNZarY+3vFG3EvqahK0MlAbCnpLBBKeQTh/q5tIBTPCpVIrMSLI+VkfriJqFjybMJfoIMSwzvgWfwNhG5KP2rgzO/6U3lO5CexvhoClnnF93TVWF7+XhuOyMMC/xxF/c9p4aZe1GJLlo7Ae+wY+IIY9TtLEKtDCy4C+IJVGnGuNkQfA9S/M7UFTVwZLvauuu2/3Jehb5V1x+XST87mQUU2VrwFCu1YeejqBDlPmQUm+HfmHTUcVruvxQLLVt0kHKztviTlY8RUn2dAdqZMPsxsBQ==
X-YMail-OSG: 5.j9xC0VM1nfcPFTkCeg319lENQlPABfpFOUrvjZJ5VqT7XdWJQNC2vXZB6NSHf
 9EegudsXpEhZccqS27wmDxWPgmcX3c_VFTc3w_fO_n8aK01og2uFBKXbzAChyUIFP_BtCScg5_fX
 KkooX6rCbQBu4_q5jRPsFq5w2Icpf4YCiL80cnYXpFK4uuRn_1XAqN5MwRK1ixV1D6vaSVe_rV8_
 HMVY2ZEALZSVGcfDmpz9SR3dEG2tEZL_T24Y6iowFA57BC_IyyNRKf6MAN91gwQqpr.6b4pQ4Odk
 CXdHFqwV_KloCW.45ugU1H5H5Ek..mG1rpaQobvj1gDejU3woNPwNqXd3eRg3eL6UWyGgFj8bxy0
 3bOZP0CoYINgh_RfeE78jwjQd4anEPBbltr4FSE5KjaLdxBiqW4Tg_o7SBZRZtbghjKymdbtnDHY
 fBfjG5NjhJpox3zoi9PXAiB9uBSxVwMaNMvptE_583FaSpIJujV8cX4szQK72qc_J7Y.PiN7Gs7y
 KsGDB1zDbjHDaIHOV7FmttcPS64Ao_Qe4wWaFuqEmXe1tm0LEpld5HoDEOILRb35y4Qv9JUVS8qT
 87TYB3AnI936pOzUo5tWzLVApFaNz5Fw6X7fCcm58L7s1t.U3bUMjDsdDJI5yWuBEGTEg10EkWZK
 DwfIyaQpNO6TcqsK9Bd3FvQ0k15YdIsGWyKRlpB8K.MokD6KiOWa6QcOlLMoMO4x8.U5XY.Tw115
 TRqyzet1r8A49acCw0r6voBAV2s9ImcEzf06FV0lFXw7CxhL54PZe8mrc2ZaYY5QUwwZwP.9GVmt
 pUh2RfxF6aWIzzGhwTExsWUShNsu5i9TM8TIOXOfMVcR3SYktrWY5sWYdFtbx6ai61qwH3AxPvzO
 GWbpd4fnydiEJvUjhNLqhsJRx1nyLGLYvehyR36de1pvZQH8gI6pcWaLZJiZ12kW5vPOrLeZk_9k
 8D04gDwjwa4mSbi5SMP_MEEFDTH17Ui5p1c_EL2j0FttfjWhH26h9LxJzZijsV.CtoMuvWqTliYS
 gZHMlw9f_GXVYEsirZvS7Fh1S4f9c2nOUrWFKQbtOfE9jlttuLFA32fHzdlo.KKSRuCPU2l6q3G3
 9DLFfana8tnN3jb1NN3accVj3zB1AroeqYg9GZcxnDAHIusRMyU6pJ3nd9URIhcT347iAX1VhYCJ
 TBISKpxFdh1ie7.Agpi2GJVRwPlncDCWcvlnbszVyGLPnvRJL_R5ti97kFhEWSdVoFEHqxf60UCr
 oehbbBVQuFnWyrB6p6GROujmvCtIUSoHdTupkjheKDCtdg3ZP6OS7BQpbrTc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:55 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0c0e3da8255eb26ca342a489fa1b8a19;
          Sun, 02 Jun 2019 16:52:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 29/58] NET: Remove netfilter scaffolding for lsm_export
Date:   Sun,  2 Jun 2019 09:50:32 -0700
Message-Id: <20190602165101.25079-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

