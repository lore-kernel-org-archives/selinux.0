Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5B2C433FE
	for <selinux@archiver.kernel.org>; Fri, 10 Dec 2021 11:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbhLJLr2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Dec 2021 06:47:28 -0500
Received: from mailomta9-re.btinternet.com ([213.120.69.102]:15112 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240723AbhLJLr2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Dec 2021 06:47:28 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20211210114351.KBLE24326.re-prd-fep-046.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Fri, 10 Dec 2021 11:43:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1639136631; 
        bh=w0xJ9+iBzI2VZjPb7/Iyd0tF5eojJI/DbIe+gnSa+nI=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Ng8+dQ3C+W2Ze6WRRaoSmiHad2TfcgHhuiN3C/4BxUCAXHIWR7az/E9MJWxLUk0SJ6Vl+hMWLrPmpfciZo08iQkGbwo5T+/XKgA0NCfAhkLV9umcYoDwh4U5fLjWdSSJgNcz16NRDuC+CezQ6SKQTGiodiivZbPUYk4zGMorzHfflKPmsv/MuAEyB8ZiJy/ZhOsRi9gnC6tentYR5ZAPSPamjSUjXEnLAcZ6eYmocBj/1Ae694h5/v4mvjFQ+JgM6eEDdP7B1U5XuAm8hIniQl6fBhVynHMnQwxLvv4z1cPPrUQvUu9q8VfZeCW58m9KLlT4vjtb//kp1QxIZOW+Wg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A901C0CC4A231
X-Originating-IP: [81.141.144.155]
X-OWM-Source-IP: 81.141.144.155 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrkedvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppeekuddrudeguddrudeggedrudehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurddugedurddugeegrdduheehpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.141.144.155) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A901C0CC4A231; Fri, 10 Dec 2021 11:43:51 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 0/4] SELinux Notebook: Add eBook reader build
Date:   Fri, 10 Dec 2021 11:43:36 +0000
Message-Id: <20211210114340.13977-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This allows an eBook to be built that can be read by readers such as
Bookworm and Foliate. Note that Bookworm does not render tables or examples
very well, whereas Foliate does.

As eBooks use a different cover format the current SELinux penguin
has been replaced with one from the SELinux artwork repository.

Richard Haines (4):
  selinux-notebook: Make file links consistent
  src/images: Remove current penguin
  src/images: Add new SELinux penguin
  selinux-notebook: Add epub build

 BUILD.md                           |  17 +-
 CONTRIBUTING.md                    |  10 +-
 Makefile                           |  48 +++-
 README.md                          |   9 +-
 src/bounds_rules.md                |   2 +-
 src/cil_overview.md                |   2 +-
 src/cover.md                       |  16 ++
 src/cover_epub.md                  |   2 +
 src/embedded_systems.md            |  12 +-
 src/images/selinux-penguin.svg     | 398 -----------------------------
 src/images/selinux-penguin_400.png | Bin 0 -> 65728 bytes
 src/network_support.md             |   4 +-
 src/postgresql.md                  |   6 +-
 src/styles_epub.css                |  44 ++++
 src/title.md                       |  16 --
 src/toc.md                         |   2 +-
 16 files changed, 139 insertions(+), 449 deletions(-)
 create mode 100644 src/cover.md
 create mode 100644 src/cover_epub.md
 delete mode 100644 src/images/selinux-penguin.svg
 create mode 100644 src/images/selinux-penguin_400.png
 create mode 100644 src/styles_epub.css

-- 
2.33.1

