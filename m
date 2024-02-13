Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4060B85
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856759; cv=none; b=QPtfXPcBhqbeFYsjmXP5PPYGkIpitmC3SFLf3m5Bj5CRs2x8zieIU9KW84xl7rqBQ66of2E7obxN1k+KN4k64eyl9x7R+hN8DEP25B7Y5ZduYpKmSD69d7fnNC8ByENVi2MLDUWjVa5P8cu6CXKyrxRL98d5Mm0nuUmOPsaDbTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856759; c=relaxed/simple;
	bh=smhuk4NaP6XtZ0OEsMkWWmcjrw7Do964tN0dV2WpLMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wh1B59cstOit73ldfN/FfJs7t7wcCo2k0ow9lr2lTJd0CecFCc2FgRq3+PFzmk7icG+IKC2awMS3A37/WWl7NGHy32zmMFW4sGiviC26D9MIqICd4kxjln4CEfeLH5CY/GT2vVYfOhQZTqyLBwBKqoxHd1DhsmMAlpQbzJqZHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIVb9BJQ; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIVb9BJQ"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d2e16b552dso2460743241.1
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856756; x=1708461556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuliSBF/4Xlm553I29feevvqsRAV4wm0eyDMHtpdyXs=;
        b=fIVb9BJQAd4T7XydvPaADHCv+K/H1sLJFWwfdnCnSumlS4fKYwYEkc+mBtWzcYdHFt
         NC5CG/AbJHrcYgrdNNkdqe+KK/0SSmlx/nLibJIzI5Q3Jyk+G6mmLvU1EAM8eheO4yjk
         CA6Xteoyy6xU48NUCXFgvfoEDLnw6RBNX7kgEN/rpH7LO2i5Op9iIrb8iYJCY9qZUYUq
         Txdcbo/qoiNozlZlcPJ2eVORhJuwH6WyUoxgMbpZwFDkQfGpzr3aa0or7p3iEYjRHUvV
         MoggXk4ojlwmXnBQbzwHOXcAJY+uOviI7tz2GmIVvo+DHGQbpfhFJsCYJgXP39xqj/rN
         gSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856756; x=1708461556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuliSBF/4Xlm553I29feevvqsRAV4wm0eyDMHtpdyXs=;
        b=U//bxl4vBLISeJ0TppXaS4DMCIElqDxjcBGVcKSliLHJzy5/wAd2G8FmtozyBWgCtk
         oTVfJUn5hp13FR36VK7F5ZO3osAkHh/cA/j6g36uIdj/090yxWR6/qnhroo8sF7yPKDc
         /4CQ8qOl5DE9fhmhIleKYeWnjkasTlsvJWbGgGrr3RW3KbsxMkhmD5CZ60zK8hAMGGxU
         MV8d7k8xyGjxkfsBhvSQaiWZ333hkzMcDU96mpj7bPtzhPEEz+K+wAJP8y1dqMw6SbEU
         jGY1msBxrAbfwT4aMaoUx3Usg0/AItFuLr6vkBfmCZ8eZCvfiYLO4TF3Ff42ykeOK8ay
         KAIg==
X-Gm-Message-State: AOJu0YxtinZHzSL8yTU0fMbo9CxtgSLXiDL18b6kiMAvYEBvtOGlkY+w
	+55yJzfbFWOBmexeVF8zGqW+Nb75l8yg12RGRVxo2rzLqKY+VsoSsaOm5qaod3rkJVAeXESR/jb
	6txvZwoK0pu1Nz2nYPW3TA1w4eCSYsS8qHzk=
X-Google-Smtp-Source: AGHT+IE3xqiWTFgvtcKnBwoxiYMzUPM5HO/GVZAWk30Zi5+qvnSXcYLd5HL9mx2pIAcqce6AovZhMbL5V7lEUlvWT30=
X-Received: by 2002:a67:eb41:0:b0:46d:3597:9f9e with SMTP id
 x1-20020a67eb41000000b0046d35979f9emr758094vso.31.1707856756250; Tue, 13 Feb
 2024 12:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-15-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-15-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:39:05 -0500
Message-ID: <CAP+JOzTcxy57oU6Qyqk50n+ks2fFx1O4LSP5P7JchcXxOcCHSQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] checkpolicy: misc policy_define.c cleanup
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Sync function parameter names.
>
> Drop superfluous return value.
>
>   The function avrule_merge_ioctls() has no failure conditions and
>   always returns 0.
>
> Drop duplicate include.
>
> Use native type for ranges.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 27 ++++++++++++---------------
>  checkpolicy/policy_define.h |  2 +-
>  2 files changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index cd49cae3..79d67a78 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -44,7 +44,6 @@
>  #define IPPROTO_SCTP 132
>  #endif
>  #include <arpa/inet.h>
> -#include <stdlib.h>
>  #include <limits.h>
>  #include <inttypes.h>
>  #include <ctype.h>
> @@ -1096,7 +1095,7 @@ int define_level(void)
>
>         while ((id =3D queue_remove(id_queue))) {
>                 cat_datum_t *cdatum;
> -               int range_start, range_end, i;
> +               uint32_t range_start, range_end, i;
>
>                 if (id_has_dot(id)) {
>                         char *id_start =3D id;
> @@ -1932,7 +1931,7 @@ error:
>         return -1;
>  }
>
> -static int avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
> +static void avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
>  {
>         struct av_ioctl_range_list *r, *tmp;
>         r =3D *rangehead;
> @@ -1949,7 +1948,6 @@ static int avrule_merge_ioctls(struct av_ioctl_rang=
e_list **rangehead)
>                 }
>                 r =3D r->next;
>         }
> -       return 0;
>  }
>
>  static int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
> @@ -2070,8 +2068,7 @@ static int avrule_ioctl_ranges(struct av_ioctl_rang=
e_list **rangelist)
>         /* sort and merge the input ioctls */
>         if (avrule_sort_ioctls(&rangehead))
>                 return -1;
> -       if (avrule_merge_ioctls(&rangehead))
> -               return -1;
> +       avrule_merge_ioctls(&rangehead);
>         /* flip ranges if these are omitted */
>         if (omit) {
>                 if (avrule_omit_ioctls(&rangehead))
> @@ -3854,7 +3851,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_=
t arg1, uintptr_t arg2)
>         return 0;
>  }
>
> -int define_conditional(cond_expr_t * expr, avrule_t * t, avrule_t * f)
> +int define_conditional(cond_expr_t * expr, avrule_t * t_list, avrule_t *=
 f_list)
>  {
>         cond_expr_t *e;
>         int depth, booleans, tunables;
> @@ -3866,15 +3863,15 @@ int define_conditional(cond_expr_t * expr, avrule=
_t * t, avrule_t * f)
>                 yyerror("illegal conditional expression");
>                 return -1;
>         }
> -       if (!t) {
> -               if (!f) {
> +       if (!t_list) {
> +               if (!f_list) {
>                         /* empty is fine, destroy expression and return *=
/
>                         cond_expr_destroy(expr);
>                         return 0;
>                 }
>                 /* Invert */
> -               t =3D f;
> -               f =3D 0;
> +               t_list =3D f_list;
> +               f_list =3D NULL;
>                 expr =3D define_cond_expr(COND_NOT, expr, 0);
>                 if (!expr) {
>                         yyerror("unable to invert conditional expression"=
);
> @@ -3940,8 +3937,8 @@ int define_conditional(cond_expr_t * expr, avrule_t=
 * t, avrule_t * f)
>         /*  use tmp conditional node to partially build new node */
>         memset(&cn, 0, sizeof(cn));
>         cn.expr =3D expr;
> -       cn.avtrue_list =3D t;
> -       cn.avfalse_list =3D f;
> +       cn.avtrue_list =3D t_list;
> +       cn.avfalse_list =3D f_list;
>
>         /* normalize/precompute expression */
>         if (cond_normalize_expr(policydbp, &cn) < 0) {
> @@ -4117,7 +4114,7 @@ static int set_user_roles(role_set_t * set, char *i=
d)
>  static int parse_categories(char *id, level_datum_t * levdatum, ebitmap_=
t * cats)
>  {
>         cat_datum_t *cdatum;
> -       int range_start, range_end, i;
> +       uint32_t range_start, range_end, i;
>
>         if (id_has_dot(id)) {
>                 char *id_start =3D id;
> @@ -5527,7 +5524,7 @@ static int define_genfs_context_helper(char *fstype=
, int has_type)
>         class_datum_t *cladatum;
>         char *type =3D NULL;
>         const char *sclass;
> -       int len, len2;
> +       size_t len, len2;
>
>         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
>                 yyerror("genfs not supported for target");
> diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
> index 075b048d..bcbfe4f3 100644
> --- a/checkpolicy/policy_define.h
> +++ b/checkpolicy/policy_define.h
> @@ -13,7 +13,7 @@
>  #define FALSE 0
>
>  avrule_t *define_cond_compute_type(int which);
> -avrule_t *define_cond_pol_list(avrule_t *avlist, avrule_t *stmt);
> +avrule_t *define_cond_pol_list(avrule_t *avlist, avrule_t *sl);
>  avrule_t *define_cond_te_avtab(int which);
>  avrule_t *define_cond_filename_trans(void);
>  cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void* arg2=
);
> --
> 2.43.0
>
>
