Return-Path: <SRS0=GjD/=DB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC35C4727D
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 08:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A2823787
	for <selinux@archiver.kernel.org>; Thu, 24 Sep 2020 08:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="CPbPwlZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgIXIxV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Sep 2020 04:53:21 -0400
Received: from mailomta17-re.btinternet.com ([213.120.69.110]:24279 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726064AbgIXIxU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Sep 2020 04:53:20 -0400
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20200924085317.LMWN4657.re-prd-fep-046.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 24 Sep 2020 09:53:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1600937597; 
        bh=upZeFktiusyKesvANNbo1fkRMuOw9DAeoZOqANbHySQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=CPbPwlZ5yiAm0IWpcl+2vh//B1veGXybxOLvTC69894+oao9NcxiZ70b1EX3DnWgsDUfMQdAxBb320M4YqFrtpWM8+DArqfSHVf0bsbnVIQsUXC+4HDUKS9fBnYOtxOayrUUpQrBL48mZqfCchdbzcniJcPXKc8p8yJRzBUO5YrbczTSKzp9i/KaYszB66y8a5aeUw/Vqx9+zVv93GeUQQMej3BqnnRFilFp5A4kxO0kZZykBMVUzKBEsXJDdMDKEe+r905KS39q5ezACC328HALdtYNeklcGOck+/CkRs0ybYnB1OOShvriIANpBA61XkbLNLM08qGJ6Gt/Bh44+A==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.146.219.130]
X-OWM-Source-IP: 86.146.219.130 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudekgddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppeekiedrudegiedrvdduledrudeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeeirddvudelrddufedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeojhhmohhrrhhishesnhgrmhgvihdrohhrgheqpdhrtghpthhtohepoehlrghfohhrghgvsehgnhhumhhonhhkshdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoohhsmhhotghomhdqnhgvthdqghhprhhssehlihhsthhsrdhoshhmohgtohhmrdhorhhgqedprhgtphhtthhopeeophgr
        sghlohesnhgvthhfihhlthgvrhdrohhrgheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsthgvphhhvghnrdhsmhgrlhhlvgihrdifohhrkhesghhmrghilhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.146.219.130) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C74D12798A9F; Thu, 24 Sep 2020 09:53:17 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        osmocom-net-gprs@lists.osmocom.org
Cc:     stephen.smalley.work@gmail.com, paul@paul-moore.com,
        pablo@netfilter.org, laforge@gnumonks.org, jmorris@namei.org,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1] selinux-testsuite: Add GTP tests
Date:   Thu, 24 Sep 2020 09:53:13 +0100
Message-Id: <20200924085314.6120-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These tests were performed on Fedora 32 Workstation with the 'targeted'
policy using an updated kernel with the GTP RFC kernel patches.

See the tests/gtp/GTP-README for detailed setup/testing.

The libgtpnl patch is at:
  tests/gtp/Update-libgtpnl-for-SELinux-testsuite-GTP-tests.patch

The basic process is:
1) Build kernel with RFC LSM/GTP/SELinux patches (use the
   selinux-testsuite/defconfig file to set correct config if required).
2) Setup the selinux-testsuite and add the GTP test patch.
3) Build/install the libgtpnl library using a patch from the
   selinux-testsuite as this will allow errors to be returned by the
   library functions.
4) Build/run selinux-testsuite for all SELinux tests (sets up the
   environment).
5) Run the GTP tests locally to see more info.
6) Remove the selinux-testsuite policy.

Richard Haines (1):
  selinux-testsuite: Add GTP tests

 defconfig                                     |   4 +
 policy/Makefile                               |   5 +
 policy/test_gtp.cil                           |  18 +
 policy/test_gtp.te                            |  96 +++++
 tests/Makefile                                |   4 +
 tests/gtp/.gitignore                          |   2 +
 tests/gtp/GTP-README                          | 123 ++++++
 tests/gtp/Makefile                            |   8 +
 ...tpnl-for-SELinux-testsuite-GTP-tests.patch | 366 ++++++++++++++++++
 tests/gtp/gtp-link.c                          | 134 +++++++
 tests/gtp/gtp-tunnel.c                        | 263 +++++++++++++
 tests/gtp/test                                | 169 ++++++++
 12 files changed, 1192 insertions(+)
 create mode 100644 policy/test_gtp.cil
 create mode 100644 policy/test_gtp.te
 create mode 100644 tests/gtp/.gitignore
 create mode 100644 tests/gtp/GTP-README
 create mode 100644 tests/gtp/Makefile
 create mode 100644 tests/gtp/Update-libgtpnl-for-SELinux-testsuite-GTP-tests.patch
 create mode 100644 tests/gtp/gtp-link.c
 create mode 100644 tests/gtp/gtp-tunnel.c
 create mode 100755 tests/gtp/test

-- 
2.26.2

