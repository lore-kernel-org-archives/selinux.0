Return-Path: <SRS0=TRyb=A5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B49EC433E2
	for <selinux@archiver.kernel.org>; Sat, 18 Jul 2020 06:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87972070A
	for <selinux@archiver.kernel.org>; Sat, 18 Jul 2020 06:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="TCT9xeBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgGRGkg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:40:36 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:54812 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgGRGkg (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 18 Jul 2020 02:40:36 -0400
Received: from localhost.localdomain (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 2129B2A1007;
        Sat, 18 Jul 2020 08:40:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 2129B2A1007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595054433;
        bh=rHxkvrjUHvOta1mVOQPA5Y5E591psr1Vti2AhixLyhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCT9xeBe6NvvmckI96wy6Ai2bvgGcZ+icwxUreBCmEhjG/wbOQ6ZkJ7ikqoUMMfRb
         HU4uKjMBhC372rl3/HmVRL4YT80gcjFDK8KcW0/sQwETQaurbq9V2PIM/CcdIyPwQo
         rt7I2UKIo9sMonHBNcZ9EbV6ePeSWWPjjFU973I4=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH v5] objects.md: some clarifications
Date:   Sat, 18 Jul 2020 08:40:22 +0200
Message-Id: <20200718064022.1300044-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAHC9VhS1d_=gotE6eau2hmxM+OjujY=u8sMQE10gNKOJ1z87dQ@mail.gmail.com>
References: <CAHC9VhS1d_=gotE6eau2hmxM+OjujY=u8sMQE10gNKOJ1z87dQ@mail.gmail.com>
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
v5: emphasize kernel threads with kernel isid description

 src/objects.md | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/src/objects.md b/src/objects.md
index 58664ef..70877b0 100644
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
+system initialization, for example kernel threads.
+
+The `unlabeled` **initial security identifier** is used
+to associate specified labels with subjects that had their label
+invalidated due to policy changes at runtime.
+
 ### Object Reuse
 
 As GNU / Linux runs it creates instances of objects and manages the
-- 
2.27.0

