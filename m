Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA73F23D283
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171193; cv=pass; b=XUVgHCJVfvzaGg5zmPDvKc3eaEt5FtaN7IX816JLErEREMM0bJXgq2G/DtXCbfkDdTlKwXrAHkMCjG6Tr5Sr8CGDnGfkjBj636bHnZCzpkQJM+iDJZpZkLYLsrOso37OLoL5DMT6dNrMEWQO7XdDrsyUQXP4dM8ubySCi/bXQhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171193; c=relaxed/simple;
	bh=DddMHJnP+BZD8e6AuSuqah9K4acYrCpfvrJYdyCPiqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu5akDPz4Ja7P80OszUNDy0isxR+oBAOggQLt82xWhYD9F4e87me5fIWsDpv3u/2SNZh/Zn0Ck9lVcZLBCOrRE7XrtrxGQF2S+pZPlHAX8sZW8YfeTV7BuaTIRuMk3wRrJw/Ag2y1Ea1synNDjGeLG3KQmDDDgqz4LW+o3usFrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqfGxkTj; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqfGxkTj"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b01cb18515so2497247e87.2
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 09:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785171187; cv=none;
        d=google.com; s=arc-20260327;
        b=rRcZMNhi7bnwF6PDu51HzLLjkvieQANQG2FMSxPz6rRrg947Zaw7+GCEKH7BKFwS7V
         97xj3o31wkMWv5CnwaD0ndl/GnSazoR2ICD+7M7XEFFrjhXpH9iCSeZbbXPmLhxQ3n80
         StYCel88pRg2E+13bGrAbZOtrhrhuWO2ltWp+3LPx23aCZQf0KtcnF36BGdQmOb98i/2
         x0S7hmmONiEvSgvs3icr5s3Nirp57y0RuL7Ze+/agiOPr8+4VEn4Anjfel95FBteDJS/
         61VKh9a2hVvUdm30m/RMZCszBbfvXWrreA3Rj75v2Am2MEdgwmGljGOU0dABBxNe6P7E
         0Cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BKvd9OLuydZl9TjODFsy+OUXItPBUiE/c7RHpHhxlNY=;
        fh=iWU6EMthgWNLSYoyCnZUFfTmFYJzGz6VSgGmuJwkex4=;
        b=GsGKD072u3YhbJaCsjmKcMgp/ROKgxEHJI1nxNH67bhzzm51dM5h6TqNYJ5Mj6P6W2
         qQIN6mvqxE5Zu+LHILbFqGIoFuJipjxf1SkPga1ab3jhsWmjsLe/cAALF2eO/3dKQeGk
         zR2I619uP5hvSI09yD4A7QANl6m7YXAk+ZQF+oYW1G4e/LqRzWKgtr7BSVmYw8plI5Io
         sVZBUbtYyp0KcgwYaoXLlgbm3K5yopTfLN8JWtnDXxkEHPYPWbdVc2h7Wj5bS61jNz1D
         ggHTGcfYhMz2nNyBff2MlIY381M9qF0N29mzPR4hfM0xiUf8suBOnySoBillPOPfsObR
         Sr7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171187; x=1785775987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BKvd9OLuydZl9TjODFsy+OUXItPBUiE/c7RHpHhxlNY=;
        b=ZqfGxkTjwCJhBqgwVj3Tb6cwjIGFEPx0mTntxP8FmTfa71rdAjnyB0ik9eZKwckwMu
         mDiPHwU++UaP3/4uksbVV2SYPko8qufDlXWbuOo5NWpjF8b2j8NSWGkubKwI7NkbE6vS
         AL8Y1syrk/G4NOVTRFBQAlfM5dvKxsdWle2MQal4s30a0u/RBg6yyJsfbzeNibWnp/N8
         IQ3hyWm8MAIGGazkggUeBed0q0GISvfREMe4M4ZhPqrqUJOgvznGY6dhSOS9Scic+cYI
         7gFzVeLRqA1ny/JA/CFLQxWKjyAXMsOFdip9Ls00ALCm14wlDw92klxlUaM3uVpUMQN7
         r+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171187; x=1785775987;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKvd9OLuydZl9TjODFsy+OUXItPBUiE/c7RHpHhxlNY=;
        b=JN1XcopEqvc8sWYfSPqfbCG2EJWp/HYn6l+CRoc7pHgcv926zWvpmuzmrqQDzZM2Wg
         OAOBgwO86fRiUtNXeeWOxKlCqTWQVuNqnczZeev9K/baMUNdV4p5NyehgVgP15ieGn2F
         dwKmHl+WfFB4a9ymLAewJM4UpM8OqudHQVYaqd+451R4wUMR3nPK5umVXoGNtIg7v1yy
         ED4lFUs7CFTxtkwUpYUwAfEpGHCjmxVd1He7I1Ud2L1psNrfHkx2wfg6BG2oGR2nnO3b
         /6ox9UTdeZydBcl1zyENWAZ/v/F0vnoAMOXe4dXZzUz4W79jOexHcNqgDC/Oq2suypKD
         yakQ==
X-Gm-Message-State: AOJu0YzndeRsgm5G8FdMoDWKvFoajHJSBJ5TWrXOVk+1ggypoaVt7pMR
	XYqJAFh71B/NItagHajs6H02LhGvEcZwjJXn8NomoqxSezTqFjQ2xJYK2WIiESfIuXGngcNkJZz
	KbupTmvaC66PpS3DVRStmmX+yd3PZX+A=
X-Gm-Gg: AR+sD12/hFA1Awe0KakM2ExYDAC6qx/C3+IAy1LEjdruZsINygD5muh16YeW4TB9CqH
	VlGUaEfiWIfhXnVrR2nZUn1bZbQeeHfqRi8LrQ0ZR66SgAiDz0TcUCxbL2XyngsjUjKuD9YJcKG
	Swzew68OxmPNWc6oV/Y9g77CbPDMwMogrPmAk3QIoebgGh3+nIqi82i3J2wBu/DQhiT/FtoMl0q
	WHZHAAHKWETa51R99MQ0K1Q+z9hc6YIDfk/Ko4FFcZrVOHZ8/lUWZd9nTzXEOaGvPOuAg==
X-Received: by 2002:a05:6512:3c87:b0:5ae:b36c:81c7 with SMTP id
 2adb3069b0e04-5b2c1b2ef79mr1831374e87.35.1785171186725; Mon, 27 Jul 2026
 09:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727135957.85523-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260727135957.85523-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 27 Jul 2026 12:52:55 -0400
X-Gm-Features: AUfX_mwIAsZqCQtfvhN9agvtrp3XuBFwBcD63t3QhsrPH204p6FbZHeb2x6gTTg
Message-ID: <CAP+JOzQ5nqo=ZuO0KogwH-+ez1UZpF4oOmPWYRmSPcOZpxwEGg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: cap max depth for __evaluate_classperms_list()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 10:00=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> __evaluate_classperms_list() is called recursively without
> a depth limit, which can overflow the stack. Cap the depth
> to avoid such overflows.
>
> Reported-by: oss-fuzz (issue 479899924)
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_post.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 8845faed..183b0d49 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -2291,11 +2291,14 @@ exit:
>  }
>
>  static int __evaluate_classperms_list(struct cil_list *classperms,
> -                                     struct cil_db *db)
> +                                     struct cil_db *db, int depth)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *curr;
>
> +       if (depth > 32)
> +               return SEPOL_ERR;
> +
>         cil_list_for_each(curr, classperms) {
>                 if (curr->flavor =3D=3D CIL_CLASSPERMS) {
>                         struct cil_classperms *cp =3D curr->data;
> @@ -2313,7 +2316,7 @@ static int __evaluate_classperms_list(struct cil_li=
st *classperms,
>                                 cil_list_for_each(i, cp->perms) {
>                                         struct cil_perm *cmp =3D i->data;
>                                         rc =3D __evaluate_classperms_list=
(
> -                                               cmp->classperms, db);
> +                                               cmp->classperms, db, dept=
h + 1);
>                                         if (rc !=3D SEPOL_OK) {
>                                                 goto exit;
>                                         }
> @@ -2322,7 +2325,8 @@ static int __evaluate_classperms_list(struct cil_li=
st *classperms,
>                 } else { /* SET */
>                         struct cil_classperms_set *cp_set =3D curr->data;
>                         struct cil_classpermission *cp =3D cp_set->set;
> -                       rc =3D __evaluate_classperms_list(cp->classperms,=
 db);
> +                       rc =3D __evaluate_classperms_list(cp->classperms,=
 db,
> +                                                       depth + 1);
>                         if (rc !=3D SEPOL_OK) {
>                                 goto exit;
>                         }
> @@ -2347,7 +2351,7 @@ __evaluate_map_perm_classperms(__attribute__((unuse=
d)) hashtab_key_t k,
>         struct class_map_args *map_args =3D args;
>         struct cil_perm *cmp =3D (struct cil_perm *)d;
>
> -       int rc =3D __evaluate_classperms_list(cmp->classperms, map_args->=
db);
> +       int rc =3D __evaluate_classperms_list(cmp->classperms, map_args->=
db, 0);
>
>         if (rc !=3D SEPOL_OK) {
>                 map_args->rc =3D rc;
> @@ -2393,7 +2397,7 @@ static int __cil_post_db_classperms_helper(struct c=
il_tree_node *node,
>         }
>         case CIL_CLASSPERMISSION: {
>                 struct cil_classpermission *cp =3D node->data;
> -               rc =3D __evaluate_classperms_list(cp->classperms, db);
> +               rc =3D __evaluate_classperms_list(cp->classperms, db, 0);
>                 if (rc !=3D SEPOL_OK) {
>                         goto exit;
>                 }
> @@ -2401,7 +2405,8 @@ static int __cil_post_db_classperms_helper(struct c=
il_tree_node *node,
>         }
>         case CIL_AVRULE: {
>                 struct cil_avrule *avrule =3D node->data;
> -               rc =3D __evaluate_classperms_list(avrule->perms.classperm=
s, db);
> +               rc =3D __evaluate_classperms_list(avrule->perms.classperm=
s, db,
> +                                               0);
>                 if (rc !=3D SEPOL_OK) {
>                         goto exit;
>                 }
> @@ -2409,7 +2414,7 @@ static int __cil_post_db_classperms_helper(struct c=
il_tree_node *node,
>         }
>         case CIL_DENY_RULE: {
>                 struct cil_deny_rule *deny =3D node->data;
> -               rc =3D __evaluate_classperms_list(deny->classperms, db);
> +               rc =3D __evaluate_classperms_list(deny->classperms, db, 0=
);
>                 if (rc !=3D SEPOL_OK) {
>                         goto exit;
>                 }
> @@ -2418,7 +2423,7 @@ static int __cil_post_db_classperms_helper(struct c=
il_tree_node *node,
>         case CIL_CONSTRAIN:
>         case CIL_MLSCONSTRAIN: {
>                 struct cil_constrain *constrain =3D node->data;
> -               rc =3D __evaluate_classperms_list(constrain->classperms, =
db);
> +               rc =3D __evaluate_classperms_list(constrain->classperms, =
db, 0);
>                 if (rc !=3D SEPOL_OK) {
>                         goto exit;
>                 }
> --
> 2.55.0
>
