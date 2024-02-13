Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4D58122
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856528; cv=none; b=FOQCu9yPI6h9MKLQ2Kwtq/xF6Cudg2nsSDgb2q+jd6PSFoUz4uZ9u/dPUGZZBFOjJ+SA1XssSJRKtRhhuqlzH2H77FM3dlC7B2QS5sYQWIIiugkGZ5IzZBdqr3oWrZEPKOx0CpjWVLsoPyONg4n3YC9RAHTuC1roVjo/VDZUBJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856528; c=relaxed/simple;
	bh=DQ9rvygz//RBTwnZxyQ62byGUMA8FcsdeF3CJGFPHjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=te9TFHmSeWcQaeMR+m+br3KayV6tbtWw9Ts7NAFmZ9g2e4wABy1DLwRxfYEcK/iiNxk1uNyC6+VScF1E3sZIq+oo2N/8QUZ1Rss7YZ50U0lDNfHs3c9fJ4C893AucJbY6j40ghHb1kHl3cRy5QTY5DzFQOCW0d44zpfdmd+uO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUuKtBbe; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUuKtBbe"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-46d60c75683so532283137.1
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856526; x=1708461326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hp6e3p2aFslpwEPhwlXOqn8gFqLVR3gjbxt08eeuKM=;
        b=MUuKtBbeWF4R+ywySxJnYwL43/IUalq1iVn/IYYe5vulmV7mROHODac3rMypkDxyou
         H7FbBIJfoeOTuMOMKOKWfUsMyII/z/1MPWJDIuRZOzWh0beWKaVPH+Dsw8TOis40eAsm
         a2DOaWaB5L83bmji0XoQIrddl6IU4bNAZ1Hpva2Kfkw3dq1hqsqUtx2zfzlqraVPHeBY
         kO/foQkwrXXyRrprP0CdJdZFHjzB82HWzKrBlfupUsd8kwLmeLYz3+pJuK096UEzQz1b
         lrgv+PsmkwHq4NshLxuiWXFmwfBbs2CrhanMm4AWxnuaqfTpbwbJoM9+qn378xPy86Gz
         qIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856526; x=1708461326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hp6e3p2aFslpwEPhwlXOqn8gFqLVR3gjbxt08eeuKM=;
        b=pU3LokR8zrEZoWSoheN9HW+YqaJ+rSRRCwF+HplVtvQOptQwfV+K4Hq22XghBWjluc
         yRV7Duzmoe6FNicKDNXxJdGRl1hAjY7t9Cjhs1cm4PQJSTSY6AHoA2AVWj+6Cdbi2PRm
         ob0o08F94VnWNQ7RNzZMIMX1YHjc5tdZH1HxEm2zfDBt5N5Fhptb5Zz4drTkobWw+KeT
         Xx3P1pIssKDCndCPTEGQSfMSA7VNWcrqNep+kDAQL9McdSjzHnIwVwsejv1SOmfvDG+Q
         4GUMIlNILC1oN1IBFBcq/d/pDUC9OtWDmEg/hWSyiW24f9UTIG+aXqQbHBDZXkd6k0J+
         waOQ==
X-Gm-Message-State: AOJu0YzgUIiYb0bT1WYXBN3quPWB6RwYnW/CohZu/Ty1xv+2nzw/XiA7
	4f0K0dp+n4qcD0/xQi1ZsCdGlRuoHgEBj37326APw4csq1JbdlAM9EWNAxYTXKMDgvE3A4/kTWG
	BagPiiKJLNuHNsRg4ofM14WSbO5I=
X-Google-Smtp-Source: AGHT+IEqQ2xX990pL+wEvuzZuMJMOCwYI10wJydWm2x/0YcKMorWLEyO8ZoBFh8Qgao0CkVg9nvb1cbR+wiLiUVV2Nw=
X-Received: by 2002:a05:6102:3116:b0:46d:2558:9490 with SMTP id
 e22-20020a056102311600b0046d25589490mr536026vsh.15.1707856526127; Tue, 13 Feb
 2024 12:35:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-4-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-4-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:35:15 -0500
Message-ID: <CAP+JOzT3dYjoT_ugVbM_paVVfsU31=W+341aNz0yh4+7R1ewkA@mail.gmail.com>
Subject: Re: [PATCH 04/15] checkpolicy: free ebitmap on error
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index db7e9d0e..053156df 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2544,6 +2544,8 @@ static int define_te_avtab_helper(int which, avrule=
_t ** rule)
>         int add =3D 1, ret =3D 0;
>         int suppress =3D 0;
>
> +       ebitmap_init(&tclasses);
> +
>         avrule =3D (avrule_t *) malloc(sizeof(avrule_t));
>         if (!avrule) {
>                 yyerror("memory error");
> @@ -2607,7 +2609,6 @@ static int define_te_avtab_helper(int which, avrule=
_t ** rule)
>                 }
>         }
>
> -       ebitmap_init(&tclasses);
>         ret =3D read_classes(&tclasses);
>         if (ret)
>                 goto out;
> @@ -2693,8 +2694,6 @@ static int define_te_avtab_helper(int which, avrule=
_t ** rule)
>                 free(id);
>         }
>
> -       ebitmap_destroy(&tclasses);
> -
>         avrule->perms =3D perms;
>         *rule =3D avrule;
>
> @@ -2703,6 +2702,9 @@ static int define_te_avtab_helper(int which, avrule=
_t ** rule)
>                 avrule_destroy(avrule);
>                 free(avrule);
>         }
> +
> +       ebitmap_destroy(&tclasses);
> +
>         return ret;
>
>  }
> --
> 2.43.0
>
>
