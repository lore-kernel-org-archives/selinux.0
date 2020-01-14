Return-Path: <SRS0=4X/7=3D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17382C33CB1
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 12:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFAD214AF
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 12:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="QTMTeWRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgANMIl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:08:41 -0500
Received: from mailomta8-sa.btinternet.com ([213.120.69.14]:61191 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgANMIl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jan 2020 07:08:41 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20200114120839.VGHX11798.sa-prd-fep-040.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Tue, 14 Jan 2020 12:08:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1579003719; 
        bh=2ywZ1EWSbQyjqkiYb2xJT3W8Rr6ZgfGrDuTbqDuInL8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=QTMTeWRO3uc4inju6o5u/qJpaynWX+9r/1Fz54/wTZkQfC9gbEJYXAudAMYLbJuqSCAhhMeprIdSGsOqzs3TIYWqvqAxdr2EPDSEeyYr2DGDZTrZI2IEj48Jw2bRsBCY7VCZvlrUt+7ztq4qC8Pm/wIXnASe/cVi9QFKA/S/+l02dGRxwzkhBQVe/0ktF4LSv0KIVGTZsQlARCCD+OUlByynkakWbDKyjIlw0+okrNcDA8u0Nkfno5kEqXDekSLQOuWZy7dZcQgLiAf2JXNBu9lxp9yBrOh3FKD1yayODztr/aTAhXaCkeJ1h70ODBOMFTGt54kcXoV1DKXWuJXfNg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.60.240]
X-OWM-Source-IP: 31.49.60.240 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrtddtgddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledriedtrddvgedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledriedtrddvgedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.60.240) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DF93CE104A4876F; Tue, 14 Jan 2020 12:08:39 +0000
Message-ID: <d3f5277099d63f1c68269444a29beadaf248b34a.camel@btinternet.com>
Subject: Re: [PATCH V3 1/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Date:   Tue, 14 Jan 2020 12:08:38 +0000
In-Reply-To: <d68f2230-38da-ef6a-fa67-5631fb88f9a0@tycho.nsa.gov>
References: <20200112192432.862800-1-richard_c_haines@btinternet.com>
         <20200112192432.862800-2-richard_c_haines@btinternet.com>
         <02e4c12e-7cf9-2b10-cc3e-f1570a0c35c0@tycho.nsa.gov>
         <5c01146696d7e5e5e9132c10b9121a2830758914.camel@btinternet.com>
         <d68f2230-38da-ef6a-fa67-5631fb88f9a0@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-01-13 at 14:01 -0500, Stephen Smalley wrote:
> On 1/13/20 1:32 PM, Richard Haines wrote:
> > On Mon, 2020-01-13 at 10:45 -0500, Stephen Smalley wrote:
> > > On 1/12/20 2:24 PM, Richard Haines wrote:
> > > > Test filesystem permissions, setfscreatecon(3), file { quotaon
> > > > }
> > > > and
> > > > changing file context via 'name type_transition rule'.
> > > > 
> > > >   From kernels 5.5 filesystem { watch } is also tested.
> > > > 
> > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > 
> > > Aside from the travis-ci build failure when trying to build the
> > > test
> > > policy against upstream refpolicy, this looks good to me.  NB you
> > > can
> > > reproduce such failures yourself by creating your own github
> > > clone
> > > of
> > > selinux-testsuite, enabling travis-ci on your clone, and pushing
> > > your
> > > change to a branch of our clone.
> > > 
> > > Possible room for improvement (but I won't insist) might include:
> > > - test non-name based type transition rule with a different type
> > > and
> > > confirm that both files are createdi in the right type (i.e. make
> > > sure
> > > we are actually matching on the component name),
> > > - test two different name-based type transition rules that only
> > > differ
> > > in name (similar),
> > > - add tests for the new mount API, fsopen(), fspick(), fsmount().
> > > 
> > > These could all be done as separate patches later.
> > 
> > If you are in no hurry for these tests I'll do them for V4.
> > 
> > I found a helpful example in samples/vfs/test-fsmount.c for fsmount
> > and
> > fsopen. Also see they were added in 5.1
> 
> Up to you; they can always be done as a separate follow-up patch
> later.
> The new syscalls don't appear to have been wired up until v5.2.

After some thought and play time I've come to the following:
1) I'll submit V4 with the non & named-based trans rules + other
changes today.
2) As tests/filesystem is testing mount(2) / umount(2) I thought it
best to submit a separate patch for the new fs* apis and put them in
tests/fs_filesystem for 5.2


