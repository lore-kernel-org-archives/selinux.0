Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B932C433DF
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413D42311A
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="WVjq7YZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgHFQsA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:48:00 -0400
Received: from mailomta21-sa.btinternet.com ([213.120.69.27]:59943 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729446AbgHFQro (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 12:47:44 -0400
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20200806095102.GJOQ4112.sa-prd-fep-045.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 6 Aug 2020 10:51:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1596707462; 
        bh=rA5U/K2TtOIx4lQUW1mP3hPYsGciPLOWurvcG+rYswo=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=WVjq7YZUeC682yqD5fBEJDX/9VeF7a3NF7Gy5nPCUeIszWhq8bG0JwwyrTJv2nInqOrqu4kidEjLBRAliXpfW3hxz7JwhmQd91yH4CYK8TOSQ8Xqs2unHpqjq6b0ttQ8ePEJVPQ5xagxVwH2MotuR/Efn+dj9ds9IQLBaz3b9cIJ5INpBfQd5u4fYDpZGfdfOFx24m3tppbJJQqmrpnxO/IclSWFk7rh3NqV/69rMIjDpxMr91BOVy98IQ9Lwq69/gRq3he0SXwyP9yY4pZpR0aJfm8q+TTftPuG8Dru/YNiIqKzfS5W72UtEoSz2qbtekmylRJxPMpzGwhHuAc26A==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.147.13.204]
X-OWM-Source-IP: 86.147.13.204 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofggtgfgsehtkeertdertdernecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeetueetfeelfeehieettdekveffgeefheduheekffevhfdtveetvdeftefhledvhfenucffohhmrghinheprghnughrohhiugdrtghomhenucfkphepkeeirddugeejrddufedrvddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddufedrvddtgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghr
        nhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.147.13.204) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED99EC90A715C1B; Thu, 6 Aug 2020 10:51:02 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH] selinux_notebook: seandroid.md convert to markdown
Date:   Thu,  6 Aug 2020 10:50:55 +0100
Message-Id: <20200806095055.7055-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This update adds a TOC to aid navigation, also converts all HTML tables
to markdown unordered lists.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/seandroid.md | 1137 +++++++++++++++++++++++-----------------------
 1 file changed, 577 insertions(+), 560 deletions(-)

diff --git a/src/seandroid.md b/src/seandroid.md
index b1833eb..409afe0 100644
--- a/src/seandroid.md
+++ b/src/seandroid.md
@@ -1,6 +1,44 @@
 # Security Enhancements for Android
 
-## Introduction
+- [SE for Android Project Updates](#se-for-android-project-updates)
+  - [*external/selinux/libselinux*](#externalselinuxlibselinux)
+  - [*external/selinux/libsepol*](#externalselinuxlibsepol)
+  - [*external/selinux/checkpolicy*](#externalselinuxcheckpolicy)
+  - [*bootable/recovery*](#bootablerecovery)
+  - [*build*](#build)
+  - [*frameworks/base*](#frameworksbase)
+  - [*system/core*](#systemcore)
+  - [*system/sepolicy*](#systemsepolicy)
+  - [*kernel*](#kernel)
+  - [*device*](#device)
+- [Kernel LSM / SELinux Support](#kernel-lsm-selinux-support)
+- [Android Classes & Permissions](#android-classes-permissions)
+  - [*binder*](#binder)
+  - [*property_service*](#property_service)
+  - [*service_manager*](#service_manager)
+  - [*hwservice_manager*](#hwservice_manager)
+  - [*keystore_key*](#keystore_key)
+  - [*drmservice*](#drmservice)
+- [SELinux Enabled Commands](#selinux-enabled-commands)
+- [SELinux Public Methods](#selinux-public-methods)
+- [Android Init Language SELinux Extensions](#android-init-language-selinux-extensions)
+- [The SELinux Policy](#the-selinux-policy)
+  - [SELinux Policy Files](#selinux-policy-files)
+  - [Android Policy Files](#android-policy-files)
+  - [Device Specific Policy](#device-specific-policy)
+    - [Managing Device Policy Files](#managing-device-policy-files)
+- [Policy Build Tools](#policy-build-tools)
+- [Policy File Formats](#policy-file-formats)
+  - [*file_contexts*](#file_contexts)
+  - [*seapp_contexts*](#seapp_contexts)
+    - [Default Entries](#default-entries)
+    - [Entry Definitions](#entry-definitions)
+    - [Computing Process Context Examples](#computing-process-context-examples)
+  - [*property_contexts*](#property_contexts)
+  - [*service_contexts*](#service_contexts)
+  - [*mac_permissions.xml*](#mac_permissions.xml)
+    - [Policy Rules](#policy-rules)
+  - [*keys.conf*](#keys.conf)
 
 This section gives an overview of the enhancements made to Android to
 add SELinux services to Security Enhancements for Android™ (SE for
@@ -14,8 +52,6 @@ AOSP master as of May '20). The AOSP git repository can be found at
 **Note:** Check the AOSP tree for any changes as there has been many updates
 to how SELinux is configured/built over the years.
 
-### Useful Links
-
 The following link describes how to validate SELinux in Android:
 <https://source.android.com/security/selinux/>
 and "**Security Enhanced (SE) Android: Bringing Flexible MAC to Android**"
@@ -29,19 +65,6 @@ also gives an overview of how SELinux / Android are being integrated with
 other security services (such as secure boot and integrity measurement)
 to help provide a more secure mobile platform.
 
-### Document Sections
-
-The sections that follow cover:
-
-1.  Overview of Android package additions and updates to support MAC
-2.  Android *libselinux* additional functions
-3.  Additional kernel LSM / SELinux support
-4.  Android Classes & Permissions
-5.  SELinux commands and methods
-7.  Policy construction and build
-8.  Logging and auditing
-9.  Configuration file formats
-
 ## SE for Android Project Updates
 
 This gives a high level view of the new and updated projects to support
@@ -58,32 +81,38 @@ device. It has additional functions to support Android as summarised in
 such as:
 
 ***selinux_android_setcontext()***
--   Sets the correct domain context when launching applications using
-    ***setcon**(3)*. Information contained in the *seapp_contexts* file
-    is used to compute the correct context.
--   It is called by *frameworks/base/core/jni/com_android_internal_os_Zygote.cpp*
-    when forking a new process and the *system/core/run-as/run-as.cpp* utility
-    for app debugging.
+
+- Sets the correct domain context when launching applications using
+  ***setcon**(3)*. Information contained in the *seapp_contexts* file
+  is used to compute the correct context.
+- It is called by *frameworks/base/core/jni/com_android_internal_os_Zygote.cpp*
+  when forking a new process and the *system/core/run-as/run-as.cpp* utility
+  for app debugging.
 
 ***selinux_android_restorecon()***
--   Sets the correct context on application directory / files using
-    ***setfilecon**(3)*. Information contained in the *seapp_contexts*
-    file is used to compute the correct context.
--   The function is used in many places, such as *system/core/init/selinux.cpp*
-    and *system/core/init/ueventd.cpp* to label devices.
--   *frameworks/native/cmds/installd/installdNativeService.cpp* when installing
-    a new app.
--   *frameworks/base/core/jni/android_os_SELinux.cpp* for the Java
-    *native_restorecon* method.
+
+- Sets the correct context on application directory / files using
+  ***setfilecon**(3)*. Information contained in the *seapp_contexts*
+  file is used to compute the correct context.
+- The function is used in many places, such as *system/core/init/selinux.cpp*
+  and *system/core/init/ueventd.cpp* to label devices.
+- *frameworks/native/cmds/installd/installdNativeService.cpp* when installing
+  a new app.
+- *frameworks/base/core/jni/android_os_SELinux.cpp* for the Java
+  *native_restorecon* method.
 
 ***selinux_android_restorecon_pkgdir()***
--   Used by *frameworks/native/cmds/installd/InstalldNativeService.cpp* for the
-    package installer.
+
+- Used by *frameworks/native/cmds/installd/InstalldNativeService.cpp* for the
+  package installer.
 
 ***selinux_android_load_policy()***
+
 ***selinux_android_load_policy_from_fd()***
--   Used by *system/core/init/selinux.cpp* to initialise SELinux policy, the
-    following note has been extracted:
+
+- Used by *system/core/init/selinux.cpp* to initialise SELinux policy, the
+  following note has been extracted:
+
 ```
 // IMPLEMENTATION NOTE: Split policy consists of three CIL files:
 // * platform -- policy needed due to logic contained in the system image,
@@ -100,20 +129,21 @@ There is a labeling service for ***selabel_lookup**(3)* to query the Android
 *frameworks/native/cmds/servicemanager/Access.cpp* for an example.
 
 Various Android services will also call (not a complete list):
--   ***selinux_status_updated**(3)*, ***is_selinux_enabled**(3)*, to
-    check whether anything changed within the SELinux environment (e.g.
-    updated configuration files).
--   ***selinux_check_access**(3)* to check if the source context has
-    access permission for the class on the target context.
--   ***selinux_label_open**(3)*, ***selabel_lookup**(3)*,
-    ***selinux_android_file_context_handle***, ***lgetfilecon**(3)*,
-    ***selinux_android_prop_context_handle***, ***setfilecon**(3)*,
-    ***setfscreatecon**(3)* to manage file labeling.
--   ***selabel_lookup_best_match*** called via *system/core/init/selabel.cpp*
-    by *system/core/init/devices.cpp* when *ueventd* creates a device node as
-    it may also create one or more symlinks (for block and PCI devices).
-    Therefore a "best match" look-up for a device node is based on its
-    real path, plus any links that may have been created.
+
+- ***selinux_status_updated**(3)*, ***is_selinux_enabled**(3)*, to
+  check whether anything changed within the SELinux environment (e.g.
+  updated configuration files).
+- ***selinux_check_access**(3)* to check if the source context has
+  access permission for the class on the target context.
+- ***selinux_label_open**(3)*, ***selabel_lookup**(3)*,
+  ***selinux_android_file_context_handle***, ***lgetfilecon**(3)*,
+  ***selinux_android_prop_context_handle***, ***setfilecon**(3)*,
+  ***setfscreatecon**(3)* to manage file labeling.
+- ***selabel_lookup_best_match*** called via *system/core/init/selabel.cpp*
+  by *system/core/init/devices.cpp* when *ueventd* creates a device node as
+  it may also create one or more symlinks (for block and PCI devices).
+  Therefore a "best match" look-up for a device node is based on its
+  real path, plus any links that may have been created.
 
 ### ***external/selinux/libsepol***
 
@@ -162,11 +192,12 @@ SELinux support for auditing avc's (*auditd*).
 
 This area contains information required to build the SELinux kernel policy
 and its supporting files. Android splits the policy into sections:
--   ***private*** - This is policy specifically for the core components of
-    Android that looks much like the reference policy, that has the policy
-    modules (*\*.te* files), class / permission files etc..
--   ***vendor*** - This is vendor specific policy.
--   ***public*** - This is public specific policy.
+
+- ***private*** - This is policy specifically for the core components of
+  Android that looks much like the reference policy, that has the policy
+  modules (*\*.te* files), class / permission files etc..
+- ***vendor*** - This is vendor specific policy.
+- ***public*** - This is public specific policy.
 
 The policy is built and installed on the target device along
 with its supporting configuration files.
@@ -219,8 +250,8 @@ is no longer required (use ***CONFIG_ANDROID_BINDERFS=y*** instead).
 
 ## Android Classes & Permissions
 
-Additional classes have been added to Android and are listed in the
-following tables with descriptions of their permissions. The policy
+Additional classes have been added to Android and are listed below with
+descriptions of their permissions. The policy
 files *system/sepolicy/private/security_classes* and
 *system/sepolicy/private/access_vectors* contain the complete list with
 descriptions available at:
@@ -228,241 +259,206 @@ descriptions available at:
 However, note that while the *security_classes* file contains many entries,
 not all are required for Android.
 
-<table>
-<tbody>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Class</strong></td>
-<td><em><strong>binder</strong></em> - Manage the Binder IPC service.</td>
-</tr>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Permission</strong></td>
-<td><strong>Description</strong> (4 unique permissions)</td>
-</tr>
-<tr>
-<td>call</td>
-<td>Perform a binder IPC to a given target process (can A call B?).</td>
-</tr>
-<tr>
-<td>impersonate</td>
-<td>Perform a binder IPC on behalf of another process (can A impersonate B on an IPC).</td>
-</tr>
-<tr>
-<td>set_context_mgr</td>
-<td>Register self as the Binder Context Manager aka <em>servicemanager</em> (global name service). Can A set the context manager to B, where normally A == B.</td>
-</tr>
-<tr>
-<td>transfer</td>
-<td>Transfer a binder reference to another process (can A transfer a binder reference to B?).</td>
-</tr>
-</tbody>
-</table>
-
-<table>
-<tbody>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Class</strong></td>
-<td><em><strong>property_service</strong></em> - This is a userspace object to manage the Android Property Service in <em>system/core/init/property_service.cpp</em></td>
-</tr>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Permission</strong></td>
-<td><strong>Description</strong> (1 unique permission)</td>
-</tr>
-<tr>
-<td><code>set</code></td>
-<td>Set a property.</td>
-</tr>
-</tbody>
-</table>
-
-<table>
-<tbody>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Class</strong></td>
-<td><em><strong>service_manager</strong></em> - This is a userspace object to manage the loading of Android services in <em>frameworks/native/cmds/servicemanager/service_manager/Access.cpp</em></td>
-</tr>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Permission</strong></td>
-<td><strong>Description</strong> (3 unique permissions)</td>
-</tr>
-<tr>
-<td>add</td>
-<td>Add a service.</td>
-</tr>
-<tr>
-<td>find</td>
-<td>Find a service.</td>
-</tr>
-<tr>
-<td>list</td>
-<td>List services.</td>
-</tr>
-</tbody>
-</table>
-
-<table>
-<tbody>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Class</strong></td>
-<td><em><strong>hwservice_manager</strong></em> - This is a userspace object to manage the loading of Android services in <em>system/hwservicemanager/AccessControl.cpp</em></td>
-</tr>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Permission</strong></td>
-<td><strong>Description</strong> (3 unique permissions)</td>
-</tr>
-<tr>
-<td>add</td>
-<td>Add a service.</td>
-</tr>
-<tr>
-<td>find</td>
-<td>Find a service.</td>
-</tr>
-<tr>
-<td>list</td>
-<td>List services.</td>
-</tr>
-</tbody>
-</table>
-
-<table>
-<tbody>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Class</strong></td>
-<td><em><strong>keystore_key</strong></em> - This is a userspace object to manage the Android keystores. See <em>system/security/keystore/key_store_service.cpp</em></td>
-</tr>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Permission</strong></td>
-<td><strong>Description</strong> (19 unique permissions)</td>
-</tr>
-<tr>
-<td>get_state</td>
-<td>check if keystore okay.</td>
-</tr>
-<tr>
-<td>get</td>
-<td>Get key.</td>
-</tr>
-<tr>
-<td>insert</td>
-<td>Insert / update key.</td>
-</tr>
-<tr>
-<td>delete</td>
-<td>Delete key.</td>
-</tr>
-<tr>
-<td>exist</td>
-<td>Check if key exists.</td>
-</tr>
-<tr>
-<td>list</td>
-<td>Search for matching string.</td>
-</tr>
-<tr>
-<td>reset</td>
-<td>Reset keystore for primary user.</td>
-</tr>
-<tr>
-<td>password</td>
-<td>Generate new keystore password for primary user.</td>
-</tr>
-<tr>
-<td>lock</td>
-<td>Lock keystore.</td>
-</tr>
-<tr>
-<td>unlock</td>
-<td>Unlock keystore.</td>
-</tr>
-<tr>
-<td>is_empty</td>
-<td>Check if keystore empty.</td>
-</tr>
-<tr>
-<td>sign</td>
-<td>Sign data.</td>
-</tr>
-<tr>
-<td>verify</td>
-<td>Verify data.</td>
-</tr>
-<tr>
-<td>grant</td>
-<td>Add or remove access.</td>
-</tr>
-<tr>
-<td>duplicate</td>
-<td>Duplicate the key.</td>
-</tr>
-<tr>
-<td>clear_uid</td>
-<td>Clear keys for this <em>uid</em>.</td>
-</tr>
-<tr>
-<td>add_auth</td>
-<td>Add hardware authentication token.</td>
-</tr>
-<tr>
-<td>user_changed</td>
-<td>Add/Remove <em>uid</em>.</td>
-</tr>
-<tr>
-<td>gen_unique_id</td>
-<td>Generate new keystore password for this <em>uid</em>.</td>
-</tr>
-</tbody>
-</table>
-
-<table>
-<tbody>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Class</strong></td>
-<td><em><strong>drmservice</strong></em> - This is a userspace object to allow finer access control of the Digital Rights Management services. See <em>frameworks/av/drm/drmserver/DrmManagerService.cpp</em></td>
-<td></td>
-</tr>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Permission</strong></td>
-<td><strong>Description</strong> (8 unique permissions)</td>
-</tr>
-<tr>
-<td>consumeRights</td>
-<td>Consume rights for content.</td>
-</tr>
-<tr>
-<td>setPlaybackStatus</td>
-<td>Set the playback state.</td>
-</tr>
-<tr>
-<td>openDecryptSession</td>
-<td>Open the DRM session for the requested DRM plugin.</td>
-</tr>
-<tr>
-<td>closeDecryptSession</td>
-<td>Close DRM session.</td>
-</tr>
-<tr>
-<td>initializeDecryptUnit</td>
-<td>Initialise the decrypt resources.</td>
-</tr>
-<tr>
-<td>decrypt</td>
-<td>Decrypt data stream.</td>
-</tr>
-<tr>
-<td>finalizeDecryptUnit</td>
-<td>Release DRM resources.</td>
-</tr>
-<tr>
-<td>pread</td>
-<td>Read the data stream.</td>
-</tr>
-</tbody>
-</table>
-
-## SELinux Commands
+### *binder*
+
+Manage the Binder IPC service (4 unique permissions).
+
+**Permissions:**
+
+*call*
+
+- Perform a binder IPC to a given target process (can A call B?).
+
+*impersonate*
+
+- Perform a binder IPC on behalf of another process (can A impersonate
+  B on an IPC).
+
+*set_context_mgr*
+
+- Register self as the Binder Context Manager aka *servicemanager* (global
+  name service). Can A set the context manager to B, where normally A == B.
+
+*transfer*
+
+- Transfer a binder reference to another process (can A transfer a binder
+  reference to B?).
+
+### *property_service*
+
+This is a userspace object to manage the Android Property Service in
+*system/core/init/property_service.cpp* (1 unique permission).
+
+**Permission:**
+
+*set*
+
+- Set a property.
+
+### *service_manager*
+
+This is a userspace object to manage the loading of Android services in
+*frameworks/native/cmds/servicemanager/service_manager/Access.cpp*
+(3 unique permissions).
+
+**Permissions:**
+
+*add*
+
+- Add a service.
+
+*find*
+
+- Find a service.
+
+*list*
+
+- List services.
+
+### *hwservice_manager*
+
+This is a userspace object to manage the loading of Android services in
+*system/hwservicemanager/AccessControl.cpp* (3 unique permissions).
+
+**Permissions:**
+
+*add*
+
+- Add a service.
+
+*find*
+
+- Find a service.
+
+*list*
+
+- List services.
+
+### *keystore_key*
+
+This is a userspace object to manage the Android keystores. See
+*system/security/keystore/key_store_service.cpp* (19 unique permissions).
+
+*get_state*
+
+- check if keystore okay.
+
+*get*
+
+- Get key.
+
+*insert*
+
+- Insert / update key.
+
+*delete*
+
+- Delete key.
+
+*exist*
+
+- Check if key exists.
+
+*list*
+
+- Search for matching string.
+
+*reset*
+
+- Reset keystore for primary user.
+
+*password*
+
+- Generate new keystore password for primary user.
+
+*lock*
+
+- Lock keystore.
+
+*unlock*
+
+- Unlock keystore.
+
+*is_empty*
+
+- Check if keystore empty.
+
+*sign*
+
+- Sign data.
+
+*verify*
+
+- Verify data.
+
+*grant*
+
+- Add or remove access.
+
+*duplicate*
+
+- Duplicate the key.
+
+*clear_uid*
+
+- Clear keys for this *uid*.
+
+*add_auth*
+
+- Add hardware authentication token.
+
+*user_changed*
+
+- Add/Remove *uid*.
+
+*gen_unique_id*
+
+- Generate new keystore password for this *uid*.
+
+### *drmservice*
+
+This is a userspace object to allow finer access control of the Digital
+Rights Management services. See
+*frameworks/av/drm/drmserver/DrmManagerService.cpp* (8 unique permissions).
+
+**Permissions:**
+
+*consumeRights*
+
+- Consume rights for content.
+
+*setPlaybackStatus*
+
+- Set the playback state.
+
+*openDecryptSession*
+
+- Open the DRM session for the requested DRM plugin.
+
+*closeDecryptSession*
+
+- Close DRM session.
+
+*initializeDecryptUnit*
+
+- Initialise the decrypt resources.
+
+*decrypt*
+
+- Decrypt data stream.
+
+*finalizeDecryptUnit*
+
+- Release DRM resources.
+
+*pread*
+
+- Read the data stream.
+
+## SELinux Enabled Commands
 
 A subset of the Linux SELinux commands have been implemented in Android
-and are listed in . Some are available as Toolbox or Toybox commands (see
+and are listed below. Some are available as Toolbox or Toybox commands (see
 *system/core/shell_and_utilities/README.md*) and can be run via *adb shell*,
 for example:
 
@@ -470,189 +466,188 @@ for example:
 adb shell pm list permissions -g
 ```
 
-### SELinux enabled commands
-
-<table>
-<tbody>
-<tr style="background-color:#F2F2F2;">
-<td>Command</td>
-<td>Comment</td>
-</tr>
-<tr>
-<td>getenforce</td>
-<td>Returns the current enforcing mode.</td>
-</tr>
-<tr>
-<td>setenforce</td>
-<td><p>Modify the SELinux enforcing mode:</p>
-<p>setenforce [enforcing|permissive|1|0]</p></td>
-</tr>
-<tr>
-<td>load_policy</td>
-<td><p>Load new policy into kernel:</p>
-<p>load_policy policy-file</p></td>
-</tr>
-<tr>
-<td>ls</td>
-<td>Supports <em>-Z</em> option to display security context.</td>
-</tr>
-<tr>
-<td>ps</td>
-<td>Supports <em>-Z</em> option to display security context.</td>
-</tr>
-<tr>
-<td>restorecon</td>
-<td><p>Restore file default security context as defined in the <em>file_contexts</em> or <em>seapp_contexts</em> files. The options are: <em>D</em> - data files, <em>F</em> - Force reset, <em>n</em> - do not change, <em>R</em>/<em>r</em> - Recursive change, v - Show changes.</p>
-<p>restorecon [-DFnrRv] pathname</p></td>
-</tr>
-<tr>
-<td>chcon</td>
-<td><p>Change security context of file. The options are: <em>h</em> - Change symlinks, <em>R</em> - Recurse into subdirectories, v - Verbose output.</p>
-<p>chcon [-hRv] context file...</p></td>
-</tr>
-<tr>
-<td>runcon</td>
-<td><p>Run command in specified security context:</p>
-<p>runcon context program args...</p></td>
-</tr>
-<tr>
-<td>id</td>
-<td>If SELinux is enabled then the security context is automatically displayed.</td>
-</tr>
-</tbody>
-</table>
+An example set of SELinux commands available are:
+
+*getenforce*
+
+- Returns the current enforcing mode.
+
+*setenforce*
+
+- Modify the SELinux enforcing mode: *setenforce [enforcing|permissive|1|0]*
+
+*load_policy*
+
+- Load new policy into kernel: *load_policy policy-file*
+
+*ls*
+
+- Supports *-Z* option to display security context.
+
+*ps*
+
+- Supports *-Z* option to display security context.
+
+*restorecon*
+
+- Restore file default security context as defined in the *file_contexts*
+  or *seapp_contexts* files. The options are: *-D* - data files,
+  *-F* - Force reset, *-n* - do not change, *-R*/*-r* - Recursive change,
+  *-v* - Show changes.
+  - *restorecon [-DFnrRv] pathname*
+
+*chcon*
+
+- Change security context of file. The options are: *-h*- Change symlinks,
+  *-R* - Recurse into subdirectories, *-v* - Verbose output.
+  - *chcon [-hRv] context file...*
+
+*runcon*
+
+- Run command in specified security context: *runcon context program args...*
+
+*id*
+
+- If SELinux is enabled then the security context is automatically displayed.
 
 ## SELinux Public Methods
 
 The public methods implemented are equivalent to *libselinux* functions
-and shown in the **SELinux class public methods** table below. They have
-been taken from *frameworks/base/core/java/android/os/SELinux.java*.
+and shown below. They have been taken from
+*frameworks/base/core/java/android/os/SELinux.java*.
 
 The SELinux class and its methods are not available in the Android SDK,
 however if developing SELinux enabled apps within AOSP then Reflection
 proguard flags would be used (for example in the
 TV package *AboutFragment.java* calls **SELinux.isSELinuxEnabled()**.
 
-<table>
-<tbody>
-<tr>
-<td><p><strong><em>String fileSelabelLookup(String path)</strong></em></p>
-<p>Get context associated with path by file_contexts. </p>
-<p>Return a string representing the security context or null on failure.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>boolean isSELinuxEnabled()</strong></em></p>
-<p>Determine whether SELinux is enabled or disabled. </p>
-<p>Return <em>true</em> if SELinux is enabled.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>boolean isSELinuxEnforced()</strong></em></p>
-<p>Determine whether SELinux is permissive or enforcing.</p>
-<p>Returns <em>true</em> if SELinux is enforcing.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>boolean setFSCreateContext(String context)</strong></em></p>
-<p>Sets the security context for newly created file objects.</p>
-<p><em>context</em> is the security context to set.</p>
-<p>Returns <em>true</em> if the operation succeeded.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>boolean setFileContext(String path, String context)</strong></em></p>
-<p>Change the security context of an existing file object.</p>
-<p><em>path</em> represents the path of file object to relabel.</p>
-<p><em>context</em> is the new security context to set .</p>
-<p>Returns <em>true</em> if the operation succeeded.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>String getFileContext(String path)</strong></em></p>
-<p>Get the security context of a file object.</p>
-<p><em>path</em> the pathname of the file object.</p>
-<p>Returns the requested security context or null.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>String getPeerContext(FileDescriptor fd)</strong></em></p>
-<p>Get the security context of a peer socket.</p>
-<p><em>FileDescriptor</em> is the file descriptor class of the peer socket.</p>
-<p>Returns the peer socket security context or null.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>String getContext()</strong></em></p>
-<p>Gets the security context of the current process.</p>
-<p> Returns the current process security context or null.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>String getPidContext(int pid)</strong></em></p>
-<p>Gets the security context of a given process id.</p>
-<p><em>pid</em> an <em>int</em> representing the process id to check.</p>
-<p>Returns the security context of the given pid or null.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>boolean checkSELinuxAccess(String scon, String tcon, String tclass, String perm)</strong></em></p>
-<p>Check permissions between two security contexts.</p>
-<p><em>scon</em> is the source or subject security context.</p>
-<p><em>tcon</em> is the target or object security context.</p>
-<p><em>tclass</em> is the object security class name.</p>
-<p><em>perm</em> is the permission name.</p>
-<p>Returns true if permission was granted.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>boolean restorecon(String pathname)</strong></em></p>
-<p>Restores a file to its default SELinux security context. If the system is not compiled with SELinux, then true is automatically returned. If SELinux is compiled in, but disabled, then true is returned.</p>
-<p><em>pathname</em> is the pathname of the file to be relabeled.</p>
-<p>Returns true if the relabeling succeeded.</p>
-<p><em>exception NullPointerException</em> if the pathname is a null object.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>boolean native_restorecon(String pathname, int flags)</strong></em></p>
-<p>Restores a file to its default SELinux security context.</p>
-<p>Returns <code>true</code> if the relabeling succeeded.</p>
-<p><em>exception NullPointerException</em> if the pathname is a null object.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>boolean restorecon(File file)</strong></em></p>
-<p>Restores a file to its default SELinux security context. If the system is not compiled with SELinux, then true is automatically returned. If SELinux is compiled in, but disabled, then true is returned.</p>
-<p><em>file</em> is the file object representing the path to be relabeled. </p>
-<p>Returns true if the relabeling succeeded.</p>
-<p><em>exception NullPointerException</em> if the file is a null object.</p></td>
-</tr>
-<tr>
-<td><p><strong><em>boolean restoreconRecursive(File file)</strong></em></p>
-<p>Recursively restores all files under the given path to their default SELinux security context. If the system is not compiled with SELinux, then true is automatically returned. If SELinux is compiled in, but disabled, then true is returned.</p>
-<p><em>pathname</em> is the pathname of the file to be relabeled.</p>
-<p>Returns a boolean indicating whether the relabeling succeeded.</p></td>
-</tr>
-</tbody>
-</table>
+*String fileSelabelLookup(String path)*
+
+- Get context associated with path by file_contexts.
+  - Return a string representing the security context or null on failure.
+
+*boolean isSELinuxEnabled()*
+
+- Determine whether SELinux is enabled or disabled.
+  - Return *true* if SELinux is enabled.
+
+*boolean isSELinuxEnforced()*
+
+- Determine whether SELinux is permissive or enforcing.
+  - Returns *true* if SELinux is enforcing.
+
+*boolean setFSCreateContext(String context)*
+
+- Sets the security context for newly created file objects.
+  *context* is the security context to set.
+  - Returns *true* if the operation succeeded.
+
+*boolean setFileContext(String path, String context)*
+
+- Change the security context of an existing file object.
+  *path* represents the path of file object to relabel.
+  *context* is the new security context to set.
+  - Returns *true* if the operation succeeded.
+
+*String getFileContext(String path)*
+
+- Get the security context of a file object.
+  *path* the pathname of the file object.
+  - Returns the requested security context or null.
+
+*String getPeerContext(FileDescriptor fd)*
+
+- Get the security context of a peer socket.
+  *FileDescriptor* is the file descriptor class of the peer socket.
+  - Returns the peer socket security context or null.
+
+*String getContext()*
+
+- Gets the security context of the current process.
+  - Returns the current process security context or null.
+
+*String getPidContext(int pid)*
+
+- Gets the security context of a given process id.
+  *pid* and *int* representing the process id to check.
+  - Returns the security context of the given pid or null.
+
+*boolean checkSELinuxAccess(String scon, String tcon, String tclass, String perm)*
+
+- Check permissions between two security contexts.
+  *scon* is the source or subject security context.
+  *tcon* is the target or object security context.
+  *tclass* is the object security class name.
+  *perm* is the permission name.
+  - Returns true if permission was granted.
+
+*boolean restorecon(String pathname)*
+
+- Restores a file to its default SELinux security context. If the system is
+  not compiled with SELinux, then true is automatically returned.
+  If SELinux is compiled in, but disabled, then true is returned.
+  *pathname* is the pathname of the file to be relabeled.
+  - Returns true if the relabeling succeeded.
+  - *exception NullPointerException* if the pathname is a null object.
+
+*boolean native_restorecon(String pathname, int flags)*
+
+- Restores a file to its default SELinux security context.
+  - Returns *true* if the relabeling succeeded.
+  - *exception NullPointerException* if the pathname is a null object.
+
+*boolean restorecon(File file)*
+
+- Restores a file to its default SELinux security context. If the system
+  is not compiled with SELinux, then true is automatically returned.
+  If SELinux is compiled in, but disabled, then true is returned.
+  *file* is the file object representing the path to be relabeled.
+  - Returns true if the relabeling succeeded.
+  - *exception NullPointerException* if the file is a null object.
+
+*boolean restoreconRecursive(File file)*
+
+- Recursively restores all files under the given path to their default SELinux
+  security context. If the system is not compiled with SELinux, then true is
+  automatically returned. If SELinux is compiled in, but disabled, then true
+  is returned. *pathname* is the pathname of the file to be relabeled.
+  - Returns a boolean indicating whether the relabeling succeeded.
 
 ## Android Init Language SELinux Extensions
 
 The Android init process language has been expanded to support SELinux
-as shown in the following table. The complete Android *init* language
+as shown below. The complete Android *init* language
 description is available in the *system/core/init/readme.txt* file.
 
-<table>
-<tbody>
-<tr>
-<td><p>seclabel &lt;securitycontext&gt;</p>
-<p><em>service option</em>: Change to security context before exec'ing this service. Primarily for use by services run from the rootfs, e.g. <em>ueventd</em>, <em>adbd</em>. Services on the system partition can instead use policy defined transitions based on their file security context. If not specified and no transition is defined in policy, defaults to the init context.</p></td>
-</tr>
-<tr>
-<td><p>restorecon &lt;path&gt;</p>
-<p><em>action command</em>: Restore the file named by <em>&lt;path&gt;</em> to the security context specified in the <em>file_contexts</em> configuration. Not required for directories created by the <em>init.rc</em> as these are automatically labeled correctly by <em>init</em>.</p></td>
-</tr>
-<tr>
-<td><p>restorecon_recursive &lt;path&gt; [ &lt;path&gt; ]</p>
-<p><em>action command</em>: Recursively restore the directory tree named by <em>&lt;path&gt;</em> to the security context specified in the <em>file_contexts</em> configuration. Do NOT use this with paths leading to shell-writable or app-writable directories, e.g. <em>/data/local/tmp</em>, <em>/data/data</em> or any prefix thereof.</p></td>
-</tr>
-<tr>
-<td><p>setcon &lt;securitycontext&gt;</p>
-<p><em>action command</em>: Set the current process security context to the specified string. This is typically only used from <em>early-init</em> to set the init context before any other process is started (see <em>init.rc</em> example above).</p></td>
-</tr>
-</tbody>
-</table>
-
-Examples of their usage are shown in the following *init.rc* file
-segments:
+*seclabel \<securitycontext\>*
+
+- service option: Change to security context before exec'ing this service.
+  Primarily for use by services run from the rootfs, e.g. *ueventd*, *adbd*.
+  Services on the system partition can instead use policy defined transitions
+  based on their file security context. If not specified and no transition
+  is defined in policy, defaults to the *init* context.
+
+*restorecon \<path\>*
+
+- action command: Restore the file named by *\<path\>* to the security context
+  specified in the *file_contexts* configuration. Not required for directories
+  created by the *init.rc* as these are automatically labeled correctly by *init*.
+
+*restorecon_recursive \<path\> \[ \<path\> \]*
+
+- action command: Recursively restore the directory tree named by
+  *\<path\>* to the security context specified in the *file_contexts*
+  configuration. Do NOT use this with paths leading to shell-writable
+  or app-writable directories, e.g. */data/local/tmp*,
+  */data/data* or any prefix thereof.
+
+*setcon \<securitycontext\>*
+
+- action command: Set the current process security context to the specified
+  string. This is typically only used from *early-init* to set the *init*
+  context before any other process is started (see *init.rc* example above).
+
+Examples of their usage are shown in the following *init.rc* file segments:
 
 ***system/core/rootdir/init.rc***
 
@@ -715,7 +710,7 @@ are many useful comments in this file regarding its build.
 ### SELinux Policy Files
 
 The core policy files are contained in *system/sepolicy*, with device
-specific policy in *device/&lt;vendor&gt;/&lt;device&gt;/sepolicy*
+specific policy in *device/\<vendor\>/\<device\>/sepolicy*
 Once generated, the policy and its supporting configuration files will be
 installed on the device as part of the build process.
 
@@ -724,49 +719,56 @@ used to build the kernel binary policy file.
 
 *private/mls_macro*, *public/global_macros*, *public/ioctl_macros*,
 *public/neverallow_macros*, *public/te_marcos*
--   These contain the ***m4**(1)* macros that control and expand the policy files
-to build a policy in the kernel policy language to be compiled by
-***checkpolicy**(8)*. The
-[**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language)
-section defines the kernel policy language.
+
+- These contain the ***m4**(1)* macros that control and expand the policy
+  files to build a policy in the kernel policy language to be compiled by
+  ***checkpolicy**(8)*. The
+  [**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language)
+  section defines the kernel policy language.
 
 *private/access_vectors*, *private/security_classes*
--   These have been modified to support the new Android classes and
-permissions.
+
+- These have been modified to support the new Android classes and
+  permissions.
 
 *private/initial_sids*, *private/initial_sids_contexts*
--   Contains the system initialisation (before policy is loaded) and
-failsafe (for objects that would not otherwise have a valid label).
 
-*fs_use*,
-*genfs_contexts*
-*port_contexts*
--   Contains policy context for various devices, see the
-    [**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language)
-    section for details.
+- Contains the system initialisation (before policy is loaded) and
+  failsafe (for objects that would not otherwise have a valid label).
+
+*fs_use*, *genfs_contexts*, *port_contexts*
+
+- Contains policy context for various devices, see the
+  [**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language)
+  section for details.
 
 *private/users*, *private/roles*
--   These define the only user (*u*) and role (*r*) used by the policy.
+
+- These define the only user (*u*) and role (*r*) used by the policy.
 
 *private/mls*
--   Contains the constraints to be applied to the defined classes and permissions.
+
+- Contains the constraints to be applied to the defined classes and permissions.
 
 *private/policy_capabilities*
--   Contains the policy capabilities enabled for the kernel policy (see
-[***policycap***](policy_config_statements.md#policy-configuration-statements)
-statement).
+
+- Contains the policy capabilities enabled for the kernel policy (see
+  [***policycap***](policy_config_statements.md#policy-configuration-statements)
+  statement).
 
 \*.te
--   The **.te* files are the policy module definition files. These are
-the same format as the standard reference policy and are expanded by the
-m4 macros. There is (generally) one *.te* file for each domain/service
-defined containing the policy rules. The device/vendor may also produce these.
+
+- The *\*.te* files are the policy module definition files. These are
+  the same format as the standard reference policy and are expanded by the
+  m4 macros. There is (generally) one *.te* file for each domain/service
+  defined containing the policy rules. The device/vendor may also produce these.
 
 *file_contexts*
--   Contains default file contexts for setting the SELinux extended file
-    attributes (***attr**(1)*). The format of this file is defined in the
-    [*file_contexts *](#file_contexts) section. The device/vendor may also
-    produce these.
+
+- Contains default file contexts for setting the SELinux extended file
+  attributes (***attr**(1)*). The format of this file is defined in the
+  [*file_contexts *](#file_contexts) section. The device/vendor may also
+  produce these.
 
 ### Android Policy Files
 
@@ -775,33 +777,36 @@ determinn whether access is allowed or not based on the security contexts
 contained within them.
 
 *seapp_contexts*
--   Contains information to allow domain or data file contexts to be
-    computed based on parameters as discussed in the
-    [*seapp_contexts*](#seapp_contexts) section.
+
+- Contains information to allow domain or data file contexts to be
+  computed based on parameters as discussed in the
+  [*seapp_contexts*](#seapp_contexts) section.
 
 *property_contexts*
--   Contains default contexts for Android property services as discussed in
-    the [*property_contexts*](#property_contexts) section.
-
-*service_contexts*
-*hwservice_contexts*
-*vndservice_contexts*
--   Contains default contexts for Android services as discussed in the
-    [*service_contexts*](#service_contexts) section. The hardware and
-    vendor service files share the same format and use
-    *selabel_open(SELABEL_CTX_ANDROID_SERVICE ..);*, ***selabel_lookup**(3)*
-    for processing files.
+
+- Contains default contexts for Android property services as discussed in
+  the [*property_contexts*](#property_contexts) section.
+
+*service_contexts*, *hwservice_contexts* and *vndservice_contexts*
+
+- Contains default contexts for Android services as discussed in the
+  [*service_contexts*](#service_contexts) section. The hardware and
+  vendor service files share the same format and use
+  *selabel_open(SELABEL_CTX_ANDROID_SERVICE ..);* and ***selabel_lookup**(3)*
+  for processing files.
 
 *mac_permissions.xml*
--   The Middleware Mandatory Access Control (MMAC) file assigns an *seinfo* tag
-    to apps based on their signature and optionally their package name.
-    The *seinfo* tag can then be used as a key in the *seapp_contexts* file to
-    assign a specific label to all apps with that *seinfo* tag. The configuration
-    file is read by *system_server* during start-up. The main code for the
-    service is *frameworks/base/services/java/com/android/server/pm/SELinuxMMAC.java*,
-    however it does hook into other Android services such as *PackageManagerService.java*.
-    Its format is discussed in the [*mac_permissions.xml*](#mac_permissions.xml)
-    section.
+
+- The Middleware Mandatory Access Control (MMAC) file assigns an *seinfo* tag
+  to apps based on their signature and optionally their package name.
+  The *seinfo* tag can then be used as a key in the *seapp_contexts* file to
+  assign a specific label to all apps with that *seinfo* tag. The configuration
+  file is read by *system_server* during start-up. The main code for the
+  service is
+  *frameworks/base/services/java/com/android/server/pm/SELinuxMMAC.java*,
+  however it does hook into other Android services such as
+  *PackageManagerService.java*. Its format is discussed in the
+  [*mac_permissions.xml*](#mac_permissions.xml)  section.
 
 ### Device Specific Policy
 
@@ -810,7 +815,7 @@ Some of this section has been extracted from the
 been updates. It describes how files in *system/sepolicy* can be
 manipulated during the build process to reflect requirements of
 different device vendors whose policy files would be located in
-the *device/&lt;vendor&gt;/&lt;board&gt;/sepolicy* directory.
+the *device/\<vendor\>/\<board\>/sepolicy* directory.
 
 Important Note: Android policy has a number of
 [***neverallow***](avc_rules.md#neverallow) rules defined in
@@ -834,15 +839,15 @@ newline inserted between each file as these are common failure
 points.
 
 These device policy files can be configured through the use of
-the BOARD_VENDOR_SEPOLICY_DIRS variable. This variable should be set
-in the BoardConfig.mk file in the device or vendor directories.
+the *BOARD_VENDOR_SEPOLICY_DIRS* variable. This variable should be set
+in the *BoardConfig.mk* file in the device or vendor directories.
 
-BOARD_VENDOR_SEPOLICY_DIRS contains a list of directories to search
+*BOARD_VENDOR_SEPOLICY_DIRS* contains a list of directories to search
 for additional policy files. Order matters in this list.
 For example, if you have 2 instances of *widget.te* files in the
-BOARD_VENDOR_SEPOLICY_DIRS search path, then the first one found (at the
-first search dir containing the file) will be concatenated first.
-Reviewing *out/target/product/&lt;device&gt;/obj/ETC/sepolicy_intermediates/policy.conf*
+*BOARD_VENDOR_SEPOLICY_DIRS* search path, then the first one found (at the
+first search dir containing the file) will be concatenated first. Reviewing
+*out/target/product/\<device\>/obj/ETC/sepolicy_intermediates/policy.conf*
 will help sort out ordering issues.
 
 Example *BoardConfig.mk* usage from the Tuna device
@@ -857,11 +862,12 @@ definitions during the build. A definition consists of a string in the form
 of *macro-name=value*. Spaces must NOT be present. This is useful for building
 modular policies, policy generation, conditional file paths, etc. It is
 supported in the following file types:
- * All \*.te and SE Linux policy files as passed to checkpolicy
- * file_contexts
- * service_contexts
- * property_contexts
- * keys.conf
+
+* All \*.te and SE Linux policy files as passed to checkpolicy
+* file_contexts
+* service_contexts
+* property_contexts
+* keys.conf
 
 Example *BoardConfig.mk* Usage:
 
@@ -900,8 +906,8 @@ Usage1:
    checkfc -p sepolicy property_contexts
 ```
 
--   Also used to compare two file_contexts or file_contexts.bin files.
-    Displays one of subset, equal, superset, or incomparable.
+- Also used to compare two file_contexts or file_contexts.bin files.
+  Displays one of subset, equal, superset, or incomparable.
 
 Usage2:
 
@@ -997,12 +1003,12 @@ adb shell dmesg
 
 This section details the following Android policy files:
 
--   *file_contexts*
--   *seapp_contexts*
--   *service_contexts*
--   *property_contexts*
--   *mac_permissions.xml*
--   *keys.conf*
+- *file_contexts*
+- *seapp_contexts*
+- *service_contexts*
+- *property_contexts*
+- *mac_permissions.xml*
+- *keys.conf*
 
 ### ***file_contexts***
 
@@ -1020,32 +1026,37 @@ Each line within the file consists of the following:
 pathname_regexp [file_type] security_context
 ```
 
-Where:
-
-<table>
-<tbody>
-<tr>
-<td>pathname_regexp</td>
-<td>An entry that defines the pathname that may be in the form of a regular expression (see the example file_contexts files below).<p><strong>Note: <em>/dev/block</em></strong> devices may have additional keywords: <strong><em>by-name</em></strong> and <strong><em>by-uuid</em></strong><br>These are resolved by
-<em>system/core/init/devices.cpp</em> as a block device name/uuid may change based on the detection order etc..</td>
-</tr>
-<tr>
-<td>file_type</td>
-<td><p>One of the following optional file_type entries (note if blank means "match all file types"):</p>
-<p>'<em>-b</em>' - Block Device         '<em>-c</em>' - Character Device</p>
-<p>'<em>-d</em>' - Directory               '<em>-p</em>' - Named Pipe (FIFO)</p>
-<p>'<em>-l</em>' - Symbolic Link      '<em>-s</em>' - Socket File</p>
-<p>'<em>--</em>' - Ordinary file</p>
-<p>This entry equates to the file mode and also the file related object class (e.g. <em>S_IFSOCK</em> = <em>sock_file</em> class).</p></td>
-</tr>
-<tr>
-<td>security_context</td>
-<td>This entry can be either:<br>- The security context that will be assigned to the file.<br>- A value of <code>&lt;&lt;none&gt;&gt;</code> that states matching files should not be re-labeled.</td>
-</tr>
-</tbody>
-</table>
+**Where:**
 
-Example entries:
+*pathname_regexp*
+
+- An entry that defines the pathname that may be in the form of a regular
+  expression (see the example *file_contexts* files below). Note that
+  */dev/block* devices may have additional keywords: *by-name* and *by-uuid*
+  These are resolved by *system/core/init/devices.cpp* as a block device
+  *name*/*uuid* may change based on the detection order etc..
+
+*file_type*
+
+- This entry equates to the file mode and also the file related object class
+  (e.g. *S_IFSOCK* = *sock_file* class).One of the following optional
+  *file_type entries* (note if blank means "match all file types"):
+  - *-b* - Block Device
+  - *-c* - Character Device
+  - *-d* - Directory
+  - *-p* - Named Pipe (FIFO)
+  - *-l* - Symbolic Link
+  - *-s* - Socket File
+  - *--* - Ordinary file
+
+*security_context*
+
+- This entry can be either:
+  - The security context that will be assigned to the file.
+  - A value of *\<\<none\>\>* that states matching files should not be
+    re-labeled.
+
+**Example entries:**
 
 ```
 ###########################################
@@ -1371,8 +1382,13 @@ The file format is:
 property_key security_context type value
 ```
 
-type = prefix or exact
-value = int, double, bool or string
+*type*
+
+- prefix or exact
+
+*value*
+
+- int, double, bool or string
 
 Example entries:
 
@@ -1475,7 +1491,7 @@ An example *mac_permissions.xml* file:
 </policy>
 ```
 
-The **&lt;signer signature=** entry may have the public base16 signing
+The **signer signature=** entry may have the public base16 signing
 key present in the string or it may have an entry starting with '@',
 where the keyword (e.g. VRCORE_DEV) extracts the key from a *pem* file
 as discussed in the [**keys.conf**](#keys.conf) section.
@@ -1499,10 +1515,11 @@ file:
     represents additional info that each app can use in setting a SELinux security
     context on the eventual process as well as the apps data directory.
 4.  *seinfo* assignments are made according to the following rules:
--   Stanzas with package name refinements will be checked first.
--   Stanzas w/o package name refinements will be checked second.
--   The "default" *seinfo* label is automatically applied.
-5.  valid stanzas can take one of the following forms:
+- Stanzas with package name refinements will be checked first.
+- Stanzas w/o package name refinements will be checked second.
+- The "default" *seinfo* label is automatically applied.
+
+Valid stanzas can take one of the following forms:
 
 ```
      // single cert protecting seinfo
-- 
2.26.2

