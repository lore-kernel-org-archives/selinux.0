Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80D8F6A
	for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374173; cv=none; b=F75vIzEPT1VVQ0+woJNv+H03+RBJvLpAwi24ZTRcw7qzHuqnLBGf3VIDsREkZY8sXL81oyaOP21dPF/WMlcCE6KZboJ0gVob47nwoIDcCSQvtiFeSWpIRPfI6W44R4QlLkxyoYpf6wE9SR+BqNXN24dslqr8SCWEhAzjr55Ux1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374173; c=relaxed/simple;
	bh=3hshFOCtaz0MlEAMMEWsbbjrBJHVSkOT2sINvqqutGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tkrw2VJr+8hSTdOiZxzYVu43a3m23nz4uMLHmSgkhyn1WK9zWy3rMQoAmBPFpvN7AweJ/FdyYH5NxFkXRqX4mljLl7W7m4AEGr9DrSjMdQR1Ko8RBt7jYld34pB7SqqIaueFzWsXdrWDJG8VyZN9ry9QWL4rQR3zBbohsD0MvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6PzpDjk; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6PzpDjk"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d22378c59eso1238508b6e.1
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718374171; x=1718978971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLw4HkFyfepI+5A4EDELb56hHIPHWzo0oMJaXy+TTpg=;
        b=D6PzpDjkFrR26nkN49wBrPhS+E6DE+t+HHPFWIQPN5/D2coyQSMWmAR08sHaOmBFPi
         qpAAKqp6r0z2Xo5qA8KtEJ+FzUDqzFtbfGUfOHrZERG8LSFW7v69Vqkn/8SN8GpqOvCY
         +AeETfXKavI5IS7oLcLyXprKyKCLM3VoUDW4okTX7SepRLED2nAilB7aRGjlR10WSRvr
         0qjtrYlOosfYUgsNpmfZB8NUPetIWOjaH03DUHitFJiTxfqkOvy2qzEp3r7s5LlTQgaw
         TtS9pQU6FatDaxfEfIHF0TDe1urYk6O350JD9hTSaromFRh9LsFidl90HS5zJz0n5LPG
         XanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374171; x=1718978971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLw4HkFyfepI+5A4EDELb56hHIPHWzo0oMJaXy+TTpg=;
        b=Upth+wqowosUKH8V8J0dPtnZOzuJLWifzMTALv/5vFqDayEMKM4gQhJO6dUFQWUc3e
         dd5XpfUz6/CusDfLMw9H2R1MOCn+0U9/il6FhkZyPfnNjeCkefZeIIAtbV9gAkyO5prY
         bVTmfI8mQb3zEhQG1EvjDH1PJ/DuJe1hRyBSIhAZ69rtMsLHxIFPqrNVGbZzhW4FVimX
         R3OPHSrbffNnYH7v/i6ArZZ1AU/2Ayw2Li4uGPAqzn/xY/FnZypmfFtAkWFNOy6+pPuw
         l9Zpx0LAoXN98iFzZHrL6SNRs7bUhPFbcECbx/UQTr7OPTaSeBkeqGSytFp97i1KP9eU
         JLLA==
X-Gm-Message-State: AOJu0YyFBUh8waIiz/Rn+QCbg1/9xoAVeNEAVbS+3gmKyPltLKLzpbnX
	KTBG/RMdWEFMHkDzXCJsvKS94JYwmao20T/m5h3BIm5ZOw4GjiNA8v7gUURe+gyM8VsKyfwu1pC
	E639l8QXUltsMMtTVVkwu/4P2zES/2g==
X-Google-Smtp-Source: AGHT+IE4oKEsFMEhV2/X19ukMNlWuidxwApM6xVgz2I3PcsQ2FbX36eqepdbc+c5z1bmRWt2IQchIJbg0fQTeABpp2o=
X-Received: by 2002:a05:6808:23d6:b0:3d2:2305:7227 with SMTP id
 5614622812f47-3d24e9d8e65mr2905822b6e.50.1718374171296; Fri, 14 Jun 2024
 07:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429163901.65239-1-cgoettsche@seltendoof.de> <CAP+JOzR8k=-bxge_ntCyNi5Zh_5sKfLHS-1QgVWjfm2ROGUvcQ@mail.gmail.com>
In-Reply-To: <CAP+JOzR8k=-bxge_ntCyNi5Zh_5sKfLHS-1QgVWjfm2ROGUvcQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 14 Jun 2024 10:09:20 -0400
Message-ID: <CAP+JOzSmVcz6_N5xEs8Rutnapmb4Eok8Vmp4-5jSDPND6cPXNQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: free empty scandir(3) result
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 4:03=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Apr 29, 2024 at 12:39=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > In case scandir(3) finds no entries still free the returned result to
> > avoid leaking it.
> >
> > Also do not override errno in case of a failure.
> >
> > Reported.by: Cppcheck
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/src/booleans.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> > index c557df65..1ede8e2d 100644
> > --- a/libselinux/src/booleans.c
> > +++ b/libselinux/src/booleans.c
> > @@ -53,7 +53,11 @@ int security_get_boolean_names(char ***names, int *l=
en)
> >
> >         snprintf(path, sizeof path, "%s%s", selinux_mnt, SELINUX_BOOL_D=
IR);
> >         *len =3D scandir(path, &namelist, &filename_select, alphasort);
> > -       if (*len <=3D 0) {
> > +       if (*len < 0) {
> > +               return -1;
> > +       }
> > +       if (*len =3D=3D 0) {
> > +               free(namelist);
> >                 errno =3D ENOENT;
> >                 return -1;
> >         }
> > --
> > 2.43.0
> >
> >
