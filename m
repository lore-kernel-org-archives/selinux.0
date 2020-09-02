Return-Path: <SRS0=5TeY=CW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA2FC433E2
	for <selinux@archiver.kernel.org>; Sun, 13 Sep 2020 21:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5031C21BE5
	for <selinux@archiver.kernel.org>; Sun, 13 Sep 2020 21:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="iBouZVpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgIMV7w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 13 Sep 2020 17:59:52 -0400
Received: from mailomta12-sa.btinternet.com ([213.120.69.18]:27904 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbgIMV7v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 13 Sep 2020 17:59:51 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200902131744.PPI4139.sa-prd-fep-048.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052664; 
        bh=sfiuhwBUJQVlhXbUwLOWJd+LDRIe8+TqXRPJzyYbaaM=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=iBouZVpYgCr8IrWyVab8ZyuQ9ti6kOgO/sOMUtwuYALISiyvnhRx3af57DOIbh9z5i+xS3RpLLPIR1oJO+zq3A5JsVMVLQJu8LLg8DrBNoEeO1NKiWlItB2C4LvRo+uN96J4cbCcIoch8/vcDKjHstjl3k1Datd6GmjC9agU2nKOph+UP1m+wUaFNO3VWudmgJuPNv7R4w0AVBpptZmpRt0N7DFjsU9wlT93s6Ooks1mctIpc1TMbETbnrFkYu9b6qw/6X11zkr+akW0ZgUJ1I40ZqNVMV4nGra1HgBXPTFdkfA+Dd1y146gj2DMMpPpFQ9xLCGIA8hHK8/aOXWiIg==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.32.197]
X-OWM-Source-IP: 109.155.32.197 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepuddtledrudehhedrfedvrdduleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrdefvddrudeljedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.197) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0EF36B74; Wed, 2 Sep 2020 14:17:44 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 02/13] mac: Tidy formatting
Date:   Wed,  2 Sep 2020 14:17:27 +0100
Message-Id: <20200902131738.18425-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/mac.md | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/src/mac.md b/src/mac.md
index 7b88c24..7f673fe 100644
--- a/src/mac.md
+++ b/src/mac.md
@@ -9,13 +9,13 @@ Each of the subjects and objects have a set of security attributes that
 can be interrogated by the operating system to check if the requested
 operation can be performed or not. For SELinux the:
 
--   [**subjects**](subjects.md#subjects) are processes.
--   [**objects**](objects.md#objects) are system resources such as files,
-    sockets, etc.
--   security attributes are the [**security context**](security_context.md#security-context).
--   Security Server within the Linux kernel authorizes access (or not)
-    using the security policy (or policy) that describes rules that must
-    be enforced.
+- [**subjects**](subjects.md#subjects) are processes.
+- [**objects**](objects.md#objects) are system resources such as files,
+  sockets, etc.
+- security attributes are the [**security context**](security_context.md#security-context).
+- Security Server within the Linux kernel authorizes access (or not)
+  using the security policy (or policy) that describes rules that must
+  be enforced.
 
 Note that the subject (and therefore the user) cannot decide to bypass
 the policy rules being enforced by the MAC policy with SELinux enabled.
@@ -35,8 +35,8 @@ SELinux supports two forms of MAC:
 objects are controlled by policy. This is the implementation used for
 general purpose MAC within SELinux along with Role Based Access Control.
 The [**Type Enforcement (TE)**](type_enforcement.md#type-enforcement) and
-[**Role Based Access Control**](rbac.md#role-based-access-control) sections covers
-these in more detail.
+[**Role Based Access Control**](rbac.md#role-based-access-control) sections
+covers these in more detail.
 
 **Multi-Level Security** - This is an implementation based on the
 Bell-La Padula (BLP) model, and used by organizations where different
@@ -51,14 +51,14 @@ Multi-Category Security (MCS).
 The MLS / MCS services are now more generally used to maintain
 application separation, for example SELinux enabled:
 
--   virtual machines use MCS categories to allow each VM to run within
-    its own domain to isolate VMs from each other (see the
-    [**SELinux Virtual Machine Support**](vm_support.md#selinux-virtual-machine-support)
-    section).
--   Android devices use dynamically generated MCS categories so that an
-    app running on behalf of one user cannot read or write files created
-    by the same app running on behalf of another user (see the
-    [**Security Enhancements for Android - Computing a Context**](seandroid.md#computing-process-context-examples) section).
+- virtual machines use MCS categories to allow each VM to run within
+  its own domain to isolate VMs from each other (see the
+  [**SELinux Virtual Machine Support**](vm_support.md#selinux-virtual-machine-support)
+  section).
+- Android devices use dynamically generated MCS categories so that an
+  app running on behalf of one user cannot read or write files created
+  by the same app running on behalf of another user (see the
+  [**Security Enhancements for Android - Computing a Context**](seandroid.md#computing-process-context-examples) section).
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

