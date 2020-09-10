Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1266C43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 10:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F6A206B8
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 10:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="qMeUl06p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIJK0h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbgIJK0f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 06:26:35 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B235AC061573
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 03:26:31 -0700 (PDT)
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 43E4F2A0D7E;
        Thu, 10 Sep 2020 12:26:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 43E4F2A0D7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1599733586;
        bh=U9Gha2JXL9SGJUsXlOltpmUlEHElAR2GlSOIkOtzK/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qMeUl06pKWeZ9I7avCEQ6ImGaE4YgDWpaf2qUhsGYq98PCZfh0HAyDNJWLFNtmEvh
         Xfd1agcAk3A/w1sEvhlFyXFTLt9R6O5uZLj713yes6sHsFEDnxuulYJmO43jem8jGG
         S2PDyO3Qfm/steUsxiN/aUq0A2cJqf/IQYR9JNFc=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH v2] cil_access_vector_rules: fixes a typo, clarifies auditallowx/dontauditx
Date:   Thu, 10 Sep 2020 12:26:17 +0200
Message-Id: <20200910102617.808902-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910092905.800461-1-dominick.grift@defensec.nl>
References: <20200910092905.800461-1-dominick.grift@defensec.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

neverallows should be neverallowx

Clearly state that auditallowx and dontauditx only works if there are auditallow and dontaudit equivalent rules respectively. Also fix the examples.

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
v2: auditallowx and dontauditx do not work without auditallow and dontaudit equivalents
The inconsistent thing is that for example neverallowx does work without neverallow equivalent (same I suspect for allowx)

secilc/docs/cil_access_vector_rules.md | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
index 9c03c710..50addf65 100644
--- a/secilc/docs/cil_access_vector_rules.md
+++ b/secilc/docs/cil_access_vector_rules.md
@@ -286,6 +286,8 @@ auditallowx
 
 Audit the access rights defined if there is a valid [`allowx`](cil_access_vector_rules.md#allowx) rule. It does NOT allow access, it only audits the event.
 
+Note that for this to work there must *also* be valid equivalent [`auditallow`](cil_access_vector_rules.md#auditallow) rules present.
+
 **Rule definition:**
 
     (auditallowx source_id target_id|self permissionx_id)
@@ -324,6 +326,7 @@ This example will log an audit event whenever the corresponding [`allowx`](cil_a
 
     (allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
 
+    (auditallow type_1 type_2 (tcp_socket (ioctl))) ;; pre-requisite
     (auditallowx type_1 type_2 (ioctl tcp_socket (range 0x2005 0x2010)))
 
 
@@ -332,6 +335,8 @@ dontauditx
 
 Do not audit the access rights defined when access denied. This stops excessive log entries for known events.
 
+Note that for this to work there must *also* be valid equivalent [`dontaudit`](cil_access_vector_rules.md#dontaudit) rules present.
+
 Note that these rules can be omitted by the CIL compiler command line parameter `-D` or `--disable-dontaudit` flags.
 
 **Rule definition:**
@@ -370,6 +375,7 @@ Note that these rules can be omitted by the CIL compiler command line parameter
 
 This example will not audit the denied access:
 
+    (dontaudit type_1 type_2 (tcp_socket (ioctl))) ;; pre-requisite
     (dontauditx type_1 type_2 (ioctl tcp_socket (range 0x3000 0x30FF)))
 
 
@@ -392,7 +398,7 @@ Note that these rules can be over-ridden by the CIL compiler command line parame
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

