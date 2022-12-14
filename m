Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7663BC4167B
	for <selinux@archiver.kernel.org>; Wed, 14 Dec 2022 22:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiLNWDU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Dec 2022 17:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLNWDT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Dec 2022 17:03:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B52A25E
        for <selinux@vger.kernel.org>; Wed, 14 Dec 2022 14:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671055353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HyhyxRQPBcKRFEESR4J5ZAErFVsW4jq5nMw+0kspL4=;
        b=WZz3MjQ0RVwv0Gacr/cKnUw7T7yLwE8UFr4ZPzD7YKck6lfad41LwokywCURw5oqFspoRf
        ThwzL4IYmYxgGRaZU2zVOSaLAM1bQ9I1K242A622uKsaihoKsss6Nql63tWMEnS3CibAVS
        md0yz/qhjnTQmr3SVwHrgUzefH47DRI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-1vb05Q1vPMqPR1__6YnTwg-1; Wed, 14 Dec 2022 17:02:30 -0500
X-MC-Unique: 1vb05Q1vPMqPR1__6YnTwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CF0A101A521;
        Wed, 14 Dec 2022 22:02:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 878F740C2064;
        Wed, 14 Dec 2022 22:02:28 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Subject: [PATCH 1/2] security, lsm: Introduce security_mptcp_add_subflow()
Date:   Wed, 14 Dec 2022 23:01:57 +0100
Message-Id: <8a1157bafa09bbcfc42fb3617fb8512b364cd51c.1671054577.git.pabeni@redhat.com>
In-Reply-To: <cover.1671054577.git.pabeni@redhat.com>
References: <cover.1671054577.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

MPTCP can create subflows in kernel context, and later indirectly
expose them to user-space, via the owning mptcp socket.

As discussed in the reported link, the above causes unexpected failures
for server, MPTCP-enabled applications.

Let's introduce a new LSM hook to allow the security module to relabel
the subflow according to the owing process.

Link: https://lore.kernel.org/mptcp/CAHC9VhTNh-YwiyTds=P1e3rixEDqbRTFj22bpya=+qJqfcaMfg@mail.gmail.com/
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 9 +++++++++
 include/linux/security.h      | 6 ++++++
 net/mptcp/subflow.c           | 6 ++++++
 security/security.c           | 5 +++++
 5 files changed, 27 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ed6cb2ac55fa..860e11e3a26b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -343,6 +343,7 @@ LSM_HOOK(void, LSM_RET_VOID, sctp_sk_clone, struct sctp_association *asoc,
 	 struct sock *sk, struct sock *newsk)
 LSM_HOOK(int, 0, sctp_assoc_established, struct sctp_association *asoc,
 	 struct sk_buff *skb)
+LSM_HOOK(int, 0, mptcp_add_subflow, struct sock *sk, struct sock *ssk)
 #endif /* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0a5ba81f7367..84c9c4d4341e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1096,6 +1096,15 @@
  *	@skb pointer to skbuff of association packet.
  *	Return 0 if permission is granted.
  *
+ * Security hooks for MPTCP
+ *
+ * @mptcp_add_subflow
+ * 	Update the labeling for the given MPTCP subflow, to match to
+ * 	owning MPTCP socket.
+ * 	@sk: the owning MPTCP socket
+ * 	@ssk: the new subflow
+ * 	Return 0 if successful, otherwise < 0 error code.
+ *
  * Security hooks for Infiniband
  *
  * @ib_pkey_access:
diff --git a/include/linux/security.h b/include/linux/security.h
index 5b67f208f7de..137a440e8e10 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1479,6 +1479,7 @@ void security_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
 			    struct sock *newsk);
 int security_sctp_assoc_established(struct sctp_association *asoc,
 				    struct sk_buff *skb);
+int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk);
 
 #else	/* CONFIG_SECURITY_NETWORK */
 static inline int security_unix_stream_connect(struct sock *sock,
@@ -1706,6 +1707,11 @@ static inline int security_sctp_assoc_established(struct sctp_association *asoc,
 {
 	return 0;
 }
+
+int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bd387d4b5a38..43b90784d914 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1680,6 +1680,10 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 
 	lock_sock(sf->sk);
 
+	err = security_mptcp_add_subflow(sk, sf->sk);
+	if (err)
+		goto release_ssk;
+
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
 
@@ -1692,6 +1696,8 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
 	sock_inuse_add(net, 1);
 	err = tcp_set_ulp(sf->sk, "mptcp");
+
+release_ssk:
 	release_sock(sf->sk);
 
 	if (err) {
diff --git a/security/security.c b/security/security.c
index d1571900a8c7..3491a4fc2b1f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2493,6 +2493,11 @@ int security_sctp_assoc_established(struct sctp_association *asoc,
 }
 EXPORT_SYMBOL(security_sctp_assoc_established);
 
+int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
+{
+	return call_int_hook(mptcp_add_subflow, 0, sk, ssk);
+}
+
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
-- 
2.38.1

