Return-Path: <SRS0=rVyX=VV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912FEC7618B
	for <selinux@archiver.kernel.org>; Wed, 24 Jul 2019 15:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698C721873
	for <selinux@archiver.kernel.org>; Wed, 24 Jul 2019 15:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ik90mLvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfGXPyG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:54:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43892 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfGXPyF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Jul 2019 11:54:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so21430174pgv.10
        for <selinux@vger.kernel.org>; Wed, 24 Jul 2019 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JHukw73OgEOriwdsLMhpivCbyH6cvsJtw9qqzYYPqGE=;
        b=Ik90mLvOG+X12MYkfJNW6qLHk5ypaW1M2wjaht/c5226g1ypJeQVluQAmvTh2XlhXC
         7If3MJd50Bgsp/roy1lFi1cKyhpozoMHxhSG3ucy/tZhW6gVM9s0OYayAeuTsS0sqxVR
         WmAHl1K/AZrKp4dV8wxVthI00OdOR0xVxLNAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JHukw73OgEOriwdsLMhpivCbyH6cvsJtw9qqzYYPqGE=;
        b=ui5B19JQpJSavc3WYur9MyYeo/VlfANeeM8IrI2/TkHLuN9vNStR0hsx8NTruiQ0Ig
         EyYbfEwJlXyKo8RDBAymmtBPH9s09UqjTyYiMuOSta3rU6OR37Rd3GOXfoXUT/Px6nH0
         M955DXAcvMMAPwj+BM3V7vHd5sskRqESwlNDnF5XNwEJgIfVUzFJ5ragJFr6I8U3nI6h
         iZwQvWVtAJYWkB8paBHq+mR2YDD8+/Ua/p4PD1D2f0Mfamstgc557oJXrBPcO3DN3pWT
         eK5DnKbvdp2oiFHbtOW34ECRmSnnHqXy/wFVpry441e4bdjYIEQE6Tg/OsJ7i/8sOFzH
         Plag==
X-Gm-Message-State: APjAAAVbTjGhh6uNRRGKpcJysCEFBgtszMxMqe9fJpbO7/gA7A4+cMgg
        I8S3RtWkRLbFk5fA7v8rKvTBuw==
X-Google-Smtp-Source: APXvYqynOrVoLdvqWKYRZRVAhvhaA12eXVFnmOQowISaUwv4yMX6yfjlcao9aUbIf+j3Ef+pi6vEvw==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr88610142pjz.117.1563983645153;
        Wed, 24 Jul 2019 08:54:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o24sm91619442pfp.135.2019.07.24.08.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 08:54:04 -0700 (PDT)
Date:   Wed, 24 Jul 2019 08:54:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        NitinGote <nitin.r.gote@intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selinux: convert struct sidtab count to refcount_t
Message-ID: <201907240852.6D10622B2@keescook>
References: <20190722113151.1584-1-nitin.r.gote@intel.com>
 <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
 <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com>
 <201907231516.11DB47AA@keescook>
 <CAG48ez2eXJwE+vS2_ahR9Vuc3qD8O4CDZ5Lh6DcrrOq+7VKOYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2eXJwE+vS2_ahR9Vuc3qD8O4CDZ5Lh6DcrrOq+7VKOYQ@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 24, 2019 at 04:28:31PM +0200, Jann Horn wrote:
> On Wed, Jul 24, 2019 at 12:17 AM Kees Cook <keescook@chromium.org> wrote:
> > Perhaps we need a "statistics" counter type for these kinds of counters?
> > "counter_t"? I bet there are a lot of atomic_t uses that are just trying
> > to be counters. (likely most of atomic_t that isn't now refcount_t ...)
> 
> This isn't a statistics counter though; this thing needs ordered
> memory accesses, which you wouldn't need for statistics.

Okay, it'd be a "very accurate" counter type? It _could_ be used for
statistics. I guess what I mean is that there are a lot of places using
atomic_t just for upward counting that don't care about wrapping, etc.

-- 
Kees Cook
