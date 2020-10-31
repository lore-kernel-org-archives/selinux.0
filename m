Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6DFC388F7
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571AC20739
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="HJum+Uv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgJaLAN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 07:00:13 -0400
Received: from mailomta19-sa.btinternet.com ([213.120.69.25]:27118 "EHLO
        sa-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726697AbgJaLAM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 07:00:12 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20201031110009.DCQU29142.sa-prd-fep-041.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sat, 31 Oct 2020 11:00:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1604142009; 
        bh=OOcCWiDlCW6LXUdR/6iasgAehqT34sU8bViY0t87/Aw=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=HJum+Uv/HQtLlkMscFkwhPlhEWc6/msuJsPFrvAf8efd95koFu3ggSe9o/2BnPL6YIe0f+l4wt/UC740W0dVaIujZcmyDT0hwi1Cw+fTTL4rwrnBUFAnH19u5sxbHPKosrVZoXhNFgjJiu8FDZUklEYEgJbzVZKwpT9guumNrtjBUay7VRQEioW3X7Q6emmwnOV+KHnXkcbK6kA5iegYNZvmwTDUmbqDlsGfQyjbACKdCY+llUfguPAPDI3d2+kOJ64/CqcnQtstg91Kub0dPhexrTmuBmxx/nDidW7bLPyIQXI6BvKWH36SzjYg8XluOJomLnF+tQxP7aTVt0IHLg==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9AFBE18804BAE
X-Originating-IP: [86.157.76.249]
X-OWM-Source-IP: 86.157.76.249 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrleejgddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepkeegfedtffekieekudegvdekjeehieffveevleegtdeludetveduleffudfggfeinecukfhppeekiedrudehjedrjeeirddvgeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehjedrjeeirddvgeelpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.157.76.249) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE18804BAE; Sat, 31 Oct 2020 11:00:08 +0000
Message-ID: <57cae09466abb6d40d505449c9766c04e37c7ca5.camel@btinternet.com>
Subject: Re: [PATCH 0/1] selinux-testsuite: Add btrfs support for filesystem
 tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Date:   Sat, 31 Oct 2020 11:00:08 +0000
In-Reply-To: <CAFqZXNtOd5CNXF49pKcDUf3Aag=V1-+nidFePX0hknteg9tq-g@mail.gmail.com>
References: <20201013145456.77253-1-richard_c_haines@btinternet.com>
         <CAFqZXNu1o3rTRcrNBRwESt+txA+chc3PcdFjrZFiP50koceyAQ@mail.gmail.com>
         <CAFqZXNtubRw-pqEiuxwzp=6n53Gnso3oOoExbhc+OhWcQ5ESAA@mail.gmail.com>
         <CAFqZXNtOd5CNXF49pKcDUf3Aag=V1-+nidFePX0hknteg9tq-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, 2020-10-31 at 10:03 +0100, Ondrej Mosnacek wrote:
> On Sat, Oct 31, 2020 at 12:44 AM Ondrej Mosnacek <omosnace@redhat.com
> > wrote:
> > On Fri, Oct 30, 2020 at 10:55 PM Ondrej Mosnacek <
> > omosnace@redhat.com> wrote:
> > > On Tue, Oct 13, 2020 at 4:55 PM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > This patch allows BTRFS filesystems to be tested.
> > > > 
> > > > The tests/filesystem all pass using './test -f btrfs' on Fedora
> > > > 32.
> > > 
> > > For me, also these tests are failing (41 of 58):
> > > 
> > > Test Summary Report
> > > -------------------
> > > filesystem/btrfs/test     (Wstat: 10496 Tests: 58 Failed: 41)
> > >   Failed tests:  3-4, 10, 13-15, 17-25, 27-28, 30-37, 39-45
> > >                 47-55
> > >   Non-zero exit status: 41
> > 
> > Oh, never mind... The reason why these were failing was that
> > btrfs-progs was not installed on the system. After installing that
> > package, only the fs_filesystem tests fail for btrfs.
> > 
> > Please add btrfs-progs as a dependency to README.md and
> > travis-ci/run-testsuite.sh in future versions of the patch.
> 
> ...and please also don't forget to update defconfig :)

I'll send updated patch soon.
> 

