Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E474FC4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDEF60FDB
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 17:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhFURIL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:08:11 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:45062 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhFURIG (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 21 Jun 2021 13:08:06 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 13:08:06 EDT
Received: from brutus.. (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 69BE12A0018;
        Mon, 21 Jun 2021 18:59:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 69BE12A0018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1624294775;
        bh=CwtAgbyTBg9saMVmbU/eby2faSkVefhrLpQrRR2YPKA=;
        h=From:To:Cc:Subject:Date:From;
        b=m07YxJM0Wz4Hq2aVf/41zn0QgIJ/eO3vM4A6shrL729S9sw2RIflCGYCNxy6UDGpe
         n7FDUE2a8xcnyMI2n/Q7skVcT4G0vwj2j9kYeqS/eBAeG5AbFiJsPw2l/35qHmPvoS
         Qc9rGcld1W9HBJkeMyJvfU3+IAWQimzQEmUDq3Gw=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH] computing_security_contexts.md: clarify mount options with comma
Date:   Mon, 21 Jun 2021 18:58:54 +0200
Message-Id: <20210621165854.285237-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If you have a comma in your context then mount will reject it without
escaped quotes. This can be confusing and it is not well documented.

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 src/computing_security_contexts.md | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
index bb946b5..11d54b8 100644
--- a/src/computing_security_contexts.md
+++ b/src/computing_security_contexts.md
@@ -175,7 +175,10 @@ Notes:
    keyword present.
 2. There are mount options for allocating various context types:
    *context=*, *fscontext=*, *defcontext=* and *rootcontext=*. They are
-   fully described in the ***mount**(8)* man page.
+   fully described in the ***mount**(8)* man page except for the fact that if
+   your context contains a comma separator then you should wrap the context
+   with escaped quotes. For example:
+   *context=\"system_u:object_r:container_file_t:s0:c1,c2\"*.
 
 ### Network File System (nfsv4.2)
 
-- 
2.32.0

