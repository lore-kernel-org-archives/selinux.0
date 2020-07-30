Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A23C433E0
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 09:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02962082E
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 09:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="TOS60KZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG3JXZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgG3JXZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 05:23:25 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 093ADC061794
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 02:23:25 -0700 (PDT)
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 287492A1010;
        Thu, 30 Jul 2020 11:23:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 287492A1010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1596101004;
        bh=+oRbuoQxuhGPNK80ELxcP3pRIlGYbg8EtgQWmqPBNL0=;
        h=From:To:Cc:Subject:Date:From;
        b=TOS60KZ5cGEAx319r/UlNqHkRkGsJjGcqhfUps7iDeBpQX467IjbjnceLVbeuBpaC
         ZfjvKLqYuh1bba6iGb6OVgEpKF/BEGTpAwPCHE+K05o/q1vNvo36fEVFa77HW2zPdx
         /x4NtYHPTtkmDnuLSj/5KyWNuTkG3RG4FhpkabA0=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH] secilc/docs: document expandtypeattribute
Date:   Thu, 30 Jul 2020 11:23:05 +0200
Message-Id: <20200730092305.896408-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This was added for Androids Treble in 2017.

I was unsure whether this belongs in type_statements or in conditional_statements.

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 secilc/docs/cil_type_statements.md | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_statements.md
index f9dd3a76..4ac1dcb9 100644
--- a/secilc/docs/cil_type_statements.md
+++ b/secilc/docs/cil_type_statements.md
@@ -213,6 +213,44 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
         )
     )
 
+expandtypeattribute
+----------------
+
+Allows expansion compiler defaults for one or more previously declared [`typeattribute`](cil_type_statements.md#typeattribute) identifiers to be overriden.
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
+<td align="left"><p>One or more previously declared <code>typeattribute</code> identifiers.</p></td>
+</tr>
+<tr class="odd">
+<td align="left"><p><code>true | false</code></p></td>
+<td align="left"><p>Either true or false.</p></td>
+</tr>
+</tbody>
+</table>
+
+**Example:**
+
+This example will use the expandtypeattribute statement to forcibly expand a previously declared `domain` type attribute.
+
+    (expandtypeattribute domain true)
+
 typebounds
 ----------
 
-- 
2.28.0.rc1

