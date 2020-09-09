Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35C4C433E2
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 19:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F82208E4
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 19:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="WI/WlN+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIJTyS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:54:18 -0400
Received: from mailomta4-re.btinternet.com ([213.120.69.97]:17464 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726776AbgIJTx6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 15:53:58 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-041.btinternet.com with ESMTP
          id <20200909133047.HINL30588.re-prd-fep-041.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658247; 
        bh=BTQb1hc37GyeHoCYt6ayI0S4hBC3F2wYC7jvesHTHA0=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=WI/WlN+do0QRaftDsBW0vpErF61tC0J7K/RdCnAwcICI2KKTxsQg8gx0dPdGVNWLW+8VEKQGPeyg9H8R5rgEzG9eJ2I0UFm6VC1jJ+CfQQHFGHGmfD6cudxc8mVdF8uqz5byAHZrFc0HOSNsd++VL3vcDd68XMTYT/1X8z4tNPtvTWM7kX/LU7JwtA/7jqXurpitxYgj/6A7hgW3r/ryK89XYN4sp5olIiCqWxgObEiCHQ8yiq7hd6Gp79H+7jsEFVUPW1QFSl35IIg3PJtLoZQP9xPwK47sWDeDKNoHi44Sn9V0Zjjeixn6R3y6c5kzi2nnfucsKV5Hv2/Qi7kQtQ==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehgedrudehgedrudeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134DF8; Wed, 9 Sep 2020 14:30:47 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 12/22] toc: Tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:29 +0100
Message-Id: <20200909133039.44498-13-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/toc.md | 120 ++++++++++++++++++++++++++---------------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/src/toc.md b/src/toc.md
index d7a4a72..d915b42 100644
--- a/src/toc.md
+++ b/src/toc.md
@@ -1,65 +1,65 @@
 ## Table of Contents
 
--   [Abbreviations and Terminology](terminology.md#abbreviations-and-terminology)
--   [SELinux Overview](selinux_overview.md#selinux-overview)
--   [Core Components](core_components.md#core-selinux-components)
--   [Mandatory Access Control (MAC)](mac.md#mandatory-access-control)
--   [SELinux Users](users.md#selinux-users)
--   [Role-Based Access Control (RBAC)](rbac.md#role-based-access-control)
--   [Type Enforcement (TE)](type_enforcement.md#type-enforcement)
--   [Security Context](security_context.md#security-context)
--   [Subjects](subjects.md#subjects)
--   [Objects](objects.md#objects)
--   [Computing Security Contexts](computing_security_contexts.md#computing-security-contexts)
--   [Computing Access Decisions](computing_access_decisions.md#computing-access-decisions)
--   [Domain and Object Transitions](domain_object_transitions.md#domain-and-object-transitions)
--   [Multi-Level and Multi-Category Security](mls_mcs.md#multi-level-and-multi-category-security)
--   [Types of SELinux Policy](types_of_policy.md#types-of-selinux-policy)
--   [Permissive and Enforcing Modes](modes.md#selinux-permissive-and-enforcing-modes)
--   [Auditing Events](auditing.md#auditing-selinux-events)
--   [Polyinstantiation Support](polyinstantiation.md#polyinstantiation-support)
--   [PAM Login Process](pam_login.md#pam-login-process)
--   [Linux Security Module and SELinux](lsm_selinux.md#linux-security-module-and-selinux)
--   [Userspace Libraries](userspace_libraries.md#selinux-userspace-libraries)
--   [Networking Support](network_support.md#selinux-networking-support)
--   [Virtual Machine Support](vm_support.md#selinux-virtual-machine-support)
--   [X-Windows Support](x_windows.md#x-windows-selinux-support)
--   [SE-PostgreSQL Support](postgresql.md#postgresql-selinux-support)
--   [Apache-Plus Support](apache_support.md#apache-selinux-support)
--   [SELinux Configuration Files](configuration_files.md#selinux-configuration-files)
-    -   [Global Configuration Files](global_config_files.md#global-configuration-files)
-    -   [Policy Store Configuration Files](policy_store_config_files.md#policy-store-configuration-files)
-    -   [Policy Configuration Files](policy_config_files.md#policy-configuration-files)
--   [SELinux Policy Languages](policy_languages.md#the-selinux-policy-languages)
-    -   [CIL Policy Language](cil_overview.md#cil-overview)
-        -   [CIL Reference Guide](notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf)
-    -   [Kernel Policy Language](kernel_policy_language.md#kernel-policy-language)
-        -   [Policy Configuration Statements](policy_config_statements.md#policy-configuration-statements)
-        -   [Default Rules](default_rules.md#default-object-rules)
-        -   [User Statements](user_statements.md#user-statements)
-        -   [Role Statements](role_statements.md#role-statements)
-        -   [Type Statements](type_statements.md#type-statements)
-        -   [Bounds Rules](bounds_rules.md#bounds-rules)
-        -   [Access Vector Rules](avc_rules.md#access-vector-rules)
-        -   [Extended Access Vector Rules](xperm_rules.md#extended-access-vector-rules)
-        -   [Object Class and Permission Statements](class_permission_statements.md#object-class-and-permission-statements)
-        -   [Conditional Policy Statements](conditional_statements.md#conditional-policy-statements)
-        -   [Constraint Statements](constraint_statements.md#constraint-statements)
-        -   [MLS Statements](mls_statements.md#mls-statements)
-        -   [Security ID (SID) Statement](sid_statement.md#security-id-sid-statement)
-        -   [File System Labeling Statements](file_labeling_statements.md#file-system-labeling-statements)
-        -   [Network Labeling Statements](network_statements.md#network-labeling-statements)
-        -   [InfiniBand Labeling Statements](infiniband_statements.md#infiniband-labeling-statements)
-        -   [XEN Statements](xen_statements.md#xen-statements)
-        -   [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
--   [The Reference Policy](reference_policy.md#the-reference-policy)
--   [Implementing SELinux-aware Applications](implementing_seaware_apps.md#implementing-selinux-aware-applications)
--   [SE for Android](seandroid.md#security-enhancements-for-android)
--   [Appendix A - Object Classes and Permissions](object_classes_permissions.md#appendix-a---object-classes-and-permissions)
--   [Appendix B - *libselinux* API Summary](libselinux_functions.md#appendix-b---libselinux-api-summary)
--   [Appendix C - SELinux Commands](selinux_cmds.md#appendix-c---selinux-commands)
--   [Appendix D - Debugging Policy - Hints and Tips](debug_policy_hints.md#appendix-d---debugging-policy---hints-and-tips)
--   [Appendix E - Policy Validation Example](policy_validation_example.md#appendix-e---policy-validation-example)
+- [Abbreviations and Terminology](terminology.md#abbreviations-and-terminology)
+- [SELinux Overview](selinux_overview.md#selinux-overview)
+- [Core Components](core_components.md#core-selinux-components)
+- [Mandatory Access Control (MAC)](mac.md#mandatory-access-control)
+- [SELinux Users](users.md#selinux-users)
+- [Role-Based Access Control (RBAC)](rbac.md#role-based-access-control)
+- [Type Enforcement (TE)](type_enforcement.md#type-enforcement)
+- [Security Context](security_context.md#security-context)
+- [Subjects](subjects.md#subjects)
+- [Objects](objects.md#objects)
+- [Computing Security Contexts](computing_security_contexts.md#computing-security-contexts)
+- [Computing Access Decisions](computing_access_decisions.md#computing-access-decisions)
+- [Domain and Object Transitions](domain_object_transitions.md#domain-and-object-transitions)
+- [Multi-Level and Multi-Category Security](mls_mcs.md#multi-level-and-multi-category-security)
+- [Types of SELinux Policy](types_of_policy.md#types-of-selinux-policy)
+- [Permissive and Enforcing Modes](modes.md#selinux-permissive-and-enforcing-modes)
+- [Auditing Events](auditing.md#auditing-selinux-events)
+- [Polyinstantiation Support](polyinstantiation.md#polyinstantiation-support)
+- [PAM Login Process](pam_login.md#pam-login-process)
+- [Linux Security Module and SELinux](lsm_selinux.md#linux-security-module-and-selinux)
+- [Userspace Libraries](userspace_libraries.md#selinux-userspace-libraries)
+- [Networking Support](network_support.md#selinux-networking-support)
+- [Virtual Machine Support](vm_support.md#selinux-virtual-machine-support)
+- [X-Windows Support](x_windows.md#x-windows-selinux-support)
+- [SE-PostgreSQL Support](postgresql.md#postgresql-selinux-support)
+- [Apache-Plus Support](apache_support.md#apache-selinux-support)
+- [SELinux Configuration Files](configuration_files.md#selinux-configuration-files)
+  - [Global Configuration Files](global_config_files.md#global-configuration-files)
+  - [Policy Store Configuration Files](policy_store_config_files.md#policy-store-configuration-files)
+  - [Policy Configuration Files](policy_config_files.md#policy-configuration-files)
+- [SELinux Policy Languages](policy_languages.md#the-selinux-policy-languages)
+  - [CIL Policy Language](cil_overview.md#cil-overview)
+    - [CIL Reference Guide](notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf)
+  - [Kernel Policy Language](kernel_policy_language.md#kernel-policy-language)
+    - [Policy Configuration Statements](policy_config_statements.md#policy-configuration-statements)
+    - [Default Rules](default_rules.md#default-object-rules)
+    - [User Statements](user_statements.md#user-statements)
+    - [Role Statements](role_statements.md#role-statements)
+    - [Type Statements](type_statements.md#type-statements)
+    - [Bounds Rules](bounds_rules.md#bounds-rules)
+    - [Access Vector Rules](avc_rules.md#access-vector-rules)
+    - [Extended Access Vector Rules](xperm_rules.md#extended-access-vector-rules)
+    - [Object Class and Permission Statements](class_permission_statements.md#object-class-and-permission-statements)
+    - [Conditional Policy Statements](conditional_statements.md#conditional-policy-statements)
+    - [Constraint Statements](constraint_statements.md#constraint-statements)
+    - [MLS Statements](mls_statements.md#mls-statements)
+    - [Security ID (SID) Statement](sid_statement.md#security-id-sid-statement)
+    - [File System Labeling Statements](file_labeling_statements.md#file-system-labeling-statements)
+    - [Network Labeling Statements](network_statements.md#network-labeling-statements)
+    - [InfiniBand Labeling Statements](infiniband_statements.md#infiniband-labeling-statements)
+    - [XEN Statements](xen_statements.md#xen-statements)
+    - [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
+- [The Reference Policy](reference_policy.md#the-reference-policy)
+- [Implementing SELinux-aware Applications](implementing_seaware_apps.md#implementing-selinux-aware-applications)
+- [SE for Android](seandroid.md#security-enhancements-for-android)
+- [Appendix A - Object Classes and Permissions](object_classes_permissions.md#appendix-a---object-classes-and-permissions)
+- [Appendix B - *libselinux* API Summary](libselinux_functions.md#appendix-b---libselinux-api-summary)
+- [Appendix C - SELinux Commands](selinux_cmds.md#appendix-c---selinux-commands)
+- [Appendix D - Debugging Policy - Hints and Tips](debug_policy_hints.md#appendix-d---debugging-policy---hints-and-tips)
+- [Appendix E - Policy Validation Example](policy_validation_example.md#appendix-e---policy-validation-example)
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

