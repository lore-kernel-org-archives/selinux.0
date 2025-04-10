Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4A1EFFAF
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304110; cv=none; b=LEy7k3nTDzdMVJGsyL9sHvVEMctEZa/YGITarxeaonVQNfNT7/FDC3KdUar38KYzAfyopVA6rUBy1OchmpQRXOg+rhPxX4f6JP1t14x4KfiZk4WC/+QJi828zY/7WRRAmG9saQrSFK2ctJslYKjbMvMWQnVbkW+Ox70LVOb0Ovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304110; c=relaxed/simple;
	bh=dwVVyonShQ0SO1F4l9/HrSccOkjgaof6qUHDJVj+Myk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M70aZUFn0OCjnYwJNQfp/LVaB04vY3uGCHm+zOvw029AML65Pik3Ors7Jgds8JorCdtLgzOxaMOiNGI68b2vnvaMezjOrYii3EY5flu+osYjIE22wCv4j6ojzqgBjBWmez3YuqGRan9iXtWclOqurDu46wusmlZDfQGvDw+Ym4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/o2t4XU; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/o2t4XU"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5240b014f47so486991e0c.1
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 09:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744304108; x=1744908908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiS1l9KhedY590rEXvEh2lAVczkasQZrW2F5N8pU11o=;
        b=f/o2t4XUC8X1J5tENgC+umsM6QJzESuPXaCDHAygWUURUaVVuyjmNNUV8vHLYfGIKG
         hSkuYzFq6WQxU2b+GuPG9f+ug+H2qcn7M0f7CyzSPlOeJnxAlg3BacYPs3edNGpCSrT+
         CIjYufOjESpfepixysS2EDCcTgolPuQVN80LGkYIRQHNOz9mEMn8dFerI4aTMNkygAwP
         IdX7m2oM9EnaWqLPoPOY6N3cdTLNkFLnrBIeJYtHAAq6olC+ga5pKEnDHgpNkT8ec4iy
         HJr/yyfQplfrHmG1lL9YiLTSfOgWC+MDWcsBuQEJ+PNR3b4R4DUShzrx964p3jSagAkq
         jphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744304108; x=1744908908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiS1l9KhedY590rEXvEh2lAVczkasQZrW2F5N8pU11o=;
        b=AS/4y4fJPMwoUI489kmcznViuiP4RRiAEy6MT26f41NjClL8JfrFOtJJAZ3ejLtYVh
         mArHhm7wOnQ/oDTZ30bww55f0pJcaku/Dww4i+DBIb+IXVyMxa0dDDM/oCK6IW6Gk1Eq
         cKw4az4U8UemyDahabovGwCup5pa01BLranGVAwrBputfZShgnKxecLcM/HmPtUyN67Z
         ztWNAPSoUEROCndgjkoROYo0YplaaNe03g0GpAbxbsiSKfEw9tmGK0GRMnUE9hgZmQq+
         Bxto+3TPV3+wQwHbn3ew/sDV7JBA9Z5nOpbAvegSO47xlziEebf3gqYkzPEdwAzDySn6
         kNNQ==
X-Gm-Message-State: AOJu0Yw/sCHPGnfsMuOVvJN1T8/hraR//G90KW8grk2tN9BP84u25KSe
	M1EcjsGnypTBUq7j3chVZnCMeRcQPSwivc1kzEe4k1phyXEQQbTJ0W4Lfld8MPST5k9V0sgeVHL
	ZnwFL1ogJ9/yDiDFEM6rNktg2K6I=
X-Gm-Gg: ASbGncvUwDjryagZQs8qb66QAXv061ldUtK26Kx2X6dBnI6QEq0imUSHu6RzqNUtLDS
	Cb5GxDPAduJ+7HJWpbYa2IO8tbbllFSh2RhDWE/muVk4UUo0FVOsOpnYzp4nq9xPvz+4UPuPsHf
	KyNcJQ4ReMElGN1LHTZwk=
X-Google-Smtp-Source: AGHT+IGVaUGb92uf37hod6IenEkVO0UBZkDp0Gxw8RIins2WpLP1l10nm8IgTMwTxg5b0AbvzJqDVnmZ89n3UFT10ws=
X-Received: by 2002:a05:6122:78c:b0:525:9ddc:381a with SMTP id
 71dfb90a1353d-527b507ffd4mr3369822e0c.6.1744304107744; Thu, 10 Apr 2025
 09:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404113637.4131353-1-inseob@google.com>
In-Reply-To: <20250404113637.4131353-1-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 10 Apr 2025 12:54:56 -0400
X-Gm-Features: ATxdqUGjqDvytzSJXAvy5bnv6GfeRnjg7zX4ue0eC-y9FFOZTkvNNQwU36VAUIQ
Message-ID: <CAP+JOzQ8_7Sg9PVRXf5Zfxmfg+qKOGthdQVG-o+HjAShiqaqgQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Allow lineno > 1 for source file line
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 7:36=E2=80=AFAM Inseob Kim <inseob@google.com> wrote=
:
>
> There are cases that the line number starts with a number greater than
> one, if preprocessor skipped the very first line. This extends #line
> syntax so any lineno is valid for lines with a source file path.
>
> Signed-off-by: Inseob Kim <inseob@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_scan.l | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 5fb9ff37..c418a629 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -56,7 +56,7 @@ void yyfatal(const char *msg)
>  #define YY_FATAL_ERROR(msg) yyfatal(msg)
>  #endif
>
> -void set_source_file(const char *name);
> +void set_source_file(const char *line);
>
>  char source_file[PATH_MAX];
>  unsigned long source_lineno =3D 1;
> @@ -297,7 +297,7 @@ GLBLUB                              { return(GLBLUB);=
 }
>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}        {=
 return(IPV6_CIDR); }
>  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
> -#line[ ]1[ ]\"[^\n]*\"         { set_source_file(yytext+9); }
> +#line[ ]{digit}+[ ]\"[^\n]*\"  { set_source_file(yytext+6); }
>  #line[ ]{digit}+               {
>                                   errno =3D 0;
>                                   source_lineno =3D strtoul(yytext+6, NUL=
L, 10) - 1;
> @@ -387,10 +387,16 @@ int yywarn(const char *msg)
>         return 0;
>  }
>
> -void set_source_file(const char *name)
> +void set_source_file(const char *line)
>  {
> -       source_lineno =3D 1;
> -       strncpy(source_file, name, sizeof(source_file)-1);
> +       char *name;
> +       errno =3D 0;
> +       source_lineno =3D strtoul(line, &name, 10) - 1;
> +       if (errno) {
> +               yywarn("source line number too big");
> +       }
> +       name +=3D 2; /* skip a space and a quote */
> +       strncpy(source_file, name, sizeof(source_file)-1);
>         source_file[sizeof(source_file)-1] =3D '\0';
>         if (strlen(source_file) && source_file[strlen(source_file)-1] =3D=
=3D '"')
>                 source_file[strlen(source_file)-1] =3D '\0';
> --
> 2.49.0.504.g3bcea36a83-goog
>
>
