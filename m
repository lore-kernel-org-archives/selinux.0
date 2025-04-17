Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17DC23F405
	for <selinux@vger.kernel.org>; Thu, 17 Apr 2025 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898810; cv=none; b=BlGbnVaDCrBOzda8qDZWkL1xkoLxmPGv3kQJowazGB+cKIB0yxelWgcvnZBkeydS1iGYSroaynkR1SuwLyfZaJ32oqxj+cQi5n6/LkRyrXBeGVOEaVcl6kxR0I7QqbbZmh6hskFLPHITjxmcOZrjVOVIKIRbalYYzMtn4XaIgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898810; c=relaxed/simple;
	bh=iyp25FhwIWizb+TTR/9LynC43f0cEMlQ0pzWM7539Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gq+/77tpi95GzFJ2z0+lBZ89Z2TOnQXhIwbi7c7Krij6qC9EMm1OVOA55vizRGIIdqu04blL0j7lR8LerQGU2orTWWLPECUs6scpDrPosVpL8H3NnWikO98cbb1vxRZEi9zEhAiTAQQSpWOFiTKwjP9ZaZPJPkzChtYo3p2glV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkG8BHl+; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkG8BHl+"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-400b64ac5fcso381115b6e.0
        for <selinux@vger.kernel.org>; Thu, 17 Apr 2025 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744898808; x=1745503608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rj0R5fbtFQaBSL38aoGzBpwv9Ap3Q7Vpi3DpeTQgAM=;
        b=OkG8BHl+rt00qgjSQtADFOs4eZ/srOseFRnDzws0Zgusx6Kkozxcn3ye9oVVd9V8zk
         NEK354MRKMONj1K/LDEqeHptoU2g0pdKw3XnAACiQjWEQkBEYehSQFxWo7w4KOVIWIzp
         LZlCphDFZCBDyea6hbmc6HCu+26hEMErjUxOVSzU71LfdCLq7wVtUh2CypyNU5FlWF/d
         CiDhdPM0cfVn3VT/WAl4iHVRvf/PaK6U1c6/+Z53+79QwEHSaUNgOajBN5L8jc5feuAg
         8++OQZS8d+Gn2QMmGqjHM72t5u3SvaMrWEAtW/4GJpGOGjTXwxFeVQmMDNqxpKURME4q
         9fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744898808; x=1745503608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rj0R5fbtFQaBSL38aoGzBpwv9Ap3Q7Vpi3DpeTQgAM=;
        b=FjicDIRlTPKW1dKUHRpTMNgFWGvU4lUR4Auxxh/prkqgyj1CGnCzUiPoqvH4zoPWmf
         A/40+1Xc0l3p1S/TWWvBsfwg375MFxaX4jEzGgMCngptG/EptI6DTuJQOZ+F9tyBUlgl
         Pe9oPvcxBuabpnE689vJAe4Xnp+Q5ABduCJ11luq4fYZ6SmFllgM5NSUpZ9zPdsOMqOe
         CGQflVuvtLNGEHGGipdglST6H5HKDoAduY6OzQYvdlKFvLev/f9sMAbu/U9nBvuDeSyB
         yD3joqyy/bBPWd7x599lM2u7xMNn/j82iKTZk1671anQF8US3Xavl+LdLjO46R3ORefJ
         QY3w==
X-Gm-Message-State: AOJu0YzXmgLV/t7AqCSOxwd+yV3JSNHPZDWZeGVN8lhGygpI8EjtWFPS
	ACI8rhd4CUhOODvrwmkcIj8+5MMPxZxO+7bE+Va9kB7rlFX5+DTWDUvdrf2GPg+CbSHLwTMWb3R
	4fBew9zDkfvbGyC3E6skUMEYCj7oBKZCl
X-Gm-Gg: ASbGnctJr/QzipOHIRKb4L7gkrHxo0F67OiCVWSAQUQkd4ZGFFAiNqzev8N9XifIZNs
	vjyii5b2Sr+kHzoiWjpfIVxvf3xYgCnXazIrBBWJCWY2Hr6uoIAZNLs6odb8AkpZlgKzKIZbPTQ
	HI+prlanx3uFw/tKte2gc=
X-Google-Smtp-Source: AGHT+IHQHE8GPNjTL9LSpDL4dFNMZlSXlOXoQRUAHUWO4WS3KF90g4BoGyGtjd//ypzt6jFzEE3P/WVmsPwekJFADf0=
X-Received: by 2002:a05:6808:201f:b0:3f6:729c:810 with SMTP id
 5614622812f47-400b01bfb42mr3463529b6e.4.1744898807738; Thu, 17 Apr 2025
 07:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzQtrLx8bS6_jb7pRaFzm=PXr9hm=Quy15qCMTFyHd8j9w@mail.gmail.com>
 <20250417020959.43450-2-tristan.ross@midstall.com>
In-Reply-To: <20250417020959.43450-2-tristan.ross@midstall.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 17 Apr 2025 10:06:36 -0400
X-Gm-Features: ATxdqUFn1w19cTTpZz5-s5dNp3yumkBZtmxJM4y7iGcV4c5JYxdtpAEJn9YSLOc
Message-ID: <CAP+JOzRJp=tZr-_aa9Gr1+2ZZa+rYiK1G3GzOmz6TpRunettew@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: add relabel_store config option
To: Tristan Ross <tristan.ross@midstall.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 10:10=E2=80=AFPM Tristan Ross <tristan.ross@midstal=
l.com> wrote:
>
> This flag allows for enabling or disabling automatic restorecon that
> semodule invokes. By default, we have it enabled to produce the same
> behavior as before. On NixOS, we need this as we're "baking" the module
> installation into a squashfs image and we cannot run restorecon inside
> the builder.
>
> Signed-off-by: Tristan Ross <tristan.ross@midstall.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/conf-parse.y     | 15 ++++++++++++++-
>  libsemanage/src/conf-scan.l      |  1 +
>  libsemanage/src/semanage_conf.h  |  1 +
>  libsemanage/src/semanage_store.c |  7 +++++--
>  4 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index e1fc9f4f..b69ac75b 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -63,7 +63,7 @@ static int parse_errors;
>
>  %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LI=
NKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_P=
OLICY MULTIPLE_DECLS
>  %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE=
_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
> -%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
> +%token BZIP_BLOCKSIZE BZIP_SMALL RELABEL_STORE REMOVE_HLL
>  %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_EN=
D
>  %token PROG_PATH PROG_ARGS
>  %token <s> ARG
> @@ -97,6 +97,7 @@ single_opt:     module_store
>         |       bzip_blocksize
>         |       bzip_small
>         |       remove_hll
> +       |       relabel_store
>         |       optimize_policy
>         |       multiple_decls
>          ;
> @@ -291,6 +292,17 @@ remove_hll:  REMOVE_HLL'=3D' ARG {
>         free($3);
>  }
>
> +relabel_store:  RELABEL_STORE'=3D' ARG {
> +       if (strcasecmp($3, "false") =3D=3D 0) {
> +               current_conf->relabel_store =3D 0;
> +       } else if (strcasecmp($3, "true") =3D=3D 0) {
> +               current_conf->relabel_store =3D 1;
> +       } else {
> +               yyerror("relabel_store can only be 'true' or 'false'");
> +       }
> +       free($3);
> +}
> +
>  optimize_policy:  OPTIMIZE_POLICY '=3D' ARG {
>         if (strcasecmp($3, "false") =3D=3D 0) {
>                 current_conf->optimize_policy =3D 0;
> @@ -400,6 +412,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
>         conf->bzip_small =3D 0;
>         conf->ignore_module_cache =3D 0;
>         conf->remove_hll =3D 0;
> +       conf->relabel_store =3D 1;
>         conf->optimize_policy =3D 1;
>         conf->multiple_decls =3D 1;
>
> diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
> index 64433f7b..c592fb63 100644
> --- a/libsemanage/src/conf-scan.l
> +++ b/libsemanage/src/conf-scan.l
> @@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
>  bzip-blocksize return BZIP_BLOCKSIZE;
>  bzip-small     return BZIP_SMALL;
>  remove-hll     return REMOVE_HLL;
> +relabel_store  return RELABEL_STORE;
>  optimize-policy return OPTIMIZE_POLICY;
>  multiple-decls return MULTIPLE_DECLS;
>  "[load_policy]"   return LOAD_POLICY_START;
> diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_c=
onf.h
> index 5db08f0c..2388faad 100644
> --- a/libsemanage/src/semanage_conf.h
> +++ b/libsemanage/src/semanage_conf.h
> @@ -49,6 +49,7 @@ typedef struct semanage_conf {
>         int ignore_module_cache;
>         int optimize_policy;
>         int multiple_decls;
> +       int relabel_store;
>         char *ignoredirs;       /* ";" separated of list for genhomedirco=
n to ignore */
>         struct external_prog *load_policy;
>         struct external_prog *setfiles;
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index 307f27f9..1731c5e8 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1823,8 +1823,11 @@ static int semanage_commit_sandbox(semanage_handle=
_t * sh)
>
>        cleanup:
>         semanage_release_active_lock(sh);
> -       sehandle =3D selinux_restorecon_default_handle();
> -       selinux_restorecon_set_sehandle(sehandle);
> +
> +       if (sh->conf->relabel_store) {
> +               sehandle =3D selinux_restorecon_default_handle();
> +               selinux_restorecon_set_sehandle(sehandle);
> +       }
>         return retval;
>  }
>
> --
> 2.47.2
>
>
