Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F2CC35242
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD0520848
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BqA7BNPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBLCuE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:50:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40316 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbgBLCuE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 21:50:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id p3so623789edx.7
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 18:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftCgYe+qTUJvxXr7u0eSTR+m0ITfiObBN6a9BVxETWY=;
        b=BqA7BNPqYswoMD/MauwEWjxvSNCGs4jIsmMC5aAm5nw8VuZrrZ3whJcHO/L9BoYrRX
         csY361p65ujRiHc6oY4KsHLOWktGfpPcwn7xJImfwnOJSZDdvDljLZYd/FFT5AJqxk5G
         j65flH0HYw1pPLEpntjqYKnp3v0H1MiYZSei9nKwfHrm+mafqJC5fm11QwRAW36IgAXZ
         8UHfHQ899Js7wRc+wdeg2emgz61yt3neLeOZlOAFmGGfYN2DJR94QGV1MCGP8gfvFAmq
         0j4Q9KqG4hh/WYfSgKm0Dnj80YmVP5PcqeQ831YGlvdYxaPwl5QsyJXspXW/4Dd9/FlL
         7UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftCgYe+qTUJvxXr7u0eSTR+m0ITfiObBN6a9BVxETWY=;
        b=ccrmu5OYQYGIvJZSCOhd7O5nK+IRrxMR0N6P11Ms4x+4ycKBKyaoRYgCR+U6c6nmYb
         JdxSnJm5R6/RpDr/yskSMK5mmnIEsYplbTM8JcpRX/ZTAzEBP/59UagyB4FHW1J/2kNp
         4DGUllSfUQoC5iN2ER5LZ8brt3xiE7wIadBV+4e4Bzw6QXxTv65EZ/aKqU+Y7VVS2mr1
         eudlcGtRiIIgYfgibumTzi5q4eJvLGIlO5CfBVxubOo8CwCwp3WRj0sTiQ5/KChctD9E
         5eNJESdLrgxbTb4MVOQ8DgQulVyikDfH7GsFqfa4h2YCiP1o/y2wb3bYPR8rykr2mjLZ
         oR+Q==
X-Gm-Message-State: APjAAAUnXuuBBeM6hd+yP40VEQol3x9gmVjnCIuMTsmBovfBvYOSpRHC
        xRFFnb5pMnc+1yDYjTCdD/j8UgIig6wS8+JvAwI9eubyvA==
X-Google-Smtp-Source: APXvYqx2WFZfgD2Rne1gKiDHBP4d1S/M1m7lFrck438+2vgpsbQhcPemmXK5OKL4V9J70ZDdu3EHHuv2H+veGzRlLmw=
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr8743871eja.77.1581475801667;
 Tue, 11 Feb 2020 18:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20200203112723.405341-1-omosnace@redhat.com> <20200203112723.405341-5-omosnace@redhat.com>
In-Reply-To: <20200203112723.405341-5-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Feb 2020 21:49:50 -0500
Message-ID: <CAHC9VhSF2GYaeCNTSunBZS9ks5VM6_+3cBwLCgTHO8ZMuk2=oA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selinux: convert cond_expr to array
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 3, 2020 at 6:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since it is fixed-size after allocation and we know the size beforehand,
> using a plain old array is simpler and more efficient.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/ss/conditional.c | 62 ++++++++++++-------------------
>  security/selinux/ss/conditional.h | 14 ++++---
>  2 files changed, 33 insertions(+), 43 deletions(-)

This one too ... merged.

-- 
paul moore
www.paul-moore.com
