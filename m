Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B478B53
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580029; cv=none; b=gpYA4tJfSUdXfdoxz90IkOQD0B+1eJGL4KnGZk9QTBhWdrntY6w4atv+HTINe0NeP8QCtHLEDP4Ov+lYQ4mTlwHi/NTKDZvxcsOQA5aXuwBd4ZGqRBFB2WQlsfBwwrdpNOQbg0aMDSutDA9jcK82CM8RUjk9Ou5A6LrjT62EPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580029; c=relaxed/simple;
	bh=aHbmfTERmUo6EG/+NxQ0/MtlT9EMtQNF+ETWdkZy+eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EarsBcHdvdq7IU2ueFoEwsigNla9qz49ivW8BYANfQh8qs86oAxWeg47q6eNGyEsb3VeVvkxUSmy3wCqVQshR5vclOVhyuy4DmGtW/uMM8awCaRv6EpuW3LrzjjReU8INRQLatUepl6aD6A3mqdCtqy70cGPHYbKRYseblSEUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZfj1aJE; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZfj1aJE"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7db36dbd474so638669241.2
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709580027; x=1710184827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msU16zVwWF7jIrJMDEWosHx8LmkK4IGfNB9n7kEiW/M=;
        b=fZfj1aJEyVBjAlbHAs8F8FyI9oWLntmT9l+wtFPXfJimb0qM/ItfxOURt7Q6F90ksh
         tO9famSWVTu2w94AzaatLNrAh4giGlG7AJF601Ka4H882QDPN4afnzifNalrGlPRuhcH
         iwIIaN/DQ7L1q1KWjC+ozlSFaEc659Y1flroozsCVFH37BgehVU99rVTNYeFpK1OpTTW
         +V6C3QIOtyjh7j9ulcEmBxddAQsloZ/cHF/BIqapSB99vVRbWMfhYDAQqsDnDPlhDwQI
         c7UcAY6niT2FsZS4/w9PfZO4slBLcccGsF00nqjb9XrNPzMNntgBm3KYCBbAtj6lRMlr
         FJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709580027; x=1710184827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msU16zVwWF7jIrJMDEWosHx8LmkK4IGfNB9n7kEiW/M=;
        b=Bl0tfmoWJ/Y01zEdAZFaIw72Y03ll8iMPBd2CiF9hMg1MrxxK+xx6YsxadcSp89ayh
         rqA3S5qNWZXZObQf1XHBV9UjpkGWPIm7RnYmQm5fFU7D/0Mt5hFKE3ru1DF+ltPQxoLh
         iDkTM3c8z3DSlEeM8paDoqIlW4+upeQ5G4hefwk+f6rAjZSdg/WHoxbDBwQCdygEfURC
         K34pcBtIEnyU1af4m3XfEEndXJgd26Ze85RqYWXwv8FbvFysYH4eRAWhjuFHmR3RoQar
         ygNvyEmaNH/LeJgL3NxNFaOKqcK7TM4NuUUJGviwo3fwWQ5xbVlmJZeRzpxKI5LmXcqt
         hwzg==
X-Gm-Message-State: AOJu0YywhglSc8wuNY7BaD0huulJ8LZjw9QqanWdgMqq3v/e24NUDd7N
	/kq63uvhRpaKVHbeJg701/Zj0BXJKYTJX2Z8KXNPeEQFfCN3dG6Mrwfn4l5P1nnis2TT/yOCbuA
	M71VFBeNXsXZiJqBlK2bFz5FdmcQ=
X-Google-Smtp-Source: AGHT+IEZnZgonniPI3x6ndX7M9/QtK9raVj526pm/2ZJio8wuRuxt9siiuGGVrLloOiqhkrNyZwNwglTnsMYQCbC3Ig=
X-Received: by 2002:a05:6102:34e5:b0:470:6f7f:d94b with SMTP id
 bi5-20020a05610234e500b004706f7fd94bmr6037796vsb.33.1709580026722; Mon, 04
 Mar 2024 11:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-13-cgzones@googlemail.com> <CAP+JOzSD6eZcsP-EcnCdb9aJEm=9Qi1b_rt-WT=HJ8fNL4V62w@mail.gmail.com>
In-Reply-To: <CAP+JOzSD6eZcsP-EcnCdb9aJEm=9Qi1b_rt-WT=HJ8fNL4V62w@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:20:15 -0500
Message-ID: <CAP+JOzTyM_qCQmVCCAbFnVsG4PaQwJgNwxEoBvkmn2urv8jgXQ@mail.gmail.com>
Subject: Re: [PATCH 13/15] checkpolicy: free temporary bounds type
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:38=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Free the temporary bounds type in the error branches.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/module_compiler.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compile=
r.c
> > index 119b7e36..464897cc 100644
> > --- a/checkpolicy/module_compiler.c
> > +++ b/checkpolicy/module_compiler.c
> > @@ -234,6 +234,7 @@ static int role_implicit_bounds(hashtab_t roles_tab=
,
> >         if (!bounds) {
> >                 yyerror2("role %s doesn't exist, is implicit bounds of =
%s",
> >                          bounds_id, role_id);
> > +               free(bounds_id);
> >                 return -1;
> >         }
> >
> > @@ -243,6 +244,7 @@ static int role_implicit_bounds(hashtab_t roles_tab=
,
> >                 yyerror2("role %s has inconsistent bounds %s/%s",
> >                          role_id, bounds_id,
> >                          policydbp->p_role_val_to_name[role->bounds - 1=
]);
> > +               free(bounds_id);
> >                 return -1;
> >         }
> >         free(bounds_id);
> > @@ -479,6 +481,7 @@ static int user_implicit_bounds(hashtab_t users_tab=
,
> >         if (!bounds) {
> >                 yyerror2("user %s doesn't exist, is implicit bounds of =
%s",
> >                          bounds_id, user_id);
> > +               free(bounds_id);
> >                 return -1;
> >         }
> >
> > @@ -488,6 +491,7 @@ static int user_implicit_bounds(hashtab_t users_tab=
,
> >                 yyerror2("user %s has inconsistent bounds %s/%s",
> >                          user_id, bounds_id,
> >                          policydbp->p_role_val_to_name[user->bounds - 1=
]);
> > +               free(bounds_id);
> >                 return -1;
> >         }
> >         free(bounds_id);
> > --
> > 2.43.0
> >
> >
