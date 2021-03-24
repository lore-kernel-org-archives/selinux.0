Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE51C433C1
	for <selinux@archiver.kernel.org>; Wed, 24 Mar 2021 15:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F494619B8
	for <selinux@archiver.kernel.org>; Wed, 24 Mar 2021 15:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhCXPLi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbhCXPLb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Mar 2021 11:11:31 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE2FC061763
        for <selinux@vger.kernel.org>; Wed, 24 Mar 2021 08:11:31 -0700 (PDT)
Received: from brutus.. (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 070362A124E;
        Wed, 24 Mar 2021 16:11:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 070362A124E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1616598683;
        bh=wwrjfj6dtY+8/Y2LxqXIcM2C3/eSgb4TtM1KtOxcMhc=;
        h=From:To:Cc:Subject:Date:From;
        b=R4/D7PEznxHdchS4Wf713+heV4MEEnYA07R/po0AXRKMWAh4IILNUJ0d7VCuxuxVx
         O5EjHM9tPXNSRpSdFgN1qajph+gnCnYfMWIPoEDNpJFnd9BLzTJH4OG+DeBqSJKVKS
         iMqm+My71zIpJSS99AG7NOGxli9hEldUXjWpVT48=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH] cil_conditional_statements.md: fix expr definition
Date:   Wed, 24 Mar 2021 16:11:05 +0100
Message-Id: <20210324151105.3765449-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

expr "(expr (tunable_id tunable_id))" does not work but "(expr
tunable_id tunable_id)" does work

for example, this works

(tunable test1)
(tunable test2)
(tunableif (or test1 test2)
	   (true
	    (allow a b (c (d)))))

but this does not work:

(tunable test1)
(tunable test2)
(tunableif (or (test1 test2))
	   (true
	    (allow a b (c (d)))))

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 secilc/docs/cil_conditional_statements.md | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/secilc/docs/cil_conditional_statements.md b/secilc/docs/cil_conditional_statements.md
index a55a9b6c..55f0bfd6 100644
--- a/secilc/docs/cil_conditional_statements.md
+++ b/secilc/docs/cil_conditional_statements.md
@@ -78,12 +78,12 @@ Contains the run time conditional statements that are instantiated in the binary
 <tr class="odd">
 <td align="left"><p><code>expr</code></p></td>
 <td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
-<p><code>    (and (boolean_id boolean_id))</code></p>
-<p><code>    (or  (boolean_id boolean_id))</code></p>
-<p><code>    (xor (boolean_id boolean_id))</code></p>
-<p><code>    (eq  (boolean_id boolean_id))</code></p>
-<p><code>    (neq (boolean_id boolean_id))</code></p>
-<p><code>    (not (boolean_id))</code></p></td>
+<p><code>    (and boolean_id boolean_id)</code></p>
+<p><code>    (or  boolean_id boolean_id)</code></p>
+<p><code>    (xor boolean_id boolean_id)</code></p>
+<p><code>    (eq  boolean_id boolean_id)</code></p>
+<p><code>    (neq boolean_id boolean_id)</code></p>
+<p><code>    (not boolean_id)</code></p></td>
 </tr>
 <tr class="even">
 <td align="left"><p><code>true</code></p></td>
@@ -196,12 +196,12 @@ Compile time conditional statement that may or may not add CIL statements to be
 <tr class="odd">
 <td align="left"><p><code>expr</code></p></td>
 <td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
-<p><code>    (and (tunable_id tunable_id))</code></p>
-<p><code>    (or  (tunable_id tunable_id))</code></p>
-<p><code>    (xor (tunable_id tunable_id))</code></p>
-<p><code>    (eq  (tunable_id tunable_id))</code></p>
-<p><code>    (neq (tunable_id tunable_id))</code></p>
-<p><code>    (not (tunable_id))</code></p></td>
+<p><code>    (and tunable_id tunable_id)</code></p>
+<p><code>    (or  tunable_id tunable_id)</code></p>
+<p><code>    (xor tunable_id tunable_id)</code></p>
+<p><code>    (eq  tunable_id tunable_id)</code></p>
+<p><code>    (neq tunable_id tunable_id)</code></p>
+<p><code>    (not tunable_id)</code></p></td>
 </tr>
 <tr class="even">
 <td align="left"><p><code>true</code></p></td>
-- 
2.30.1

