Return-Path: <SRS0=UMxC=BM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FBCC433DF
	for <selinux@archiver.kernel.org>; Sun,  2 Aug 2020 12:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205DF20738
	for <selinux@archiver.kernel.org>; Sun,  2 Aug 2020 12:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="H6zxmmEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgHBMek (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Aug 2020 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgHBMek (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Aug 2020 08:34:40 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 301FBC06174A
        for <selinux@vger.kernel.org>; Sun,  2 Aug 2020 05:34:40 -0700 (PDT)
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 1F3F42A1010;
        Sun,  2 Aug 2020 14:34:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 1F3F42A1010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1596371676;
        bh=S3hE0t4Bmu/tqlt+N0TkoXoZYY131EwV363n4Vyl66o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6zxmmEF+G413uN7L64Vhpuwha9K7OhxyMgLlutJSNYNBLH/Ll2ky99cLTDS4Qa0f
         urJdSfqpdcoGmF0c96BYeMxAf9nwD3ZLlH0Vgh0uRTPaDDKnYl2NkKfKB4bDHe+LAw
         JvStCdcxL3MrQ2wnkwmTcPVslxxEgz25KBWjnPtQ=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH v4] secilc/docs: document expandtypeattribute
Date:   Sun,  2 Aug 2020 14:34:21 +0200
Message-Id: <20200802123421.222597-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
References: <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
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

 secilc/docs/README.md              |  1 +
 secilc/docs/cil_type_statements.md | 44 ++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

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
index f9dd3a76..41f0f01a 100644
--- a/secilc/docs/cil_type_statements.md
+++ b/secilc/docs/cil_type_statements.md
@@ -213,6 +213,50 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
         )
     )
 
+expandtypeattribute
+-------------------
+
+Overrides the compiler defaults for the expansion of one or more previously declared [`typeattribute`](cil_type_statements.md#typeattribute) identifiers.
+
+Note that this statement can be overridden at compile-time with `secilc -X SIZE` and that this functionality is not intended to override `secilc -X SIZE` for individual type attributes!
+
+**Statement definition:**
+
+    (expandtypeattribute typeattribute_id true|false)
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
+<td align="left"><p><code>true | false</code></p></td>
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

