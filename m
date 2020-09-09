Return-Path: <SRS0=qhvK=DJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53495C4363D
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 09:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D599B20679
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 09:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="J/Ee6O1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgJBJHu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Oct 2020 05:07:50 -0400
Received: from mailomta14-re.btinternet.com ([213.120.69.107]:17930 "EHLO
        re-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbgJBJHu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Oct 2020 05:07:50 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20200909133048.UPNO13627.re-prd-fep-042.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658248; 
        bh=fRoy7//t2hqJx2OAzFvyCb2o9dDs5ilPr2gtBBMgQKc=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=J/Ee6O1zYAtrCFDF47CjKzcwiAGCkIYQmH/c7cYoOYHsNh1+UVy9d/Kok4YX2LpO0mghDNS2QdKtEbGRWkYoFQFOSYACG7GjvZqjwMrsZE/zg1f1Pe/LTx+cG4kuOhtrut7BWn77LdZPC4CEY4oK/f0biz79ZieHm46yWBop2aQX/sr1WJFaFsQeGiBy67L53wynJix9pVd6HyCLTGyFjOs7sj+804CSBa9yvMiYmq2fjPPrGh7JnS7s358qO6deGofZWtNuhogWsozWwNOtj+arIxIseomK7hrLPQaTW/9oIw0Ukr8ZHcL8Z6dLE+heQAMY+zDpbuOGI1ujzj7/KQ==
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
        id 5ED9C2FD10134E2B; Wed, 9 Sep 2020 14:30:48 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 16/22] user_statements:: Tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:33 +0100
Message-Id: <20200909133039.44498-17-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/user_statements.md | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/user_statements.md b/src/user_statements.md
index 7a5ff8a..ee3eed1 100644
--- a/src/user_statements.md
+++ b/src/user_statements.md
@@ -70,7 +70,7 @@ Policy Type
 
 Conditional Policy Statements
 
-| *if* statement          | *optional* Statement    | *require* Statement     |
+| *if* Statement          | *optional* Statement    | *require* Statement     |
 | ----------------------- | ----------------------- | ----------------------- |
 | No                      | Yes                     | Yes                     |
 
@@ -116,9 +116,9 @@ semanage user -a -R unconfined_r mque_u
 ```
 
 This command will produce the following files in the default
-&lt;SELINUXTYPE&gt; policy store and then activate the policy:
+\<SELINUXTYPE\> policy store and then activate the policy:
 
-*/var/lib/selinux/&lt;SELINUXTYPE&gt;/active/users.local*:
+*/var/lib/selinux/\<SELINUXTYPE\>/active/users.local*:
 
 ```
 # This file is auto-generated by libsemanage
@@ -127,7 +127,7 @@ This command will produce the following files in the default
 user mque_u roles { unconfined_r } ;
 ```
 
-*/var/lib/selinux/&lt;SELINUXTYPE&gt;/active/users_extra*:
+*/var/lib/selinux/\<SELINUXTYPE\>/active/users_extra*:
 
 ```
 # This file is auto-generated by libsemanage
@@ -136,7 +136,7 @@ user mque_u roles { unconfined_r } ;
 user mque_u prefix user;
 ```
 
-*/var/lib/selinux/&lt;SELINUXTYPE&gt;/active/users_extra.local*:
+*/var/lib/selinux/\<SELINUXTYPE\>/active/users_extra.local*:
 
 ```
 # This file is auto-generated by libsemanage
-- 
2.26.2

