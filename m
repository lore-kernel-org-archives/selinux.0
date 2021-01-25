Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30A9C433E6
	for <selinux@archiver.kernel.org>; Tue, 26 Jan 2021 03:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5640022E03
	for <selinux@archiver.kernel.org>; Tue, 26 Jan 2021 03:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbhAYN3v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Jan 2021 08:29:51 -0500
Received: from mailomta23-re.btinternet.com ([213.120.69.116]:44728 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728850AbhAYN3p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Jan 2021 08:29:45 -0500
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20210125132808.EBPO13971.re-prd-fep-046.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Mon, 25 Jan 2021 13:28:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1611581288; 
        bh=ohx2KD33CDJ4GidTp0nREOd9cyjrQ3iS1Rsoj/Uh2Rk=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Y2hqiHOT8uerWnyylLW/eoeKmSbc06cu4iad5cISTF6j18rStvtV1nEOYARlmzO/cO3o1pZ+jsZRAOh2d0IkIgCVq58j/uWVqnJuEpfSza/3mAMv2Yy0oo1ZAZVCbsc6GQYSZQL0syYIiXUreuhmPxRdLGjZCekxmKMAuZi0ry2RG9HCdg35e86UvMOYatswIDo/RK4CdIhNL9fMnWGcaQYXzn8LAoViE4HkBye5tJTqygMX66SUS+DLih0jTnH76Rw31bMSE+iGjwxdKM92jXV61P9pznutCvjjznJXw5hig7pHzEWMZzAwdN9O7ktPVZsorpBQY1cf9tgvTnfCFg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C0CC23A04FA5
X-Originating-IP: [217.42.114.247]
X-OWM-Source-IP: 217.42.114.247 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppedvudejrdegvddruddugedrvdegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepvddujedrgedvrdduudegrddvgeejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (217.42.114.247) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C0CC23A04FA5; Mon, 25 Jan 2021 13:28:08 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-notebook: Fix document links
Date:   Mon, 25 Jan 2021 13:28:05 +0000
Message-Id: <20210125132805.12146-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix navigation links and supporting text.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/configuration_files.md       | 12 ++++++------
 src/implementing_seaware_apps.md |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/configuration_files.md b/src/configuration_files.md
index 0d48d09..9fd8d8b 100644
--- a/src/configuration_files.md
+++ b/src/configuration_files.md
@@ -21,14 +21,14 @@ as follows:
 2. [**Policy Store Configuration Files**](policy_store_config_files.md#policy-store-configuration-files)
    that are managed by the **semanage**(8) and **semodule**(8) commands. These
    are used to build the majority of the
-   [Policy Configuration Files](policy_config_files.md#policy-configuration-files)
+   [**Policy Configuration Files**](policy_config_files.md#policy-configuration-files)
    and should NOT be edited as together they describe the overall 'policy' configuration.
-3. [**Policy Configuration Files**](policy_config_files.md) used by an active
-   (run time) policy/system. Note that there can be multiple policy
-   configurations on a system (e.g. */etc/selinux/targeted* and
+3. [**Policy Configuration Files**](policy_config_files.md#policy-configuration-files)
+   used by an active (run time) policy/system. Note that there can be multiple
+   policy configurations on a system (e.g. */etc/selinux/targeted* and
    */etc/selinux/mls*), however only one can be the active policy.
-4. [**SELinux Filesystem files - Table 6: SELinux filesystem Information**](lsm_selinux.md#selinux-filesystem)
-   located under the */sys/fs/selinux* directory and reflect the current
+4. The [**SELinux Filesystem**](lsm_selinux.md#selinux-filesystem)
+   located under the */sys/fs/selinux* directory and reflects the current
    configuration of SELinux for the active policy. This area is used
    extensively by the libselinux library for userspace object managers and
    other SELinux-aware applications. These files and directories should not
diff --git a/src/implementing_seaware_apps.md b/src/implementing_seaware_apps.md
index ee38258..62e04d9 100644
--- a/src/implementing_seaware_apps.md
+++ b/src/implementing_seaware_apps.md
@@ -86,7 +86,8 @@ developing SELinux-aware applications and object managers using
     *libselinux* 2.0.99, with Linux kernel 2.6.37 and above.
 11. There are changes to the way contexts are computed for sockets in
     kernels 2.6.39 and above as described in the
-    [**Computing Security Contexts**](computing_security_contexts.md) section.
+    [**Computing Security Contexts**](computing_security_contexts.md#computing-security-contexts)
+    section.
     The functions affected by this are: ***avc_compute_create**(3)*,
     ***avc_compute_member**(3)*, ***security_compute_create**(3)*,
     ***security_compute_member**(3)* and
-- 
2.29.2

