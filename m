Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E9DC433F5
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 09:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353794AbiDDJbK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353996AbiDDJbJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 05:31:09 -0400
Received: from re-prd-fep-049.btinternet.com (mailomta17-re.btinternet.com [213.120.69.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E0821E1F
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 02:29:12 -0700 (PDT)
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20220404092910.JPXV31284.re-prd-fep-049.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Mon, 4 Apr 2022 10:29:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1649064550; 
        bh=5XUoYTrdWHM/UMUwrD47tMPEArLzmtwv+e3kGWTtcls=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=gbfjdopslxaMtvl+iQ09MwaRL/JmDB7Qzw8I+VDbF57251rmCLZVwrJqcSNoh46BkL0JyGGf72DIuNBWLmqmkI7tgrB7Pmt/40fsTNV2hgwBNlwhTZq1xBLbPWfuOgrlEagsN48FnHLjRwxmy2TCd78s3/I5slMiEkJiNrKu4R9n0lWuOy9jzaPH3NH0yrGEzduptTtlFTuzqZ+sTWQ20N7C45Cqp5ls42Y0BGdpR8uBZ4T8ZWWs+XOmqrPuV7yJaAImQi/1r2ZZcIvtidCrZzP3Y6trQ9iAEwM5KHLPm8fcea3a4IxKzSSseFgjBeEChyY+OP8M9sPo3hVhtUlP+w==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A8DE81CB32C5A
X-Originating-IP: [109.158.127.88]
X-OWM-Source-IP: 109.158.127.88 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudejvddgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeuudekheeiheekieegkeeiieeuhfelgeeuledvfedtheekfedvgeeggeekvdfhvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedutdelrdduheekrdduvdejrdekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehkedruddvjedrkeekpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.158.127.88) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A8DE81CB32C5A; Mon, 4 Apr 2022 10:29:10 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH Notebook] SELINUX=disabled is being deprecated
Date:   Mon,  4 Apr 2022 10:29:00 +0100
Message-Id: <20220404092900.6400-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The existing kernel command line switch selinux=0, which allows users to
disable SELinux at system boot should be used instead.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/core_components.md     | 6 +++++-
 src/embedded_systems.md    | 6 ++++++
 src/global_config_files.md | 5 +++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/core_components.md b/src/core_components.md
index eeb1945..17c4d66 100644
--- a/src/core_components.md
+++ b/src/core_components.md
@@ -126,7 +126,11 @@ in the audit log. SELinux can also be disabled (at boot time only) by
 setting *SELINUX=disabled*. There is also support for the
 [***permissive***](type_statements.md#permissive) statement that allows a
 domain to run in permissive mode while the others are still confined
-(instead of all or nothing set by *SELINUX=*).
+(instead of all or nothing set by *SELINUX=*). Note setting *SELINUX=disabled*
+will be deprecated at some stage, in favor of the existing kernel command line
+switch *selinux=0*, which allows users to disable SELinux at system boot. See
+<https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable>
+that explains how to achieve this on various Linux distributions.
 
 <!-- %CUTHERE% -->
 
diff --git a/src/embedded_systems.md b/src/embedded_systems.md
index 75821fe..9661649 100644
--- a/src/embedded_systems.md
+++ b/src/embedded_systems.md
@@ -244,6 +244,12 @@ SELINUX=enforcing
 SELINUXTYPE=targeted
 ```
 
+Note setting *SELINUX=disabled* will be deprecated at some stage, in favor of
+the existing kernel command line switch *selinux=0*, which allows users to
+disable SELinux at system boot. See
+<https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable>
+that explains how to achieve this on various Linux distributions.
+
 The standard Linux SELinux policy load sequence is as follows:
 
 - Obtain policy version supported by the kernel.
diff --git a/src/global_config_files.md b/src/global_config_files.md
index 7c8132d..1dcdfeb 100644
--- a/src/global_config_files.md
+++ b/src/global_config_files.md
@@ -46,6 +46,11 @@ This entry can contain one of three values:
   the global SELinux enforcement mode. It is still possible to have domains
   running in permissive mode and/or object managers running as disabled,
   permissive or enforcing, when the global mode is enforcing or permissive.
+  Note setting *SELINUX=disabled* will be deprecated at some stage, in favor of
+  the existing kernel command line switch *selinux=0*, which allows users to
+  disable SELinux at system boot. See
+  <https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable>
+  that explains how to achieve this on various Linux distributions.
 
 *SELINUXTYPE*
 
-- 
2.35.1

