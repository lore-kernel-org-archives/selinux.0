Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139E8C4167B
	for <selinux@archiver.kernel.org>; Mon, 19 Dec 2022 17:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiLSRe7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Dec 2022 12:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiLSRe4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Dec 2022 12:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C1112AAA
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 09:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671471251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mge2WhqWFyM9HhE8E4llCSfJEuyu5fUhFFg1FKTv2b0=;
        b=Xsaf6XEdWD688xboZ5B4j3QBg9VzAlaXyKnYQDIsNdJetGOSyJNsfY8h0AUmYFujNFlfgQ
        AMmrgW6NAYJjgU3+odCEh5FfuK2c/m4Lp1WhGfjtoQtoKD8Tf9AEEsv1WFt+CoDMScEtaf
        RTz9juhEoslv4B+pb86pvFXxGLuI8fM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-RwNk93g1NoyypRfJLiLUAg-1; Mon, 19 Dec 2022 12:34:06 -0500
X-MC-Unique: RwNk93g1NoyypRfJLiLUAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA3251802D50;
        Mon, 19 Dec 2022 17:34:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4D5D2166B26;
        Mon, 19 Dec 2022 17:34:04 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Subject: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
Date:   Mon, 19 Dec 2022 18:33:49 +0100
Message-Id: <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
In-Reply-To: <cover.1671469167.git.pabeni@redhat.com>
References: <cover.1671469167.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Newly added subflows should inherit the associated label
from the current process context, regarless of the sk_kern_sock
flag value.

This patch implements the above resetting the subflow sid, deleting
the existing subflow label, if any, and then re-creating a new one.

The new helper reuses the selinux_netlbl_sk_security_free() function,
and it can end-up being called multiple times with the same argument;
we additionally need to make it idempotent.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - fix build issue with !CONFIG_NETLABEL
---
 security/selinux/hooks.c    | 27 +++++++++++++++++++++++++++
 security/selinux/netlabel.c |  4 +++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3c5be76a9199..f785600b666a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5476,6 +5476,32 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
 	selinux_netlbl_sctp_sk_clone(sk, newsk);
 }
 
+static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	struct sk_security_struct *ssksec = ssk->sk_security;
+	u16 sclass;
+	u32 sid;
+	int err;
+
+	/* create the sid using the current cred, regardless of the ssk kern
+	 * flag
+	 */
+	sclass = socket_type_to_security_class(ssk->sk_family, ssk->sk_type,
+					       ssk->sk_protocol);
+	err = socket_sockcreate_sid(tsec, sclass, &sid);
+	if (err)
+		return err;
+
+	ssksec->sid = sid;
+
+	/* replace the existing subflow label deleting the existing one
+	 * and re-recrating a new label using the current context
+	 */
+	selinux_netlbl_sk_security_free(ssksec);
+	return selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
+}
+
 static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
@@ -7216,6 +7242,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sctp_sk_clone, selinux_sctp_sk_clone),
 	LSM_HOOK_INIT(sctp_bind_connect, selinux_sctp_bind_connect),
 	LSM_HOOK_INIT(sctp_assoc_established, selinux_sctp_assoc_established),
+	LSM_HOOK_INIT(mptcp_add_subflow, selinux_mptcp_add_subflow),
 	LSM_HOOK_INIT(inet_conn_request, selinux_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, selinux_inet_csk_clone),
 	LSM_HOOK_INIT(inet_conn_established, selinux_inet_conn_established),
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 1321f15799e2..8e0080b8a8ef 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -155,8 +155,10 @@ void selinux_netlbl_err(struct sk_buff *skb, u16 family, int error, int gateway)
  */
 void selinux_netlbl_sk_security_free(struct sk_security_struct *sksec)
 {
-	if (sksec->nlbl_secattr != NULL)
+	if (sksec->nlbl_secattr != NULL) {
 		netlbl_secattr_free(sksec->nlbl_secattr);
+		sksec->nlbl_secattr = NULL;
+	}
 }
 
 /**
-- 
2.38.1

