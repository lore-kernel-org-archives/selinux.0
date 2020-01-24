Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBD7C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 10:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B98E2070A
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 10:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20150623.gappssmtp.com header.i=@perfinion-com.20150623.gappssmtp.com header.b="SUH4Ghd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgAXKjX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:39:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41723 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXKjX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 05:39:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so803384pgk.8
        for <selinux@vger.kernel.org>; Fri, 24 Jan 2020 02:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MwowejhIkxhaOsyzADgOKoxK6j3Lx+MwQs4eBTNd6/g=;
        b=SUH4Ghd1OV2lUwYMfLAKqYOKQuy2fsOkGbitR1Aiky+rSxbuPQ0hWLFPe+Yn/oXtqp
         ER5jOuIlQ378/wZeR43xuwposj2cgQN6PwOK1MRV0SxdEW3PIm1JykmhSMaBTOivfY1a
         i61U+bsMtg73qyqYPfEDqfka8KPFjzLGnz00SYUPJGBEpQH5Ojc2peAjICOqBE50XHFA
         //YTGn3mVs55oVUBYaZUyqqD1Ta3lfy1uXNn5431tJ+Bk5g8Z6nENAdEcMH/v3LP9+77
         zzPly0yy74XtJ7J8geag1eglA+Iiw2MWiF63sdZ1U89jh+BTqMRehoAZ5WzMNAePloaB
         8POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MwowejhIkxhaOsyzADgOKoxK6j3Lx+MwQs4eBTNd6/g=;
        b=f40WSFBRpUL6kpSJ62m724sBPgbPeCAi8Ph7CT6bL0ibpUd+hcSaQWCchrRKwBOCS4
         9U/lz3L0ZihdcwhlYTrwHH7nXDv7fR8FKjqW+pjs/r/mb051UjhIqPYDIXnrl8xVfN0V
         I5vqMlAXXNF1WIJ335TRPRRAv0aIs79Tra1333eWsAPpjh+9uyEtCJcUatMFW8j6tK4R
         L+fMnDKyuuH9s60kL9AffKIXUHLQuBW9fAfjdcruugWx0sxwcaXClZQPEks1bvCs469d
         1swDuJaQin3H7oPuKvPjpye2+IyfgN3XtbjP05HF+45c4YTP9PgFyDOkuTk6/wj8fBZj
         Xz1g==
X-Gm-Message-State: APjAAAUO6Z9KXSnnonyCYgEprDHv9ki6I0BldkNBNevCowveLwUx39vH
        N6vFJgChGBhz+HH6OH2pnAd/WsbNrtY=
X-Google-Smtp-Source: APXvYqw7jMMHLVx3ZhphuR8qhQHJu7JG3nOsDp+QFVE3hg6eMk0BZH2/cSfoUl1RMLoZu/XFAUpneA==
X-Received: by 2002:a65:4242:: with SMTP id d2mr3398221pgq.166.1579862362276;
        Fri, 24 Jan 2020 02:39:22 -0800 (PST)
Received: from localhost ([101.127.140.252])
        by smtp.gmail.com with ESMTPSA id l2sm5950134pjt.31.2020.01.24.02.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 02:39:21 -0800 (PST)
Date:   Fri, 24 Jan 2020 18:39:18 +0800
From:   Jason Zaman <jason@perfinion.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH userspace v2 0/4] Fix build with -fno-common
Message-ID: <20200124103918.GA51061@baraddur.perfinion.com>
References: <20200123125716.12662-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123125716.12662-1-omosnace@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 23, 2020 at 01:57:12PM +0100, Ondrej Mosnacek wrote:
> GCC 10 is going to enable -fno-common by default [1], so fix all build
> errors uncovered by it and add it to global CFLAGS to avoid introducing
> new bugs.

How far back does -fno-common go? Will this affect our minimum GCC
version at all? I assume it wont but figured I'd ask just in case.

-- Jason

> Changes in v2:
>  - remove also struct te_assert definition, which is also useless
>  - redo cil_mem_error_handler to match commit 4459d635b8f1 as suggested
>    by Jim Carter
> 
> Travis build: [2]
> 
> [1] https://gcc.gnu.org/gcc-10/porting_to.html#common
> [2] https://travis-ci.org/WOnder93/selinux/builds/640875119
> 
> Ondrej Mosnacek (4):
>   libsepol: fix CIL_KEY_* build errors with -fno-common
>   libsepol: remove leftovers of cil_mem_error_handler
>   checkpolicy: remove unused te_assertions
>   Makefile: always build with -fno-common
> 
>  Makefile                        |   3 +-
>  checkpolicy/checkpolicy.h       |  14 --
>  libsepol/cil/src/cil.c          | 162 ++++++++++++++++
>  libsepol/cil/src/cil_internal.h | 322 ++++++++++++++++----------------
>  libsepol/cil/src/cil_mem.h      |   1 -
>  libsepol/cil/src/cil_strpool.c  |   8 +-
>  6 files changed, 329 insertions(+), 181 deletions(-)
> 
> -- 
> 2.24.1
> 
