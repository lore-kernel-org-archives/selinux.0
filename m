Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CC7C433DF
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 13:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E862D2072D
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 13:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhE89joY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbgE1NgT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 09:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390346AbgE1NgT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 09:36:19 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F51C05BD1E
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 06:36:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id i22so24867068oik.10
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+8Gs/Nn17O3PBTA/Vsg3xrTrPyWacJMMdZO2dqd80k=;
        b=AhE89joYrl3vFJ06KKX5MdT0YLEzczwXRMvM45HjcMcRXSPX7xVpYxXFwNY2NFvnuQ
         kKhI4BRgNTVJY1PXDdMahnDbtd9t236bjYlFphNbSxOzzpzgKaJENbqFSdbsKuhZ5hV/
         v/hojtbR9CZVWIvOfO+yq0ALt5o+5oJ/Fl/bIUCiKSsjru0DaR7YJHE8yFPh4HfrkIF6
         HKm0zXYXOND30tUgUQIr1ilNz/C9cqiqrVqbo40HMVs81zZ0Sh1Lv17JbwQnroHyFaSc
         RIfL5KmDBFnfcDOy7up22WRdOtYyb6auJWQ2nbgQOKz5b6L8jwmuFkaJ9HAZ6Xo9sNFl
         ef+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+8Gs/Nn17O3PBTA/Vsg3xrTrPyWacJMMdZO2dqd80k=;
        b=AaZmfgzBtrxJ7w3X/fIH8jos++rF+mKE3jguvLsiCk29cKQoaeEfrvCz2ANYnSiMrC
         rEKVyX5+vQS+XFbKZezDNtYzrzwzNnlxeIMSizEJUMpwB/3JP817wwjuJEhGkTpdHu1u
         5hvhT6JGLOdmPFajnjEPlEr6Nvh+cI4PB98uoIrJe2ABRPgOIqJowHy7ZbazC6BMXN/t
         UvbOC7U9JlEDbcUukUOHoUCYNKl9DooELaj4TjCyCSzZlOUQy7MNiPw/GUg6YQ4EpVfk
         6uEJCqp8y4+vV0AT5FIV7cuTkZ1maUrkJRWZLxSHqB9aZU8uE2F73yBprBssmkafD43j
         lWFg==
X-Gm-Message-State: AOAM533sECIU+9KH/lRBC83YGVhLGuaCWHld9Yxk/ugKdTx9V99nIbNT
        AKR2NojLyMvRwIPBQslaTLfdi/IOaxsx778/WvI=
X-Google-Smtp-Source: ABdhPJy1uzbZgEQNt2VMerux0eYKhXsP6zQQIG1Af8/Gzo/s/zbKmFCNRmgWiIbcymPdv6/npZZ4R2yABxfDLgJKPoM=
X-Received: by 2002:aca:fd0a:: with SMTP id b10mr2306272oii.16.1590672978007;
 Thu, 28 May 2020 06:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <ypjlsgfk71po.fsf@defensec.nl> <CAP+JOzRQzA=PU+djvZmyA_RtdcduMQuyhZPvNSpNodpE_G4xGg@mail.gmail.com>
 <520dd447-7ba4-9ea5-0353-425a7da4497b@defensec.nl>
In-Reply-To: <520dd447-7ba4-9ea5-0353-425a7da4497b@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 28 May 2020 09:36:06 -0400
Message-ID: <CAP+JOzS7iGdo-C6ViwYcxC47v614MCWY=K1a8ajWy6BWZrjv_Q@mail.gmail.com>
Subject: Re: CIL typealiases
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 28, 2020 at 9:28 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
>
> On 5/28/20 3:19 PM, James Carter wrote:
> > On Thu, May 28, 2020 at 7:21 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >>
> >> tl;dr typalias (and possibly typealiasactual) statement does not like periods
> >>
> >> systemd plans to consolidate systemd-udevd and udevadm and so I was
> >> looking to consolidate the policy. For compatibility I wanted to add a
> >> (typealias .udev.udevadm.exec) and (typealiasactual .udev.udevadm.exec
> >> .udev.daemon.exec)
> >>
> >> That reminded me that it does not like the period name space
> >> delimiter in at least the typealias statement.
> >>
> >> Example:
> >>
> >> [root@brutus ~]# echo "(block test (type test1) (typealias test2.test1)
> >> (typealiasactual test2.test1 test.test1))" > mytest.cil
> >> [root@brutus ~]# semodule -vvv -i mytest.cil
> >>
> >> <snip>
> >> Building AST from Parse Tree
> >> Invalid character "." in test2.test1
> >> Invalid name
> >> Failed to create node
> >> Bad typealias declaration at
> >> /var/lib/selinux/mydssp3-mcs/tmp/modules/400/mytest/cil:1
> >> Problem at /var/lib/selinux/mydssp3-mcs/tmp/modules/400/mytest/cil:1
> >> Failed to build ast
> >> semodule:  Failed!
> >>
> >
> > CIL doesn't like "." in any name used in a declaration.
> >
> > If you want an alias with a "." in it, then use blocks.
> > (block udev
> >   (block daemon
> >      (type exec)
> >   )
> >   (block udevadm
> >      (typealias exec)
> >      (typealiasactual exec .udev.daemon.exec)
> >   )
> > )
> >
> > Or something like that.
>
> Right, thanks that works and sorry about that. Feels like deja vu, must
> have not been the first time I encountered this.
>
> Feels kind of un-intuitive but makes perfect sense thinking about it.
> Just need to get used to it.
>

I had forgotten myself until I looked at the code. It is obvious in
hindsight though, because if CIL allowed ".", then it would have
trouble trying to resolve the name, because it would expect a block.

Thanks for the report anyway. You do a great job of finding all of the
corner cases in CIL. CIL has been greatly helped by all of your
reports.

Jim
