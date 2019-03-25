Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA22CC43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 12:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C208B2085A
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 12:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfCYMlS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:41:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55033 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbfCYMlS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 08:41:18 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1x2P-1gxUuA43GT-012Ijd; Mon, 25 Mar 2019 13:40:52 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] selinux: avoid uninitialized variable warning
Date:   Mon, 25 Mar 2019 13:40:45 +0100
Message-Id: <20190325124050.1285877-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9d/9dFgDs3t5g2S63jy6hB9rb1mMw//XjPFUuJMgOZtS2X9jGru
 iHn4ZHXT6INzgI9AE6VWLRVgCnpeKGxNyYwvmagYfOVaIeUy575LKola77DX+SDR47USV89
 Bsoll2kbjbrf0/JfGOCAmPR1lIwSQKLtJJ+OUAIUazqKJAnHcGb8JdzhQhhJkO5oom1KQwo
 nlptQoluEqZKd2PaKMGTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GBkGklooK8Y=:B9rIAgfjV2Ai+K/CsjDT4v
 7asOU5LWS1XlLLUu70poQ8dlA9FgjDZO1uoAEIHlLJVzjkqoQ+KOmbvt2pk3wnVJFMKu8aR+W
 cvNf8PRyQN6oN/l6XR4Az+RuLYz5yAKJEd0xi05hI5V3tYbReJNJVAoJ0Ij5KZxLyBTwDeH70
 5aOZu3fYNj08NsaBM4T3M4s3NbbuVyL5a2aaOTvwNc6XP0CZkmh7IbCPc0DdAjqaJEIMy36j2
 AwIkx8WnjEhCmfPnUiYvstkGGov4IAO0fSs90S0T4adCkGGLog21XHoCsXuQZZiVZDY0V+Cym
 zcGJ8c5L/3VfO5sZH13dSitBTjFHoE0vUaVgzNeYH/mVRFIZlud9pHfHaGluadoWbd6eT0s8g
 gyifq/daM984dSruwQgn/ppJftYTbLMZu7W/P4XK21XFt8KBYxappB9PuW1M7o09HmDIXwXOa
 RD/4Zt57SrzEv29LtbPZ03WsZdW5PKAZQeQLdIzaaMJsEIrMzAPYYa3ETVukaqDidhk7nuH5E
 jcae9riKvQw2M2gEWi/5KkzwEDWpVsEwUWcN7/waPdEoXATKLk+ar8raYsfhsSuJnd9pat1/f
 veAKJ7WPuu/uKDFtEplvCKMMic0nQl3fMps0hKojpKc0Z672tgfNCu7T9CVGzV8oGmzDqHje2
 TNHXRIchyNAtQ39AUNrI04slDwSJpfWpShU5FiHE7jsElIbCUBkngmvuky8lv0mZBv3wDvcxu
 YD6pTh9/jhlcBtdXY0djTUE9BAGSCz7rf+x5BQ==
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

This is probably harmless since we should not see ipv6 packets
of CONFIG_IPV6 is disabled, but it's better to rearrange the code
so this cannot happen.

Link: https://lore.kernel.org/patchwork/patch/1053663/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: revise after discussing with Paul Moore
---
 security/selinux/netlabel.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 186e727b737b..fb4351733450 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -288,11 +288,8 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
 	int rc;
 	struct netlbl_lsm_secattr secattr;
 	struct sk_security_struct *sksec = ep->base.sk->sk_security;
-	struct sockaddr *addr;
 	struct sockaddr_in addr4;
-#if IS_ENABLED(CONFIG_IPV6)
 	struct sockaddr_in6 addr6;
-#endif
 
 	if (ep->base.sk->sk_family != PF_INET &&
 				ep->base.sk->sk_family != PF_INET6)
@@ -310,16 +307,15 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
 	if (ip_hdr(skb)->version == 4) {
 		addr4.sin_family = AF_INET;
 		addr4.sin_addr.s_addr = ip_hdr(skb)->saddr;
-		addr = (struct sockaddr *)&addr4;
-#if IS_ENABLED(CONFIG_IPV6)
-	} else {
+		rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr4, &secattr);
+	} else if (IS_ENABLED(CONFIG_IPV6)) {
 		addr6.sin6_family = AF_INET6;
 		addr6.sin6_addr = ipv6_hdr(skb)->saddr;
-		addr = (struct sockaddr *)&addr6;
-#endif
+		rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr6, &secattr);
+	} else {
+		rc = -EAFNOSUPPORT;
 	}
 
-	rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
 	if (rc == 0)
 		sksec->nlbl_state = NLBL_LABELED;
 
-- 
2.20.0

