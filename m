Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A1CC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C370F208C3
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 17:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfEJRNi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 13:13:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfEJRNi (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 10 May 2019 13:13:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12EF43001804;
        Fri, 10 May 2019 17:13:38 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.32.181.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02C551018A2E;
        Fri, 10 May 2019 17:13:35 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, Tom Deseyn <tdeseyn@redhat.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH v3] selinux: do not report error on connect(AF_UNSPEC)
Date:   Fri, 10 May 2019 19:12:33 +0200
Message-Id: <73b14b25ad7741c9ddcef061ab65a9b7ea8811bc.1557506063.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 10 May 2019 17:13:38 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

calling connect(AF_UNSPEC) on an already connected TCP socket is an
established way to disconnect() such socket. After commit 68741a8adab9
("selinux: Fix ltp test connect-syscall failure") it no longer works
and, in the above scenario connect() fails with EAFNOSUPPORT.

Fix the above explicitly early checking for AF_UNSPEC family, and
returning success in that case.

Suggested-by: Paul Moore <paul@paul-moore.com>
Fixes: 68741a8adab9 ("selinux: Fix ltp test connect-syscall failure")
Reported-by: Tom Deseyn <tdeseyn@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - do the check for AF_UNSPEC at the begining, as suggested by Paul
v1 -> v2:
 - avoid validation for AF_UNSPEC
---
 security/selinux/hooks.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c61787b15f27..3ec702cf46ca 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4637,6 +4637,14 @@ static int selinux_socket_connect_helper(struct socket *sock,
 	err = sock_has_perm(sk, SOCKET__CONNECT);
 	if (err)
 		return err;
+	if (addrlen < offsetofend(struct sockaddr, sa_family))
+		return -EINVAL;
+
+	/* connect(AF_UNSPEC) has special handling, as it is a documented
+	 * way to disconnect the socket
+	 */
+	if (address->sa_family == AF_UNSPEC)
+		return 0;
 
 	/*
 	 * If a TCP, DCCP or SCTP socket, check name_connect permission
@@ -4657,8 +4665,6 @@ static int selinux_socket_connect_helper(struct socket *sock,
 		 * need to check address->sa_family as it is possible to have
 		 * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
 		 */
-		if (addrlen < offsetofend(struct sockaddr, sa_family))
-			return -EINVAL;
 		switch (address->sa_family) {
 		case AF_INET:
 			addr4 = (struct sockaddr_in *)address;
-- 
2.20.1

