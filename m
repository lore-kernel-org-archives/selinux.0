Return-Path: <SRS0=KxHl=TW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3375C282DC
	for <selinux@archiver.kernel.org>; Wed, 22 May 2019 16:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AA820815
	for <selinux@archiver.kernel.org>; Wed, 22 May 2019 16:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="wLb2EiwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfEVQmn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 May 2019 12:42:43 -0400
Received: from rgout0803.bt.lon5.cpcloud.co.uk ([65.20.0.150]:8784 "EHLO
        rgout0803.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729572AbfEVQmn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 May 2019 12:42:43 -0400
X-OWM-Source-IP: 31.49.58.155 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudduvddguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepfedurdegledrheekrdduheehnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledrheekrdduheehpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoeiguhhntghhrghnghesghhoohhglhgvrdgtohhmqeenucevlhhushhtvghrufhiiigvpedt
Received: from localhost.localdomain (31.49.58.155) by rgout08.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5BC47A8713F6B7E4; Wed, 22 May 2019 17:42:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1558543363; 
        bh=+9AT9sAs0tiYw6KEB9hmSud5WpBdy+qAbBBAryjdJmw=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=wLb2EiwS+WlTNiEsTblzC8YItWzZI6TcwYR7e7Vzit3yMPO5LYS5NCo+9F2AMXDG0OYoYkh/VymLgm/JDsegrezwhUpybY8q50JWsrhF52+xz8ggKGlWJxsAPN6ZYl1ucLbe1etvT5isU63DLSnr5edUyqv8CEoHbHaw7I8ITIY=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov, xunchang@google.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/3] Update restorecon to support new digest scheme
Date:   Wed, 22 May 2019 17:42:40 +0100
Message-Id: <20190522164240.3062-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These patches require [1] and [2] be installed first. They have
been implemented on Android and sent to the selinux list, however their
merge has been deferred. They will install the core hashing of
file_context entries and fix root stem processing.

Patch 1/3 updates selinux_restorecon() replacing the per-mountpoint
security.restorecon_last attribute with a per-directory security.sehash
attribute computed from only those file contexts entries that partially
match the directory. This is to avoid the need to walk the entire tree
when any part of file_contexts changes, limiting relabels to only those
parts of the tree that could have changed.

One change is to add a new selabel_get_digests_all_partial_matches(3)
function that is explained in the man page. This could replace the Android
version of selabel_hash_all_partial_matches(3), that could then be
converted into a local function (The Android team would need to approve).

Patches 2/3 and 3/3 update restorecon, setfiles and restorecond.

I will send a patch for the selinux-testsuite that will perform tests on
the new code.
 
[1] https://lore.kernel.org/selinux/20190311222442.49824-1-xunchang@google.com/
[2] https://lore.kernel.org/selinux/20190417180955.136942-1-xunchang@google.com/

Richard Haines (3):
  libselinux: Save digest of all partial matches for directory
  setfiles: Update utilities for the new digest scheme
  restorecond: Update to handle new digest scheme

 libselinux/include/selinux/label.h            |   5 +
 libselinux/include/selinux/restorecon.h       |  17 +-
 .../selabel_get_digests_all_partial_matches.3 |  70 +++++
 libselinux/man/man3/selinux_restorecon.3      |  91 +++---
 .../man3/selinux_restorecon_default_handle.3  |   9 +-
 .../man/man3/selinux_restorecon_xattr.3       |  11 +-
 libselinux/src/label.c                        |  15 +
 libselinux/src/label_file.c                   |  51 ++++
 libselinux/src/label_file.h                   |   4 +
 libselinux/src/label_internal.h               |   5 +
 libselinux/src/selinux_restorecon.c           | 267 +++++++++++-------
 libselinux/utils/.gitignore                   |   1 +
 .../selabel_get_digests_all_partial_matches.c | 170 +++++++++++
 policycoreutils/setfiles/restore.c            |   7 +-
 policycoreutils/setfiles/restore.h            |   2 +-
 policycoreutils/setfiles/restorecon.8         |  10 +-
 policycoreutils/setfiles/restorecon_xattr.8   |  19 +-
 policycoreutils/setfiles/restorecon_xattr.c   |  66 +----
 policycoreutils/setfiles/setfiles.8           |  10 +-
 policycoreutils/setfiles/setfiles.c           |  19 +-
 restorecond/restore.c                         |   8 +-
 restorecond/restore.h                         |   2 +-
 restorecond/restorecond.c                     |   5 +-
 23 files changed, 593 insertions(+), 271 deletions(-)
 create mode 100644 libselinux/man/man3/selabel_get_digests_all_partial_matches.3
 create mode 100644 libselinux/utils/selabel_get_digests_all_partial_matches.c

-- 
2.20.1

