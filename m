Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683FAC43461
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 19:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E1B208E4
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 19:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="HX0jODTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgIOTt4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 15:49:56 -0400
Received: from mailomta6-sa.btinternet.com ([213.120.69.12]:62158 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727952AbgIOTtn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 15:49:43 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20200902131748.VNDJ4112.sa-prd-fep-045.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052668; 
        bh=CHJo7+Mp8hJaF/i7p8CvP20Ym0pqyO3Fl0dzhORi41Y=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=HX0jODTCVnCyZ16DzdzG2QKdgS/4YqtELGjpIGPhYZOfva6Xx2q3WXxNGDMMVmQ/Y1pJLkt4yz24ujIpSRp+SaoBXNQNzNZuHbT3nW0w8B1tixLiU0YOYBlLwZG4FryEVmtR1oThpCIavdgJHGrrogpngxaWCua7BNNcvSMxrEfoQqeayjXv6CwHOpvgbwF+pdlzAUQrIBFfQ3gg1CvIb4TN25lidrd8wT5aQ9DjRwcgr8E+VntbVkDG68S+tGnSfpT6/98axdbMS63iQAq6++MoDf7BFtti0kdjstqQKGvgjMR+T+T1HffzczycVSZvxUSkq2jplDdU7o49WjS69g==
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
        id 5ED9AFBE0EF36BFB; Wed, 2 Sep 2020 14:17:48 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 12/13] rbac: Minor format fix
Date:   Wed,  2 Sep 2020 14:17:37 +0100
Message-Id: <20200902131738.18425-13-richard_c_haines@btinternet.com>
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
 src/rbac.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rbac.md b/src/rbac.md
index 4063e38..0cf4c22 100644
--- a/src/rbac.md
+++ b/src/rbac.md
@@ -6,7 +6,7 @@ associated to one or more roles, where each role is then associated to
 one or more domain types as shown in **Figure 4: Role Based Access Control**.
 
 The SELinux role name is the second component of a 'security context'
-and by convention SELinux roles end in *_r*, however this is not
+and by convention SELinux roles end in *\_r*, however this is not
 enforced by any SELinux service (i.e. it is only used to identify the
 role component), although CIL with namespaces does make identification
 of a role easier for example a 'role' could be declared as
-- 
2.26.2

