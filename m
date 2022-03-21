Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A86BC4167D
	for <selinux@archiver.kernel.org>; Mon, 21 Mar 2022 11:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346942AbiCULxT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347005AbiCULxB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Mar 2022 07:53:01 -0400
X-Greylist: delayed 3508 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 04:51:36 PDT
Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E301557FF
        for <selinux@vger.kernel.org>; Mon, 21 Mar 2022 04:51:36 -0700 (PDT)
Received: from brutus.. (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id AC295FC0729;
        Mon, 21 Mar 2022 12:51:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1647863494;
        bh=ZVHQrjv1Iv4tMaENDO+7fldMIEaNuO9EQ6urtcu1E+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpwFXo9bUKiAovu3drS986w4FY/PGW6PTKZfuCU/LTI5HQTqH8hxBRxI/mYHcFBWp
         NOlcINk8hLStoRb+LFDjqhXzHwJxSQHKe0zbVjx/20nY0FPnjEUt4CzqrIffF+rMSA
         f3cLzEVuu5i4w+Frz6x0g3XfM/s/tXCq9MMQEDxg=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH v2] optional statement is not valid in if and require statement
Date:   Mon, 21 Mar 2022 12:50:54 +0100
Message-Id: <20220321115054.150336-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321105250.148231-1-dominick.grift@defensec.nl>
References: <20220321105250.148231-1-dominick.grift@defensec.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

the conditional-policy-statements chapter describes which statements
are allowed in if statements and optional is not one of them

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
v2: adjusts kernel_policy_language.md as well

 src/kernel_policy_language.md    | 2 +-
 src/modular_policy_statements.md | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/kernel_policy_language.md b/src/kernel_policy_language.md
index b7b72ce..4f01609 100644
--- a/src/kernel_policy_language.md
+++ b/src/kernel_policy_language.md
@@ -262,7 +262,7 @@ within an *if/else* construct, *optional {rule_list}*, or
 | *neverallow*     |        Yes        |      Yes    |Yes [^fn_kpl_3]|          No            |         Yes        |        No         |
 | *neverallowxperm*|        Yes        |      Yes    |      Yes      |          No            |         No         |        No         |
 | *nodecon*        |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
-| *optional*       |        No         |      Yes    |      Yes      |          Yes           |         Yes        |        Yes        |
+| *optional*       |        No         |      Yes    |      Yes      |          No            |         Yes        |        No         |
 | *permissive*     |        Yes        |      Yes    |      Yes      |          Yes           |         Yes        |        No         |
 | *policycap*      |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
 | *portcon*        |        Yes        |      Yes    |      No       |          No            |         No         |        No         |
diff --git a/src/modular_policy_statements.md b/src/modular_policy_statements.md
index e62e6ac..508d531 100644
--- a/src/modular_policy_statements.md
+++ b/src/modular_policy_statements.md
@@ -190,7 +190,7 @@ Conditional Policy Statements
 
 | *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
-| Yes                     | Yes                     | Yes                     |
+| No                      | Yes                     | No                      |
 
 **Examples:**
 
-- 
2.35.1

