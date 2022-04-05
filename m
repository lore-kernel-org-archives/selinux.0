Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B188C35296
	for <selinux@archiver.kernel.org>; Tue,  5 Apr 2022 08:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbiDEIiC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbiDEIWO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Apr 2022 04:22:14 -0400
Received: from sa-prd-fep-048.btinternet.com (mailomta19-sa.btinternet.com [213.120.69.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F2DE91
        for <selinux@vger.kernel.org>; Tue,  5 Apr 2022 01:19:40 -0700 (PDT)
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20220405081938.CCKP22188.sa-prd-fep-048.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Tue, 5 Apr 2022 09:19:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1649146778; 
        bh=K6kcQeJdMxgE96Dw6MB/Al2m6cGkWUVS2cMc/T+uaVA=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=rpdf+TTRMET0L/mhgrSpIW731wyuml4XX7ocKnHcQtyDrhhxQ4gP9UmrIhFyYqidsxK2Z1Ml/c14bUYXgpjzVU6aXP7whPUAe/TS0tCXQpV+K4R5EwYHgTnsB+l4QoTDOdAYOf8xworZ24gAk3r21sCgSu+PcTP/HL8/IOewehR6V5p/dpAKAL6p1JdP4CKALa/j06v2uPXlp2MSRFRcpqZsgP97kNsxOtenPIcfqkNoSfIcI5iVHW3E/VpsMRE+xR7vIRG9SJWwSnhdaXMO4GVMM6C5oQc2xT8l9wK5z0jg+aXke4Hc7HxxXdjdY0KAuFv8g16a9LQztowsbpUn9g==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613943C61DBB4847
X-Originating-IP: [86.183.114.123]
X-OWM-Source-IP: 86.183.114.123 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudejfedgudeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppeekiedrudekfedruddugedruddvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeefrdduudegrdduvdefpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegusghurhhgvghnvghrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.183.114.123) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613943C61DBB4847; Tue, 5 Apr 2022 09:19:38 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, dburgener@linux.microsoft.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V3 Notebook] How to add a new policy capability
Date:   Tue,  5 Apr 2022 09:19:25 +0100
Message-Id: <20220405081925.5668-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Describes the steps required to add a new policy capability to:
kernel, libsepol, and policy.

Also add the ioctl_skip_cloexec capability description.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Changes:
Clarify naming conventions.
Change enums from POLICYDB_CAPABILITY to POLICYDB_CAP
Add ioctl_skip_cloexec
V3 Changes:
Fix typos and 'Policy Updates' text.

 src/lsm_selinux.md              |   4 +
 src/policy_config_statements.md | 139 ++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/src/lsm_selinux.md b/src/lsm_selinux.md
index cb8189b..7284912 100644
--- a/src/lsm_selinux.md
+++ b/src/lsm_selinux.md
@@ -714,6 +714,10 @@ or *libsepol* library.
 - Enables fine-grained labeling of symlinks in pseudo filesystems based
   on *genfscon* rules.
 
+*policy_capabilities/ioctl_skip_cloexec*
+
+- If true always allow FIOCLEX and FIONCLEXE ioctl permissions (from kernel 5.18).
+
 *policy_capabilities/network_peer_controls*
 
 - If true the following *network_peer_controls* are enabled:
diff --git a/src/policy_config_statements.md b/src/policy_config_statements.md
index d4eee48..9699766 100644
--- a/src/policy_config_statements.md
+++ b/src/policy_config_statements.md
@@ -1,5 +1,12 @@
 # Policy Configuration Statements
 
+- [*policycap*](#policycap)
+  - [Adding A New Policy Capability](#adding-a-new-policy-capability)
+    - [Kernel Updates](#kernel-updates)
+    - [*libsepol* Library Updates](#libsepol-library-updates)
+    - [Reference Policy Updates](#reference-policy-updates)
+    - [CIL Policy Updates](#cil-policy-updates)
+
 ## *policycap*
 
 Policy version 22 introduced the *policycap* statement to allow new
@@ -47,6 +54,138 @@ Conditional Policy Statements
 policycap network_peer_controls;
 ```
 
+## Adding A New Policy Capability
+
+The kernel, userspace libsepol library and policy must be updated to enable
+the new capability as described below. For readability, the new capability
+should follow a consistent naming convention, where:
+
+- policy capability identifier is a lower-case string.
+- enum definition is ```POLICYDB_CAP_``` with the identifier appended in
+  upper-case.
+- kernel function call is ```selinux_policycap_``` with the identifier
+  appended in lower-case.
+
+### Kernel Updates
+
+In kernel source update the following three files with the new capability:
+
+***security/selinux/include/policycap_names.h***
+
+Add new entry at end of this list:
+
+```
+/* Policy capability names */
+const char *selinux_policycap_names[__POLICYDB_CAP_MAX] = {
+	...
+	"genfs_seclabel_symlinks",
+	"ioctl_skip_cloexec",
+	"new_name"
+};
+```
+
+***security/selinux/include/policycap.h***
+
+Add new entry at end of this list:
+
+```
+/* Policy capabilities */
+enum {
+	...
+	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
+	POLICYDB_CAP_NEW_NAME,
+	__POLICYDB_CAP_MAX
+};
+```
+
+***security/selinux/include/security.h***
+
+Add a new call to retrieve the loaded policy capability state:
+
+```
+static inline bool selinux_policycap_new_name(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return READ_ONCE(state->policycap[POLICYDB_CAP_NEW_NAME]);
+}
+```
+
+Finally in the updated code that utilises the new policy capability do
+something like:
+
+```
+if (selinux_policycap_new_name())
+	do this;
+else
+	do that;
+```
+
+### *libsepol* Library Updates
+
+In selinux userspace source update the following two files with the new
+capability:
+
+***selinux/libsepol/src/polcaps.c***
+
+Add new entry at end of this list:
+
+```
+static const char * const polcap_names[] = {
+	...
+	"genfs_seclabel_symlinks",	/* POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS */
+	"ioctl_skip_cloexec",		/* POLICYDB_CAP_IOCTL_SKIP_CLOEXEC */
+	"new_name",			/* POLICYDB_CAP_NEW_NAME */
+	NULL
+};
+```
+
+***selinux/libsepol/include/sepol/policydb/polcaps.h***
+
+Add new entry at end of this list:
+
+```
+/* Policy capabilities */
+enum {
+	...
+	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
+	POLICYDB_CAP_NEW_NAME,
+	__POLICYDB_CAP_MAX
+};
+```
+
+### Reference Policy Updates
+
+To enable the new capability in Reference Policy, add a new entry to this file:
+
+***policy/policy_capabilities***
+
+New *policycap* statement added to end of file:
+
+```
+# A description of the capability
+policycap new_name;
+```
+
+To disable the capability, comment out the entry:
+
+```
+# A description of the capability
+#policycap new_name;
+```
+
+### CIL Policy Updates
+
+To enable the capability in policy, add the following entry to a CIL
+source file:
+
+```
+; A description of the capability
+(policycap new_name)
+```
+
 <!-- %CUTHERE% -->
 
 ---
-- 
2.35.1

