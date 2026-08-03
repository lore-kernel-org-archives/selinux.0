Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728F40F73A
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769975; cv=pass; b=st87IHndkEABR5sktZYYy65dE59phb3qLjmukN6vJN7kyXU5fkTnwONjexJgR3N4ghXDic8BROIAWGiXZ16vHEQu25oZ+lh+79fuVUs9yvZTx+xlspE8bwKEEMREQfeC7OZ845pNJ5+xTaKA6ND0Lnyq22iZPOMaea0e21IHDD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769975; c=relaxed/simple;
	bh=BcSbtW2nGabwlufx7HWwPjml9ywvMwp4IenRnwT3wI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPwe5aFdnXa6bjgpt2pXQJx7h2NVZ35pv8qzQuxeW1JYPY1MBf9k9rgblev645yj7v1JRKnzhebxxbhJKiQIUBH30QUfAQxGEQGDz+6ki9GB8pbCqXOae80fGK+Sr4rqeL2IRkmSmCm/pJUfv8l1IwpM+7H/iwbsTdhUtS3AM5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnVf6leY; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnVf6leY"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso30872491fa.3
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 08:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785769972; cv=none;
        d=google.com; s=arc-20260327;
        b=caSdg3KL/mLvQlxXYrXxWcuAi+XU+LmK2c5h3UsmiBEVSAmAOey7UDrdpsMrzDK6dD
         o2io3P+Dt2jwPkKhMNJ0ylAnUWw8qtIrRBzz5DVpA2UHCjzX0hZgiQcUyg48KDEmwgd2
         +qNMl5N6ozKMfF30yfcjn304wq9KYvn8/clSWLRMlgAp2ARkU2zhe6j7sepvd03e77/8
         N5URSSwY4Qor8v/b06LLeu0pGXBH40dLmLKfomGQ/LMNlEqc1Z50uV5pgRWdcN/LnkJ5
         RwVKCfudbFcH7F8Wo1juWXabcXbE3lbs8Ure+LjUnYD1WLLMJG2EpvWGaQYIdiKh5m2A
         xWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NJ75ZTxPVSWoampqGwn5IUWEmIMNTN9k1uD65Sv9JB8=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=do6lHPttJhv5uFon2CrASWOOsg7v6485MWNw5e/De8D34G1lPmqa4IBNbAX4zesZTT
         rrqHD5lHRx+VcAEbFB+VCn2eWyEu4eF40T8L9wiSdlP/NfViICp5IAAuInQYxOfbuQ21
         jKSIbGxz4QWi6iGkdwMmniudz9pLceB4y1TpChS9brhglxeC+gk2+VArqqefOAfpx/Kg
         SBoEG/s6iapIINWLX8Jb+WP4+3MN+iiTFcqWSoI3+XyLx/h3QMVA+GBc8wkblLG+BND+
         w/wjxDkNNb6CQ8VBpdRpZShZa8mWy/ckZCnbyhAf3iKEGQkrIOPxNqa7lYM5gGT553OT
         Qjow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785769972; x=1786374772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NJ75ZTxPVSWoampqGwn5IUWEmIMNTN9k1uD65Sv9JB8=;
        b=SnVf6leYp6J6Ha8NamUj8MjZ5sZ7hRBO58A+cNkBRuc1JBlCs+KN/o/KSZseeelbT7
         8Ez0n2+Oa41tWVV9DqYsJBP9w8U0ta14dODVzI7ZEOeRoGVQEJUavOrbkt5gOjImjBWS
         4VHYqj6bnrEVwuTZB/biS6PdojI0lNPmbLK3qYCOSjPcL1ZnNhHtonXUD5iRz1+/uOAW
         FBRF8lx7gHA2e7gUb75IqYAI8aBx2iQKo+AVuxxn02Sm6TOvfzOPAUWPG8Ye3uQEeAxL
         MhcA7VEkLVM6aPxgDUe83C3EapXIbiZF37QUYvjUmvkE9e8q6S5ccQD6XtKJ4urKg/hx
         jzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769972; x=1786374772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NJ75ZTxPVSWoampqGwn5IUWEmIMNTN9k1uD65Sv9JB8=;
        b=q2OMpcNwDcShrnikF/6eBS6dA0gmrNtu5LR1gVALtrooAWb+aMo0AnGrPrZpr9R7U9
         bAuUpFuCqhNb28gsRfyCcBJ0Cl3GYGJDMGu3x+hSi2qFBAp5dMwm3rI7cA/9rJ89o7/M
         Ljpa7C2LbgVPZKEmSH8/07yYy1BFWBDzEeAx4ewZrAtVw0lvUHz4wkM8IMzGho0oi25U
         kxAG+8buh44JcKXiFR/YBS9pdSZtdRrGlqaXwHlLf6odZvCTqjO/MBm/9Jl5ACSiFmv8
         u47ZR58yxOJ6+FwZGoqg2qwwcQ5Fr/69NU5nCC9+UkEpwRUmZIW9UklT7DWYRvuHxM7Y
         LaPQ==
X-Gm-Message-State: AOJu0YwG039uwmpQtQv2dIgQDTgUwpX9RghTVx3W3PmadXL81WGlWQWW
	/oxPgmEXGRKfMfM8bkbk+2Ydk3tiwZ94Sk1BJHhkY3WSyASDPY1we03A7Q9mVu1aI9veOyOXZJO
	U/h+PhH/zVdIEmwRcrd56Q2bBmnOA8KM=
X-Gm-Gg: AR+sD12T6BnERVU+YwOhdxuyEM6LEEKcpTjzz9ISK5LMbJC8CQLGm9Sz/ho4WBmufaP
	mGkIFY4xN3eyCZJ/iNPa6cVS3jH4lBk/uXR3b8Qo0sXN7nSY56Hsb7gcP9NPN890IMCp8MvYROU
	2yRKj69me3TiCxU0LSj3IHFa1tKfoh4ZEwJJH5dPou/e/k7fmftpA8X0smhFbshEbD1C/kwu86N
	4Sjk8wG7+Uso740lJqFoIfLfWR1RGhzo2uAx3gyYhVAIGopv3b8CHbwF2QWm4UhMudL4iCuiX2+
	8Az839mP9VWqlJN1Y9VarhgLHRSINtTCST1np2uvQA==
X-Received: by 2002:a2e:ad0a:0:b0:39b:b6d:59a1 with SMTP id
 38308e7fff4ca-39f86105ef3mr20764021fa.3.1785769971516; Mon, 03 Aug 2026
 08:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803142359.44099-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260803142359.44099-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 3 Aug 2026 11:12:39 -0400
X-Gm-Features: AUfX_mx2BuuZHgyyHfT2Kkao6oOxFlwWR3Z4LUPAkmJ7UG_FXprEMRIszj0xSC4
Message-ID: <CAP+JOzQ5n-5S4BpMfZD7d7jWQZw6fw4iON6oV+dboc==+mibCg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Cap max depth and processed nodes for cil_tree_walk()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:24=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Cap the max tree depth and number of processed nodes for
> cil_tree_walk() to avoid stack overflows and OOM conditions.
>
> Reported-by: oss-fuzz (issue 471608794)
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_tree.c | 65 ++++++++++++++++++++++++++++++-------
>  1 file changed, 53 insertions(+), 12 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 63dd33dd..17f19256 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -41,6 +41,9 @@
>  #include "cil_parser.h"
>  #include "cil_strpool.h"
>
> +#define MAX_DEPTH (256)
> +#define MAX_NODES (1U << 20)
> +
>  struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node,
>                                              char **info_kind,
>                                              uint32_t *hll_line, char **p=
ath)
> @@ -311,25 +314,41 @@ void cil_tree_node_remove(struct cil_tree_node *nod=
e)
>     extra_args:               any additional data to be passed to the hel=
per functions
>  */
>
> +static int cil_tree_walk_helper(
> +       struct cil_tree_node *node,
> +       int (*process_node)(struct cil_tree_node *node, uint32_t *finishe=
d,
> +                           void *extra_args),
> +       int (*first_child)(struct cil_tree_node *node, void *extra_args),
> +       int (*last_child)(struct cil_tree_node *node, void *extra_args),
> +       void *extra_args, unsigned depth, unsigned *processed);
> +
>  static int cil_tree_walk_core(
>         struct cil_tree_node *node,
>         int (*process_node)(struct cil_tree_node *node, uint32_t *finishe=
d,
>                             void *extra_args),
>         int (*first_child)(struct cil_tree_node *node, void *extra_args),
>         int (*last_child)(struct cil_tree_node *node, void *extra_args),
> -       void *extra_args)
> +       void *extra_args, unsigned depth, unsigned *processed)
>  {
>         int rc =3D SEPOL_ERR;
>
>         while (node) {
>                 uint32_t finished =3D CIL_TREE_SKIP_NOTHING;
>
> +               if (*processed >=3D MAX_NODES) {
> +                       cil_tree_log(node, CIL_ERR,
> +                                    "Exceeded max tree processed nodes (=
%u)",
> +                                    MAX_NODES);
> +                       return SEPOL_ERR;
> +               }
> +
>                 if (process_node !=3D NULL) {
>                         rc =3D (*process_node)(node, &finished, extra_arg=
s);
>                         if (rc !=3D SEPOL_OK) {
>                                 cil_tree_log(node, CIL_INFO, "Problem");
>                                 return rc;
>                         }
> +                       (*processed)++;
>                 }
>
>                 if (finished & CIL_TREE_SKIP_NEXT) {
> @@ -337,8 +356,10 @@ static int cil_tree_walk_core(
>                 }
>
>                 if (node->cl_head !=3D NULL && !(finished & CIL_TREE_SKIP=
_HEAD)) {
> -                       rc =3D cil_tree_walk(node, process_node, first_ch=
ild,
> -                                          last_child, extra_args);
> +                       rc =3D cil_tree_walk_helper(node, process_node,
> +                                                 first_child, last_child=
,
> +                                                 extra_args, depth + 1,
> +                                                 processed);
>                         if (rc !=3D SEPOL_OK) {
>                                 return rc;
>                         }
> @@ -350,17 +371,22 @@ static int cil_tree_walk_core(
>         return SEPOL_OK;
>  }
>
> -int cil_tree_walk(struct cil_tree_node *node,
> -                 int (*process_node)(struct cil_tree_node *node,
> -                                     uint32_t *finished, void *extra_arg=
s),
> -                 int (*first_child)(struct cil_tree_node *node,
> -                                    void *extra_args),
> -                 int (*last_child)(struct cil_tree_node *node,
> -                                   void *extra_args),
> -                 void *extra_args)
> +static int cil_tree_walk_helper(
> +       struct cil_tree_node *node,
> +       int (*process_node)(struct cil_tree_node *node, uint32_t *finishe=
d,
> +                           void *extra_args),
> +       int (*first_child)(struct cil_tree_node *node, void *extra_args),
> +       int (*last_child)(struct cil_tree_node *node, void *extra_args),
> +       void *extra_args, unsigned depth, unsigned *processed)
>  {
>         int rc =3D SEPOL_ERR;
>
> +       if (depth >=3D MAX_DEPTH) {
> +               cil_tree_log(node, CIL_ERR, "Exceeded max tree depth (%u)=
",
> +                            MAX_DEPTH);
> +               return SEPOL_ERR;
> +       }
> +
>         if (!node || !node->cl_head) {
>                 return SEPOL_OK;
>         }
> @@ -374,7 +400,7 @@ int cil_tree_walk(struct cil_tree_node *node,
>         }
>
>         rc =3D cil_tree_walk_core(node->cl_head, process_node, first_chil=
d,
> -                               last_child, extra_args);
> +                               last_child, extra_args, depth, processed)=
;
>         if (rc !=3D SEPOL_OK) {
>                 return rc;
>         }
> @@ -389,3 +415,18 @@ int cil_tree_walk(struct cil_tree_node *node,
>
>         return SEPOL_OK;
>  }
> +
> +int cil_tree_walk(struct cil_tree_node *node,
> +                 int (*process_node)(struct cil_tree_node *node,
> +                                     uint32_t *finished, void *extra_arg=
s),
> +                 int (*first_child)(struct cil_tree_node *node,
> +                                    void *extra_args),
> +                 int (*last_child)(struct cil_tree_node *node,
> +                                   void *extra_args),
> +                 void *extra_args)
> +{
> +       unsigned processed =3D 0;
> +
> +       return cil_tree_walk_helper(node, process_node, first_child, last=
_child,
> +                                   extra_args, 0, &processed);
> +}
> --
> 2.55.0
>
