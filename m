Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768A0C433F5
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 08:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiDDIj4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 04:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiDDIjz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 04:39:55 -0400
Received: from sa-prd-fep-049.btinternet.com (mailomta30-sa.btinternet.com [213.120.69.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15DE3615E
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 01:37:59 -0700 (PDT)
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20220404083758.XZHM30507.sa-prd-fep-049.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Mon, 4 Apr 2022 09:37:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1649061478; 
        bh=WHYPhf2N/TGZV1ceRAI/tCFWTDG1z6G+fyCdhQQAsmY=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=DUG7DrgWbYwnDweLDcZIEKpDJVxV4+l2qHEX4X1w+rjE84CBXoguDops8t67sWumMP9Bt6xooWVC4stZgRfQvnXtgPvb7vp1yQ76FdBVXiVQepODxrLy5ZKtRMS5pzxhToPiVi9Cr2hGsoIx2Vc4f+UCa7XfsWRGbWCQsFm+QzDFSq8HVd6jpxx/TW7DGleYnOBwKKkOTIEv2BvFpY7IefKzjUUc2INCmbCj5J3jdZQPWUyx66m3eOZ6WIX9AVwxajO+ZkJADp6wyOPkWMu42rhCtJVskP5jNy4NO7q1JBPokgD5kFWdBuvue7b7qOmEsBCA3cNPXKXkIDzLa1Qwvg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613006A91EA547C5
X-Originating-IP: [109.158.127.88]
X-OWM-Source-IP: 109.158.127.88 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudejuddguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppedutdelrdduheekrdduvdejrdekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehkedruddvjedrkeekpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.158.127.88) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613006A91EA547C5; Mon, 4 Apr 2022 09:37:58 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH Notebook] Reference Policy: Module versioning now optional
Date:   Mon,  4 Apr 2022 09:37:46 +0100
Message-Id: <20220404083746.5929-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since Reference Policy release 2.20220106 the version_number argument
is optional. If missing '1' is set as a default to satisfy the policy
syntax.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/modular_policy_statements.md | 4 +++-
 src/reference_policy.md          | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/modular_policy_statements.md b/src/modular_policy_statements.md
index e62e6ac..c0caa62 100644
--- a/src/modular_policy_statements.md
+++ b/src/modular_policy_statements.md
@@ -35,7 +35,9 @@ The *module* name.
 *version_number*
 
 The module version number in M.m.m format (where M = major version number
-and m = minor version numbers).
+and m = minor version numbers). Since Reference Policy release 2.20220106
+the *version_number* argument is optional. If missing '1' is set as a default
+to satisfy the policy syntax.
 
 **The statement is valid in:**
 
diff --git a/src/reference_policy.md b/src/reference_policy.md
index ebb516f..f96949a 100644
--- a/src/reference_policy.md
+++ b/src/reference_policy.md
@@ -1820,7 +1820,9 @@ policy_module(module_name,version)
 *version_number*
 
 - The module version number in M.m.m format (where M = major version number
-  and m = minor version numbers).
+  and m = minor version numbers). Since release 2.20220106 the *version_number*
+  argument is optional. If missing '1' is set as a default to satisfy the
+  policy syntax.
 
 **The macro is valid in:**
 
-- 
2.35.1

