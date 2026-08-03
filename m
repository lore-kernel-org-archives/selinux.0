Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24030C151
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767705; cv=pass; b=M8cj6BgL6B+cB71BqyryNm/oC/rXKbXlMm7t1zky5t7gCwtILuXWJzPahVSXece4KCXRz3Zuhr5tMv9o+GtyYheDwtd0s1GovCfo9CqmkBaZ4rn38ia/zP8e63kqvjQ7XGKpI2qO3RN08lLtAjLB9dcaBQd9fF317j76BSJxtxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767705; c=relaxed/simple;
	bh=Sskmg5ZazUMCwOm1pgstUCMgvAcPWMq50hfuG9twvh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQHO6PViPo4JGW/GZUdKH0IZ0Ga0kqSnFLHz1JjurAlqUZ2HKvelJ0jSKB/Px5bJAAFG0zTyaUDjOLYBxc1iZ1cv3cTi/y44K1yYdEPnY75Bw3qj5K5RAMSGcZM4+CYHRI1CYOzIv7oNQh/1WvyzvobT/2KtTr0jqhoqSwIbDws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCGLpCtR; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCGLpCtR"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so1251700fac.2
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 07:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785767702; cv=none;
        d=google.com; s=arc-20260327;
        b=FrQyceontiCV4fFJIOy9z336zs+Quu9glu5BakL7soRX0no4j3lE6M+Jqr8nOhRbVV
         6hH5KivnbDqBCXu6uryxC76awf1W6lpSdCaZOdojB2BPLq7btXRqMmA0qNrM3mDFP4od
         tttroMtG6VOJ/UtYY1fDkFGTh7wzXrMvJL+nh8+4dPcDMPaxzZ8zWyqWn8Fl7LrREuOP
         QlR1fP6Vak1ne2tx3sqcXg+F6IPeoEKMxk/2cWo3czLDKWi6sGp8hjgFiUF8k98BHdAT
         J/yb8K8YZ8GyF1NHaQLST4S3POdKEUCjd6bHcLyBLUGwhC/vxg6yVmYm2WmUDAB/ypW7
         NTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=22Mm43AzUBOzIFs1dNmz8bRhvISx7nCqv3/izg3XkAo=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=N78C2ftLUTQfMfbnBtzV+VmKv/rE5+eqr0PwVOxCPt8N0dZjT6oh2TJ8qlT87VGmaV
         WYbQAYPWS9FH8UWdFnnsEKIHz+g9UnXaZ5KLTL4F3rtlYMY9Zajo2tIjWjijK/x5NtMu
         R9i1fEgLwEWp6P0kHRCRGTDTJ4sI5Bzho1GDUVVbYaopB6TjZvSh3K+EKs+11ox/Km0X
         yEUuzus/2jsW/NajgbRECigODv6PXZn7eio0ITjPMdD93FwPzkxwwwPaz+cajfQPEkHm
         Wt960Oqhk7QrROhMb8r1TRnkqh73CwPUx5zOSJ+0jcfrvfSi8qr3nE3RwRVCpSD8wR58
         KVCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767702; x=1786372502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=22Mm43AzUBOzIFs1dNmz8bRhvISx7nCqv3/izg3XkAo=;
        b=SCGLpCtRrGJ9IDgFgjKcpGelc0YqHyq/IdakJe37OBFzxen+98qcUBbzLkrytSSwd5
         IlGfrPMubfHCb2v7a5QOxQjnvF/E70YaPl2RYf/nWb0Ad3NLBC4sWh8wyBMbfS+eFDvI
         Aj1FtbfuFKUOG4WS7RwwJF70i2R/xP0WaFbM+vPb6hTC53S3gmyG4sKgzh9TQdRaCmiL
         /iF9FYiVxvpYmajx7SM7dPkfc9UDJU4ImZYcJGqgSLVZ1TnhOWcDRtmcALhjK90iAog4
         MVqvdONPsdPm4DBIqIfMHcUMK+8IUkTHQtN7+0u8HPUlUtDS1mXxUaEGzGrok9fTbeV5
         0tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767702; x=1786372502;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=22Mm43AzUBOzIFs1dNmz8bRhvISx7nCqv3/izg3XkAo=;
        b=GfU1VyV7eynBumbBMeVqmZMx8xXiHnoYG+x6969kD94y4VLazR8RIq8SdUwb2UD4A3
         KqDAeII4WaXw75tJac5rEPZ9Xh7VqdwW7pKtGTRJtB/uU3vGjYHvKWQVblK1Lu94n0X7
         5WolrZAAQ3gnVfTfQzu8gDVuCQMkYixgqoTGVACUNqjIXCYf6bnpMNWm4iz5FiT+l+TA
         eE/WOOxuDE2wjSPwbR3wj2IBHTmB5M+JjNrUXTLdJGpK9XKFSS7Ih+LrfYtGeW49jEL4
         EJ5OCFlber0pD77xNieencQ+ZG93fovrJDghSlX/2KagC4tz/myo/Jm2q14eAjzWLeFr
         Sfag==
X-Gm-Message-State: AOJu0YyIuFNlyyokdYiC3Q1pMCbwqziPgPEIfTdfxcsbjuVA8hd3uHCq
	dkmZ+CgpqYlGumMYHG6Lf7Y4MDLcm4w6aowCglxIaOox/D9MA8UD9WO2aEjDVZi6LPvmUrIm+1z
	Z4xdZ17mAUf6SWAkKhG0irMaKqL4YFki4b/OA
X-Gm-Gg: AR+sD11NNeQ1GlVaCn1xLivLu24DEaPD65EdIkU0BQzeqjKpUycGUzgySI3xJ7G7c+B
	pmgNTxzQiMLayJ0IJrLmavd9Yx6fVrj0kOEPp8xrMq3eT56IojhyX/UJzim5lIA9vpTmoygNHB3
	4Eqy3kS0rh+22d5w7GD6/tJQBERWTzc1UD8p4sSjjuPOGPN6crMRPRkOqEeQyGN9hAg50kuOAIf
	aAfU123+w8FMO+y9SwYkqJvJtQeNRv+xSoXGz6HlcgZr53bYjDt9gBqcqFBoCLUYEix5aqNdtN2
	J2c1p6A9h4KBpNhnuzhrQYUDHn0tHRA8wFf6Nmte1NrY4ntXCA8mFT0=
X-Received: by 2002:a05:6870:70a5:b0:448:908d:27e0 with SMTP id
 586e51a60fabf-45905844c87mr16064653fac.4.1785767702588; Mon, 03 Aug 2026
 07:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803142359.44099-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260803142359.44099-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 3 Aug 2026 10:34:50 -0400
X-Gm-Features: AUfX_mzVd-Vgb5BOwyMNRP-J_36wgYzHC6m73stDTHVJwyKShdtcBydmvnZPJr8
Message-ID: <CAEjxPJ5X2Z=MApTHczefZf0RwNikFdXUyzUy89LDQDop3n8shQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Cap max depth and processed nodes for cil_tree_walk()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
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

For reference, semodule -B on Fedora policy reached depth 51 and
processed 698555 nodes.
Could likely lower the MAX_DEPTH if desired.

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
