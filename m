Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E755C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 11:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539FC2077C
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 11:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6oy/wBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbgAXLQO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:16:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31526 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390331AbgAXLQM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 06:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579864571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsIbz664SY9Gm8gNm7i7Qd4lDz+cCdDAOYjvdUHoACo=;
        b=P6oy/wBGlyxl/dDMROf9F0WSZ3HW/yRZ0JaxWNTZRaPbVar2GVjKZr5EsOwbdwV6YlJhQP
        xBM92+wIF+76Xf2C9+YrG0tWGdjJhsX7zvc6/FOcnoAsGKq8BvT6tWya0y2sqZ0/lOKLcM
        zTRSq5cBywLyvYfCzusCGnX/5CzU1cw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-ojjx85X5OyeDznGUGKr0BQ-1; Fri, 24 Jan 2020 06:16:09 -0500
X-MC-Unique: ojjx85X5OyeDznGUGKr0BQ-1
Received: by mail-ot1-f70.google.com with SMTP id l13so701449otn.18
        for <selinux@vger.kernel.org>; Fri, 24 Jan 2020 03:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsIbz664SY9Gm8gNm7i7Qd4lDz+cCdDAOYjvdUHoACo=;
        b=W3XQuTib3Je2kA/p1XUzRIhmsiY4/0BbST5hIdu2CwYz+NoL+Fzc5mpCTlB6ftno8S
         KaXyELrjZpxu4PCR0YtLPCQg0YRK7QKSlMH0MTpNJTmtM/OeVekezeyQGaQN1fldOWy7
         z2Gs2RYoRyivNVuy4bAm3yC/PlN3QTCnb+62bD8i9r9jKjgMgczh4xdjm4S/7JSYeaer
         HP/nJJIaUP63xytO0eat5NOvUtiWaurMPiGzJm6G/c6XI+ocQnuk5OW1hBO+gYd+0Esr
         XsNgn5YMT653mXn29ihiS6N+oOaQ4Yja+Zr5myh8taSKlY9n84zrjezFt70x7J9YskZx
         y22Q==
X-Gm-Message-State: APjAAAWoXNHWq9nEPBFWv8yCJNKQxb62JRDWld9RwDTZubPozqq4lusv
        jS1cY+rH1R0yq0Tro7RBtapEdHtwiu1k1+944G3AmbHwtG8tuJnm1SGKfXbDzwDs+ue7KtkjXj3
        0I2NDVBqCktnT0eG+F1PwcdZajYNEPFXn0w==
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr2164558oto.367.1579864568443;
        Fri, 24 Jan 2020 03:16:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzN0HDVK+JjlK+Ai2tzkTErj3rh3UDezUuWXlFDj0HyDTJmgEULymM4d82b9nwwwuRK1aMe71lfq60r9ZsSPns=
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr2164542oto.367.1579864568151;
 Fri, 24 Jan 2020 03:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20200123125716.12662-1-omosnace@redhat.com> <20200124103918.GA51061@baraddur.perfinion.com>
In-Reply-To: <20200124103918.GA51061@baraddur.perfinion.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 24 Jan 2020 12:15:57 +0100
Message-ID: <CAFqZXNtffOz+NjX7eU3sOCrmbWSinY+mWGLaJcMTEEYWfK=abg@mail.gmail.com>
Subject: Re: [PATCH userspace v2 0/4] Fix build with -fno-common
To:     Jason Zaman <jason@perfinion.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 24, 2020 at 11:39 AM Jason Zaman <jason@perfinion.com> wrote:
> On Thu, Jan 23, 2020 at 01:57:12PM +0100, Ondrej Mosnacek wrote:
> > GCC 10 is going to enable -fno-common by default [1], so fix all build
> > errors uncovered by it and add it to global CFLAGS to avoid introducing
> > new bugs.
>
> How far back does -fno-common go? Will this affect our minimum GCC
> version at all? I assume it wont but figured I'd ask just in case.

Good question... It looks like it's been around since at least 1996:

https://github.com/gcc-mirror/gcc/commit/9493f1421183f7c39598629fe60d37c599dfe2af

(That doesn't seem to be the commit that introduced it, but I hope it
suffices as evidence :)

>
> -- Jason
>
> > Changes in v2:
> >  - remove also struct te_assert definition, which is also useless
> >  - redo cil_mem_error_handler to match commit 4459d635b8f1 as suggested
> >    by Jim Carter
> >
> > Travis build: [2]
> >
> > [1] https://gcc.gnu.org/gcc-10/porting_to.html#common
> > [2] https://travis-ci.org/WOnder93/selinux/builds/640875119
> >
> > Ondrej Mosnacek (4):
> >   libsepol: fix CIL_KEY_* build errors with -fno-common
> >   libsepol: remove leftovers of cil_mem_error_handler
> >   checkpolicy: remove unused te_assertions
> >   Makefile: always build with -fno-common
> >
> >  Makefile                        |   3 +-
> >  checkpolicy/checkpolicy.h       |  14 --
> >  libsepol/cil/src/cil.c          | 162 ++++++++++++++++
> >  libsepol/cil/src/cil_internal.h | 322 ++++++++++++++++----------------
> >  libsepol/cil/src/cil_mem.h      |   1 -
> >  libsepol/cil/src/cil_strpool.c  |   8 +-
> >  6 files changed, 329 insertions(+), 181 deletions(-)
> >
> > --
> > 2.24.1
> >
>


-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

