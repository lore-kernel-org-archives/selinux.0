Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BB0C433EF
	for <selinux@archiver.kernel.org>; Tue, 15 Feb 2022 20:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbiBOUfY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Feb 2022 15:35:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiBOUfX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Feb 2022 15:35:23 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A1D76C2
        for <selinux@vger.kernel.org>; Tue, 15 Feb 2022 12:35:11 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p15so46775112ejc.7
        for <selinux@vger.kernel.org>; Tue, 15 Feb 2022 12:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KePYcCl5a38qqRp4PlWIKJyXKZKQzDwLkIxZJtpH86s=;
        b=TjWFfUMH/5M/aImVMoFiuz3ZvcaO/cos6XwrUYBV1zduc1Cwj9ORKwQ8gBkKx1kv3q
         eqGaj9THZ4cCjfkgLJtX/iS/XdLY692b93Q4qZeaOqZDVcwHHSAtC6bGaW6OWSSj1skk
         0IDe8gV5sQi9hGV2dHz5XcfdV1Xfyr1cAOQFYo9fQa+Y0wFqsRLyszyKN+cz3ojjZrrz
         asjUssQFpyaC4Qoa14E4HyJ8NfDCAakA8qWRb88gGAyWPOQKvSYxxlUEHSL+5N2t95uk
         CbVZuTzLB1QkD96EV8OUK10iHv+G/yqcjcMFlurbnNA5VLP0sguuydd1TH17mhKQzPZ9
         rVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KePYcCl5a38qqRp4PlWIKJyXKZKQzDwLkIxZJtpH86s=;
        b=JbpyJnxYEUmvodnjw/4pwbw2/jJLV5OEARqrGEqm8Mfl3AqYqagYYDvMK1jWb9E4+l
         DWR1YWVOYBZf+Zo43GyEfvHGqnxkjwvRF6vxOY+KjqcNRZqmZO0P9qJxbEkUzIhKsEYX
         wFblccfU7b3Cif4Vh5WJ+kLbOJPidDbav77r4iQC9LUkQYtvXeRfD6sPYbpHgKnEZrVZ
         GdoVkn1LYO0W5fLMmB/X8/ocXdzN9e8hn+lJ8MCICYamURiRc0pmGg+MPRlf8X4T1XQI
         OC465A959B9kGoFZd/ue+aukXQA7u+zxpoqaMBj9ajhimVIzbv4zAk/+Xnrc07AzQGsf
         aC9A==
X-Gm-Message-State: AOAM532vY9Ld3F6aSegVTAJtsEZO74fb+w9mm2be35oyOkymPJmZkGMF
        /HBs9fqVH6NtuCNV5hVOTN6Kxo0XCL85ssRF+dnH
X-Google-Smtp-Source: ABdhPJz1Tc45Xo6bFBvHTWEiDBZPvg/YToRg+d0x7DzZCYRR99sT5jdGxyicDniFd93V3RRkBGBRUsY70DgMCnKJwt0=
X-Received: by 2002:a17:907:7409:: with SMTP id gj9mr713011ejc.112.1644957309973;
 Tue, 15 Feb 2022 12:35:09 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com> <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com> <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com> <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
 <875ypt5zmz.fsf@defensec.nl> <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
 <CABXk95Az0V0qWyB0Cp9D+MaCKNBfcdk4=bvXRdm5EXzHdjXJJg@mail.gmail.com>
In-Reply-To: <CABXk95Az0V0qWyB0Cp9D+MaCKNBfcdk4=bvXRdm5EXzHdjXJJg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Feb 2022 15:34:59 -0500
Message-ID: <CAHC9VhQKuQuR1pJfa0h2Y5dCjmrpiYaGpymwxxE1sa6jR3h-bA@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     Demi Marie Obenour <demiobenour@gmail.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        Chris PeBenito <chpebeni@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 14, 2022 at 2:11 AM Jeffrey Vander Stoep <jeffv@google.com> wrote:
> On Tue, Feb 8, 2022 at 3:18 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> >
> > <snip>
> >
> > This is getting too long for me.
> >
> > > >
> > > > I don't have a strong opinion either way.  If one were to allow this
> > > > using a policy rule, it would result in a major policy breakage.  The
> > > > rule would turn on extended perm checks across the entire system,
> > > > which the SELinux Reference Policy isn't written for.  I can't speak
> > > > to the Android policy, but I would imagine it would be the similar
> > > > problem there too.
> > >
> > > Excuse me if I am wrong but AFAIK adding a xperm rule does not turn on
> > > xperm checks across the entire system.
> >
> > It doesn't as you state below its target + class.
> >
> > >
> > > If i am not mistaken it will turn on xperm checks only for the
> > > operations that have the same source and target/target class.
> >
> > That's correct.
> >
> > >
> > > This is also why i don't (with the exception TIOSCTI for termdev
> > > chr_file) use xperms by default.
> > >
> > > 1. it is really easy to selectively filter ioctls by adding xperm rules
> > > for end users (and since ioctls are often device/driver specific they
> > > know best what is needed and what not)
> >
> > > >>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD)
> > >
> > > 2. if you filter ioctls in upstream policy for example like i do with
> > > TIOSCTI using for example (allowx foo bar (ioctl chr_file (not
> > > (0xXXXX)))) then you cannot easily exclude additional ioctls later where source is
> > > foo and target/tclass is bar/chr_file because there is already a rule in
> > > place allowing the ioctl (and you cannot add rules)
> >
> > Currently, fcntl flag F_SETFD is never checked, it's silently allowed, but
> > the equivalent FIONCLEX and FIOCLEX are checked. So if you wrote policy
> > to block the FIO*CLEX flags, it would be bypassable through F_SETFD and
> > FD_CLOEXEC. So the patch proposed makes the FIO flags behave like
> > F_SETFD. Which means upstream policy users could drop this allow, which
> > could then remove the target/class rule and allow all icotls. Which is easy
> > to prevent and fix you could be a rule in to allowx 0 as documented in the
> > wiki: https://selinuxproject.org/page/XpermRules
> >
> > The questions I think we have here are:
> > 1. Do we agree that the behavior between SETFD and the FIO flags are equivalent?
> >   I think they are.
> > 2. Do we want the interfaces to behave the same?
> >   I think they should.
> > 3. Do upstream users of the policy construct care?
> >   The patch is backwards compat, but I don't want their to be cruft
> > floating around with extra allowxperm rules.
>
> I think this proposed change is fine from Android's perspective. It
> implements in the kernel what we've already already put in place in
> our policy - that all domains are allowed to use these IOCLTs.
> https://cs.android.com/android/platform/superproject/+/master:system/sepolicy/public/domain.te;l=312
>
> It'll be a few years before we can clean up our policy since we need
> to support older kernels, but that's fine.

Thanks for the discussion everyone, it sounds like everybody is okay
with the change - that's good.  However, as I said earlier in this
thread I think we need to put this behind a policy capability, how
does POLICYDB_CAPABILITY_IOCTL_CLOEXEC/"ioctl_skip_cloexec" sound to
everyone?

Demi, are you able to respin this patch with policy capability changes?

-- 
paul-moore.com
