Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C780BC43461
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B26C206B7
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 22:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="posrajiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgIOWEM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:04:12 -0400
Received: from mailomta17-sa.btinternet.com ([213.120.69.23]:61355 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728037AbgIOWDP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 18:03:15 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20200902131747.LIKU5290.sa-prd-fep-040.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052667; 
        bh=mRFlu6AUIRasfGcfogtV+u9I3+Thj9E7BIG8PWv387o=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=posrajivUdrIEi7KLAHHLXcWQkUc/CLO40/y59UyjX7QR5dCry0801gBJ90YcziIvWDp4TGU8FJu31EYdK5MY5TGlYVS/QULdk7wjeJY3aHRi7zM4vRddUxbnp6y48e54Ck86Tz7NCOzdrxMwYh9/gEfW6mBQu0e5cEtr3xCYZxoXpDy4aZm+4C9BJTV4GiJRT3ADCrpqELD28hlasa9vR23f4ZGMq+paixJQ/YSs0Ec93bQYxptfCTMB18h5UTDNy1zq03OFGFsD+A+jvog49my8GEi5wmUNuB/v261HN3ZqzroyvqS9NUjY2kzH5rmyKsVZpos2m0wUoWl7eWlPQ==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.32.197]
X-OWM-Source-IP: 109.155.32.197 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepgfekgffghffgleekgfellefftedvhfejveehhfekkefgvdehueetgfffffelkedtnecukfhppedutdelrdduheehrdefvddrudeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrfedvrdduleejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.197) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0EF36BC0; Wed, 2 Sep 2020 14:17:47 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 06/13] objects: Convert to markdown
Date:   Wed,  2 Sep 2020 14:17:31 +0100
Message-Id: <20200902131738.18425-7-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/objects.md | 185 +++++++++++++++++++++++++------------------------
 1 file changed, 95 insertions(+), 90 deletions(-)

diff --git a/src/objects.md b/src/objects.md
index 09c77f3..8762cb9 100644
--- a/src/objects.md
+++ b/src/objects.md
@@ -1,5 +1,13 @@
 # Objects
 
+- [Object Classes and Permissions](#object-classes-and-permissions)
+- [Allowing a Process Access to Resources](#allowing-a-process-access-to-resources)
+- [Labeling Objects](#labeling-objects)
+  - [Labeling Extended Attribute Filesystems](#labeling-extended-attribute-filesystems)
+    - [Copying and Moving Files](#copying-and-moving-files)
+- [Labeling Subjects](#labeling-subjects)
+- [Object Reuse](#object-reuse)
+
 Within SELinux an object is a resource such as files, sockets, pipes or
 network interfaces that are accessed via processes (also known as
 subjects). These objects are classified according to the resource they
@@ -11,8 +19,8 @@ in the following sections.
 ## Object Classes and Permissions
 
 Each object consists of a class identifier that defines its purpose
-(e.g. file, socket) along with a set of permissions (Also known in SELinux
-as Access Vectors (AV)) that describe what services the object can handle
+(e.g. file, socket) along with a set of permissions (also known as Access
+Vectors (AV)) that describe what services the object can handle
 (read, write, send etc.).
 When an object is instantiated it will be allocated a name (e.g. a file
 could be called config or a socket my_connection) and a security
@@ -23,7 +31,7 @@ context (e.g. *system_u:object_r:selinux_config_t*) as shown in
 
 **Figure 5: Object Class = 'file' and permissions** - *the policy rules would
 define those permissions allowed for each process that needs access to
-the */etc/selinux/config* file.*
+the /etc/selinux/config file.*
 
 The objective of the policy is to enable the user of the object (the
 subject) access to the minimum permissions needed to complete the task
@@ -45,9 +53,9 @@ permissions are described in
 
 This is a simple example that attempts to explain two points:
 
-1.  How a process is given permission to use an objects resource.
-2.  By using the *process* object class, show that a process can be
-    described as a process or object.
+1. How a process is given permission to use an objects resource.
+2. By using the *process* object class, show that a process can be
+   described as a process or object.
 
 An SELinux policy contains many rules and statements, the majority of
 which are *allow* rules that (simply) allows processes to be given
@@ -66,36 +74,35 @@ allow        unconfined_t    ext_gateway_t :  process  transition;
 
 Where:
 
-<table>
-<tbody>
-<tr>
-<td>allow</td>
-<td>The SELinux language allow rule.</td>
-</tr>
-<tr>
-<td>unconfined_t</td>
-<td>The source domain (or subject) identifier - in this case the shell that wants to exec the gateway application.</td>
-</tr>
-<tr>
-<td>ext_gateway_t</td>
-<td>The target object identifier - the object instance of the gateway application process. </td>
-</tr>
-<tr>
-<td>process</td>
-<td>The target object class - the *process* object class.</td>
-</tr>
-<tr>
-<td>transition</td>
-<td>The permission granted to the source domain on the targets object - in this case the *unconfined_t* domain has transition permission on the *ext_gateway_t* *process* object.</td>
-</tr>
-</tbody>
-</table>
+*allow*
+
+- The SELinux language *allow* rule.
+
+*unconfined_t*
+
+- The source domain (or subject) identifier - in this case the shell that
+  wants to *exec* the gateway application.
+
+*ext_gateway_t*
+
+- The target object identifier - the object instance of the gateway
+  application process.
+
+*process*
+
+- The target object class - the *process* object class.
+
+*transition*
+
+- The permission granted to the source domain on the targets object - in this
+  case the *unconfined_t* domain has transition permission on the
+  *ext_gateway_t process* object.
 
 ![](./images/6-allow-rule.png)
 
 **Figure 6: The *allow* rule** - *Showing that the subject (the processes
-running in the *unconfined_t* domain) has been given the transition
-permission on the *ext_gateway_t* *process* object.*
+running in the unconfined_t domain) has been given the transition
+permission on the ext_gateway_t process object.*
 
 It should be noted that there is more to a domain transition than
 described above, for a more detailed explanation, see the
@@ -108,28 +115,28 @@ objects is managed by the system and generally unseen by the users
 (until labeling goes wrong !!). As processes and objects are created and
 destroyed, they either:
 
-1.  Inherit their labels from the parent process or object. The policy
-    default user, type, role and range statements can be used to
-	change the behavior as discussed in the [**Default Rules**](default_rules.md#default-object-rules)
-    section.
-2.  The policy type, role and range transition statements allow a
-    different label to be assigned as discussed in the
-    [**Domain and Object Transitions**](domain_object_transitions.md#domain-and-object-transitions)
-    section.
-3.  SELinux-aware applications can assign a new label (with the
-    policy's approval of course) using the **libselinux** API
-    functions. The `process setfscreate` permission can be used to
-    allow subjects to create files with a new label programmatically
-    using the ***setfscreatecon**(3)* function, overriding default
-    rules and transition statements.
-4.  An object manager (OM) can enforce a default label that can either
-    be built into the OM or obtained via a configuration file (such as
-    those used by
-    [**SELinux X-Windows Support**](x_windows.md#x-windows-selinux-support).
-5.  Use an '[**initial security identifier**](sid_statement.md#security-id-sid-statement)'
-    (or initial SID). These are defined in all policies and are used to either
-    set an initial context during the boot process, or if an object requires
-    a default (i.e. the object does not already have a valid context).
+1. Inherit their labels from the parent process or object. The policy
+   default user, type, role and range statements can be used to
+   change the behavior as discussed in the [**Default Rules**](default_rules.md#default-object-rules)
+   section.
+2. The policy type, role and range transition statements allow a
+   different label to be assigned as discussed in the
+   [**Domain and Object Transitions**](domain_object_transitions.md#domain-and-object-transitions)
+   section.
+3. SELinux-aware applications can assign a new label (with the
+   policy's approval of course) using the **libselinux** API
+   functions. The *process { setfscreate }* permission can be used to
+   allow subjects to create files with a new label programmatically
+   using the ***setfscreatecon**(3)* function, overriding default
+   rules and transition statements.
+4. An object manager (OM) can enforce a default label that can either
+   be built into the OM or obtained via a configuration file (such as
+   those used by
+   [**SELinux X-Windows Support**](x_windows.md#x-windows-selinux-support).
+5. Use an '[**initial security identifier**](sid_statement.md#security-id-sid-statement)'
+   (or initial SID). These are defined in all policies and are used to either
+   set an initial context during the boot process, or if an object requires
+   a default (i.e. the object does not already have a valid context).
 
 The [**Computing Security Contexts**](computing_security_contexts.md#computing-security-contexts)
 section gives detail on how some of the kernel based objects are computed.
@@ -149,26 +156,24 @@ section.
 ### Labeling Extended Attribute Filesystems
 
 The labeling of file systems that implement extended
-attributes<a href="#fno1" class="footnote-ref" id="fnobj1"><strong><sup>1</sup></strong></a>
-is supported by SELinux using:
-
-1.  The *fs_use_xattr* statement within the policy to identify what
-    filesystems use extended attributes. This statement is used to
-    inform the security server how to label the filesystem.
-2.  A 'file contexts' file that defines what the initial contexts should
-    be for each file and directory within the filesystem. The format of
-    this file and how it is built from source policy is described in the
-    [**Policy Store Configuration Files - Building the File Labeling Support Files**](policy_store_config_files.md#building-the-file-labeling-support-files)<a href="#fno2" class="footnote-ref" id="fnobj2"><strong><sup>2</sup></strong></a>
-    section.
-
-3.  A method to initialise the filesystem with these extended
-    attributes. This is achieved by SELinux utilities such as
-    ***fixfiles**(8)* and ***setfiles**(8)*. There are also commands such as
-    ***chcon**(1)*, ***restorecon**(8)* and ***restorecond**(8)* that can be
-    used to relabel files.
+attributes[^fn_objs_1] is supported by SELinux using:
+
+1. The *fs_use_xattr* statement within the policy to identify what
+   filesystems use extended attributes. This statement is used to
+   inform the security server how to label the filesystem.
+2. A 'file contexts' file that defines what the initial contexts should
+   be for each file and directory within the filesystem. The format of
+   this file and how it is built from source policy is described in the
+   [**Policy Store Configuration Files - Building the File Labeling Support Files**](policy_store_config_files.md#building-the-file-labeling-support-files)[^fn_objs_2]
+   section.
+3. A method to initialise the filesystem with these extended
+   attributes. This is achieved by SELinux utilities such as
+   ***fixfiles**(8)* and ***setfiles**(8)*. There are also commands such as
+   ***chcon**(1)*, ***restorecon**(8)* and ***restorecond**(8)* that can be
+   used to relabel files.
 
 Extended attributes containing the SELinux context of a file can be
-viewed by the ls -Z or ***getfattr**(1)* commands as follows:
+viewed by the *ls -Z* or ***getfattr**(1)* commands as follows:
 
 ```
 ls -Z myfile
@@ -191,8 +196,8 @@ Assuming that the correct permissions have been granted by the policy,
 the effects on the security context of a file when copied or moved
 differ as follows:
 
--   copy a file - takes on label of new directory.
--   move a file - retains the label of the file.
+- copy a file - takes on label of new directory.
+- move a file - retains the label of the file.
 
 However, if the ***restorecond**(8)* daemon is running and the
 [**restorecond.conf**](global_config_files.md#etcselinuxrestorecond.conf)
@@ -262,26 +267,26 @@ discussed in the
 The policy language supports a number of statements to assign components
 to security contexts such as:
 
-*user*, *role* and *type* statements.
+- *user*, *role* and *type* statements.
 
-and manage their scope:
+and to manage their scope:
 
-*role_allow* and *constrain*
+- *role_allow* and *constrain*
 
-and manage their transition:
+and to manage their transition:
 
-*type_transition*, *role_transition* and *range_transition*
+- *type_transition*, *role_transition* and *range_transition*
 
 SELinux-aware applications can assign a new label (with the policy's
 approval of course) using the **libselinux** API functions. The
-`process setexec`, `process setkeycreate` and `process setsockcreate`
+*process { setexec setkeycreate setsockcreate }*
 permissions can be used to allow subjects to label processes,
 kernel keyrings, and sockets programmatically using the
 ***setexec**(3)*, ***setkeycreatecon**(3)* and
 ***setsockcreatecon**(3)* functions respectively, overriding
 transition statements.
 
-The `kernel` **initial security identifier** is used to associate
+The *kernel* **initial security identifier** is used to associate
 a specified label with kernel objects, including kernel threads
 (both those that are created during initialization but also kernel
 threads created later), kernel-private sockets and synthetic objects
@@ -293,7 +298,7 @@ either a policy-defined transition or an explicit setcon or
 setexeccon+execve, but that's just the typical default inheritance
 from creating task behavior for processes.
 
-The context associated with the `unlabeled`
+The context associated with the *unlabeled*
 **initial security identifier** is used as the fallback context for
 both subjects and objects when their label is invalidated by a policy
 reload (their SID is unchanged but the SID is transparently remapped
@@ -302,7 +307,7 @@ for various objects e.g. inodes, superblocks, etc until they reach a
 point where a more specific label can be determined e.g. from an
 xattr or from policy.
 
-### Object Reuse
+## Object Reuse
 
 As GNU / Linux runs it creates instances of objects and manages the
 information they contain (read, write, modify etc.) under the control of
@@ -319,13 +324,13 @@ process itself should clear or shred the information before releasing
 the object (which can be difficult in some cases unless the source code
 is available).
 
-<section class="footnotes">
-<ol>
-<li id="fno1"><p>These file systems store the security context in an attribute
-associated with the file.<a href="#fnobj1" class="footnote-back">↩</a></p></li>
-<li id="fno2"><p>Note that this file contains the contexts of all files in all extended attribute filesystems for the policy. However within a modular policy (and/or CIL modules) each module describes its own file context information, that is then used to build this file.<a href="#fnobj2" class="footnote-back">↩</a></p></li>
-</ol>
-</section>
+[^fn_objs_1]: These file systems store the security context in an attribute
+associated with the file.
+
+[^fn_objs_2]: Note that this file contains the contexts of all files in all
+extended attribute filesystems for the policy. However within a modular policy
+(and/or CIL modules) each module describes its own file context information,
+that is then used to build this file.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

