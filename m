Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CDCC43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E722084D
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfCYOXZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:23:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfCYOXY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 10:23:24 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MzyAy-1gnt2m3QhS-00wzOF; Mon, 25 Mar 2019 15:23:18 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] selinux: avoid uninitialized variable warning
Date:   Mon, 25 Mar 2019 15:23:11 +0100
Message-Id: <20190325142317.3666259-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yehdT+ZfYZWAZLLqu0Sw+Rj6k9hADiCOlnQ/QAYfGtPNdwxd3DJ
 PbBWIDx8bpFAp2nQmmfe4sFecjF72+o+zwjBtfbKKqrcKbRGYIx+8BQixLP3gufGrquurKP
 NA+W0dLQ1DJl811lxQ7fP+YpXaY5wiju50AN4c1uzC1j7I0dWLg+g2nZOOlAqSTqwi3jrya
 z9U0LfaIfs4XoZoGWP57A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MW1T5419R2k=:HgTWk3Y/RUeG46PNGbVawj
 3/vbFkzN2MibOJpBjurOHxi3PCx9BBK0r5jZgWDEjw0KwSeXFsyTkrXKYVst+GNQK/1UEOEfr
 fF5/46Bo9XJbdlg7y+qi6Hho7EsEGqKpMbRHsg5dhaf4oIeUaYv7c1mPCg3KMHRHUK6yBaLmU
 VSKRWEaTm1lGVvjD+sz1+4UAv3TakzLPVNOYISduKBaSFp9//Mp2BGHBaxv7K4I7+jqmxNC7O
 AVvoATSfdFzNhnm4rXtWpKEajN5DNSxPkdq7qfLPkCzNuV4kKx02M5YDOtybvKgZ0GDDXkeCO
 fp1Ogg3IMJy2N3XvYkYcxPTquMiWejLAcx+tT/8uf1Dr0p99IxhgSGdFvIKbYSn1/qBV3LSyh
 XtvudIxVwZIV/QbEnXyIAYRGqnHJxUSoreVzBq2L2lAOFA1Vu2nRA+OMs1cqXCGiACEPPUulK
 2XQkN702vuj47XQgEcII0RTarIEpo31jPujbAh9eEQxsTDeOsUQM//woqFwlS+rfDJNXsDciG
 T20z3I12tOj74nA4bs3rTDaC0UYWUlYnaGWET5PysRnsdyABj47z/O9bKdxEMT6o3uiqdnVZi
 q3qoJ91c0ato025eHRSTGAeg9eFalQ13HzU1m83610wGpGIISND7j0pHNO/UTK4wirz/RtQPz
 jH/eECtwpGVSuK+EHgkp0FyqfACTCHlo5XBWxxSF3aS3tgX+lJltPmO6/rXybncy90WkhG9nw
 j0PUjQRaqbzB0vvuwfupl1lJIy9NhGacyi/Y5w==
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
v3: add missing ip_hdr(skb)->version == 6 check
v2: revise after discussing with Paul Moore
---
 security/selinux/netlabel.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 186e727b737b..f10813e54d07 100644
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
+	} else if (IS_ENABLED(CONFIG_IPV6) && ip_hdr(skb)->version == 6) {
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

