Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110ED32B116
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307310; cv=pass; b=WceZ0BLS4R6IfrMWGgQAqpKTjVWQmUeCbNzpEyWYfZcN9r/Klr/0NikK6T7w98dk8qS2ybGctDgir3/9kLuYN65PlCLM2eOv0rBVf/qNIb748h9Gzv4NkH4qv+SGKlquqGa825krvNz6c7JUNsehL4oF0+NuTblUIrSN5d3kywM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307310; c=relaxed/simple;
	bh=CFBXOGih10F4Xw7qeaVW8q97Sba5zM5jBvki4R454V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ8V8t0wGzs21nq/xV4PvZqioY9Q8dE79tLVJpg8SKvV6EIoBu/D1O06PRcgiERMqY5vbVzkjJJPTHUKD8m/aUbiIJOwwcrPW1IX/D+Q1YDojAqziMkH99zoXYUaRLtLtNhzy5siAfHvJc96979OyOoV3MuZln3Uit0eB7Wwaz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ3Nk2BH; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ3Nk2BH"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e8292423fso37654421fa.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779307306; cv=none;
        d=google.com; s=arc-20240605;
        b=dz+H2mq17d4wAuY2YRIDxg/tV6LLqC+IbdZNvdsMas3Ao4I5h/tWlILduHh59Vj2WI
         C/207Ss9wmu7awmYxPBWrEdgXcIUyx1afdAvbE/MbKFAMxPSjE88ZlHlwaxWFh9lrmzL
         kg4ETqAG154/lzMmaHBohFure4Pmz00LZvQZgnYZ3ldOpU6vuqZ92XxIIC8ZASTbBTUD
         aqNFc4HwbkUXpkH2ubYGT+qLQ+tvoFgCkaV1JNfB1Xj5yqYzlwknJaIU5SDGmamD3Irl
         ZxZ3BBP8P+PYA1VGJn2INT0PFoPcqwdRQPImw8CGebN6vmOvCUQTrh2GJvyFRJ0tu0zT
         PqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuyI+wAhAKOKygy/ShdfbypQwUN2UVDInt3qxqNjOa8=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=QewjrtPA8uoIPYSILFGASmhqGwWdPCoXCJs6Jxon7eFLLUqPQnRa7aWEciZLyi41mi
         uri1WvW9BJGfbd5QPCZd9KuxHB/pf2SHeTJO2qsWu6lhRUgtZcUSubGIBkJ1oMSCi8GG
         rAz/GajR3DVyPSBL1tMl64eJyKWHPM6T0gpcJbRQpr6YbPKIh4gG0zbFLu/1FP1HFOoc
         7SJDXagQ1LiIWrAwxhnaJVq8v2UT+ngvUDnUiYk2up8CWCHhL+6Q0GsuGslKknWEx+d4
         vsWhTi/ihPma9Z7A7FZnny59CjOFcPHztvBlgcC/SSi23aGc9mQqGShzGgpfvv5MIbj9
         WFJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779307306; x=1779912106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuyI+wAhAKOKygy/ShdfbypQwUN2UVDInt3qxqNjOa8=;
        b=AJ3Nk2BHblU1xQW+bXLaFaQu/HYjalJ4b7UITYb1/Q47bVZ2WAONr8gRE64hzWzNxm
         8vbyCy1bCL7BCDWrMHERo639vBx7c3H9yuLrJzUA5DlU4Go9knUfvo5MQkYtOufbt67d
         KJEogIa441/rpYhLWq3Xyt74TXZrA7yVMqP6PqS1zRlst463V3ALIMK9pjR+T/J63B3o
         WpITHyhjnDG4mCXT7RD9RPgv27/bh9NEV9IyKNY8rVDKSUNz+zLzOG7gI9JJTeCRCQS6
         /bpP29nSRLZg1oMBoliB0n3FM4x1owCiF06yr5NtV6L9azAJua/Y5TuJ3w0lWXoce9dB
         uRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307306; x=1779912106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuyI+wAhAKOKygy/ShdfbypQwUN2UVDInt3qxqNjOa8=;
        b=NgEt1sXYvnS+z5sKxhIAqzn5qaaC1zmJ+dyRkf/SpVw3X9KCLWV0/dVRmud2oM6mmZ
         mkuF48Q387JgstsfsdzQZPk2zdX4Dp7PdsJWPxVdmXsWE+9MTrPjm3uLFS93L8rvQ62n
         qaHZ24ySLOSsEL36godYDB2PM15X5txkzZmRSU7zidSAp2V9zIxsYGr+0m+MxStbbIuo
         3FGgpEw9JgA3fgmFEDHPVHSX02knpjG4GI7e9tf2o3AFIure0/BU3EBuks6O87x+vf+G
         NjlWftzy5AMaUVlIXARrnWazOGCGATdesQj9aGNAUYHOfxWtSmzHvC3hyv7vCSaZp5Ng
         pRtQ==
X-Gm-Message-State: AOJu0YyatsbFeKMdMiSKk/CczRVqZYccMseHkxVpjaGLqFwymtqHqYeR
	vYPzxrdunLTwjaExk5YCekUlLInZxOjixqbYQly5oo4djUsezF+uo32XhhdK7smqFSjf4B0QJZf
	Tdhg3ECliiFfxbh76dTpDB6sV9xCqPyQnVYnh
X-Gm-Gg: Acq92OFNW99k76whjOLZ0bB+Jdr85/fq9Kcd4le0nD5N0j7KthZTeRTpg8qC0L2RQRQ
	h8Gv9B5dcxYRWoEZwU/hH1trLikrjjbwJVZNixwe3+1ghSG0QYAdVy1VFQnlZaSUAkWK8LBLpFw
	KjTGFLhPnLFZuVGi8BrzjHxD9dZZVsF9LRuzbITStAPB//hXDn6vtVctvYK40tMPPedtAaleqCS
	MOJ5wCql+fDDgwWl7FfGBEj1KQWOwRAUmfMcOclVCPhV7Q0sDbQ10l2fWiv6fe5N36wtlnduUu3
	k6XQ
X-Received: by 2002:a2e:8a98:0:b0:393:d706:7bc with SMTP id
 38308e7fff4ca-3956193091cmr79016101fa.0.1779307305954; Wed, 20 May 2026
 13:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514204236.96433-1-kalevi@kolttonen.fi>
In-Reply-To: <20260514204236.96433-1-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 16:01:33 -0400
X-Gm-Features: AVHnY4KVqX6elWFB9hQt0YH00izwnjBsSNw5QS9b9sMKo93pCMiDp0rUNVO5Y4g
Message-ID: <CAP+JOzQnUGH=8uB9ktzjGOOMh=m-do0zWHhpv3Vu=auhFvCnCA@mail.gmail.com>
Subject: Re: [PATCH v3] libsemanage: use 'bool' for boolean options
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 4:42=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Use 'bool' for boolean options. Check strdup() failures.
> Add explicit 'conf->disable_genhomedircon =3D false' default
> initialization.
>
> Add missing <stdbool.h> include.
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/conf-parse.y    | 68 ++++++++++++++++++---------------
>  libsemanage/src/direct_api.c    |  2 +-
>  libsemanage/src/handle.c        |  2 +-
>  libsemanage/src/semanage_conf.h | 21 +++++-----
>  4 files changed, 51 insertions(+), 42 deletions(-)
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
> +       conf->remove_hll =3D false;
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
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 8f909a3b..9593bf69 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -992,7 +992,7 @@ static int semanage_compile_module(semanage_handle_t =
*sh,
>                 goto cleanup;
>         }
>
> -       if (sh->conf->remove_hll =3D=3D 1) {
> +       if (sh->conf->remove_hll) {
>                 status =3D unlink(hll_path);
>                 if (status !=3D 0) {
>                         ERR(sh, "Error while removing HLL file %s.", hll_=
path);
> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
> index ca57702a..2b3f1e61 100644
> --- a/libsemanage/src/handle.c
> +++ b/libsemanage/src/handle.c
> @@ -231,7 +231,7 @@ void semanage_set_ignore_module_cache(semanage_handle=
_t *sh,
>                                     int ignore_module_cache)
>  {
>         assert(sh !=3D NULL);
> -       sh->conf->ignore_module_cache =3D ignore_module_cache;
> +       sh->conf->ignore_module_cache =3D !!ignore_module_cache;
>  }
>
>  void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_co=
ntexts)
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
