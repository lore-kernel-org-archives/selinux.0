Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC679C8FE
	for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817522; cv=none; b=TWHJrj8p2jaqLtBy77G6mpC2kKHSZ8FRfZE6twDOoq0CwZOdaLDBJnVqikh5B7iL4ZevpaWyvQhi08yLjbuLGMYy0tlIm+MYI3lExBVypDIQ7pZKcOU1MGBbAgMvYK/F6Lyy2cpp8rs4BZFxcTnmVN1DOm5xUOcYTjUM+bqH2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817522; c=relaxed/simple;
	bh=1Lhwt+q4Wyvcu7FTQllx+qDa9kHdaKEdrxQhmgTOwc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiXcRkBHgvoHiGbv1sRfILa1myTwkaKWf58vphBeRvuYdlWnyME4EKGyT8101OzwmM64J+3nfBODClBiJEhxH7/bq52N6GLtlnIKs/i9oHE4LhScNrtayhHwHUHShQZTtPpYnoF9GVhllzfncuVQ0i/BFZZNTjEACNJwLKPSBmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TINJit4Z; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TINJit4Z"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5f720c717so90101785a.0
        for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744817519; x=1745422319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0uR+gkxVCettyfEtNU2w0DFu8JCelFmyc41LKNWcUI=;
        b=TINJit4ZHPko8o8P3z5r8lGiSxaxOfaDKSHuAzQaGkN1ENdEjbtRLOwhAGBBNXpUoM
         Im3FU72quxJ2LYrsT4zeb5P3vX0p5SsSBs8uuCdL/uO7VX+IktGKaCW0Ad6STv2HGRkw
         ASFhXIocz2VPHs3RE6TA2+61AQbXjtStrpkyWIfMJU7D8/94nFDB1CfIEEa8Y1NWrDip
         OQ5wLUauPnxUlH25IOyXA5DQPW2IkjtFGqk3WEKMjKp1c84IPT6DFG6TG9ztd0UyL8Mh
         GYcyxLNPd4ejZvSmcup8UG/sh6o1zLtm1c62aMviN5lBvyitGJePGoXqpfyAs2ENB18m
         swpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744817519; x=1745422319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0uR+gkxVCettyfEtNU2w0DFu8JCelFmyc41LKNWcUI=;
        b=EWHvxXdglqFRRusoy17rJKL6dBq3FXHlBQleQPvD2Ov+7bsjUp/zcq2NoJHixXcVt/
         kJ2P/dS4EVItMKv1PDlJnanCEbbeC7akVCvBSfjLOv8EqWIxU9TZX9ZQQFlq3MifHOHD
         LOG3d3MElEJpAw1s//5ByxpHaHJm13nXGiE7ve4aD7thOGivFRqJhbfs2hLjplsJ570h
         PpgygMxzx2+ugzB0relM7bdSR2vLDTxLfo8qRhBmGbuFbOk+3PR/QSopch06ugjlrll4
         lS2e5orxykGgnmjL+Xhjk1DQzx2PK/iwwwdg9gv/1WI063cCW51veJyAyYvIaJpEVMkX
         0K4g==
X-Gm-Message-State: AOJu0YxBKtSo7WtPniSoV9KdgayM1BKyQV//TJcD09n3Vgya8KKzGxwB
	vKnDX86urOTDT6x9Np+M1hPV+TZJpl3kzLGSH1TxpTBE3UiopwJE5IhJ6/1D6KqG6RHSjMh85mK
	njtY3azOTZVS8Wwr4VJmqx0RZSS71ww==
X-Gm-Gg: ASbGncvMirznAWmI+nx4EtgBEZxjeHAdvO1IpcDZ4ufTRv8ZkPl2pd8UvVneQwVqU5G
	/SFACRrwVNIlY9ZNekl9vS1rUeGriyG2GIgRMf27zDEAzbGibbfzKX8yti0njYinFHneM/GlzNL
	p09W/kciPrHSHJZkdt8mI=
X-Google-Smtp-Source: AGHT+IF/WGY2GKNE23DdIS++9Mldb4RtCxx/NeeXUnc5Nkq3SsRHqkqX0mFfCKA0HWyEGMstPRu9GQdY+qoFVZXVHno=
X-Received: by 2002:a05:620a:17a9:b0:7c3:b7c2:acf6 with SMTP id
 af79cd13be357-7c9194c38cbmr341134685a.15.1744817518621; Wed, 16 Apr 2025
 08:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ2a_DcSrGUFktCNhDBop_EtS-mO4Jgt8r6XMCq+DO-C4K_ZOA@mail.gmail.com>
 <20250416044501.28631-1-tristan.ross@midstall.com>
In-Reply-To: <20250416044501.28631-1-tristan.ross@midstall.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 16 Apr 2025 11:31:47 -0400
X-Gm-Features: ATxdqUFlkeBSk4tyzOYT9MaQYs5seuV6UIdRryQtU7dcxGOkRRtNqVU-znJ6aUM
Message-ID: <CAP+JOzQtrLx8bS6_jb7pRaFzm=PXr9hm=Quy15qCMTFyHd8j9w@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: add relabel_store config option
To: Tristan Ross <tristan.ross@midstall.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 12:47=E2=80=AFAM Tristan Ross <tristan.ross@midstal=
l.com> wrote:
>
> This flag allows for enabling or disabling automatic restorecon that
> semodule invokes. By default, we have it enabled to produce the same
> behavior as before. On NixOS, we need this as we're "baking" the module
> installation into a squashfs image and we cannot run restorecon inside
> the builder.

The patch looks good, but I need a Signed-off-by.
This goes for your other patches as well.

Thanks,
Jim

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
