Return-Path: <SRS0=Vikk=BC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F98C433E0
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 07:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0C9206C1
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 07:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="rg6u3PGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgGWHuZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:50:25 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:56814 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgGWHuZ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 23 Jul 2020 03:50:25 -0400
Received: from localhost.localdomain (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 034182A1007;
        Thu, 23 Jul 2020 09:50:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 034182A1007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595490622;
        bh=PHVgAtRkeXzIST2UL9y8qF+SNwCe6iZkje82qI+14gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rg6u3PGZ3fXGMWkuDQomIc/rwd3wWbEiuRPbAHyvXLm+QQWwpuf6UYcXm/0Cj7vIr
         LfjS3K8t1RQTjzsCSowcbXj7yWiai4mGDdGmW60eqzzXghZmLrx7a+9VqkVeS4NKKD
         Vqz9Gzn+6TyWiBWk6KjbHvGKibCyPJq0/KHEuuZw=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH v9] objects.md: some clarifications
Date:   Thu, 23 Jul 2020 09:50:08 +0200
Message-Id: <20200723075008.2256123-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAEjxPJ6twZempmDtTBQjUxs_x9PJr5eQf1aSLJ1a6OpM_1eR=g@mail.gmail.com>
References: <CAEjxPJ6twZempmDtTBQjUxs_x9PJr5eQf1aSLJ1a6OpM_1eR=g@mail.gmail.com>
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
v6: forgot to mention defaultuser, can only associate one label with isids
v7: copied and pasted feedback from Stephen Smalley
v8: missed a s/access vectors/permissions/ instance
v9: restructure unlabeled isid paragraph

 src/objects.md | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/src/objects.md b/src/objects.md
index 58664ef..7e46b78 100644
--- a/src/objects.md
+++ b/src/objects.md
@@ -110,14 +110,20 @@ objects is managed by the system and generally unseen by the users
 (until labeling goes wrong !!). As processes and objects are created and
 destroyed, they either:
 
-1.  Inherit their labels from the parent process or object.
+1.  Inherit their labels from the parent process or object. The policy
+    default user, type, role and range statements can be used to
+	change the behavior as discussed in the [**Default Rules**](default_rules.md#default-object-rules)
+    section.
 2.  The policy type, role and range transition statements allow a
     different label to be assigned as discussed in the
     [**Domain and Object Transitions**](domain_object_transitions.md#domain-and-object-transitions)
     section.
-3.  SELinux-aware applications can enforce a new label (with the
-    policies approval of course) using the **libselinux** API
-    functions.
+3.  SELinux-aware applications can assign a new label (with the
+    policy's approval of course) using the **libselinux** API
+    functions. The `process setfscreate` permission can be used to
+    allow subjects to create files with a new label programmatically
+    using the ***setfscreatecon**(3)* function, overriding default
+    rules and transition statements.
 4.  An object manager (OM) can enforce a default label that can either
     be built into the OM or obtained via a configuration file (such as
     those used by
@@ -269,6 +275,36 @@ and manage their transition:
 
 `type_transition`, `role_transition` and `range_transition`
 
+SELinux-aware applications can assign a new label (with the policy's
+approval of course) using the **libselinux** API functions. The
+`process setexec`, `process setkeycreate` and `process setsockcreate`
+permissions can be used to allow subjects to label processes,
+kernel keyrings, and sockets programmatically using the
+***setexec**(3)*, ***setkeycreatecon**(3)* and
+***setsockcreatecon**(3)* functions respectively, overriding
+transition statements.
+
+The `kernel` **initial security identifier** is used to associate
+a specified label with kernel objects, including kernel threads
+(both those that are created during initialization but also kernel
+threads created later), kernel-private sockets and synthetic objects
+representing kernel resources (e.g. the "system" class).
+
+It is true that processes created prior to initial policy load will
+also be in the kernel SID until/unless there is a policy loaded and
+either a policy-defined transition or an explicit setcon or
+setexeccon+execve, but that's just the typical default inheritance
+from creating task behavior for processes.
+
+The context associated with the `unlabeled`
+**initial security identifier** is used as the fallback context for
+both subjects and objects when their label is invalidated by a policy
+reload (their SID is unchanged but the SID is transparently remapped
+to the unlabeled context). It is also assigned as the initial state
+for various objects e.g. inodes, superblocks, etc until they reach a
+point where a more specific label can be determined e.g. from an
+xattr or from policy. 
+
 ### Object Reuse
 
 As GNU / Linux runs it creates instances of objects and manages the
-- 
2.27.0

