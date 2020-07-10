Return-Path: <SRS0=ib1x=AV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C72C433DF
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 07:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99BA42077D
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 07:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="D8p4dS61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgGJHOo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:14:44 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:42430 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgGJHOn (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 10 Jul 2020 03:14:43 -0400
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 192202A0CEF;
        Fri, 10 Jul 2020 09:14:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 192202A0CEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1594365282;
        bh=ZTc2LdoEY7HERzjXSbHuDUZ7NAZjJVrTItW14KdWWsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8p4dS61ez96PiGD5zv/BGB/c7IFULB0Lr3YFgL8bfPq4R3RsD+E9kdl5TZkZT5oH
         XDfqn98hS43vmDuBf5Kd0Nh/6xaDJP7b7jEYW7m6xY6xMRtabxzEYIga/LAprHv0v8
         O/KmpFjtmOs1xVAuvU11lBTNCp0hzPvozw47seRk=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH v2] objects.md: some clarifications
Date:   Fri, 10 Jul 2020 09:14:31 +0200
Message-Id: <20200710071431.107444-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710070903.106482-1-dominick.grift@defensec.nl>
References: <20200710070903.106482-1-dominick.grift@defensec.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

v2: fixes patch description
Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 src/objects.md | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/src/objects.md b/src/objects.md
index 58664ef..aadb539 100644
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
     policies approval of course) using the **libselinux** API
-    functions.
+    functions. The `process setfscreate` access vector can be used to
+    allow subjects to create files with a new label programmatically
+    using the ***setfscreatecon**(3)* function, overriding default
+    rules and transition statements.
 4.  An object manager (OM) can enforce a default label that can either
     be built into the OM or obtained via a configuration file (such as
     those used by
@@ -269,6 +275,20 @@ and manage their transition:
 
 `type_transition`, `role_transition` and `range_transition`
 
+SELinux-aware applications can enforce a new label (with the policies
+approval of course) using the **libselinux** API functions. The
+`process setexec`, `process setkeycreate` and `process setsockcreate`
+access vectors can be used to allow subjects to label processes,
+kernel keyrings, and sockets programmatically using the
+***setexec**(3)*, ***setkeycreatecon**(3)* and
+***setsockcreatecon**(3)* functions respectively, overriding
+transition statements.
+
+The `kernel` and `unlabeled` **initial security identifiers** are used
+to associate specified labels with subjects that were left unlabeled
+due to initialization or with subjects that had their label
+invalidated due to policy changes at runtime respectively.
+
 ### Object Reuse
 
 As GNU / Linux runs it creates instances of objects and manages the
-- 
2.27.0

