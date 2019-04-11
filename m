Return-Path: <SRS0=m7/L=SN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39225C10F13
	for <selinux@archiver.kernel.org>; Thu, 11 Apr 2019 12:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62AB2184E
	for <selinux@archiver.kernel.org>; Thu, 11 Apr 2019 12:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="YzFmVKBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfDKMYc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:24:32 -0400
Received: from rgout0301.bt.lon5.cpcloud.co.uk ([65.20.0.207]:49566 "EHLO
        rgout03.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726517AbfDKMYc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Apr 2019 08:24:32 -0400
X-OWM-Source-IP: 86.147.205.173 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudelgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddugeejrddvtdehrddujeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdehrddujeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeothhkjhhoshesghhoohhglhgvrdgtohhmqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudelgdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddugeejrddvtdehrddujeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdehrddujeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudelgdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddugeejrddvtdehrddujeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdehrddujeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudelgdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddugeejrddvtdehrddujeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdehrddujeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgepud
Received: from localhost.localdomain (86.147.205.173) by rgout03.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5C90B6EC02125C13; Thu, 11 Apr 2019 12:48:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1554985471; 
        bh=GJBIO56WJJ522le3kEAtY1L1P6c2UWrm7VcdvG6zY2c=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=YzFmVKBnk9K7yOlao8hq17dUtGX3UF2qz3ClrCHAsUsfb3UP8cih1MBuL7I7cRgQTglTawFD2wiUwVCn5rqGHGLl+qpuFKiX0BAf/bgQofW/M3wy/Qik4v8F4sawQAG8szGwxMWVQZn6+bGOXYknNB6xCLSF6sjGWO/pC12Ixlw=
Message-ID: <2ef270d1e0ce2edbbddc07fba754cb99f2b093d4.camel@btinternet.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Update binder test applications
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, tkjos@google.com
Date:   Thu, 11 Apr 2019 12:48:24 +0100
In-Reply-To: <CAHC9VhRXgNk0qMS+-=wUt3wYoteauCv3UdPuPrYPyTEV8zXcHw@mail.gmail.com>
References: <20190403122611.6543-1-richard_c_haines@btinternet.com>
         <CAHC9VhTTeetqR03+zaV0d_2rdHr4r6eKnqKNrXO6k9O7+tz=gQ@mail.gmail.com>
         <a1869fe6f41148a956ff902d7077356fc729b28b.camel@btinternet.com>
         <CAHC9VhRXgNk0qMS+-=wUt3wYoteauCv3UdPuPrYPyTEV8zXcHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2019-04-10 at 19:43 -0400, Paul Moore wrote:
> On Wed, Apr 10, 2019 at 1:04 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Wed, 2019-04-10 at 11:35 -0400, Paul Moore wrote:
> > > On Wed, Apr 3, 2019 at 8:43 AM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > Replace binder_test.c with separate manager, client and service
> > > > provider.
> > > > This works in the same way as a service provider/client
> > > > interacts
> > > > with a service manager in the Android world. It passes the
> > > > service
> > > > providers binder file descriptor to the client for the
> > > > impersonate
> > > > permission check.
> > > > 
> > > > Also added tests for Dynamically Allocated Binder Devices and
> > > > passing
> > > > the sender SELinux security context on binder transactions.
> > > > 
> > > > Note that the tests require a minimum kernel of 4.16, else some
> > > > tests may
> > > > fail. To run successfully the "binder: Add thread->process_todo
> > > > flag"
> > > > patch may be required that is available from:
> > > > https://lore.kernel.org/patchwork/patch/851324/
> > > > This patch has been backported to some earlier kernels.
> > > > 
> > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > ---
> > > >  defconfig                       |   3 +
> > > >  policy/test_binder.te           | 176 ++++----
> > > >  tests/binder/.gitignore         |   6 +-
> > > >  tests/binder/Makefile           |  13 +-
> > > >  tests/binder/binder_common.c    | 155 +++++++
> > > >  tests/binder/binder_common.h    |  37 ++
> > > >  tests/binder/check_binder.c     |  27 +-
> > > >  tests/binder/check_binderfs.c   |  53 +++
> > > >  tests/binder/client.c           | 450 ++++++++++++++++++++
> > > >  tests/binder/manager.c          | 362 ++++++++++++++++
> > > >  tests/binder/service_provider.c | 404 ++++++++++++++++++
> > > >  tests/binder/test               | 257 ++++++++++--
> > > >  tests/binder/test_binder.c      | 705 ------------------------
> > > > ----
> > > > ----
> > > >  13 files changed, 1785 insertions(+), 863 deletions(-)
> > > >  create mode 100644 tests/binder/binder_common.c
> > > >  create mode 100644 tests/binder/binder_common.h
> > > >  create mode 100644 tests/binder/check_binderfs.c
> > > >  create mode 100644 tests/binder/client.c
> > > >  create mode 100644 tests/binder/manager.c
> > > >  create mode 100644 tests/binder/service_provider.c
> > > >  delete mode 100644 tests/binder/test_binder.c
> > > 
> > > Hi Richard,
> > > 
> > > Welcome back :)
> > > 
> > > I had hoped to spend some time reading up on Binder so I could
> > > give
> > > this a proper review, but that hasn't happened so I'm inclined to
> > > merge it, assuming it works on my test system.  However,
> > > considering
> > > your comment about this not working on kernel's older than 4.16,
> > > I
> > > think we should probably add some checks to only run this test on
> > > systems with the appropriate kernel support.
> > > 
> > > If you look at tests/Makefile you will see a number of distro
> > > specific
> > > test list modifications, and there is even an example of checking
> > > the
> > > kernel version (search for "kvercmp" in the Makefile).  I would
> > > suggest a simple check to make sure the kernel is at least v4.16,
> > > and
> > > if we find distro specific support (e.g. a particular distro
> > > backported the listed patch) we can always add an exception for
> > > that
> > > distro.
> > > 
> > > How does that sound?
> > 
> > There are tests for the OS in the 'test' script already. I guess
> > you
> > need to check if these are okay, as I check if < 4.16 and if so
> > print
> > message saying if fail check for the patch.
> 
> Ah ha, yes you did, and I missed it.  Sorry about that.  I checked
> the
> Makefiles, didn't see any checks, and wrongly assumed they were not
> there.
> 
> Looking quickly at the check it seems reasonable, if I notice any
> problems when testing I'll let you know.
> 
> > I'm not sure this will get to the list as I appear to be black-
> > balled.
> > I did send a cover letter with this patch + another one regarding
> > running SCTP on < 4.20.17. I sent email to
> > owner-selinux@vger.kernel.org but not heard anything yet.
> 
> Hmm, that's not good.  FWIW, the original patch obviously made it,
> but
> yes I'm not seeing your response in the list archives.  Did you get
> any sort of majordomo hate mail back on your posts, or is is just
> silently dropping your messages?

Just silently dropping messages. I had thought to remove from list then
add again, however it might smell a rat so left until owner-selinux
returns. I can only repeat what Julius Caesar muttered "Infamy! Infamy!
They've all got it in for me!" (well in Carry On Cleo any way).

> 
> > Cover Letter:
> > Subject: [PATCH 0/1] selinux-testsuite: Update binder test
> > applications
> > 
> > The Binder tests have been rewritten to support the new Dynamically
> > Allocated Binder Devices and passing the sender SELinux security
> > context on binder transactions.
> > 
> > They have been tested on f29 and rawhide with the following kernels
> > from kernel.org:
> > mainline: 5.1-rc3
> > longterm: 4.19.32
> > longterm: 4.14.109
> > 
> > As noted in the main patch, the tests require a minimum kernel of
> > 4.16,
> > else some tests may fail (tests 4 & 7). To run successfully the
> > 4.14.109 kernel was patched with: "binder: Add thread->process_todo
> > flag" available from:
> > https://lore.kernel.org/patchwork/patch/851324/
> > 
> > I found that on slow systems using 4.14.109, all tests would pass,
> > however when testing on a faster system they would fail. Once
> > patched,
> > worked fine.
> > 
> > Any testing feedback gratefully received.
> > 
> > Richard

