Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81186C10F0B
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 08:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C56820835
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 08:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="HDrNz+Jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbfDRIj0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:39:26 -0400
Received: from rgout0407.bt.lon5.cpcloud.co.uk ([65.20.0.220]:11083 "EHLO
        rgout04.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728074AbfDRIj0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 04:39:26 -0400
X-OWM-Source-IP: 31.49.61.120 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrfeehgddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepfedurdegledriedurdduvddtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledriedurdduvddtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
Received: from localhost.localdomain (31.49.61.120) by rgout04.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5C55FFA9074EE2D1; Thu, 18 Apr 2019 09:39:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1555576766; 
        bh=l125m4DHpHmBFtVLV0y2RkYvemU++3p3qvIR/RJPJ58=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=HDrNz+Jvk+BkDUrZny8C3O45cNGua+SziU0hs8yRk8FeFYZPr8gGq7MJZTbyyi9MOxN04XRuZq7ZV2eKkrw3gN0wPgnPh2BOqE2y7BMnkKpiVTOSrX63WJ1DQqbet33e51PJPI4tV63rw0SekGrsEW9a1Y94v7qT3duV8kmtmjE=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1] libselinux: Save digest of all partial matches for directory
Date:   Thu, 18 Apr 2019 09:38:57 +0100
Message-Id: <20190418083857.3081-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch requires that patch [1] be installed first. [1] has been
implemented on Android and was sent to the selinux list, however its
merge has been defered. It will install the core hashing of file_context
entries.

This patch updates selinux_restorecon() replacing the per-mountpoint
security.restorecon_last attribute with a per-directory security.sehash
attribute computed from only those file contexts entries that partially
match the directory. This is to avoid the need to walk the entire tree
when any part of file_contexts changes, limiting relabels to only those
parts of the tree that could have changed.

One change is to add a new selabel_get_digests_all_partial_matches(3)
function that is explained in the man page. This could replace the Android
version of selabel_hash_all_partial_matches(3), that could then be
converted into a local function.

I've not updated restorecon(8) or restorecon_xattr(8) programs as they
work okay (although I could rework the "selabel_opt_digest" stuff). However
the man pages at least will need updating.

The patch still needs more testing (I've not tried all restorecon options),
however I will send a patch for the selinux-testsuite that will perform
some simple tests on the new code.
 
[1] https://lore.kernel.org/selinux/20190311222442.49824-1-xunchang@google.com/

Richard Haines (1):
  libselinux: Save digest of all partial matches for directory

 libselinux/include/selinux/label.h            |   5 +
 .../selabel_get_digests_all_partial_matches.3 |  69 ++++++
 libselinux/src/label.c                        |  15 ++
 libselinux/src/label_file.c                   |  51 +++++
 libselinux/src/label_file.h                   |   4 +
 libselinux/src/label_internal.h               |   5 +
 libselinux/src/selinux_restorecon.c           | 204 +++++++++++++-----
 libselinux/utils/.gitignore                   |   2 +
 .../selabel_get_digests_all_partial_matches.c | 171 +++++++++++++++
 .../utils/selabel_hash_all_partial_matches.c  | 126 +++++++++++
 10 files changed, 595 insertions(+), 57 deletions(-)
 create mode 100644 libselinux/man/man3/selabel_get_digests_all_partial_matches.3
 create mode 100644 libselinux/utils/selabel_get_digests_all_partial_matches.c
 create mode 100644 libselinux/utils/selabel_hash_all_partial_matches.c

-- 
2.20.1

