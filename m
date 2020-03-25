Return-Path: <SRS0=pblC=5K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819A1C1975A
	for <selinux@archiver.kernel.org>; Wed, 25 Mar 2020 16:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1A52073E
	for <selinux@archiver.kernel.org>; Wed, 25 Mar 2020 16:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="mqrz15UK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgCYQIy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:08:54 -0400
Received: from mailomta29-re.btinternet.com ([213.120.69.122]:12149 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgCYQIx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Mar 2020 12:08:53 -0400
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20200325160850.WZTU26380.re-prd-fep-046.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 25 Mar 2020 16:08:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1585152530; 
        bh=lGBBZ/VckU626Y3ghY3ADKPZVPt2CL7Tr4k1o6ydZHg=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=mqrz15UKQK8pBQMMKeZJktxhZxrdPqoPiJ+tgxn5k61/Q0ZKMtipZm7+A+68gD5tGoibkZkyxeu5Xvh/p0qWka9u6BwgpPpOnghzO888y97F6YEs/zfl+EBC0FF7iNG1aMQz/PaTYzvPpOM68/rSBT9oIw1Zj2Feb5pSlYMMeTQuQ5VV71+Mx0EmguDpxl9L6uutvf8o2iz/U+rTAT9dj46XxeoscbdkXyt/5Mq8rVnHjq/ZzBGezFZOUrvfJOwTLesee5931c7opEXvCf0jEAQfDAWNqycpeK+paMiKNqYaOE76mA0c+DbKWhvxi0X1BaJe6Ah2KaM7cdsdqOf2Tg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [213.122.112.51]
X-OWM-Source-IP: 213.122.112.51 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrudehgedgheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrdduvddvrdduuddvrdehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepvddufedruddvvddrudduvddrhedupdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsmhgrhihhvgifsehrvggu
        hhgrthdrtghomheqpdhrtghpthhtohepoehsthgvphhhvghnrdhsmhgrlhhlvgihrdifohhrkhesghhmrghilhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (213.122.112.51) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A195F079C6F10; Wed, 25 Mar 2020 16:08:50 +0000
Message-ID: <4a97f14795186ed3fa539d277e1633cdeb1dd267.camel@btinternet.com>
Subject: Re: [PATCH V2 0/2] selinux-testsuite: Use native filesystem for
 tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Date:   Wed, 25 Mar 2020 16:08:49 +0000
In-Reply-To: <CAFqZXNs3_HXA1Mh0XXSFy-pmgbQKTBYhsGHP+qHH-tHdfxq8BQ@mail.gmail.com>
References: <20200325130900.15047-1-richard_c_haines@btinternet.com>
         <CAEjxPJ5K7Aa=6sJ236b1Qoa9VUePpEJyY=S0bNF2cm3Gd_dqMw@mail.gmail.com>
         <CAFqZXNs3_HXA1Mh0XXSFy-pmgbQKTBYhsGHP+qHH-tHdfxq8BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-03-25 at 16:38 +0100, Ondrej Mosnacek wrote:
> On Wed, Mar 25, 2020 at 3:55 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Mar 25, 2020 at 9:09 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > If tested on the selinux-next kernel (that has the XFS patch [1])
> > > with
> > > the "NFS: Ensure security label is set for root inode" patch [2],
> > > then all
> > > tests should pass. Anything else will give varying amounts of
> > > fails.
> > > 
> > > The filesystem types tested are: ext4, xfs, vfat and nfs4.
> > > 
> > > [1] 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
> > > [2] 
> > > https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/
> > 
> > Thanks, with this version of the patches, make test and
> > ./tools/nfs.sh
> > pass for me on the selinux next branch.
> > Still need to review all the changes and confirm that it is all
> > functioning as expected (e.g. getting the expected permission
> > denials).
> > Ondrej, how does this fare on RHEL-8, both with respect to
> > differences
> > there in policy/userspace and with respect to default use of
> > xfs instead of ext4?
> 
> Just checked - two of the filesystem tests fail there:
> 
> filesystem/test ............. 25/65
> #   Failed test at filesystem/test line 524.
> 
> #   Failed test at filesystem/test line 572.
> filesystem/test ............. 46/65 # Looks like you failed 2 tests
> of 65.
> filesystem/test ............. Dubious, test returned 2 (wstat 512,
> 0x200)
> Failed 2/65 subtests
> [...]
> Test Summary Report
> -------------------
> filesystem/test           (Wstat: 512 Tests: 65 Failed: 2)
>  Failed tests:  26, 29
>  Non-zero exit status: 2
> 
> In both cases the xfs_quotas_test program exits with 0, not with an
> error as expected.

I guess you don't have the XFS quota patch [1] installed. Best to use
the selinux-next kernel as that also has the NFS patch as well.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce

> 

