Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF3EC433E2
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 16:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B56520C09
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 16:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="cM8nIk3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIJQlf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:41:35 -0400
Received: from mailomta31-re.btinternet.com ([213.120.69.124]:32045 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726419AbgIJQkh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 12:40:37 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200909133055.TZNQ21348.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658255; 
        bh=87zVF68tcchdgBHEoPopuWruvFN/T/mHQmVwxz58igQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=cM8nIk3WAL3UwOm6ZCJ3IHGdU1Qt9hC0CPG/L2OK/sjpjlAqEk6SDnlMYNDBATmccYJs+HKDQgrIyeru8QGA2jfv+ifKb4Bluuk+GJeykqZf/bO5UfbVHfyErB7J1uPZd7kpCSGeDMcT4/Dw/ZeBkddUWKiS9Tc7mRvUsa/HpnMtJzmDTGUJHHVZmj7DKabxqsiSiWi1dum1VlamLL3Lahj93pWl5BZucQniPSfRxRMfqQEedAYPpKA5UqfJKOyWgGI8ruzF1mdScTFWcqS88I+ChiuYXqzEm8/6TkDu2jO9KMVYc5HZhtAVZVKMJ0t4px8vYU6UoX4mgq9vkH4uZw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgepudegnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirdduheegrdduheegrddufeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134F25; Wed, 9 Sep 2020 14:30:55 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 22/22] xperm_rules: Tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:39 +0100
Message-Id: <20200909133039.44498-23-richard_c_haines@btinternet.com>
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
 src/xperm_rules.md | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/src/xperm_rules.md b/src/xperm_rules.md
index 7f8744b..849b2ac 100644
--- a/src/xperm_rules.md
+++ b/src/xperm_rules.md
@@ -1,5 +1,7 @@
 # Extended Access Vector Rules
 
+- [*ioctl* Operation Rules](#ioctl-operation-rules)
+
 There are three extended AV rules implemented from Policy version 30
 with the target platform 'selinux' that expand the permission sets from
 a fixed 32 bits to permission sets in 256 bit increments: *allowxperm*,
@@ -66,7 +68,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | No                      | No                      |
 
@@ -80,7 +82,7 @@ policy format changes shown in the example below with a brief overview
 the final upstream kernel patch).
 
 Ioctl calls are generally used to get or set device options. Policy
-versions &lt; 30 only controls whether an *ioctl* permission is allowed
+versions \> 30 only controls whether an *ioctl* permission is allowed
 or not, for example this rule allows the object class *tcp_socket* the
 *ioctl* permission:
 
@@ -116,17 +118,17 @@ tclass=udp_socket permissive=0
 
 Notes:
 
-1.  Important: The ioctl operation is not 'deny all' ioctl requests
-    (hence whitelisting). It is targeted at the specific
-    source/target/class set of ioctl commands. As no other *allowxperm*
-    rules have been defined in the example, all other ioctl calls may
-    continue to use any valid request parameters (provided there are
-    *allow* rules for the *ioctl* permission).
-2.  As the ***ioctl**(2)* function requires a file descriptor, its
-    context must match the process context otherwise the *fd { use }*
-    class/permission is required.
-3.  To deny all ioctl requests for a specific source/target/class the
-    *xperm_set* should be set to *0* or *0x0*.
+1. Important: The ioctl operation is not 'deny all' ioctl requests
+   (hence whitelisting). It is targeted at the specific
+   source/target/class set of ioctl commands. As no other *allowxperm*
+   rules have been defined in the example, all other ioctl calls may
+   continue to use any valid request parameters (provided there are
+   *allow* rules for the *ioctl* permission).
+2. As the ***ioctl**(2)* function requires a file descriptor, its
+   context must match the process context otherwise the *fd { use }*
+   class/permission is required.
+3. To deny all ioctl requests for a specific source/target/class the
+   *xperm_set* should be set to *0* or *0x0*.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

