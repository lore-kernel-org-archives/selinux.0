Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611313A1D4
	for <selinux@vger.kernel.org>; Tue, 19 Mar 2024 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879654; cv=none; b=r9DXnQf+/Y7gqTZ9HhhMhqaLLx7UWGlyFaDoPTz+5BMPdlxZiHHb9wWbm7vQLJvvDjeK+6V7N0zgXGsucu5FHf2ZvM2ej1IfTCqxNEg8MX+MRLKTpwDqHwCmVUz2AKvg0m4XGIqBt2pif/jXEfVzjtetHo01avXulu1m9RIzyCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879654; c=relaxed/simple;
	bh=1/I/KB0MfZ+z74stdpMMrVelDYsRflY8a0s/SgG1Z98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJ8/YrLmOgECmTLDqQMUHo1gRpVnnO0neELbXOigZNjxRE7pWHQ85WYmRbf+RBnTYCvqKf0Lu83F5Hgu40qBwzT5vjJK34ZUzgYAgPEhExmMJExJa8WgWSWsAMNWzvwbnAi0nB0iZrH401JjZaClOSfF5weWiTzEsG2xix8IR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh2wjvjt; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh2wjvjt"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-476605ec78bso992260137.2
        for <selinux@vger.kernel.org>; Tue, 19 Mar 2024 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710879652; x=1711484452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jzPX/JEGEPwdl83Qp6KnY7BN5vetAsd/fNyM14Ezok=;
        b=Lh2wjvjt7preoGz7e65pn8Hzo0wwP3g6j1yrccMadqOUHBCSIjDeuG2X6bB1Nq/sJg
         p8cJZxuw3O3la0VGhggEUTuZOPuquP9H/z/6/kWLtpSx2TcFk5Gc+TG7cRXAcNrl7K9u
         ZthWeFPfxLKczYjOdlA369xvu2lqTvl/zGAVd3zNd8rQDlVCdC6PpyjqMR/EDISlssIu
         6SgPE0CYgb/sDWqZoMcVtJzBvhcZC1wE0dE24hsYYoDMlOdcV6ChXbd+0iwK66JHofZY
         nSDT2eDK0NT/qhgddIf9r8hOsO6N98oSamVdLcZf8ew/ViQMeahUuOgfTaqylral+ClD
         3KiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710879652; x=1711484452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jzPX/JEGEPwdl83Qp6KnY7BN5vetAsd/fNyM14Ezok=;
        b=DGA9isDWJ/Y9Gv1zSLwBNROtcwiIt9215y4B4OtcV+NoombUsX7V0GocStNM7ENSXA
         9WNPR38cUs+z1QKFEgzodvaQczicr/GpFt8swMRLMOukfvZWon9mwBkSj8aP8/Ww36Wd
         P3GoZeLigh+J0AJ8H/1ASYhM/uat4y0n3pczOdSLgeDRJkuCuPd2FO23rySL4jToqj0H
         JNxr3kyTduDH+madRtcaTlkwMWBWJEAGZTRL/TlDbmm/WhX3bHhE5F4DGeFB8bA+81ws
         Lo6stXgXnaFJo92XKrFd44b8fCdLe2xqxJRTlkol+pYEgSa/uaNXCFZicq+g9MWwz8LD
         MbeA==
X-Gm-Message-State: AOJu0Yxqv/GH1q3SuAn+jAkbEA9dIvwzx9fWX3XNl5VIDmbLaaSj17BF
	TN+YrICrZrJy9v6KDN1XYxg3+IVzrY/cKwGUYnX5kRflKIqSl03Gul3K9My6LWj7CmjbYQzlIX/
	+v2TeiFQmnjldofjuG89WxuWu9ssRIgsg
X-Google-Smtp-Source: AGHT+IH0LvhqMGsC5wxkXFniY5+WeBsknX1Gmgfo+qtPBa/1E4FVr/3vrQpNbniBCZsTEZOXGhIoRL/FwzmtAbYrBxs=
X-Received: by 2002:a67:b915:0:b0:476:6a20:bdd6 with SMTP id
 q21-20020a67b915000000b004766a20bdd6mr10944418vsn.31.1710879652147; Tue, 19
 Mar 2024 13:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315172436.631262-1-cgzones@googlemail.com>
In-Reply-To: <20240315172436.631262-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 19 Mar 2024 16:20:41 -0400
Message-ID: <CAP+JOzRbwZef2D6BzZfeWenU3UZ_EwJLOGrDde_Jkzz-imwM5Q@mail.gmail.com>
Subject: Re: [PATCH] libselinux: avoid logs in get_ordered_context_list()
 without policy
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> If no policy has been loaded yet and thus the current context is still
> "kernel" avoid logging failures in get_ordered_context_list(), like:
>
>     get_ordered_context_list:  error in processing configuration file /et=
c/selinux/debian/contexts/users/root
>     get_ordered_context_list:  error in processing configuration file /et=
c/selinux/debian/contexts/default_contexts
>
> Since get_context_user() needs a valid context, because it tries to split
> it into its parts, jump right to the failsafe.

Needs a sign-off.
Thanks,
Jim

> ---
>  libselinux/src/get_context_list.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_conte=
xt_list.c
> index 7e23be05..ec3775a8 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -427,6 +427,12 @@ int get_ordered_context_list(const char *user,
>                 fromcon =3D backup_fromcon;
>         }
>
> +       if (strcmp(fromcon, "kernel") =3D=3D 0)
> +               /* get_context_user() needs a valid context, avoid
> +                * unnecessary log messages if no policy has been loaded
> +                * yet. */
> +               goto failsafe;
> +
>         /* Determine the ordering to apply from the optional per-user con=
fig
>            and from the global config. */
>         fname_len =3D strlen(user_contexts_path) + strlen(user) + 2;
> --
> 2.43.0
>
>
