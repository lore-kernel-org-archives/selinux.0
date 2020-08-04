Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D651C433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C04320781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OxrIgRSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgHDBdv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBdv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:33:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F0DC06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:33:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l23so37111959qkk.0
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=J9fXVlEdf7OFiOr4V1LW5OGbAB+De+vYVl5tQCtvAEI=;
        b=OxrIgRSa7kC5eSc6PEMjCK0ZSHU+GL5BucHkNDe9nSsoM2GNplNIldrx3QwnmPULjr
         7ww2uCMG9xLSOvqnksstsWcNQJAwQ7LNW8xvPdPAapzoIZc/97G3wZSFJ57LleR6OT0y
         Xd7mSgGSOExrfsh65RuAev4Bo63LmKO44BFxa3rNbOMxAZTxXAXAbxvaIg6dC4NKufhK
         DWxE7rhFesF1fIkOvJ5ouwykKaliw8xQg+P/7MIeJ0zqlKY+kouaTrII40GZKEniLpXJ
         XcLQ4xk/W1/1bA+6aVSuOkv+SeXZV9aAYnlByWHM3i/kJMAVV917eD2+17SRALK20rq8
         vQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=J9fXVlEdf7OFiOr4V1LW5OGbAB+De+vYVl5tQCtvAEI=;
        b=NLm6Jpg8EdSPJQMHxX5vpncq+UZvHC7IyOXV6OmrWb/HJIJrlPMib3iTqKBV5MM/eF
         S8cM/F5Sc2BB2rW2KRjueRXRIsM3nofuu6+FjNPP/8wkcRCrWNRQSU318j7gX/r6ONX4
         fosPRWDfD0yEQIYHEDQG9huGBE51iC2XDOZFIcrTyzkdT3sWnYc0fKOvX/rXqAQnko/y
         EiDC48vbCazvi4RtTkQykWpzbW0+GFEda8Dk34fITneUIncSO9QVxD+eahllnE3J0ZmP
         e1R8q/oeXAYfSpINdUYfVN3m1qt8cnKHwAm8octxra6HnnJtmPSXWKuX7CxG4FhkQ6aH
         vMBg==
X-Gm-Message-State: AOAM532Ze7cspoLxbwuogwAD0hTCk79vTVpYNUjJP/8TPj8QcF4fbUl+
        6ioTye0m+F2BSjKy3xDRLlbXxF+itGJF
X-Google-Smtp-Source: ABdhPJy76Dl43lsRSXjhzzBTEajjuk6EGN1W/Uq+IyMGT8NxKYLRd0U6U15bJWvj05fNYv68k9B9pQ==
X-Received: by 2002:a05:620a:22f4:: with SMTP id p20mr19354183qki.349.1596504830005;
        Mon, 03 Aug 2020 18:33:50 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id z126sm19953984qkc.58.2020.08.03.18.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:33:49 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 05/18] xperm_rules: fully convert to
 markdown
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:33:48 -0400
Message-ID: <159650482872.8961.7516871249534865160.stgit@sifl>
In-Reply-To: <159650470076.8961.12721446818345626943.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/xperm_rules.md |  138 ++++++++++++++++++++++++----------------------------
 1 file changed, 64 insertions(+), 74 deletions(-)

diff --git a/src/xperm_rules.md b/src/xperm_rules.md
index 48beb41..21878ea 100644
--- a/src/xperm_rules.md
+++ b/src/xperm_rules.md
@@ -2,8 +2,8 @@
 
 There are three extended AV rules implemented from Policy version 30
 with the target platform 'selinux' that expand the permission sets from
-a fixed 32 bits to permission sets in 256 bit increments: `allowxperm`,
-`dontauditxperm`, `auditallowxperm` and `neverallowxperm`.
+a fixed 32 bits to permission sets in 256 bit increments: *allowxperm*,
+*dontauditxperm*, *auditallowxperm* and *neverallowxperm*.
 
 The rules for extended permissions are subject to the 'operation' they
 perform with Policy version 30 and kernels from 4.3 supporting ioctl
@@ -16,66 +16,59 @@ libsepol 2.7 minimum is required).
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>rule_name</code></td>
-<td>The applicable <code>allowxperm</code>, <code>dontauditxperm</code>, <code>auditallowxperm</code> or <code>neverallowxperm</code> rule keyword.</td>
-</tr>
-<tr>
-<td><p><code>source_type</code></p>
-<p><code>target_type</code></p></td>
-<td><p>One or more source / target <code>type</code>, <code>typealias</code> or <code>attribute</code> identifiers. Multiple entries consist of a space separated list enclosed in braces '{}'. Entries can be excluded from the list by using the negative operator '-'.</p>
-<p>The target_type can have the <code>self</code> keyword instead of <code>type</code>, <code>typealias</code> or <code>attribute</code> identifiers. This means that the <code>target_type</code> is the same as the <code>source_type</code>.</p></td>
-</tr>
-<tr>
-<td><code>class</code></td>
-<td>One or more object classes. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>operation<code></td>
-<td>A key word defining the operation to be implemented by the rule. Currently only the <code>ioctl</code> operation is supported by the kernel policy language and kernel as described in the  <a href="#ioctl-operation-rules"><code>ioctl</code> Operation Rules</a> section.</td>
-</tr>
-<tr>
-<td><code>xperm_set</code></td>
-<td><p>One or more extended permissions represented by numeric values (i.e. <code>0x8900</code> or <code>35072</code>). The usage is dependent on the specified <em>operation</em>.</p>
-<p>Multiple entries consist of a space separated list enclosed in braces '{}'.</p>
-<p>The complement operator '~' is used to specify all permissions except those explicitly listed.</p>
-<p>The range operator '-' is used to specify all permissions within the <code>low – high</code> range.</p>
-<p>An example is shown in the <a href="#ioctl-operation-rules"><code>ioctl</code> Operation Rules</a> section.</p></td>
-</tr>
-</tbody>
-</table>
+*rule_name*
+
+The applicable *allowxperm*, *dontauditxperm*, *auditallowxperm*
+or *neverallowxperm* rule keyword.
+
+*source_type*
+
+One or more source / target *type*, *typealias* or *attribute* identifiers.
+Multiple entries consist of a space separated list enclosed in braces \'{}\'.
+Entries can be excluded from the list by using the negative operator \'-\'.
+
+*target_type*
+
+The target_type can have the *self* keyword instead of *type*, *typealias* or
+*attribute* identifiers. This means that the *target_type* is the same as the
+*source_type*.
+
+*class*
+
+One or more object classes. Multiple entries consist of a space separated list
+enclosed in braces \'{}\'.
+
+*operation*
+
+A key word defining the operation to be implemented by the rule. Currently only
+the *ioctl* operation is supported by the kernel policy language and kernel as
+described in the [*ioctl* Operation Rules](#ioctl-operation-rules) section.
+
+*xperm_set*
+
+One or more extended permissions represented by numeric values (i.e. *0x8900*
+or *35072*). The usage is dependent on the specified *operation*. Multiple
+entries consist of a space separated list enclosed in braces \'{}\'. The
+complement operator \'\~\' is used to specify all permissions except those
+explicitly listed. The range operator \'-\' is used to specify all permissions
+within the *low – high* range. An example is shown in the
+[*ioctl* Operation Rules](#ioctl-operation-rules) section.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
-<br>
-
-### `ioctl` Operation Rules
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
+
+### *ioctl* Operation Rules
 
 Use cases and implementation details for ioctl command whitelisting are
 described in detail at
@@ -85,14 +78,14 @@ policy format changes shown in the example below with a brief overview
 the final upstream kernel patch).
 
 Ioctl calls are generally used to get or set device options. Policy
-versions &lt; 30 only controls whether an `ioctl` permission is allowed
-or not, for example this rule allows the object class `tcp_socket` the
-`ioctl` permission:
+versions &lt; 30 only controls whether an *ioctl* permission is allowed
+or not, for example this rule allows the object class *tcp_socket* the
+*ioctl* permission:
 
 `allow src_t tgt_t : tcp_socket ioctl;`
 
 From Policy version 30 it is possible to control ***ioctl**(2)*
-'*request*' parameters provided the `ioctl` permission is also allowed,
+'*request*' parameters provided the *ioctl* permission is also allowed,
 for example:
 
 ```
@@ -101,14 +94,14 @@ allow src_t tgt_t : tcp_socket ioctl;
 allowxperm src_t tgt_t : tcp_socket ioctl ~0x8927;
 ```
 
-The `allowxperm` rule states that all ioctl request parameters are
+The *allowxperm* rule states that all ioctl request parameters are
 allowed for the source/target/class with the exception of the value
-`0x8927` that (using *include/linux/sockios.h*) is **SIOCGIFHWADDR**, or
+*0x8927* that (using *include/linux/sockios.h*) is **SIOCGIFHWADDR**, or
 'get hardware address'.
 
 An example audit log entry denying an ioctl request to add a routing
-table entry (**SIOCADDRT** - `ioctlcmd=890b`) for *goldfish_setup* on a
-`udp_socket` is:
+table entry (**SIOCADDRT** - *ioctlcmd=890b*) for *goldfish_setup* on a
+*udp_socket* is:
 
 ```
 type=1400 audit(1437408413.860:6): avc: denied { ioctl } for pid=81
@@ -121,18 +114,15 @@ Notes:
 
 1.  Important: The ioctl operation is not 'deny all' ioctl requests
     (hence whitelisting). It is targeted at the specific
-    source/target/class set of ioctl commands. As no other `allowxperm`
+    source/target/class set of ioctl commands. As no other *allowxperm*
     rules have been defined in the example, all other ioctl calls may
     continue to use any valid request parameters (provided there are
-    `allow` rules for the `ioctl` permission).
+    *allow* rules for the *ioctl* permission).
 2.  As the ***ioctl**(2)* function requires a file descriptor, its
-    context must match the process context otherwise the `fd { use }`
+    context must match the process context otherwise the *fd { use }*
     class/permission is required.
 3.  To deny all ioctl requests for a specific source/target/class the
-    `xperm_set` should be set to `0` or `0x0`.
-
-
-<br>
+    *xperm_set* should be set to *0* or *0x0*.
 
 <!-- %CUTHERE% -->
 

