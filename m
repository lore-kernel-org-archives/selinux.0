Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D327C43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 20:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41A9214F1
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 20:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="k91IK/hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgIJUhZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:37:25 -0400
Received: from mailomta29-re.btinternet.com ([213.120.69.122]:37533 "EHLO
        re-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727095AbgIJUgs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 16:36:48 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20200909133047.XPYC4657.re-prd-fep-046.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658247; 
        bh=eduegantj3dfN2YFOqqp8bjctyeuMflYLW19ih1dtD4=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=k91IK/hb3KyIk3xX/hzyN+lK3FAM+esAKuTfiyNRfKI9tg1EdWbrbvXPKccGJPvWxNVYIn7MtYOlxKtol6ZIPGe/+UheVfCK6+UrLl70u7gDW8UqNHYPCCO/iCVP6PEf1WqUOE0gBLf4qoE+C75OlIv5SvWS+2qBL97Qcy2PQcVYF2cqUG/zOhoWbFw1360APpcFIMiQG+lHdwpOMr1vFk2mbR07V0hOt8GA2tJ4TYQnLrtaCFrA+vA3w71fSLS+1C3UrtceRjQ3u3sCDhWyjMIMHLdnCuWPfCyn6We6iAxVrYa1hjR/xeupnhnQgnLjIHzPUiOY0Vks329HXWqrbQ==
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
        id 5ED9C2FD10134DFF; Wed, 9 Sep 2020 14:30:47 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 13/22] type_enforcement: Convert to markdown
Date:   Wed,  9 Sep 2020 14:30:30 +0100
Message-Id: <20200909133039.44498-14-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/type_enforcement.md | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/type_enforcement.md b/src/type_enforcement.md
index d8d08be..bfd75b8 100644
--- a/src/type_enforcement.md
+++ b/src/type_enforcement.md
@@ -1,5 +1,8 @@
 # Type Enforcement
 
+- [Constraints](#constraints)
+- [Bounds](#bounds)
+
 SELinux makes use of a specific style of type enforcement (TE) to enforce
 mandatory access control. For SELinux it means that all
 [**subjects**](subjects.md#subjects) and [**objects**](objects.md#objects)
@@ -17,7 +20,7 @@ server, enforce policy via the object managers.
 Because the *type* identifier (or just 'type') is associated to all
 subjects and objects, it can sometimes be difficult to distinguish what
 the type is actually associated with (it's not helped by the fact that
-by convention, type identifiers end in *_t*). In the end it comes down
+by convention, type identifiers end in *\_t*). In the end it comes down
 to understanding how they are allocated in the policy itself and how
 they are used by SELinux services (although CIL policies with namespaces
 do help in that a domain process 'type' could be declared as
@@ -33,7 +36,7 @@ While SELinux refers to a subject as being an active process that is
 associated to a domain type, the scope of an SELinux type enforcement
 domain can vary widely. For example in the simple
 [**Kernel policy**](./notebook-examples/selinux-policy/kernel/kern-nb-policy.txt)
-in the notebook-examples, all the processes on the system run in the
+in the *notebook-examples*, all the processes on the system run in the
 *unconfined_t* domain, therefore every process is
 'of type *unconfined_t*' (that means it can do whatever it likes within
 the limits of the standard Linux DAC policy as all access is allowed by
@@ -49,7 +52,7 @@ where the majority of user space processes run under the *unconfined_t*
 domain.
 
 The SELinux type is the third component of a 'security context' and by
-convention SELinux types end in *_t*, however this is not enforced by
+convention SELinux types end in *\_t*, however this is not enforced by
 any SELinux service (i.e. it is only used to identify the type
 component), although as explained above CIL with namespaces does make
 identification of types easier.
-- 
2.26.2

