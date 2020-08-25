Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AC4C433E3
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D312071E
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="L9oh5Ir0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgHYIiY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:24 -0400
Received: from mailomta5-sa.btinternet.com ([213.120.69.11]:37035 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728115AbgHYIiQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:16 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200825083809.GKOE3440.sa-prd-fep-044.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344689; 
        bh=dr9T7/JLpH7J3P0mRfUWnisH5zS+69UMofuRGXGw9aA=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=L9oh5Ir0o9yGq8Ls3opfLi2beIYOlH503B+ByYrEKK/+PnFENm/AShj6Mjzt9sUBUFBEk2n9kYGeX8hasSbVlGDU95Gf+cUIix9Ryk65tkvETpWMJBfFdFc8sBwwTN7Wag4Lwd7hrx+1IsilpJxlK4E2yVH8o2yfTc4AmZahzfQSdf8Xo+1toMHVqq7rqucoVvdOjaXpo43abH+nR3A74yVbPBWTu4lOPgiA93eoSKVu5vrErAeOEeXMM686vx/SI/sYXF4Q+JyuyI0P3l1daMW9gQ0+qX0G1IhG+8SaaUA6eVI4rCT3glkFMTjfsSuVW5zCRlUjOylU6gUxvgmrfA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepuddtledrudehhedrudeftddrudeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrudeftddrudeitddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599DB6; Tue, 25 Aug 2020 09:38:09 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 07/18] computing_access_decisions: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:32 +0100
Message-Id: <20200825083743.6508-8-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert to markdown

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/computing_access_decisions.md | 82 ++++++++++++++-----------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/src/computing_access_decisions.md b/src/computing_access_decisions.md
index 5ab9430..0ab1092 100644
--- a/src/computing_access_decisions.md
+++ b/src/computing_access_decisions.md
@@ -3,50 +3,44 @@
 There are a number of ways to compute access decisions within userspace
 SELinux-aware applications or object managers:
 
-1.  Use of the ***selinux_check_access**(3)* function is the
-    recommended option. This utilises the AVC services discussed in
-    bullet 3 in a single call that:
-
--   Dynamically resolves class and permissions strings to their
-    class/permission values using ***string_to_security_class**(3)*
-    and ***string_to_av_perm**(3)* with
-    ***security_deny_unknown**(3)* to handle unknown
-    classes/permissions.
--   Uses ***avc_has_perm**(3)* to check whether the decision is cached
-    before calling ***security_compute_av_flags**(3)* (and caching
-    the result), checks enforcing mode (both global and per-domain
-    (permissive)), and logs any denials (there is also an option to add
-    supplemental auditing information that is handled as described in
-    ***avc_audit**(3)*.
-
-2.  Use functions that do not cache access decisions (i.e. they do not
-    use the *libselinux* AVC services). These require a call to the
-    kernel for every decision using ***security_compute_av**(3)* or
-    ***security_compute_av_flags**(3)*. The ***avc_netlink_\***(3)*
-    functions can be used to detect policy change events. Auditing would
-    need to be implemented if required.
-
-3.  Use functions that utilise the *libselinux* userspace AVC services
-    that are initialised with ***avc_open**(3)*. These can be built in
-    various configurations such as:
-
--   Using the default single threaded mode where ***avc_has_perm**(3)*
-    will automatically cache entries, audit the decision and manage
-    the handling of policy change events.
-
--   Implementing threads or a similar service that will handle policy
-    change events and auditing in real time with
-    ***avc_has_perm**(3)* or ***avc_has_perm_noaudit**(3)*
-    handling decisions and caching. This has the advantage of better
-    performance, which can be further increased by caching the entry
-    reference.
-
-4.  Implement custom caching services with
-    ***security_compute_av**(3)* or
-    ***security_compute_av_flags**(3)* for computing access
-    decisions. The ***avc_netlink_\***(3)* functions can then be used to
-    detect policy change events. Auditing would need to be implemented
-    if required.
+1. Use of the ***selinux_check_access**(3)* function is the
+   recommended option. This utilises the AVC services discussed in
+   bullet 3 in a single call that:
+   - Dynamically resolves class and permissions strings to their
+     class/permission values using ***string_to_security_class**(3)*
+     and ***string_to_av_perm**(3)* with
+     ***security_deny_unknown**(3)* to handle unknown
+     classes/permissions.
+   - Uses ***avc_has_perm**(3)* to check whether the decision is cached
+     before calling ***security_compute_av_flags**(3)* (and caching
+     the result), checks enforcing mode (both global and per-domain
+     (permissive)), and logs any denials (there is also an option to add
+     supplemental auditing information that is handled as described in
+     ***avc_audit**(3)*.
+2. Use functions that do not cache access decisions (i.e. they do not
+   use the *libselinux* AVC services). These require a call to the
+   kernel for every decision using ***security_compute_av**(3)* or
+   ***security_compute_av_flags**(3)*. The ***avc_netlink_\***(3)*
+   functions can be used to detect policy change events. Auditing would
+   need to be implemented if required.
+3. Use functions that utilise the *libselinux* userspace AVC services
+   that are initialised with ***avc_open**(3)*. These can be built in
+   various configurations such as:
+   - Using the default single threaded mode where ***avc_has_perm**(3)*
+     will automatically cache entries, audit the decision and manage
+     the handling of policy change events.
+   - Implementing threads or a similar service that will handle policy
+     change events and auditing in real time with
+     ***avc_has_perm**(3)* or ***avc_has_perm_noaudit**(3)*
+     handling decisions and caching. This has the advantage of better
+     performance, which can be further increased by caching the entry
+     reference.
+4. Implement custom caching services with
+   ***security_compute_av**(3)* or
+   ***security_compute_av_flags**(3)* for computing access
+   decisions. The ***avc_netlink_\***(3)* functions can then be used to
+   detect policy change events. Auditing would need to be implemented
+   if required.
 
 Where performance is important when making policy decisions, then the
 ***selinux_status_open**(3)*, ***selinux_status_updated**(3)*,
-- 
2.26.2

