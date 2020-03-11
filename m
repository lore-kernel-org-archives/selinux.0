Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7527DC0044D
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 17:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B6720738
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 17:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Kw0hg4//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgCKRwy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:52:54 -0400
Received: from mailomta2-re.btinternet.com ([213.120.69.95]:54692 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730468AbgCKRwx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 13:52:53 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200311175251.MBMJ3071.re-prd-fep-048.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 11 Mar 2020 17:52:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1583949171; 
        bh=5PuI45Z93QjbUn5YQtk0hOdXspx+vmtHRN7rhpnEKSs=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=Kw0hg4//poB0QXaaPHsIxQT9I7zAGSvkbcFPsxSjWvH28aU9SMzQnYR2kgC71aRuU46lkhP+opsz3qlJfZ/Ta4k5R9zKTS4FhGxDEfxeFw0eJOh8r1ut9XEuuuAWrT7CzKLbGN84HuQmsPlfyE64M2aus0tnpvzh3ur3ddVeO6P0nVmMuqZI+zRwbVHaD/Y0H+HH+lCMevGQpT7fcz9x9TC47aLK6A4AVeUN0scGQJ8LV2cd3xElJ6THpeYM0TYYoECDjwyyK7yE2R/tTSZwXZh7XIloyw+In3BpPS22DVYfpyOBXiMX8QVVCH+8/6QlA1+3TUBVVa+ksEWEqYKUpA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.4.28]
X-OWM-Source-IP: 86.134.4.28 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedruddvvddguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpeihmhhlrdihohhupdhtrhgrvhhishdqtghirdhorhhgnecukfhppeekiedrudefgedrgedrvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrgedrvdekpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshhmrgihhhgvfiesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeoshhtvghphhgv
        nhdrshhmrghllhgvhidrfihorhhksehgmhgrihhlrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.4.28) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A15B605673CB3; Wed, 11 Mar 2020 17:52:51 +0000
Message-ID: <5b317d8b29fbf7d56238a136254b53b042becf96.camel@btinternet.com>
Subject: Re: [RFC V3 PATCH 0/2] selinux-testsuite: Use native filesystem for
 tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Date:   Wed, 11 Mar 2020 17:52:50 +0000
In-Reply-To: <CAEjxPJ4USNdqFY40vPnviLPHSZR22Tpq0y1L+LauJenKXRw6HA@mail.gmail.com>
References: <20200310162456.32240-1-richard_c_haines@btinternet.com>
         <CAEjxPJ4USNdqFY40vPnviLPHSZR22Tpq0y1L+LauJenKXRw6HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-03-11 at 10:55 -0400, Stephen Smalley wrote:
> On Tue, Mar 10, 2020 at 12:25 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > If you test on the selinux-next kernel (that has the XFS patch [1])
> > with
> > the "NFS: Ensure security label is set for root inode" patch [2],
> > then all
> > tests should pass. Anything else will give varying amounts of
> > fails.
> > 
> > The filesystem types tested are: ext4, xfs, vfat and nfs4.
> > 
> > I've revamped the nfs.sh to handle tests that require specific
> > mount
> > options, these plus many more are now in tests/nfs_filesystem. This
> > only
> > gets run by nfs.sh.
> 
> I don't really understand why you moved tests that could only be run
> from nfs.sh out of it into
> tests/nfs_filesystem?

I only moved them as it seemed more in keeping with the testsuite.
Would you prefer them in the shell script ? I don't mind either way.

> 
> > There are two minor workarounds involving multiple mounts returning
> > EBUSY.
> > These are either bugs or features.
> > 
> > Not tested on travis.
> 
> travis will require you to add the new dependencies to the packages
> list in .travis.yml.  You can test this yourself by
> pushing a branch with your changes to your own clone on GitHub and
> checking travis-ci.org for the result.

I've added these to .travis.yml
      - xfslibs-dev
      - uuid-dev

