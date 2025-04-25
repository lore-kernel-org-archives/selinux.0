Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F176FC3
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745603584; cv=none; b=MZseWSZVrmO1NuELoelnjLKDdNlev4IebDiY9vCkfnLg1XbSsvWV+TONYLqjg+OdxiTs/3i+weyStkgzYlAkB8KICSKdxZShkeOZzfjcjBddoEZKIpCHraR2GJKeZkl2TFN1doFkb7Qv4qukJ6/5j6dlYFd36IhdcWQgzxFuWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745603584; c=relaxed/simple;
	bh=KRuu3XWkDhP0TjegU2Q1jVU8DIDUHXSQY6kC7PAx/xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jD/hF2VWYygh5gU0VdUwkriPPkHIb6nVTZf4J5QooU5epLIYHB5Lw+a6yxDuEke3/1kVg3fOEsaHhaTGyP9TTN022n1fEgf7fZXYXj+gTRe1Nj0UzOAQhmJstwd6my6APLBOxb+gkRhT6eiX3v1+6gBH/e7+oQgBp2KZr3v0Bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dc7TZbgR; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dc7TZbgR"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86715793b1fso1084318241.0
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745603582; x=1746208382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwuJBOnqOgGTbJQl4eB52c1NnNVXGoAiw6IsDyyQrIk=;
        b=Dc7TZbgRtjYKkuZOZztbeprAIhUFL6WuZXb9I6VvKwzbvl+r8hk4b5798eC3u5+JhK
         x9NKoESBYnpQ+Q/eDwE5GRvXz+Aor+fsTgiGopYas7da0DaTvBeovxZAbF4xWgJ4/rs8
         /o8t1v4lZlb+0Tz4Gn2oZpXNWU7RZqgDuBSD656+64FFTp7rEq1CXzGt+tKqYvOXPHYh
         b/Ilz1/hygvL/QoMG0AwuasYXOcWhyBLO6KhNdbUMmF32l949jfQ/rfs66u41vbsE/6X
         xQr1W3NTR4rSV39s/6j7Bt7IFXq15bKlLaRVKNfhpbqCbmiDB0h25Qvnm2/1IBZHfNyA
         FVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745603582; x=1746208382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwuJBOnqOgGTbJQl4eB52c1NnNVXGoAiw6IsDyyQrIk=;
        b=CRM8etPBYt0sa4ePL/vAd9iAyrjjt5PmRIqSX0zzpPLnVtGi8I8bUhldBFzjZdZ/DT
         8Prdz2A05WANijToMQIsUwqCRoOAe1uxXiyeKnnM9Ewlufp/FX2xbSOaa5+STc47agWQ
         RA0YqBGAS2Aq37d7gKR0tc+RNVnn/PbMBx1yvv5/t7DU7r2A9KndE4CSaGCBkY35v6GQ
         G4GhGuCzp7zqFmXG+xbpLc3kQWu/d5vPJxhEXWwkiGploDeGWXlvk4m7Y3PbtnmyylMO
         cm1O4SLKbgXW2nIGBJuzghLaFMPNlpJSG2yMWhOwMjCBhIlWrI64sniuXjCE/pPSnTsv
         0SIw==
X-Gm-Message-State: AOJu0YyUfjV42cE2zKGStfrzp+j/lJunCgGYmykZaUTzT271skCY9PeP
	H0wfv7A/PJ9ANwlen+dYoVI+cUpwkR78wegS0Jv0Zxvr3xpwKKkeRTXZAlDE3LAwVLaXcyE6j7Y
	5+8ciUU0R9oC4te4GzCVTk3XBmE0=
X-Gm-Gg: ASbGnctdMDOAHSRFfZ/quG3Snhl0Lvd6y+rmmWF5LiKRZu2NFfZy1O06iSVX76aOQOu
	0D/5rqloQq6bnIgiqluZq/Ta9OlRNnylPxi1YLM2cZ5Q9QKNLHG8C8ntKDvhWT4U42DGo3g6Mhn
	Ulh8A3CezukYbDb+V5/n8=
X-Google-Smtp-Source: AGHT+IFbykEHC9Gf3g0cH/rlTxzt/NFwFDuSMxl72r7YjCzTvtssMC7f4yLTN4/osjD9DpLtB/jbpX/PbzQDN7K5RV0=
X-Received: by 2002:a05:6102:6c4:b0:4c3:64bd:93ba with SMTP id
 ada2fe7eead31-4d640b83d26mr611267137.11.1745603581609; Fri, 25 Apr 2025
 10:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417190812.41263-1-cgoettsche@seltendoof.de>
 <CAP+JOzQT6z8osFtrK9PTfG8dXnuwwo7vNyMxT_83OBUEwERKtg@mail.gmail.com> <CAJ2a_DdRZXWnjnmJMmxZspUJn4hUgMBF=vVfsqY9EL3L8gpRoA@mail.gmail.com>
In-Reply-To: <CAJ2a_DdRZXWnjnmJMmxZspUJn4hUgMBF=vVfsqY9EL3L8gpRoA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 25 Apr 2025 13:52:50 -0400
X-Gm-Features: ATxdqUFIycAvn2VLaDdgPwfMuE-fRrFZhL1LpDpOp3Vt82s0L4cPwHD_gTTvWaI
Message-ID: <CAP+JOzT+KRj2GvLa1g3z6YqKPEM4e72+oPKjUQ=XLKssHnZ8ew@mail.gmail.com>
Subject: Re: [PATCH] libselinux: prioritize local literal fcontext definitions
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Fri, 18 Apr 2025 at 21:13, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Thu, Apr 17, 2025 at 3:18=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > For literal file context definitions respect overrides from homedirs =
or
> > > local configurations by ordering them first.
> > >
> > > Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
> > > Reported-by: Paul Holzinger
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2360183
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  libselinux/src/label_file.c       |  5 +++--
> > >  libselinux/src/label_file.h       | 10 +++++++++-
> > >  libselinux/src/selinux_internal.h |  2 ++
> > >  3 files changed, 14 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.=
c
> > > index 5d73fb84..61a9ddb6 100644
> > > --- a/libselinux/src/label_file.c
> > > +++ b/libselinux/src/label_file.c
> > > @@ -480,7 +480,7 @@ static int load_mmap_ctxarray(struct mmap_area *m=
map_area, const char *path, str
> > >         return 0;
> > >  }
> > >
> > > -static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool =
validating,
> > > +static int load_mmap_literal_spec(struct mmap_area *mmap_area, bool =
validating, uint8_t inputno,
> > >                                   struct literal_spec *lspec, const s=
truct context_array *ctx_array)
> > >  {
> > >         uint32_t data_u32, ctx_id;
> > > @@ -489,6 +489,7 @@ static int load_mmap_literal_spec(struct mmap_are=
a *mmap_area, bool validating,
> > >         int rc;
> > >
> > >         lspec->from_mmap =3D true;
> > > +       lspec->inputno =3D inputno;
> > >
> > >
> > >         /*
> > > @@ -742,7 +743,7 @@ static int load_mmap_spec_node(struct mmap_area *=
mmap_area, const char *path, bo
> > >                 node->literal_specs_alloc =3D lspec_num;
> > >
> > >                 for (uint32_t i =3D 0; i < lspec_num; i++) {
> > > -                       rc =3D load_mmap_literal_spec(mmap_area, vali=
dating, &node->literal_specs[i], ctx_array);
> > > +                       rc =3D load_mmap_literal_spec(mmap_area, vali=
dating, inputno, &node->literal_specs[i], ctx_array);
> > >                         if (rc)
> > >                                 return -1;
> > >                 }
> > > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.=
h
> > > index 67db78e5..b7aed0bc 100644
> > > --- a/libselinux/src/label_file.h
> > > +++ b/libselinux/src/label_file.h
> > > @@ -96,6 +96,7 @@ struct literal_spec {
> > >         char *regex_str;                        /* original regular e=
xpression string for diagnostics */
> > >         char *literal_match;                    /* simplified string =
from regular expression */
> > >         uint16_t prefix_len;                    /* length of fixed pa=
th prefix, i.e. length of the literal match */
> > > +       uint8_t inputno;                        /* Input number of so=
urce file */
> > >         uint8_t file_kind;                      /* file type */
> > >         bool any_matches;                       /* whether any pathna=
me match */
> > >         bool from_mmap;                         /* whether this spec =
is from an mmap of the data */
> > > @@ -368,7 +369,13 @@ static inline int compare_literal_spec(const voi=
d *p1, const void *p2)
> > >                 return ret;
> > >
> > >         /* Order wildcard mode (0) last */
> > > -       return (l1->file_kind < l2->file_kind) - (l1->file_kind > l2-=
>file_kind);
> > > +       ret =3D spaceship_cmp(l1->file_kind, l2->file_kind);
> > > +       if (ret)
> > > +               return -ret;
> > > +
> > These four lines should be removed. It makes sense to consider the
> > wildcard mode as less specific and give priority to a rule that is not
> > using a wildcard, but that is not how it was done in the past and that
> > is not (from my testing) what is being done if a regex is involved. So
> > for both consistency and in keeping with past practice, we should not
> > use the file kind to sort here.
> >
> > By my testing, everything works as expected with those lines removed.
>
> The only difference I am seeing is when omitting specifying the file
> type to lookup (-t for selabel_lookup, -m for matchpathcon).
> Previously the last defined definition was returned, now the one with
> the highest LABEL_FILE_KIND_* value (e.g. regular has currently the
> highest value of 7).

That is the difference.

> But in practice that should not matter since for corretly labeling
> files the type is important, and one could argue it is unspecified
> what definition is returned if the type is omitted.
>

It is not unspecified. It means "all file types"

> If the order should not depend on the mode one would need to store the
> file linenumber in the compiled format (i.e. a binary format change),
> since otherwise the order would be dependent on the used sorting
> algorithm/implementation.
>

I am not following what you are saying here.

In my testing, the file type only mattered when there was no regex in the p=
ath.
If you specify a file context with a regex in an fc file, then
regardless of whether the file type was a regular file or it was not
specified, setting the file context with semanage would override it.
But if you specify a file context that does not have a regex in an fc
file, then setting the file context with semanage would override it
only if you set the file type or if the file context in the fc file
did not specify a file type.

So it is more consistent to not sort based on the file type here.
Also not sorting based on file type matches the old behavior.

If this was new and we did not have to worry about regressions, then I
would agree with you. I think that it would make sense to have a fc
rule that specified a specific file type be selected over one that did
not (everything else being equal).

Thanks,
Jim


> > The rest of the patch looks good to me.
> >
> > Thanks,
> > Jim
> >
> > > +       /* Order by input number (higher number means added later, me=
ans higher priority) */
> > > +       ret =3D spaceship_cmp(l1->inputno, l2->inputno);
> > > +       return -ret;
> > >  }
> > >
> > >  static inline int compare_spec_node(const void *p1, const void *p2)
> > > @@ -754,6 +761,7 @@ static int insert_spec(const struct selabel_handl=
e *rec, struct saved_data *data
> > >                         .regex_str =3D regex,
> > >                         .prefix_len =3D prefix_len,
> > >                         .literal_match =3D literal_regex,
> > > +                       .inputno =3D inputno,
> > >                         .file_kind =3D file_kind,
> > >                         .any_matches =3D false,
> > >                         .lr.ctx_raw =3D context,
> > > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selin=
ux_internal.h
> > > index 964b8418..3fe7d4c3 100644
> > > --- a/libselinux/src/selinux_internal.h
> > > +++ b/libselinux/src/selinux_internal.h
> > > @@ -150,4 +150,6 @@ static inline void fclose_errno_safe(FILE *stream=
)
> > >  # define unlikely(x)                   (x)
> > >  #endif /* __GNUC__ */
> > >
> > > +#define spaceship_cmp(a, b)            (((a) > (b)) - ((a) < (b)))
> > > +
> > >  #endif /* SELINUX_INTERNAL_H_ */
> > > --
> > > 2.49.0
> > >
> > >
