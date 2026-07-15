Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F32BEC43
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122579; cv=pass; b=OqF3U1vqG104xBHgByDOsAMUoFzV1yhohf61U6mx3LNmhc2Ph5ClWXPc7Qrf9AgBJXzsxP4+Nxyacji3Kfn2EZLlL6bfwC4qhytTSwuGhGCzAhEK4mOPLrNw/n27rX5RuzBIfBy5U8pV9hlGO4Pf3AxFCNaQILSXd8LcFP79eNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122579; c=relaxed/simple;
	bh=yZwt3za293B5Z2nEYOwDmw5MaPSY8ewbu+MZPkD/9BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEPkAyoQUKCY7pDHTUMcL1DvqOsNs+0ySLor6Wy7ER53ooMZMmhNE1XThsHJBxJkidy7H+8DYW4HcTMsvVzynUAqWhu328aY9f03BgSOa7RFQ6X4X4ZYZWpuj2x1dCNB+8+nOOCwQ0EB8/SRGq6M9L9qrdBS6GvUTdAOM063y90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imADZDHO; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imADZDHO"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c95395230so17316481fa.2
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 06:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784122574; cv=none;
        d=google.com; s=arc-20260327;
        b=lu401KXg3dXVhvHAgZTyj05yTi/xYkAH5Iy+joSKkWMS8gFb8p4+i1MteBAh9F61e3
         Cxik+wn1uLYku852/TveuhBGyFs+Pl9KNBHbPG491VFusSVQIXXMfYrIDrVjXBKdLb5r
         bDHOi/YBR+kevs0qAJflhNv5nugfVyXh8DXryRfzPgq0Rzj9NUQ+/aSvP0QPJVFBd9LV
         gWgGZ8pdmMRDSPz1dlA8/lm+e+y0uf5sOylxfl1S4teg3az1mpn0AklcwzWqSwTZspOI
         xlo1Cix2oxiKJFdh5UgBTj78YnoY7Mnbh9ieRUOPAhg6fY4Kh7McTc9xsJDJmH0hOoQi
         HjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZlPlepQZuI5L9ZoD/6KD1HaJeojVhxMlM/ML1UH/1FE=;
        fh=T/DwU8K2ttnmUCRB/O0JCIxbGdvnCJJhfSqbbVYEQGo=;
        b=TNfFvAe3GbgvWMIyYp3MH7XzVigAPfF0xRvmVhBjFuTdva7u5QSXrQhY3ZxbEZTWzg
         xxoElv/YKpO+fh0kdzaFtPvkgIMRv+goCwV2DJdQEBcl305ZDdL7pDqwMSiB61XGirRt
         agn5HsRxxMoQM0mAKawAPMmq4lA3yaPTgbn05l0K7KeRnZHNX/PcPP8h7EK8HYTtbqHG
         QNBVNrG/cqfkYBPcjobGP7fkuqOrdIOawweyCF97W9Ltd2ie3yaI2puKD8jhUGsQtC0n
         ftmDIN5XXlTTRVUCDSgVvSXu9LRvU4z25d7FLnjNUy7uzc0T7gfMS/EWrDN1Vmsi6vkV
         AbmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122574; x=1784727374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZlPlepQZuI5L9ZoD/6KD1HaJeojVhxMlM/ML1UH/1FE=;
        b=imADZDHO92OwJFVK/VsiUW/8njirHBPc2MuiHyjQBONrl4QGM73MxR3C8c8D1mSwjC
         9CmSTqxhL19cc3e0Cp0sU5qxH/7hwn8XsiuoQHZlPfi/bpKN4bhFFF+Z7v4APYEmwBqy
         jNxItkm/Zys6tj+6m0fyoSX6ZUu2bNPeQ2eq1L3VDDcqZMADOGzGhzgXgi4DFCA0HBCd
         YhW2ciCxZ3/t0NK0Q/IWadQ4HvM35DVu7esXeREHBETOOgKP0R9vKvnrXKHAm+VYhNVz
         HTUnLeaY8DR08bOQh0YowUmLIEt6rwVO3SPxa95zZxmeyFkowcw5IUlG8MdMj1t7shTB
         yWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122574; x=1784727374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZlPlepQZuI5L9ZoD/6KD1HaJeojVhxMlM/ML1UH/1FE=;
        b=VIS69cACwQqTjWwf6UXf6CqaJU8cLyYxRD+ANn2V2Z5GYy9SF5ZMoJToPrcc9GcxZz
         hLPdqWj3p1hKXEEW+MB9PAW35f5IoosRN128/BpiNDHMD/F478APkWbSSFvNqHISQX/t
         URe+tl5Ls+jQRCfK0mhAPA/Kg3Pg3FB52J0/dDNvaE3d0ahliXdeCoKTFEwkEyefDdC2
         Lv4xpP6+A/6j2TcyedD+ADUDCDBZt2nEGW2sglVozvHdMKvTtlTjVQUdVor/vMZ7sVcM
         Y7UHivCFKctpHo6BkRD1gYsLrQWO77qf7yy9541qDrmqZMHF5PRKLjSRY9RMV+cI1pns
         vjAA==
X-Forwarded-Encrypted: i=1; AHgh+RrDiKQ3jPrhqkBKBvLeH3qA+sFVWgR7okW/GKEvddpb3KDKGPEZc8XEUh91sbHPLoThQDMyzeGh@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFrQD+51BSTyQgyf0JJuF/I7VP7OUEW9GeSLqkMB5fNGInHpa
	bYIuCdlJazVXPxgAsZmmFgjoQTC+9l0dAIt6htPXzX4Gc8jNuG0Q0I3WpAUrBJsFx2YBhk7E9yw
	UwK9YYvBXBNhcG5GSt8lmssZnX9oNxgI=
X-Gm-Gg: AfdE7cmrtGGbmQqgFyI8jVQQxm5pQzAc1oTHuvWjAZKt1i8vQV8BRnsk6RtX26u33DU
	59SR9Fg6Cyl2mD12MGUOOV+da1gzzALFib6WzibXcQqjG+KabnfaaFuKYhed6e92zO2dY9Zxrxo
	nyfv2dJeG3PeNYRczQCKR+yYKcGVktEHCtDLTNQn2mMC1KHXyIV4HAIlyxqkuUY0Zs8/Ht2SBMd
	viPaV2vwgt6QG5tKCVqsmLj43PApGJZ78qA1hcbvixef9LzMv2iYsgx2Mh+HSJmggZLpA==
X-Received: by 2002:a2e:9859:0:b0:39b:d04:b783 with SMTP id
 38308e7fff4ca-39caa8540aamr28897911fa.20.1784122573855; Wed, 15 Jul 2026
 06:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714232511.2858868-1-tweek@google.com> <CAEjxPJ6V62STmhacLbx4hD-+hu1hk4728xL=Qfp5=o0yBL-sgQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6V62STmhacLbx4hD-+hu1hk4728xL=Qfp5=o0yBL-sgQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 15 Jul 2026 09:36:02 -0400
X-Gm-Features: AUfX_mzGr6jSZcFcrmI-O54KxBXWyr34wH_Sw65wbsx6GCXMyxoHHDPSqdA-PiY
Message-ID: <CAP+JOzRCkt0AqG-X2-fgBJwz9072i8=F3yG1oCSyb8GazH+REw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: use designated initializers for label initfuncs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 9:05=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jul 14, 2026 at 7:25=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goo=
gle.com> wrote:
> >
> > Previously, the initfuncs array relied on implicit positional ordering
> > to match backend context constants (e.g., SELABEL_CTX_FILE). If constan=
ts
> > were reordered or added, array indexing could become misaligned.
> >
> > Use C99 designated initializers in initfuncs to explicitly bind each
> > initialization function to its corresponding context constant.
> >
> > Additionally, define _SELABEL_CTX_NUM in include/selinux/label.h
> > to count total backends, and add a compile-time static_assert ensuring
> > initfuncs stays in sync with _SELABEL_CTX_NUM.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Thanks,
Jim

>
> > ---
> > v2: Rebase on selinux/main and format
> >
> >  libselinux/include/selinux/label.h |  5 +++++
> >  libselinux/src/label.c             | 18 ++++++++++++------
> >  2 files changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/label.h b/libselinux/include/se=
linux/label.h
> > index 748b0db0..bde2501f 100644
> > --- a/libselinux/include/selinux/label.h
> > +++ b/libselinux/include/selinux/label.h
> > @@ -37,6 +37,11 @@ struct selabel_handle;
> >  #define SELABEL_CTX_ANDROID_PROP 4
> >  /* Android service contexts */
> >  #define SELABEL_CTX_ANDROID_SERVICE 5
> > +/*
> > + * Total number of context backends. When adding a new backend,
> > + * please increase this value.
> > + */
> > +#define _SELABEL_CTX_NUM 6
> >
> >  /*
> >   * Available options
> > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > index 1ccd1abe..991b9769 100644
> > --- a/libselinux/src/label.c
> > +++ b/libselinux/src/label.c
> > @@ -4,6 +4,7 @@
> >   * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
> >   */
> >
> > +#include <assert.h>
> >  #include <sys/types.h>
> >  #include <ctype.h>
> >  #include <errno.h>
> > @@ -45,14 +46,19 @@ typedef int (*selabel_initfunc)(struct selabel_hand=
le *rec,
> >                                 const struct selinux_opt *opts, unsigne=
d nopts);
> >
> >  static const selabel_initfunc initfuncs[] =3D {
> > -       &selabel_file_init,
> > -       CONFIG_MEDIA_BACKEND(selabel_media_init),
> > -       CONFIG_X_BACKEND(selabel_x_init),
> > -       CONFIG_DB_BACKEND(selabel_db_init),
> > -       CONFIG_ANDROID_BACKEND(selabel_property_init),
> > -       CONFIG_ANDROID_BACKEND(selabel_service_init),
> > +       [SELABEL_CTX_FILE] =3D &selabel_file_init,
> > +       [SELABEL_CTX_MEDIA] =3D CONFIG_MEDIA_BACKEND(selabel_media_init=
),
> > +       [SELABEL_CTX_X] =3D CONFIG_X_BACKEND(selabel_x_init),
> > +       [SELABEL_CTX_DB] =3D CONFIG_DB_BACKEND(selabel_db_init),
> > +       [SELABEL_CTX_ANDROID_PROP] =3D
> > +               CONFIG_ANDROID_BACKEND(selabel_property_init),
> > +       [SELABEL_CTX_ANDROID_SERVICE] =3D
> > +               CONFIG_ANDROID_BACKEND(selabel_service_init),
> >  };
> >
> > +static_assert(ARRAY_SIZE(initfuncs) =3D=3D _SELABEL_CTX_NUM,
> > +             "initfuncs array size does not match _SELABEL_CTX_NUM");
> > +
> >  static inline struct selabel_digest *
> >  selabel_is_digest_set(const struct selinux_opt *opts, unsigned n)
> >  {
> > --
> > 2.55.0.229.g6434b31f56-goog
> >
