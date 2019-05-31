Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A586C46470
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E85026FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="A8bLphXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEaXOs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:14:48 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:41036 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbfEaXOr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344486; bh=KYlupIPcbLYAYHDyLLLdG0LtZrXeMUYE6GpZUguvURc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=A8bLphXAqaAANetljJULkAGdCmgl19ZdVRUBxfbXFZxvUrvl9Wp7RgMIrUDPT1cpzhYh6oEmwZN2BRSp8jgVc7tZUSuGY7JUNusXOrVoTJWZv+h5JpgJLS7ijqSpS+rRqXKERsXusq1zbZfAkSS16eVD3H+zsLVpa/+2e8/LKDM2OKmV63zMplzHLRGWoMppm6OJUTFZBNmmZC/VMic5Qjabkopw2gyYeSYrwKADGmazH1MfUyhLIGUxEyvWWQZ3hH86UPHBT3h9c/0NaRLG7IsF8O/PTNhfHmJ2tpcrB1Oe6XXh18mVNQ45Gsj9Yox73OQr0nMr3wXR4QG3+xmYSw==
X-YMail-OSG: m6CpCCoVM1mhXXlaJkJ10R5zDUWgHEYSVbivIY_4NXazI2pKnfkCeIa52oArJt1
 fx9eBj.GlTyLN3xvCYxxF5FqvRNP45E4mDKxAejkJNVJAnN1EtGs8AktVFy3KW0f3d6Q4_x7nIgm
 _hBViRUWrD6K_snDrmwn3gerVH2vAR44ziwUxAQbn8bwwH1Xn_M4NACoOUYV_4Zr34LKxtu1DEAD
 zFT0sbB3BawiMyfj4V8tW4ZIiCpB7yReLC6OK00Qv.ODFeEuEsiGJo0B1kV9kdq._3TZFYnTYJ9n
 1m.FNnQh0YYD4FaJg4IiQ1Z25mpF.KMevv8EQPCmhNeqNkrMeqkJaX8ouVw7I0X23I9RDbl5h7Vu
 ixASO1nnQqjfE3QBGr1.WWkZMtyNDmv9ug4XMlHNDzTDLnsOj8GrLJzgsBH8tc0PsjRucCeh17Dz
 2gydBgDVDLKBhY_Ktg4V5nlLsTP8D4KfsNp5Wivoz1tU4GLdiSEpoMqNE23CpUvGIxqWBTfsX0Cn
 8oNhOsoT8o0naDIfBrK.7RWzM0QAF0wxo1qWSTOY28yJLKnEAkSBKcLSeqbAXDlkQwCfztBhl.8_
 4wwptQ1Ak9NKpGXP2n8YmdUNfZDVDwHpRe4BDwnP6izCBNGGl06SyWnnkeUJYSRxQ0jjf1.qC78F
 PYfbXNcI.Mru5kB0w2vAz8Mj.QHrwublbX5NgBUUxJgmA_Qj9Gsk_jKQ31lUglxl8hAAxMBMCsmh
 D6fzKzTdKVlWijmwUnViJqNLPXvkc8oWMBPshwIGzcJj5OOCYzK23IjGFPGSOa97SKOP23AbwhQX
 S18vuZN8I_.x8UBmqTMdC_A3YiHovMhkCIk.4QJBBAcHJuAXHZ71W_DARFBPUMn2zSgYB7EYn_qX
 s4b88IcJvnhcRBsBBjYZ9ZVMVjVAvKBBwam2ad.mp7nEwulk6qQE9MkVeKYfBeD4pdWmxEnvimkz
 n2AO9Ckwk3kvm86SHEw_VaZ.Isyhi4kpLskmyY9XHTWhRwshObu9S3UHXUsmFChfv89hMvWtiYLM
 on4sEc8FdkhoYQKn0K75Ee4cs6IIzzdlL2D9fxJRGa7sZ7wglEycaEu3aE8iNfhcHliiycZULQI2
 4j6dHLE_9p0Zp4llBh2ooq01IcbNa3UP15QkiNGkI87J4YfEo_wSYBrE0esKM.hosn9.WmGVq9Tw
 L2x45nkmypu_q2Qg6zR_xJJkyvLjLl6k3SAu5EC2DNBIxH4Be4rAL0LOqwDHX7iamsBtwRgwT78l
 .fXEv82zrhpf8QlZCWn2iEhn8cyZKUmOI_kIPT04RfPT69q4glC8CtyA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:14:46 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp418.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0d7978b7ccfb88ed7fd120b8f1db518f;
          Fri, 31 May 2019 23:14:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 29/58] NET: Remove netfilter scaffolding for lsm_export
Date:   Fri, 31 May 2019 16:09:51 -0700
Message-Id: <20190531231020.628-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

