Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FBCC33CA9
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 18:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864062081E
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 18:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="KoVc0J2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgAMSel (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 13:34:41 -0500
Received: from mailomta27-sa.btinternet.com ([213.120.69.33]:53418 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728516AbgAMSek (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 13:34:40 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200113183437.QGBX8264.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Mon, 13 Jan 2020 18:34:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1578940477; 
        bh=sw9+cC2XqVr4FGEw47p5ZI2F2+nT4yrs0WH9uGqz/pE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=KoVc0J2+r7OUJ+AbvFn8MLaXfKxFJHMTyUqosEayyykH5pdn0+dHobTHH7LcKEMlEMapXlWNf2OWGOcPLXp4NVvgnd5f78Q4/HQ5xNmXu07MLOnxmbJ/L7PSnJYoQycOWU2oPSdRSqknK8uQL9hmdjCTWQauziailmD4uvDVMJW08pBK6ykhreAR0VNTAeX1c2ZfHgFiW5MA6nIg/LNa53t3YRHPp2Y8fsd2thM8GsMStOxManReZxs/+G59RCaxQ06PVQ12MBDNpDSKMF/nTrMqWixB36sDV8OPgH/pfHOmnq9WywNbr4LjUDbxPhBVJzvsCn67kyfcdDuLDpQXWQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.60.79]
X-OWM-Source-IP: 31.49.60.79 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvdejtddgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledriedtrdejleenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdeitddrjeelpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.60.79) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D8362CD1470A93D; Mon, 13 Jan 2020 18:34:37 +0000
Message-ID: <0a99ab5d50a8fead752f8bcb05bacdc4e152afd2.camel@btinternet.com>
Subject: Re: [PATCH V3 0/1] selinux-testsuite: Add filesystem tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Date:   Mon, 13 Jan 2020 18:34:37 +0000
In-Reply-To: <e0f09965-4e23-172f-568f-ea906672e5fd@tycho.nsa.gov>
References: <20200112192432.862800-1-richard_c_haines@btinternet.com>
         <e0f09965-4e23-172f-568f-ea906672e5fd@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-01-13 at 11:57 -0500, Stephen Smalley wrote:
> On 1/12/20 2:24 PM, Richard Haines wrote:
> > These tests should cover all the areas in selinux/hooks.c that
> > touch
> > the 'filesystem' class. Each hooks.c function is listed in the
> > 'test'
> > script as there are some permissions that are checked in multiple
> > places.
> > 
> > Tested on Fedora 31 and Rawhide (5.5 for the new watch perm).
> > 
> > V3 Changes:
> > 1) Lots of minor updates.
> > 2) Add 'udevadm settle' as suggested by Ondrej to resolve udisks(8)
> > issue.
> > 3) Add stopping udisks(8) daemon as a '-d' option.
> > 4) Add file quotaon test.
> > 5) Add test for name type_transition rule.
> > 6) Fix setfscreatecon(3) test to create a directory and check
> > context.
> > 7) Use kernel_dontaudit_setsched() as explained in [1].
> > 
> > The only thing I have not done is cutting the clutter in the logs.
> > Tried
> > various things, all failed. Ideas !!!!
> 
> Looks like at least the y2038 warnings were removed in v5.4 so don't 
> need to worry about those.  If they show up in a future kernel again,
> we 
> can avoid them by creating ext4 filesystems with inodes > 128 bytes
> ala 
> -I 256.

I'll add -I 256 in v4 just in case

> 

