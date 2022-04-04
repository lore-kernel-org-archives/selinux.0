Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79367C433EF
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 09:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354009AbiDDJdY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 05:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbiDDJdY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 05:33:24 -0400
Received: from sa-prd-fep-041.btinternet.com (mailomta13-sa.btinternet.com [213.120.69.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E062522B2B
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 02:31:27 -0700 (PDT)
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20220404093126.KZG30965.sa-prd-fep-041.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Mon, 4 Apr 2022 10:31:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1649064686; 
        bh=6vWebTpp+gD/h1f/3qUmFSplii237ZLMH0+t88fmxzo=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=OPW1ldmYm2b+5j/jV56Z++jJ6XSFFa62BD3Yag5RWFwHHRKFKd4g37dnTpoSrxgJkGqcuFMRhoF6Ol1sD7Ahv/xszYasqCn79SHYqB6W/LLFl9DTRFivy27RAKGekh0O2kNxmYiOKf3Z0xjQn7iCs3c07gb6vkHhvwSD441u022KbpdR4UIraznd9dfIYlj02wQvZy8WgBk1hxzjxOutK1UeVSAG/4pJYvboyjnO8jyw7KORlHli3QH1J/ixTEmzKSs75yZMqqQ6337DUhwxFHrXc8MkNzjNO41EnJYWtzmdGDiKjnTxzwb/07Q9A/vwIlfWvhouyOBZDvxkHHgTBA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613943C61D95EBF6
X-Originating-IP: [109.158.127.88]
X-OWM-Source-IP: 109.158.127.88 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudejvddgudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeuudekheeiheekieegkeeiieeuhfelgeeuledvfedtheekfedvgeeggeekvdfhvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedutdelrdduheekrdduvdejrdekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehkedruddvjedrkeekpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.158.127.88) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613943C61D95EBF6; Mon, 4 Apr 2022 10:31:26 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH Notebook] checkreqprot is being deprecated
Date:   Mon,  4 Apr 2022 10:31:15 +0100
Message-Id: <20220404093115.6451-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This will be deprecated at some stage, with the default set to 0.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/lsm_selinux.md                | 8 +++++---
 src/object_classes_permissions.md | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/lsm_selinux.md b/src/lsm_selinux.md
index 560d89f..cb8189b 100644
--- a/src/lsm_selinux.md
+++ b/src/lsm_selinux.md
@@ -515,11 +515,13 @@ or *libsepol* library.
 
 *checkreqprot*
 
-- *0* = Check requested protection applied by kernel.
-  *1* = Check protection requested by application. This is the default.
+- *0* = Check protection applied by kernel (default since kernel v4.4).
+  *1* = Check protection requested by application.
   These apply to the *mmap* and *mprotect* kernel calls. Default value can
   be changed at boot time via the *checkreqprot=* parameter.
-  Requires *security { setcheckreqprot }* permission.
+  Requires *security { setcheckreqprot }* permission. Note *checkreqprot* will
+  be deprecated at some stage, with the default set to 0. See
+  <https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot>
 
 *commit_pending_bools*
 
diff --git a/src/object_classes_permissions.md b/src/object_classes_permissions.md
index 4ad8520..05a2a80 100644
--- a/src/object_classes_permissions.md
+++ b/src/object_classes_permissions.md
@@ -1956,7 +1956,7 @@ object (for the SELinux security server).
 
 - Change a boolean value within the active policy.
 
-*setcheckreqprot*
+*setcheckreqprot* (deprecated)
 
 - Set if SELinux will check original protection mode or modified protection
   mode (read-implies-exec) for *mmap* / *mprotect*.
-- 
2.35.1

