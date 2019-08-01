Return-Path: <SRS0=gk/B=V5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C84CC19759
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 21:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213532080C
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 21:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Mb7i98Ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbfHAVzK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:55:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38933 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbfHAVzK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Aug 2019 17:55:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so71854644qtu.6
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2019 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=U8qCtST6T5dgar4CjgF0sHchOCsctlAW7a83LjfEHM4=;
        b=Mb7i98Koi3+M6tHKpP/xsc0OVMiReK/kWGjunMO+lazxhptZL81JAE5kEISM5Oc0T9
         tzFrCoLVq6zu94PJrkRKYMeeZAEUSOQCgkND2sQXamu6XMSwat3MAPk3yY8LVNVKUQmc
         lDz77JURNkKffzjdj76PWKZ8JtdXbQAWpxhoUpWTadNFSRtTFPmGYpo4I4tHhtCcRT0r
         mIS/24AFEEJ/wqtV4GVNraMkwqf53xgQ0fql8zHV0SwhqnTRmtSHInZ8dtze8EsaFvNr
         qcy5sKOMN0SH331FfGb4A7C3lDL5rHSRwOrzhDra7nPdrAKF8uwI57ujtNi2mB6Kxb57
         8c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=U8qCtST6T5dgar4CjgF0sHchOCsctlAW7a83LjfEHM4=;
        b=ka1FPF3aVBE++pUK/Qpdg5cQSsyJXuiFwQW7z9ULy/XCbWzj88sb287BaIkmFul8Mm
         TfWx2TKIH6O8Xmuz+AXNXwQxZ/zZPz5XAI47hIJpz4dscNHyDDgCcGuiJWQMDa7U4tCm
         PggriRaP7tkKEzUwfu4a4kEBQiJ8bPDlHNhoVa3UnJdGJGop2kd7DTE1n+SUtDoC1i8R
         JLQsCtXC1Itgi/MCmheRoHFXpkyyTX+7PKD32gavpf6OMhgQIzVMVfxyECRUgkE+FK1l
         XfrMSuegtd2rdCUkxt9dS7+kYtgCcmQnyapgbvJmSwKAEfrgmwQt7ccY/Dkjp04nEphF
         GnpA==
X-Gm-Message-State: APjAAAW3NdcmzOC7zUawgZtVe/Ntfrq1XnjaDkqC5hO7Ya02GScQJm1r
        DNJfwcSAU8FBLCzlDAW24FxXgE4=
X-Google-Smtp-Source: APXvYqxcznvHNH8d6oAB5aYppWjM43fHwVQAjHJlaPSzwaEBIU3J+fEgOA/kh/H+9its1KZWi9xN0A==
X-Received: by 2002:ac8:26d9:: with SMTP id 25mr94566109qtp.377.1564696508555;
        Thu, 01 Aug 2019 14:55:08 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id v1sm31211519qkj.19.2019.08.01.14.55.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 14:55:07 -0700 (PDT)
Subject: [PATCH] selinux: always return a secid from the network caches if we
 find one
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Thu, 01 Aug 2019 17:55:06 -0400
Message-ID: <156469650636.3483.8884306975486053452.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Previously if we couldn't find an entry in the cache and we failed to
allocate memory for a new cache entry we would fail the network object
label lookup; this is obviously not ideal.  This patch fixes this so
that we return the object label even if we can't cache the object at
this point in time due to memory pressure.

The GitHub issue tracker is below:
 * https://github.com/SELinuxProject/selinux-kernel/issues/3

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/netif.c   |   31 +++++++++++++------------------
 security/selinux/netnode.c |   30 ++++++++++++++----------------
 security/selinux/netport.c |   24 +++++++++++-------------
 3 files changed, 38 insertions(+), 47 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 8c738c189942..cbe6ec246412 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -135,9 +135,9 @@ static void sel_netif_destroy(struct sel_netif *netif)
  */
 static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 {
-	int ret;
+	int ret = 0;
 	struct sel_netif *netif;
-	struct sel_netif *new = NULL;
+	struct sel_netif *new;
 	struct net_device *dev;
 
 	/* NOTE: we always use init's network namespace since we don't
@@ -154,32 +154,27 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 	netif = sel_netif_find(ns, ifindex);
 	if (netif != NULL) {
 		*sid = netif->nsec.sid;
-		ret = 0;
 		goto out;
 	}
-	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (new == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	ret = security_netif_sid(&selinux_state, dev->name, &new->nsec.sid);
-	if (ret != 0)
-		goto out;
-	new->nsec.ns = ns;
-	new->nsec.ifindex = ifindex;
-	ret = sel_netif_insert(new);
+
+	ret = security_netif_sid(&selinux_state, dev->name, sid);
 	if (ret != 0)
 		goto out;
-	*sid = new->nsec.sid;
+	new = kzalloc(sizeof(*new), GFP_ATOMIC);
+	if (new) {
+		new->nsec.ns = ns;
+		new->nsec.ifindex = ifindex;
+		new->nsec.sid = *sid;
+		if (sel_netif_insert(new))
+			kfree(new);
+	}
 
 out:
 	spin_unlock_bh(&sel_netif_lock);
 	dev_put(dev);
-	if (unlikely(ret)) {
+	if (unlikely(ret))
 		pr_warn("SELinux: failure in %s(), unable to determine network interface label (%d)\n",
 			__func__, ifindex);
-		kfree(new);
-	}
 	return ret;
 }
 
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index afa0d432436b..df590aaa33f4 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -199,9 +199,9 @@ static void sel_netnode_insert(struct sel_netnode *node)
  */
 static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 {
-	int ret = -ENOMEM;
+	int ret;
 	struct sel_netnode *node;
-	struct sel_netnode *new = NULL;
+	struct sel_netnode *new;
 
 	spin_lock_bh(&sel_netnode_lock);
 	node = sel_netnode_find(addr, family);
@@ -210,38 +210,36 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 		spin_unlock_bh(&sel_netnode_lock);
 		return 0;
 	}
+
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (new == NULL)
-		goto out;
 	switch (family) {
 	case PF_INET:
 		ret = security_node_sid(&selinux_state, PF_INET,
 					addr, sizeof(struct in_addr), sid);
-		new->nsec.addr.ipv4 = *(__be32 *)addr;
+		if (new)
+			new->nsec.addr.ipv4 = *(__be32 *)addr;
 		break;
 	case PF_INET6:
 		ret = security_node_sid(&selinux_state, PF_INET6,
 					addr, sizeof(struct in6_addr), sid);
-		new->nsec.addr.ipv6 = *(struct in6_addr *)addr;
+		if (new)
+			new->nsec.addr.ipv6 = *(struct in6_addr *)addr;
 		break;
 	default:
 		BUG();
 		ret = -EINVAL;
 	}
-	if (ret != 0)
-		goto out;
-
-	new->nsec.family = family;
-	new->nsec.sid = *sid;
-	sel_netnode_insert(new);
+	if (ret == 0 && new) {
+		new->nsec.family = family;
+		new->nsec.sid = *sid;
+		sel_netnode_insert(new);
+	} else
+		kfree(new);
 
-out:
 	spin_unlock_bh(&sel_netnode_lock);
-	if (unlikely(ret)) {
+	if (unlikely(ret))
 		pr_warn("SELinux: failure in %s(), unable to determine network node label\n",
 			__func__);
-		kfree(new);
-	}
 	return ret;
 }
 
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 7a141cadbffc..936d630a938d 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -147,9 +147,9 @@ static void sel_netport_insert(struct sel_netport *port)
  */
 static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 {
-	int ret = -ENOMEM;
+	int ret;
 	struct sel_netport *port;
-	struct sel_netport *new = NULL;
+	struct sel_netport *new;
 
 	spin_lock_bh(&sel_netport_lock);
 	port = sel_netport_find(protocol, pnum);
@@ -158,25 +158,23 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 		spin_unlock_bh(&sel_netport_lock);
 		return 0;
 	}
-	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (new == NULL)
-		goto out;
+
 	ret = security_port_sid(&selinux_state, protocol, pnum, sid);
 	if (ret != 0)
 		goto out;
-
-	new->psec.port = pnum;
-	new->psec.protocol = protocol;
-	new->psec.sid = *sid;
-	sel_netport_insert(new);
+	new = kzalloc(sizeof(*new), GFP_ATOMIC);
+	if (new) {
+		new->psec.port = pnum;
+		new->psec.protocol = protocol;
+		new->psec.sid = *sid;
+		sel_netport_insert(new);
+	}
 
 out:
 	spin_unlock_bh(&sel_netport_lock);
-	if (unlikely(ret)) {
+	if (unlikely(ret))
 		pr_warn("SELinux: failure in %s(), unable to determine network port label\n",
 			__func__);
-		kfree(new);
-	}
 	return ret;
 }
 

