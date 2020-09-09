Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BA0C433E7
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 01:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1B72074F
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 01:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="S0dQwLx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgJLBNf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 11 Oct 2020 21:13:35 -0400
Received: from mailomta24-re.btinternet.com ([213.120.69.117]:38829 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727132AbgJLBNf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 11 Oct 2020 21:13:35 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20200909133048.EKJM29506.re-prd-fep-043.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658248; 
        bh=ESdkPYZawKdw2LQrnbogIWp3PGnFWR4KxIhcw3/xNFo=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=S0dQwLx7QvKHW3CkzP/NN0qixLRJFggGK2EGAxutU6yhPgACB6QvdWfbFn3AzRcr5nwVsKlqJU5GEy2D55djeqt3dkWco14uE4utfpnGv7EX9HVxuyd285jV4vL0yDd25UgaS/qzCAw+oqUm/TcFgkBwGakxX7nkwCcbzVuP4UJOu8nqMiTzfiDi8Vf9mx2+oFp5jO0wTIyWecmeR753QOiKEGYMBZnlqlUk/dG4AsOt48C61ldX93ONxQ/WLABUs6oa8vmpjfbna6YriwHzNXMFnV/v88JqnAK2HIyAyvFqVVslA0dfdueQ3LWNNqUHtpkVs0RCRrKT44a1T+8opQ==
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
        id 5ED9C2FD10134E2F; Wed, 9 Sep 2020 14:30:48 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 17/22] users: Tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:34 +0100
Message-Id: <20200909133039.44498-18-richard_c_haines@btinternet.com>
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
 src/users.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/users.md b/src/users.md
index a1a86b1..4be8356 100644
--- a/src/users.md
+++ b/src/users.md
@@ -13,7 +13,7 @@ objects, this user is *system_u*.
 
 The SELinux user name is the first component of a
 [**Security Context**](security_context.md#security-context) and
-by convention SELinux user names end in *_u*, however this is not
+by convention SELinux user names end in *\_u*, however this is not
 enforced by any SELinux service (i.e. it is only to identify the user
 component), although CIL with namespaces does make identification of an
 SELinux user easier for example a 'user' could be declared as
-- 
2.26.2

