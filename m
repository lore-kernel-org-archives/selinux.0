Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9487EC433EF
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 15:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiC3PMQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347941AbiC3PMP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 11:12:15 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CBDC682F
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 08:10:30 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id e189so22335444oia.8
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkCg2H85deIVJJSgXURZwfCnYWO/tnnYlke7j1v1H7w=;
        b=qSU6IBAAd2PFdWgms7WeChBxJ6XJDbCfL8aiOgfkMU3BSJ3X6RKzETsAl+PlSceiQA
         XyshsErRpsYAimeOaVJX9r3PqSnPZF4rrm/xRP9zZj9w+KE57Qzo8HzCzPgGtBNn4LGj
         2pi1/+WeYo9qikPCcmFcBnJt2vhPMoCQMlb88mHj6SZIO4QPbofw6uPLkMXIaSUVj86Z
         rBkbrHlBmQzJUim15AZbpp8oH6yMheYo8cCwFe4lumfmNYcq1eI+Bv0lGq+tC/J8y1ze
         Tfwqfwb0vNBc9bO9gcwr50lhJR9jOHxVbTj/hNsQMB5HLKK1PyvK+WbqqPlZfJWUpcQS
         uXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkCg2H85deIVJJSgXURZwfCnYWO/tnnYlke7j1v1H7w=;
        b=tXrvipS/BoAEmI3CkIvVkgvcSfB0vXt1OagsMzyUiBnhzMnt8KwTGttp6ZVYN8WsX4
         3PT2Jby2dkmJRsMTi0u33aPnaPKHIdUjG2X0NopJl67VvrSrE/B8B6GTCQYgkL9w/zTh
         yK9ERx+6LoQ6GMkZqGxIOED/yfNmnXwtNHQAQcHdu5pFFWFc0vFNHUsx0c5Xk1Iepikb
         NcvM8ZVgTZBar2DXQJNzntpjUFK7wkBhrjKBm6P+05vyBNx7AT2voR8lSU3aiBTNia0K
         2KkzHkcbuGHncso4r2bjh6xPpDPToRUXyGE1v62NRgmDcuVRW5TTo17Rh8082OGrgGDP
         LRKw==
X-Gm-Message-State: AOAM532nEi53oaqVff40kqEi9jQYBRc2AquZGNxWL2QoRG8ywaSv1yJF
        usuJma2WRh5w04CPZpJZKQmKUnb6cFWbTKQat8XLrDHR
X-Google-Smtp-Source: ABdhPJwH0k9rdDPk93w5NThcE//OHujSWkF73jwuEDYKsb658b6MJo39m7P5d4T8fkXwy7YkHxwT7A6/njh5rsy7A2I=
X-Received: by 2002:a05:6808:ecb:b0:2f7:41cc:21b9 with SMTP id
 q11-20020a0568080ecb00b002f741cc21b9mr47228oiv.156.1648653029325; Wed, 30 Mar
 2022 08:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220314182400.121510-1-jwcart2@gmail.com> <CAGB+Vh59mbuLpAAXU2vikcF+3H9t_DY9N8GNHEkWv7bzP0hXGQ@mail.gmail.com>
 <CAP+JOzSm3S4xkzRAwvs+5Diy39LimcSr44dH48_gqjTwcwG1EA@mail.gmail.com> <CAGB+Vh7aBin48a2yrwG2ei_K6jKQJH5DH-vfroJ_xWnved6smA@mail.gmail.com>
In-Reply-To: <CAGB+Vh7aBin48a2yrwG2ei_K6jKQJH5DH-vfroJ_xWnved6smA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 30 Mar 2022 11:10:18 -0400
Message-ID: <CAP+JOzSoCCUJD1fD05Fz1po+qnOch5zaY3uUNo1yXsvGOMTy2A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use calloc when initializing bool_val_to_struct array
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 30, 2022 at 11:09 AM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
>
> On Wed, Mar 30, 2022 at 10:51 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Wed, Mar 30, 2022 at 9:55 AM Joshua Brindle
> > <joshua.brindle@crunchydata.com> wrote:
> > >
> > > On Mon, Mar 14, 2022 at 2:24 PM James Carter <jwcart2@gmail.com> wrote:
> > > >
> > > > Use calloc() instead of mallocarray() so that everything is
> > > > initialized to zero to prevent the use of unitialized memory when
> > > > validating malformed binary policies.
> > > >
> > > > Found by oss-fuzz (#45493)
> > > >
> > > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > > > ---
> > > >  libsepol/src/conditional.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> > > > index f78b38a2..a620451d 100644
> > > > --- a/libsepol/src/conditional.c
> > > > +++ b/libsepol/src/conditional.c
> > > > @@ -522,7 +522,7 @@ int cond_init_bool_indexes(policydb_t * p)
> > > >         if (p->bool_val_to_struct)
> > > >                 free(p->bool_val_to_struct);
> > > >         p->bool_val_to_struct = (cond_bool_datum_t **)
> > > > -           mallocarray(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> > > > +           calloc(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> > > >         if (!p->bool_val_to_struct)
> > > >                 return -1;
> > > >         return 0;
> > > > --
> > > > 2.34.1
> > >
> > > Why not change the mallocarray macro to use calloc? I see a number of
> > > mallocarray calls that should be audited if this approach is taken.
> >
> > Many of the calls to mallocarray() should be replaced by calloc()
> > because the array is initialized to zero right after the mallocarray()
> > call. I guess all of the calls can be replaced if you don't mind
> > having the memory set to zero and then immediately setting the array
> > to different values.
> >
> > I will merge this patch and send another patch replacing mallocarray()
> > where appropriate.
> >
>
> Hrm, I meant something like:
>
> diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> index a8cc1472..9a51fb34 100644
> --- a/libsepol/src/private.h
> +++ b/libsepol/src/private.h
> @@ -90,7 +90,7 @@ static inline void* mallocarray(size_t nmemb, size_t size) {
>                 return NULL;
>         }
>
> -       return malloc(nmemb * size);
> +       return calloc(nmemb, size);
>  }
>
>  #ifndef HAVE_REALLOCARRAY
>
>
> Since mallocarray has additional length checking logic that you lose
> if you just switch from mallocarray to calloc.

Does it? The man page for calloc says that it will return an error if
nmemb * size will overflow.

Jim
