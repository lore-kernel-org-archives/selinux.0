Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E6C433F5
	for <selinux@archiver.kernel.org>; Mon, 13 Dec 2021 10:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbhLMKSo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Dec 2021 05:18:44 -0500
Received: from mailomta8-re.btinternet.com ([213.120.69.101]:54069 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244164AbhLMKQk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Dec 2021 05:16:40 -0500
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20211213101637.SLUL24878.re-prd-fep-047.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Mon, 13 Dec 2021 10:16:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1639390597; 
        bh=s3llG6U8LHdttcurwh23YiAgPp6VuJPY/rJhOdkyGPU=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Bbhf9xN5LoAvAlceptC/woiBILqigPyRKmjPmC3GjRXGEyf0ggrduXRillRnvPgtTFT0bf+hcM5JIkwLNrTNuWtC71eqaRk8fYqxVygsyWwK8DgxMP/ykEclt4471t/2+2Yt/fI9JDOYJwEKs8yPL56a4VcXaSVfVaMfLOJDpxUyClLwbNGXhboPGAr0LcyL+aJXPvOTzSeXMxYAwF9ftK3EUJLhFNt4giuCJznu58hSmCpMC4EP5zIInQtfbV6EBV+lV85dm9EFVeZK90WoDhv0mPlHPehRIsH7yEOCPYS++fqEJuKU0ew0IprbJikx86t/qL5H8OX2eCQOmD1a8A==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A8DE80D18AF7E
X-Originating-IP: [217.42.116.92]
X-OWM-Source-IP: 217.42.116.92 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrkeekgddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepieegffejteetvdfffefhteehuefhuefgteeggfevjefhffetteettddtfffgfedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedvudejrdegvddrudduiedrledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedvudejrdegvddrudduiedrledvpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopegusghurhhgvghnvghrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
        gh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (217.42.116.92) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A8DE80D18AF7E; Mon, 13 Dec 2021 10:16:37 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, dburgener@linux.microsoft.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 0/4] SELinux Notebook: Add eBook reader build
Date:   Mon, 13 Dec 2021 10:16:18 +0000
Message-Id: <20211213101622.29888-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This allows an eBook to be built that can be read by readers such as
Foliate. Note that Bookworm does not render tables or examples
very well, whereas Foliate does.

As eBooks use a different cover format the current SELinux penguin
has been replaced with one from the SELinux artwork repository.

Daniel Burgener suggested adding metadata, I've picked some that may be
useful. Any views ??

[PATCH 3/4] adds a new SELinux penguin, however it will be bounced by
vger.kernel.org. The file can be found at [1].

V2 Changes:
Add metadata
Add notes regarding capabilities of eBook readers
Fix minor nits

[1] https://github.com/SELinuxProject/selinux-artwork/blob/main/PNG/selinux-penguin_400.png

Richard Haines (4):
  selinux-notebook: Make file links consistent
  src/images: Remove current penguin
  src/images: Add new SELinux penguin
  selinux-notebook: Add epub build

 BUILD.md                           |  23 +-
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
 src/metadata.yaml                  |  14 +
 src/network_support.md             |   4 +-
 src/postgresql.md                  |   6 +-
 src/seandroid.md                   |   4 +-
 src/styles_epub.css                |  52 ++++
 src/styles_html.css                |   8 +
 src/styles_pdf.css                 |   8 +
 src/title.md                       |  16 --
 src/toc.md                         |   2 +-
 20 files changed, 185 insertions(+), 451 deletions(-)
 create mode 100644 src/cover.md
 create mode 100644 src/cover_epub.md
 delete mode 100644 src/images/selinux-penguin.svg
 create mode 100644 src/images/selinux-penguin_400.png
 create mode 100644 src/styles_epub.css

-- 
2.33.1

