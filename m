Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF85DC433F5
	for <selinux@archiver.kernel.org>; Tue, 30 Nov 2021 11:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhK3LQX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhK3LQX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Nov 2021 06:16:23 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281E0C061574
        for <selinux@vger.kernel.org>; Tue, 30 Nov 2021 03:13:04 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id a11-20020a4ad1cb000000b002c2657270a0so6604815oos.8
        for <selinux@vger.kernel.org>; Tue, 30 Nov 2021 03:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XMEIjzq3bQECYZ3KYi48kwnU3trmjZqMxnsUJ5QoL/8=;
        b=hU6mG/fEVwcE9+ISqgsOfrpRF2hLLtdzA6yuEaU5DQeKLN3YJJTtwVKj1PRzC5JNq0
         hk7NZIwkecZejWevs0aV6pM50eGjOpO3VuLfYfTcj0QZy5d9cT1TyomXOHN4CVsLSY3z
         +ZVTERNQK17TZnUr8G3FZWr+RH3DbhIdJvoycE/T8Ue9Ua2GbQ5mXwDG0Pr3UW/UKgqQ
         FzY4W6ZQucbw6m9Qfu4QuahdZUAKbC2jtVwD5SksgZgRtZwFNtrVI21cQ2Z14zLYB1wL
         QnyU/EKJcxiLRNpe1aUTOCiF9RZUIDYxcft0aDGLBMP4gs3BTxMS2S93IuWBF2uJeSJN
         Pvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XMEIjzq3bQECYZ3KYi48kwnU3trmjZqMxnsUJ5QoL/8=;
        b=sAhJdBd3gSzybVvca5z+d/1dOZbjk9So1yk5S47Wo0cEoZGoUFH8/LcvuMiHMXwxvM
         EDKcRuV3YbVo/CI7m7HEtCs7wTIlneINLTJjywidxw8ogeP6BQ16c/oxh5Qu+uIe7W/t
         rfoIzU/QM5YyYjd0MEJ3dYS+WtVYBZlljeQbCKEdoTmO86ViUjLnKqb8nBLfgvP39Pft
         Pi22dBo29WSXqMMVu3EatatALDp4ZIAaehEcVPg93lOhWGR2UmI3z0axpHYzsHf+WbKm
         r+NBFVfH4XUjm/WgMWgUnTg9ATUSQ+umaX7pUlfk3vF1LM2E5JtWGSXEIa6IJv3GMvRm
         97aw==
X-Gm-Message-State: AOAM533oKzphxZJ+fXPgariaNKgrIn5bizVqNMTv5/2IzD55MzKZwAGE
        ZpGzHg++jB0sLOSK3r42S5LkEkzJRCfkU+o8J/Y=
X-Google-Smtp-Source: ABdhPJzxMDpJz83dpLMLnqbJtvAkhDyyEJ+71i8rqS8ju0jbN4RDZk4TacPzRZIxiOz3rxPJDW9T67UQmM3NDnu3u1g=
X-Received: by 2002:a4a:d486:: with SMTP id o6mr6763400oos.49.1638270783384;
 Tue, 30 Nov 2021 03:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20211123190704.14341-1-cgzones@googlemail.com>
 <20211124190815.12757-1-cgzones@googlemail.com> <CAP+JOzQipvtFYq-R=BvsXaoa_LyZtYTMoPEc0H_oAgqxq9Cqrg@mail.gmail.com>
In-Reply-To: <CAP+JOzQipvtFYq-R=BvsXaoa_LyZtYTMoPEc0H_oAgqxq9Cqrg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 30 Nov 2021 12:12:52 +0100
Message-ID: <CAJ2a_Dc_wt0UaYkEEFJ=Zg-Qn9N7soa_eFkhsO6WM-uWybGb+w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] libsepol: introduce ebitmap_subtract()
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 29 Nov 2021 at 18:48, James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Nov 25, 2021 at 3:03 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add a subtract method for ebitmaps.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2:
> >    - add shortcut for empty ebitmaps
> > ---
> >  libsepol/include/sepol/policydb/ebitmap.h |  1 +
> >  libsepol/src/ebitmap.c                    | 18 ++++++++++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/inclu=
de/sepol/policydb/ebitmap.h
> > index 81d0c7a6..daca67a2 100644
> > --- a/libsepol/include/sepol/policydb/ebitmap.h
> > +++ b/libsepol/include/sepol/policydb/ebitmap.h
> > @@ -83,6 +83,7 @@ static inline int ebitmap_node_get_bit(const ebitmap_=
node_t * n, unsigned int bi
> >  extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
> >  extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebi=
tmap_t * e2);
> >  extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
> > +extern int ebitmap_subtract(ebitmap_t *dst, const ebitmap_t *e1);
> >  extern int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebit=
map_t *e2);
> >  extern int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebit=
map_t *e2);
> >  extern int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned i=
nt maxbit);
> > diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> > index 1de3816a..80f0e201 100644
> > --- a/libsepol/src/ebitmap.c
> > +++ b/libsepol/src/ebitmap.c
> > @@ -72,6 +72,24 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t *=
 e1)
> >         return 0;
> >  }
> >
> > +int ebitmap_subtract(ebitmap_t *dst, const ebitmap_t *e1)
> > +{
> > +       unsigned int i, length;
> > +
> > +       if (ebitmap_is_empty(dst) || ebitmap_is_empty(e1))
> > +               return 0;
> > +
> > +       length =3D min(ebitmap_length(dst), ebitmap_length(e1));
> > +       for (i=3D0; i < length; i++) {
> > +               if (ebitmap_get_bit(e1, i)) {
> > +                       int rc =3D ebitmap_set_bit(dst, i, 0);
> > +                       if (rc < 0)
> > +                               return rc;
> > +               }
> > +       }
> > +       return 0;
> > +}
> > +
> >  int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *=
e2)
> >  {
> >         unsigned int i, length =3D min(ebitmap_length(e1), ebitmap_leng=
th(e2));
> > --
> > 2.34.0
> >
>
> We already have ebitmap_andnot() which does the same thing (although
> it does take three ebitmaps). Also, subtract is not a bit operation,
> so it doesn't seem to fit.

ebitmap_andnot() does perform a not and an and operation (so two
iterations over the ebitmaps) and allocates a temporary ebitmap on the
way.
So I think this new helper has its justification for performance reasons.
Do you prefer another name, e.g. ebitmap_rel_comp() (see
https://en.wikipedia.org/wiki/Complement_(set_theory)#Relative_complement)?

> Thanks,
> Jim
