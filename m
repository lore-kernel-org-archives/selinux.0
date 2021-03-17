Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0067DC433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 15:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8BE64F6C
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 15:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhCQPu5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhCQPuY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 11:50:24 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8FCC061763
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 08:50:24 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id n17so18631444wrq.5
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eZ0IaSrEKtqBhBUO7kHmyEE/SbgsMqZRhisBRsFJTV8=;
        b=V7xt+yDM9UTZWAWIMbyOEfzgodCexInv09lKBQeNYN2aA78GKy7WIK53kbxOX9B23W
         WxTx6CZLYLVA6LkesJXPxaGgrXwZimaNJ4dsPBZ5QceNimMaXO+P00UEq1sMsn3jxo9x
         wjR98ct7z+GYONYBiOibp11AaMMk/icEbxM5To7snSBEvfrEHtNmRzfQjkj9EDvYrO1i
         OlMipoxsiKGPvjTRGHJJkvTlSLMvx34p3FU+1gMB0mkED+TO64NxyuoSlaCsmTdUsGiF
         BUa2vKUl8YWz2AQIBJ9Ildoiw6Mxb0mVxtArWBdkhxNsUAX6urwDA1nEifC7tCCb2FrV
         hTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eZ0IaSrEKtqBhBUO7kHmyEE/SbgsMqZRhisBRsFJTV8=;
        b=p7UmytmeuXq9FFExOIi8MV5lNUx+y+Hy1GB9vsH8iPvJCELPycYFz8XDWa804MRXH7
         TdMuclugPuY41dADtZ2awDxjy72h4YZvT0lpltVmkLobdX4XVOJbJ3sGjWHPo+8W2P8n
         hIeCEj5DfHK7GcoX4cbE5XCXcyJMMTeebxAMC3M+CN/odvugbhOOazh1zq2RzvilyuPK
         qhqhTUyS8Fqk5EZFfH6udJugcznjB+IOYv7Z/Vto2hADzkpmPfWfCCs/ypOnjXOOl2+G
         FAfChZ/VP+W8Wtu3LK+31zKeGUL38U5jtALwwuKBK3Uw6ebu/Dum/5Kw948ZIpM1TR/6
         KkyA==
X-Gm-Message-State: AOAM533MSl2SWMumlBP+oUSYYivNtqabvTHrAe8mQr9kWmktbLZmxl2h
        f2RVJTHcpwIpCjr7NwmkRIU1COnfEMZxUqVFczCAlEuO3y3LS9cUJewmkWuIwbGI9mWWJm0N7wY
        LfSHK5gJkFCwvBHvPvuNa+w2iPhp79uf6g2rv1tU9/VUlE/zpTw369ql/V4jjRyPpdWCy
X-Google-Smtp-Source: ABdhPJyAihfXcNLMxfLmDlNAy51x1RvGzXsVoVv2S0gp0kZBj642cmMzEdhuNg+IZnCFBE0gBLfzQVJ5F/cmeA==
X-Received: from dbrazdil.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:7f9b])
 (user=dbrazdil job=sendgmr) by 2002:a7b:cb89:: with SMTP id
 m9mr4267737wmi.27.1615995892631; Wed, 17 Mar 2021 08:44:52 -0700 (PDT)
Date:   Wed, 17 Mar 2021 15:44:48 +0000
Message-Id: <20210317154448.1034471-1-dbrazdil@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] selinux: vsock: Set SID for socket returned by accept()
From:   David Brazdil <dbrazdil@google.com>
To:     selinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Alistair Delva <adelva@google.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For AF_VSOCK, accept() currently returns sockets that are unlabelled.
Other socket families derive the child's SID from the SID of the parent
and the SID of the incoming packet. This is typically done as the
connected socket is placed in the queue that accept() removes from.

Implement an LSM hook 'vsock_sk_clone' that takes the parent (server)
and child (connection) struct socks, and assigns the parent SID to the
child. There is no packet SID in this case.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
This is my first patch in this part of the kernel so please comment if I
missed anything, specifically whether there is a packet SID that should
be mixed into the child SID.

Tested on Android.

 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  7 +++++++
 include/linux/security.h      |  5 +++++
 net/vmw_vsock/af_vsock.c      |  1 +
 security/security.c           |  5 +++++
 security/selinux/hooks.c      | 10 ++++++++++
 6 files changed, 29 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 477a597db013..f35e422b2b5c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -329,6 +329,7 @@ LSM_HOOK(int, 0, sctp_bind_connect, struct sock *sk, int optname,
 	 struct sockaddr *address, int addrlen)
 LSM_HOOK(void, LSM_RET_VOID, sctp_sk_clone, struct sctp_endpoint *ep,
 	 struct sock *sk, struct sock *newsk)
+LSM_HOOK(void, LSM_RET_VOID, vsock_sk_clone, struct sock *sock, struct sock *newsk)
 #endif /* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fb7f3193753d..1b4e92990401 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1033,6 +1033,13 @@
  *	@sk pointer to current sock structure.
  *	@sk pointer to new sock structure.
  *
+ * Security hooks for vSockets
+ *
+ * @vsock_sk_clone:
+ *	Clone SID from the server socket to a newly connected child socket.
+ *	@sock contains the sock structure.
+ *	@newsk contains the new sock structure.
+ *
  * Security hooks for Infiniband
  *
  * @ib_pkey_access:
diff --git a/include/linux/security.h b/include/linux/security.h
index 8aeebd6646dc..ffac67058355 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1404,6 +1404,7 @@ int security_sctp_bind_connect(struct sock *sk, int optname,
 			       struct sockaddr *address, int addrlen);
 void security_sctp_sk_clone(struct sctp_endpoint *ep, struct sock *sk,
 			    struct sock *newsk);
+void security_vsock_sk_clone(struct sock *sock, struct sock *newsk);
 
 #else	/* CONFIG_SECURITY_NETWORK */
 static inline int security_unix_stream_connect(struct sock *sock,
@@ -1623,6 +1624,10 @@ static inline void security_sctp_sk_clone(struct sctp_endpoint *ep,
 					  struct sock *newsk)
 {
 }
+
+static inline void security_vsock_sk_clone(struct sock *sock, struct sock *newsk)
+{
+}
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5546710d8ac1..a9bf3b90cb2f 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -755,6 +755,7 @@ static struct sock *__vsock_create(struct net *net,
 		vsk->buffer_size = psk->buffer_size;
 		vsk->buffer_min_size = psk->buffer_min_size;
 		vsk->buffer_max_size = psk->buffer_max_size;
+		security_vsock_sk_clone(parent, sk);
 	} else {
 		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
 		vsk->owner = get_current_cred();
diff --git a/security/security.c b/security/security.c
index 5ac96b16f8fa..050b653405e0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2335,6 +2335,11 @@ void security_sctp_sk_clone(struct sctp_endpoint *ep, struct sock *sk,
 }
 EXPORT_SYMBOL(security_sctp_sk_clone);
 
+void security_vsock_sk_clone(struct sock *sock, struct sock *newsk)
+{
+	call_void_hook(vsock_sk_clone, sock, newsk);
+}
+EXPORT_SYMBOL(security_vsock_sk_clone);
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ddd097790d47..7b92d6f2e0fd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5616,6 +5616,15 @@ static int selinux_tun_dev_open(void *security)
 	return 0;
 }
 
+static void selinux_socket_vsock_sk_clone(struct sock *sock, struct sock *newsk)
+{
+	struct sk_security_struct *sksec_sock = sock->sk_security;
+	struct sk_security_struct *sksec_new = newsk->sk_security;
+
+	/* Always returns 0 when packet SID is SECSID_NULL. */
+	WARN_ON_ONCE(selinux_conn_sid(sksec_sock->sid, SECSID_NULL, &sksec_new->sid));
+}
+
 #ifdef CONFIG_NETFILTER
 
 static unsigned int selinux_ip_forward(struct sk_buff *skb,
@@ -7228,6 +7237,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
 	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
 	LSM_HOOK_INIT(tun_dev_open, selinux_tun_dev_open),
+	LSM_HOOK_INIT(vsock_sk_clone, selinux_socket_vsock_sk_clone),
 #ifdef CONFIG_SECURITY_INFINIBAND
 	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
 	LSM_HOOK_INIT(ib_endport_manage_subnet,
-- 
2.31.0.rc2.261.g7f71774620-goog

