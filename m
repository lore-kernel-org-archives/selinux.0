Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC77C433F5
	for <selinux@archiver.kernel.org>; Thu, 31 Mar 2022 15:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiCaPRH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Mar 2022 11:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiCaPRG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Mar 2022 11:17:06 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D511229AB
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 08:15:18 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-d6ca46da48so25651100fac.12
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCvBL2cOdcFOVuw/9bxrTZGVVODJB6m4W/aUvHTadZY=;
        b=D5CyKc6gYxKUeEPD1oRFx2DK2DCvfkEy9K/8XzI79wjgGPHo5poC3NKEtKNCa+HBSE
         S7JqzN3W2X+5xbuajN/Dsy2+AgvANCc/7H0YduXnncZ8/ie7v9T4wWwlzh/BVdNMlWTv
         V2Sm8m636UdqZpHuSR0lqDfb+iX2Lit6Aa6u4vM93Q/n2YYrcNjVgwRSXlrblTu/xfQh
         1AoKiH+C4mQLufLFLLntJ28tFTVMRT9kO1uk/fOgwCgzYF/5Gj/dG5oFNIW5MXFNCOvp
         YTlPCF0mu5DzQtk7gbfiAaNWglwNttRO1o36695xeaF6mKmSMWObVI7RYOOfUdm71VM6
         02xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCvBL2cOdcFOVuw/9bxrTZGVVODJB6m4W/aUvHTadZY=;
        b=BAC55WXb8AqpWjs+2RitXDhxV+koAKH5WlZxSs9jeZQiykWAe16x/b24wcA2qtSsky
         kBLYarkfElhkKfcdi5DHno/CW3gdQNdbasd33JseITlPXVtBvXefJoymIAGm9ckAIMmQ
         vUEIqcb3YapoquWFrnknMr6u52iQ9Vt8keV4KpxiItsQVjltP2Z/W6/2Q8/V6RX6SVg5
         CdRmMIn8MQAp8zqq4KVHGmA2f2IGqOQhZwhz53EoOklKOX5NaMQIIQ3/XZ//WJEk4Z/c
         mOKg2Rz6OhWcJmkXTa7NMCVfnxLZ2qN3VDNHk+qd+kM0PvMYWjKTywQ1cT6U2uudubAH
         EYVw==
X-Gm-Message-State: AOAM533x3Lg7+NNC6Z4y0ZwYuBBM7bxROOVeeoynqx6aOcIOIowoq/A8
        tAX+6D3f6y0SisT7jHR+GjKIpehVH5a9t5+Ztew=
X-Google-Smtp-Source: ABdhPJwGzyH9CnfcK2tES7zTQ6P8l6lCGJnK2ifO6zJMi2yHlZRiFBP9EkdThjCB6gYuS1QZVnkBIJejIAwu7aZKJFI=
X-Received: by 2002:a05:6870:e408:b0:de:b929:5206 with SMTP id
 n8-20020a056870e40800b000deb9295206mr2861279oag.71.1648739717872; Thu, 31 Mar
 2022 08:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <87pmm43dfc.fsf@redhat.com> <CAP+JOzTnOW9A7iyDeysC6pNcZA9sAqJxP1UhMYJx3-Umk6R3Ag@mail.gmail.com>
 <87o81mbb8y.fsf@redhat.com>
In-Reply-To: <87o81mbb8y.fsf@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 31 Mar 2022 17:15:06 +0200
Message-ID: <CAJ2a_DdnyOeYfE6P+7NLsRusp=Vow7JjEsTguU7yzQnfsMgmBA@mail.gmail.com>
Subject: Re: Lets start with 3.4 userspace release
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 31 Mar 2022 at 13:41, Petr Lautrbach <plautrba@redhat.com> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Tue, Mar 29, 2022 at 3:06 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >>
> >> Hello,
> >>
> >> after 142 commits and 5 months since last SELinux userspace release,
> >> it's time to think about another release.
> >>
> >> The current backlog of patches is bellow. Please take a look.
> >>
> >> This time, I'd like to release rcX every 14 days -
> >> rc1 - 04-06-2022
> >> rc2 - 04-20-2022
> >> ...
> >>
> >> I'll try send patches with the release number change on Mondays before every
> >> release.
> >>
> >>
> >> Also when rc1 is out, please consider postponing non-bugfix patches
> >> after the release or provide a comment that the change is not necessary
> >> for this release.
> >>
> >>
> >>
> >> * https://patchwork.kernel.org/patch/12617693/ New [v2] Support static-only builds
> >>
> >> - v2 of https://lore.kernel.org/selinux/87lf1scgd6.fsf@alyssa.is/
> >> - waits for another review
> >>
> >> * https://patchwork.kernel.org/patch/12639767/ New libsepol: free ebitmap on end of function
> >>
> > This is part of the notself patches which will not be ready for this release.

It was not specific to the not-self patches, but it is rendered
obsolete by 3b71e516 ("libsepol: Make use of previously created
ebitmap when checking self ").

> >
> >> * https://patchwork.kernel.org/project/selinux/list/?series=590259 add not-self neverallow support
> >>
> > Still working, but not for this release.
> >
> >> * https://patchwork.kernel.org/patch/12672523/ New [v2] secilc: kernel policy language is infix
> >>
> > This one fell off my radar. I can ack and merge it.
> >
> >> * https://patchwork.kernel.org/project/selinux/list/?series=604679  libsepol: Adding support for not-self rules
> >>
> > Still working, but not for this release.

What is missing, it worked fine for me.

> >> * https://patchwork.kernel.org/patch/12718352/ New [libselinux] libselinux: make threadsafe for discover_class_cache
> >>
> >> * https://patchwork.kernel.org/patch/12726783/ New libselinux: Prevent cached context giving wrong results
> >>
> >> * https://patchwork.kernel.org/project/selinux/list/?series=616731 libsepol: add sepol_av_perm_to_string |
> >>
> >> """
> >> Since most of these functions are used in either checkpolicy or
> >> audit2why (or both), it is probably fine to export these, but I would
> >> appreciate any thoughts that Chris and others might have.
> >> """
> >>
> > I need to think about this one.
> >
> >> * https://patchwork.kernel.org/patch/12775701/ New libsepol/cil: Write a message when a log message is truncated
> >>
> > I will merge this.
> >
> >> * https://patchwork.kernel.org/patch/12780657/ New libsepol: Use calloc when initializing bool_val_to_struct array
> >>
> > I will merge this.
> >
> >> * https://patchwork.kernel.org/patch/12783189/ New libsepol: Validate conditional expressions
> >>
> > I will merge this.
> >
> >> * https://patchwork.kernel.org/patch/12790631/ New [v3] libsemanage: Fall back to semanage_copy_dir when rename() fails
> >>
> > I don't know if Ondrej was planning on ack'ing it, but it seems like
> > he is satisfied.
> >
>
> Thank You!
>
>
> >
> >>
> >>
> >> Petr
> >>
>

The Fedora fork[1] seems to contain several Coverity related fixes.
Any chance of upstreaming those?


The permission map[2], used to weight the interface permissions in the
database generated by sepolgen-ifgen used by `audit2allow(1) -R`, is
quite out of date, while the one from setools[3] is.
Could it get synced by a maintainer, as a patch would be more than
3000 lines and hard to review.


[1]: https://github.com/fedora-selinux/selinux/commits/rawhide
[2]: https://github.com/SELinuxProject/selinux/blob/master/python/sepolgen/src/share/perm_map
[3]: https://github.com/SELinuxProject/setools/blob/master/setools/perm_map
