Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6561DE4C3
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601571; cv=none; b=GGKBCJmxtI6hgqvdCuH6qpL9szmK2RoKGvYVBCYqn11CxhWvyRikqnA6ALq6+DypAxI+RerSt1F7fk19ZQjdAJjnCoSJ1NsVxLftTpg31PyW2v8AJxVgRu+6rC3pjnOB4bVW2I9UIdAFjK93C2YIH5H9pBul0Uf8/oOhD2hEcHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601571; c=relaxed/simple;
	bh=FBzDD1eWRLPB7GnsEVCzOVNZ//hcJ0/3J90I3ZUnNFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2wcOzWAd4TL5z5p51idRPj4iIWn99KLxy5kSR4CPMjTBTA9md2N8e2nIXuuAzySlJc5JPDlTHp24rvdpGvR+NXbLWDzMBgq7zH/+R1p6wHWJ158jc/f0qG/mRtU+9qR+CR3d3JdumWhVvXT0IY6UPvma8+NU6D/nxabPx49WK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QmRLuly0; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QmRLuly0"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ff27ad48beso25044657b3.0
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745601568; x=1746206368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qga3HxQQ9Dyd7vp8ZGvuhlgJALrv2ioq8MZUwUoIDa4=;
        b=QmRLuly0D1zGxPPysZ7Hpjw8NDbWMO4hYeX3/atoLoYfCGQyJS0u2THgY01zs1IwWa
         VOAvB8KxoBgNyvZOCsImRWoOEwsWUzJFI53j2EXB67oUC+5GYPFACUF1xrPkHow4rO96
         kUd+GVFizX6nZQ3T4W9wN2gOzZkOvecd3pSQrmm0q/G0M2UP4aGe5tMSxa7frmwUP4VA
         gg+9+KQebM9WogZ2NShSTLOVUeNIO74RWrkWJLhiRV/LkAiEQMd+KMlf56Z5PeN1fxL0
         S6DgjehX8LiYfi1RO8ZJLp/SoRBD8nXZTgQ12AZdHP0d+cwS4lUv6gyrtXUUIKitOp2+
         QvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745601568; x=1746206368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qga3HxQQ9Dyd7vp8ZGvuhlgJALrv2ioq8MZUwUoIDa4=;
        b=ts+btLK5AeOqNtfaK3GEqQnUdDp0JZ4j0xld11aKdkHOripKlFdS1VW351sOg+4lvl
         gg1vAqQ0yOb2tjcQ0dHoYn7rP8ft1YHlKpXuKnSEfCLE8JN+EQXCKK5mQuNaKm55i3/j
         lV3Q5c6OHrDRC4HFQVgNv9fNauhivhLi85YoVgYYy9gnhnoUa3jCfykmzrdj/tNKcvqT
         Y0oCp1r7Xednha+V4tioKxBmUfvt5xxhNYqkktsIV5cQPRGFbMp7zbF1diEm7YsfMjOa
         j9Hrub87wC6et6JTZNCKryJTamyS7mpPDYsJhpAKV92EYzLUG2dC2IQQDaqJxmHjC3Xx
         IyyQ==
X-Gm-Message-State: AOJu0YyfPdYypRReXv97wGNHwi2hx0hyThh/3sJE/rV8Pw675jrhwm1p
	SPB9mMzfq9TcnpLDu9hig8E3mRpRJEPhKivPi5PjYHpcTdq5+3+JtPLwcTN3+HBmyNDayq3aZIn
	AkCRkTBeuKTkMOah/dql9nb+KIWU=
X-Gm-Gg: ASbGncvaygI0BNDUnCTTREb5DF3EUCbJZTeb5Ac/nfQ8QtmPaZHbY3OldizQ+mz8ScZ
	HGzUUiXrgZ2ohUIOxxq38AJhbtNz9EjvqFc9U2RDBGlZiAFUd/s0BtELziKoJWf37tkBphG7Dn/
	iCM2Row/VTYuVps01OfkjCj+c=
X-Google-Smtp-Source: AGHT+IHPKXfFAvXUoJ/vy8MlMKm+M+gl2IaMSbsdtDUHp1ambcVZbzwLnIrt7bC/3igrqfK+jl84Pkj/aHJrkACBOuY=
X-Received: by 2002:a05:690c:680e:b0:708:39b1:863e with SMTP id
 00721157ae682-708540eceedmr42325937b3.15.1745601567806; Fri, 25 Apr 2025
 10:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417190812.41263-1-cgoettsche@seltendoof.de> <CAP+JOzQT6z8osFtrK9PTfG8dXnuwwo7vNyMxT_83OBUEwERKtg@mail.gmail.com>
In-Reply-To: <CAP+JOzQT6z8osFtrK9PTfG8dXnuwwo7vNyMxT_83OBUEwERKtg@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Fri, 25 Apr 2025 19:19:16 +0200
X-Gm-Features: ATxdqUHB_HxguGDQtHIsRmDopN5aPCY_p3n0ZGTOqT55oR9IcEyKEWME_-mg6n0
Message-ID: <CAJ2a_DdRZXWnjnmJMmxZspUJn4hUgMBF=vVfsqY9EL3L8gpRoA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: prioritize local literal fcontext definitions
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Apr 2025 at 21:13, James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Apr 17, 2025 at 3:18=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > For literal file context definitions respect overrides from homedirs or
> > local configurations by ordering them first.
> >
> > Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
> > Reported-by: Paul Holzinger
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2360183
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/src/label_file.c       |  5 +++--
> >  libselinux/src/label_file.h       | 10 +++++++++-
> >  libselinux/src/selinux_internal.h |  2 ++
> >  3 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 5d73fb84..61a9ddb6 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -480,7 +480,7 @@ static int load_mmap_ctxarray(struct mmap_area *mma=
p_area, const char *path, str
> >         return 0;
> >  }
> >
> > -static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool va=
lidating,
> > +static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool va=
lidating, uint8_t inputno,
> >                                   struct literal_spec *lspec, const str=
uct context_array *ctx_array)
> >  {
> >         uint32_t data_u32, ctx_id;
> > @@ -489,6 +489,7 @@ static int load_mmap_literal_spec(struct mmap_area =
*mmap_area, bool validating,
> >         int rc;
> >
> >         lspec->from_mmap =3D true;
> > +       lspec->inputno =3D inputno;
> >
> >
> >         /*
> > @@ -742,7 +743,7 @@ static int load_mmap_spec_node(struct mmap_area *mm=
ap_area, const char *path, bo
> >                 node->literal_specs_alloc =3D lspec_num;
> >
> >                 for (uint32_t i =3D 0; i < lspec_num; i++) {
> > -                       rc =3D load_mmap_literal_spec(mmap_area, valida=
ting, &node->literal_specs[i], ctx_array);
> > +                       rc =3D load_mmap_literal_spec(mmap_area, valida=
ting, inputno, &node->literal_specs[i], ctx_array);
> >                         if (rc)
> >                                 return -1;
> >                 }
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index 67db78e5..b7aed0bc 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -96,6 +96,7 @@ struct literal_spec {
> >         char *regex_str;                        /* original regular exp=
ression string for diagnostics */
> >         char *literal_match;                    /* simplified string fr=
om regular expression */
> >         uint16_t prefix_len;                    /* length of fixed path=
 prefix, i.e. length of the literal match */
> > +       uint8_t inputno;                        /* Input number of sour=
ce file */
> >         uint8_t file_kind;                      /* file type */
> >         bool any_matches;                       /* whether any pathname=
 match */
> >         bool from_mmap;                         /* whether this spec is=
 from an mmap of the data */
> > @@ -368,7 +369,13 @@ static inline int compare_literal_spec(const void =
*p1, const void *p2)
> >                 return ret;
> >
> >         /* Order wildcard mode (0) last */
> > -       return (l1->file_kind < l2->file_kind) - (l1->file_kind > l2->f=
ile_kind);
> > +       ret =3D spaceship_cmp(l1->file_kind, l2->file_kind);
> > +       if (ret)
> > +               return -ret;
> > +
> These four lines should be removed. It makes sense to consider the
> wildcard mode as less specific and give priority to a rule that is not
> using a wildcard, but that is not how it was done in the past and that
> is not (from my testing) what is being done if a regex is involved. So
> for both consistency and in keeping with past practice, we should not
> use the file kind to sort here.
>
> By my testing, everything works as expected with those lines removed.

The only difference I am seeing is when omitting specifying the file
type to lookup (-t for selabel_lookup, -m for matchpathcon).
Previously the last defined definition was returned, now the one with
the highest LABEL_FILE_KIND_* value (e.g. regular has currently the
highest value of 7).
But in practice that should not matter since for corretly labeling
files the type is important, and one could argue it is unspecified
what definition is returned if the type is omitted.

If the order should not depend on the mode one would need to store the
file linenumber in the compiled format (i.e. a binary format change),
since otherwise the order would be dependent on the used sorting
algorithm/implementation.

> The rest of the patch looks good to me.
>
> Thanks,
> Jim
>
> > +       /* Order by input number (higher number means added later, mean=
s higher priority) */
> > +       ret =3D spaceship_cmp(l1->inputno, l2->inputno);
> > +       return -ret;
> >  }
> >
> >  static inline int compare_spec_node(const void *p1, const void *p2)
> > @@ -754,6 +761,7 @@ static int insert_spec(const struct selabel_handle =
*rec, struct saved_data *data
> >                         .regex_str =3D regex,
> >                         .prefix_len =3D prefix_len,
> >                         .literal_match =3D literal_regex,
> > +                       .inputno =3D inputno,
> >                         .file_kind =3D file_kind,
> >                         .any_matches =3D false,
> >                         .lr.ctx_raw =3D context,
> > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux=
_internal.h
> > index 964b8418..3fe7d4c3 100644
> > --- a/libselinux/src/selinux_internal.h
> > +++ b/libselinux/src/selinux_internal.h
> > @@ -150,4 +150,6 @@ static inline void fclose_errno_safe(FILE *stream)
> >  # define unlikely(x)                   (x)
> >  #endif /* __GNUC__ */
> >
> > +#define spaceship_cmp(a, b)            (((a) > (b)) - ((a) < (b)))
> > +
> >  #endif /* SELINUX_INTERNAL_H_ */
> > --
> > 2.49.0
> >
> >
