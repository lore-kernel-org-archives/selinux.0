Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A3336897
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786760; cv=pass; b=CGewbdF9VR5f3g/A4HqCvZl3/CxP9HUXFAxEvPza792cB0nrJVl5+jvNdbyuUwOrbflFEYoz5UjE3KN28Ef7fg4xvAvV1I8BdxF0COnu/ot2H9wEII/pC06C1bOuL3OjKrue+RxGQ8DKiKN3ZkX6rFRY0Pk9EDI5RdyININ8sfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786760; c=relaxed/simple;
	bh=XnLozcFhTmBeqHF+OQb8DA4GGy04l3o7vkgETjM7PAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caf5vN0dVVBjAWr0R6kBM5fAdgR4BMh4aszHKPkDwMHXLRHEXNE3L9iWYiBBt0LCKhiW1LpS30+H0K9nvhKjwkWRs5Jp9wkXu2I4O9ZbmyfmolLczqWGtLO3v69egzSQP+rFPfvwXBpkQAt8GfQjQznrNz59bdyf6aqRHcrk3iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHSrTowz; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHSrTowz"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39394e1e8f3so74613581fa.1
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 12:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778786757; cv=none;
        d=google.com; s=arc-20240605;
        b=MI1VELUTjg1hr2HS1/kb/cchVuPZSZvVg9BDEoMZBYfr3VMKpWWlefzE3WBf0xXTRd
         7Bca1gS8JXgj7bGM40XHvHpe5Z8n0XAh2zedJxPRnCsSXcW6WJ13K+L+MxlWQ3OBuYY9
         2Z8Am/dEIIB56s47yj2xtGKtEEAMIosDET/fYFx7/pF+t4M81DCqGoruNIukYaMyb/u+
         ANNXQ96Id3L4AItEFBxgV/nPMS8c8zGsJt9W6C0GZ8qpAfqHTaOmEla7k+3WtoVEMyji
         qTwBupJv2TvOktF9ZWQO4Ap/A+2c/AS/xF4bgAs4ECaIRpXb+GtsrfFF7NBeHAnAAOA6
         YzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IG7W3FdvjxoN8VhBMnkXSlJ11gJzamUqy32HCfnlbTk=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=TFVXWhSEeoIgLJbmlJTVQgx5f5u4hxrD2rA/iXhzXQtYAME4jv1frLkf8JQe0pDcK8
         sx8AYUzJTiAEy2Pe8w/2Z+MqWqFGjNI5J6A3Zr3xz3DeT3JT3s3vAnrhWzZsg7/MxwNE
         N7InSn1mJoYs1xorKJpFz+tH6yDLko6U4Nypt/erJ1LidzHfMJKKt7UlekNVtEi208cC
         RPUziS2rfwXrALa22j9qEt8uzE6Am4tfbEjYV1gSDMq/ejxk8obRbs3Unk3wuKH/JGVd
         dpyFDpRM9tr1H0EiVVKcX7eUqVZStewBdg6VCvG3XebtS9POF1mOOwfC+Y/cKn6FX+tP
         EhcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778786757; x=1779391557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IG7W3FdvjxoN8VhBMnkXSlJ11gJzamUqy32HCfnlbTk=;
        b=cHSrTowzV9skKT4/VoRPzVbqBsGwqVL6yEyMQ7+Ygn4dLEWntMiEuHwHsR+I/oyZDi
         ndD+4adj6YXoRMbTq7IOIjWmdLlgna4VgfaVHGkyH7a2CuwwT3SWP19ThUbot6ODMe4d
         Tc2uSo89bg0KpOEnpc/Oiz6ZYFXjsjgDGIsVqDPkA0obqegOoZIQoeWHkHKNojSwbfB7
         fWB+zYaFSgzRdN8szJpoFxpUv733Y5z5cwXXXGJHBAeolBCyZ50ch0pxrDFQgiW5OnMu
         l5drTOf0x1jTHxucOMnDuIgFaj5S2ZBj+4fS/lJ84zo9gM4RIlqXFTJNBp1yfYFZq4KT
         6NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778786757; x=1779391557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IG7W3FdvjxoN8VhBMnkXSlJ11gJzamUqy32HCfnlbTk=;
        b=Qim3vHmp1cZ5qFmJGlj5EDOIj4uP6Ke69MklhPBoJ4uLXfBIfgkTFcMNpACWcFovGp
         1VXAIrP1cWBS4BRJOLTQuV9AFu3fgEozNAQsqN4Yg14tOJAPQQxL4OfZTX3O3BSqOY85
         ZuBvlRqspeDJaFP6jGnX0n1TKuyFB2YAuX227+3L5GB8DTTSFF817ikG6jFlrmDU8QJw
         SNH6w+iNQJOo6fxUatOE2/JofnNImbfPoyFBTe5+Hosl3Qu3JoXMW5Fxy9bR1bAwxlX6
         N0PPN9CGLPtYts912iKCV3L05FfmPqRuEtUv0T6a8MBMaAF3RMS4wMB63Jx1zeirVxK5
         41jA==
X-Gm-Message-State: AOJu0YymPqP2W+b6ef3MYSTyVrDNnx4ZHsxUFMVfJw/VSleF96UtDCIS
	Tb2RitFkamGfMUQoFW7T1ULgxqnuZ+thl9R5aHJ51WmPPGxMquX++HRHJll/uQyZTNCwMqym6+L
	PRByHzYIQi4Oddc6CTzys0S1KiGayhWVBoyLO
X-Gm-Gg: Acq92OEGF5qIOjKoV1P9NcaMuPmfOAtrP2C4+qe+eawMOyChygfpx3XrdqB473ugG/o
	hJI5gIf1JRGLY9eXKA7FOoNkirZ/fh27i5b6viyW4xHWrO7xwLoTaUCHpR2KYJPTIzhK+AyPwA2
	ApqUkHlckD+/6zCkn3EFcvFpjJyLvZEjQwsqxzJKD12MwMaGQO0ayRwBihqWYMyVJ8d94qGKfJx
	ckRxuNxXI+RSJZQqb8fiNvWhF27G68Nm2BFtvAKG4J/owVSN9ZL6l30wTynhshFKLaEN289cSGb
	PWt2
X-Received: by 2002:a2e:8a89:0:b0:38f:20cc:2bb0 with SMTP id
 38308e7fff4ca-39561dcaa58mr1051451fa.23.1778786756278; Thu, 14 May 2026
 12:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506195818.93622-1-kalevi@kolttonen.fi>
In-Reply-To: <20260506195818.93622-1-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 14 May 2026 15:25:44 -0400
X-Gm-Features: AVHnY4IlfrtdXinz2EcFBOJoJqLGFk2CNxz3v43YpIh52C8MRfSdxiv2O9tOiHc
Message-ID: <CAP+JOzTtcQikXMEjQrN5zO+9qwzQ9jz7X-bRhrEaq-2k0MR0Ng@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: use 'bool' for boolean options
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 3:58=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.f=
i> wrote:
>
> Use 'bool' for boolean options. Check strdup() failures.
> Add explicit 'conf->disable_genhomedircon =3D false' default
> initialization.
>
> Add missing <stdbool.h> include.
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  libsemanage/src/conf-parse.y    | 68 ++++++++++++++++++---------------
>  libsemanage/src/semanage_conf.h | 21 +++++-----
>  2 files changed, 49 insertions(+), 40 deletions(-)
>
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index b69ac75b..0f10546e 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -29,6 +29,7 @@
>
>  #include <errno.h>
>  #include <unistd.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -132,9 +133,9 @@ compiler_dir:       COMPILER_DIR '=3D' ARG  {
>
>  ignore_module_cache:   IGNORE_MODULE_CACHE '=3D' ARG  {
>                                                         if (strcasecmp($3=
, "true") =3D=3D 0)
> -                                                               current_c=
onf->ignore_module_cache =3D 1;
> +                                                               current_c=
onf->ignore_module_cache =3D true;
>                                                         else if (strcasec=
mp($3, "false") =3D=3D 0)
> -                                                               current_c=
onf->ignore_module_cache =3D 0;
> +                                                               current_c=
onf->ignore_module_cache =3D false;
>                                                         else {
>                                                                 yyerror("=
disable-caching can only be 'true' or 'false'");
>                                                         }
> @@ -195,9 +196,9 @@ file_mode:   FILE_MODE '=3D' ARG  {
>
>  save_previous:    SAVE_PREVIOUS '=3D' ARG {
>                         if (strcasecmp($3, "true") =3D=3D 0)
> -                               current_conf->save_previous =3D 1;
> +                               current_conf->save_previous =3D true;
>                         else if (strcasecmp($3, "false") =3D=3D 0)
> -                               current_conf->save_previous =3D 0;
> +                               current_conf->save_previous =3D false;
>                         else {
>                                 yyerror("save-previous can only be 'true'=
 or 'false'");
>                         }
> @@ -208,9 +209,9 @@ save_previous:    SAVE_PREVIOUS '=3D' ARG {
>
>  save_linked:    SAVE_LINKED '=3D' ARG {
>                         if (strcasecmp($3, "true") =3D=3D 0)
> -                               current_conf->save_linked =3D 1;
> +                               current_conf->save_linked =3D true;
>                         else if (strcasecmp($3, "false") =3D=3D 0)
> -                               current_conf->save_linked =3D 0;
> +                               current_conf->save_linked =3D false;
>                         else {
>                                 yyerror("save-linked can only be 'true' o=
r 'false'");
>                         }
> @@ -220,9 +221,9 @@ save_linked:    SAVE_LINKED '=3D' ARG {
>
>  disable_genhomedircon: DISABLE_GENHOMEDIRCON '=3D' ARG {
>         if (strcasecmp($3, "false") =3D=3D 0) {
> -               current_conf->disable_genhomedircon =3D 0;
> +               current_conf->disable_genhomedircon =3D false;
>         } else if (strcasecmp($3, "true") =3D=3D 0) {
> -               current_conf->disable_genhomedircon =3D 1;
> +               current_conf->disable_genhomedircon =3D true;
>         } else {
>                 yyerror("disable-genhomedircon can only be 'true' or 'fal=
se'");
>         }
> @@ -231,9 +232,9 @@ disable_genhomedircon: DISABLE_GENHOMEDIRCON '=3D' AR=
G {
>
>  usepasswd: USEPASSWD '=3D' ARG {
>         if (strcasecmp($3, "false") =3D=3D 0) {
> -               current_conf->usepasswd =3D 0;
> +               current_conf->usepasswd =3D false;
>         } else if (strcasecmp($3, "true") =3D=3D 0) {
> -               current_conf->usepasswd =3D 1;
> +               current_conf->usepasswd =3D true;
>         } else {
>                 yyerror("usepasswd can only be 'true' or 'false'");
>         }
> @@ -272,9 +273,9 @@ bzip_blocksize:  BZIP_BLOCKSIZE '=3D' ARG {
>
>  bzip_small:  BZIP_SMALL '=3D' ARG {
>         if (strcasecmp($3, "false") =3D=3D 0) {
> -               current_conf->bzip_small =3D 0;
> +               current_conf->bzip_small =3D false;
>         } else if (strcasecmp($3, "true") =3D=3D 0) {
> -               current_conf->bzip_small =3D 1;
> +               current_conf->bzip_small =3D true;
>         } else {
>                 yyerror("bzip-small can only be 'true' or 'false'");
>         }
> @@ -283,9 +284,9 @@ bzip_small:  BZIP_SMALL '=3D' ARG {
>
>  remove_hll:  REMOVE_HLL'=3D' ARG {
>         if (strcasecmp($3, "false") =3D=3D 0) {
> -               current_conf->remove_hll =3D 0;
> +               current_conf->remove_hll =3D false;
>         } else if (strcasecmp($3, "true") =3D=3D 0) {
> -               current_conf->remove_hll =3D 1;
> +               current_conf->remove_hll =3D true;
>         } else {
>                 yyerror("remove-hll can only be 'true' or 'false'");
>         }
> @@ -294,9 +295,9 @@ remove_hll:  REMOVE_HLL'=3D' ARG {
>
>  relabel_store:  RELABEL_STORE'=3D' ARG {
>         if (strcasecmp($3, "false") =3D=3D 0) {
> -               current_conf->relabel_store =3D 0;
> +               current_conf->relabel_store =3D false;
>         } else if (strcasecmp($3, "true") =3D=3D 0) {
> -               current_conf->relabel_store =3D 1;
> +               current_conf->relabel_store =3D true;
>         } else {
>                 yyerror("relabel_store can only be 'true' or 'false'");
>         }
> @@ -305,9 +306,9 @@ relabel_store:  RELABEL_STORE'=3D' ARG {
>
>  optimize_policy:  OPTIMIZE_POLICY '=3D' ARG {
>         if (strcasecmp($3, "false") =3D=3D 0) {
> -               current_conf->optimize_policy =3D 0;
> +               current_conf->optimize_policy =3D false;
>         } else if (strcasecmp($3, "true") =3D=3D 0) {
> -               current_conf->optimize_policy =3D 1;
> +               current_conf->optimize_policy =3D true;
>         } else {
>                 yyerror("optimize-policy can only be 'true' or 'false'");
>         }
> @@ -316,9 +317,9 @@ optimize_policy:  OPTIMIZE_POLICY '=3D' ARG {
>
>  multiple_decls:  MULTIPLE_DECLS '=3D' ARG {
>         if (strcasecmp($3, "false") =3D=3D 0) {
> -               current_conf->multiple_decls =3D 0;
> +               current_conf->multiple_decls =3D false;
>         } else if (strcasecmp($3, "true") =3D=3D 0) {
> -               current_conf->multiple_decls =3D 1;
> +               current_conf->multiple_decls =3D true;
>         } else {
>                 yyerror("multiple-decls can only be 'true' or 'false'");
>         }
> @@ -398,26 +399,33 @@ static int semanage_conf_init(semanage_conf_t * con=
f)
>         const char *policy_root =3D selinux_policy_root();
>         if (policy_root !=3D NULL) {
>                 conf->store_path =3D strdup(semanage_basename(policy_root=
));
> +               if (!conf->store_path)
> +                       return -1;
>         }
>         conf->ignoredirs =3D NULL;
>         conf->store_root_path =3D strdup("/var/lib/selinux");
> +       if (!conf->store_root_path)
> +               return -1;
>         conf->compiler_directory_path =3D strdup("/usr/libexec/selinux/hl=
l");
> +       if (!conf->compiler_directory_path)
> +               return -1;
>         conf->policyvers =3D sepol_policy_kern_vers_max();
>         conf->target_platform =3D SEPOL_TARGET_SELINUX;
>         conf->expand_check =3D 1;
>         conf->handle_unknown =3D -1;
> -       conf->usepasswd =3D 1;
> +       conf->usepasswd =3D true;
>         conf->file_mode =3D 0644;
>         conf->bzip_blocksize =3D 9;
> -       conf->bzip_small =3D 0;
> -       conf->ignore_module_cache =3D 0;
> -       conf->remove_hll =3D 0;
> -       conf->relabel_store =3D 1;
> -       conf->optimize_policy =3D 1;
> -       conf->multiple_decls =3D 1;
> -
> -       conf->save_previous =3D 0;
> -       conf->save_linked =3D 0;
> +       conf->bzip_small =3D false;
> +       conf->ignore_module_cache =3D false;

In handle.c the function semanage_set_ignore_module_cache() assigns an
int to this.
It is fine to assign a bool to an int, but I would rather be more
explicit when assigning an int to a bool, so that assignment should
be:
sh->conf->ignore_module_cache =3D (ignore_module_cache !=3D 0);
if you prefer, the following style is used in multiple places:
sh->conf->ignore_module_cache =3D !!ignore_module_cache;

> +       conf->remove_hll =3D false;

In direct_api.c, remove_hll is compared to 1, that comparison should just b=
e:
if (sh->conf->remove_hll) {

I believe that the other references are either making a comparison
like the above or passing it into a function expecting an int which is
fine.

Thanks,
Jim

> +       conf->relabel_store =3D true;
> +       conf->optimize_policy =3D true;
> +       conf->multiple_decls =3D true;
> +
> +       conf->save_previous =3D false;
> +       conf->save_linked =3D false;
> +       conf->disable_genhomedircon =3D false;
>
>         if (!conf->store_path ||
>             !conf->store_root_path ||
> diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_c=
onf.h
> index 2388faad..4df9b195 100644
> --- a/libsemanage/src/semanage_conf.h
> +++ b/libsemanage/src/semanage_conf.h
> @@ -21,6 +21,7 @@
>  #define SEMANAGE_CONF_H
>
>  #include <semanage/handle.h>
> +#include <stdbool.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>
> @@ -37,19 +38,19 @@ typedef struct semanage_conf {
>         int policyvers;         /* version for server generated policies =
*/
>         int target_platform;
>         int expand_check;
> -       int save_previous;
> -       int save_linked;
> -       int disable_genhomedircon;
> -       int usepasswd;
> +       bool save_previous;
> +       bool save_linked;
> +       bool disable_genhomedircon;
> +       bool usepasswd;
>         int handle_unknown;
>         mode_t file_mode;
>         int bzip_blocksize;
> -       int bzip_small;
> -       int remove_hll;
> -       int ignore_module_cache;
> -       int optimize_policy;
> -       int multiple_decls;
> -       int relabel_store;
> +       bool bzip_small;
> +       bool remove_hll;
> +       bool ignore_module_cache;
> +       bool optimize_policy;
> +       bool multiple_decls;
> +       bool relabel_store;
>         char *ignoredirs;       /* ";" separated of list for genhomedirco=
n to ignore */
>         struct external_prog *load_policy;
>         struct external_prog *setfiles;
> --
> 2.54.0
>
>
