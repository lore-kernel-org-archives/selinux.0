Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908BFC388F7
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A4422202
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="ETjYti81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgJaLFW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 07:05:22 -0400
Received: from mailomta31-re.btinternet.com ([213.120.69.124]:15641 "EHLO
        re-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726697AbgJaLFW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 07:05:22 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-040.btinternet.com with ESMTP
          id <20201031110519.OAMV20789.re-prd-fep-040.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sat, 31 Oct 2020 11:05:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1604142319; 
        bh=odwnCdVISsN9p5vzmFJk4VOVx7g7YFRnBzGoMJnfytk=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=ETjYti81O1d8mF7IofiAMLcLUb/U+WuW2ajW1nTcw0Y4jJNscnuzy+aFeHmkdcE3bDYAH6gjIZOJoBkYVzQ7j6bE7kM9Jiunlb6oEaM6wnHPlEcFEmmih9LNo5VlDNXHHjNp33oh6SJd2iWjH0HUhiJ42zdF6rAJlcZ7V/KRmk5k94Bn54OXHwvbIw1jPv94pqxl5cNCBoz0TZkksY3vY56DRJKlKHUk8sBaemyn/RD4WNtt70qZ6m6iauqL8KR4p6MK1lLX/bjum4S+upr2snk415m69vJdVKbfBMacY/J/ukEM0dr+1BDPN0uoRiwPCn3dZvtdVIPO9I2oWUf4gA==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C2FD18345970
X-Originating-IP: [86.157.76.249]
X-OWM-Source-IP: 86.157.76.249 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrleejgddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepjeejkeetgefgteejteekledtveeftefhhfdukeehgfeggfeivdeuieetkeehgfehnecuffhomhgrihhnpehtrhgrvhhishdqtghirdgtohhmnecukfhppeekiedrudehjedrjeeirddvgeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehjedrjeeirddvgeelpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.157.76.249) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD18345970; Sat, 31 Oct 2020 11:05:19 +0000
Message-ID: <defeb72b69504c9b7af78615e6bb77053444fe36.camel@btinternet.com>
Subject: Re: [PATCH 0/1] selinux-testsuite: Add btrfs support for filesystem
 tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Date:   Sat, 31 Oct 2020 11:05:19 +0000
In-Reply-To: <e895f6ebe00f6fd8ca451521a2326d0717d75760.camel@btinternet.com>
References: <20201013145456.77253-1-richard_c_haines@btinternet.com>
         <CAFqZXNu1o3rTRcrNBRwESt+txA+chc3PcdFjrZFiP50koceyAQ@mail.gmail.com>
         <CAFqZXNtubRw-pqEiuxwzp=6n53Gnso3oOoExbhc+OhWcQ5ESAA@mail.gmail.com>
         <CAFqZXNvUiezPUTYgV+vWiS2LO5Nt0_Sb-p8GeELhLjVcPVTmRg@mail.gmail.com>
         <e895f6ebe00f6fd8ca451521a2326d0717d75760.camel@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, 2020-10-31 at 10:57 +0000, Richard Haines wrote:
> On Sat, 2020-10-31 at 01:04 +0100, Ondrej Mosnacek wrote:
> > On Sat, Oct 31, 2020 at 12:44 AM Ondrej Mosnacek <
> > omosnace@redhat.com
> > > wrote:
> > > On Fri, Oct 30, 2020 at 10:55 PM Ondrej Mosnacek <
> > > omosnace@redhat.com> wrote:
> > > > And on related note, the existing vfat tests are also failing:
> > > > Test Summary Report
> > > > -------------------
> > > > filesystem/vfat/test      (Wstat: 7936 Tests: 43 Failed: 31)
> > > >   Failed tests:  3-4, 6-7, 10-12, 14-19, 21-22, 24-36, 38-40
> > > >   Non-zero exit status: 31
> > > > fs_filesystem/vfat/test   (Wstat: 8192 Tests: 42 Failed: 32)
> > > >   Failed tests:  3, 5-7, 10-20, 22-35, 37-39
> > > >   Non-zero exit status: 32
> > > 
> > > And this might be the same problem, but with dosfstools... I'll
> > > need to check.
> > 
> > Yeah, that was it. With dosfstools installed the tests pass.
> > 
> > There are some fsetfilecon(3) errors visible in the test output,
> > though:
> > https://travis-ci.com/github/WOnder93/selinux-testsuite/jobs/422914927#L2697
> > 
> 
> These tests pass as for vfat Operation not supported is correct. The
> tests just need " 2>&1" added to stop output. I'll submit a patch,
> also
> to add dosfstools (also to travis run-testsuite.sh).
> 

No as already there:
> I guess I also really need to add to defconfig:
> 
> CONFIG_VFAT_FS=m
> 
> 

