Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C61BC43461
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 08:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955482177B
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 08:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="fnbz+UHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgIHIxo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:53:44 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:48018 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbgIHIxn (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 8 Sep 2020 04:53:43 -0400
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id D373C2A1505;
        Tue,  8 Sep 2020 10:53:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl D373C2A1505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1599555221;
        bh=wcsLtuGlvERWexCNvXDACOpmki3MXzA+prmlFD2SRVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnbz+UHSZ4Mxir6enbM0YIHQw4uLArLW1uQHBrUiYNLFVCGsjb8bRdTYedaBZUk6V
         H5JiaCwCyjjv9Hhso1Pv6moCus5PS/IKWCsQnd7+ByhFatRaDZ+dcWa8wYDVY99LqN
         EyjZkV4OK/SmdkTlSsYXLk18MVb91oYjGNz4Byx4=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH v2] cil_network_labeling_statements: fixes nodecon examples
Date:   Tue,  8 Sep 2020 10:53:29 +0200
Message-Id: <20200908085329.409762-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907174712.290567-1-dominick.grift@defensec.nl>
References: <20200907174712.290567-1-dominick.grift@defensec.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The order of the subnet and netmask is wrong and also the value of netmask is wrong for single address subnet
Use an ipaddr reserved for documentation: https://tools.ietf.org/html/rfc5737
Add ipv6 example: https://tools.ietf.org/html/rfc3849

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
I added a ip6 example because the old style netmask makes that a bit unclear. I know I will appreciate such an example later on.

 .../docs/cil_network_labeling_statements.md   | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/secilc/docs/cil_network_labeling_statements.md b/secilc/docs/cil_network_labeling_statements.md
index 49a836c1..60aec80d 100644
--- a/secilc/docs/cil_network_labeling_statements.md
+++ b/secilc/docs/cil_network_labeling_statements.md
@@ -145,12 +145,21 @@ These examples show named and anonymous [`nodecon`](cil_network_labeling_stateme
     (context context_1 (unconfined.user object_r unconfined.object low_low))
     (context context_2 (unconfined.user object_r unconfined.object (systemlow level_2)))
 
-    (ipaddr netmask_1 255.255.255.0)
-    (ipaddr ipv4_1 192.168.1.64)
+    (ipaddr netmask_1 255.255.255.255)
+    (ipaddr ipv4_1 192.0.2.64)
+
+    (nodecon ipv4_1 netmask_1 context_2)
+    (nodecon (192.0.2.64) (255.255.255.255) context_1)
+    (nodecon (192.0.2.64) netmask_1 (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
+
+    (context context_3 (sys.id sys.role my48prefix.node ((s0)(s0))))
+
+    (ipaddr netmask_2 ffff:ffff:ffff:0:0:0:0:0)
+    (ipaddr ipv6_2  2001:db8:1:0:0:0:0:0)
 
-    (nodecon netmask_1 ipv4_1 context_2)
-    (nodecon (255.255.255.0) (192.168.1.64) context_1)
-    (nodecon netmask_1 (192.168.1.64) (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
+    (nodecon ipv6_2 netmask_2 context_3)
+    (nodecon (2001:db8:1:0:0:0:0:0) (ffff:ffff:ffff:0:0:0:0:0) context_3)
+    (nodecon (2001:db8:1:0:0:0:0:0) netmask_2 (sys.id sys.role my48prefix.node ((s0)(s0))))
 
 portcon
 -------
-- 
2.28.0

