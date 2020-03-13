Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47813C10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 18:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1EE20674
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 18:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="AcVZu7Hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCMSSV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:18:21 -0400
Received: from mailomta13-sa.btinternet.com ([213.120.69.19]:36098 "EHLO
        sa-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726303AbgCMSSV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 14:18:21 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20200313181818.VLDB1599.sa-prd-fep-041.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 13 Mar 2020 18:18:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1584123498; 
        bh=p75iKeGt2teRdDEyK9nPT/SbLd34R8G2WKH3jI/Dgnc=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=AcVZu7HjfiINUoD+P9qHZi0jp0hchHMlFc0P3+Iw8JDUf4EJY9nmstUbTZq8rXit/t1T6FjWRio7mS0oRl/v/sMkYfeBAX6Y/HienrYuJKGlpn5gH0GowHkiVG/e9/WdR0llW8c6tz9k6EbGboGUuiwVRsYdqdwixfnzI70EpK/5jQtDfV6MlzVRXlGIAB5c9sFu3LizpYUMPbzWUBAvGyqq0Yxe+bHi2a66zkaTrSd6HRQ8jyz4VQtbtFx+d7T9alp8WQlsEWZex8r3XB03spOiAadmxk7tVIdVuESma1lf4GzaW/L2pqDtbspiNozCEW6j8qpQQis6FojBNecDaA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.56.193]
X-OWM-Source-IP: 31.49.56.193 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedruddvjedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepfedurdegledrheeirdduleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehiedrudelfedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsmhgrhihhvgifsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehsthgvphhhvghnrdhsmhgrlhhlvgih
        rdifohhrkhesghhmrghilhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.56.193) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A268A05C06977; Fri, 13 Mar 2020 18:18:18 +0000
Message-ID: <280fe687e65a9e316d4637281f31c9cf7adfdf5f.camel@btinternet.com>
Subject: Re: [PATCH 0/2] selinux-testsuite: Use native filesystem for tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Date:   Fri, 13 Mar 2020 18:18:17 +0000
In-Reply-To: <CAEjxPJ4D7odh+f4mx==Z1YPV0=XtdLY2B9wTvfO-p4d7FZyzug@mail.gmail.com>
References: <20200312113637.20355-1-richard_c_haines@btinternet.com>
         <CAEjxPJ7Ds4J=7hO9K-B1pLXUfCgx4vFbMth-3nQW9x_4xV7S0Q@mail.gmail.com>
         <CAEjxPJ7kjzaj4bz9=_oTJrLAYmDKfMZsC_eAGDj_N7Kbxm=omg@mail.gmail.com>
         <CAEjxPJ4D7odh+f4mx==Z1YPV0=XtdLY2B9wTvfO-p4d7FZyzug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2020-03-13 at 13:21 -0400, Stephen Smalley wrote:
> On Fri, Mar 13, 2020 at 12:04 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Fri, Mar 13, 2020 at 11:47 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Thu, Mar 12, 2020 at 7:37 AM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > If you test on the selinux-next kernel (that has the XFS patch
> > > > [1]) with
> > > > the "NFS: Ensure security label is set for root inode" patch
> > > > [2], then all
> > > > tests should pass. Anything else will give varying amounts of
> > > > fails.
> > > > 
> > > > The filesystem types tested are: ext4, xfs, vfat and nfs4.
> > > > 
> > > > I've revamped the nfs.sh to handle tests that require specific
> > > > mount
> > > > options, these plus many more are now in tests/nfs_filesystem.
> > > > This only
> > > > gets run by nfs.sh.
> > > > 
> > > > There are two minor workarounds involving multiple mounts
> > > > returning EBUSY.
> > > > These are either bugs or features.
> > > > 
> > > > [1] 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
> > > > [2] 
> > > > https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/
> > > 
> > > Still failing for me:
> > > filesystem/test ............. 13/27 Failed mount(2): Permission
> > > denied
> > > filesystem/test ............. 18/27
> > 
> > Sorry, that's on me.  Wrong kernel.  Will retry...
> 
> Same failures with the right kernel.  If I am reading it correctly,
> the first failure is on this test:
> 
> print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> print "Using mount options:\n\t$mount_opts\n";
> $result = system(
> "runcon -t test_filesystem_no_getattr_t $basedir/mount -s $dev -t
> $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
> );
> ok( $result eq 0 );
> 
> Looks like the denial was:
> type=SYSCALL msg=audit(03/13/2020 13:11:37.805:1605) : arch=x86_64
> syscall=mount success=no exit=EACCES(Permission denied)
> a0=0x7ffc28975328 a1=0x7ffc2897536b a2=0x7ffc28975386 a3=0x0 items=14
> ppid=15745 pid=15886 auid=sds uid=root gid=root euid=root suid=root
> fsuid=root egid=root sgid=root fsgid=root tty=pts0 ses=1 comm=mount
> exe=/mnt/selinux-testsuite/tests/filesystem/mount
> subj=unconfined_u:unconfined_r:test_filesystem_no_getattr_t:s0-
> s0:c0.c1023
> key=(null)
> type=AVC msg=audit(03/13/2020 13:11:37.805:1605) : avc:  denied  {
> search } for  pid=15886 comm=mount name=sds dev="0:49" ino=17039361
> scontext=unconfined_u:unconfined_r:test_filesystem_no_getattr_t:s0-
> s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_dir_t:s0 tclass=dir
> permissive=0

So far I have not managed to see this problem before or after a
restorecon. I'll investigate further and see what I can find !!!


