Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CED6C433DF
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 15:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B8520878
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 15:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="r1uHYJNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389540AbgJLPZi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 11:25:38 -0400
Received: from mailomta9-sa.btinternet.com ([213.120.69.15]:29703 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389951AbgJLPZi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 11:25:38 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20200902131748.DGWK19995.sa-prd-fep-041.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052668; 
        bh=DSD1nziWklDOmkkpGfGmb2HE2POtxVAGNLqdI4mpnFQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=r1uHYJNo84LbNdaxwWNhT3Qi21Osgny/vtqg3a/0RHcjMotfOZYmQzTB2/1Bh1bIwLaXuemjQBR5DeA1vBTe6+sqb4cyNq8u5vS3EGzAcxzUxJ9J+yWMYdlkqWv7o0J+InBEOuumqyTNsLrzRVxggsU9AsH9EvupFkVsGpZp0FkDXznXyDPTiIZodDQEpIkILYUgV/5O88Vpy3zpIKrai5rHuv1W04p5Cy7aa++2wjUDbX+OmqQ0kddCXwd4D2OQrupDFCV9N99s6gnt7u04QPHT9UnpSG4a89JrzCL/uZdu9n9rCYW/CZYWWp/GwrJqgJ3L2T63HfHNc3pHKP/OPg==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.32.197]
X-OWM-Source-IP: 109.155.32.197 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhjeehjeeijedvieeggffhkedtgfevveeuudegkeffveegfeefgfdvffejfeevveenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrrggtthhivhgvpdhpohhlihgthidrrggtthhivhgvnecukfhppedutdelrdduheehrdefvddrudeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrfedvrdduleejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhn
        vghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.197) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0EF36BEC; Wed, 2 Sep 2020 14:17:48 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 10/13] policy_store_config_files: Add TOC and tidy up formatting
Date:   Wed,  2 Sep 2020 14:17:35 +0100
Message-Id: <20200902131738.18425-11-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add TOC and tidy up formatting.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/policy_store_config_files.md | 432 +++++++++++++++++--------------
 1 file changed, 234 insertions(+), 198 deletions(-)

diff --git a/src/policy_store_config_files.md b/src/policy_store_config_files.md
index 3e7f8ab..93d3727 100644
--- a/src/policy_store_config_files.md
+++ b/src/policy_store_config_files.md
@@ -1,23 +1,47 @@
 # Policy Store Configuration Files
 
-**NOTE: Files in this area are private and subject to change, they should only
-be modified using the** ***semodule**(8)* and ***semanage**(8)* commands.
+- [*active/modules* Directory Contents](#activemodules-directory-contents)
+  - [*tmp* Policy Store (build failure)](#tmp-policy-store-build-failure)
+- [*active/commit_num*](#activecommit_num)
+  - [*active/policy.kern*](#activepolicy.kern)
+- [*active/policy.linked*](#activepolicy.linked)
+- [*active/seusers.linked*](#activeseusers.linked)
+- [*active/seusers_extra.linked*](#activeseusers_extra.linked)
+- [*active/booleans.local*](#activebooleans.local)
+- [*disable_dontaudit*](#disable_dontaudit)
+- [*active/file_contexts*](#activefile_contexts)
+  - [Building the File Labeling Support Files](#building-the-file-labeling-support-files)
+- [*active/file_contexts.local*](#activefile_contexts.local)
+- [*active/homedir_template*](#activehomedir_template)
+  - [*active/file_contexts.homedirs*](#activefile_contexts.homedirs)
+- [*active/seusers*](#activeseusers)
+- [*active/seusers.local*](#activeseusers.local)
+- [*active/users_extra*](#activeusers_extra)
+- [*active/users_extra.local*](#activeusers_extra.local)
+- [*active/users.local*](#activeusers.local)
+- [*active/interfaces.local*](#activeinterfaces.local)
+- [*active/nodes.local*](#activenodes.local)
+- [*active/ports.local*](#activeports.local)
+- [Set domain permissive mode](#set-domain-permissive-mode)
+
+**NOTE:** Files in this area are private and subject to change, they should only
+be modified using the ***semodule**(8)* and ***semanage**(8)* commands.
 
 Depending on the SELinux userspace library release being used the default
 policy stores will be located at:
 
--   */etc/selinux/&lt;SELINUXTYPE&gt;/modules* - This is the default for
-    systems that support versions &lt; 2.4 of the SELinux userspace library.
-    The migration process to &gt;= 2.4 is described at
-    <https://github.com/SELinuxProject/selinux/wiki/Policy-Store-Migration>.
--   */var/lib/selinux* - This is the default base for systems that
-    support versions &gt;= 2.4 of the SELinux userspace library. This base
-    may be overridden by the ***store-root*** parameter defined in the
-    [***semanage.conf**(5)*](global_config_files.md#etcselinuxsemanage.conf)
-    file. Multiple policy stores are supported by appending the
-    *&lt;SELINUXTYPE&gt;*, for example:
--   */var/lib/selinux/mls*
--   */var/lib/selinux/targeted*
+- */etc/selinux/\<SELINUXTYPE\>/modules* - This is the default for
+  systems that support versions \< 2.4 of the SELinux userspace library.
+  The migration process to \>= 2.4 is described at
+  <https://github.com/SELinuxProject/selinux/wiki/Policy-Store-Migration>.
+- */var/lib/selinux* - This is the default base for systems that
+  support versions \>= 2.4 of the SELinux userspace library. This base
+  may be overridden by the ***store-root*** parameter defined in the
+  [***semanage.conf**(5)*](global_config_files.md#etcselinuxsemanage.conf)
+  file. Multiple policy stores are supported by appending the
+  *\<SELINUXTYPE\>*, for example:
+  - */var/lib/selinux/mls*
+  - */var/lib/selinux/targeted*
 
 The Policy Store files are either installed, updated or built by the
 ***semodule**(8)* and ***semanage**(8)* commands as a part of the build
@@ -25,34 +49,35 @@ process with the resulting files being copied over to the
 [**The Policy Store**](configuration_files.md#the-policy-store) area.
 
 The policy configuration files are described relative to the default
-***store-root*** at */var/lib/selinux* with *&lt;SELINUXTYPE&gt;* being
+***store-root*** at */var/lib/selinux* with *\<SELINUXTYPE\>* being
 *targeted*.
 
 The ***semanage**(8)* command must be used to configure policy (the actual
 policy and supporting configuration files) within a specific **Policy Store**.
 The command types are:
--   [***semanage boolean***](#activebooleans.local) Manage booleans to
-    selectively enable functionality
--   [***semanage dontaudit***](#disable_dontaudit) Disable/Enable *dontaudit*
-    rules in policy
--   ***semanage export*** Output local customizations
--   [***semanage fcontext***](#activefile_contexts.local) Manage file context
-    mapping definitions
--   ***semanage ibendport*** Manage infiniband end port type definitions
--   ***semanage ibpkey*** Manage infiniband pkey type definitions
--   ***semanage import*** Import local customizations
--   [***semanage interface***](#activeinterfaces.local) Manage network interface
-    type definitions
--   [***semanage login***](#activeseusers.local) Manage login mappings between
-    linux users and SELinux confined users
--   [***semanage module***](#activemodules-directory-contents) Manage SELinux
-    policy modules
--   [***semanage node***](#activenodes.local) Manage network node type definitions
--   [***semanage permissive***](#set-domain-permissive-mode) Manage process
-    type enforcement mode.
--   [***semanage port***](#activeports.local) Manage network port type definitions
--   [***semanage user***](#activeusers.local) Manage  SELinux confined users
-(Roles and levels for an SELinux user)
+
+- [***semanage boolean***](#activebooleans.local) Manage booleans to
+  selectively enable functionality
+- [***semanage dontaudit***](#disable_dontaudit) Disable/Enable *dontaudit*
+  rules in policy
+- ***semanage export*** Output local customizations
+- [***semanage fcontext***](#activefile_contexts.local) Manage file context
+  mapping definitions
+- ***semanage ibendport*** Manage infiniband end port type definitions
+- ***semanage ibpkey*** Manage infiniband pkey type definitions
+- ***semanage import*** Import local customizations
+- [***semanage interface***](#activeinterfaces.local) Manage network interface
+  type definitions
+- [***semanage login***](#activeseusers.local) Manage login mappings between
+  linux users and SELinux confined users
+- [***semanage module***](#activemodules-directory-contents) Manage SELinux
+  policy modules
+- [***semanage node***](#activenodes.local) Manage network node type definitions
+- [***semanage permissive***](#set-domain-permissive-mode) Manage process
+  type enforcement mode.
+- [***semanage port***](#activeports.local) Manage network port type definitions
+- [***semanage user***](#activeusers.local) Manage SELinux confined users
+  (Roles and levels for an SELinux user)
 
 ## active/modules Directory Contents
 
@@ -84,8 +109,8 @@ test_policy               400       pp
 
 ### *tmp* Policy Store (build failure)
 
-When adding/updating a policy module and it fails to  build for some reason,
-the *tmp* directory (*/var/lib/selinux&lt;SELINUXTYPE&gt;/tmp*) will contain
+When adding/updating a policy module and it fails to build for some reason,
+the *tmp* directory (*/var/lib/selinux\<SELINUXTYPE\>/tmp*) will contain
 a copy of the failed policy for inspection. An example ***semodule*** failure
 message indicating the failing line number is:
 
@@ -103,7 +128,7 @@ store. The format is not relevant to policy construction.
 This is the binary policy file built by either the ***semanage**(8)* or
 ***semodule**(8)* commands (depending on the configuration action), that
 is then becomes the
-*/etc/selinux/&lt;SELINUXTYPE&gt;/policy/policy.&lt;ver&gt;* binary policy
+*/etc/selinux/\<SELINUXTYPE\>/policy/policy.\<ver\>* binary policy
 that will be loaded into the kernel.
 
 ## *active/policy.linked*
@@ -145,7 +170,7 @@ such as ***audit2allow**(8)* to list all denials to assist debugging policy.
 ## *active/file_contexts*
 
 This file becomes the policy
-[*/etc/selinux/&lt;SELINUXTYPE&gt;/contexts/files/file_contexts*](policy_config_files.md#contextsfilesfile_contexts)
+[*/etc/selinux/\<SELINUXTYPE\>/contexts/files/file_contexts*](policy_config_files.md#contextsfilesfile_contexts)
  file. It is built as described in the
 [**Building the File Labeling Support Files**](#building-the-file-labeling-support-files)
 section.
@@ -210,18 +235,18 @@ section.
 The process used to build the *file_contexts* and the *file_contexts.template*
 files is shown in **Figure 25: File Context Configuration Files**.
 
-1.  They are built by ***semanage**(8)*  using entries from the 'Policy File
-    Labeling' statements extracted from the
-    [*active/modules*](#activemodules-directory-contents) entries
-    (the *&lt;module_name&gt;.fc* files, this will include any CIL *(filecon ....)*
-    statements that are within CIL policy files).
-2.  As a part of the ***semanage**(8)* build process, these two files
-    will also have *file_contexts.bin* and *file_contexts.homedirs.bin*
-    files present in the
-    [Policy Configuration Files](policy_config_files.md#contextsfilesfile_contexts)
-    *./contexts/files* directory. This is because ***semanage**(8)* requires
-    these in the Perl compatible regular expression (PCRE) internal format.
-    They are generated by the ***sefcontext_compile**(8)* utility.
+1. They are built by ***semanage**(8)* using entries from the 'Policy File
+   Labeling' statements extracted from the
+   [*active/modules*](#activemodules-directory-contents) entries
+   (the *\<module_name\>.fc* files, this will include any CIL *(filecon ....)*
+   statements that are within CIL policy files).
+2. As a part of the ***semanage**(8)* build process, these two files
+   will also have *file_contexts.bin* and *file_contexts.homedirs.bin*
+   files present in the
+   [Policy Configuration Files](policy_config_files.md#contextsfilesfile_contexts)
+   *./contexts/files* directory. This is because ***semanage**(8)* requires
+   these in the Perl compatible regular expression (PCRE) internal format.
+   They are generated by the ***sefcontext_compile**(8)* utility.
 
 ![](./images/25-file_contexts.png)
 
@@ -237,66 +262,82 @@ pathname_regexp [file_type] security_context | <<none>>
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>pathname_regexp</code></td>
-<td><p>An entry that defines the pathname that may be in the form of a regular expression.</p>
-<p>The metacharacters '^' (match beginning of line) and '$' (match end of line) are automatically added to the expression by the routines that process this file, however they can be over-ridden by using '.*' at either the beginning or end of the expression (see the example <em>file_contexts</em> files below). </p>
-<p>The source policy <em>*.fc</em> and f<em>ile_contexts.template</em> files may also contain the keywords HOME_ROOT, HOME_DIR, ROLE and USER that will be replaced as explained in the next table.</p></td>
-</tr>
-<tr>
-<td><code>file_type</code></td>
-<td><p>One of the following optional file_type entries (note if blank means "all file types"):</p>
-<p>'<em>-b</em>' - Block Device         '<em>-c</em>' - Character Device</p>
-<p>'<em>-d</em>' - Directory               '<em>-p</em>' - Named Pipe (FIFO)</p>
-<p>'<em>-l</em>' - Symbolic Link      '<em>-s</em>' - Socket File</p>
-<p>'<em>--</em>' - Ordinary file</p>
-<p>By convention this entry is known as 'file type', however it really represents the 'file object class'.</p></td>
-</tr>
-<tr>
-<td><code>security_context</code></td>
-<td>This entry can be either:
-<p>a. The security context, including the MLS / MCS level or range if applicable that will be assigned to the file.</p>
-<p>b. A value of &lt;&lt;none&gt;&gt; can be used to indicate that matching files should not be re-labeled.</p></td>
-</tr>
-</tbody>
-</table>
-
-Keywords that can be in policy source \*.fc files and then form the *file_contexts.template* file entries are:
-
-<table>
-<tbody>
-<tr>
-<td>HOME_ROOT</td>
-<td>This keyword is replaced by the Linux users root home directory, normally <em>/home</em> is the default.</td>
-</tr>
-<tr>
-<td>HOME_DIR</td>
-<td>This keyword is replaced by the Linux users home directory, normally <em>/home/</em> is the default.</td>
-</tr>
-<tr>
-<td>USER</td>
-<td>This keyword will be replaced by the users Linux user id.</td>
-</tr>
-<tr>
-<td>ROLE</td>
-<td><p>This keyword is replaced by the <code>prefix</code> entry from the users_extra configuration file that corresponds to the SELinux users user id. Example users_extra configuration file entries are:</p>
-<p><code>user user_u  prefix user;</code></p>
-<p><code>user staff_u prefix staff;</code></p>
-<p>It is used for files and directories within the users home directory area. </p>
-<p>The prefix can be added by the semanage <em>login</em> command as follows (although note that the <em>-P</em> option is suppressed when help is displayed as it is generally it is not used (defaults to <em>user</em>:</p>
-<p># Add a Linux user:</p>
-<p><code>adduser rch</code></p>
-<p># Modify staff_u SELinux user and prefix:</p>
-<p><code>semanage user -m -R staff_r -P staff staff_u</code></p>
-<p># Associate the SELinux user to the Linux user:</p>
-<p><code>semanage login -a -s staff_u rch</code></p></td>
-</tr>
-</tbody>
-</table>
-
-**Example policy source file from Reference Policy** *policy/modules/system/userdomain.fc*:
+*pathname_regexp*
+
+- An entry that defines the pathname that may be in the form of a regular
+  expression. The metacharacters '^' (match beginning of line) and '\$'
+  (match end of line) are automatically added to the expression by the
+  routines that process this file, however they can be over-ridden by
+  using '\.\*' at either the beginning or end of the expression (see the
+  example *file_contexts* files below).
+- The source policy *\*.fc* and *file_contexts.template* files may also
+  contain the keywords *HOME_ROOT*, *HOME_DIR*, *ROLE* and *USER* that will
+  be replaced as explained in the next table.
+
+*file_type*
+
+- One of the following optional file_type entries (note if blank means
+  "all file types"):
+  - *-b* - Block Device
+  - *-c* - Character Device
+  - *-d* - Directory
+  - *-p* - Named Pipe (FIFO)
+  - *-l* - Symbolic Link
+  - *-s* - Socket File
+  - *\-\-* - Ordinary file
+- By convention this entry is known as *file type*, however it really
+  represents the 'file object class'.
+
+*security_context*
+
+- This entry can be either:
+  - The security context, including the MLS / MCS level or range if applicable
+    that will be assigned to the file.
+  - A value of \<\<none\>\> can be used to indicate that matching files should
+    not be re-labeled.
+
+Keywords that can be in policy source \*.fc files and then form the
+*file_contexts.template* file entries are:
+
+*HOME_ROOT*
+
+- This keyword is replaced by the Linux users root home directory,
+  normally */home* is the default.
+
+*HOME_DIR*
+
+- This keyword is replaced by the Linux users home directory,
+  normally */home/* is the default.
+
+*USER*
+
+- This keyword will be replaced by the users Linux user id.
+
+*ROLE*
+
+- This keyword is replaced by the *prefix* entry from the *users_extra*
+  configuration file that corresponds to the SELinux users user id. Example
+  *users_extra* configuration file entries are:
+  - *user user_u prefix user;*
+  - *user staff_u prefix staff;*
+- It is used for files and directories within the users home directory area.
+  The prefix can be added by the semanage *login* command as follows
+  (although note that the *-P* option is suppressed when help is displayed
+  as it is generally it is not used (defaults to *user*)):
+
+```
+# Add a Linux user:
+
+adduser rch
+# Modify staff_u SELinux user and prefix:
+semanage user -m -R staff_r -P staff staff_u
+
+# Associate the SELinux user to the Linux user:
+semanage login -a -s staff_u rch
+```
+
+**Example policy source file from Reference Policy**
+*policy/modules/system/userdomain.fc*:
 
 ```
 HOME_DIR	-d	gen_context(system_u:object_r:user_home_dir_t,s0-mls_systemhigh)
@@ -309,7 +350,8 @@ HOME_DIR/.+		gen_context(system_u:object_r:user_home_t,s0)
 /root/\.debug(/.*)?	<<none>>
 ```
 
-**Example policy source file from Reference Policy** *policy/modules/kernel/files.fc*:
+**Example policy source file from Reference Policy**
+*policy/modules/kernel/files.fc*:
 
 ```
 #
@@ -387,8 +429,8 @@ HOME_DIR/.+	system_u:object_r:user_home_t:s0
 ### *active/file_contexts.homedirs*
 
 This file becomes the policy
-[*/etc/selinux/<SELINUXTYPE>/contexts/files/file_contexts.homedirs*](policy_config_files.md#contextsfilesfile_contexts.homedirs) file. It is built
-as described in the
+[*/etc/selinux/\<SELINUXTYPE\>/contexts/files/file_contexts.homedirs*](policy_config_files.md#contextsfilesfile_contexts.homedirs)
+file. It is built as described in the
 [**Building the File Labeling Support Files**](#building-the-file-labeling-support-files)
 section. It is then used by the file labeling utilities to ensure that users
 home directory areas are labeled according to the policy.
@@ -419,32 +461,32 @@ libsepol library function.
 /home/[^/]+/.+	unconfined_u:object_r:user_home_t:s0
 ```
 
-## active/seusers
-## active/seusers.local
+## *active/seusers*
+## *active/seusers.local*
 
-The *active/seusers* file becomes the policy */etc/selinux/<SELINUXTYPE>/seusers*
+The *active/seusers* file becomes the policy */etc/selinux/\<SELINUXTYPE\>/seusers*
 file, the *active/seusers.local* file holds entries added when adding users via
 ***semanage**(8)*.
 
 The *seusers* file is built or modified when:
 
-1.  Building a policy where an optional *seusers* file has been included
-    in the base package via the ***semodule_package**(8)* command
-    (signified by the *-s* flag) as follows:
--   *semodule_package -o base.pp -m base.mod -s seusers ...*
--   The *seusers* file would be extracted by the subsequent ***semodule*** command
-    when building the policy to produce the *seusers.final* file.
-2.  The ***semanage login*** command is used to map Linux users to
-    SELinux users as follows:
--   *semanage login -a -s staff_u rch*
--   This action will update the *seusers* file that would then be used to
-    produce the seusers.final file with both policy and locally defined user
-    mapping.
-3.  It is also possible to associate a Linux group of users to an
-    SELinux user as follows:
--   *semanage login -a -s staff_u %staff_group*
-
-**The format of the** *seusers* & *seusers.local* **files are as follows:**
+1. Building a policy where an optional *seusers* file has been included
+   in the base package via the ***semodule_package**(8)* command
+   (signified by the *-s* flag) as follows:
+   - *semodule_package -o base.pp -m base.mod -s seusers ...*
+   - The *seusers* file would be extracted by the subsequent ***semodule***
+     command when building the policy to produce the *seusers.final* file.
+2. The ***semanage login*** command is used to map Linux users to
+   SELinux users as follows:
+   - *semanage login -a -s staff_u rch*
+   - This action will update the *seusers* file that would then be used to
+      produce the seusers.final file with both policy and locally defined user
+      mapping.
+3. It is also possible to associate a Linux group of users to an
+   SELinux user as follows:
+   - *semanage login -a -s staff_u %staff_group*
+
+**The format of the** *seusers* and *seusers.local* **files are as follows:**
 
 ```
 [%]user_id:seuser_id[:range]
@@ -452,22 +494,18 @@ The *seusers* file is built or modified when:
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>user_id</td>
-<td>Where <em>user_id</em> is the Linux user identity. If this is a Linux <em>group_id</em> then it will be preceded with the '<em>%</em>' sign as shown in the example below.</td>
-</tr>
-<tr>
-<td>seuser_id</td>
-<td>The SELinux user identity.</td>
-</tr>
-<tr>
-<td>range</td>
-<td>The optional <em>level</em> or range.</td>
-</tr>
-</tbody>
-</table>
+*user_id*
+
+- Where *user_id* is the Linux user identity. If this is a Linux *group_id*
+  then it will be preceded with the '*%*' sign as shown in the example below.
+
+*seuser_id*
+
+- The SELinux user identity.
+
+*range*
+
+- The optional *level* or *range*.
 
 **Example** *seusers* **file contents:**
 
@@ -510,32 +548,32 @@ rch:user_u:s0
 These three files work together to describe SELinux user information as
 follows:
 
-1.  The *users_extra* and *users_extra.local* files are used to map a
-    *prefix* to a users home directories as discussed in the
-    [**Building the File Labeling Support Files**](#building-the-file-labeling-support-files)
-    section, where it is used to replace the *ROLE* keyword. The
-    *prefix* is linked to an SELinux user id and should reflect the users role.
--   The *users_extra* file contains all the policy *prefix* entries, and the
-    *users_extra.local* file contains those generated by the ***semanage user***
-    command.
--   The *users_extra* file can optionally be included in the base package via
-    the ***semodule_package**(8)* command (signified by the *-u* flag) as
-    follows:
--   *semodule_package -o base.pp -m base.mod -u users_extra ...*
--   The *users_extra* file would then be extracted by a subsequent semodule
-    command when building the policy.
-2.  The *users.local* file is used to add new SELinux users to the policy
-    without editing the policy source itself (with each line in the file
-    following a policy language
-    [**user Statement**](user_statements.md#user-statements)).
-    This is useful when only the Reference Policy headers are installed and
-    additional users need to be added. The ***semanage user*** command will allow
-    a new SELinux user to be added that would generate the *user.local* file
-    and if a *-P* flag has been specified, then a *users_extra.local* file is also
-    updated (note: if this is a new SELinux user and a prefix is not specified
-    a default *prefix* of user is generated).
-
-**The format of the** *users_extra* & *users_extra.local* **files are:**
+1. The *users_extra* and *users_extra.local* files are used to map a
+   *prefix* to a users home directories as discussed in the
+   [**Building the File Labeling Support Files**](#building-the-file-labeling-support-files)
+   section, where it is used to replace the *ROLE* keyword. The
+   *prefix* is linked to an SELinux user id and should reflect the users role.
+   - The *users_extra* file contains all the policy *prefix* entries, and the
+     *users_extra.local* file contains those generated by the
+     ***semanage user*** command.
+   - The *users_extra* file can optionally be included in the base package via
+     the ***semodule_package**(8)* command (signified by the *-u* flag) as
+     follows:
+   - *semodule_package -o base.pp -m base.mod -u users_extra ...*
+   - The *users_extra* file would then be extracted by a subsequent semodule
+   command when building the policy.
+2. The *users.local* file is used to add new SELinux users to the policy
+   without editing the policy source itself (with each line in the file
+   following a policy language
+   [**user Statement**](user_statements.md#user-statements)).
+   This is useful when only the Reference Policy headers are installed and
+   additional users need to be added. The ***semanage user*** command will allow
+   a new SELinux user to be added that would generate the *user.local* file
+   and if a *-P* flag has been specified, then a *users_extra.local* file is also
+   updated (note: if this is a new SELinux user and a prefix is not specified
+   a default *prefix* of user is generated).
+
+**The format of the** *users_extra* and *users_extra.local* **files are:**
 
 ```
 user seuser_id prefix prefix_id;
@@ -543,26 +581,24 @@ user seuser_id prefix prefix_id;
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>user</td>
-<td>The user keyword.</td>
-</tr>
-<tr>
-<td>seuser_id</td>
-<td>The SELinux user identity.</td>
-</tr>
-<tr>
-<td>prefix</td>
-<td>The prefix keyword.</td>
-</tr>
-<tr>
-<td>prefix_id</td>
-<td>An identifier that will be used to replace the ROLE keyword within the active/homedir_template file when building the active/file_contexts.homedirs file for the relabeling utilities to set the security context on users home directories.</td>
-</tr>
-</tbody>
-</table>
+*user*
+
+- The user keyword.
+
+*seuser_id*
+
+- The SELinux user identity.
+
+*prefix*
+
+- The prefix keyword.
+
+*prefix_id*
+
+- An identifier that will be used to replace the *ROLE* keyword within the
+  *active/homedir_template* file when building the
+  *active/file_contexts.homedirs* file for the relabeling utilities to set
+  the security context on users home directories.
 
 **Example** *users_extra* **file contents:**
 
-- 
2.26.2

