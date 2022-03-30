Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8166BC433F5
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 15:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbiC3PXu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243242AbiC3PXs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 11:23:48 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B8192362
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 08:22:01 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h18so10195041ila.12
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 08:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHM8xkqLSlTxZ5CWW+E97Lf9LYJLU9OmLftw5n5cgwY=;
        b=oC0kIUT16fUAYmYhRPVeBPjl3zCzEOPCXOq2/TCJLkdCLOZYiI4gZfMG/aOUXTbDUG
         Xw+g5h8lV5/LSFgLsi2AIQPNxZRFuWdADV53ubELckez3r01wuld7GS0jVxGOHQbs0zD
         dEUjP5rYHTGar/ShYznTHVmYcW5PBjk+s+N7OfeZUtiSgbPG9AXl+yl3FgRAkVbn23si
         7MIJQzBQqKuz34ROk2WmuB98O/dLbpWJVCXS9VJJ+HnelgvWukddiCqcHA2hnspXizHE
         Qi1iifqZP1vW+gV8Plr9PmhgnqZBttZp0KHAgkPYc3x7mF3C8KMDKeJS/fNvQQ/YlLUx
         TO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHM8xkqLSlTxZ5CWW+E97Lf9LYJLU9OmLftw5n5cgwY=;
        b=MN1dRTebRKonxtOKE0lkrBV99cyp5ljFBO83lnxlp08gj8EGKLvasAyYQ0bIXZi7ks
         TlZRJiBa3GvZ2XWEWURYKtd2D0oNcMp4te25vL9d2hOZUf0wc/pJnVehehUYU2CkzmaA
         JNxuAQLtFMZBSxW2Owfb2beAVNixTv4JyvbX2/B11AUDsmFCeEU6tScNnqhDyJhHdLJA
         M7u7eprApjTW2+YSTz3l/wG32XQ9B3c48+CZg7jfGc7KApFNut1nzKpm7ZaXd++Ptl8x
         BLAEIlILlLchVgOUxltfLP9ExWaIwP6Zy2kJvSmlsNo7kcejarHSApoSmQeHTrtUKRVy
         Rk1A==
X-Gm-Message-State: AOAM531bygDr1i8SSukWBjNMPJ1HOxFGgYL2bxUrDkC9KumZvIIB7Kcn
        JRm4UoJObAHyLbqvKB6O8K/cKgOekNTboisrTF7kFg==
X-Google-Smtp-Source: ABdhPJzjXiN0E/JaCQoupB44azLEopG8iA8btrLo9RnaSNSzmRqQeepvDx/SfWPMRUykk2XKrZJfAonSmG+8+V0p+d4=
X-Received: by 2002:a05:6e02:164b:b0:2c7:f5b9:214e with SMTP id
 v11-20020a056e02164b00b002c7f5b9214emr11551297ilu.188.1648653721027; Wed, 30
 Mar 2022 08:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220314182400.121510-1-jwcart2@gmail.com> <CAGB+Vh59mbuLpAAXU2vikcF+3H9t_DY9N8GNHEkWv7bzP0hXGQ@mail.gmail.com>
 <CAP+JOzSm3S4xkzRAwvs+5Diy39LimcSr44dH48_gqjTwcwG1EA@mail.gmail.com>
 <CAGB+Vh7aBin48a2yrwG2ei_K6jKQJH5DH-vfroJ_xWnved6smA@mail.gmail.com> <CAP+JOzSoCCUJD1fD05Fz1po+qnOch5zaY3uUNo1yXsvGOMTy2A@mail.gmail.com>
In-Reply-To: <CAP+JOzSoCCUJD1fD05Fz1po+qnOch5zaY3uUNo1yXsvGOMTy2A@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Wed, 30 Mar 2022 11:21:50 -0400
Message-ID: <CAGB+Vh6nFp2fj0KzSd-vr-hG3nz1SpdDX2YP8snkpdmN1C=dRg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use calloc when initializing bool_val_to_struct array
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 30, 2022 at 11:10 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Mar 30, 2022 at 11:09 AM Joshua Brindle
> <joshua.brindle@crunchydata.com> wrote:
> >
> > On Wed, Mar 30, 2022 at 10:51 AM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > On Wed, Mar 30, 2022 at 9:55 AM Joshua Brindle
> > > <joshua.brindle@crunchydata.com> wrote:
> > > >
> > > > On Mon, Mar 14, 2022 at 2:24 PM James Carter <jwcart2@gmail.com> wrote:
> > > > >
> > > > > Use calloc() instead of mallocarray() so that everything is
> > > > > initialized to zero to prevent the use of unitialized memory when
> > > > > validating malformed binary policies.
> > > > >
> > > > > Found by oss-fuzz (#45493)
> > > > >
> > > > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > > > > ---
> > > > >  libsepol/src/conditional.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> > > > > index f78b38a2..a620451d 100644
> > > > > --- a/libsepol/src/conditional.c
> > > > > +++ b/libsepol/src/conditional.c
> > > > > @@ -522,7 +522,7 @@ int cond_init_bool_indexes(policydb_t * p)
> > > > >         if (p->bool_val_to_struct)
> > > > >                 free(p->bool_val_to_struct);
> > > > >         p->bool_val_to_struct = (cond_bool_datum_t **)
> > > > > -           mallocarray(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> > > > > +           calloc(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> > > > >         if (!p->bool_val_to_struct)
> > > > >                 return -1;
> > > > >         return 0;
> > > > > --
> > > > > 2.34.1
> > > >
> > > > Why not change the mallocarray macro to use calloc? I see a number of
> > > > mallocarray calls that should be audited if this approach is taken.
> > >
> > > Many of the calls to mallocarray() should be replaced by calloc()
> > > because the array is initialized to zero right after the mallocarray()
> > > call. I guess all of the calls can be replaced if you don't mind
> > > having the memory set to zero and then immediately setting the array
> > > to different values.
> > >
> > > I will merge this patch and send another patch replacing mallocarray()
> > > where appropriate.
> > >
> >
> > Hrm, I meant something like:
> >
> > diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> > index a8cc1472..9a51fb34 100644
> > --- a/libsepol/src/private.h
> > +++ b/libsepol/src/private.h
> > @@ -90,7 +90,7 @@ static inline void* mallocarray(size_t nmemb, size_t size) {
> >                 return NULL;
> >         }
> >
> > -       return malloc(nmemb * size);
> > +       return calloc(nmemb, size);
> >  }
> >
> >  #ifndef HAVE_REALLOCARRAY
> >
> >
> > Since mallocarray has additional length checking logic that you lose
> > if you just switch from mallocarray to calloc.
>
> Does it? The man page for calloc says that it will return an error if
> nmemb * size will overflow.

Alright, +1
