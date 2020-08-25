Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E69C433EB
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6564220706
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="JiciTYT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgHYIiZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:25 -0400
Received: from mailomta9-sa.btinternet.com ([213.120.69.15]:51235 "EHLO
        sa-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728145AbgHYIiU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:20 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20200825083810.JHDK4195.sa-prd-fep-049.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344690; 
        bh=rdfzeAhIXlReKS+I1/cNliu0vPNZfs6ItoLhaS6TReQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=JiciTYT6T+CX1DeLUXb6DHPqKpl7QTw1cQjQL9gT/CgwloqtOIlf1GWJ3ySxEFwUYnNrY9q/ajCa9RpMPc9IqVKrQVsa0GoUX4A3iM82TlQUJE5vQuceGY1KpOTZi2YM1pbLbnzlR8Ea803NJRYwo3UFk/Y5ZE7S9LBRJ/I4To9W6GdxjcnlZqSIciv7gz1lxxZRUSsTHSnquPrCXzdRzHeWK2y7JyJRGmVoA/H7nX3wNCPpr+HJQZegTHDih6hbdJcuhy66PaafiM7oILWUrgykZtnBtjIVFUScZWHEi6byGiVbk2d058YaQDg6k21mt7ZD3dupwJCvqmw0W60zCw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepuddtledrudehhedrudeftddrudeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrudeftddrudeitddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599DD2; Tue, 25 Aug 2020 09:38:10 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 08/18] computing_security_contexts: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:33 +0100
Message-Id: <20200825083743.6508-9-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/computing_security_contexts.md | 662 +++++++++++++++--------------
 1 file changed, 346 insertions(+), 316 deletions(-)

diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
index 5849375..bb946b5 100644
--- a/src/computing_security_contexts.md
+++ b/src/computing_security_contexts.md
@@ -1,5 +1,22 @@
 # Computing Security Contexts
 
+- [Security Context Computation for Kernel Objects](#security-context-computation-for-kernel-objects)
+  - [Process](#process)
+  - [Files](#files)
+  - [File Descriptors](#file-descriptors)
+  - [Filesystems](#filesystems)
+  - [Network File System (nfsv4.2)](#network-file-system-nfsv4.2)
+  - [INET Sockets](#inet-sockets)
+  - [IPC](#ipc)
+  - [Message Queues](#message-queues)
+  - [Semaphores](#semaphores)
+  - [Shared Memory](#shared-memory)
+  - [Keys](#keys)
+- [Using libselinux Functions](#using-libselinux-functions)
+  - [*avc_compute_create* and *security_compute_create*](#avc_compute_create-and-security_compute_create)
+  - [*avc_compute_member* and *security_compute_member*](#avc_compute_member-and-security_compute_member)
+  - [*security_compute_relabel*](#security_compute_relabel)
+
 SELinux uses a number of policy language statements and *libselinux*
 functions to compute a security context via the kernel security server.
 
@@ -15,9 +32,9 @@ components: a source context, a target context and an object class.
 The *libselinux* userspace functions used to compute a security context
 are:
 
--   ***avc_compute_create**(3)* and ***security_compute_create**(3)*
--   ***avc_compute_member**(3)* and ***security_compute_member**(3)*
--   ***security_compute_relabel**(3)*
+- ***avc_compute_create**(3)* and ***security_compute_create**(3)*
+- ***avc_compute_member**(3)* and ***security_compute_member**(3)*
+- ***security_compute_relabel**(3)*
 
 Note that these *libselinux* functions actually call the kernel
 equivalent functions in the security server (see kernel source
@@ -53,24 +70,24 @@ The initial task starts with the kernel security context, but the
 (e.g. *init_t*) when the init binary is executed after the policy has
 been loaded. Some init programs re-exec themselves after loading policy,
 while in other cases the initial policy load is performed by the
-*initrd*/*initramfs* script prior to mounting the real root and
-executing the real init program.
+*initrd*/*initramfs* script prior to mounting the real *root* and
+executing the real *init* program.
 
 Processes inherit their security context as follows:
 
-1.  On fork a process inherits the security context of its
-    creator/parent.
-2.  On *exec*, a process may transition to another security context
-    based on policy statements: *type_transition*, *range_transition*,
-    *role_transition* (policy version 26), *default_user*,
-    *default_role*, *default_range* (policy versions 27) and
-    *default_type* (policy version 28) or if a security-aware process,
-    by calling ***setexeccon**(3)* if permitted by policy prior to
-    invoking exec.
-3.  At any time, a security-aware process may invoke ***setcon**(3)* to
-    switch its security context (if permitted by policy) although this
-    practice is generally discouraged - exec-based transitions are
-    preferred.
+1. On fork a process inherits the security context of its
+   creator/parent.
+2. On *exec*, a process may transition to another security context
+   based on policy statements: *type_transition*, *range_transition*,
+   *role_transition* (policy version 26), *default_user*,
+   *default_role*, *default_range* (policy versions 27) and
+   *default_type* (policy version 28) or if a security-aware process,
+   by calling ***setexeccon**(3)* if permitted by policy prior to
+   invoking exec.
+3. At any time, a security-aware process may invoke ***setcon**(3)* to
+   switch its security context (if permitted by policy) although this
+   practice is generally discouraged - exec-based transitions are
+   preferred.
 
 ### Files
 
@@ -79,23 +96,23 @@ the following classes: files, symbolic links, directories, socket files,
 fifo's and block/character) upon creation for any filesystem type that
 supports labeling is as follows:
 
-1.  The user component is inherited from the creating process (policy
-    version 27 allows a *default_user* of source or target to be
-    defined for each object class).
-2.  The role component generally defaults to the *object_r* role
-    (policy version 26 allows a *role_transition* and version 27 allows
-    a *default_role* of source or target to be defined for each object
-    class).
-3.  The type component defaults to the type of the parent directory if
-    no matching *type_transition* rule was specified in the policy
-    (policy version 25 allows a filename *type_transition* rule and
-    version 28 allows a *default_type* of source or target to be
-    defined for each object class).
-4.  The *range*/*level* component defaults to the low/current level of
-    the creating process if no matching *range_transition* rule was
-    specified in the policy (policy version 27 allows a *default_range*
-    of source or target with the selected range being low, high or
-    low-high to be defined for each object class).
+1. The user component is inherited from the creating process (policy
+   version 27 allows a *default_user* of source or target to be
+   defined for each object class).
+2. The role component generally defaults to the *object_r* role
+   (policy version 26 allows a *role_transition* and version 27 allows
+   a *default_role* of source or target to be defined for each object
+   class).
+3. The type component defaults to the type of the parent directory if
+   no matching *type_transition* rule was specified in the policy
+   (policy version 25 allows a filename *type_transition* rule and
+   version 28 allows a *default_type* of source or target to be
+   defined for each object class).
+4. The *range*/*level* component defaults to the low/current level of
+   the creating process if no matching *range_transition* rule was
+   specified in the policy (policy version 27 allows a *default_range*
+   of source or target with the selected range being low, high or
+   low-high to be defined for each object class).
 
 Security-aware applications can override this default behavior by
 calling ***setfscreatecon**(3)* prior to creating the file, if permitted
@@ -116,7 +133,7 @@ Inherits the label of its creator/parent.
 ### Filesystems
 
 Filesystems are labeled using the appropriate *fs_use* kernel policy
-language statement as they are mounted, they are based on the filesystem
+language statement as they are mounted, they are based on the *filesystem*
 type name (e.g. *ext4*) and their behaviour (e.g. *xattr*). For example
 if the policy specifies the following:
 
@@ -128,37 +145,37 @@ then as the *pipefs* filesystem is being mounted, the SELinux LSM
 security hook *selinux_set_mnt_opts* will call *security_fs_use*
 that will:
 
--  Look for the filesystem name within the policy (*pipefs*)
--  If present, obtain its behaviour (*fs_use_task*)
--  Then obtain the allocated security context (*system_u:object_r:fs_t:s0*)
+- Look for the filesystem name within the policy (*pipefs*)
+- If present, obtain its behaviour (*fs_use_task*)
+- Then obtain the allocated security context (*system_u:object_r:fs_t:s0*)
 
 Should the behaviour be defined as *fs_use_task*, then the filesystem
 will be labeled as follows:
 
-1.  The user component is inherited from the creating process (policy
-    version 27 allows a *default_user* of source or target to be
-    defined).
-2.  The role component generally defaults to the *object_r* role
-    (policy version 26 allows a *role_transition* and version 27 allows
-    a *default_role* of source or target to be defined).
-3.  The type component defaults to the type of the target type if no
-    matching *type_transition* rule was specified in the policy (policy
-    version 28 allows a *default_type* of source or target to be
-    defined).
-4.  The *range*/*level* component defaults to the low/current level of
-    the creating process if no matching *range_transition* rule was
-    specified in the policy (policy version 27 allows a *default_range*
-    of source or target with the selected range being low, high or
-    low-high to be defined).
+1. The user component is inherited from the creating process (policy
+   version 27 allows a *default_user* of source or target to be
+   defined).
+2. The role component generally defaults to the *object_r* role
+   (policy version 26 allows a *role_transition* and version 27 allows
+   a *default_role* of source or target to be defined).
+3. The type component defaults to the type of the target type if no
+   matching *type_transition* rule was specified in the policy (policy
+   version 28 allows a *default_type* of source or target to be
+   defined).
+4. The *range*/*level* component defaults to the low/current level of
+   the creating process if no matching *range_transition* rule was
+   specified in the policy (policy version 27 allows a *default_range*
+   of source or target with the selected range being *low*, *high* or
+   *low-high* to be defined).
 
 Notes:
 
-1.  Filesystems that support *xattr* extended attributes can be
-    identified via the mount command as there will be a '*seclabel*'
-    keyword present.
-2.  There are mount options for allocating various context types:
-    *context=*, *fscontext=*, *defcontext=* and *rootcontext=*. They are
-    fully described in the ***mount**(8)* man page.
+1. Filesystems that support *xattr* extended attributes can be
+   identified via the mount command as there will be a '*seclabel*'
+   keyword present.
+2. There are mount options for allocating various context types:
+   *context=*, *fscontext=*, *defcontext=* and *rootcontext=*. They are
+   fully described in the ***mount**(8)* man page.
 
 ### Network File System (nfsv4.2)
 
@@ -171,22 +188,22 @@ section.
 If a socket is created by the ***socket**(3)* call they are labeled as
 follows:
 
-1.  The user component is inherited from the creating process (policy
-    version 27 allows a *default_user* of source or target to be
-    defined for each socket object class).
-2.  The role component is inherited from the creating process (policy
-    version 26 allows a *role_transition* and version 27 allows a
-    *default_role* of source or target to be defined for each socket
-    object class).
-3.  The type component is inherited from the creating process if no
-    matching *type_transition* rule was specified in the policy and
-    version 28 allows a *default_type* of source or target to be
-    defined for each socket object class).
-4.  The *range*/*level* component is inherited from the creating process
-    if no matching *range_transition* rule was specified in the policy
-    (policy version 27 allows a *default_range* of source or target
-    with the selected range being low, high or low-high to be defined
-    for each socket object class).
+1. The user component is inherited from the creating process (policy
+   version 27 allows a *default_user* of source or target to be
+   defined for each socket object class).
+2. The role component is inherited from the creating process (policy
+   version 26 allows a *role_transition* and version 27 allows a
+   *default_role* of source or target to be defined for each socket
+   object class).
+3. The type component is inherited from the creating process if no
+   matching *type_transition* rule was specified in the policy and
+   version 28 allows a *default_type* of source or target to be
+   defined for each socket object class).
+4. The *range*/*level* component is inherited from the creating process
+   if no matching *range_transition* rule was specified in the policy
+   (policy version 27 allows a *default_range* of source or target
+   with the selected range being *low*, *high* or *low-high* to be defined
+   for each socket object class).
 
 Security-aware applications may use ***setsockcreatecon**(3)* to
 explicitly label sockets they create if permitted by policy.
@@ -208,22 +225,22 @@ Inherits the label of its sending process. However if sending a message
 that is unlabeled, compute a new label based on the current process and
 the message queue it will be stored in as follows:
 
-1.  The user component is inherited from the sending process (policy
-    version 27 allows a *default_user* of source or target to be
-    defined for the message object class).
-2.  The role component is inherited from the sending process (policy
-    version 26 allows a *role_transition* and version 27 allows a
-    *default_role* of source or target to be defined for the message
-    object class).
-3.  The type component is inherited from the sending process if no
-    matching *type_transition* rule was specified in the policy and
-    version 28 allows a *default_type* of source or target to be
-    defined for the message object class).
-4.  The *range*/*level* component is inherited from the sending process
-    if no matching *range_transition* rule was specified in the policy
-    (policy version 27 allows a *default_range* of source or target
-    with the selected range being low, high or low-high to be defined
-    for the message object class).
+1. The user component is inherited from the sending process (policy
+   version 27 allows a *default_user* of source or target to be
+   defined for the message object class).
+2. The role component is inherited from the sending process (policy
+   version 26 allows a *role_transition* and version 27 allows a
+   *default_role* of source or target to be defined for the message
+   object class).
+3. The type component is inherited from the sending process if no
+   matching *type_transition* rule was specified in the policy and
+   version 28 allows a *default_type* of source or target to be
+   defined for the message object class).
+4. The *range*/*level* component is inherited from the sending process
+   if no matching *range_transition* rule was specified in the policy
+   (policy version 27 allows a *default_range* of source or target
+   with the selected range being *low*, *high* or *low-high* to be defined
+   for the message object class).
 
 ### Semaphores
 
@@ -244,249 +261,262 @@ explicitly label keys they create if permitted by policy.
 
 ### *avc_compute_create* and *security_compute_create*
 
-**Table 1** below shows how the components from the source context
+The table below shows how the components from the source context
 *scon*, target context *tcon* and class *tclass* are used to compute the
 new context *newcon* (referenced by SIDs for
 ***avc_compute_create**(3)*). The following notes also apply:
 
-1.  Any valid policy *role_transition*, *type_transition* and
-    *range_transition* enforcement rules will influence the final
-    outcome as shown.
-2.  For kernels less than 2.6.39 the context generated will depend on
-    whether the class is *process* or any other class.
-3.  For kernels 2.6.39 and above the following also applies:
--   Those classes suffixed by *socket* will also be included in the *process*
+1. Any valid policy [***role_transition***](role_statements.md#role_transition),
+   [***type_transition***](type_statements.md#type_transition) and
+   [***range_transition***](mls_statements.md#range_transition) enforcement
+   rules will influence the final outcome as shown.
+2. For kernels less than 2.6.39 the context generated will depend on
+   whether the class is *process* or any other class.
+3. For kernels 2.6.39 and above the following also applies:
+   - Those classes suffixed by *socket* will also be included in the *process*
     class outcome.
--   If a valid *role_transition* rule for *tclass*, then use that
-    instead of the default *object_r*. Also requires policy version
-    26 or greater - see ***security_policyvers**(3)*.
--   If the *type_transition* rule is classed as the 'file name
-    transition rule' (i.e. it has an *object_name* parameter), then
-    provided the object name in the rule matches the last component of
-    the objects name (in this case a file or directory name), then use
-    the rules *default_type*. Also requires policy version 25 or greater.
-4.  For kernels 3.5 and above with policy version 27 or greater, the
-    *default_user*, *default_role*, *default_range* statements will
-    influence the *user*, *role* and *range* of the computed context for
-    the specified class *tclass*. With policy version 28 or greater the
-    *default_type* statement can also influence the *type* in the
-    computed context.
-
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>user</strong></td>
-<td><strong>role</strong></td>
-<td><strong>type</strong></td>
-<td><strong>range</strong></td>
-</tr>
-<tr>
-<td><p>If kernel &gt;= 3.5 with a <strong>default_user </strong><em>tclass</em><strong> target</strong> rule then use <em>tcon</em> <em>user</em></p>
-<p>ELSE</p>
-<p>Use <em>scon</em> <em>user</em></p></td>
-<td><p>If kernel &gt;=2.6.39, and there is a valid</p>
-<p>role_transition</p>
-<p> rule then use the rules <em>new_role</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <em><strong>default_role </strong>tclass<strong> source</strong></em> rule then use <em>scon</em> <em>role</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <em><strong>default_role </strong>tclass<strong> target</strong></em> rule then use <em>tcon</em> <em>role</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 2.6.39 and <em>tclass</em> is <em><strong>process</strong></em> or <em>socket</em>, then use <em>scon</em> <em>role</em></p>
-<p>OR</p>
-<p>If kernel &lt;= 2.6.38 and <em>tclass</em> is <em><strong>process</strong></em>, then use <em>scon</em> <em>role</em></p>
-<p>ELSE</p>
-<p>Use <em><strong>object_r</strong></em></p></td>
-<td><p>If there is a valid</p>
-<p>type_transition</p>
-<p>rule then use the rules <em>default_type</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <em><strong>default_type </strong>tclass<strong> source</strong></em> rule then use <em>scon</em> <em>type</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <em><strong>default_type </strong>tclass<strong> target</strong></em> rule then use <em>tcon</em> <em>type</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 2.6.39 and <em>tclass</em> is <em><strong>process</strong></em> or <em>socket</em>, then use <em>scon</em> <em>type</em></p>
-<p>OR</p>
-<p>If kernel &lt;= 2.6.38 and <em>tclass</em> is <em><strong>process</strong></em>, then use <em>scon</em> <em>type</em></p>
-<p>ELSE</p>
-<p>Use <em>tcon</em> <em>type</em></p></td>
-<td><p> If there is a valid</p>
-<p>range_transition</p>
-<p> rule then use the rules <em>new_range</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> source low</strong> rule then use <em>scon</em> <em>low</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> source high</strong> rule then use <em>scon</em> <em>high</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> source low_high</strong> rule then use <em>scon</em> <em>range</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> target low</strong> rule then use <em>tcon</em> <em>low</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> target high</strong> rule then use <em>tcon</em> <em>high</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> target low_high</strong> rule then use <em>tcon</em> <em>range</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 2.6.39 and <em>tclass</em> is <em><strong>process</strong></em> or <em>socket</em>, then use <em>scon</em> <em>range</em></p>
-<p>OR</p>
-<p>If kernel &lt;= 2.6.38 and <em>tclass</em> is <em><strong>process</strong></em>, then use <em>scon</em> <em>range</em></p>
-<p>ELSE</p>
-<p>Use <em>scon</em> <em>low</em></p></td>
-</tr>
-</tbody>
-</table>
-
-**Table 1**
+   - If a valid *role_transition* rule for *tclass*, then use that
+     instead of the default *object_r*. Also requires policy version
+     26 or greater - see ***security_policyvers**(3)*.
+   - If the *type_transition* rule is classed as the 'file name
+     transition rule' (i.e. it has an *object_name* parameter), then
+     provided the object name in the rule matches the last component of
+     the objects name (in this case a file or directory name), then use
+     the rules *default_type*. Also requires policy version 25 or greater.
+4. For kernels 3.5 and above with policy version 27 or greater, the
+   *default_user*, *default_role*, *default_range* statements will
+   influence the *user*, *role* and *range* of the computed context for
+   the specified class *tclass*. With policy version 28 or greater the
+   *default_type* statement can also influence the *type* in the
+   computed context.
+
+***Computing avc_compute_create(3) and security_compute_create(3) contexts***:
+
+- ***user***
+  - IF kernel \>= 3.5 with a *default_user tclass target* rule then
+    use *tcon user*
+  - ELSE
+  - Use *scon user*
+- ***role***
+  - IF kernel \>=2.6.39, and there is a valid *role_transition* rule then
+    use the rules [***new_role***](role_statements.md#role_transition)
+  - OR
+  - IF kernel \>= 3.5 with *default_role tclass source* rule then use
+    *scon role*
+  - OR
+  - IF kernel \>= 3.5 with *default_role tclass target* rule then use
+    *tcon role*
+  - OR
+  - IF kernel \>= 2.6.39 and *tclass* is *process* or *\*socket*, then
+    use *scon role*
+  - OR
+  - IF kernel \<= 2.6.38 and *tclass* is *process* then use *scon role*
+  - ELSE
+  - Use *object_r*
+- ***type***
+  - IF there is a valid *type_transition* rule then use the rules
+    [***default_type***](type_statements.md#type_transition)
+  - OR
+  - IF kernel \>= 3.5 with *default_type tclass source* rule then use
+    *scon type*
+  - OR
+  - IF kernel \>= 3.5 with *default_type tclass target* rule then use
+    *tcon type*
+  - OR
+  - IF kernel \>= 2.6.39 and *tclass* is *process* or *\*socket* then
+    use *scon type*
+  - OR
+  - IF kernel \<= 2.6.38 and *tclass* is *process* then use *scon type*
+  - **ELSE**
+  - Use *tcon type*
+- ***range***
+  - IF there is a valid *range_transition* rule then use the rules
+    [***new_range***](mls_statements.md#range_transition)
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass source low* rule then
+    use *scon low*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass source high* rule then
+    use *scon high*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass source low_high* rule
+    then use *scon range*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass target low* rule then
+    use *tcon low*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass target high* rule then
+    use *tcon high*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass target low_high* rule
+    then use *tcon range*
+  - OR
+  - IF kernel \>= 2.6.39 and *tclass* is *process* or *\*socket* then
+    use *scon range*
+  - OR
+  - IF kernel \<= 2.6.38 and *tclass* is *process* then use *scon range*
+  - **ELSE**
+  - Use *scon low*
 
 ### *avc_compute_member* and *security_compute_member*
 
-**Table 2** shows how the components from the source context,
+The table below shows how the components from the source context,
 *scon* target context, *tcon* and class, *tclass* are used to compute
 the new context *newcon* (referenced by SIDs for
 ***avc_compute_member**(3)*). The following notes also apply:
 
-1.  Any valid policy *type_member* enforcement rules will influence the
-    final outcome as shown.
-2.  For kernels less than 2.6.39 the context generated will depend on
-    whether the class is *process* or any other class.
-3.  For kernels 2.6.39 and above, those classes suffixed by *socket* are
-    also included in the *process* class outcome.
-4.  For kernels 3.5 and above with policy version 28 or greater, the
-    *default_role*, *default_range* statements will influence the
-    *role* and *range* of the computed context for the specified class
-    *tclass*. With policy version 28 or greater the *default_type*
-    statement can also influence the *type* in the computed context.
-
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>user</strong></td>
-<td><strong>role</strong></td>
-<td><strong>type</strong></td>
-<td><strong>range</strong></td>
-</tr>
-<tr>
-<td>Always uses <em>tcon</em> <em>user</em></td>
-<td><p>If kernel &gt;= 3.5 with <strong>default_role </strong><em>tclass</em><strong> source</strong> rule then use <em>scon</em> <em>role</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_role </strong><em>tclass</em><strong> target</strong> rule then use <em>tcon</em> <em>role</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 2.6.39 and <em>tclass</em> is <strong>process</strong> or <em>socket</em>, then use <em>scon</em> <em>role</em></p>
-<p>OR</p>
-<p>If kernel &lt;= 2.6.38 and <em>tclass</em> is <strong>process</strong>, then use <em>scon</em> <em>role</em></p>
-<p>ELSE</p>
-<p>Use <strong>object_r</strong></p></td>
-<td><p>If there is a valid</p>
-<p>type_member</p>
-<p>rule then use the rules <em>member_type</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_type </strong><em>tclass</em><strong> source</strong> rule then use <em>scon</em> <em>type</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_type </strong><em>tclass</em><strong> target</strong> rule then use <em>tcon</em> <em>type</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 2.6.39 and <em>tclass</em> is <em><strong>process</strong></em> or <em>socket</em>, then use <em>scon</em> <em>type</em></p>
-<p>OR</p>
-<p>If kernel &lt;= 2.6.38 and <em>tclass</em> is <strong>process</strong>, then use <em>scon</em> <em>type</em></p>
-<p>ELSE</p>
-<p>Use <em>tcon</em> <em>type</em></p></td>
-<td><p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> source low</strong> rule then use <em>scon</em> <em>low</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> source high</strong> rule then use <em>scon</em> <em>high</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> source low_high</strong> rule then use <em>scon</em> <em>range</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> target low</strong> rule then use <em>tcon</em> <em>low</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> target high</strong> rule then use <em>tcon</em> <em>high</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> target low_high</strong> rule then use <em>tcon</em> <em>range</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 2.6.39 and <em>tclass</em> is <strong>process</strong> or <em>socket</em>, then use <em>scon</em> <em>range</em></p>
-<p>OR</p>
-<p>If kernel &lt;= 2.6.38 and <em>tclass</em> is <strong>process</strong>, then use <em>scon</em> <em>range</em></p>
-<p>ELSE</p>
-<p>Use <em>scon</em> <em>low</em></p></td>
-</tr>
-</tbody>
-</table>
-
-**Table 2**
+1. Any valid policy [***type_member***](type_statements.md#type_member)
+   enforcement rules will influence the final outcome as shown.
+2. For kernels less than 2.6.39 the context generated will depend on
+   whether the class is *process* or any other class.
+3. For kernels 2.6.39 and above, those classes suffixed by *socket* are
+   also included in the *process* class outcome.
+4. For kernels 3.5 and above with policy version 28 or greater, the
+   *default_role*, *default_range* statements will influence the
+   *role* and *range* of the computed context for the specified class
+   *tclass*. With policy version 28 or greater the *default_type*
+   statement can also influence the *type* in the computed context.
+
+***Computing avc_compute_member(3) and security_compute_member(3) contexts:***
+
+- ***user***
+  - Always uses *tcon user*
+- ***role***
+  - IF kernel \>= 3.5 with *default_role tclass source* rule then use
+    *scon role*
+  - OR
+  - IF kernel \>= 3.5 with *default_role tclass target* rule then use
+    *tcon role*
+  - OR
+  - IF kernel \>= 2.6.39 and *tclass* is *process* or *\*socket* then
+    use *scon role*
+  - OR
+  - IF kernel \<= 2.6.38 and *tclass* is *process* then use *scon role*
+  - ELSE
+  - Use *object_r*
+- ***type***
+  - IF there is a valid *type_member* rule then use the rules
+    [***member_type***](type_statements.md#type_member)
+  - OR
+  - IF kernel \>= 3.5 with *default_type tclass source* rule then use
+    *scon type*
+  - OR
+  - IF kernel \>= 3.5 with *default_type tclass target* rule then use
+    *tcon type*
+  - OR
+  - IF kernel \>= 2.6.39 and *tclass* is *process* or *\*socket* then
+    use *scon type*
+  - OR
+  - IF kernel \<= 2.6.38 and *tclass* is *process* then use *scon type*
+  - ELSE
+  - Use *tcon type*
+- ***range***
+  - IF kernel \>= 3.5 with *default_range tclass source low* rule then
+    use *scon low*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass source high* rule then
+    use *scon high*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass source low_high* rule
+    then use *scon range*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass target low* rule then
+      use *tcon low*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass target high* rule then
+    use *tcon high*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass target low_high* rule
+    then use *tcon range*
+  - OR
+  - IF kernel \>= 2.6.39 and *tclass* is *process* or *\*socket* then
+    use *scon range*
+  - OR
+  - IF kernel \<= 2.6.38 and *tclass* is *process* then use *scon range*
+  - ELSE
+  - Use *scon low*
 
 ### *security_compute_relabel*
 
-**Table 3** below shows how the components from the source context,
+The table below shows how the components from the source context,
 *scon* target context, *tcon* and class, *tclass* are used to compute
 the new context *newcon* for ***security_compute_relabel**(3)*. The
 following notes also apply:
 
-1.  Any valid policy *type_change* enforcement rules will influence the
-    final outcome shown in the table.
-2.  For kernels less than 2.6.39 the context generated will depend on
-    whether the class is *process* or any other class.
-3.  For kernels 2.6.39 and above, those classes suffixed by *socket*
-    are also included in the *process* class outcome.
-4.  For kernels 3.5 and above with policy version 28 or greater, the
-    *default_user*, *default_role*, *default_range* statements will
-    influence the *user*, *role* and *range* of the computed context for
-    the specified class *tclass*. With policy version 28 or greater the
-    *default_type* statement can also influence the *type* in the
-    computed context.
-
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>user</strong></td>
-<td><strong>role</strong></td>
-<td><strong>type</strong></td>
-<td><strong>range</strong></td>
-</tr>
-<tr>
-<td><p>If kernel &gt;= 3.5 with a <strong>default_user </strong><em>tclass</em><strong> target</strong> rule then use <em>tcon</em> <em>user</em></p>
-<p>ELSE</p>
-<p>Use <em>scon</em> <em>user</em></p></td>
-<td><p>If kernel &gt;= 3.5 with <strong>default_role </strong><em>tclass</em><strong> source</strong> rule then use <em>scon</em> <em>role</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_role </strong><em>tclass</em><strong> target</strong> rule then use <em>tcon</em> <em>role</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 2.6.39 and <em>tclass</em> is <strong>process</strong> or <em>socket</em>, then use <em>scon</em> <em>role</em></p>
-<p>OR</p>
-<p>If kernel &lt;= 2.6.38 and <em>tclass</em> is <strong>process</strong>, then use <em>scon</em> <em>role</em></p>
-<p>ELSE</p>
-<p>Use <strong>object_r</strong></p></td>
-<td><p>If there is a valid</p>
-<p>type_change</p>
-<p>rule then use the rules <em>change_type</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_type </strong><em>tclass</em><strong> source</strong> rule then use <em>scon</em> <em>type</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_type </strong><em>tclass</em><strong> target</strong> rule then use <em>tcon</em> <em>type</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 2.6.39 and <em>tclass</em> is <em><strong>process</strong></em> or <em>socket</em>, then use <em>scon</em> <em>type</em></p>
-<p>OR</p>
-<p>If kernel &lt;= 2.6.38 and <em>tclass</em> is <strong>process</strong>, then use <em>scon</em> <em>type</em></p>
-<p>ELSE</p>
-<p>Use <em>tcon</em> <em>type</em></p></td>
-<td><p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> source low</strong> rule then use <em>scon</em> <em>low</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> source high</strong> rule then use <em>scon</em> <em>high</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> source low_high</strong> rule then use <em>scon</em> <em>range</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> target low</strong> rule then use <em>tcon</em> <em>low</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> target high</strong> rule then use <em>tcon</em> <em>high</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 3.5 with <strong>default_range </strong><em>tclass</em><strong> target low_high</strong> rule then use <em>tcon</em> <em>range</em></p>
-<p>OR</p>
-<p>If kernel &gt;= 2.6.39 and <em>tclass</em> is <strong>process</strong> or <em>socket</em>, then use <em>scon</em> <em>range</em></p>
-<p>OR</p>
-<p>If kernel &lt;= 2.6.38 and <em>tclass</em> is <strong>process</strong>, then use <em>scon</em> <em>range</em></p>
-<p>ELSE</p>
-<p>Use <em>scon</em> <em>low</em></p></td>
-</tr>
-</tbody>
-</table>
-
-**Table 3**
+1. Any valid policy [***type_change***](type_statements.md#type_change)
+   enforcement rules will influence the final outcome shown in the table.
+2. For kernels less than 2.6.39 the context generated will depend on
+   whether the class is *process* or any other class.
+3. For kernels 2.6.39 and above, those classes suffixed by *socket*
+   are also included in the *process* class outcome.
+4. For kernels 3.5 and above with policy version 28 or greater, the
+   *default_user*, *default_role*, *default_range* statements will
+   influence the *user*, *role* and *range* of the computed context for
+   the specified class *tclass*. With policy version 28 or greater the
+   *default_type* statement can also influence the *type* in the
+   computed context.
+
+***Computing security_compute_relabel(3) contexts:***
+
+- ***user***
+  - If kernel \>= 3.5 with a *default_user tclass target* rule then use
+    *tcon user*
+  - ELSE
+  - Use *scon user*
+- ***role***
+  - IF kernel \>= 3.5 with *default_role tclass source* rule then use
+    *scon role*
+  - OR
+  - IF kernel \>= 3.5 with *default_role tclass target* rule then use
+    *tcon role*
+  - OR
+  - IF kernel \>= 2.6.39 and *tclass* is *process* or *\*socket* then use
+    *scon role*
+  - OR
+  - IF kernel \<= 2.6.38 and *tclass* is *process* then use *scon role*
+  - ELSE
+  - Use *object_r*
+- ***type***
+  - IF there is a valid *type_change* rule then use the rules
+    [***change_type***](type_statements.md#type_change)
+  - OR
+  - IF kernel \>= 3.5 with *default_type tclass source* rule then use
+    *scon type*
+  - OR
+  - IF kernel \>= 3.5 with *default_type tclass target* rule then use
+    *tcon type*
+  - OR
+  - IF kernel \>= 2.6.39 and *tclass* is *process* or *\*socket* then use
+    *scon type*
+  - OR
+  - IF kernel \<= 2.6.38 and *tclass* is *process* then use *scon type*
+  - ELSE
+  - Use *tcon type*
+- ***range***
+  - IF kernel \>= 3.5 with *default_range tclass source low* rule then use
+    *scon low*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass source high* rule then use
+    *scon high*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass source low_high* rule then
+    use *scon range*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass target low* rule then use
+    *tcon low*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass target high* rule then use
+    *tcon high*
+  - OR
+  - IF kernel \>= 3.5 with *default_range tclass target low_high* rule then
+    use *tcon range*
+  - OR
+  - IF kernel \>= 2.6.39 and *tclass* is *process* or *\*socket* then use
+    *scon range*
+  - OR
+  - IF kernel \<= 2.6.38 and *tclass* is *process* then use *scon range*
+  - ELSE
+  - Use *scon low*
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

