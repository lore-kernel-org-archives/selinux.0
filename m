Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC4C433F5
	for <selinux@archiver.kernel.org>; Tue, 30 Nov 2021 15:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhK3PjZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhK3PjZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Nov 2021 10:39:25 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6DBC061574
        for <selinux@vger.kernel.org>; Tue, 30 Nov 2021 07:36:06 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso6820174ooa.6
        for <selinux@vger.kernel.org>; Tue, 30 Nov 2021 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dAomew5eSi41lWsVxLurXpKfx1pupt5t41jmbsUm+7A=;
        b=CyKnyS64jDWXWnalizxTljHONhZJRVap+84V+bCJBttbduApl7P58k6BbdpCT88mrb
         Jm0Q9bZ+osysCikYAk9VvR966W6b6cwI2n/wPv5j1YtlXP9/iL16BFcd4Tl48hPJqh5s
         SziqrQctBmr0/LwfoAf18o+O1WRRt+VE2zFOv8rSGKgOWIGEWh48ShVY3hzQ/xY6BwX5
         KgUnj9f1OPpNqEFOOQ7/91iKJ4N67cQMXRtO12buLAS86tQ+l2ssJQNO1Xzu7qICQTtn
         IMUmGGe/h1q3qOFx1HLB2+AQNbikVPidkROUt9TPi28bVx4tlFsVujNEye24uEawwBa7
         qw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dAomew5eSi41lWsVxLurXpKfx1pupt5t41jmbsUm+7A=;
        b=i/j+x0mPJEoDpp4lhjXHjeGXXKRdM14aWQbbxU0GagJI8EN3XTIt0M6utdBN8/QftV
         wVJfIMgEKGCKjdugxlLfKRnzMrbB7S31l5F726EbNlDTmMq7tpK6rYALvQ7ZribEWIKy
         zCO7qQ8iVQpp4QX2vtM4uge1iOkqGuXv9/8bmBLSYGu3a4Y/PskNI52NgAUk3FsRAASG
         r8CEE4fesMFMj82BWh39JiTNv+FobrLw7ZOFwZ9A1h3FvukZHtv+1F8JsnGOqwB4QvqA
         KsQiqsNW7kKWUgej+iG0QdNIpz2qrtSmyuLqvGF+YVlHgGU1+BBSQhC67yUWQEKFsPmF
         OzPQ==
X-Gm-Message-State: AOAM532N9sQ9R7TmA8D/rIBSuP7K1yfsRO/Z86bxsb54A0iUXjmd+WMK
        PyT7fnwPR3IQRg+0KrsdR5QTkj7V5tzvnyfAm1gzXmk/
X-Google-Smtp-Source: ABdhPJwAqYffCTlr34QtkuWCANIkfaJ+mSUzEsDYx+LKktTf9PBnXmyJBHLgsFSdzLURm3TMmo3Mg9f50ZoZo1QhjIY=
X-Received: by 2002:a4a:1b02:: with SMTP id 2mr38640oop.2.1638286565627; Tue,
 30 Nov 2021 07:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20211123190704.14341-1-cgzones@googlemail.com>
 <20211124190815.12757-1-cgzones@googlemail.com> <CAP+JOzQipvtFYq-R=BvsXaoa_LyZtYTMoPEc0H_oAgqxq9Cqrg@mail.gmail.com>
 <CAJ2a_Dc_wt0UaYkEEFJ=Zg-Qn9N7soa_eFkhsO6WM-uWybGb+w@mail.gmail.com>
In-Reply-To: <CAJ2a_Dc_wt0UaYkEEFJ=Zg-Qn9N7soa_eFkhsO6WM-uWybGb+w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 30 Nov 2021 10:35:54 -0500
Message-ID: <CAP+JOzRYW2io6b0Gv0CXT6V1Lx337WFkOywxN7DvH-JUFpkh-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] libsepol: introduce ebitmap_subtract()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 30, 2021 at 6:13 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 29 Nov 2021 at 18:48, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 3:03 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Add a subtract method for ebitmaps.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > > v2:
> > >    - add shortcut for empty ebitmaps
> > > ---
> > >  libsepol/include/sepol/policydb/ebitmap.h |  1 +
> > >  libsepol/src/ebitmap.c                    | 18 ++++++++++++++++++
> > >  2 files changed, 19 insertions(+)
> > >
> > > diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/inc=
lude/sepol/policydb/ebitmap.h
> > > index 81d0c7a6..daca67a2 100644
> > > --- a/libsepol/include/sepol/policydb/ebitmap.h
> > > +++ b/libsepol/include/sepol/policydb/ebitmap.h
> > > @@ -83,6 +83,7 @@ static inline int ebitmap_node_get_bit(const ebitma=
p_node_t * n, unsigned int bi
> > >  extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
> > >  extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const e=
bitmap_t * e2);
> > >  extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
> > > +extern int ebitmap_subtract(ebitmap_t *dst, const ebitmap_t *e1);
> > >  extern int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const eb=
itmap_t *e2);
> > >  extern int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const eb=
itmap_t *e2);
> > >  extern int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned=
 int maxbit);
> > > diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> > > index 1de3816a..80f0e201 100644
> > > --- a/libsepol/src/ebitmap.c
> > > +++ b/libsepol/src/ebitmap.c
> > > @@ -72,6 +72,24 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t=
 * e1)
> > >         return 0;
> > >  }
> > >
> > > +int ebitmap_subtract(ebitmap_t *dst, const ebitmap_t *e1)
> > > +{
> > > +       unsigned int i, length;
> > > +
> > > +       if (ebitmap_is_empty(dst) || ebitmap_is_empty(e1))
> > > +               return 0;
> > > +
> > > +       length =3D min(ebitmap_length(dst), ebitmap_length(e1));
> > > +       for (i=3D0; i < length; i++) {
> > > +               if (ebitmap_get_bit(e1, i)) {
> > > +                       int rc =3D ebitmap_set_bit(dst, i, 0);
> > > +                       if (rc < 0)
> > > +                               return rc;
> > > +               }
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > >  int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t=
 *e2)
> > >  {
> > >         unsigned int i, length =3D min(ebitmap_length(e1), ebitmap_le=
ngth(e2));
> > > --
> > > 2.34.0
> > >
> >
> > We already have ebitmap_andnot() which does the same thing (although
> > it does take three ebitmaps). Also, subtract is not a bit operation,
> > so it doesn't seem to fit.
>
> ebitmap_andnot() does perform a not and an and operation (so two
> iterations over the ebitmaps) and allocates a temporary ebitmap on the
> way.
> So I think this new helper has its justification for performance reasons.
> Do you prefer another name, e.g. ebitmap_rel_comp() (see
> https://en.wikipedia.org/wiki/Complement_(set_theory)#Relative_complement=
)?
>

I do prefer that name and will be fine with the patch with that name.
Thanks,
Jim

> > Thanks,
> > Jim
