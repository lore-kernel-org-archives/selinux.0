Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD89C47089
	for <selinux@archiver.kernel.org>; Wed,  7 Dec 2022 17:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLGRw4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Dec 2022 12:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiLGRwz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Dec 2022 12:52:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81166C70A
        for <selinux@vger.kernel.org>; Wed,  7 Dec 2022 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670435517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LOZ8x6C4D+JnlKlmoreFGr0U0F06apiXIqBr4xtjBzc=;
        b=YrFJy6AMlaxIk5aL401FeUW3v45m0Xyn2r4J2DBbYzmwVp6ZGi33vlpYqKDrMtx55aLQZl
        nfoVhkglz/kABekh+gx5W1N+Z3NVTTNug90dxmVNw9SVnXG8xGBBUVQgzf6uq9qbi7bi8j
        A3jn1ObDrbZMxbgV4OWjLXWAC53JlhU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-lxcTsvN8Nua8Xn0OFq6pzw-1; Wed, 07 Dec 2022 12:51:53 -0500
X-MC-Unique: lxcTsvN8Nua8Xn0OFq6pzw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DA7086C044;
        Wed,  7 Dec 2022 17:51:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72A4C492CA4;
        Wed,  7 Dec 2022 17:51:52 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     mptcp@lists.linux.dev
Cc:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: [PATCH mptcp-net] mptcp: fix LSM labeling for passive msk
Date:   Wed,  7 Dec 2022 18:51:29 +0100
Message-Id: <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

MPTCP sockets created via accept() inherit their LSM label
from the initial request socket, which in turn get it from the
listener socket's first subflow. The latter is a kernel socket,
and get the relevant labeling at creation time.

Due to all the above even the accepted MPTCP socket get a kernel
label, causing unexpected behaviour and failure on later LSM tests.

Address the issue factoring out a socket creation helper that does
not include the post-creation LSM checks. Use such helper to create
mptcp subflow as in-kernel sockets and doing explicitly LSM validation:
vs the current user for the first subflow, as a kernel socket otherwise.

Fixes: 0c14846032f2 ("mptcp: fix security context on server socket")
Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/net.h |  2 ++
 net/mptcp/subflow.c | 19 ++++++++++++--
 net/socket.c        | 60 ++++++++++++++++++++++++++++++---------------
 3 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index b73ad8e3c212..91713012504d 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -251,6 +251,8 @@ int sock_wake_async(struct socket_wq *sk_wq, int how, int band);
 int sock_register(const struct net_proto_family *fam);
 void sock_unregister(int family);
 bool sock_is_registered(int family);
+int __sock_create_nosec(struct net *net, int family, int type, int proto,
+			struct socket **res, int kern);
 int __sock_create(struct net *net, int family, int type, int proto,
 		  struct socket **res, int kern);
 int sock_create(int family, int type, int proto, struct socket **res);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d5ff502c88d7..e7e6f17df7ef 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1646,11 +1646,26 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 	if (unlikely(!sk->sk_socket))
 		return -EINVAL;
 
-	err = sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
-			       &sf);
+	/* the subflow is created by the kernel, and we need kernel annotation
+	 * for lockdep's sake...
+	 */
+	err = __sock_create_nosec(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
+				  &sf, 1);
 	if (err)
 		return err;
 
+	/* ... but the MPC subflow will be indirectly exposed to the
+	 * user-space via accept(). Let's attach the current user security
+	 * label to the first subflow, that is when msk->first is not yet
+	 * initialized.
+	 */
+	err = security_socket_post_create(sf, sk->sk_family, SOCK_STREAM,
+					  IPPROTO_TCP, !!mptcp_sk(sk)->first);
+	if (err) {
+		sock_release(sf);
+		return err;
+	}
+
 	lock_sock(sf->sk);
 
 	/* the newly created socket has to be in the same cgroup as its parent */
diff --git a/net/socket.c b/net/socket.c
index 55c5d536e5f6..d5d51e4e26ae 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1426,23 +1426,11 @@ int sock_wake_async(struct socket_wq *wq, int how, int band)
 }
 EXPORT_SYMBOL(sock_wake_async);
 
-/**
- *	__sock_create - creates a socket
- *	@net: net namespace
- *	@family: protocol family (AF_INET, ...)
- *	@type: communication type (SOCK_STREAM, ...)
- *	@protocol: protocol (0, ...)
- *	@res: new socket
- *	@kern: boolean for kernel space sockets
- *
- *	Creates a new socket and assigns it to @res, passing through LSM.
- *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
- *	be set to true if the socket resides in kernel space.
- *	This function internally uses GFP_KERNEL.
- */
 
-int __sock_create(struct net *net, int family, int type, int protocol,
-			 struct socket **res, int kern)
+
+/*creates a socket leaving LSM post-creation checks to the caller */
+int __sock_create_nosec(struct net *net, int family, int type, int protocol,
+			struct socket **res, int kern)
 {
 	int err;
 	struct socket *sock;
@@ -1528,11 +1516,8 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	 * module can have its refcnt decremented
 	 */
 	module_put(pf->owner);
-	err = security_socket_post_create(sock, family, type, protocol, kern);
-	if (err)
-		goto out_sock_release;
-	*res = sock;
 
+	*res = sock;
 	return 0;
 
 out_module_busy:
@@ -1548,6 +1533,41 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	rcu_read_unlock();
 	goto out_sock_release;
 }
+
+/**
+ *	__sock_create - creates a socket
+ *	@net: net namespace
+ *	@family: protocol family (AF_INET, ...)
+ *	@type: communication type (SOCK_STREAM, ...)
+ *	@protocol: protocol (0, ...)
+ *	@res: new socket
+ *	@kern: boolean for kernel space sockets
+ *
+ *	Creates a new socket and assigns it to @res, passing through LSM.
+ *	Returns 0 or an error. On failure @res is set to %NULL. @kern must
+ *	be set to true if the socket resides in kernel space.
+ *	This function internally uses GFP_KERNEL.
+ */
+
+int __sock_create(struct net *net, int family, int type, int protocol,
+		  struct socket **res, int kern)
+{
+	struct socket *sock;
+	int err;
+
+	err = __sock_create_nosec(net, family, type, protocol, &sock, kern);
+	if (err)
+		return err;
+
+	err = security_socket_post_create(sock, family, type, protocol, kern);
+	if (err) {
+		sock_release(sock);
+		return err;
+	}
+
+	*res = sock;
+	return 0;
+}
 EXPORT_SYMBOL(__sock_create);
 
 /**
-- 
2.38.1

