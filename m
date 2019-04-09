Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E716FC282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99112133D
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CsQq9sdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfDIVlm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:42 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:42093
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbfDIVll (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846093; bh=VEDYIM3R1NMqedNbn6scDMcxUUfpt0y9Ccbwl5mHx6o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=CsQq9sdLMKK2JhzXxKjLJIS9qHAVhGfz7MVGqzmONkFYEL88EQq61y/tPv3dq5yhzxwqaSLp/lsk71G3kxehQ7PfH32KqHUbXEt05f2V+2cnF2VzCP3UxQCbhKlSwrnJ3v5mEbH6fPUjTCIUjFL0W+dlM6a25e9aEKeJe2zQf2kpPx8sSAK4CNTLYFuMREYI0xN2bIlOT1LGFYGd0xyWW0QNvwOHCxH1PsCaTLl6qkiGHhdluY8pzFYx2Amd0mrQjgkdzN+HJM3gnCK2DMeTk2VufbNGd06IWhDdBjs6i99sPrac1+4BAf/EOxrJ0LwN8bEF4VJqZFoENCb6vz+NqQ==
X-YMail-OSG: ElnSnMkVM1m6mIEPIVTWjS9OZgBhm1.uQDa9zsyjcVFCZmK10VC_43XGhS3mxtt
 oL84oLqkL_zDzpTQDjGSd9oT2snnvDRWjiY_zlz84NNBrBzZpcMPoIqu2MkRx3oQx03twIsCZsQ1
 9YvhhfqMl2AMk0h1oo5rVnyn0qGf73bTPvrEeWxu9WM5skkQFWEAApcO3JlnLhM0vBFhe5qJsWTi
 9mHMSYRqvpYeVbYV0D9geoZiE073uBoF8QYOY1sz9vGEv8kbQ8Hz.rV8MllE82YvCBK7lTp40Wv7
 vipuKTQWWwMBbNsKpdWOM3T6twG9yzfnR7_nMAelPR4PowoQHeQFgPKVkB42jUJ3AHlhpe4F8yRG
 PC_8O.ZayHaHu7i3X9KxUiHUNyKN_x3mQobnmKz8MJKp.wyGw6ncdMz_wl_dBdew2Q2Ko_r.ndwV
 Fy0aIkkJV6rypLU5zTnWOGh9NFXSI8bAUNbJJ5DKTzgQrLS1z37tmCs5JzOt72fQ3DPkrAs4lr9K
 Ha6jfv8d8pQZ5916sdmhDRv9kj4xTO3RTWXzSUE3Uv_6.l7yp2ntfSpuHEM5se5LkzOQk4cSc54a
 h1MQgDucEyk90zyttK6_oFUGC.cT69ZLFQkVkHoBXgnRgm2iNm5qrl0WJv_IKCRnuEKpL6zzzZH_
 4o9VNMqmP9x0i4m83K6B1rk4gPjPJ4Qhvvhk5VSjjggLYFRRKVCziojqwPcbBcGwHJQDPnHLWaOY
 STKRXRdaIs.apCR2D3oZyx_bMX7wDpX8efm50kFnUCVfoEMsQefPZfXl0JEB8hBqRSDi0DbfUW.U
 5xnC5T2G8LEQ0skECC16vpCm2p9u3Byuybj5NjHxDOtPZt.SKNzMmFVyPOd7UbyeedEjHgQLYxpz
 KQ8YZjzx6kdSCMmWJGha0kIrJtTdACiHuSXtoZP7YnNam0d3.FwfVzHCgBk0BrqPQCmnMHuVZejm
 jcpJHJcuOOeId.IqNNMKI3PD6bBhbQfWD.yIxnRetGyK37Co22iVc3jcFtS_lpvnptMtFiBHxaJ4
 LPYbQ7L7VaoigKV7PALWViH9jxRQHQRUDz7A2YO8RJbCldDyrKjswnK5DZjFknOkVngfA.a15aZz
 TYSagZEXos.dE52kxNodi470o8tsENFyoN2143RwADNtaNuCpOlgSk6TSbhaxjg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6a737b6f7572f7259a29fc213d8f0ed1;
          Tue, 09 Apr 2019 21:40:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 35/59] AppArmor: Remove unnecessary hook stub
Date:   Tue,  9 Apr 2019 14:39:22 -0700
Message-Id: <20190409213946.1667-36-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove the getpeersec_dgram hook stub. It's unnecessary
and disrupts stacking.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 24b638bd4305..76c409737370 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1094,15 +1094,9 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
  * @secid: pointer to where to put the secid of the packet
  *
  * Sets the netlabel socket state on sk from parent
+ *
+ * The TODO stub interfered with stacking and was removed - Casey
  */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb,
-					    struct lsm_export *l)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
 
 /**
  * apparmor_sock_graft - Initialize newly created socket
@@ -1202,8 +1196,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
-- 
2.19.1

