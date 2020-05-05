Return-Path: <SRS0=X6Oi=6T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CCEC47257
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 14:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D96206FA
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 14:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe9CTMKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgEEOW1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729256AbgEEOW0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 May 2020 10:22:26 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537A5C061A0F
        for <selinux@vger.kernel.org>; Tue,  5 May 2020 07:22:26 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s202so2095024oih.3
        for <selinux@vger.kernel.org>; Tue, 05 May 2020 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fQiafRnLRGwE4iV6/dJuGZf5xpweo7VHk1Q6aRK8Kg=;
        b=fe9CTMKyqqZHaEJCUapdSROwdFcrGfbqC6ejCI0CNeJ0GEXf+NvHF0STjp4R8ETO9t
         YH1UH/ln5AZMqqwvnMPq87QsEvZVfXHTFErkViFi5IxeC+d/5bx9QSWiTbm0DCcIX5JW
         VtMBRuZRGYdOxIiN8AgbDr5ICy1E6KAfwE1HlNz1RyxJrps/9/nhIe5lMQMpNcYVSu3m
         ORH6imgbQT9IWTATgv0iwHuFdBpeuNDXy2V5SAaNRY2jWiCX56hNlkDL8ulU1cHHPKZ5
         uFR3PQOCusvQt8GPJb8+nEbd1kucIqToX64JUrxO0dk9wIkE8y5PPobH32o203A3gDWq
         vLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fQiafRnLRGwE4iV6/dJuGZf5xpweo7VHk1Q6aRK8Kg=;
        b=Wzp7KlY9NT0S77XwSX+h/ZLIcChlkHdHMvTsWgVtMJ2JMpQ+wQpY3G51YLsi6j0FPr
         nSM4fgdxdnGv8JOghTogRajZb9fxfJZRDug8glpHg/4pE7yqNAGW5jqeO0DUnU365w50
         Oe7VFtKMcceBynvwuEdvj9KRZsMxZ3Ub48x6kqNMVu0CANuRVXwrbuG6XDMfRN/pfYEX
         AOnl2OV4a3eTizZIkScTbRWFlsX0AFBx5ZzgpuhrL5qa7qXwKA/65sy5btByq2hNNoG2
         2ulu4IOVtRqJnZdpLCbdrwEmptPLrEzS4BoIohefA9J0nxg/x5yDmTqIdgXehBdv0GIE
         MHKw==
X-Gm-Message-State: AGi0PuZIIOAKIVhHzciiI7avvFSx4asJuKPlBny12z5alUHwZyba3VOV
        S6qeYiggz3Cd8rSGFEHTV0mwS5xrsm//cgM2Wck=
X-Google-Smtp-Source: APiQypIPM9zb8GyHziCVhNHvB7Ig4cYET89l5P9N6TILCObl8eNsVvBqe5q3PTv+vCbgkR/h/RRSNpq0u+jonUWjgGk=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr2603863oib.140.1588688545687;
 Tue, 05 May 2020 07:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135727.GD7308@workstation>
In-Reply-To: <20200505135727.GD7308@workstation>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 5 May 2020 10:22:13 -0400
Message-ID: <CAEjxPJ57OVu+VCN4VoSRC1Wbdtcyt3Z6Fq7qRuvdRb7xsGe14w@mail.gmail.com>
Subject: Re: Intent to release 3.1-rc1
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 5, 2020 at 10:00 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Hello,
>
> I'd like to release 3.1-rc1 until end of this week.
>
> Looking at https://patchwork.kernel.org/project/selinux/list/ I see:
>
> - 3 acked patches which are ready to be merged (and I'll merge
> them tomorrow if there's no other comment):
>
> https://patchwork.kernel.org/patch/11525435/ libselinux: Add missing errno setup
> https://patchwork.kernel.org/patch/11527311/ tree-wide: introduce PYTHON_SETUP_ARGS to customize setup.py calls on Debian
> https://patchwork.kernel.org/patch/11527463/ Travis-CI: upgrade to Ubuntu 18.04 and latest releases of Python and Ruby
>
> - 1 patchset which should be postpone for the next release as it breaks setools
> https://lore.kernel.org/selinux/20200502190828.3555858-1-omosnace@redhat.com/T/#t
>
> - 1 patch without response:
> https://patchwork.kernel.org/patch/11392367/ libselinux/getconlist: add verbose switch to print more information

I had asked about the motivation for the patch and didn't see any
reply.  I had also noted that we have several overlapping utilities
there that ought to be coalesced or dropped.  Anyway absent some
compelling motivation for this patch I don't think it warrants merging
right now.

>
> - 1 RFC related to other kernel RFC
> https://patchwork.kernel.org/patch/11436953/ [RFC] selinux: add unprivileged sandboxing capability
> https://patchwork.kernel.org/patch/11436955/ [RFC] libsepol,secilc,policycoreutils: add unprivileged sandboxing capability
>
>
> There are 2 opened github PRs without Signed-of: and matching patch on the
> mailing list:
> https://github.com/SELinuxProject/selinux/pull/174  Use quote include for files located in the local directory
> https://github.com/SELinuxProject/selinux/pull/135  More robust ausearch time input
>
>
> Have I missed something? Do you have any comments, objections to release?

There was also this one that I deferred to the distro maintainers to decide on:
https://patchwork.kernel.org/patch/11284945/

Otherwise, looks good to me.  I agree that we don't want to include
the setools-breaking change until after this release.
