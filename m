Return-Path: <SRS0=Np7y=OH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF15C43441
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 18:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579F5206B2
	for <selinux@archiver.kernel.org>; Wed, 28 Nov 2018 18:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="CGLDpemi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579F5206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbeK2FrH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:47:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35868 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeK2FrH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 00:47:07 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so17474027qkf.3
        for <selinux@vger.kernel.org>; Wed, 28 Nov 2018 10:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QTh0JeC4zqOc4EOBbXz1J3I4PC6Dej6hUKmyWcjnHc0=;
        b=CGLDpemi/iTHb0U1XSDSyhzkMD90fvid+BaYKqQhy2ASJ4a9r2t3cr5pwVkX/sE5NU
         ZJKXNdrwwycK/ZYR8FeVNzloovmV4J7FCRrfgD3A1xisOWI/mYwSygaiqR1qGyKTilMt
         nSsiV0hVYF6USsoGgXwlf3gFGUkobFaB+NAh797V3fw/de0I8W7kY3qu9qQ6duZRmxLw
         BfMUi3U4Spcpnnn6bkhPT+O4X+MD19iYkfPXGDdDT1gucmuSpgryS9ef5rQjs5UTcEnm
         yz/ToM6DUdN2EUI4ht9gPh6adx+bv7ldyBkJxyfjsi+Ny+1MJxiioqku7JQ9TtWYnNGK
         0nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=QTh0JeC4zqOc4EOBbXz1J3I4PC6Dej6hUKmyWcjnHc0=;
        b=TUo8HJ3D9x7SGRAy4JSJSBprgbYf6qvSnPr3hRd6KJlSIbalx+8ltsLHFbJs6iViWL
         Xd1hKEHlOoBQ49Q4RWVrc9x33rPqGmAG52ZkMtqBYfeAZF0ctMyMC7dZhTSy4lGo6aSm
         JhTLd/0hZSvSs/sY0GB+oSFrPtxJu2JejLfQX2K/srexkU5SBJ1RWgEcvJFwD3EoGX+O
         LNvLwDWECWaHieTDM9wSoxxE3byeBSYjrIqNIaNcb/4rQAfbJY/cNPh1+3fQ3dQUfZDZ
         R3qJV00P+ADY3Jef37+a5I8p86kut6izXSG4A0gDDCWRCjiBT5JeoM2jBzMOrNR3J6Wk
         4scg==
X-Gm-Message-State: AA+aEWaH6L4S2XbGMWoZXNqI40gBa57aXLuumXyVtRmFhkqZq3vww50o
        5JKU7aw1PhmIzC+Qz3eFMc96yogTUw==
X-Google-Smtp-Source: AFSGD/W0o8n4vmCLbJ5UbEHAcLvn4MV9C/lhB9a1GnAp2KyTt2kC9B6PH6aAQGp06QL2y7kMV5oFIA==
X-Received: by 2002:a37:3753:: with SMTP id e80mr34020821qka.207.1543430670497;
        Wed, 28 Nov 2018 10:44:30 -0800 (PST)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id 21sm5965183qkr.89.2018.11.28.10.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 10:44:29 -0800 (PST)
Subject: [PATCH] selinux: add support for RTM_NEWCHAIN, RTM_DELCHAIN,
 and RTM_GETCHAIN
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     netdev@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>
Date:   Wed, 28 Nov 2018 13:44:28 -0500
Message-ID: <154343066843.17825.12154246717874457759.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
added new RTM_* definitions without properly updating SELinux, this
patch adds the necessary SELinux support.

While there was a BUILD_BUG_ON() in the SELinux code to protect from
exactly this case, it was bypassed in the broken commit.  In order to
hopefully prevent this from happening in the future, add additional
comments which provide some instructions on how to resolve the
BUILD_BUG_ON() failures.

Fixes: 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
Cc: <stable@vger.kernel.org> # 4.19
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/nlmsgtab.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 74b951f55608..9cec81209617 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -80,6 +80,9 @@ static const struct nlmsg_perm nlmsg_route_perms[] =
 	{ RTM_NEWSTATS,		NETLINK_ROUTE_SOCKET__NLMSG_READ },
 	{ RTM_GETSTATS,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
 	{ RTM_NEWCACHEREPORT,	NETLINK_ROUTE_SOCKET__NLMSG_READ },
+	{ RTM_NEWCHAIN,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELCHAIN,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETCHAIN,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
 };
 
 static const struct nlmsg_perm nlmsg_tcpdiag_perms[] =
@@ -158,7 +161,11 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 
 	switch (sclass) {
 	case SECCLASS_NETLINK_ROUTE_SOCKET:
-		/* RTM_MAX always point to RTM_SETxxxx, ie RTM_NEWxxx + 3 */
+		/* RTM_MAX always points to RTM_SETxxxx, ie RTM_NEWxxx + 3.
+		 * If the BUILD_BUG_ON() below fails you must update the
+		 * structures at the top of this file with the new mappings
+		 * before updating the BUILD_BUG_ON() macro!
+		 */
 		BUILD_BUG_ON(RTM_MAX != (RTM_NEWCHAIN + 3));
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
 				 sizeof(nlmsg_route_perms));
@@ -170,6 +177,10 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 		break;
 
 	case SECCLASS_NETLINK_XFRM_SOCKET:
+		/* If the BUILD_BUG_ON() below fails you must update the
+		 * structures at the top of this file with the new mappings
+		 * before updating the BUILD_BUG_ON() macro!
+		 */
 		BUILD_BUG_ON(XFRM_MSG_MAX != XFRM_MSG_MAPPING);
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_xfrm_perms,
 				 sizeof(nlmsg_xfrm_perms));

