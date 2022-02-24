Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8862FC433EF
	for <selinux@archiver.kernel.org>; Thu, 24 Feb 2022 13:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiBXNIG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiBXNIE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Feb 2022 08:08:04 -0500
Received: from sa-prd-fep-045.btinternet.com (mailomta26-sa.btinternet.com [213.120.69.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49060230E48
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 05:07:33 -0800 (PST)
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20220224130731.UPYR20692.sa-prd-fep-045.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 24 Feb 2022 13:07:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1645708051; 
        bh=l8gtnLH+Z3LB9ZdFTA67SIPyViWzwsskq12qniCti9U=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=XAWfgA31JtlMpTWQdjaD1iVjnawPiVAgCrHi0JTM4t5uW3k3MpxX7oNnXfI8YA6Z4B4TkKQmQHFyabEFXDK0H1An0toxzgD33oKPWiXGRnb7pv/1xXXqGcD9wGq6VRc+tvcLvb/rE0e+BrSUsQgZwWSpegDHx9VC8SW03czzdH/GgPz27mZ8snXz1Iqsf0vJlh8iQLk4MFKEiw4E/Vy7V/TCf/xfai4FwzWQIUh9KD6du2TZwgK4F1jxsFOESa8vOAZQagq+Q0UqBpmELYHXO8kvjv3WJdVR1Loa2uF2NmVFCOLCxJuDBeiw2H/oh7H3hWDCxA6zuhRdf40Hr6WQgg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613006A917E98E70
X-Originating-IP: [109.158.127.121]
X-OWM-Source-IP: 109.158.127.121 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrledvgdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppedutdelrdduheekrdduvdejrdduvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheekrdduvdejrdduvddupdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.158.127.121) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613006A917E98E70; Thu, 24 Feb 2022 13:07:31 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH Notebook] policy_config_statements.md: How to add a new capability
Date:   Thu, 24 Feb 2022 13:07:19 +0000
Message-Id: <20220224130719.44424-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Describes the steps required to add a new policy capability to the:
kernel, libsepol, and policy.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
Paul: Please note the use of the 'Oxford comma' above. Did you know there
is the "Oxford Comma" song by Vampire Weekend (if you are of a sensitive
disposition, don't listen).

 src/policy_config_statements.md | 125 ++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/src/policy_config_statements.md b/src/policy_config_statements.md
index d4eee48..1ae7f64 100644
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
@@ -47,6 +54,124 @@ Conditional Policy Statements
 policycap network_peer_controls;
 ```
 
+## Adding A New Policy Capability
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
+const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
+	...
+	"genfs_seclabel_symlinks",
+	"new_polcap_name"
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
+	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAPABILITY_NEW_POLCAP_NAME,
+	__POLICYDB_CAPABILITY_MAX
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
+	return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_NEW_POLCAP_NAME]);
+}
+```
+
+Finally in the updated code that utilises the new policy capability do
+something like this:
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
+	"genfs_seclabel_symlinks",	/* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
+	"new_polcap_name",		/* POLICYDB_CAPABILITY_NEW_POLCAP_NAME */
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
+	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAPABILITY_NEW_POLCAP_NAME,
+	__POLICYDB_CAPABILITY_MAX
+};
+```
+
+### Reference Policy Updates
+
+The new policy capability is then added to the Reference Policy file:
+
+***policy/policy_capabilities***
+
+To enable the capability in policy:
+
+```
+# A description of the capability
+policycap new_polcap_name;
+```
+
+To disable the capability comment out the entry:
+
+```
+# A description of the capability
+#policycap new_polcap_name;
+```
+
+### CIL Policy Updates
+
+To enable the capability in policy, add the following entry to a CIL
+source file:
+
+```
+; A description of the capability
+(policycap new_polcap_name)
+```
+
 <!-- %CUTHERE% -->
 
 ---
-- 
2.35.1

