Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC6DC43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 09:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334A321D40
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 09:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="l+pAIePN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgIJJ3v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:29:51 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:53250 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730446AbgIJJ3i (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 10 Sep 2020 05:29:38 -0400
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 894312A127E;
        Thu, 10 Sep 2020 11:29:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 894312A127E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1599730163;
        bh=ZfTacSCSMcda5IYNeRZFmZuPbIMFKJbmWGl1pSUL8EU=;
        h=From:To:Cc:Subject:Date:From;
        b=l+pAIePNIhzg+5tBFmBzF5a7VMN7ifgMD28qZeCsYczl8pjzBB+9z52c3Jtq/YmbI
         AcL0BWbaEmDDGrimNsq8CmMZxRx0NPU8/igNA5/W0qSbLaTl2jFfZo+inUpQP3/eig
         gVslQd4uy+anQHEOGXfsfLJpX0FC02UMQ/6Tcbl4=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH] cil_access_vector_rules: fixes a typo
Date:   Thu, 10 Sep 2020 11:29:05 +0200
Message-Id: <20200910092905.800461-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

neverallows should be neverallowx

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
When I was verifying a suggestion that auditallowx and dontauditx does not work I found this typo.
auditallowx and dontauditx seem to not work.

 secilc/docs/cil_access_vector_rules.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
index 9c03c710..1eb33b2c 100644
--- a/secilc/docs/cil_access_vector_rules.md
+++ b/secilc/docs/cil_access_vector_rules.md
@@ -392,7 +392,7 @@ Note that these rules can be over-ridden by the CIL compiler command line parame
 </colgroup>
 <tbody>
 <tr class="odd">
-<td align="left"><p><code>neverallows</code></p></td>
+<td align="left"><p><code>neverallowx</code></p></td>
 <td align="left"><p>The <code>neverallowx</code> keyword.</p></td>
 </tr>
 <tr class="even">
-- 
2.28.0

