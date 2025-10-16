Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07414F112
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643531; cv=none; b=RSmabz164CbuAmJQra/VQBdR7n9iYRTj/jqrVEQGLA11hCJscrOZWW7x9klHqQDbmT4eh1NYPROp8RleZJZVTfDsGPLTXs+KeADtc2K3MbzWJjRNfY+Y5hxT/l1a2QcMKKACk8tDZopTf5nm9ixqZZOsAMIax3sSwDC5ZOGjbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643531; c=relaxed/simple;
	bh=VlcVbpauNlYiTWVSantVbhx8xvIYodhZ/jN/wBsUsd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Noas69j8J8kkmz9gyF7g5gemboSNTdKWlVs12w57lhz0KvxG4Tla7PCYg3Cuz7tWbNBHKFU8qqFrD9tT/28hoZYlF82JDsYRj2ADhPoAteieCGK+jS7CiJ6KXkQ84TCdv5YwJ++VVa2/Cw01SMlh9I9JBxhgzjW8iyvpeHCsmcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtTTa9Sl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtTTa9Sl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso1119352a91.0
        for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760643529; x=1761248329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VckiFzr+B/U4uxxMplHMdyH3KjI64QH3ui8WFWHkV0=;
        b=OtTTa9SlWG+oNHtyp2pRdnzxBspa6CTaZmZTwlrWSUTYSJk3S7JPMKsvhptwGQpS3N
         ad9LSTttrx5H/98O/ynQac2bksO1IjsElMmOcgLsXw/u4LlxYhF6TUTB4ebhyI+alMNq
         ufiYgbRSerHUmP0t10k7/mOHwF/YUh6cZb17Upubeir3/wm5V19z4Lmvo3z5yj64bCka
         MmoyW2U+586KpNY4qpEbL8pmP8kWK9wYH7lW7PKq5AmtM7JTmomQml+XR8KIyP5AdZTq
         7h83YZfx2HoeeZui2ca4vcPf1mhJZ776yb5c3vuHvw2eGsCuVkrX0OrbTMGFNaM4Aihg
         +iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760643529; x=1761248329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VckiFzr+B/U4uxxMplHMdyH3KjI64QH3ui8WFWHkV0=;
        b=sV9rGsywyMOdpbYvX9zwEmnfjH8VOs+S9G3ZgTrpRLHOvFkfbKqpOjvtK8lYTGcqM/
         jp/9EFo8kttXv97rCaAK4i42/HqFNT/kPHQ9D0s+uW/zo8kENc+T2CTlYwf9AvfAwhpD
         KJiNNmi9WvH0i4qN1RA2GB705Ezk13MzuoAgqgX2dNGPNANR3W4d7Xulahr/6FhkcQWE
         hPgEIVsgMhKF3XnmfaWndQtmzQevgbpsNXhGNQX18YBp7+wpjdUDAqpKl1Jy77tc6IDq
         DqUd30ca5AheTC64UG6HCTkPHqpkJLef+QtAXwYsARr5y4pegDQ5n7EzDiHlaaUY2Rj4
         n3Rg==
X-Gm-Message-State: AOJu0YwE1ZYxXkvP58yLlfiWVIHhNC2NeR4ylS7/9y7tSN0WvFhzKXb9
	cSu4zsbw1I9JfxKwDLSO72CqKfVi+I3uBeyEF3Vo+YJb1pbA/uZ11oB7BK0mvoAtxspmKpjlC2y
	pCXGyW/AxWwZXjzdjelll44ROU7nATl3nog==
X-Gm-Gg: ASbGncstAkpDejmSohYxv6LqPsUtH9gbP+dWoqanPUqp9lOPewUWyyM0yZDUlXLbII9
	4q9kZ0fE6b2AJRmOye7BR6bZHS3NaALPqHHrMdjROvsKW9PRIRbnen+Fx3KmPRAlnsJ9/e3QBaM
	8p7JSRNtSTBOsrNmRon8jVqQzUbt7HG7KJg3bO5reiqBOLIFhAbfc0bbBPOTJslBQB8Ttf+5s75
	vm3dJa8WioNA8/2imXJ3/ZRlaVOtQlbwPaAfB0AdJZaQnZMkLIO+t5zNrx1r9AOQ9LBT8E=
X-Google-Smtp-Source: AGHT+IFLo4Ttwlx1xa2vUnFzlTajHctxCKFsbd1XeGGlkItBFQyKlJWAhUuSENNjSE0kj2SUsVt7LhzaG0xLhDDWK4Y=
X-Received: by 2002:a17:90b:3c42:b0:33b:ae28:5eae with SMTP id
 98e67ed59e1d1-33bcf87ac11mr1090220a91.14.1760643528865; Thu, 16 Oct 2025
 12:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016180929.452863-1-vmojzis@redhat.com>
In-Reply-To: <20251016180929.452863-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 16 Oct 2025 15:38:37 -0400
X-Gm-Features: AS18NWB4BQ55RvUQPhZ3cYyqqK369BHJYXaGMCmIHH9GG0N-cYgiJ9ijdvvqwPg
Message-ID: <CAEjxPJ7UE2vtCBNwDphKO1SPC88vbTHCyq+ENhvZe1Tea2hCGA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Ignore files removed during relabeling
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 2:09=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> In case ignore_noent is specified, ignore files removed during
> relabeling (race condition between folder read, file read and label
> set).
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libselinux/src/selinux_restorecon.c | 30 ++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 39eabeb9..7cad4c8d 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -726,6 +726,14 @@ static int restorecon_sb(const char *pathname, const=
 struct stat *sb,
>                             pathname, newcon);
>
>         if (lgetfilecon_raw(pathname, &curcon) < 0) {
> +               /* Ignore files removed during relabeling if ignore_noent=
 is set */
> +               if (flags->ignore_noent && errno =3D=3D ENOENT){
> +                       if (flags->verbose)
> +                               selinux_log(SELINUX_INFO,
> +                                           "%s removed during relabeling=
\n",
> +                                           pathname);

I wouldn't bother with these log messages.

> +                       goto out;
> +               }
>                 if (errno !=3D ENODATA)
>                         goto err;
>
> @@ -765,8 +773,19 @@ static int restorecon_sb(const char *pathname, const=
 struct stat *sb,
>                 }
>
>                 if (!flags->nochange) {
> -                       if (lsetfilecon(pathname, newcon) < 0)
> -                               goto err;
> +                       if (lsetfilecon(pathname, newcon) < 0){
> +                               /* Ignore files removed during relabeling=
 if ignore_noent is set */
> +                               if (flags->ignore_noent && errno =3D=3D E=
NOENT){
> +                                       if (flags->verbose)
> +                                               selinux_log(SELINUX_INFO,
> +                                                           "%s removed d=
uring relabeling\n",
> +                                                           pathname);

Ditto.

> +                                       goto out;
> +                               }
> +                               else
> +                                       goto err;
> +                       }
> +
>                         updated =3D true;
>                 }
>
> @@ -932,9 +951,10 @@ loop_body:
>                 case FTS_NS:
>                         error =3D errno;
>                         errno =3D ftsent->fts_errno;
> -                       selinux_log(SELINUX_ERROR,
> -                                   "Could not stat %s: %m.\n",
> -                                   ftsent->fts_path);
> +                       if (!state->flags.ignore_noent || errno !=3D ENOE=
NT)
> +                               selinux_log(SELINUX_ERROR,
> +                                           "Could not stat %s: %m.\n",
> +                                           ftsent->fts_path);
>                         errno =3D error;
>                         fts_set(fts, ftsent, FTS_SKIP);
>                         continue;
> --
> 2.51.0
>
>
