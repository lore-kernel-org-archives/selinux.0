Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ACDC433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE582078D
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="c2KFFLLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgHZMhb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:37:31 -0400
Received: from mailomta29-re.btinternet.com ([213.120.69.122]:45434 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729775AbgHZMh2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 08:37:28 -0400
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20200826123725.HLBT4131.re-prd-fep-049.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Wed, 26 Aug 2020 13:37:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598445445; 
        bh=2w2N/egg6rC0An/IFHQ+6MyBIQQgtOsHrZrnzcoAe1o=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=c2KFFLLv9WnjNa4Mi499GvJGA5lk0Getlo4MDZ8BkRJWaHx/HVblsFC0+7VKp3i9nNUgCwSQJpJ5x+8zi+NggodZVyb241+qDK2u2iT1ZACvjzuysH5P0MJ/8wHhsY/Hhb+NGwWd9AankG+I1xpQNU/qwcA2O6v9w2bKMu2uNE9JkQDkOdqOzNBp1Evf4fmD0iM98ef+IeRHlpW+++CpWDL59Mr8tvGhTSEtyRDouW9+PLwZ0LfmhrF96MAumNWJDn8N9VFOmB9fkcGKtDSqcsg0tYKgsqVtKqjhfkbD36ae7+QbcwHhkn8Pgt+xKVgXexe9P10l3/aQwxWxyjVkTQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.155.83.250]
X-OWM-Source-IP: 86.155.83.250 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvvddgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepkeeirdduheehrdekfedrvdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirdduheehrdekfedrvdehtddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.155.83.250) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C5060DAF53A5; Wed, 26 Aug 2020 13:37:25 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/1] selinux-testsuite: Update SCTP asconf client/server
Date:   Wed, 26 Aug 2020 13:37:18 +0100
Message-Id: <20200826123719.26121-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As this patch updates asconf client/server to make them more reliable
for running the client and server on different systems, I will post RFC
patches 'selinux-testsuite: Run tests using remote server' to allow this
to be tested.

Richard Haines (1):
  selinux-testsuite: Update SCTP asconf client/server

 policy/test_sctp.te                    |  75 ++++-
 tests/sctp/.gitignore                  |   1 -
 tests/sctp/Makefile                    |   3 +-
 tests/sctp/sctp_asconf_params_client.c | 322 ++++++++-----------
 tests/sctp/sctp_asconf_params_server.c | 275 +++++++++-------
 tests/sctp/sctp_common.c               | 189 ++++++++++-
 tests/sctp/sctp_common.h               |  12 +-
 tests/sctp/sctp_peeloff_server.c       |  42 +--
 tests/sctp/sctp_server.c               |   4 +-
 tests/sctp/sctp_set_peer_addr.c        | 415 -------------------------
 tests/sctp/test                        |  70 ++++-
 11 files changed, 623 insertions(+), 785 deletions(-)
 delete mode 100644 tests/sctp/sctp_set_peer_addr.c

-- 
2.26.2

