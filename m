Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE176C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 14:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB51218E2
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 14:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfCVOOi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:14:38 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfCVOOi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Mar 2019 10:14:38 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N33V5-1gzeo127WX-013LMl; Fri, 22 Mar 2019 15:14:16 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: avoid uninitialized variable warning
Date:   Fri, 22 Mar 2019 15:14:10 +0100
Message-Id: <20190322141414.496017-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:w5V6K7pdZn5HEIo8LT9QcLMEh4jms0YhMHN7c3bwHTP5qxKGPLN
 q0MoxjZIjCcvUgedvnGJmvU1IN9AGQDT3QM/B/0iyu0ctg1pn6qysIHcvi/EFyQ56GRQmuH
 zIy+n2vtRi0rjqQxmA0YRsPizw9ZY72fYDVqDF1nF0K2Y8vkKmAvNpzW4yCA+DekQiapLAL
 J6y5ZuUKwmxkNXiGWUhoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W6BJY4dw72c=:54tRuohkmB2xo+1BD2tbGs
 460fwgnCO7QsjOMSC/6XJE2dmDYWv/O3+zeurS2OEYAwHURPOF5WWJ6ZbkJU5ArINMMsy3g+q
 lQnGn7cItz5/YIDDQMSlbTdR8B9bMvFopMne1XqBz1bBRDyzsD6JuwL8NJTHWJjPCwqPv9/Ir
 j8u6VjKh+oVH+IpfKZL7TEvOVztdJqcXti43Rd3/g+Yk0/o9jZpg9aAdpDAFoed9KdC9d737q
 D5T8xWKSa9QtLu3WesjtumA5hPrGmitw4bsR4wf+OpdPIFMqxLqzFQyPJvozsgM9NGCQV/8YV
 JIMIA9a7lUYZ3byEN6Z2DfnvIevobprai0FvbhfwilNYerltuM/iXfF7xTuzXZ9SVoLEyTE9x
 /efvji4v1fHO6g4sQ0BaKHTxKTVUhyUOmCOBj/djlEFKTHOnEaUWKbVc0nmOcmQUfDv4Dqz8q
 BrSBFid93LJkvoEIAf9GbMXCnMMvVP9qsJRPAO2S5BkU5WcKsOKvdUALXfaWCNnugOhSKhwLI
 USAsprcbcexuvCWWOZKS2QqEd83ZjHVHVvuTzk117jXU2ksagTh0Ymr6Nr2o2l3CW/U9sKk1I
 QdMqeV+disgdeMeXH+DC4D5Emdn/CcJZsyxQifiMjiTn6G71+FiQcK6I3TA69AErolNGhes1k
 pCpAiBSbBudyNXOwB3HEGEGUrJyMcsLMXJ/OIXrtAPu3PqJWOwTqf0Dej394j4/qbWX9ajQgw
 EJZ8QB/dxgJyivI70rG5LB8QasEIxeIXOxZa1Q==
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

clang correctly points out a code path that would lead
to an uninitialized variable use:

security/selinux/netlabel.c:310:6: error: variable 'addr' is used uninitialized whenever 'if' condition is false
      [-Werror,-Wsometimes-uninitialized]
        if (ip_hdr(skb)->version == 4) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~
security/selinux/netlabel.c:322:40: note: uninitialized use occurs here
        rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
                                              ^~~~
security/selinux/netlabel.c:310:2: note: remove the 'if' if its condition is always true
        if (ip_hdr(skb)->version == 4) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
security/selinux/netlabel.c:291:23: note: initialize the variable 'addr' to silence this warning
        struct sockaddr *addr;
                             ^
                              = NULL
1 error generated.

This is probably harmless since we should not see ipv6 packets
of CONFIG_IPV6 is disabled, but it's better to rearrange the code
so this cannot happen.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/selinux/netlabel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 186e727b737b..d0e549d4f486 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -288,7 +288,6 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
 	int rc;
 	struct netlbl_lsm_secattr secattr;
 	struct sk_security_struct *sksec = ep->base.sk->sk_security;
-	struct sockaddr *addr;
 	struct sockaddr_in addr4;
 #if IS_ENABLED(CONFIG_IPV6)
 	struct sockaddr_in6 addr6;
@@ -310,16 +309,15 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
 	if (ip_hdr(skb)->version == 4) {
 		addr4.sin_family = AF_INET;
 		addr4.sin_addr.s_addr = ip_hdr(skb)->saddr;
-		addr = (struct sockaddr *)&addr4;
+		rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr4, &secattr);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		addr6.sin6_family = AF_INET6;
 		addr6.sin6_addr = ipv6_hdr(skb)->saddr;
-		addr = (struct sockaddr *)&addr6;
+		rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr6, &secattr);
 #endif
 	}
 
-	rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
 	if (rc == 0)
 		sksec->nlbl_state = NLBL_LABELED;
 
-- 
2.20.0

