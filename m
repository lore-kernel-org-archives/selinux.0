Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C64C433E6
	for <selinux@archiver.kernel.org>; Sat, 23 Jan 2021 13:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DCF22AAF
	for <selinux@archiver.kernel.org>; Sat, 23 Jan 2021 13:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbhAWNkt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:40:49 -0500
Received: from mailomta12-re.btinternet.com ([213.120.69.105]:31391 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbhAWNks (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 23 Jan 2021 08:40:48 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20210123134005.EEZF30806.re-prd-fep-045.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Sat, 23 Jan 2021 13:40:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1611409205; 
        bh=qKxwPmI+VJt9NbL+iWKPQrXtWhf1y+ImeoxhhtT0/U0=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=idJvoH7c3ItocjbXex/FwVRgkVteFIlef+QKWUyyMR8TARHDu3a6lY+Fi4PNEbr8I3TmttuVQ19aXdwLFk3FT5FyQ/FUMW62Qn33znOsuw4sVqrCuR+/ryUVnue7S49AaDoBUGzWbrN26tJo82eBBuYXFPU5d6Mu+cpLYx/t6Le4pxmCH7G5xW/Ok8l/6YyI78NDLdJmj5ktjXDlZtYp4U/2ce/LpyhER5Y7eD88dROrmX89gWdyhyPkAIEcnxAtpuHg5gcnG5UMXrwfqE5kfVeFz21c/1B96KIScHPE785FpN5VqfjVDM0FngyA+9r+ApND9IlQJq2R9yCIK4Aufg==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C5062365CE37
X-Originating-IP: [109.158.127.107]
X-OWM-Source-IP: 109.158.127.107 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrudekgdehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepvdeiudfhvdejteffjeelvdeuvdehgffflefghfefleegieejjeelkeeljeejhfdvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepuddtledrudehkedruddvjedruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrudelkegnpdhinhgvthepuddtledrudehkedruddvjedruddtjedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoeguohhmihhnihgtkhdrghhrihhfthesuggvfhgvnhhsvggtrdhnlheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugidqrhgvfhhpohhlihgthiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
        pdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (109.158.127.107) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C5062365CE37; Sat, 23 Jan 2021 13:40:05 +0000
Message-ID: <beff39b090e852de30059d8c9b3f8914011363ae.camel@btinternet.com>
Subject: Re: [RFC PATCH 1/1] selinux-notebook: Add new section for Embedded
 Systems
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Date:   Sat, 23 Jan 2021 13:39:58 +0000
In-Reply-To: <CAHC9VhRXyA-g929Z+eam-gmYpzD=LeJV2W548_3GkHRyrZY0vw@mail.gmail.com>
References: <20210119105747.9680-1-richard_c_haines@btinternet.com>
         <20210119105747.9680-2-richard_c_haines@btinternet.com>
         <ypjleeihm5e0.fsf@defensec.nl>
         <8776cbb2687a09ed5b4e5b3cf0c50ade6c018fa6.camel@btinternet.com>
         <CAHC9VhRXyA-g929Z+eam-gmYpzD=LeJV2W548_3GkHRyrZY0vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2021-01-22 at 17:20 -0500, Paul Moore wrote:
> On Wed, Jan 20, 2021 at 7:37 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Tue, 2021-01-19 at 14:18 +0100, Dominick Grift wrote:
> > > Richard Haines <richard_c_haines@btinternet.com> writes:
> > > 
> > > > Add a new section and supporting examples for embedded systems.
> > > 
> > > Nice initiative, thanks. Looks pretty solid for a first
> > > iteration.
> > > 
> > > I wrote a document for OpenWrt here [1]. Basically the
> > > instructions
> > > needed
> > > to assemble OpenWrt from modules applicable to a particular
> > > system,
> > > but also how
> > > to build on top of it, or now to just fork it so that you can use
> > > it
> > > as
> > > a base for your own policy.
> > > 
> > > [1]
> > > https://github.com/doverride/openwrt-selinux-policy/blob/master/README.md
> > > 
> > > I am currently pretty happy with the results so far (its a work
> > > in
> > > progress, and there are known loose ends)
> > > 
> > > One of the differences compared with android is that SELinux is
> > > not
> > > tightly integrated in OpenWrt, and so most of the tough aspects
> > > are
> > > addressed in policy
> > > rather than adding selinux-awareness all over. SELinux in OpenWrt
> > > is
> > > therefore
> > > fairly self-contained and considering the challenges fairly
> > > robust.
> > > 
> > 
> > Thanks, I've worked these comments into the next version.
> 
> I just wanted to check and make sure this next version hasn't been
> posted to the list yet?  Sometimes the list eats things and I wanted
> to make sure that wasn't the case here.
> 
No not yet. I plan to post new version on Monday after I've done a few
minor updates.


