Return-Path: <SRS0=L9QR=3B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC56BC33CA2
	for <selinux@archiver.kernel.org>; Sun, 12 Jan 2020 15:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3934214AF
	for <selinux@archiver.kernel.org>; Sun, 12 Jan 2020 15:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="Lc42kDsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbgALPnb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Jan 2020 10:43:31 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25839 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733062AbgALPna (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Jan 2020 10:43:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=TpebOZGE2wj9DS1vbyFXR1OxvP3buNgiUn1PZEURTyPZdokpYso5kjjexrrATRu6mebcne9AnIwh
    aGpqroOyu/fbaj36CLKoDHCjvHzUU7M1ct801EPqFn54RnTHSyeT  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1578843793;
        s=zm2020; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=WZCWRBGh1t2SRmpgaZUMd0Pp5ss91MIxscX3R7XSddw=;
        b=Lc42kDsn5FRRKHVh8hp2zXXzP2AertqsMUS+iyql394uJ17DJn0/XXHy7r2XIrbA
        T2chrfq2GEEqj6sZ2YMUFRqLPglrtMOJb29E+aGm/JJMpHi2x7zhkKB/rQw+5Dd4lkv
        4x+Yvkb9Cq9TvAyqtqQzkYLZ+0FCX6n9X8x5EPYQ=
Received: from YEHS1XPF1D05WL.lenovo.com (123.120.59.236 [123.120.59.236]) by mx.zohomail.com
        with SMTPS id 1578843787996562.0534033364099; Sun, 12 Jan 2020 07:43:07 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
        jmorris@namei.org, serge@hallyn.com
Cc:     tyu1@lenovo.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] selinux: remove redundant selinux_nlmsg_perm
Date:   Sun, 12 Jan 2020 23:42:16 +0800
Message-Id: <20200112154216.46992-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

selinux_nlmsg_perm is used for only by selinux_netlink_send. Remove
the redundant function to simplify the code.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 security/selinux/hooks.c | 73 ++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fb1b9da..9f3f966 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5507,44 +5507,6 @@ static int selinux_tun_dev_open(void *security)
 	return 0;
 }
 
-static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
-{
-	int err = 0;
-	u32 perm;
-	struct nlmsghdr *nlh;
-	struct sk_security_struct *sksec = sk->sk_security;
-
-	if (skb->len < NLMSG_HDRLEN) {
-		err = -EINVAL;
-		goto out;
-	}
-	nlh = nlmsg_hdr(skb);
-
-	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
-	if (err) {
-		if (err == -EINVAL) {
-			pr_warn_ratelimited("SELinux: unrecognized netlink"
-			       " message: protocol=%hu nlmsg_type=%hu sclass=%s"
-			       " pig=%d comm=%s\n",
-			       sk->sk_protocol, nlh->nlmsg_type,
-			       secclass_map[sksec->sclass - 1].name,
-			       task_pid_nr(current), current->comm);
-			if (!enforcing_enabled(&selinux_state) ||
-			    security_get_allow_unknown(&selinux_state))
-				err = 0;
-		}
-
-		/* Ignore */
-		if (err == -ENOENT)
-			err = 0;
-		goto out;
-	}
-
-	err = sock_has_perm(sk, perm);
-out:
-	return err;
-}
-
 #ifdef CONFIG_NETFILTER
 
 static unsigned int selinux_ip_forward(struct sk_buff *skb,
@@ -5873,7 +5835,40 @@ static unsigned int selinux_ipv6_postroute(void *priv,
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	return selinux_nlmsg_perm(sk, skb);
+	int err = 0;
+	u32 perm;
+	struct nlmsghdr *nlh;
+	struct sk_security_struct *sksec = sk->sk_security;
+
+	if (skb->len < NLMSG_HDRLEN) {
+		err = -EINVAL;
+		goto out;
+	}
+	nlh = nlmsg_hdr(skb);
+
+	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
+	if (err) {
+		if (err == -EINVAL) {
+			pr_warn_ratelimited("SELinux: unrecognized netlink"
+			       " message: protocol=%hu nlmsg_type=%hu sclass=%s"
+			       " pig=%d comm=%s\n",
+			       sk->sk_protocol, nlh->nlmsg_type,
+			       secclass_map[sksec->sclass - 1].name,
+			       task_pid_nr(current), current->comm);
+			if (!enforcing_enabled(&selinux_state) ||
+			    security_get_allow_unknown(&selinux_state))
+				err = 0;
+		}
+
+		/* Ignore */
+		if (err == -ENOENT)
+			err = 0;
+		goto out;
+	}
+
+	err = sock_has_perm(sk, perm);
+out:
+	return err;
 }
 
 static void ipc_init_security(struct ipc_security_struct *isec, u16 sclass)
-- 
1.8.3.1


