Return-Path: <SRS0=g6d+=UX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A36C43613
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 18:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FF320645
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 18:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="NFFGVQfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfFXSZm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:25:42 -0400
Received: from rgout0104.bt.lon5.cpcloud.co.uk ([65.20.0.124]:56339 "EHLO
        rgout01.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbfFXSZm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 14:25:42 -0400
X-OWM-Source-IP: 86.147.202.200 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddruddvgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudegjedrvddtvddrvddttdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtvddrvddttddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddruddvgdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudegjedrvddtvddrvddttdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtvddrvddttddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddruddvgdduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudegjedrvddtvddrvddttdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtvddrvddttddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
Received: from localhost.localdomain (86.147.202.200) by rgout01.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5CFA38CA01A5FB8C; Mon, 24 Jun 2019 19:01:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1561400742; 
        bh=C2MVK5/9QkEyUaDYjtRuRY95u9d35jLLi3B/FeRJAe0=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=NFFGVQfwwwBPHC9pOBPcnaExMxdxAIZdC2rE0sZTj6Gq/zL/LQrcFGFrjD/XDvJFVKTyFZ3NGFMZ3m2msKN0hAMZQPL76Heoj718IlFpVMnbXCDA+WpjLnrLNYcAleLk38nl+DkAKbB4ctpul++273XtlMs7G9EN8xjdJV94dvs=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V3 0/2] selinux: Remove legacy local boolean and user code
Date:   Mon, 24 Jun 2019 19:02:27 +0100
Message-Id: <20190624180229.9573-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I've removed the legacy code as discussed and seems to work okay when
loading policy on Fedora 30 & Rawhide (they both boot as well).
Note: I cannot test any other releases.

Tested downgrading policy to 24 okay using load_policy(8).

V2 Changes:
Updated as requested in [1].
Add manpages.
V3 Change:
Fix deprecated_funcs.c WARN() messages in Patch 1.

[1] https://lore.kernel.org/selinux/18e772cde0ed8f4d83752a9957ad2a3a11ecad8c.camel@btinternet.com/

Richard Haines (2):
  selinux: Remove legacy local boolean and user code
  selinux: Update manpages after removing legacy boolean and user code

 libselinux/include/selinux/selinux.h          |  18 +-
 libselinux/man/man3/security_load_booleans.3  |  12 +-
 .../man/man3/selinux_binary_policy_path.3     |   7 +-
 libselinux/man/man3/selinux_booleans_path.3   |   1 -
 libselinux/man/man5/booleans.5                |  80 ----
 libselinux/man/man5/local.users.5             |  68 ----
 libselinux/man/ru/man5/booleans.5             |  83 -----
 libselinux/man/ru/man5/local.users.5          |  72 ----
 libselinux/src/booleans.c                     | 225 +-----------
 libselinux/src/file_path_suffixes.h           |   2 +
 libselinux/src/load_policy.c                  | 100 +----
 libselinux/src/selinux_config.c               |   9 +-
 libselinux/src/selinux_internal.h             |   1 -
 libsepol/include/sepol/booleans.h             |  15 +-
 libsepol/include/sepol/policydb/services.h    |   6 -
 libsepol/include/sepol/users.h                |  13 +-
 libsepol/man/man3/sepol_genbools.3            |  30 --
 libsepol/man/man3/sepol_genusers.3            |  54 ---
 libsepol/src/deprecated_funcs.c               |  50 +++
 libsepol/src/genbools.c                       | 279 --------------
 libsepol/src/genusers.c                       | 343 ------------------
 policycoreutils/load_policy/load_policy.c     |   2 +-
 policycoreutils/man/man5/selinux_config.5     |  15 +-
 policycoreutils/man/ru/man5/selinux_config.5  |  11 +-
 24 files changed, 86 insertions(+), 1410 deletions(-)
 delete mode 100644 libselinux/man/man3/selinux_booleans_path.3
 delete mode 100644 libselinux/man/man5/booleans.5
 delete mode 100644 libselinux/man/man5/local.users.5
 delete mode 100644 libselinux/man/ru/man5/booleans.5
 delete mode 100644 libselinux/man/ru/man5/local.users.5
 delete mode 100644 libsepol/man/man3/sepol_genbools.3
 delete mode 100644 libsepol/man/man3/sepol_genusers.3
 create mode 100644 libsepol/src/deprecated_funcs.c
 delete mode 100644 libsepol/src/genbools.c
 delete mode 100644 libsepol/src/genusers.c

-- 
2.21.0

