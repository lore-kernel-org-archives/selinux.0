Return-Path: <SRS0=ftUv=CV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F9C433E2
	for <selinux@archiver.kernel.org>; Sat, 12 Sep 2020 13:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6DD20796
	for <selinux@archiver.kernel.org>; Sat, 12 Sep 2020 13:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="J5WZWMVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgILNOs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 12 Sep 2020 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgILNOi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 12 Sep 2020 09:14:38 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B42DC061573
        for <selinux@vger.kernel.org>; Sat, 12 Sep 2020 06:14:36 -0700 (PDT)
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 6F4FC2A1003;
        Sat, 12 Sep 2020 15:14:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 6F4FC2A1003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1599916463;
        bh=Ob7t9IXXo3NgG/9mGrWROXZW4Jfzj+PY3fJ6wfC5pRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5WZWMVQWRBhHRaTRW4Aj3kgppM1965czoJizoOlsrHe4ws9EBX4uVy2AASVNGWkp
         zQsbFm/HarFdtM8C+hbpNaCW5XNkCUBll18r527/3LPUmRDsj1F4xH2BiGf63xQai8
         a+AF5Kw23vdtbAJPdNYp/VKJgj/Im+mZ5eFDS8u4=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH v4] cil_access_vector_rules: allowx, auditallowx and dontauditx fixes
Date:   Sat, 12 Sep 2020 15:14:11 +0200
Message-Id: <20200912131411.1213573-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910113244.818506-1-dominick.grift@defensec.nl>
References: <20200910113244.818506-1-dominick.grift@defensec.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

allowx requires a equivalent "allow ioctl" rule to be present
auditallowx requires a equivalent "auditallow" ioctl rule to be present
dontauditx requires atleast one equivalent "allowx" rule to be present (can be a random irrelevant ioctlcmd)

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
v4: add a "proper" clarification for dontauditx

This just can't be how it was designed to behave, but it "works".

There seem to be no logic to this at all and allowx, auditallowx and dontauditx should probably work the same as neverallowx.
regardless, this behavior should be documented because people will lose their sanity if they have to figure this out on their own.

 secilc/docs/cil_access_vector_rules.md | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
index 9c03c710..683cc28c 100644
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
+    (allow type_3 type_4 (udp_socket (ioctl))) ;; pre-requisite
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
 
+Note that for this to work there must *also* be atleast one [`allowx`](cil_access_vector_rules.md#allowx) rule associated with the target type.
+
 Note that these rules can be omitted by the CIL compiler command line parameter `-D` or `--disable-dontaudit` flags.
 
 **Rule definition:**
@@ -370,6 +378,7 @@ Note that these rules can be omitted by the CIL compiler command line parameter
 
 This example will not audit the denied access:
 
+    (allowx type_1 type_2 (ioctl tcp_socket (0x1))) ;; pre-requisite, just some irrelevant random ioctl
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

