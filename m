Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC77C433EF
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 15:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbiC3PKy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348060AbiC3PKt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 11:10:49 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B729831
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 08:09:03 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e18so14732986ilr.2
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTSky7XAl8fDeNDuPo3899FkcF+mPbhuj9HjUGynedM=;
        b=B1zC49s2iQqA+YW090KKIBCBZaB1iDuUdponjOg6asJhmx1bCpgEMnrlEDVMGndfi+
         bYiGc9OjCryCc9Y+FIiRgvKN+ncrt0VTbddp45tfDTfA8dGsPOnflL7knjdb2JNhdGwF
         vPk2VZRGkBcsSfVew8iET/b45SH3Dkuq6DSsVmGwmBMOOKZNqFND1khQnMMZICU8PX+e
         mn11a1RMa6r00ezFx86/h2z0o3Jv600BzTmYQxzuiRF/sZbAfm35TU7Xtm2Ibh1v/g7W
         tUWJmQk4LKQWlmxbYRrgypXAwYyKOtGvCv/YZYdeC+RPyUPKcVeNrpVVFAnLfZ+J4AXz
         qhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTSky7XAl8fDeNDuPo3899FkcF+mPbhuj9HjUGynedM=;
        b=rn+PHchxSLuznGNe2bDfpYaZS/+xpkpHKXw7Yti3NT2RYjrSVy4f3NBGBo2JIe16EB
         E0lj5y6VJVnii1JSvO69MumvH8S5X+8pdgiBl8yAenN0h3KgRanfVsemQs66dnyUNhLs
         wZntOeQ0VhSSr0lYLClXJ7rPZrZDr2YTOJJ/5MucnvbXVfK0zQpbRetv4wTJZwnqRFHY
         68i2xEAM77BMpRGAMFcea/WkBR2KDhx6Iy5aXtHxLvj1jIr3l1UeQF/9GaKiWV+EICby
         LcUtQ3b+yE/t/D7gsA17qz8usQTXXMZDmRjKk//zssw5BD77gb7O14Nj0/eLGsoA5akA
         5+uA==
X-Gm-Message-State: AOAM532Msnwo8g+z5ajmxZUhexML6p68NnbtR/uTqfl0BjHn+zY7puIu
        O/oiOdVHEMkH/MhcnGraLqr8HDRN3EytSJ+R0RsSmq1aFSK/RQ==
X-Google-Smtp-Source: ABdhPJxV+M/fetuzR32n4G6uOqPSL6S3PLX20/mQ6w9uMM83vAV87JV7fcwz/A78yKHL/Hs5bcjkuQ1c4mke1YDL3aQ=
X-Received: by 2002:a05:6e02:1c2b:b0:2c9:b42e:981b with SMTP id
 m11-20020a056e021c2b00b002c9b42e981bmr8058497ilh.37.1648652943001; Wed, 30
 Mar 2022 08:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220314182400.121510-1-jwcart2@gmail.com> <CAGB+Vh59mbuLpAAXU2vikcF+3H9t_DY9N8GNHEkWv7bzP0hXGQ@mail.gmail.com>
 <CAP+JOzSm3S4xkzRAwvs+5Diy39LimcSr44dH48_gqjTwcwG1EA@mail.gmail.com>
In-Reply-To: <CAP+JOzSm3S4xkzRAwvs+5Diy39LimcSr44dH48_gqjTwcwG1EA@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Wed, 30 Mar 2022 11:08:52 -0400
Message-ID: <CAGB+Vh7aBin48a2yrwG2ei_K6jKQJH5DH-vfroJ_xWnved6smA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use calloc when initializing bool_val_to_struct array
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 30, 2022 at 10:51 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Mar 30, 2022 at 9:55 AM Joshua Brindle
> <joshua.brindle@crunchydata.com> wrote:
> >
> > On Mon, Mar 14, 2022 at 2:24 PM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > Use calloc() instead of mallocarray() so that everything is
> > > initialized to zero to prevent the use of unitialized memory when
> > > validating malformed binary policies.
> > >
> > > Found by oss-fuzz (#45493)
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > > ---
> > >  libsepol/src/conditional.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> > > index f78b38a2..a620451d 100644
> > > --- a/libsepol/src/conditional.c
> > > +++ b/libsepol/src/conditional.c
> > > @@ -522,7 +522,7 @@ int cond_init_bool_indexes(policydb_t * p)
> > >         if (p->bool_val_to_struct)
> > >                 free(p->bool_val_to_struct);
> > >         p->bool_val_to_struct = (cond_bool_datum_t **)
> > > -           mallocarray(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> > > +           calloc(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> > >         if (!p->bool_val_to_struct)
> > >                 return -1;
> > >         return 0;
> > > --
> > > 2.34.1
> >
> > Why not change the mallocarray macro to use calloc? I see a number of
> > mallocarray calls that should be audited if this approach is taken.
>
> Many of the calls to mallocarray() should be replaced by calloc()
> because the array is initialized to zero right after the mallocarray()
> call. I guess all of the calls can be replaced if you don't mind
> having the memory set to zero and then immediately setting the array
> to different values.
>
> I will merge this patch and send another patch replacing mallocarray()
> where appropriate.
>

Hrm, I meant something like:

diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index a8cc1472..9a51fb34 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -90,7 +90,7 @@ static inline void* mallocarray(size_t nmemb, size_t size) {
                return NULL;
        }

-       return malloc(nmemb * size);
+       return calloc(nmemb, size);
 }

 #ifndef HAVE_REALLOCARRAY


Since mallocarray has additional length checking logic that you lose
if you just switch from mallocarray to calloc.
