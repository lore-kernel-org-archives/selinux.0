Return-Path: <SRS0=INWG=WR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9FAC3A59E
	for <selinux@archiver.kernel.org>; Wed, 21 Aug 2019 13:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032BD2339F
	for <selinux@archiver.kernel.org>; Wed, 21 Aug 2019 13:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLSNKFK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfHUNqV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:46:21 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:48899 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfHUNqV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Aug 2019 09:46:21 -0400
Received: by mail-qk1-f201.google.com with SMTP id k5so2140067qke.15
        for <selinux@vger.kernel.org>; Wed, 21 Aug 2019 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rxOZiHLiXlR7oWwCjeqqkt/Tx6NEkM2JG/wKnc0+cI0=;
        b=QLSNKFK2BljYAlq+6cET1vNhCXir5M2toI8tLBH7koa2ZkMCQ/40X6Ysig01A8gd4x
         Uv+KJDMWXs5767ljAKpUxAGOOkW90VkO43TZCQdGTC07PkZ7x074B8qCz4t11rPbceOj
         qFesrjdLZNYMZJp6g6hS6QSnXYNU+LWM7jH2B//Lw8NHPE7LNUURKT9/gOqCV0wO6UVW
         S+qnDv2FmGQUm81aitsgD9Jmr3TiiB9Me2m24TC5zV9nJsep/LiWlyL1XtiWd+2b0NGC
         ai4wNEkw3glv4SBB2Ym1QUfqars9mtAT41Gi/rm4ggGz8VaFxhqY9f5jZe7VkyUCICBB
         jBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rxOZiHLiXlR7oWwCjeqqkt/Tx6NEkM2JG/wKnc0+cI0=;
        b=ZI4PgtuaXF1AeK6lgBugh3Yx0wXtzJnGYk63zcWInZFwyuCsVRyb2H7xa/sTuJjUec
         QEBS+tOS9HFTlCPX7L3DEj7AJLdB163IbPGNcFcZupZqGI8EVrWbuPEcVWfDBz1urARw
         r8h4GC8gGqPsP6J0YlFdHU4Uvc5WXZcLanyR/ri5yfl33HmKf4W3uw6Dcr0H6sHRql8H
         dZVOXCiBiFWSjD2p2U10LqVKHwfGelJqfYLWxi7CwAyBhpekQFD3GO5VyKU5vLnm3o18
         7salBQUG+GwvFER7ebhuWqDRCeBX39OsjwAMZ7jZvbhI8Qxuamh9ekLjqffiwu5grExU
         tsIA==
X-Gm-Message-State: APjAAAVITAjfHTVeGdQdJm1oUw0mMynQSIxHoV/4wEYJD/DKXxhcFko+
        rMpswyTdgDSFFsZNNqSTt+FzB+9XSQ==
X-Google-Smtp-Source: APXvYqxf61t+iGOt/jCj9FILC8WV2Oy4AeBZmfAatOmH8J1ocxdsbu6srUgHfqOWhuWwGvAOkp9pPRRB0g==
X-Received: by 2002:ac8:41d1:: with SMTP id o17mr31262970qtm.383.1566395180609;
 Wed, 21 Aug 2019 06:46:20 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:46:16 +0200
Message-Id: <20190821134616.97894-1-jeffv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 2/2] selinux: use netlink_receive hook
From:   Jeff Vander Stoep <jeffv@google.com>
To:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the nlmsg_readpriv permission to netlink_route socket class.
Currently this is only used to restrict MAC address access.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 security/selinux/hooks.c            | 6 ++++++
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 74dd46de01b6..2ab89a73f663 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5825,6 +5825,11 @@ static unsigned int selinux_ipv6_postroute(void *priv,
 
 #endif	/* CONFIG_NETFILTER */
 
+static int selinux_netlink_receive(struct sock *sk, struct sk_buff *skb)
+{
+	return sock_has_perm(current, sk, NETLINK_ROUTE_SOCKET__NLMSG_READPRIV);
+}
+
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
 	return selinux_nlmsg_perm(sk, skb);
@@ -6765,6 +6770,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(syslog, selinux_syslog),
 	LSM_HOOK_INIT(vm_enough_memory, selinux_vm_enough_memory),
 
+	LSM_HOOK_INIT(netlink_receive, selinux_netlink_receive),
 	LSM_HOOK_INIT(netlink_send, selinux_netlink_send),
 
 	LSM_HOOK_INIT(bprm_set_creds, selinux_bprm_set_creds),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 201f7e588a29..3726c61a3dd1 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -115,7 +115,7 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_IPC_PERMS, NULL } },
 	{ "netlink_route_socket",
 	  { COMMON_SOCK_PERMS,
-	    "nlmsg_read", "nlmsg_write", NULL } },
+	    "nlmsg_read", "nlmsg_write", "nlmsg_readpriv", NULL } },
 	{ "netlink_tcpdiag_socket",
 	  { COMMON_SOCK_PERMS,
 	    "nlmsg_read", "nlmsg_write", NULL } },
-- 
2.23.0.rc1.153.gdeed80330f-goog

