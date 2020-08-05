Return-Path: <SRS0=Kca8=BP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750BAC433E3
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B842250E
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="i8Ban5+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgHETst (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:48:49 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:54472 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgHETsq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 5 Aug 2020 15:48:46 -0400
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 25F412A0EFE;
        Wed,  5 Aug 2020 21:48:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 25F412A0EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1596656923;
        bh=m3d3pVTrYd7bq7Mvf/eOq7F/zTGTszxauEvMZqcXBn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8Ban5+aCrwI7Md2H3zsYaUYEuJedGy2X4qCtHpXIyEVk/fTK8lx9l8X4k1mq+uWS
         VPOkJ/GeB2Cq66jGjGsNlNBwelPe7s10FN0orQ2ddoi8TEN7bvHYFJArmz6xl9S40j
         VDL76N+EUpO38vKW+nEd4HxhPkW3gDN8eiUMZHVw=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH v5] secilc/docs: document expandtypeattribute
Date:   Wed,  5 Aug 2020 21:48:23 +0200
Message-Id: <20200805194823.492092-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAP+JOzQe8Q0GKtm9aavEQTzFWCT8sUi8shjw=TmgJYm5XkaN_w@mail.gmail.com>
References: <CAP+JOzQe8Q0GKtm9aavEQTzFWCT8sUi8shjw=TmgJYm5XkaN_w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This was added for Androids Treble in 2017.

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
v2: overriden is overridden
v3: add link to README.md
v4: rephrase and add another example
v5: use description from James Carter

 secilc/docs/README.md              |  1 +
 secilc/docs/cil_type_statements.md | 51 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/secilc/docs/README.md b/secilc/docs/README.md
index 3f1838e6..efab2a71 100644
--- a/secilc/docs/README.md
+++ b/secilc/docs/README.md
@@ -126,6 +126,7 @@ CIL (Common Intermediate Language)
   * [typealiasactual](cil_type_statements.md#typealiasactual)
   * [typeattribute](cil_type_statements.md#typeattribute)
   * [typeattributeset](cil_type_statements.md#typeattributeset)
+  * [expandtypeattribute](cil_type_statements.md#expandtypeattribute)
   * [typebounds](cil_type_statements.md#typebounds)
   * [typechange](cil_type_statements.md#typechange)
   * [typemember](cil_type_statements.md#typemember)
diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_statements.md
index f9dd3a76..432cede5 100644
--- a/secilc/docs/cil_type_statements.md
+++ b/secilc/docs/cil_type_statements.md
@@ -213,6 +213,57 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
         )
     )
 
+expandtypeattribute
+-------------------
+
+Overrides the compiler defaults for the expansion of one or more
+previously declared [`typeattribute`](cil_type_statements.md#typeattribute)
+identifiers.
+
+This rule gives more control over type attribute expansion and
+removal. When the value is true, all rules involving the type
+attribute will be expanded and the type attribute will be removed from
+the policy. When the value is false, the type attribute will not be
+removed from the policy, even if the default expand rules or "-X"
+option cause the rules involving the type attribute to be expanded.
+
+**Statement definition:**
+
+    (expandtypeattribute typeattribute_id expand_value)
+
+**Where:**
+
+<table>
+<colgroup>
+<col width="25%" />
+<col width="75%" />
+</colgroup>
+<tbody>
+<tr class="odd">
+<td align="left"><p><code>expandtypeattribute</code></p></td>
+<td align="left"><p>The <code>expandtypeattribute</code> keyword.</p></td>
+</tr>
+<tr class="even">
+<td align="left"><p><code>typeattribute_id</code></p></td>
+<td align="left"><p>One or more previously declared <code>typeattribute</code> identifiers. Multiple entries consist of a space separated list enclosed in parentheses '()'.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>expand_value</code></p></td>
+<td align="left"><p>Either true or false.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Examples:**
+
+This example uses the expandtypeattribute statement to forcibly expand a previously declared `domain` type attribute.
+
+    (expandtypeattribute domain true)
+
+This example uses the expandtypeattribute statement to not expand previously declared `file_type` and `port_type` type attributes regardless of compiler defaults.
+
+    (expandtypeattribute (file_type port_type) false)
+
 typebounds
 ----------
 
-- 
2.28.0

