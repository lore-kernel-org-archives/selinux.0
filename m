Return-Path: <SRS0=SQk1=V4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F4CC433FF
	for <selinux@archiver.kernel.org>; Wed, 31 Jul 2019 19:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BAF216C8
	for <selinux@archiver.kernel.org>; Wed, 31 Jul 2019 19:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="RtJMx31K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfGaT7b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:59:31 -0400
Received: from mailomta28-sa.btinternet.com ([213.120.69.34]:24182 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730227AbfGaT7a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Jul 2019 15:59:30 -0400
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20190731195927.DXTB8450.sa-prd-fep-043.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Wed, 31 Jul 2019 20:59:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1564603167; 
        bh=xiZDyMZvGsIZvsTNhwCsy1BQejTJ/x6pKhj3+R3/d/E=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=RtJMx31KqA6J+pu9Fd1qDzA4sS3TOmcPnlShXhhAm6uC7WfiS72vTthmxfcgheDJSPeC3dYBrcET5l2U94JhvC4rYcWkuJ/Bt7xPOWb0u+IL5CVNOb6PoeHzjnEcm7OFnAsY+tOwAzvyVm0H/FonptL93IvUoFPD+J15zvcFfHqxIPXeGjFHsQG/ccB4EDq1KsljUedxKGkpKRVCJXdZwMPXoqpdERlGW4G4ytslXDGFYSo2MqbAquCgN3kFdRsvlyfG2lqY6LCiU/VJQdPF8x3cia4UPVUGY26I40AWpE4CfIH9f1cavmGGt9Y5I/gtTWJ+mW1RC+D8/BUJAQiLRg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.58.160]
X-OWM-Source-IP: 31.49.58.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrleehgddugedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdehkedrudeitdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehkedrudeitddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.58.160) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.335.01) (authenticated as richard_c_haines@btinternet.com)
        id 5D3F8E9E0034BDA1; Wed, 31 Jul 2019 20:59:27 +0100
Message-ID: <9dff3e40ff2ea96f627d276c574a989baa6e2f4e.camel@btinternet.com>
Subject: Re: [PATCH 0/1] selinux-testsuite: Add BPF tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, paul@paul-moore.com
Date:   Wed, 31 Jul 2019 20:59:26 +0100
In-Reply-To: <20190731162612.16851-1-richard_c_haines@btinternet.com>
References: <20190731162612.16851-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2019-07-31 at 17:26 +0100, Richard Haines wrote:
> This runs basic checks for BPF with map_create, map_read, map_write,
> prog_load and prog_run permissions.
> 
> If this is okay, I'll do tests for checking the following:
> tests/fdreceive - security_file_receive path
> tests/binder - security_binder_transfer_file path

This patch should work ok, however as the fdreceive and binder required
the same BPF map/prog calls, I'm planning to split these out of
bpf_test.c and into a common area so they can all use it.

I'll send a v2 of this patch when I've completed the fdreceive so I can
check they both work with same BPF code.
> 
> Richard Haines (1):
>   selinux-testsuite: Add BPF tests
> 
>  README.md            |   4 +-
>  defconfig            |   5 ++
>  policy/Makefile      |   4 ++
>  policy/test_bpf.te   |  77 +++++++++++++++++++++++++++
>  tests/Makefile       |   4 ++
>  tests/bpf/.gitignore |   1 +
>  tests/bpf/Makefile   |   8 +++
>  tests/bpf/bpf_insn.h |  20 +++++++
>  tests/bpf/bpf_test.c | 124
> +++++++++++++++++++++++++++++++++++++++++++
>  tests/bpf/test       |  57 ++++++++++++++++++++
>  tools/check-syntax   |   2 +-
>  tools/chk_c_exclude  |   1 +
>  12 files changed, 305 insertions(+), 2 deletions(-)
>  create mode 100644 policy/test_bpf.te
>  create mode 100644 tests/bpf/.gitignore
>  create mode 100644 tests/bpf/Makefile
>  create mode 100644 tests/bpf/bpf_insn.h
>  create mode 100644 tests/bpf/bpf_test.c
>  create mode 100755 tests/bpf/test
>  create mode 100644 tools/chk_c_exclude
> 

