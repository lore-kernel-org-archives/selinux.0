Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCDFC0044D
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6AC20735
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="WJ6XO7KS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgCKSO4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:14:56 -0400
Received: from mailomta1-re.btinternet.com ([213.120.69.94]:41558 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730524AbgCKSO4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 14:14:56 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20200311181452.IAIC28880.re-prd-fep-042.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 11 Mar 2020 18:14:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1583950492; 
        bh=ifpyMWEmQt06tPbflk67pEut2Eixcpi1g48H34uC90o=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=WJ6XO7KSs6sxxzcgyCXKbZL70yTBtQENwUwx6QiM0vksM7Fi3K8BIL+RDE8hT3T8lxXrAm6+ECAwUyzJP542D6kpCcBDQ/BBO2Saq+QZI1QIM7Gq5NbRZOZhjmxjKud+wDMT2thrbXSZ5PeGYWlB5bPYe+71ajaP4PiaAq3QWxDTEg+up1Q+spYJBu/vNUddedbl/EQZzy/lxw6Mt+z52BkOONSoteKtpu58Lb5eJ6tmkW4s2qsNcYxl0mDXM42Mo+GTdRk1E6AtgDKfb4DfYTY67QfmtUDCEGVtpS8wPszwiH4cmpVGT26kUKRycjpau7k0mQjLAkt9ZPgHUUAetQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.4.28]
X-OWM-Source-IP: 86.134.4.28 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedruddvvddguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirddufeegrdegrddvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdegrddvkedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsmhgrhihhvgifsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehsthgvphhhvghnrdhsmhgrlhhlvgihrdif
        ohhrkhesghhmrghilhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.4.28) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A16DE056899FB; Wed, 11 Mar 2020 18:14:52 +0000
Message-ID: <81c75bff0cd0b8d4d56e28a7ada43589b216adc5.camel@btinternet.com>
Subject: Re: [RFC V3 PATCH 0/2] selinux-testsuite: Use native filesystem for
 tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Date:   Wed, 11 Mar 2020 18:14:52 +0000
In-Reply-To: <CAEjxPJ4ES3fsDsWbyz+35a+TUW1PfBSQTL37m8SOdJx74NsQqw@mail.gmail.com>
References: <20200310162456.32240-1-richard_c_haines@btinternet.com>
         <CAEjxPJ69FMkO=X4fxMvgF1F7rsv9ZsEaJemgFzkuvzRWrgfUNg@mail.gmail.com>
         <6b43f33ac519bbeaa42a79125e2e97e9823ec8f9.camel@btinternet.com>
         <CAEjxPJ4ES3fsDsWbyz+35a+TUW1PfBSQTL37m8SOdJx74NsQqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-03-11 at 13:53 -0400, Stephen Smalley wrote:
> On Wed, Mar 11, 2020 at 12:54 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Wed, 2020-03-11 at 12:02 -0400, Stephen Smalley wrote:
> > > On Tue, Mar 10, 2020 at 12:25 PM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > [1]
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
> > > > [2]
> > > > https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/
> > > 
> > > Even with the patches above applied, I am seeing failures during
> > > the
> > > tests/nfs_filesystem tests:
> > 
> > Looks like my /mnt was mis-labeled. I've fixed and had to add this
> > to
> > test_filesystem.te:
> > 
> > files_mounton_non_security(filesystemdomain)
> > 
> > and now works okay. Could you confirm please, then I'll resend new
> > patch later
> 
> With that change to policy and no other changes, it then fails
> earlier
> during fs_filesystem/test as shown below even
> though the kernel does have the referenced patch (and it passes if I
> revert that policy change).  Also, I noticed that
> as it is running the tests for filesystem and fs_filesystem, it shows
> a question mark (?) as the total/planned number of tests,
> suggesting a problem with the plan.

I've tried to fix this and failed !!. It seems that because I have to
load the subroutines from Filesystem.pm before doing plan tests =>
$test_count;, it gets upset, hence the ?.

> 
> ...
> filesystem/test ............. ok
> 
> #   Failed test 'Failed as kernel 5.6.0 without "selinux: fix
> regression introduced by move_mount(2) syscall" patch'
> #   at fs_filesystem/test line 752.
> # Looks like you failed 1 test of 26.
> fs_filesystem/test ..........
> Dubious, test returned 1 (wstat 256, 0x100)
> Failed 1/26 subtests

Looks like this is too open. I'll fix later
files_mounton_non_security(filesystemdomain)

> 
> Test Summary Report
> -------------------
> fs_filesystem/test        (Wstat: 256 Tests: 26 Failed: 1)
>   Failed test:  22
>   Non-zero exit status: 1
> Files=63, Tests=623, 161 wallclock secs ( 0.33 usr  0.90 sys +  2.76
> cusr 46.78 csys = 50.77 CPU)
> Result: FAIL
> Failed 1/63 test programs. 1/623 subtests failed.

