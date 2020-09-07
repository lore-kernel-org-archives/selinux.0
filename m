Return-Path: <SRS0=D1eb=CQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E506C43461
	for <selinux@archiver.kernel.org>; Mon,  7 Sep 2020 17:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96829206E7
	for <selinux@archiver.kernel.org>; Mon,  7 Sep 2020 17:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="UyOLByPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgIGRsG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731367AbgIGRrz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Sep 2020 13:47:55 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A9F5C061573
        for <selinux@vger.kernel.org>; Mon,  7 Sep 2020 10:47:54 -0700 (PDT)
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 6A3FC2A1505;
        Mon,  7 Sep 2020 19:47:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 6A3FC2A1505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1599500863;
        bh=lHctK6xks3A5yd/gqmDKQ2U+KPhxWB/kS6BNBgMCdZk=;
        h=From:To:Cc:Subject:Date:From;
        b=UyOLByPlxeLC8Zh0CGFrf3at90cnNz7vSKr2ylilSCATCpcXdiO4bTgRjr08wxqOJ
         AxwDqR/twqLe+NhPgpjns8malKXSeToJdkhCw0lj1UHaz+LLuo4iZ7mHYAqdxmXcD4
         LphFTAysM6SnLGvsTeFf9Eooc9wtaSlHzIISKLjA=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH] cil_network_labeling_statements: fixes nodecon examples
Date:   Mon,  7 Sep 2020 19:47:12 +0200
Message-Id: <20200907174712.290567-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The order of the subnet and netmask is wrong and also the value of netmask is wrong for single address subnet
Also use an ipaddr reserved for documentation: https://tools.ietf.org/html/rfc5737

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 secilc/docs/cil_network_labeling_statements.md | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/secilc/docs/cil_network_labeling_statements.md b/secilc/docs/cil_network_labeling_statements.md
index 49a836c1..cb52e7cf 100644
--- a/secilc/docs/cil_network_labeling_statements.md
+++ b/secilc/docs/cil_network_labeling_statements.md
@@ -145,12 +145,12 @@ These examples show named and anonymous [`nodecon`](cil_network_labeling_stateme
     (context context_1 (unconfined.user object_r unconfined.object low_low))
     (context context_2 (unconfined.user object_r unconfined.object (systemlow level_2)))
 
-    (ipaddr netmask_1 255.255.255.0)
-    (ipaddr ipv4_1 192.168.1.64)
+    (ipaddr netmask_1 255.255.255.255)
+    (ipaddr ipv4_1 192.0.2.64)
 
-    (nodecon netmask_1 ipv4_1 context_2)
-    (nodecon (255.255.255.0) (192.168.1.64) context_1)
-    (nodecon netmask_1 (192.168.1.64) (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
+    (nodecon ipv4_1 netmask_1 context_2)
+    (nodecon (192.0.2.64) (255.255.255.255) context_1)
+    (nodecon (192.0.2.64) netmask_1 (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
 
 portcon
 -------
-- 
2.28.0

