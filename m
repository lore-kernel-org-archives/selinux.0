Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E12DC433EF
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 08:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbiDDIcD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiDDIcA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 04:32:00 -0400
Received: from sa-prd-fep-041.btinternet.com (mailomta19-sa.btinternet.com [213.120.69.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE922520
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 01:30:03 -0700 (PDT)
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20220404083001.ZWTA30965.sa-prd-fep-041.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Mon, 4 Apr 2022 09:30:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1649061001; 
        bh=1qdi4oRFwUrw6rckIr/cOG7UhHD4jmAXZHqGDHh9wT8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=ObZX+EcDnb4aHnxEWtS0k1rNuPI1xwVEU1mFlD9KPlN9W7pDQzVN1nuWAXrXit86ut1NxuKT/RxSUR66wlsdjaX6yEZtP1NTbAGmfk8hXbQJMXf8B4eJ9v0mL+WZ8vq5XJpx+a1B/yobB1Fa0v0Jx4NTuuaP1bNaQsu0Sc4jar+ExEr2paqvvvQsG8wgq9kC6/0OErtUkXDpzrV4BksjWXBvduR9shhEXUASKSFQq+XUzpK5UrDlUAptllFvwYBuLzFGIMjAfkpBKXYn7jNzFU+pEJwwnQuZ/kdmon0i1Qvs/3/32/YVKYJVhta6Svp2bzw/4RLeRRkFMltAH3EuBA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613943C61D93FC00
X-Originating-IP: [109.158.127.88]
X-OWM-Source-IP: 109.158.127.88 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudejvddgtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepuddtledrudehkedruddvjedrkeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheekrdduvdejrdekkedpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.158.127.88) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613943C61D93FC00; Mon, 4 Apr 2022 09:30:01 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 Notebook] How to add a new policy capability
Date:   Mon,  4 Apr 2022 09:29:47 +0100
Message-Id: <20220404082947.5817-1-richard_c_haines@btinternet.com>
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

 src/lsm_selinux.md              |   4 +
 src/policy_config_statements.md | 139 ++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/src/lsm_selinux.md b/src/lsm_selinux.md
index 560d89f..2fa34dd 100644
--- a/src/lsm_selinux.md
+++ b/src/lsm_selinux.md
@@ -712,6 +712,10 @@ or *libsepol* library.
 - Enables fine-grained labeling of symlinks in pseudo filesystems based
   on *genfscon* rules.
 
+*policy_capabilities/ioctl_skip_cloexec*
+
+- If true always allow FIOCLEX and FIONCLEXE ioctl permissions (from kernel 5.18).
+
 *policy_capabilities/network_peer_controls*
 
 - If true the following *network_peer_controls* are enabled:
diff --git a/src/policy_config_statements.md b/src/policy_config_statements.md
index d4eee48..90bf440 100644
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
+- enum definition is ```POLICYDB_CAP_``` with the indentifier appended in
+  upper-case.
+- kernel function call is ```selinux_policycap_``` with the indentifier
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
+The new policy capability identifier is then added to the Reference Policy file:
+
+***policy/policy_capabilities***
+
+To enable the capability in policy:
+
+```
+# A description of the capability
+policycap new_name;
+```
+
+To disable the capability comment out the entry:
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

