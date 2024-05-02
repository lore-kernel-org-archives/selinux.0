Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB41553BB
	for <selinux@vger.kernel.org>; Thu,  2 May 2024 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673050; cv=none; b=FCnZyzPuWLRvfHsJt80hpt0ug5huDi+unlbHrD0k+IUOxW5q4tq5mL4dOrk4eM66wnW0IJTpKxFPVMFbRNElAvVbvUELfC54rG+h2EPilebMCgypVUptEc/F0mlg0FiAfeaXqy1IbCF0xzQUoeybKgWUR4zxSXFfP1+Age8NIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673050; c=relaxed/simple;
	bh=Z46eq9Vo7oPNP5cfJYSsrPaKopEYSC/nzRD7+MCUHXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJc5blAw5MJUyfLayDPaq6qPVlLAYu8vnKKhxjJx4Y1rxk9APtjIkyknRtIo5S9NbJylIqglMeFdOf2YmvQh7hbW8aonJkSpLH6tE5tRw4SIIRBOk44N3HhhKC974XZSil5L18E/hezYTWQYyMQ0DkC6Jq4LxD1xyLjHL8oebLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+FXdUrB; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+FXdUrB"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de610800da0so3832189276.2
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714673047; x=1715277847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd3MgpuYiQplIUa13mx2Nt/EMPDBby43kAh+dB/Ivgs=;
        b=j+FXdUrB1ey94WwFtqZp740jwT7ZSI44HPP2VspRla5pi32ojLsDwWtxurQ6ftSU8S
         9ZjAGNIA5kH/Bs8O3Jws2bpDucC2Xe/oOK3elB6hVLY1nssdYcUxQIMkHoS4ApNoZ29p
         7UUGNqifODGuEkTX57a79z7SIemDilyY3oKc7u4hV2LaMzfqCsXEr/TbuutVbOcKY3Ww
         LkPBy4dELhZ4awfP5cU1D6ubmoVcbal+WtLty+GtMjvTzDmXXWHeJ6TMSSxgr5wfhr/W
         S2JLQzK6P1Ucvh0RPynfVVvZIWLfUhR9mJSmGLaseCo1A7suVvgiy94fQSsECS/ZqZh2
         CMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714673047; x=1715277847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fd3MgpuYiQplIUa13mx2Nt/EMPDBby43kAh+dB/Ivgs=;
        b=C0soEWZO1i+l6r4DVdpq4EgzAHGn4ixsjARHID+veYGMpuwJOAWGxUdCGSiaaNLM+V
         D/IcfCPh7MnsqEvflg7ebagFFvbQKBz+vC24cUhgkFH1PNPRB+BzKQxB9jULHUi39nKW
         0rQPtRvUcidnXAfMg2BShX9zFgWWb5T9O6Zssd6P3Kgnc7nnGfvCzCGhVoHwHGmpx54P
         Bf+Akf4aIJPYh1WvVOYSIpm2QivwPdtbED/2O4edrXHzD5nv84sKLEnVf2wMpGV72Gxb
         esh6Zi86fHHHqT+GogIRuaoLb69bUSXE84036Ct29G19scisp9k5/XOfLT11w9TU/b3j
         qKHA==
X-Gm-Message-State: AOJu0YxY45T8TxCvHQAARi6L5FX/05TWIe+wT0Q5CQdXZksrPNaD5RZ2
	jXm8cIR0OJp7LQDSuMqeaRKDVlhw0SMrdYd8yi9FGFQU0729uLwIq7kYPFYLyByvlK5BDlLMEr2
	lNU8Etm01n7DIJbnh5oMcOzt/L4iqkA==
X-Google-Smtp-Source: AGHT+IE2ZYnuGIKNiS74J6kpNzGUzaJ3Yy7vqXHt2OcBW3MaHl2y23/K+NoRgDsToQ/OHsaOnFkYvfiPkBvFIQcSwdA=
X-Received: by 2002:a05:6902:240f:b0:de5:965d:7965 with SMTP id
 dr15-20020a056902240f00b00de5965d7965mr697839ybb.64.1714673047615; Thu, 02
 May 2024 11:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408150802.63941-1-cgoettsche@seltendoof.de> <CAP+JOzSk1oNHeLDS9W=94j1+GH9CjwPuMiKvKSp2D=ja==7kdg@mail.gmail.com>
In-Reply-To: <CAP+JOzSk1oNHeLDS9W=94j1+GH9CjwPuMiKvKSp2D=ja==7kdg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 2 May 2024 14:03:56 -0400
Message-ID: <CAP+JOzTUuKC43nGDSuaP6LsrO0J3=gXP3CRg0_sdBOQvC6sKMA@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol: improve policy lookup failure message
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 4:48=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Apr 8, 2024 at 11:08=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > If a policy version cannot be found include the policy target, and a
> > module prefix for non kernel policies in the message.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These four patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/write.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index 283d11c8..2fcc1701 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -2252,8 +2252,10 @@ int policydb_write(policydb_t * p, struct policy=
_file *fp)
> >         info =3D policydb_lookup_compat(p->policyvers, p->policy_type,
> >                                         p->target_platform);
> >         if (!info) {
> > -               ERR(fp->handle, "compatibility lookup failed for policy=
 "
> > -                   "version %d", p->policyvers);
> > +               ERR(fp->handle, "compatibility lookup failed for %s%s p=
olicy version %d",
> > +                   p->target_platform =3D=3D SEPOL_TARGET_SELINUX ? "s=
elinux" : "xen",
> > +                   p->policy_type =3D=3D POLICY_KERN ? "" : " module",
> > +                   p->policyvers);
> >                 return POLICYDB_ERROR;
> >         }
> >
> > --
> > 2.43.0
> >
> >
