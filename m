Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DCC39FF4
	for <selinux@vger.kernel.org>; Fri, 24 May 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558558; cv=none; b=qaU8tHAiSONBTRUy9/z9XbpSvFgWJSUs3nlWMAIy6dAVLI6PjquV1YO9WfycJjGMe9esIG+v25Kozvy82c7pAYzhnodeVjswLEwPuQw/FvJ3WIb/Ty0Ko6QOireyvdzJ64drOO5Oi+35yfOcOGz3RkUutm2efOojK1mDXV9JVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558558; c=relaxed/simple;
	bh=OBG8D2YxN5PDpzH5B1w0UWfu8d6y81BQ+k1YwktQ3tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgC+Ahw5xB7kVR5eXznb4+sxH2VErXcfwcjeB/bmNVx2ialvGcIvicw8lPv1fglBndPjAipo7nV66++mQZkPESj7vgxfhuL7Z8FXGa7fEwvsLLi2IufOpAC1XglQBrckcg8nmcM+kKua0CH7GTLkr2EKO72mnBfLcrP9XWamUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJWdKWHV; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJWdKWHV"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48a39e3923fso289538137.3
        for <selinux@vger.kernel.org>; Fri, 24 May 2024 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716558555; x=1717163355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIC2J5Qtkk9q6607+NWVSIFtxPk1VgNXzLSbIwcMHeQ=;
        b=bJWdKWHVaxgTuDOUYTujz0U0DBLKcVeDw5M0bKeKdk0ZSulwSN5/3MJSZANhfOnYq4
         m5xUcYcs/7mKv2c6qpK/WY13bPVNmApnPdwDlRIvF/9tWgYqhfJroT87dqKZj+VlV9Fq
         QcJcL7j0c3mZXOVRc1r7FomrvtLu3exrr3/W4tp1xeoqkJ8cK2/eDZTmfs6lPC5h/f1b
         yV0S8ct+JQ9bgSsojdQ9uDCWpPqbcJCWNLhdI2lGvh8OGRRFuTiQ2cM6o3X06JoQLlrt
         eI2gqFlxcQ4RJqTHHMjPcUEU3PAHaCV+UhqdU0Dg37UTQ8rnHQdSoSfe3t2xcqO0u/BN
         bKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716558555; x=1717163355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIC2J5Qtkk9q6607+NWVSIFtxPk1VgNXzLSbIwcMHeQ=;
        b=F02KOFWM6RxhV1RkW5M2dh3osOrHVe8bqT8W8Dfif9xl3TDIDmQz5PaCaWOnlMyZNz
         VftmEcXl+myQGeZO9HPj/ceIZlskOAwJKdJ4glPE0bN5ArhlO4y/dZAAn4mLibZTK0oT
         9pf5ZeqWLQrIILqf6vTmBxia5k5NZFmlOBFvrp0eiZKuHt65dDj4nV+7mzakA9BCMaz1
         TbW0msKyx5VPn4DgyES6+/fmzP9ShYqcmhGaaZPkLf4iST6/ynRUxA7LlQFIkAq0oZU6
         wl4BAI5St0cSPqVJ0AKQuRVCEwhiHba3UqdNqkF7fa6anNWbJqU2ujTKWyeVoi0xi4Is
         MFHA==
X-Gm-Message-State: AOJu0YyarREmYxBXe43wzAyZjDdBY0eGQEvbw0KLICBW8VSFQmXDQDPI
	6JwhtMAoRl+SxWnm8Z3zSwg3bKuaVD1DnZ+AAK4ff2omBas3JP6qpgQjpoUDf2lVtj2j2/FBoMC
	OO8fa9H2jHJEMZq9hRRHvamuuStsaHA==
X-Google-Smtp-Source: AGHT+IHUSTIwVtGn0AtLUFhAQAnh5tsok6zCmEBE5KcfZh0Nb0UaE4TYzfhO3wzT+UeocW2vQKN2CQ24Vx8iyHgciHY=
X-Received: by 2002:a05:6102:98:b0:47b:614e:cbd with SMTP id
 ada2fe7eead31-48a386d7d64mr2261231137.31.1716558555701; Fri, 24 May 2024
 06:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506173110.220702-1-cgoettsche@seltendoof.de> <CAP+JOzQHF9Y35MTVZfKw5gCPVwmsNZe4fbDk_ED2iSbXVza7tQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQHF9Y35MTVZfKw5gCPVwmsNZe4fbDk_ED2iSbXVza7tQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 24 May 2024 09:49:03 -0400
Message-ID: <CAP+JOzRRU1QEfwcnfpTqYPtZL7Tu2J2ou2cr37oRjTYK9DuWvA@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol: reject self flag in type rules in old policies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 2:50=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, May 6, 2024 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The flag RULE_SELF in type rules is only supported in modular policies
> > since version 21 (MOD_POLICYDB_VERSION_SELF_TYPETRANS).
> >
> > Reported-by: oss-fuzz (issue 68731)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These four patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb_validate.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index e1623172..be3ebe5f 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -1077,6 +1077,10 @@ static int validate_avrules(sepol_handle_t *hand=
le, const avrule_t *avrule, int
> >                 switch(avrule->flags) {
> >                 case 0:
> >                 case RULE_SELF:
> > +                       if (p->policyvers !=3D POLICY_KERN &&
> > +                           p->policyvers < MOD_POLICYDB_VERSION_SELF_T=
YPETRANS &&
> > +                           (avrule->specified & AVRULE_TYPE))
> > +                               goto bad;
> >                         break;
> >                 case RULE_NOTSELF:
> >                         switch(avrule->specified) {
> > @@ -1503,8 +1507,16 @@ static int validate_filename_trans_rules(sepol_h=
andle_t *handle, const filename_
> >                         goto bad;
> >
> >                 /* currently only the RULE_SELF flag can be set */
> > -               if ((filename_trans->flags & ~RULE_SELF) !=3D 0)
> > +               switch (filename_trans->flags) {
> > +               case 0:
> > +                       break;
> > +               case RULE_SELF:
> > +                       if (p->policyvers !=3D POLICY_KERN && p->policy=
vers < MOD_POLICYDB_VERSION_SELF_TYPETRANS)
> > +                               goto bad;
> > +                       break;
> > +               default:
> >                         goto bad;
> > +               }
> >         }
> >
> >         return 0;
> > --
> > 2.43.0
> >
> >
