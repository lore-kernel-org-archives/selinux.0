Return-Path: <SRS0=INWG=WR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0649CC3A59E
	for <selinux@archiver.kernel.org>; Wed, 21 Aug 2019 13:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CC32339F
	for <selinux@archiver.kernel.org>; Wed, 21 Aug 2019 13:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHkey7/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfHUNp4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:45:56 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:42657 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfHUNp4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Aug 2019 09:45:56 -0400
Received: by mail-qt1-f202.google.com with SMTP id e22so2667089qtp.9
        for <selinux@vger.kernel.org>; Wed, 21 Aug 2019 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VdxLqqxvQ1VVL4avZcCP2yW2lIouW/66kNiFtbKiPXE=;
        b=gHkey7/PD0UJhXQQW4Ne8NtSP3Z8k+K80R5bIzurTx910qku1Vp/kva0nYk/9F3YUb
         WrlMXwuWYDYMRH7FV2Prs8R2WXc9uj+RTVwVQYL4zFV/bS/tAaz2jIph3vMZHchvNMyF
         81rzpX5DOlmIlnSkNy+wtLoLjrLIJyZuEvOCaw9idbJUDXE3dC11gOv77hNSmF68kgy0
         dhBcoGTUWHlmNa8EchhunYFu4iNWr12/Mw9mzVAiL1Jgcud8eFpisaRcJjGNXysg9gbi
         6Pf0t2zmsTvdjfa1t3faLaFs8KMxp1utvD1aPs9RiR14Kpp+n/SX5yQQgdCHFRT/ZvuP
         NAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VdxLqqxvQ1VVL4avZcCP2yW2lIouW/66kNiFtbKiPXE=;
        b=cv3jyNcHXHRaJsQcz/xWTchqVdJ5i6McnUbjPhWAwhurHMfN6f98G52Q0ltx5tQDDB
         8h9KmRbYo9bcH6wB/UVH9N5RxYXJk6LGUtaA5ctTeZwDRyoZCi/68wDhQgt7XKItQvc1
         IqihUGthJkjPKBkno1ilIqcPV06vmsxtr4MYXjmkLRAbjtJKYre5kRnssDfJunOv+jM+
         ZyWrCIo6xV8gEgihQy+9PSet18pSYUNsO5z2aWF3lMcqjfZp5kpu9sf3YggHDIPdKNZy
         xnGHPJMJ1Q6WEGyCVO0wfcdeLWqUIisxpBJktjOXmLyrVNds7fhJVwNoH1kUTyZn9EiN
         r4iw==
X-Gm-Message-State: APjAAAUOpETB2nyS53pd0D4pN6EoMsMsZsbBR6GKsdgip/GQQLRARwJ/
        /iQX8UB5qAd2sAqhLzY+HXhd+sLsEA==
X-Google-Smtp-Source: APXvYqxnhmNIUPYTp4W5dlnL3rMXrWtp2gSX8a3JW01dlQM5PCQUUxjjpcVLLvN0hGeKH2QuSr9cWiZKQg==
X-Received: by 2002:a37:7404:: with SMTP id p4mr15572175qkc.476.1566395154861;
 Wed, 21 Aug 2019 06:45:54 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:45:47 +0200
Message-Id: <20190821134547.96929-1-jeffv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 1/2] rtnetlink: gate MAC address with an LSM hook
From:   Jeff Vander Stoep <jeffv@google.com>
To:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

MAC addresses are often considered sensitive because they are
usually unique and can be used to identify/track a device or
user [1].

The MAC address is accessible via the RTM_NEWLINK message type of a
netlink route socket[2]. Ideally we could grant/deny access to the
MAC address on a case-by-case basis without blocking the entire
RTM_NEWLINK message type which contains a lot of other useful
information. This can be achieved using a new LSM hook on the netlink
message receive path. Using this new hook, individual LSMs can select
which processes are allowed access to the real MAC, otherwise a
default value of zeros is returned. Offloading access control
decisions like this to an LSM is convenient because it preserves the
status quo for most Linux users while giving the various LSMs
flexibility to make finer grained decisions on access to sensitive
data based on policy.

[1] https://adamdrake.com/mac-addresses-udids-and-privacy.html
[2] Other access vectors like ioctl(SIOCGIFHWADDR) are already covered
by existing LSM hooks.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 include/linux/lsm_hooks.h |  8 ++++++++
 include/linux/security.h  |  6 ++++++
 net/core/rtnetlink.c      | 12 ++++++++++--
 security/security.c       |  5 +++++
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index df1318d85f7d..dfcb2e11ff43 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -728,6 +728,12 @@
  *
  * Security hooks for Netlink messaging.
  *
+ * @netlink_receive
+ *	Check permissions on a netlink message field before populating it.
+ *	@sk associated sock of task receiving the message.
+ *	@skb contains the sk_buff structure for the netlink message.
+ *	Return 0 if the data should be included in the message.
+ *
  * @netlink_send:
  *	Save security information for a netlink message so that permission
  *	checking can be performed when the message is processed.  The security
@@ -1673,6 +1679,7 @@ union security_list_options {
 	int (*sem_semop)(struct kern_ipc_perm *perm, struct sembuf *sops,
 				unsigned nsops, int alter);
 
+	int (*netlink_receive)(struct sock *sk, struct sk_buff *skb);
 	int (*netlink_send)(struct sock *sk, struct sk_buff *skb);
 
 	void (*d_instantiate)(struct dentry *dentry, struct inode *inode);
@@ -1952,6 +1959,7 @@ struct security_hook_heads {
 	struct hlist_head sem_associate;
 	struct hlist_head sem_semctl;
 	struct hlist_head sem_semop;
+	struct hlist_head netlink_receive;
 	struct hlist_head netlink_send;
 	struct hlist_head d_instantiate;
 	struct hlist_head getprocattr;
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f7441abbf42..46b5af6de59e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -382,6 +382,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 			 char **value);
 int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
+int security_netlink_receive(struct sock *sk, struct sk_buff *skb);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
@@ -1162,6 +1163,11 @@ static inline int security_setprocattr(const char *lsm, char *name,
 	return -EINVAL;
 }
 
+static inline int security_netlink_receive(struct sock *sk, struct sk_buff *skb)
+{
+	return 0;
+}
+
 static inline int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
 	return 0;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1ee6460f8275..7d69fcb8d22e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1650,8 +1650,16 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		goto nla_put_failure;
 
 	if (dev->addr_len) {
-		if (nla_put(skb, IFLA_ADDRESS, dev->addr_len, dev->dev_addr) ||
-		    nla_put(skb, IFLA_BROADCAST, dev->addr_len, dev->broadcast))
+		if (skb->sk && security_netlink_receive(skb->sk, skb)) {
+			if (!nla_reserve(skb, IFLA_ADDRESS, dev->addr_len))
+				goto nla_put_failure;
+
+		} else {
+			if (nla_put(skb, IFLA_ADDRESS, dev->addr_len,
+				    dev->dev_addr))
+				goto nla_put_failure;
+		}
+		if (nla_put(skb, IFLA_BROADCAST, dev->addr_len, dev->broadcast))
 			goto nla_put_failure;
 	}
 
diff --git a/security/security.c b/security/security.c
index 250ee2d76406..35c5929921b2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1861,6 +1861,11 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	return -EINVAL;
 }
 
+int security_netlink_receive(struct sock *sk, struct sk_buff *skb)
+{
+	return call_int_hook(netlink_receive, 0, sk, skb);
+}
+
 int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
 	return call_int_hook(netlink_send, 0, sk, skb);
-- 
2.23.0.rc1.153.gdeed80330f-goog

