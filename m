Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622EFC43446
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E75C2073A
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 17:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="S4nLm4Hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgGURD4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:03:56 -0400
Received: from mailomta12-sa.btinternet.com ([213.120.69.18]:34155 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730313AbgGUQ4o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 12:56:44 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20200721165628.KZAR5290.sa-prd-fep-040.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 21 Jul 2020 17:56:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1595350588; 
        bh=RlkbIUbXWPENrQ3ALLWG9MmNaUXTSyqyXJzpmLcwQ/8=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=S4nLm4HgG4wGqsHAtXdS3u0jhnSH3giB9BF4q8Elgc0NxvZrpolCPcI+kL2wvQL1tEHYq7urSXQQ1gltN7gbW/HNCqIMn4ff5q2oDDd6UMZOGLnN2UapoEUfqBDldbi08AKln5fbZaMYXh8+IxUvp/OOjAAzlRakRlHI5shEuZtS0icXu8gRK7sQruRbof5DStBL2QPGaZlijpJwFv7IDuw00XGriNmUTbAJdtEKwG+KlFfbxcdU9pMJVFFvnd9uJovLDjHrJXgGbJ1lNmx9o97683G+9KpkWhsTLtHKw0OfgKYRXRSn4iI0/rQ3t8OQUG3qhqH4UBEGGr3kJYk+yA==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.158.127.27]
X-OWM-Source-IP: 109.158.127.27 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrgeeigddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeivddvhfevveevheegkeffkeeiffehgfetgeefgedthfekkeeljeduveeffeevhfenucffohhmrghinhepphgruhhlqdhmohhorhgvrdgtohhmnecukfhppedutdelrdduheekrdduvdejrddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehkedruddvjedrvdejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoughomhhinhhitghkrdhgrhhifhhtseguvghfvghnshgvtgdrnhhlqedprhgtphhtthhopeeojhiftggrrhhtvdesghhmrghilhdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthho
        peeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.158.127.27) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE07EEFF19; Tue, 21 Jul 2020 17:56:28 +0100
Message-ID: <d37dcc1e21d3292c4112810c7d398d5590e14d14.camel@btinternet.com>
Subject: Re: [SELinux-notebook PATCH v5] adds CIL policy with makefile
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Date:   Tue, 21 Jul 2020 17:56:21 +0100
In-Reply-To: <CAHC9VhTS0hr+i3GvMJPhs3WQd48fOdz3xbZBUSJDJD=XAfNQvQ@mail.gmail.com>
References: <20200718104842.1333101-1-dominick.grift@defensec.nl>
         <20200719181704.1583398-1-dominick.grift@defensec.nl>
         <CAHC9VhTS0hr+i3GvMJPhs3WQd48fOdz3xbZBUSJDJD=XAfNQvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2020-07-21 at 12:42 -0400, Paul Moore wrote:
> On Sun, Jul 19, 2020 at 2:17 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> > This example CIL policy takes a different approach:
> > 
> > 1. Leverages CIL
> > 2. Installs using semodule to make it tunable at runtime (but you
> > can obviously also use secilc to build a monolithic version and
> > deploy that)
> > 3. Makes few assumptions about variables
> > 4. Leverages handleunknown allow and declares least required access
> > vectors so that you can pick and choose which access vectors you
> > want to use and ignore the remainder
> > 5. Leverages unlabeled and file ISID and makes no assumptions about
> > any volatile filesystems you may or may not use
> > 6. As small and simple as reasonably possible, heavily documented
> > 7. Modern, Requires SELinux 3.1
> > 
> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> > ---
> > v2: rename XWAYLAND.md to XSERVER_XWAYLAND.md and cover both
> > Xserver as well as Xwayland
> > V3: fix typo in XSERVER_XWAYLAND.md and exclude x_contexts
> > altogether
> > v4: remove XSERVER_XWAYLAND and add the note to README.md, redo
> > README.md and clean up cil-policy.cil
> > v5: add -F to fixfiles onboot (onboot should probably just imply
> > -F)
> > 
> >  src/cil_overview.md                           |  11 +
> >  src/notebook-examples/README.md               |   2 +
> >  src/notebook-examples/cil-policy/Makefile     |  31 ++
> >  src/notebook-examples/cil-policy/README.md    |  90 ++++
> >  .../cil-policy/cil-policy.cil                 | 448
> > ++++++++++++++++++
> >  5 files changed, 582 insertions(+)
> >  create mode 100644 src/notebook-examples/cil-policy/Makefile
> >  create mode 100644 src/notebook-examples/cil-policy/README.md
> >  create mode 100644 src/notebook-examples/cil-policy/cil-policy.cil
> 
> James, Richard, you both had comments on previous drafts, does v3
> look
> good to you guys?

Yes I've tested this (v4 & V5) a few times and okay on Fedora 32 WS.

Acked-by: Richard Haines <richard_c_haines@btinternet.com>


> 
> --
> paul moore
> www.paul-moore.com

