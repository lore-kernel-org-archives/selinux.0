Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A13C2D0A3
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 16:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB7D206DB
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 16:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Al4o8h+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgKDQtS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:49:18 -0500
Received: from mailomta13-sa.btinternet.com ([213.120.69.19]:31390 "EHLO
        sa-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730154AbgKDQtS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 11:49:18 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-046.btinternet.com with ESMTP
          id <20201104164916.QTTE28150.sa-prd-fep-046.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 4 Nov 2020 16:49:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1604508556; 
        bh=pHGEt1hcFpaSxXtsa1JdLUyyhIfgp/dQ6cd6G2917yE=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Al4o8h+uSo6qPrt4PWFst8vCb1JGqAI7gthDlVQnfzPexIeAr0bVNAaJnV30ie17cmm8qHFwhP0faCxK1wg0Xj0C9BTSjtb6ABqSKmnBXS5JYXoa5b1TO7AMnCYc1LWDwCRZ8uaOctlXRQpt9UFuWIbSIJU6yNQtp2PBWWk0RMG5jpAKS+vwbNbYucF0dTUDaKqPkcdDpd1DwreK52tOYV8X/fRqAGOuKdo+byNHYx4bet40wuj39dtmiY8abh9dK2i4nqU9CUOGNaM/TJ5qD+VCPzf6Eg7Hz6UJfnx6Jax1pdM/NdDK8af01jsikKcp7sKlLYuZ3PpMHYbvrUF8kA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9B8A7190E1F5E
X-Originating-IP: [213.122.112.63]
X-OWM-Source-IP: 213.122.112.63 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepvddufedruddvvddrudduvddrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedvudefrdduvddvrdduuddvrdeifedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (213.122.112.63) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A7190E1F5E; Wed, 4 Nov 2020 16:49:16 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1] selinux-testsuite: Reduce sctp test runtime
Date:   Wed,  4 Nov 2020 16:49:12 +0000
Message-Id: <20201104164913.11536-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch uses the audit system to detect AVC events and if detected exit
the test with the specified exit code.

This speeds up the sctp tests as the clients do not have to hang around for
the socket call to timeout.

There are some notes in sctp_common.c on the process.
Using './test -v' will show the audit entries captured and any triggers.

Without this patch sctp tests take ~2.6 min, with patch ~4 secs.

If acceptable I could do the same with the inet_socket tests.

Richard Haines (1):
  selinux-testsuite: Reduce sctp test runtime

 README.md                              |  5 +-
 policy/test_sctp.te                    |  1 +
 tests/sctp/Makefile                    |  2 +-
 tests/sctp/sctp_asconf_params_client.c | 51 ++++++++++++-
 tests/sctp/sctp_client.c               | 52 ++++++++++++--
 tests/sctp/sctp_common.c               | 99 ++++++++++++++++++++++++++
 tests/sctp/sctp_common.h               | 11 +++
 tests/sctp/test                        | 50 ++++++-------
 travis-ci/run-testsuite.sh             |  1 +
 9 files changed, 237 insertions(+), 35 deletions(-)

-- 
2.28.0

