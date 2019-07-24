Return-Path: <SRS0=rVyX=VV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975DEC76186
	for <selinux@archiver.kernel.org>; Wed, 24 Jul 2019 16:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C44D21841
	for <selinux@archiver.kernel.org>; Wed, 24 Jul 2019 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hf5QP/9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfGXQ4P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:56:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46279 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfGXQ4O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Jul 2019 12:56:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so20232685ote.13
        for <selinux@vger.kernel.org>; Wed, 24 Jul 2019 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lj5VxMT7ytpqUXOYqjV0SKU1nsfCOyOUOiGQpNCaobw=;
        b=Hf5QP/9Gi6ugQidFc1Hm+WBEJpAQIEtpQ7l4tIiLgRnLmI7Jh7/AM3JX+PtpswSZlp
         AVuLSWocf3cXjTCleGz9CJ4T1PqEUUx5GTyeHTNGwet7kw8n3MkOxUzEGb8QBrP2j60T
         gXknXyP8eoQbZ++rJWA2iAhdf2EOi6FDOy/V3xOwcji1yFBFBEIfQfgPI/c57puE0urV
         2c8fsxHE8iGFEyGVuQpMnRWT5/bLME98JycyzMuLxvp0AEsPpBBw44GwmbYPiBqFCDIl
         gKoV04gnZcdVMOPmVYmPiFQmgt++jK5QKoW+Yfi4Eb+FAwqch1BhT7IGNsl2BXf1KbSl
         2qXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lj5VxMT7ytpqUXOYqjV0SKU1nsfCOyOUOiGQpNCaobw=;
        b=dZfoJQ8m/HTmiEVPuvhlHQ0Nufa0j3iaRK5Eyl7+pmQ8vZy8U66sTD7eVh70Ahs4iX
         Bf4QgALwoldTXciCKcRxZl8h5YkF9IXqno2xWT5eZHrlmwpYqrw3CMlDqyKezhLR6KPS
         P0YjzCncVcH1EeTfDWQflXYIEsB3DKZb6Tq+a781Gwwlwpr2fQ6pto6K40e36Kxb9f0W
         UGpZtmu9jZaFS6PGv1xeHWRp/LvebxfAfzwlMpt4ycgJbhmmL0KMJQFI74bnw4PS9Peu
         uRwKxxKFzaCVPnDWPmEOkiVj4yWsK3awdHlAaVpVab0/WDFOqZif0wy6ufSgrPb1e0Fn
         kmpg==
X-Gm-Message-State: APjAAAWNQ+H/Q+7XU7rMBg1ZPCMt7v5iqRyvLONFsLCo8zcynsB0NEnR
        +75LlLlJthuwxJRpZol3kW2+367jaszGiTByW1wQkA==
X-Google-Smtp-Source: APXvYqwh6vIcM8Jk1c4NR1KfxKt+DGUENc04BHP7lwI3tYLzzDoMhYrlgtCveTpKvh97oEm0dQAfR9WL3p/kkMmdu68=
X-Received: by 2002:a9d:774a:: with SMTP id t10mr29134096otl.228.1563987373619;
 Wed, 24 Jul 2019 09:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190722113151.1584-1-nitin.r.gote@intel.com> <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
 <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com>
 <201907231516.11DB47AA@keescook> <CAG48ez2eXJwE+vS2_ahR9Vuc3qD8O4CDZ5Lh6DcrrOq+7VKOYQ@mail.gmail.com>
 <201907240852.6D10622B2@keescook>
In-Reply-To: <201907240852.6D10622B2@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 24 Jul 2019 18:55:47 +0200
Message-ID: <CAG48ez3-qdbnJaEooFrhfBT8czyAZNDp5YfkDRcy5mLH4BQy2g@mail.gmail.com>
Subject: Re: [PATCH] selinux: convert struct sidtab count to refcount_t
To:     Kees Cook <keescook@chromium.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        NitinGote <nitin.r.gote@intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 24, 2019 at 5:54 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jul 24, 2019 at 04:28:31PM +0200, Jann Horn wrote:
> > On Wed, Jul 24, 2019 at 12:17 AM Kees Cook <keescook@chromium.org> wrote:
> > > Perhaps we need a "statistics" counter type for these kinds of counters?
> > > "counter_t"? I bet there are a lot of atomic_t uses that are just trying
> > > to be counters. (likely most of atomic_t that isn't now refcount_t ...)
> >
> > This isn't a statistics counter though; this thing needs ordered
> > memory accesses, which you wouldn't need for statistics.
>
> Okay, it'd be a "very accurate" counter type? It _could_ be used for
> statistics. I guess what I mean is that there are a lot of places using
> atomic_t just for upward counting that don't care about wrapping, etc.

(Accurate) statistics counters need RMW ops, don't need memory
ordering, usually can't be locked against writes, and may not care
about wrapping.
This thing doesn't need RMW ops, does need memory ordering, can be
locked against writes, and definitely shouldn't wrap.

I agree that there are a bunch of statistics counters in the kernel,
and it's not necessarily a bad idea to use a separate type for them;
but this is not a statistics counter.
