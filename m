Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8163FC43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20D82078B
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="O5DtZ/Cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgIJIqf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:46:35 -0400
Received: from mailomta24-re.btinternet.com ([213.120.69.117]:37014 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730278AbgIJIqR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 04:46:17 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200909133047.TZMY21348.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658247; 
        bh=pzha7khpJL4E/90/eTKgAikz1W8y43PtnuK4ih7Hk5w=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=O5DtZ/ClSbfhWJmlg6P/OatA4qMyci+Wp28v6EGcjidV8CYru4lQb1DlGqHodvVnjkUdiaF+5SOxKXLPiY+gVgOfjuzKxmFBb9J/6hSRbj9xtQ+WqzgB6OLif+FuVJk7qKbjs+xXSmiuODhAbnDvpQn2J4rWJ9vMRopa+g1+wy7wCFvJ/wg2+WILiCJ8VaSAobIRe5l5CLAY8mJQgS2afDK+XJaPci1AbyEFkPkKzrJh9vW1HHB723w7UOyoMWt5Cb2LLGDp76ZXUPavrDHBZaiaJnaG7b7oGwo4XxQP2OaoXAxKX+EN2wZLCF3MGKzXwinKByqvCAmF/g3zIJi5Fw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepgfekgffghffgleekgfellefftedvhfejveehhfekkefgvdehueetgfffffelkedtnecukfhppeekiedrudehgedrudehgedrudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirdduheegrdduheegrddufeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134DEE; Wed, 9 Sep 2020 14:30:46 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 11/22] subjects: Convert to markdown
Date:   Wed,  9 Sep 2020 14:30:28 +0100
Message-Id: <20200909133039.44498-12-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/subjects.md | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/src/subjects.md b/src/subjects.md
index 4f677cb..bc7a89a 100644
--- a/src/subjects.md
+++ b/src/subjects.md
@@ -9,13 +9,13 @@ Within SELinux a subject is an active process and has a
 it, however a process can also be referred to as an object depending on the
 context in which it is being taken, for example:
 
-1.  A running process (i.e. an active entity) is a subject because it
-    causes information to flow among objects or can change the system
-    state.
-2.  The process can also be referred to as an object because each
-    process has an associated object class<a href="#fns1" class="footnote-ref" id="fnsub1"><strong><sup>1</sup></strong></a>
-    called '**process**'. This process 'object', defines what permissions the
-    policy is allowed to grant or deny on the active process.
+1. A running process (i.e. an active entity) is a subject because it
+   causes information to flow among objects or can change the system
+   state.
+2. The process can also be referred to as an object because each
+   process has an associated object class[^fn_sub_1]
+   called ***process***. This process 'object', defines what permissions the
+   policy is allowed to grant or deny on the active process.
 
 An example is given of the above scenarios in the
 [**Allowing a Process Access to Resources**](objects.md#allowing-a-process-access-to-resources)
@@ -37,11 +37,8 @@ under *semanage_t*).
 
 **Untrusted** - Everything else.
 
-<section class="footnotes">
-<ol>
-<li id="fns1"><p>The object class and its associated permissions are explained in the <strong><a href="object_classes_permissions.md#process-object-class"> Appendix A - Object Classes and Permissions - Process Object Class</a></strong> section.<a href="#fnsub1" class="footnote-back">↩</a></p></li>
-</ol>
-</section>
+[^fn_sub_1]: The object class and its associated permissions are explained in
+[**Appendix A - Object Classes and Permissions - Process Object Class**](object_classes_permissions.md#process-object-class)
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

