Return-Path: <SRS0=s7s9=A3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFFEC433DF
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 12:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B592074B
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 12:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="TarANw6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgGPMSN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgGPMSM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jul 2020 08:18:12 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B36E8C061755
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 05:18:12 -0700 (PDT)
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 4D8462A100B;
        Thu, 16 Jul 2020 14:18:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 4D8462A100B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1594901891;
        bh=7YZH4EwTKYzgIcEvsMgthJ+TwYuoKPRvble78+l/K98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TarANw6VwdUBuO1B9XquFVQpbSE3QbKLR+sjBhSRi7BA2IpqaVjvkhLqrhy2uWY/6
         u8kUujiazFazwapbyKCC+hAvecz2f+7Um+BrqwA5GWsYDIzGwS+a2Bdz6J0x2Q+C3u
         3P9p9OrVoaeALHsgIYYiOjAaci9NRazJwclQ2yfk=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH v4] objects.md: some clarifications
Date:   Thu, 16 Jul 2020 14:17:29 +0200
Message-Id: <20200716121729.962241-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716111825.953813-1-dominick.grift@defensec.nl>
References: <20200716111825.953813-1-dominick.grift@defensec.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Elaborate on labeling. Touch on the significance of the default statement, on various av permissions related to labeling using the libselinux API, and on how the kernel and unlabeled initial security identifiers are used to address labeling challenges in special cases such as initialization and failover respectively.

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
v2: fixes patch description
v3: adding patch description, s/policies/policy's/, split unlabeled and kernel descriptions for clarity
v4: fixes another typo in description and emphasize system initialization a bit

src/objects.md | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/src/objects.md b/src/objects.md
index 58664ef..c67787d 100644
--- a/src/objects.md
+++ b/src/objects.md
@@ -110,14 +110,20 @@ objects is managed by the system and generally unseen by the users
 (until labeling goes wrong !!). As processes and objects are created and
 destroyed, they either:
 
-1.  Inherit their labels from the parent process or object.
+1.  Inherit their labels from the parent process or object. The policy
+    default type, role and range statements can be used to change the
+    behavior as discussed in the [**Default Rules**](default_rules.md#default-object-rules)
+    section.
 2.  The policy type, role and range transition statements allow a
     different label to be assigned as discussed in the
     [**Domain and Object Transitions**](domain_object_transitions.md#domain-and-object-transitions)
     section.
 3.  SELinux-aware applications can enforce a new label (with the
-    policies approval of course) using the **libselinux** API
-    functions.
+    policy's approval of course) using the **libselinux** API
+    functions. The `process setfscreate` access vector can be used to
+    allow subjects to create files with a new label programmatically
+    using the ***setfscreatecon**(3)* function, overriding default
+    rules and transition statements.
 4.  An object manager (OM) can enforce a default label that can either
     be built into the OM or obtained via a configuration file (such as
     those used by
@@ -269,6 +275,23 @@ and manage their transition:
 
 `type_transition`, `role_transition` and `range_transition`
 
+SELinux-aware applications can enforce a new label (with the policy's
+approval of course) using the **libselinux** API functions. The
+`process setexec`, `process setkeycreate` and `process setsockcreate`
+access vectors can be used to allow subjects to label processes,
+kernel keyrings, and sockets programmatically using the
+***setexec**(3)*, ***setkeycreatecon**(3)* and
+***setsockcreatecon**(3)* functions respectively, overriding
+transition statements.
+
+The `kernel` **initial security identifier** is used to associate
+specified labels with subjects that were left unlabeled due to
+system initialization.
+
+The `unlabeled` **initial security identifier** is used
+to associate specified labels with subjects that had their label
+invalidated due to policy changes at runtime.
+
 ### Object Reuse
 
 As GNU / Linux runs it creates instances of objects and manages the
-- 
2.27.0

