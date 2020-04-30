Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6981C47247
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 20:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2375207DD
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 20:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="s527PId3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgD3URt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgD3URt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 16:17:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB612C035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 13:17:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c63so7193329qke.2
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IGPWJ7s4KKsKqGHEmlRljdT8EWbolzYafR5EIvMCCio=;
        b=s527PId353+2wEvxrpK2k9HE8D4XQ+ckcpU7V4OWvKC8JEza2K2i+nE/rX1KUZeM6b
         GSCkEY1Z2cbN0y3bLLqt50O3DYKKDNMd1AfAHHHPY4uk68awqnYA0vTHavyBd7pTk4j0
         LhSoS/7SdFnBOSEVuays4Hm/iFW2JxQasUmrRfmKxsZQnLNPJzZjmPifYHOU8oSPd3pf
         Xo10s9eJwx/jkRGgAUCxGsqg5O027idcWcOk/PvLxnUkZn2FXwz8NBG8RXUjcS9CG39l
         cP9mwy9q8kz3y2BKWfYDw8UinNFNHhcMatrFHw5ENkvWyFHLJUJUzw+zutrmBCukQBIq
         xihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=IGPWJ7s4KKsKqGHEmlRljdT8EWbolzYafR5EIvMCCio=;
        b=UNwVG5/7Vtu7tncdpvagUwEtfD+yNnRWJj1nHbGjBrxo/rnyMsZrcd7em1nMAlokTS
         7sB2jyAlcQUNV8RTmzgvF1fYhzoUnAY7/eJCKdqDqblFgRXaqIBkhegjzzECU0bIoAgB
         bJ8zkiXyMj1Ed+5FKcPZESa/xgxi5Qfvm0VJ5GvGqr22ir7Pf0vIwDmzjVDs+VPObrP9
         9GCilYjRg+S0PkG0fDUKLqiawj1O0F0UIv/aio+galw99yvj/PfBGP8ONho0isFf8XBj
         sFD5c84x/1b40KTqyKWwj2NR85klq3Azj0JivRaoY2vSGkV+yIKuQdS6Ywgqadij6lpP
         LxrA==
X-Gm-Message-State: AGi0PubRX9rS6if1HJLTmYWPjgnuYwFtIOgE1AhIinoP4BJzu8a2rfGn
        9NSOmXlW0nfdU3VnHWh5C74zVwLLhA==
X-Google-Smtp-Source: APiQypLRwsYikHNUlMdSI3fa3JOpGbb6BxNGCu62rjaRsdWsBF3z6eGANiWK51tELS3c3ksW2P4RNg==
X-Received: by 2002:a37:6782:: with SMTP id b124mr211268qkc.383.1588277867558;
        Thu, 30 Apr 2020 13:17:47 -0700 (PDT)
Received: from localhost (pool-71-245-238-133.bstnma.fios.verizon.net. [71.245.238.133])
        by smtp.gmail.com with ESMTPSA id z18sm637002qti.47.2020.04.30.13.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 13:17:46 -0700 (PDT)
Subject: [PATCH] selinux: properly handle multiple messages in
 selinux_netlink_send()
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Thu, 30 Apr 2020 16:17:45 -0400
Message-ID: <158827786575.204093.6741581954492272816.stgit@chester>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix the SELinux netlink_send hook to properly handle multiple netlink
messages in a single sk_buff; each message is parsed and subject to
SELinux access control.  Prior to this patch, SELinux only inspected
the first message in the sk_buff.

Cc: stable@vger.kernel.org
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |   70 ++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0b4e32161b77..4c037c2545c1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5842,40 +5842,60 @@ static unsigned int selinux_ipv6_postroute(void *priv,
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	int err = 0;
-	u32 perm;
+	int rc = 0;
+	unsigned int msg_len;
+	unsigned int data_len = skb->len;
+	unsigned char *data = skb->data;
 	struct nlmsghdr *nlh;
 	struct sk_security_struct *sksec = sk->sk_security;
+	u16 sclass = sksec->sclass;
+	u32 perm;
 
-	if (skb->len < NLMSG_HDRLEN) {
-		err = -EINVAL;
-		goto out;
-	}
-	nlh = nlmsg_hdr(skb);
+	while (data_len >= nlmsg_total_size(0)) {
+		nlh = (struct nlmsghdr *)data;
+
+		/* NOTE: the nlmsg_len field isn't reliably set by some netlink
+		 *       users which means we can't reject skb's with bogus
+		 *       length fields; our solution is to follow what
+		 *       netlink_rcv_skb() does and simply skip processing at
+		 *       messages with length fields that are clearly junk
+		 */
+		if (nlh->nlmsg_len < NLMSG_HDRLEN || nlh->nlmsg_len > data_len)
+			return 0;
 
-	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
-	if (err) {
-		if (err == -EINVAL) {
+		rc = selinux_nlmsg_lookup(sclass, nlh->nlmsg_type, &perm);
+		if (rc == 0) {
+			rc = sock_has_perm(sk, perm);
+			if (rc)
+				return rc;
+		} else if (rc == -EINVAL) {
+			/* -EINVAL is a missing msg/perm mapping */
 			pr_warn_ratelimited("SELinux: unrecognized netlink"
-			       " message: protocol=%hu nlmsg_type=%hu sclass=%s"
-			       " pid=%d comm=%s\n",
-			       sk->sk_protocol, nlh->nlmsg_type,
-			       secclass_map[sksec->sclass - 1].name,
-			       task_pid_nr(current), current->comm);
-			if (!enforcing_enabled(&selinux_state) ||
-			    security_get_allow_unknown(&selinux_state))
-				err = 0;
+				" message: protocol=%hu nlmsg_type=%hu sclass=%s"
+				" pid=%d comm=%s\n",
+				sk->sk_protocol, nlh->nlmsg_type,
+				secclass_map[sclass - 1].name,
+				task_pid_nr(current), current->comm);
+			if (enforcing_enabled(&selinux_state) &&
+			    !security_get_allow_unknown(&selinux_state))
+				return rc;
+			rc = 0;
+		} else if (rc == -ENOENT) {
+			/* -ENOENT is a missing socket/class mapping, ignore */
+			rc = 0;
+		} else {
+			return rc;
 		}
 
-		/* Ignore */
-		if (err == -ENOENT)
-			err = 0;
-		goto out;
+		/* move to the next message after applying netlink padding */
+		msg_len = NLMSG_ALIGN(nlh->nlmsg_len);
+		if (msg_len >= data_len)
+			return 0;
+		data_len -= msg_len;
+		data += msg_len;
 	}
 
-	err = sock_has_perm(sk, perm);
-out:
-	return err;
+	return rc;
 }
 
 static void ipc_init_security(struct ipc_security_struct *isec, u16 sclass)

