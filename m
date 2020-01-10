Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B18C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B047B2077C
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="L22CFZt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgAJO2i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:28:38 -0500
Received: from mailomta22-sa.btinternet.com ([213.120.69.28]:27406 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727420AbgAJO2i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 09:28:38 -0500
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20200110142834.ITUX22185.sa-prd-fep-043.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Fri, 10 Jan 2020 14:28:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1578666514; 
        bh=Qq+8w+F0Xv1B67qGORpKbotfgQhEBFOR2sBybGGQgQM=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=L22CFZt508Hk7DdnhT+fiT1HLDFu9V13FB1oFXqOH4ycN2NK4tODjLE97h3+M+b+aMVPDJgWsTt8lzB7TRXGrbdTD7sU2QPZQefTNwFZUHbkOx2Lsl2+HQ+mZqPjLC2iLJyPCCEKhYK/VunxzPT1EFrzV0CZO8oSse/yDTMW+7gbZDxUtLPr2WgJ2W5p/BAR28GYHn5V7xdCpqY+uyYQVvd6ZLp9JO6fPYjuD4q9QPK6lSc80mBeE/lDUP+t/9vn1wZb/tkg238pWVTkM0CBpaAECvYXanc2XUqAVY0OeRxYVbnsYtgyBWoLaQIUB2n82Qm1ITnd/lkquenDT8uwLw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.251]
X-OWM-Source-IP: 86.134.6.251 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvdeifedgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdeirddvhedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirddvhedupdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.251) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DF778260427736E; Fri, 10 Jan 2020 14:28:34 +0000
Message-ID: <f3d68d625b9a7340ad8354927223fb30a81152a3.camel@btinternet.com>
Subject: Re: [PATCH V2 0/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Date:   Fri, 10 Jan 2020 14:28:33 +0000
In-Reply-To: <CAFqZXNvKgGfbcmaMExG6HK=nmeS22VCSumjAZMqSaNzxC+0Qfg@mail.gmail.com>
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
         <7281d970-cd5d-aee9-c790-fbf5951273d6@tycho.nsa.gov>
         <4eefc9594eec6010c8427a3308e5e3c3fdabbf3b.camel@btinternet.com>
         <CAFqZXNvKgGfbcmaMExG6HK=nmeS22VCSumjAZMqSaNzxC+0Qfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-01-09 at 22:01 +0100, Ondrej Mosnacek wrote:
> On Thu, Jan 9, 2020 at 9:36 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Thu, 2020-01-09 at 13:04 -0500, Stephen Smalley wrote:
> > > On 1/9/20 10:07 AM, Richard Haines wrote:
> > > > These tests should cover all the areas in selinux/hooks.c that
> > > > touch
> > > > the 'filesystem' class. Each hooks.c function is listed in the
> > > > 'test'
> > > > script as there are some permissions that are checked in
> > > > multiple
> > > > places.
> > > > 
> > > > Tested on Fedora 31 and Rawhide (5.5 for the new watch perm).
> > > > 
> > > > V2 Changes:
> > > > 1) If udisks(8) daemon is running, stop then restart after
> > > > tests.
> > > > The tests
> > > >     run faster and stops the annoying habit of adding mounts to
> > > > the
> > > > 'files'
> > > >     app on the desktop. Supports /usr/bin/systemctl or
> > > > /usr/sbin/service
> > > >     More importantly it stops interferance with the '*context='
> > > > tests as it
> > > >     can cause intermittent failures. Tested by running 'test'
> > > > in a
> > > > continuous
> > > >     loop with udisks enabled, and then again disabled.
> > > >     Loop 200 times, with udisks failed between 1 to 70
> > > > iterations,
> > > > without
> > > >     udisks, no failures.
> > > 
> > > Wondering why udisks is causing failures - that seems like
> > > another
> > > bug.
> > 
> > With udisk2 enabled, 99% of the time the 'rootcontext=' test fails
> > (the
> > 1% is 'defcontext='). However if I run this test on its own, it
> > does
> > not fail. If I add the 'context=' test before and run, the
> > 'rootcontext=' will fail at some point.
> > 
> > If I add a short delay as shown in the 'context=' sequence, the
> > fault
> > does not occur:
> > -- Start --
> > system("losetup -d $dev 2>/dev/null");
> > system("sleep 0.01");
> > get_loop_dev();
> > attach_dev();
> 
> Can you try putting `udevadm settle` instead of the sleep there? I
> remember having some issues with udev race conditions a long time ago
> and I think that helped. (But I'm not sure at all if that's the right
> fix...)

Thanks - I had to add this to a couple of places and worked okay for
200 interations on Rawhide.

On the next patch version would you like the
udisks2_stop()/udisks2_restart() functions removed, left as is or set
as an option for the test when run locally ??

> 
> > # Mount again with no xttr support
> > $context2_opts =
> > "context=system_u:object_r:test_filesystem_context_t:s0";
> > -- End --
> > 
> > It could be udisk2 has a timing problem as the losetup(8) man page
> > '-d'
> > entry reads:
> > Note that since Linux v3.7 kernel uses "lazy  device destruction".
> > The
> > detach operation does not return EBUSY error anymore if device is
> > actively used by system, but it  is  marked by autoclear flag and
> > destroyed later.
> > 
> > But then again it could be something else !!!!
> > 
> > 

