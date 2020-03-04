Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CC9C3F2CE
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC09124658
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 17:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="jkVAQ93L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgCDRSY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:18:24 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45659 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgCDRSY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 12:18:24 -0500
Received: by mail-il1-f194.google.com with SMTP id s201so1731107ilc.12
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 09:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVzpzKqN50eWWq2tMPQDAp4wSJlZA0J4ns1zxUZByAU=;
        b=jkVAQ93LJR2ute/clro3H7KIwmRby9VxrzFLA+wFKd2UjLQXsfahqkqpNfi199Vb5Z
         PvrzNo/jdmqenNlxunDOhynbIJHDWfjfLStVxijnmUeqt+R3JFJcDjp7dZ/z3anYzzho
         wH+Tvxjn7FU6qyrYlAZ1NTFiVvhiimM0uh85dIi4r6tzoyKv1iy9e1ZiWyI2Nbgd8tIf
         khTygAskOK2CXoQeEsgWqPCFLz2955JoLw7kdIZiE2yMXN8ypKDWHYhVSpm3dfy2VUjI
         6JToiBwe98+q+sOmbZTIl95VGPPINIdZGkrzNY5iDDnY2dd8zUSX28fA4wMhvwBNIcx+
         1D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVzpzKqN50eWWq2tMPQDAp4wSJlZA0J4ns1zxUZByAU=;
        b=dDnOyVu8iL+EuorMSHUQUpXTZXeExTZXNrxdy26GFdyqoXY6CZ/emeuBG7cSeBRPZS
         HrwnMJ/oSGrPG8NA2rpxiQIid54Wf1dYIaAEjW1jZXBaCbsCBYdeyJAGeV82wuet7Op7
         CY3gCQzpY3jTpN7zoGn00gUuqnyRFIHMFMUdxfbYabhcvyT9djOR8qMePp1OtH3gSN7Q
         2rHlyHEyWDQrVuTKn9TvddLMxNzlgT3SKzz9DgUmkbdOVNOTfWPpphPunnK3tDSOibOd
         1sXY9GSXiDiPXXGtDOjClVf7KMhXocUBSPkcr8YCUx4f6G5IDSIczNn+4dfUeRmsOfM/
         68Gw==
X-Gm-Message-State: ANhLgQ1wZOEV1hVq2hefik/s9mDTqRKW77AKrdYyhLxyHc4GKUKZlfse
        TKvob7rr77AcmOT0h4vGZBLFqEBUSQkH7ze8BWj1ag==
X-Google-Smtp-Source: ADFU+vsyJ071+WQcoWFLdq2Iuwb/9WIosbmX+14nDlZJje+K3CIguIWJUGnTDh5Cis8lJMmtuopMZWa8k9Y81KqrBQM=
X-Received: by 2002:a92:aa02:: with SMTP id j2mr3485550ili.34.1583342303701;
 Wed, 04 Mar 2020 09:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20200303085233.137371-1-omosnace@redhat.com> <CAEjxPJ5XHa2JLMf_BmhHV=LNBUe7qgM8Le6_PMX=jYjGb2OXvA@mail.gmail.com>
 <CAGB+Vh4RVwSraAGn1caEXOvHySkmgzgAfV7aZ-pwWKeUVyV_ag@mail.gmail.com>
In-Reply-To: <CAGB+Vh4RVwSraAGn1caEXOvHySkmgzgAfV7aZ-pwWKeUVyV_ag@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Wed, 4 Mar 2020 12:18:12 -0500
Message-ID: <CAGB+Vh69hcAjRG7aoDbCO6RyATWFoOBzEBcAYyGRWWHkE9RSFQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests: add test for default_range glblub support
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 12:11 PM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
>
> On Wed, Mar 4, 2020 at 11:54 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Mar 3, 2020 at 3:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Adds a basic test for the "glblub" default_range mode introduced in
> > > kernel commit [1] and userspace commit [2]. The test vectors are taken
> > > from the original commit messages.
>
> I'm confused, I submitted tests at Paul's request. The patch is here
> but says superceded:
> https://patchwork.kernel.org/patch/11119909/
>

It's been a while so I'm just rereading mine, I also attempted to
differentiate between MLS and MCS policies on the system running the
tests so that they could run on the MLS policies directly (which is
where glblub support is utilized), and I also verify the default (non
glblub) behavior to ensure we didn't impact normal computations.

Unless there is a compelling reason I think mine should be merged
rather than this one.

>
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42345b68c2e3e2b6549fc34b937ff44240dfc3b6
> > > [2] https://github.com/SELinuxProject/selinux/commit/9ba35fe8c280b7c91ec65b138d9f13e44ededaa9
> > >
> > > Cc: Joshua Brindle <joshua.brindle@crunchydata.com>
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
