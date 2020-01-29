Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CE4C2D0DB
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 12:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F4C20716
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 12:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Y0CS7LwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgA2M4R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:56:17 -0500
Received: from mailomta4-sa.btinternet.com ([213.120.69.10]:61367 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726069AbgA2M4R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 07:56:17 -0500
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200129125614.BOFS28550.sa-prd-fep-044.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
          Wed, 29 Jan 2020 12:56:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580302574; 
        bh=CVBx6jPfH3/TJUXoPjq2l8e6FnYe1KDRMUbCCrpY+/c=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=Y0CS7LwFR+I9XfDr57p8tZT4q4dPn+DMAGtaJiOpWNCtG58zTO0CCaT7KKH8WG7r5I17P6BFlwLJDTQ+uLae8Ch5CYjXDsq5TqtZ5x0pY5RtpdbrMyElJnHCC9D8T7gHAMzBwzhOpahSQCFfqSEMf/ciYD6Ym72pQiEKzrhWECqmAH2xUsOPXlz6P9i+MKbRyIMmmFv7MIpglR3e2l9LbvM9yBfYjpwvbOwR8jRVvt9HfM+bgXx7jtzHpIN/iLmE9ytUDqr4IusKl2raJnqGSuLIGzJO460c7EI7DXWrT1SMiEHv3ykM+E9SXkEJVatNyRtf92IuWLktgRWCVvxcuw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.71]
X-OWM-Source-IP: 86.134.6.71 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrfeeigdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddufeegrdeirdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirdejuddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehomhhoshhnrggtvgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
        gheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.71) by sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5E1A2CBA02C3142B; Wed, 29 Jan 2020 12:56:14 +0000
Message-ID: <a282f10df731b296be6575bb97ba76b15100203c.camel@btinternet.com>
Subject: Re: [PATCH V2 0/2] selinux-testsuite: Add fs*(2) API filesystem
 tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Jan 2020 12:56:13 +0000
In-Reply-To: <29631d39-9d64-71b4-5fb7-8a0180466f73@tycho.nsa.gov>
References: <20200127093249.3143-1-richard_c_haines@btinternet.com>
         <29631d39-9d64-71b4-5fb7-8a0180466f73@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-01-27 at 12:46 -0500, Stephen Smalley wrote:
> On 1/27/20 4:32 AM, Richard Haines wrote:
> > These patches update the current tests/filesystem to share code
> > (patch 1)
> > with the fs*(2) API filesystem tests (patch 2).
> > 
> > V2 Changes:
> > 1) If kernel patch [1] installed move_mount test for denying
> > FILE__MOUNTON
> >     should pass. If not installed, display 'Failed as kernel 5.x
> > without
> >     "selinux: fix regression introduced by move_mount(2) syscall"
> > patch'
> >     (as there is a regression that should be fixed).
> >     Note: Kernels 5.2 - 5.5 will fail unless [1] backported. 5.6 is
> > expected
> >     to have [1].
> > 2) Move policy changes to patch 2.
> 
> These look ok to me; we'll see if anyone else objects to the error
> message.
> 
> One other item that occurred to me is that most of the current 
> filesystem and fs_filesystem tests are only exercising ext4
> regardless 
> of the native filesystem in which you run the testsuite (e.g. if I
> run 
> it on a labeled NFS mount most of the tests end up running in the
> ext4 
> filesystem that is created and mounted rather than on labeled NFS 
> itself, and likewise if I run it on xfs or btrfs or ...).  For tests 
> where it does not matter (e.g. the type_transition tests) it might
> be 
> better to run those on the host/native filesystem directly so we can 
> more readily reuse those tests.  Obviously the mount tests
> themselves 
> require some other filesystem besides the one in which the testsuite 
> itself resides.  Don't know if people may want to make it easier to 
> substitute or add additional filesystem types for testing; you
> already 
> provide a fs_type variable in the test script but that requires
> patching 
> the script and still only supports testing one filesystem type at a
> time.

I'll do some work on making the tests use the native filesystem and add
an option to select a different one.
I quess I could add a list of fs to run against from relevant
proc/filesystems entries? (or something else)

I had a go with xfs and found Fedora is configured by default to use
the xfs quota system, however that does not call security hooks
security_quota_on or security_quotactl so not worth testing, otherwise
apart from increasing the block size seems okay.

I also have another patch ready as I noticed that I missed these:
hooks.c selinux_path_notify() FILE__WATCH_SB
hooks.c selinux_path_notify() FILE__WATCH_MOUNT

> 
> > [1] 
> > https://lore.kernel.org/selinux/20200117202407.12344-1-sds@tycho.nsa.gov
> > 
> > Richard Haines (2):
> >    selinux-testsuite: Prepare for adding fs*(2) API tests
> >    selinux-testsuite: Add fs*(2) API filesystem tests
> > 
> >   policy/test_filesystem.te        |  18 +-
> >   tests/Makefile                   |   6 +
> >   tests/filesystem/Filesystem.pm   | 166 ++++++
> >   tests/filesystem/test            | 219 ++------
> >   tests/fs_filesystem/.gitignore   |   3 +
> >   tests/fs_filesystem/Makefile     |  16 +
> >   tests/fs_filesystem/fs_common.c  | 110 ++++
> >   tests/fs_filesystem/fs_common.h  |  30 ++
> >   tests/fs_filesystem/fsmount.c    |  89 ++++
> >   tests/fs_filesystem/fspick.c     |  68 +++
> >   tests/fs_filesystem/move_mount.c |  76 +++
> >   tests/fs_filesystem/test         | 835
> > +++++++++++++++++++++++++++++++
> >   tools/check-syntax               |   2 +-
> >   13 files changed, 1455 insertions(+), 183 deletions(-)
> >   create mode 100644 tests/filesystem/Filesystem.pm
> >   create mode 100644 tests/fs_filesystem/.gitignore
> >   create mode 100644 tests/fs_filesystem/Makefile
> >   create mode 100644 tests/fs_filesystem/fs_common.c
> >   create mode 100644 tests/fs_filesystem/fs_common.h
> >   create mode 100644 tests/fs_filesystem/fsmount.c
> >   create mode 100644 tests/fs_filesystem/fspick.c
> >   create mode 100644 tests/fs_filesystem/move_mount.c
> >   create mode 100755 tests/fs_filesystem/test
> > 

