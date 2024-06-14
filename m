Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D46FB1
	for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374239; cv=none; b=qkG4viSGaHXlVPBfvgMC/fm6OFoJl5cPr/va6C7EzAyX18lDfw5Ff6ZZtW4l6YcmN+CvJwYIwCZJn9Z7rZtJcjaYDFSt9kOCL9QW2mNEFxxw8KPDmGgRWwq98zKvyqg9QVQWv7xlja20IiL6B9W+wR/yXRFZe+t1YO1nfesLMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374239; c=relaxed/simple;
	bh=UVfXvc8hv0gX76YGxl8osnoIccvpdKqHFX5z6m/MY4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzfoT5VDoXlsCFaCd9oY/4yzMAw2Qe/kaSONMKevI8dcQEn0QbHSiCJ0IyK6Ng+yLsw8okg2yH1FMH7ylO2jMA6oYANX9Af2vjsOpMV+rI65hCEZXkFY4jX3bFcBOpo9zHWfTuppViX4azoJiYrSCQog+L3+k41yM77sD+ZqsAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIc6IJxK; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIc6IJxK"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c9cc681ee4so1031092b6e.0
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718374237; x=1718979037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nzGa+PCpGRR2F7rdI2ao+R2A3s3CvwLkXGyD6Nh6Tk=;
        b=IIc6IJxKkGrAR+EJIylqV08W5ZnJuceYhTqizJzhiVZ0VoUWh5LB0XbDI1rNYddd4S
         wupUNXAX/VOasfEORvq+mp0IPuwaONi5Agy5VgVeyTlSVAh2dqfojOvmzhH5NJHGMNb9
         l+bsyQCjV6IR+F83ytGMpbAMJtRihoz+HMKbUEFa0OosLOfg+1CWlD0DlWgi6sI+cfXl
         0IssYFcRF1R28YsCshmN4rMqgM75vwQh8jPTm5Y3iwN9TmMGITvqSS6A+fDiby2mOyKj
         qLo1cBgJekBOB+iaeW169yvEMq6/eMPkfsteP+SEMBBs74Zw5/vWvA93hlfDqwtn7CnI
         M+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374237; x=1718979037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nzGa+PCpGRR2F7rdI2ao+R2A3s3CvwLkXGyD6Nh6Tk=;
        b=u4icfL57oFqgT/PizJzigu4syPx0D8ezyKIRq5S2gJRFO2tC2/SwB+s9agAVGzR9Vl
         Z7MTj7qEdrXgNDZCMcw16l9my1p8y5KEmkgr6OAtiF2Qbfb2zqXjiTQqVuDukgSPB7xd
         GDGfrqm+utfJNYXY24QCpu3X/x97ILougqkE06U/bmDH19hluZdfTVXiOs1916B7RneA
         vcm1/VRjg6tuxuuRyuYsz/wzAxUADC8vJ/peuOQGkcXp0CFW2MMCuWohh9hB+88AdR5r
         03y0221Gmj9yMAHhW3YQ6nQQLwUt/5jTBr1yd9AOOA1eAsqfN+xnA0k1jOX8gRM+/Kio
         2bjA==
X-Gm-Message-State: AOJu0YxE9suovAAWi78T/SocHhWnlCyEM4zO1bYJrCZwAGVeXYZvcuBw
	uKateonpu+Wh8BX/lEbscA21dIPC9DfVTm8EXZL0zw96LNsrvJ/OcQLNlveiD+kSM/tuRE92+Iv
	Mcfy0Uh6tbKLZzNCTupiDBmojapnMIA==
X-Google-Smtp-Source: AGHT+IHBx3yoHiD0eA0DijqenkKYYwnB1UVl/hl9uPBGNVxMY/ztucB12MknAE7JK39r7OkGonjeEmgIAMf/aiNd5/E=
X-Received: by 2002:a05:6808:114e:b0:3d2:1e7e:60a0 with SMTP id
 5614622812f47-3d24e8a6b76mr3792046b6e.11.1718374236927; Fri, 14 Jun 2024
 07:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608171923.136765-1-cgoettsche@seltendoof.de> <CAP+JOzT2Fo3T8zzdCCaLZKdximUCWC6My3ZzoNqhsDhiSV0c4A@mail.gmail.com>
In-Reply-To: <CAP+JOzT2Fo3T8zzdCCaLZKdximUCWC6My3ZzoNqhsDhiSV0c4A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 14 Jun 2024 10:10:26 -0400
Message-ID: <CAP+JOzRPjQBwPCGU_+mFzAtgMeP5dsYtEVh5k9UUvZ94RzXzVQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: hashtab: save one comparison on hit
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 1:14=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sat, Jun 8, 2024 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > When the comparison function returns 0, avoid a repeated call to it.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/hashtab.c | 53 +++++++++++++++++++++++++-----------------
> >  1 file changed, 32 insertions(+), 21 deletions(-)
> >
> > diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> > index 2af3a9bf..399582b1 100644
> > --- a/libsepol/src/hashtab.c
> > +++ b/libsepol/src/hashtab.c
> > @@ -112,15 +112,17 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key=
, hashtab_datum_t datum)
> >         hashtab_check_resize(h);
> >
> >         hvalue =3D h->hash_value(h, key);
> > -       prev =3D NULL;
> > -       cur =3D h->htable[hvalue];
> > -       while (cur && h->keycmp(h, key, cur->key) > 0) {
> > -               prev =3D cur;
> > -               cur =3D cur->next;
> > -       }
> >
> > -       if (cur && (h->keycmp(h, key, cur->key) =3D=3D 0))
> > -               return SEPOL_EEXIST;
> > +       for (prev =3D NULL, cur =3D h->htable[hvalue]; cur; prev =3D cu=
r, cur =3D cur->next) {
> > +               int cmp;
> > +
> > +               cmp =3D h->keycmp(h, key, cur->key);
> > +               if (cmp > 0)
> > +                       continue;
> > +               if (cmp =3D=3D 0)
> > +                       return SEPOL_EEXIST;
> > +               break;
> > +       }
> >
> >         newnode =3D (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
> >         if (newnode =3D=3D NULL)
> > @@ -151,14 +153,19 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key=
,
> >                 return SEPOL_ENOENT;
> >
> >         hvalue =3D h->hash_value(h, key);
> > -       last =3D NULL;
> > -       cur =3D h->htable[hvalue];
> > -       while (cur !=3D NULL && h->keycmp(h, key, cur->key) > 0) {
> > -               last =3D cur;
> > -               cur =3D cur->next;
> > +
> > +       for (last =3D NULL, cur =3D h->htable[hvalue]; cur; last =3D cu=
r, cur =3D cur->next) {
> > +               int cmp;
> > +
> > +               cmp =3D h->keycmp(h, key, cur->key);
> > +               if (cmp > 0)
> > +                       continue;
> > +               if (cmp =3D=3D 0)
> > +                       break;
> > +               return SEPOL_ENOENT;
> >         }
> >
> > -       if (cur =3D=3D NULL || (h->keycmp(h, key, cur->key) !=3D 0))
> > +       if (cur =3D=3D NULL)
> >                 return SEPOL_ENOENT;
> >
> >         if (last =3D=3D NULL)
> > @@ -183,14 +190,18 @@ hashtab_datum_t hashtab_search(hashtab_t h, const=
_hashtab_key_t key)
> >                 return NULL;
> >
> >         hvalue =3D h->hash_value(h, key);
> > -       cur =3D h->htable[hvalue];
> > -       while (cur !=3D NULL && h->keycmp(h, key, cur->key) > 0)
> > -               cur =3D cur->next;
> > -
> > -       if (cur =3D=3D NULL || (h->keycmp(h, key, cur->key) !=3D 0))
> > -               return NULL;
> > +       for (cur =3D h->htable[hvalue]; cur; cur =3D cur->next) {
> > +               int cmp;
> > +
> > +               cmp =3D h->keycmp(h, key, cur->key);
> > +               if (cmp > 0)
> > +                       continue;
> > +               if (cmp =3D=3D 0)
> > +                       return cur->datum;
> > +               break;
> > +       }
> >
> > -       return cur->datum;
> > +       return NULL;
> >  }
> >
> >  void hashtab_destroy(hashtab_t h)
> > --
> > 2.45.1
> >
> >
