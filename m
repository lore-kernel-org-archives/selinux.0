Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA92C43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E206220C09
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 17:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="It8BaE3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgIJROL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:14:11 -0400
Received: from mailomta29-re.btinternet.com ([213.120.69.122]:53598 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726769AbgIJRLm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 13:11:42 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20200909133048.SKEM4599.re-prd-fep-047.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658248; 
        bh=WiaiRTgesQ81sJH6cV2BTbRKKW/OBVOCw/7UFcS9j5A=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=It8BaE3mo9VEfdDJfGU8kxNjvvJYVqJmnS2Dq+mN/rhxJhdL7T0K+aLOMLKtsd9rCGe3bQaE8aiZjKYZ7zIK+e80gVCfy3Dopy9sDFi9co2gatyYcsEJ6+hxM/Ej8+oazHWVqFXppCLfzBeAu7Df+MRECCzTBWxHeOD1c4mX/zAYmnFFGP19iu/n+GO5g99Ns5Z8E1/qEJfQC/NnA/pfrqIiR3EW48ejDH/5+y5qIDUQ2SX3wcQqAvtL1xB8T0dSjcxDaD2KIZ+hprFWlYjJgMTXjS4/5ThNYgJbsHs88M8WQk/MgigRhL+dTktpeoWE7OiU8cLzAdGCpEveKJYVWA==
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
        id 5ED9C2FD10134E35; Wed, 9 Sep 2020 14:30:48 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 18/22] userspace_libraries: Tidy up formatting, add toc
Date:   Wed,  9 Sep 2020 14:30:35 +0100
Message-Id: <20200909133039.44498-19-richard_c_haines@btinternet.com>
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
 src/userspace_libraries.md | 58 ++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/src/userspace_libraries.md b/src/userspace_libraries.md
index 4f70321..5be703a 100644
--- a/src/userspace_libraries.md
+++ b/src/userspace_libraries.md
@@ -1,5 +1,9 @@
 # SELinux Userspace Libraries
 
+- [libselinux Library](#libselinux-library)
+- [libsepol Library](#libsepol-library)
+- [libsemanage Library](#libsemanage-library)
+
 The versions of kernel and SELinux tools and libraries influence the
 features available, therefore it is important to establish what level of
 functionality is required for the application. The
@@ -19,13 +23,13 @@ Python, Ruby and PHP languages.
 
 The library hides the low level functionality of (but not limited to):
 
--   The SELinux filesystem that interfaces to the SELinux kernel
-    security server.
--   The proc filesystem that maintains process state information and
-    security contexts - see ***proc**(5)*.
--   Extended attribute services that manage the extended attributes
-    associated to files, sockets etc. - see ***attr**(5)*.
--   The SELinux policy and its associated configuration files.
+- The SELinux filesystem that interfaces to the SELinux kernel
+  security server.
+- The proc filesystem that maintains process state information and
+  security contexts - see ***proc**(5)*.
+- Extended attribute services that manage the extended attributes
+  associated to files, sockets etc. - see ***attr**(5)*.
+- The SELinux policy and its associated configuration files.
 
 The general category of functions available in *libselinux* are shown below,
 with [**Appendix B - *libselinux* API Summary**](libselinux_functions.md#appendix-b---libselinux-api-summary)
@@ -102,24 +106,23 @@ Retrieve default contexts for user sessions.
 The *libselinux* functions make use of a number of files within the
 SELinux sub-system:
 
-1.  The SELinux configuration file *config* that is described in the
-    [*/etc/selinux/config*](global_config_files.md#etcselinuxconfig) section.
-2.  The SELinux filesystem interface between userspace and kernel that
-    is generally mounted as */selinux* or */sys/fs/selinux* and
-    described in the
-    [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem)
-    section.
-3.  The *proc* filesystem that maintains process state information and
-    security contexts - see ***proc**(5)*.
-4.  The extended attribute services that manage the extended attributes
-    associated to files, sockets etc. - see ***attr**(5)*.
-5.  The SELinux kernel binary policy that describes the enforcement
-    policy.
-6.  A number of *libselinux* functions have their own configuration
-    files that in conjunction with the policy, allow additional levels
-    of configuration. These are described in the
-    [**Policy Configuration Files**](policy_config_files.md#policy-configuration-files)
-    section.
+1. The SELinux configuration file *config* that is described in the
+   [*/etc/selinux/config*](global_config_files.md#etcselinuxconfig) section.
+2. The SELinux filesystem interface between userspace and kernel that
+   is generally mounted as */selinux* or */sys/fs/selinux* and
+   described in the
+   [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem) section.
+3. The *proc* filesystem that maintains process state information and
+   security contexts - see ***proc**(5)*.
+4. The extended attribute services that manage the extended attributes
+   associated to files, sockets etc. - see ***attr**(5)*.
+5. The SELinux kernel binary policy that describes the enforcement
+   policy.
+6. A number of *libselinux* functions have their own configuration
+   files that in conjunction with the policy, allow additional levels
+   of configuration. These are described in the
+   [**Policy Configuration Files**](policy_config_files.md#policy-configuration-files)
+   section.
 
 There is a static version of the library that is not installed by default:
 
@@ -140,10 +143,11 @@ dnf install libsepol-static
 
 This is used by commands such as ***audit2allow**(8)* and ***checkpolicy**(8)*
 as they require access to functions that are not available in the dynamic
-library (such as sepol_compute_av(), sepol_compute_av_reason() and
-sepol_context_to_sid().
+library, such as *sepol_compute_av()*, *sepol_compute_av_reason()* and
+*sepol_context_to_sid()*.
 
 ## libsemanage Library
+
 *libsemanage* - To manage the policy infrastructure.
 
 <!-- %CUTHERE% -->
-- 
2.26.2

