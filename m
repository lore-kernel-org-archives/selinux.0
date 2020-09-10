Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BFEC433E2
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 11:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 239DC2078E
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 11:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="WYl/ynkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIJLpO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbgIJLmi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 07:42:38 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61796C06179B
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 04:34:11 -0700 (PDT)
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 539722A1505;
        Thu, 10 Sep 2020 13:32:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 539722A1505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1599737574;
        bh=tVwSQOkhY0Z01mzYDcrPmrDYfhxUjz8RUnlkpVURfzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYl/ynkHmkKL0YQLJCKGodfIhzXzSoLMYxBLbShbAAw/sX9Q/KedbzErR9FutFnCa
         DhUeoO4ZThPLzAdSosJId+cqFfDaVNSca2yCj9oe9jdOccxo9vVRLTLi7RCXY/opi6
         AO92fCaEIXH1gg5pPj7MbDIWytt2Z3PSTnOzEaz8=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH v3] cil_access_vector_rules: allowx, auditallowx and dontauditx fixes
Date:   Thu, 10 Sep 2020 13:32:44 +0200
Message-Id: <20200910113244.818506-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910102617.808902-1-dominick.grift@defensec.nl>
References: <20200910102617.808902-1-dominick.grift@defensec.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Clearly state that allowx, auditallowx and dontauditx only works if there are allow, auditallow and dontaudit equivalent rules respectively. Also fix the examples.

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
v3: this actually also applies to allowx (but not to neverallowx)
There is something wrong though as for example (dontauditx a b (ioctl file (c))) will also dontauditx for example (dontauditx a b (ioctl file (d)))
In other words it seems that you cannot dontauditx individual ioctl if source, target and target class are the same.
Same probably applies to auditallowx (unverified)

secilc/docs/cil_access_vector_rules.md | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
index 9c03c710..366979d2 100644
--- a/secilc/docs/cil_access_vector_rules.md
+++ b/secilc/docs/cil_access_vector_rules.md
@@ -238,6 +238,8 @@ allowx
 
 Specifies the access allowed between a source and target type using extended permissions. Unlike the [`allow`](cil_access_vector_rules.md#allow) statement, the statements [`validatetrans`](cil_constraint_statements.md#validatetrans), [`mlsvalidatetrans`](cil_constraint_statements.md#mlsvalidatetrans), [`constrain`](cil_constraint_statements.md#constrain), and [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain) do not limit accesses granted by [`allowx`](cil_access_vector_rules.md#allowx).
 
+Note that for this to work there must *also* be valid equivalent [`allow`](cil_access_vector_rules.md#allow) rules present.
+
 **Rule definition:**
 
     (allowx source_id target_id|self permissionx_id)
@@ -274,18 +276,21 @@ Specifies the access allowed between a source and target type using extended per
 
 These examples show a selection of possible permutations of [`allowx`](cil_access_vector_rules.md#allowx) rules:
 
+    (allow type_1 type_2 (tcp_socket (ioctl))) ;; pre-requisite
     (allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
 
     (permissionx ioctl_nodebug (ioctl udp_socket (not (range 0x4000 0x4010))))
+	(allow type_3 type_4 (udp_socket (ioctl))) ;; pre-requisite
     (allowx type_3 type_4 ioctl_nodebug)
 
 
-
 auditallowx
 -----------
 
 Audit the access rights defined if there is a valid [`allowx`](cil_access_vector_rules.md#allowx) rule. It does NOT allow access, it only audits the event.
 
+Note that for this to work there must *also* be valid equivalent [`auditallow`](cil_access_vector_rules.md#auditallow) rules present.
+
 **Rule definition:**
 
     (auditallowx source_id target_id|self permissionx_id)
@@ -324,6 +329,7 @@ This example will log an audit event whenever the corresponding [`allowx`](cil_a
 
     (allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
 
+    (auditallow type_1 type_2 (tcp_socket (ioctl))) ;; pre-requisite
     (auditallowx type_1 type_2 (ioctl tcp_socket (range 0x2005 0x2010)))
 
 
@@ -332,6 +338,8 @@ dontauditx
 
 Do not audit the access rights defined when access denied. This stops excessive log entries for known events.
 
+Note that for this to work there must *also* be valid equivalent [`dontaudit`](cil_access_vector_rules.md#dontaudit) rules present.
+
 Note that these rules can be omitted by the CIL compiler command line parameter `-D` or `--disable-dontaudit` flags.
 
 **Rule definition:**
@@ -370,6 +378,7 @@ Note that these rules can be omitted by the CIL compiler command line parameter
 
 This example will not audit the denied access:
 
+    (dontaudit type_1 type_2 (tcp_socket (ioctl))) ;; pre-requisite
     (dontauditx type_1 type_2 (ioctl tcp_socket (range 0x3000 0x30FF)))
 
 
@@ -392,7 +401,7 @@ Note that these rules can be over-ridden by the CIL compiler command line parame
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

