Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFEBC433E4
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC0420706
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="ZVKfOOMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHYIi1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:27 -0400
Received: from mailomta12-sa.btinternet.com ([213.120.69.18]:35296 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728873AbgHYIiR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:17 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20200825083811.VUFS4609.sa-prd-fep-047.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344691; 
        bh=smUIFAcgfgCcaohr4VEO5dUM7n+qDg7USg195rx+kqc=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=ZVKfOOMJQcctAr/W7yHWe9mv3YH5rosudMU/N4NeWz5X5FW9SDjRWoYwzhiZk2PLrgsJeqw3KaVcRKrkBwYZYyPn4LHrL0VkHMa2oQUB0oUlYypCfzuaohoLMeSGYL2bOqzZCfuDccGXfJ66Z7uyNmGHMxlO+6N8Iszz1tnzRRWE67VUAqIbuv3ymZAE2iImEmcIgVkOU8Ob7t7b3SYDteLKVYklcrgrC5jZn1C7NydkVHU4Ml6W7YVZU85o8nB/CLUVqETXCzXpa4sSfOl7bepnqxmf6HPuJ3ZbX5cMQXLfSQlvTLeIhXH8NeRrgmRFKjLdB6swQQ9TklnFgx+STw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepvdejfeehfeduhfevjeehheejkefgvdekvdegueelffdtkeeghfekveduveffieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepuddtledrudehhedrudeftddrudeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrudeftddrudeitddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhg
        vghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599E3C; Tue, 25 Aug 2020 09:38:11 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 12/18] core_components: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:37 +0100
Message-Id: <20200825083743.6508-13-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert to markdown

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/core_components.md | 211 +++++++++++++++++++----------------------
 1 file changed, 99 insertions(+), 112 deletions(-)

diff --git a/src/core_components.md b/src/core_components.md
index 0bb9058..eeb1945 100644
--- a/src/core_components.md
+++ b/src/core_components.md
@@ -3,19 +3,19 @@
 **Figure 1** shows a high level diagram of the SELinux core components that
 manage enforcement of the policy and comprise of the following:
 
-1.  A [**Subjects**](subjects.md#subjects) that must be present to cause an action
-    to be taken by an [**Objects**](objects.md#objects) (such as read a file as
-    information only flows when a subject is involved).
-2.  An Object Manager that knows the actions required of the particular
-    resource (such as a file) and can enforce those actions (i.e. allow
-    it to write to a file if permitted by the policy).
-3.  A Security Server that makes decisions regarding the subjects rights
-    to perform the requested action on the object, based on the security
-    policy rules.
-4.  A Security Policy that describes the rules using the SELinux
-    [**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language)).
-5.  An Access Vector Cache (AVC) that improves system performance by
-    caching security server decisions.
+1. A [**Subject**](subjects.md#subjects) that must be present to cause an action
+   to be taken by an [**Object**](objects.md#objects) (such as read a file as
+   information only flows when a subject is involved).
+2. An Object Manager that knows the actions required of the particular
+   resource (such as a file) and can enforce those actions (i.e. allow
+   it to write to a file if permitted by the policy).
+3. A Security Server that makes decisions regarding the subjects rights
+   to perform the requested action on the object, based on the security
+   policy rules.
+4. A Security Policy that describes the rules using the SELinux
+   [**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language)).
+5. An Access Vector Cache (AVC) that improves system performance by
+   caching security server decisions.
 
 ![](./images/1-core.png)
 
@@ -33,113 +33,100 @@ supporting services that are used to manage the SELinux environment.
 This diagram will be referenced a number of times to explain areas of
 SELinux, therefore starting from the bottom:
 
-1.  In the current implementation of SELinux the security server is
-    embedded in the kernel with the policy being loaded from userspace via a
-    series of functions contained in the **libselinux** library (see
-    [**SELinux Userspace Libraries**](userspace_libraries.md#selinux-userspace-libraries) for details).
-
-    The object managers (OM) and access vector cache (AVC) can reside in:
-
--   **kernel space** - These object manages are for the kernel services such
-as files, directory, socket, IPC etc. and are provided by hooks into the
-SELinux sub-system via the Linux Security Module (LSM) framework (shown
-as LSM Hooks in ) that is discussed in the
-[**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
- section. The SELinux kernel AVC service is used to cache the security servers
-response to the kernel based object managers thus speeding up access decisions
-should the same request be asked in future.
-
--   **userspace** - These object managers are provided with the application
-    or service that requires support for MAC and are known as
-    'SELinux-aware' applications or services. Examples of these are:
-    X-Windows, D-bus messaging (used by the Gnome desktop), PostgreSQL
-    database, Name Service Cache Daemon (*nscd*), and the GNU / Linux passwd
-    command. Generally, these OMs use the AVC services built into the
-    SELinux library (libselinux), however they could, if required supply
-    their own AVC or not use an AVC at all (see
-    [**Implementing SELinux-aware Applications**](implementing_seaware_apps.md#implementing-selinux-aware-applications) for details).
-
-2.  The SELinux security policy (right hand side of **Figure 2**) and its
-supporting configuration files are contained in the /etc/selinux directory.
-This directory contains the main SELinux configuration file *config* that has
-the name of the policy to be loaded (via the *SELINUXTYPE* entry) and the initial
-enforcement mode<a href="#fnc1" class="footnote-ref" id="fncor1"><sup>1</sup></a>
-of the policy at load time (via the *SELINUX* entry).
-The /etc/selinux/*&lt;SELINUXTYPE&gt;* directories
-contain policies that can be activated along with their configuration
-files (e.g. '*SELINUXTYPE=targeted*' will have its policy and associated
-configuration files located at */etc/selinux/targeted*). All known
-configuration files are shown in the
-[**SELinux Configuration Files**](configuration_files.md#selinux-configuration-files)
-sections.
-
-3.  SELinux supports a 'modular policy', this means that a policy does not
-have to be one large source policy but can be built from modules. A
-modular policy consists of a base policy that contains the mandatory
-information (such as object classes, permissions etc.), and zero or more
-policy modules where generally each supports a particular application or
-service. These modules are compiled, linked, and held in a 'policy
-store' where they can be built into a binary format that is then loaded
-into the security server (in the diagram the binary policy is located at
-*/etc/selinux/targeted/policy/policy.30*). The types of policy and their
-construction are covered in the
-[**Types of SELinux Policy**](types_of_policy.md#types-of-selinux-policy)
-section.
-
-4.  To be able to build the policy in the first place, policy source is
-required (top left hand side of **Figure 2**). This can be supplied in three
-basic ways:
-
--  as source code written using the
-[**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language),
-however it is not recommended for large policy developments.
--  using the **Reference Policy** that has high
-level macros to define policy rules. This is the standard way
-policies are now built for SELinux distributions such as Red Hat
-and Debian and is discussed in the
-[**The Reference Policy**](reference_policy.md#the-reference-policy)
-section. Note that SE for Android also uses high level macros to define
-policy rules.
--  using CIL (Common Intermediate Language). An overview can be found
-in the [**CIL Policy Language**](cil_overview.md#cil-overview)
-section. The <https://github.com/DefenSec/dssp> is a good example.
-
+1. In the current implementation of SELinux the security server is
+   embedded in the kernel with the policy being loaded from userspace via a
+   series of functions contained in the **libselinux** library (see
+   [**SELinux Userspace Libraries**](userspace_libraries.md#selinux-userspace-libraries)
+   for details). The object managers (OM) and access vector cache (AVC) can
+   reside in:
+   - **kernel space** - These object manages are for the kernel services such
+     as files, directory, socket, IPC etc. and are provided by hooks into the
+     SELinux sub-system via the Linux Security Module (LSM) framework (shown
+     as LSM Hooks in ) that is discussed in the
+     [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
+     section. The SELinux kernel AVC service is used to cache the security
+     servers response to the kernel based object managers thus speeding up
+     access decisions should the same request be asked in future.
+   - **userspace** - These object managers are provided with the application
+     or service that requires support for MAC and are known as
+     'SELinux-aware' applications or services. Examples of these are:
+     X-Windows, D-bus messaging (used by the Gnome desktop), PostgreSQL
+     database, Name Service Cache Daemon (*nscd*), and the GNU / Linux passwd
+     command. Generally, these OMs use the AVC services built into the
+     SELinux library (libselinux), however they could, if required supply
+     their own AVC or not use an AVC at all (see
+     [**Implementing SELinux-aware Applications**](implementing_seaware_apps.md#implementing-selinux-aware-applications)
+     for details).
+2. The SELinux security policy (right hand side of **Figure 2**) and its
+   supporting configuration files are contained in the /etc/selinux directory.
+   This directory contains the main SELinux configuration file *config* that has
+   the name of the policy to be loaded (via the *SELINUXTYPE* entry) and the
+   initial enforcement mode[^fn_cc_1] of the policy at load time (via the
+   *SELINUX* entry). The */etc/selinux/\<SELINUXTYPE\>* directories contain
+   policies that can be activated along with their configuration files (e.g.
+   '*SELINUXTYPE=targeted*' will have its policy and associated configuration
+   files located at */etc/selinux/targeted*). All known configuration files are
+   shown in the
+   [**SELinux Configuration Files**](configuration_files.md#selinux-configuration-files)
+   sections.
+3. SELinux supports a 'modular policy', this means that a policy does not
+   have to be one large source policy but can be built from modules. A
+   modular policy consists of a base policy that contains the mandatory
+   information (such as object classes, permissions etc.), and zero or more
+   policy modules where generally each supports a particular application or
+   service. These modules are compiled, linked, and held in a 'policy
+   store' where they can be built into a binary format that is then loaded
+   into the security server (in the diagram the binary policy is located at
+   */etc/selinux/targeted/policy/policy.30*). The types of policy and their
+   construction are covered in the
+   [**Types of SELinux Policy**](types_of_policy.md#types-of-selinux-policy)
+   section.
+4. To be able to build the policy in the first place, policy source is
+   required (top left hand side of **Figure 2**). This can be supplied in three
+   basic ways:
+   1. as source code written using the
+      [**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language),
+      however it is not recommended for large policy developments.
+   2. using the **Reference Policy** that has high
+      level macros to define policy rules. This is the standard way
+      policies are now built for SELinux distributions such as Red Hat
+      and Debian and is discussed in the
+      [**The Reference Policy**](reference_policy.md#the-reference-policy)
+      section. Note that SE for Android also uses high level macros to define
+      policy rules.
+   3. using CIL (Common Intermediate Language). An overview can be found
+      in the [**CIL Policy Language**](cil_overview.md#cil-overview)
+      section. The <https://github.com/DefenSec/dssp> is a good example.
 5. To be able to compile and link the policy source then load it into the
-security server requires a number of tools (top of **Figure 2**).
-
-6.  To enable system administrators to manage policy, the SELinux
-environment and label file systems, tools and modified GNU / Linux
-commands are used. These are mentioned throughout the Notebook as needed
-and summarised in
-[**SELinux Commands**](selinux_cmds.md#appendix-c---selinux-commands).
-Note that there are many other applications to manage policy, however this
-Notebook only concentrates on the core services.
-
-7.  To ensure security events are logged, GNU / Linux has an audit service
-that captures policy violations. The
-[**Auditing Events**](auditing.md#auditing-selinux-events)
-section describes the format of these security events.
-
-8.  SELinux supports network services that are described in the
-[**SELinux Networking Support**](network_support.md#selinux-networking-support)
-section.
+   security server requires a number of tools (top of **Figure 2**).
+6. To enable system administrators to manage policy, the SELinux
+   environment and label file systems, tools and modified GNU / Linux
+   commands are used. These are mentioned throughout the Notebook as needed
+   and summarised in
+   [**SELinux Commands**](selinux_cmds.md#appendix-c---selinux-commands).
+   Note that there are many other applications to manage policy, however this
+   Notebook only concentrates on the core services.
+7. To ensure security events are logged, GNU / Linux has an audit service
+   that captures policy violations. The
+   [**Auditing Events**](auditing.md#auditing-selinux-events)
+   section describes the format of these security events.
+8. SELinux supports network services that are described in the
+   [**SELinux Networking Support**](network_support.md#selinux-networking-support)
+   section.
 
 The [**Linux Security Module and SELinux**](lsm_selinux.md#linux-security-module-and-selinux)
 section goes into greater detail of the LSM / SELinux modules with a walk
 through of a ***fork**(2)* and ***exec**(2)* process.
 
-<section class="footnotes">
-<ol>
-<li id="fnc1"><p>When SELinux is enabled, the policy can be running in 'permissive mode' (<code>SELINUX=permissive</code>), where all accesses are allowed. The policy
-can also be run in 'enforcing mode' (<code>SELINUX=enforcing</code>), where any
+[^fn_cc_1]: When SELinux is enabled, the policy can be running in
+'permissive mode' (*SELINUX=permissive*), where all accesses are allowed.
+The policy can also be run in 'enforcing mode' (*SELINUX=enforcing*), where any
 access that is not defined in the policy is denied and an entry placed
 in the audit log. SELinux can also be disabled (at boot time only) by
-setting <code>SELINUX=disabled</code>. There is also support for the
-<a href="type_statements.md#permissive"><code>permissive</code></a>
-statement that allows a domain to run in permissive mode while the others are still confined
-(instead of the all or nothing set by <code>SELINUX=</code>).<a href="#fncor1" class="footnote-back">↩</a></p></li>
-</ol>
-</section>
+setting *SELINUX=disabled*. There is also support for the
+[***permissive***](type_statements.md#permissive) statement that allows a
+domain to run in permissive mode while the others are still confined
+(instead of all or nothing set by *SELINUX=*).
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

