Return-Path: <SRS0=Syrn=BT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C778DC433DF
	for <selinux@archiver.kernel.org>; Sun,  9 Aug 2020 16:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E44A2068F
	for <selinux@archiver.kernel.org>; Sun,  9 Aug 2020 16:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="RjS/6Gyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHIQVT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:21:19 -0400
Received: from mailomta5-sa.btinternet.com ([213.120.69.11]:65275 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbgHIQVT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 9 Aug 2020 12:21:19 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200809162110.UCUO4139.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Sun, 9 Aug 2020 17:21:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1596990070; 
        bh=KXO5NPCm+jDzudrRjKtgmYaeS9/YWBdKIFTjLVRioNQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=RjS/6GydS8kAb6qKriBvO4PuJFVpiNiwjBeX1+1bdwW7Kjd1TkKVlB2skRKA8Ii6xxNaaKp6s+1t1wTtsYQ2QvxOIeGlBUEPQe/5i9wjKY73TWZXUKXugBOKsNZwSvg7Lpu9yBnw6+MCEX/ImhubUw175hpQgF5xSrd8Z26OkT0W80aHKw6nhfA7Td/avqbTPKYMKrFx4gawr2r5343T0AAbZy2P18CQ915dp32mUtM988loaQ9wEbDF3gsk5D2I4vQIkPDYpQ3vmGZR3FMXXY9DUqZtPWNwF4nGqT/J+5irobdm/OTyStvRJaFHT9++Ka88gbj50PUIIRny/vqJQA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [81.147.56.64]
X-OWM-Source-IP: 81.147.56.64 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrkeeigdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofggtgfgsehtkeertdertdernecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeduveeffedutdeuhefgkeehvefhkeffueduffekjefhgfdvueeuffekvedvjefggfenucfkphepkedurddugeejrdehiedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudegjedrheeirdeigedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.147.56.64) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70AE72272; Sun, 9 Aug 2020 17:21:10 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-notebook: policy_config_files.md convert to markdown
Date:   Sun,  9 Aug 2020 17:21:08 +0100
Message-Id: <20200809162108.193636-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert HTML tables to markdown
unordered lists.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/policy_config_files.md | 477 ++++++++++++++++++-------------------
 1 file changed, 233 insertions(+), 244 deletions(-)

diff --git a/src/policy_config_files.md b/src/policy_config_files.md
index b6ae69c..e7fab1e 100644
--- a/src/policy_config_files.md
+++ b/src/policy_config_files.md
@@ -1,5 +1,37 @@
 # Policy Configuration Files
 
+-   [setrans.conf](#setrans.conf)
+-   [*secolor.conf*](#secolor.conf)
+-   [*policy/policy.\<ver\>*](#policypolicy.ver)
+-   [*contexts/customizable_types*](#contextscustomizable_types)
+-   [*contexts/default_contexts*](#contextsdefault_contexts)
+-   [*contexts/dbus_contexts*](#contextsdbus_contexts)
+-   [*contexts/default_type*](#contextsdefault_type)
+-   [*contexts/failsafe_context*](#contextsfailsafe_context)
+-   [*contexts/initrc_context*](#contextsinitrc_context)
+-   [*contexts/lxc_contexts*](#contextslxc_contexts)
+-   [*contexts/netfilter_contexts* - Obsolete](#contextsnetfilter_contexts---obsolete)
+-   [*contexts/openrc_contexts*](#contextsopenrc_contexts)
+-   [*contexts/openssh_contexts*](#contextsopenssh_contexts)
+-   [*contexts/removable_context*](#contextsremovable_context)
+-   [*contexts/sepgsql_contexts*](#contextssepgsql_contexts)
+-   [*contexts/snapperd_contexts*](#contextssnapperd_contexts)
+-   [*contexts/securetty_types*](#contextssecuretty_types)
+-   [*contexts/systemd_contexts*](#contextssystemd_contexts)
+-   [*contexts/userhelper_context*](#contextsuserhelper_context)
+-   [*contexts/virtual_domain_context*](#contextsvirtual_domain_context)
+-   [*contexts/virtual_image_context*](#contextsvirtual_image_context)
+-   [*contexts/x_contexts*](#contextsx_contexts)
+-   [*contexts/files/file_contexts*](#contextsfilesfile_contexts)
+-   [*contexts/files/file_contexts.local*](#contextsfilesfile_contexts.local)
+-   [*contexts/files/file_contexts.homedirs*](#contextsfilesfile_contexts.homedirs)
+-   [*contexts/files/file_contexts.subs*](#contextsfilesfile_contexts.subs)
+-   [*contexts/files/file_contexts.subs_dist*](#contextsfilesfile_contexts.subs_dist)
+-   [*contexts/files/media*](#contextsfilesmedia)
+-   [*contexts/users/[seuser_id]*](#contextsusersseuser_id)
+-   [*logins/\<linuxuser_id\>*](#loginslinuxuser_id)
+-   [*users/local.users*](#userslocal.users)
+
 Each file discussed in this section is relative to the policy name as
 follows:
 
@@ -20,16 +52,16 @@ For example the simple
 described in the Notebook examples could run at init 3 (i.e. no X-Windows)
 and only require the following configuration files:
 
--   *./seusers* - For login programs.
--   *./policy/policy.&lt;ver&gt;* - The binary policy loaded into the kernel.
--   *./context/files/file_contexts* - To allow the filesystem to be relabeled.
+-   *seusers* - For login programs.
+-   *policy/policy.\<ver\>* - The binary policy loaded into the kernel.
+-   *context/files/file_contexts* - To allow the filesystem to be relabeled.
 
 If the simple policy is to run at init 5, (i.e. with X-Windows) then an
 additional two files are required:
 
--   *./context/dbus_contexts* - To allow the dbus messaging service to run under
+-   *context/dbus_contexts* - To allow the dbus messaging service to run under
     SELinux.
--   *./context/x_contexts* - To allow the X-Windows service to run under SELinux.
+-   *context/x_contexts* - To allow the X-Windows service to run under SELinux.
 
 ## *seusers*
 
@@ -43,13 +75,13 @@ typical login sequence would be:
     entry.
 -   To determine the remaining context to be used as the security
     context, read the
-    [*./contexts/users/[seuser_id]*](#contextsusersseuser_id)
+    [*contexts/users/[seuser_id]*](#contextsusersseuser_id)
     file. If this file is not present, then:
 -   Check for a default context in the
-    [*./contexts/default_contexts*](#contextsdefault_contexts)
+    [*contexts/default_contexts*](#contextsdefault_contexts)
     file. If no default context is found, then:
 -   Read the
-    [*./contexts/failsafe_context*](#contextsfailsafe_context) file
+    [*contexts/failsafe_context*](#contextsfailsafe_context) file
     to allow a fail safe context to be set.
 
 Note: The *system_u* user is defined in this file, however there must be
@@ -89,9 +121,9 @@ file section.
 For systems that do use these files:
 
 -   ***security_set_boolean_list**(3)* - Writes a *boolean.local* file if
-flag *permanent* = '*1*'.
+    flag *permanent* = '*1*'.
 -   ***security_load_booleans**(3)* - Will look for a *booleans* or
-*booleans.local* file here unless a specific path is specified.
+    *booleans.local* file here unless a specific path is specified.
 
 Both files have the same format and contain one or more boolean names.
 
@@ -103,19 +135,14 @@ boolean_name value
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>boolean_name</td>
-<td>The name of the boolean.</td>
-</tr>
-<tr>
-<td>value</td>
-<td><p>The default setting for the boolean that can be one of the following:</p>
-<p>true | false | 1 | 0</p></td>
-</tr>
-</tbody>
-</table>
+*boolean_name*
+
+-   The name of the boolean.
+
+*value*
+
+-   The default setting for the boolean that can be one of the following:
+    -  *true* | *false* | *1* | *0*
 
 Note that if *SETLOCALDEFS* is set in the SELinux
 [*/etc/selinux/config*](global_config_files.md#etcselinuxconfig) file, then
@@ -127,7 +154,7 @@ in the ***selinux_users_path**(3)*.
 
 The *booleans.subs_dist* file (if present) will allow new boolean names
 to be allocated to those in the active policy. This file was added
-because many older booleans began with 'allow' that made it difficult to
+because many older booleans began with '*allow*' that made it difficult to
 determine what they did. For example the boolean *allow_console_login*
 becomes more descriptive as *login_console_enabled*. If the
 *booleans.subs_dist* file is present, then either name may be used.
@@ -143,13 +170,18 @@ policy_bool_name new_name
 
 **Where:**
 
--   *policy_bool_name* - The policy boolean name.
--   *new_name* - The new boolean name.
+*policy_bool_name*
+
+-   The policy boolean name.
+
+*new_name*
+
+-   The new boolean name.
 
 **Example:**
 
 ```
-# ./booleans.subs_dist
+# booleans.subs_dist
 allow_auditadm_exec_content auditadm_exec_content
 allow_console_login         login_console_enabled
 allow_cvs_read_shadow       cvs_read_shadow
@@ -168,7 +200,7 @@ Supporting libselinux API functions are:
 -   ***security_get_boolean_names**(3)*
 -   ***security_set_boolean**(3)*
 
-## setrans.conf
+## *setrans.conf*
 
 The ***setrans.conf**(8)* file is used by the ***mcstransd**(8)* daemon
 (available in the mcstrans rpm). The daemon enables SELinux-aware
@@ -244,42 +276,41 @@ context_component string fg_color_name bg_color_name
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>color</td>
-<td>The color keyword.</td>
-</tr>
-<tr>
-<td>color_name</td>
-<td>A descriptive name for the colour (e.g. <em>red</em>).</td>
-</tr>
-<tr>
-<td>color_mask</td>
-<td>A colour mask starting with a hash (<em>#</em>) that describes the RGB colours with black being <em>#000000</em> and white being <em>#ffffff</em>.</td>
-</tr>
-<tr>
-<td>context_component</td>
-<td>The colour translation supports different colours on the context string components (<em>user</em>, <em>role</em>, <em>type</em> and <em>range</em>). Each component is on a separate line.</td>
-</tr>
-<tr>
-<td>string</td>
-<td><p>This is the context_component string that will be matched with the <em>raw</em> context component passed by <em><strong>selinux_raw_context_to_color</strong>(3)</em></p>
-<p>A wildcard '<em><strong>*</strong></em>' may be used to match any undefined <em>string</em> for the <em>user</em>, <em>role</em> and <em>type context_component</em> entries only</p>
-<p>A wildcard '<em><strong>*</strong></em>' may be used to match any undefined <em>string</em> for the <em>user</em>, <em>role</em> and <em>type context_component</em> entries only.</p></td>
-</tr>
-<tr>
-<td>fg_color_name</td>
-<td><p>The <em>color_name</em> string that will be used as the foreground colour.</p>
-<p>A <em>color_mask</em> may also be used.</p></td>
-</tr>
-<tr>
-<td>bg_color_name</td>
-<td><p>The <em>color_name</em> string that will be used as the background colour.</p>
-<p>A <em>color_mask</em> may also be used.</p></td>
-</tr>
-</tbody>
-</table>
+*color*
+
+-   The color keyword.
+
+*color_name*
+
+-   A descriptive name for the colour (e.g. *red*).
+
+*color_mask*
+
+-   A colour mask starting with a hash '*#*' that describes the RGB colours
+    with black being *#000000* and white being *#ffffff*.
+
+*context_component*
+
+-   The colour translation supports different colours on the context string
+    components (*user*, *role*, *type* and *range*). Each component is on a
+    separate line.
+
+*string*
+
+-   This is the *context_component* string that will be matched with the
+    *raw* context component passed by ***selinux_raw_context_to_color**(3)*.
+    A wildcard '*\**' may be used to match any undefined *string* for the
+    *user*, *role* and *type* *context_component* entries only.
+
+*fg_color_name*
+
+-   The *color_name* string that will be used as the foreground colour.
+    A *color_mask* may also be used.
+
+*bg_color_name*
+
+-   The *color_name* string that will be used as the background colour.
+    A *color_mask* may also be used.</p></td>
 
 **Example file contents:**
 
@@ -317,7 +348,7 @@ user : role : type : range
 black white white black tan orange black green
 ```
 
-## *policy/policy.&lt;ver&gt;*
+## *policy/policy.\<ver\>*
 
 This is the binary policy file that is loaded into the kernel to enforce
 policy and is built by either ***checkpolicy**(8)* or ***semodule**(8)*. Life
@@ -337,7 +368,7 @@ section.
 The ***customizable_types**(5)* file contains a list of types that will
 not be relabeled by the ***setfiles**(8)* or **restorecon**(8) commands.
 The commands check this file before relabeling and excludes those in the
-list unless the -F flag is used (see the man pages).
+list unless the *-F* flag is used (see the man pages).
 
 **The file format is as follows:**
 
@@ -347,14 +378,11 @@ type
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>type</td>
-<td>The type defined in the policy that needs to excluded from relabeling. An example is when a file has been purposely relabeled with a different type to allow an application to work.</td>
-</tr>
-</tbody>
-</table>
+*type*
+
+-   The type defined in the policy that needs to excluded from relabeling.
+    An example is when a file has been purposely relabeled with a different
+    type to allow an application to work.
 
 **Example file contents:**
 
@@ -384,8 +412,8 @@ login applications) where:
     been determined as described in the [*seusers*](#seusers) file
     section.
 3.  The login applications will check the
-    [*./contexts/users/[seuser_id]*](#contextsusersseuser_id) file
-    first and if no valid entry, will then look in the [seuser_id]
+    [*contexts/users/[seuser_id]*](#contextsusersseuser_id) file
+    first and if no valid entry, will then look in the *[seuser_id]*
     file for a default context to use.
 
 **The file format is as follows:**
@@ -396,16 +424,14 @@ role:type[:range] role:type[:range] ...
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>role:type[:range]</td>
-<td><p>The file contains one or more lines that consist of role:type[:range] pairs (including the MLS / MCS level or range if applicable).</p>
-<p>The entry at the start of a new line corresponds to the partial role:type[:range] context of (generally) the login application.</p>
-<p>The other role:type[:range] entries on that line represent an ordered list of valid contexts that may be used to set the users context. </p></td>
-</tr>
-</tbody>
-</table>
+*role:type[:range]*
+
+-   The file contains one or more lines that consist of *role:type[:range]*
+    pairs (including the MLS / MCS *level* or *range* if applicable).
+    -  The entry at the start of a new line corresponds to the partial
+       *role:type[:range]* context of (generally) the login application.
+    -  The other *role:type[:range]* entries on that line represent an ordered
+       list of valid contexts that may be used to set the users context.
 
 **Example file contents:**
 
@@ -420,7 +446,7 @@ system_r:xdm_t:s0 user_r:user_t:s0
 
 **Supporting libselinux API functions are:**
 
-Note that the *./contexts/users/[seuser_id]* file is also read by some of
+Note that the *contexts/users/[seuser_id]* file is also read by some of
 these functions.
 
 -   ***selinux_contexts_path**(3)*
@@ -500,14 +526,10 @@ role:type
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>role:type</td>
-<td>The file contains one or more lines that consist of role:type entries. There should be one line for each role defined within the policy.</td>
-</tr>
-</tbody>
-</table>
+*role:type*
+
+-   The file contains one or more lines that consist of *role:type* entries.
+    There should be one line for each role defined within the policy.
 
 **Example file contents:**
 
@@ -539,14 +561,10 @@ role:type[:range]
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>role:type[:range]</td>
-<td>A single line that has a valid context to allow an administrator access to the system, including the MLS / MCS level or range if applicable.</td>
-</tr>
-</tbody>
-</table>
+*role:type[:range]*
+
+-   A single line that has a valid context to allow an administrator access
+    to the system, including the MLS / MCS *level* or *range* if applicable.
 
 **Example file contents:**
 
@@ -581,14 +599,10 @@ user:role:type[:range]
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>user:role:type[:range]</td>
-<td>The file contains one line that consists of a security context, including the MLS / MCS level or range if applicable.</td>
-</tr>
-</tbody>
-</table>
+*user:role:type[:range]*
+
+-   The file contains one line that consists of a security context,
+    including the MLS / MCS *level* or *range* if applicable.
 
 **Example file contents:**
 
@@ -618,27 +632,26 @@ content = "security_context"
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>process</td>
-<td>A single <em>process</em> entry that contains the lxc domain security context, including the MLS / MCS level or range if applicable.</td>
-</tr>
-<tr>
-<td>file</td>
-<td>A single <em>file</em> entry that contains the lxc file security context, including the MLS / MCS level or range if applicable.</td>
-</tr>
-<tr>
-<td>content</td>
-<td>A single <em>content</em> entry that contains the lxc content security context, including the MLS / MCS level or range if applicable.</td>
-</tr>
-<tr>
-<td><p>sandbox_kvm_process</p>
-<p>sandbox_lxc_process</p></td>
-<td>These entries may be present and contain the security context.</td>
-</tr>
-</tbody>
-</table>
+*process*
+
+-   A single *process* entry that contains the lxc domain security context,
+    including the MLS / MCS *level* or *range* if applicable.
+
+*file*
+
+-   A single *file* entry that contains the lxc file security context,
+    including the MLS / MCS *level* or *range* if applicable.</td>
+
+*content*
+
+-   A single *content* entry that contains the lxc content security context,
+    including the MLS / MCS *level* or *range* if applicable.</td>
+
+*sandbox_kvm_process*
+
+*sandbox_lxc_process*
+
+-   These entries may be present and contain the security context.
 
 **Example file contents:**
 
@@ -711,14 +724,10 @@ user:role:type[:range]
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>user:role:type[:range]</td>
-<td>The file contains one line that consists of a security context, including the MLS / MCS level or range if applicable.</td>
-</tr>
-</tbody>
-</table>
+*user:role:type[:range]*
+
+-   The file contains one line that consists of a security context,
+    including the MLS / MCS *level* or *range* if applicable.
 
 **Example file contents:**
 
@@ -743,23 +752,22 @@ object_type object_name context
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><em><em>object_type</em></em></td>
-<td><em><em>This is the string representation of the object type.</em></em></td>
-</tr>
-<tr>
-<td><em><em>object_name</em></em></td>
-<td><p><em><em>These are the object names of the specific database objects. </em></em></p>
-<p><em><em>The entry can contain '</em><em>*</em><em>' for wildcard matching or '</em><em>?</em><em>' for substitution. Note that if the '</em><em>*</em><em>' is used, then be aware that the order of entries in the file is important. The '</em><em>*</em><em>' on its own is used to ensure a default fallback context is assigned and should be the last entry in the </em><em>object_type</em><em> block.</em></em></p></td>
-</tr>
-<tr>
-<td><em><em>context</em></em></td>
-<td><em><em>The security </em><em>context</em><em> that will be applied to the object. </em></em></td>
-</tr>
-</tbody>
-</table>
+*object_type*
+
+-   This is the string representation of the object type.
+
+*object_name*
+
+-   These are the object names of the specific database objects.
+    The entry can contain '*\**' for wildcard matching or '*?*' for
+    substitution. Note that if the '*\**' is used, then be aware that the order
+    of entries in the file is important. The '*\**' on its own is used to ensure
+    a default fallback context is assigned and should be the last entry in the
+    *object_type* block.
+
+*context*
+
+-   The security *context* that will be applied to the object.
 
 **Example file contents:**
 
@@ -800,14 +808,9 @@ type
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>type</td>
-<td>Zero or more type entries that are defined in the policy for tty devices.</td>
-</tr>
-</tbody>
-</table>
+*type*
+
+-   Zero or more type entries that are defined in the policy for tty devices.
 
 **Example file contents:**
 
@@ -833,18 +836,15 @@ service_class = security_context
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>service_class</td>
-<td>One or more entries that relate to the <em>systemd</em> service (e.g. runtime, transient).</td>
-</tr>
-<tr>
-<td>security_context</td>
-<td>The security context, including the MLS / MCS level or range if applicable of the service to be run.</td>
-</tr>
-</tbody>
-</table>
+*service_class*
+
+-   One or more entries that relate to the ***systemd**(1)* service (e.g.
+    runtime, transient).
+
+*security_context*
+
+-   The security context, including the MLS / MCS *level* or *range* if
+    applicable of the service to be run.
 
 **Example file contents:**
 
@@ -860,7 +860,7 @@ runtime=system_u:object_r:systemd_runtime_unit_file_t:s0
 ## *contexts/userhelper_context*
 
 This file contains the default security context used by the
-system-config-* applications when running from root.
+system-config-\* applications when running from root.
 
 **The file format is as follows:**
 
@@ -870,14 +870,10 @@ security_context
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>security_context</td>
-<td>The file contains one line that consists of a full security context, including the MLS / MCS level or range if applicable.</td>
-</tr>
-</tbody>
-</table>
+*security_context*
+
+-   The file contains one line that consists of a full security context,
+    including the MLS / MCS *level* or *range* if applicable.
 
 **Example file contents:**
 
@@ -931,7 +927,7 @@ system_u:object_r:virt_content_t:s0
 
 The ***x_contexts**(5)* file provides the default security contexts for
 the X-Windows SELinux security extension. The usage is discussed in the
-[SELinux X-Windows Support](x_windows.md#x-windows-selinux-support)section.
+[SELinux X-Windows Support](x_windows.md#x-windows-selinux-support) section.
 The MCS / MLS version of the file has the appropriate level or
 range information added.
 
@@ -944,23 +940,27 @@ selection      PRIMARY	   system_u:object_r:clipboard_xselection_t:s0
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><em><em>object_type</em></em></td>
-<td><em><em>These are types of object supported and valid entries</em><em> are: </em><em>client</em><em>, </em><em>property</em><em>, </em><em>poly_property</em><em>, </em><em>extension</em><em>, </em><em>selection</em><em>, </em><em>poly_selection</em><em> and </em><em>events</em><em>.</em></em></td>
-</tr>
-<tr>
-<td><em><em>object_name</em></em></td>
-<td><p><em><em>These are the object names of the specific X-server resource such as </em><em>PRIMARY</em><em>, </em><em>CUT_BUFFER0</em><em> etc. They are generally defined in the X-server source code (</em><em>protocol.txt</em><em> and </em><em>BuiltInAtoms </em><em>in the </em><em>dix</em><em> directory of the </em><em>xorg-server</em><em> source package). </em></em></p>
-<p><em><em>This can contain '</em><em>*</em><em>' for 'any' or '</em><em>?</em><em>' for 'substitute' (see the </em><em>CUT_BUFFER?</em><em> entry where the '</em><em>?</em><em>' would be substituted for a number between 0 and 7 that represents the number of these buffers).</em></em></p></td>
-</tr>
-<tr>
-<td><em><em>context</em></em></td>
-<td><em><em>This is the security context that will be applied to the object. For MLS/MCS systems there would be the additional MLS label.</em></em></td>
-</tr>
-</tbody>
-</table>
+
+*object_type*
+
+-   These are types of object supported and valid entries are: *client*,
+    *property*, *poly_property*, *extension*, *selection*, *poly_selection*
+    and *events*.
+
+*object_name*
+
+-   These are the object names of the specific X-server resource such as
+    *PRIMARY*, *CUT_BUFFER0* etc. They are generally defined in the X-server
+    source code (*protocol.txt* and *BuiltInAtoms* in the *dix* directory of
+    the *xorg-server* source package). This can contain '*\**' for 'any'
+    or '*?*' for 'substitute' (see the *CUT_BUFFER?* entry where the '*?*'
+    would be substituted for a number between 0 and 7 that represents the
+    number of these buffers).
+
+*context*
+
+-   This is the security context that will be applied to the object.
+    For MLS/MCS systems there would be the additional MLS label.
 
 **Supporting libselinux API functions are:**
 
@@ -973,12 +973,12 @@ selection      PRIMARY	   system_u:object_r:clipboard_xselection_t:s0
 ## *contexts/files/file_contexts*
 
 The ***file_contexts**(5)* file is managed by the ***semodule**(8)* and
-***semanage**(8)* commands<a href="#fnp1" class="footnote-ref" id="fnpcf1"><strong><sup>1</sup></strong></a>
+***semanage**(8)* commands[^fn_pcf_1]
 as the policy is updated (adding or removing modules or updating the base),
 and therefore should not be edited.
 
 The file is used by a number of SELinux-aware commands (***setfiles**(8)*,
-***fixfiles**(8)*, ***restorecon**(8)*) to relabel either part or all of the
+***fixfiles**(8)*, ***restorecon**(8)* to relabel either part or all of the
 file system.
 
 Note that users home directory file contexts are not present in this
@@ -1037,8 +1037,8 @@ Perl compatible regular expression (PCRE) internal format.
 -   ***selinux_file_context_homedir_path**(3)*
 -   ***selinux_homedir_context_path**(3)*
 
-## contexts/files/file_contexts.subs
-## contexts/files/file_contexts.subs_dist
+## *contexts/files/file_contexts.subs*
+## *contexts/files/file_contexts.subs_dist*
 
 These files allow substitution of file names (*.subs* for local use and
 *.subs_dist* for GNU / Linux distributions use) for the *libselinux*
@@ -1083,18 +1083,14 @@ media_id file_context
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>media_id</td>
-<td>The media identifier (those known are: cdrom, floppy, disk and usb).</td>
-</tr>
-<tr>
-<td>file_context</td>
-<td>The context to be used for the device. Note that it does not have the MLS / MCS level).</td>
-</tr>
-</tbody>
-</table>
+*media_id*
+
+-   The media identifier (those known are: cdrom, floppy, disk and usb).
+
+*file_context*
+
+-   The context to be used for the device. Note that it does not have the
+    MLS / MCS level).
 
 **Example file contents:**
 
@@ -1145,7 +1141,7 @@ system_r:init_t:s0		unconfined_r:unconfined_t:s0
 -   ***get_ordered_context_list**(3)*
 -   ***get_ordered_context_list_with_level**(3)*
 
-## *logins/&lt;linuxuser_id&gt;*
+## *logins/\<linuxuser_id\>*
 
 These optional files are used by SELinux-aware login applications such
 as PAM (using the *pam_selinux* module) to obtain an SELinux user name
@@ -1170,27 +1166,22 @@ service_name:seuser_id:level
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>service_name</td>
-<td>The name of the service.</td>
-</tr>
-<tr>
-<td>seuser_id</td>
-<td>The SELinux user name.</td>
-</tr>
-<tr>
-<td>level</td>
-<td>The run level</td>
-</tr>
-</tbody>
-</table>
+*service_name*
+
+-   The name of the service.
+
+*seuser_id*
+
+-   The SELinux user name.
+
+*level*
+
+-  The run level
 
 **Example file contents:**
 
 ```
-# ./logins/ipa example entries
+# logins/ipa example entries
 ipa_service:user_u:s0
 another_service:unconfined_u:s0
 ```
@@ -1199,7 +1190,7 @@ another_service:unconfined_u:s0
 
 -   ***getseuser**(3)*
 
-## users/local.users
+## *users/local.users*
 
 **NOTE: These were removed in libselinux 3.0**
 
@@ -1218,11 +1209,9 @@ Note that if *SETLOCALDEFS* is set in the SELinux
 in the ***selinux_booleans_path**(3)*, and also a *local.users* file
 in the ***selinux_users_path**(3)*.
 
-<section class="footnotes">
-<ol>
-<li id="fnp1"><p>As each module would have its own file_contexts component that is either added or removed from the policies overall /etc/selinux/&lt;SELINUXTYPE&gt;/contexts/ files/file_contexts file.<a href="#fnpcf1" class="footnote-back">↩</a></p></li>
-</ol>
-</section>
+[^fn_pcf_1]: As each module would have its own *file_contexts* component that
+is either added or removed from the policies overall
+*/etc/selinux/\<SELINUXTYPE\>/contexts/files/file_contexts* file.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

