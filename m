Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D19C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B41D2465E
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="AqIFWM7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfLQR2S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:28:18 -0500
Received: from mailomta28-re.btinternet.com ([213.120.69.121]:10639 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbfLQR2R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 12:28:17 -0500
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20191217172815.NOYM22473.re-prd-fep-046.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Tue, 17 Dec 2019 17:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1576603695; 
        bh=U7wCuYb5tjm1qU1/Fm+zQoO4mQxQXQSzhNPU6/N0EPQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=AqIFWM7xAV2f/MrTrrVwT0OzrZlz3wJSvE3AZ6PItNgsW7Y341f8n0O6TboXhqXrQwcF3RjDl0aLLgaMR4hLM21pa1UBB2g+SLu7+AuZTx9DJwINdY0fZL4pcxe5earprRuhDkDlXJAgKQNbksEVrXDZlHuwzWACfIXskIW2h6qS3jZsFkOT3U5qV/ESu3icFvSxXHMt0p0z55qQJ+W90EEpBRHcgngTTeR6ZQQ+Lj0PDoQyqylyt85woihhrZDCzzXQiT1AZC6UGH7cR2kPZhpX6tliOWeQeuN+Vk081dCqRYTX8Jh3itDzAQGm0lgQzAsuyl0j82v9JuZ8MoKP5w==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.214]
X-OWM-Source-IP: 86.134.6.214 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvddtjedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedriedrvddugeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedrvddugedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.214) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DE2575E0306931B; Tue, 17 Dec 2019 17:28:15 +0000
Message-ID: <8f0b604a274ca9c94e3f5f9f63a31c647991dbe5.camel@btinternet.com>
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 17 Dec 2019 17:28:14 +0000
In-Reply-To: <cf9921c8-47e0-d384-b732-fd017a587d54@tycho.nsa.gov>
References: <20191215170620.73506-1-richard_c_haines@btinternet.com>
         <20191215170620.73506-2-richard_c_haines@btinternet.com>
         <ace92ec4-2276-9af8-bb52-c942d0be7605@tycho.nsa.gov>
         <d72ecf26-152d-2642-6f1a-8bebe9d1eb69@tycho.nsa.gov>
         <ca2340581dafaca79860d249bd048bbb6ffe0593.camel@btinternet.com>
         <cf9921c8-47e0-d384-b732-fd017a587d54@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2019-12-17 at 11:49 -0500, Stephen Smalley wrote:
> On 12/17/19 11:38 AM, Richard Haines wrote:
> > On Tue, 2019-12-17 at 10:36 -0500, Stephen Smalley wrote:
> > > On 12/16/19 9:09 AM, Stephen Smalley wrote:
> > > > On 12/15/19 12:06 PM, Richard Haines wrote:
> > > > > Test filesystem permissions using mount(2)/umount(2).
> > > > > 
> > > > >   From kernels 5.5 filesystem { watch } is also tested.
> > > > > 
> > > > > Signed-off-by: Richard Haines <
> > > > > richard_c_haines@btinternet.com>
> > > > 
> > > > This didn't pass travis-ci, looks like a combination of failing
> > > > check-syntax and FAN_MARK_FILESYSTEM not being defined (maybe
> > > > the
> > > > kernel
> > > > headers are too old in the base distro?).
> > > 
> > > Possibly we need to install our own kernel headers for the
> > > testsuite?
> > I assume this is on the travis system (that I don't use).
> 
> Yes, the build/test environment is specified by the .travis.yml file
> in 
> the selinux-testsuite repo.  Currently uses a bionic Ubuntu distro
> as 
> the base (sadly Fedora isn't an option).  In other situations where
> we 
> have had dependency problems, we have explicitly had it download the 
> desired upstream sources and install them, e.g. for perl tidy,
> libbpf, 
> keytuils, etc.  Should be possible to do the same with the kernel 
> headers instead of just using the distro-provided ones.  Or your
> test 
> code could have #ifndef FAN_MARK_FILESYSTEM...#define 
> FAN_MARK_FILESYSTEM...#endif; we have some instances of that already
> for 
> SO_PEERSEC, SCM_SECURITY, MAP_HUGETLB, AF_KCM, etc.  That's probably
> the 
> easiest solution.

Thanks. I'll add the ifndef etc.

> 
> 

