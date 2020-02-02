Return-Path: <SRS0=qlmh=3W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FA2C35249
	for <selinux@archiver.kernel.org>; Sun,  2 Feb 2020 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA6C20679
	for <selinux@archiver.kernel.org>; Sun,  2 Feb 2020 19:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="KU3k81xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBBTfN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Feb 2020 14:35:13 -0500
Received: from mailomta18-sa.btinternet.com ([213.120.69.24]:11786 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgBBTfN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Feb 2020 14:35:13 -0500
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200202193510.PIVO7916.sa-prd-fep-048.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sun, 2 Feb 2020 19:35:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580672110; 
        bh=UXzd2ISOpfZafJkY4GHue7PZ0dSNbZz2zR8gPT+VYgU=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=KU3k81xgbzkVC2O/f4ZbZK3r2TJwI3f0FnC18A2LZgFFWMlXbSDqgPfketDFRWK3mSlgdvcNCkyRTL/GfoHM1yDTvF5RI2dNhwT727I48c3ogXav2s0Q6Ew3Mvj4VlsjlTdVqZEm+LQwjOAac9NzAx7qG7+yNVt/zNOBg1aosrBcMCIWD3zuruMAzIeLy9nlGcgKPGfR/Tra6x2LR4B4DbDsE2RMugDB8j9eJCLCpUkiTxmxnX6ZZRcUc0SlY81ZmCSbG1XCs3No7B2hNLiRJxkwUl2eb7hc8Hiag3Vbbah3/N1EJ/5QFB60p10llxzq2xWHbIV9JMLoiQTYTGvTFg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.56.38]
X-OWM-Source-IP: 31.49.56.38 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrgeehgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeefuddrgeelrdehiedrfeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehiedrfeekpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoughhohifvghllhhssehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.56.38) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5E1A3066036A668A; Sun, 2 Feb 2020 19:35:10 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     dhowells@redhat.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1] selinux-testsuite: Add additional key permission tests
Date:   Sun,  2 Feb 2020 19:35:07 +0000
Message-Id: <20200202193508.15056-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch allows the new key permissions to be tested as discussed in [1].

To test:
1) Build and install kernel from [2].

2) Run the selinux-testsuite to check ok.

3) Update selinux-testsuite with this patch.

4) Update libsepol with: libsepol-Add-key_perms-policy-capability.patch

5) Add the following CIL statements to test_keys.cil and install:
semodule -i test_keys.cil

(policycap key_perms) ; comment out to test original permission translation
(common key (inval revoke join clear))
(classcommon key key)

6) Edit /usr/share/selinux/devel/include/support/all_perms.spt
   and insert the 'inval revoke join clear' permissions:

define(`all_key_perms',`{ view read write ...}')

7) Run 'make test'

[1] https://lore.kernel.org/selinux/459818a9ad1c808298bf3d7c9bcb130323d30e97.camel@btinternet.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=keys-next

Richard Haines (1):
  selinux-testsuite: Add additional key permission tests

 policy/test_keys.te          | 139 ++++++++++++++++++++++++++++-------
 tests/keys/keyctl.c          |  39 ++++++++++
 tests/keys/keyring_service.c |  12 ++-
 tests/keys/request_keys.c    |  70 ++++++++++++++----
 tests/keys/test              |  63 ++++++++++++++--
 5 files changed, 273 insertions(+), 50 deletions(-)

-- 
2.24.1

