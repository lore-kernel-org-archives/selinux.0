Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9EA1D1E7A
	for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293977; cv=none; b=BLZs4InlDM8jgqAyYoIt3CB+nrHS01mRfS/akshyRXx1UwY8XNp3d5p3B+5HLG+uRhpNH+qC1y6lcJHgDTDBLyNmc5hVNShTF4B49oFQURw8BAhXAwSTcubGc7u8nwMNSoOSE4Xljwgk79MfonLaRqqVuc+ysOKfoH7RFaA04uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293977; c=relaxed/simple;
	bh=h+Im4TLObUNVZhvPHm8BnZD3ldbThOf/eglwF74hNCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aumvtoVhWQnDbMTk2Yg8uKIwq0bYARFGCft3xCU0ZhE3OzVSmsNOtxDHvEjvBKzx8R6LhLhsYgeeEkcrbBoYg/yqZW0EfckwRFPtL9yP0B4Gx2Yrim05DE3ozhFUpaNymT6SICwmHAS4t6DWbu3kLs0jzVna+zxwsXiHgXUMcxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhWFh3WH; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhWFh3WH"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e7e1320cabso3010656eaf.0
        for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730293975; x=1730898775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oqP3P5RQk0HoXUZ15pzZjUd6fDPsMZCUiZ+veazDDc=;
        b=VhWFh3WHFAfmjSsHsAVaHJG2JRLzgkaUnZCmY1ed/RZiqyf2amFkyXez+QUa5pRNgi
         ClBjmdk4v6aJ9MlRQ9ifvHr6toE1zQhhQ7VZOkeZnFDfP3ZtuOFXVC0KYrFp8hNhH5Bv
         7cjMIFrKTkVYDBMeplaf54qyFIfxAqaboH59o5u50wV/uzhZLeGKZjsl/epI02dnzuqB
         FvK2wkmuxRfog1w8ydqaqfAtrbLXOpcV1523jzN58N/f0mryJJJ8i+4v4EEX+cYEwfwo
         BkrIHUDITPsfhquEKmWqr8jYGT07/8nGoQarrg0Zwot3pgF6b7LvBaLIHyBNk48fIwb8
         oXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730293975; x=1730898775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oqP3P5RQk0HoXUZ15pzZjUd6fDPsMZCUiZ+veazDDc=;
        b=XwMt8PefSTWcsZ/JczVQnhQc75DQ8+GRcMItUMUsZz6zqbWLC+fngK5Ja8phH/YQe0
         rNL/4Q2SwRjR7IyFnT33jNRQLKqyGai/newCl7R33d3WbfpAroFnlEYvcSgRfWofoZoL
         5D3g+g0KaDzClK/nSVkUEW1P8/dyRZEy1DkaNk+rWqQ+9oNXeMOx7n3GYdQYPQjxNJZB
         fXrIuHiuTEX++hSpGN66/T3GriIItEmX6ZJbLQNcoAHu5ex7E/l6mwPM4VvcIlrhUQlg
         VTeRqIh8hcLjRITH/8OCrgsBm0LzINXni04jopCLGi9f6K4vfaAsMOPd8NmPXE516nR1
         kPIg==
X-Forwarded-Encrypted: i=1; AJvYcCVqWhX/Irojau0QDx1LytojfWGd9nb12GAWuF6xodYjbwHv1eGka4+OVOq+JYnjrYR+kxGKrhwU@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSn3F6kla6T/ZiP9fRIvacEwS1ciFNyvPfDcxkyMb4D7y9msb
	9QNPKOYeGN7p9RHFjQBtTDC2b+8oeddj61VKfze5avKZXRpyGCIqEZe1qdWm+hP8vUITXAwli1+
	bF8w7mPIjpCGt0PLuERDN6xGGoMU=
X-Google-Smtp-Source: AGHT+IFQhMvZFYxBPUgeLdKYJVihwShDU5Rc7jwMI4S2Hf2yGom/Y54S3fv0yoR1SXhWFiNjn0Kn0d34NgJgXpLGz5s=
X-Received: by 2002:a05:6358:728:b0:1ac:f839:e001 with SMTP id
 e5c5f4694b2df-1c3f9f6b6ffmr675931355d.22.1730293974726; Wed, 30 Oct 2024
 06:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004164605.7607-1-stephen.smalley.work@gmail.com> <87v7xskk89.fsf@redhat.com>
In-Reply-To: <87v7xskk89.fsf@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 30 Oct 2024 09:12:43 -0400
Message-ID: <CAP+JOzQudrPsP4ej-ouGQY6qS30MBe3DAuB+EmsCXFYO4EOs4Q@mail.gmail.com>
Subject: Re: [PATCH] libselinux: formally deprecate security_compute_user()
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:53=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > It was originally marked for deprecation back in Feb 2020,
> > commit a41dfeb55d43 ("libselinux: deprecate security_compute_user(),
> > update man pages"), but the attribute was not added at the time.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Merge.
Thanks,
Jim

>
>
> > ---
> >  libselinux/include/selinux/selinux.h | 6 ++++++
> >  libselinux/src/compute_user.c        | 2 ++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index 1318a66a..50419a7c 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -263,9 +263,15 @@ extern int security_compute_member_raw(const char =
* scon,
> >   * These interfaces are deprecated.  Use get_ordered_context_list() or
> >   * one of its variant interfaces instead.
> >   */
> > +#ifdef __GNUC__
> > +__attribute__ ((deprecated))
> > +#endif
> >  extern int security_compute_user(const char * scon,
> >                                const char *username,
> >                                char *** con);
> > +#ifdef __GNUC__
> > +__attribute__ ((deprecated))
> > +#endif
> >  extern int security_compute_user_raw(const char * scon,
> >                                    const char *username,
> >                                    char *** con);
> > diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_use=
r.c
> > index f55f945a..d4387aed 100644
> > --- a/libselinux/src/compute_user.c
> > +++ b/libselinux/src/compute_user.c
> > @@ -96,7 +96,9 @@ int security_compute_user(const char * scon,
> >       if (selinux_trans_to_raw_context(scon, &rscon))
> >               return -1;
> >
> > +     IGNORE_DEPRECATED_DECLARATION_BEGIN
> >       ret =3D security_compute_user_raw(rscon, user, con);
> > +     IGNORE_DEPRECATED_DECLARATION_END
> >
> >       freecon(rscon);
> >       if (!ret) {
> > --
> > 2.40.1
>
>
