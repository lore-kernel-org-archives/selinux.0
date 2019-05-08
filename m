Return-Path: <SRS0=Lq8N=TI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17320C04AAD
	for <selinux@archiver.kernel.org>; Wed,  8 May 2019 13:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFED20644
	for <selinux@archiver.kernel.org>; Wed,  8 May 2019 13:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfEHNdN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 May 2019 09:33:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHNdN (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 May 2019 09:33:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A26C308620F;
        Wed,  8 May 2019 13:33:13 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.32.181.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9AF360C61;
        Wed,  8 May 2019 13:33:11 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, netdev@vger.kernel.org,
        Tom Deseyn <tdeseyn@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH net] selinux: do not report error on connect(AF_UNSPEC)
Date:   Wed,  8 May 2019 15:32:51 +0200
Message-Id: <7301017039d68c920cb9120c035a1a0df3e6b30d.1557322358.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 08 May 2019 13:33:13 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

calling connect(AF_UNSPEC) on an already connected TCP socket is an
established way to disconnect() such socket. After commit 68741a8adab9
("selinux: Fix ltp test connect-syscall failure") it no longer works
and, in the above scenario connect() fails with EAFNOSUPPORT.

Fix the above falling back to the generic/old code when the address family
is not AF_INET{4,6}, but leave the SCTP code path untouched, as it has
specific constraints.

Fixes: 68741a8adab9 ("selinux: Fix ltp test connect-syscall failure")
Reported-by: Tom Deseyn <tdeseyn@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 security/selinux/hooks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c61787b15f27..d82b87c16b0a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4649,7 +4649,7 @@ static int selinux_socket_connect_helper(struct socket *sock,
 		struct lsm_network_audit net = {0,};
 		struct sockaddr_in *addr4 = NULL;
 		struct sockaddr_in6 *addr6 = NULL;
-		unsigned short snum;
+		unsigned short snum = 0;
 		u32 sid, perm;
 
 		/* sctp_connectx(3) calls via selinux_sctp_bind_connect()
@@ -4674,12 +4674,12 @@ static int selinux_socket_connect_helper(struct socket *sock,
 			break;
 		default:
 			/* Note that SCTP services expect -EINVAL, whereas
-			 * others expect -EAFNOSUPPORT.
+			 * others must handle this at the protocol level:
+			 * connect(AF_UNSPEC) on a connected socket is
+			 * a documented way disconnect the socket.
 			 */
 			if (sksec->sclass == SECCLASS_SCTP_SOCKET)
 				return -EINVAL;
-			else
-				return -EAFNOSUPPORT;
 		}
 
 		err = sel_netport_sid(sk->sk_protocol, snum, &sid);
-- 
2.20.1

