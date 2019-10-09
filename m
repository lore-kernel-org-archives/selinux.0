Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E0C47404
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 15:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67355206BB
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 15:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="WifoCbJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJIPty (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:49:54 -0400
Received: from mailomta11-sa.btinternet.com ([213.120.69.17]:46615 "EHLO
        sa-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731145AbfJIPty (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 11:49:54 -0400
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20191009154949.DUC28776.sa-prd-fep-049.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Wed, 9 Oct 2019 16:49:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1570636189; 
        bh=S7ldQ4uTbbKpL2UZCDOtOCHJ7nMvV+yGGw+IjVuCrUU=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=WifoCbJ6ElZhuuBFwojyf/TSo/KR5sCnSjft0oIcsdE4ZqgGubZ7IcIFgFKWiC6tQh3/pLy331GUfRxKA9VU6pzPfrNAheeAJTuf4QMHhvTX6CzLH/zRoYAhmANuo9hv6kwk5ZaykV3/4tYsn3oyzpnpyN6zPolmFUOsWNiVHTIUt7+YQ0DUFdu8ZgFsN4scgpL+7jHGFwFsh5CxmPHXevSQclmx7MGd6cVwjUlqWMKxAR1R6mSEVaKithCgODM1hjzALSoRPlH4qIc040ZbRnQDe+/qJqxWKn0yQHamPMOCZXnvqptK7Jf6MwWXzI64o0MmJ0sH0G79Qw4Okm3quw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.4.168]
X-OWM-Source-IP: 86.134.4.168 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedriedugdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlqddutddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedrgedrudeikeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrgedrudeikedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghr
        ufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.4.168) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D8681A102E9AAEA; Wed, 9 Oct 2019 16:49:49 +0100
Message-ID: <f534d405a0ff00169e93673ce26de8cc7a695874.camel@btinternet.com>
Subject: Re: [PATCH] selinux-testsuite: Update binder for kernel 5.4 support
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Date:   Wed, 09 Oct 2019 16:49:48 +0100
In-Reply-To: <CAHC9VhTmzp=miTR+aSvL+onOtd1P5=Ln1EKjLqFFuh7wkr1OYA@mail.gmail.com>
References: <20191006085121.13556-1-richard_c_haines@btinternet.com>
         <5e20d80f-909f-0bb7-4cf5-16e7ce89382b@tycho.nsa.gov>
         <57056c510589650446ac4dd079c112e22dffb042.camel@btinternet.com>
         <4f0c2ff54dd1ad94392ef7c2428c766e0e2a2574.camel@btinternet.com>
         <CAHC9VhQcvFna_Jj5kZaJVbUtY_EW97sreAODTiaH8pb8nEqZjA@mail.gmail.com>
         <e9b371bc-f028-1f0e-2b7e-628c11c1a0db@tycho.nsa.gov>
         <CAHC9VhTmzp=miTR+aSvL+onOtd1P5=Ln1EKjLqFFuh7wkr1OYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2019-10-09 at 10:03 -0400, Paul Moore wrote:
> On Wed, Oct 9, 2019 at 9:56 AM Stephen Smalley <sds@tycho.nsa.gov>
> wrote
> > On 10/8/19 5:43 PM, Paul Moore wrote:
> > > On Mon, Oct 7, 2019 at 12:35 PM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > On Mon, 2019-10-07 at 16:17 +0100, Richard Haines wrote:
> > > > > On Mon, 2019-10-07 at 10:28 -0400, Stephen Smalley wrote:
> > > > > > On 10/6/19 4:51 AM, Richard Haines wrote:
> > > > > > > Kernel 5.4 commit
> > > > > > > ca2864c6e8965c37df97f11e6f99e83e09806b1c
> > > > > > > ("binder: Add
> > > > > > > default binder devices through binderfs when
> > > > > > > configured"),
> > > > > > > changed
> > > > > > > the way
> > > > > > > the binder device is initialised and no longer
> > > > > > > automatically
> > > > > > > generates
> > > > > > > /dev/binder when CONFIG_ANDROID_BINDERFS=y.
> > > > > > 
> > > > > > This seems like a userspace ABI break, no?  Same kernel
> > > > > > config
> > > > > > before
> > > > > > and after this commit yields different behavior for
> > > > > > /dev/binder.  I
> > > > > > suppose one might argue that one would only enable
> > > > > > CONFIG_ANDROID_BINDERFS if one wanted to use it instead of
> > > > > > /dev/binder
> > > > > > but the original commit that introduced binderfs
> > > > > > specifically said
> > > > > > that
> > > > > > backward compatibility was preserved.
> > > > > I'll need to check this further, but from what I've seen so
> > > > > far, is
> > > > > that the /dev/binder is not available until you mount
> > > > > binderfs etc.
> > > > > that's why Paul had the failure on 5.4 as before then is was
> > > > > available
> > > > > when the binder driver first initialised.
> > > > 
> > > > To confirm tests using kernel 5.4-rc1
> > > > 
> > > > Test 1 config:
> > > > CONFIG_ANDROID=y
> > > > CONFIG_ANDROID_BINDER_IPC=y
> > > > CONFIG_ANDROID_BINDERFS=y
> > > > CONFIG_ANDROID_BINDER_DEVICES="binder"
> > > > 
> > > > On boot no /dev/binder
> > > > 
> > > > To get this you have to:
> > > > mkdir /dev/binderfs 2>/dev/null
> > > > mount -t binder binder /dev/binderfs -o
> > > > context=system_u:object_r:device_t:s0 2>/dev/null
> > > > 
> > > > You then have devs:
> > > > binder and binder-control
> > > > 
> > > > Test 2 config:
> > > > CONFIG_ANDROID=y
> > > > CONFIG_ANDROID_BINDER_IPC=y
> > > > # CONFIG_ANDROID_BINDERFS is not set
> > > > CONFIG_ANDROID_BINDER_DEVICES="binder"
> > > > 
> > > > On boot you have /dev/binder
> > > 
> > > Disabling binderfs during build is probably not the smart thing
> > > to do
> > > considering where the world is at with namespaces/containers,
> > > whatever
> > > we do we should make sure the tests work with
> > > CONFIG_ANDROID_BINDERFS=y.
> > 
> > Yes, I think the question is just whether we want to have the tests
> > use
> > binderfs for kernel >= 5.0 (i.e. the point at which binderfs was
> > first
> > introduced) or for kernel >= 5.4 (i.e. the point at which binderfs
> > usage
> > became mandatory if you enable it in your config because
> > /dev/binder is
> > no longer automatically created).  I'm fine either way.
> 
> Agreed in that it probably doesn't matter all that much.  I might be
> tempted to start with v5.4 over v5.0 since the old way still worked
> on
> v5.0 through v5.3 and it might be nice to notice if that changes in a
> v5.{0..3}.Z release.
> 
Thanks for the feedback, I will start using binderfs from 5.4.



