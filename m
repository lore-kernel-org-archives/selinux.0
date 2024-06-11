Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADCA249E5
	for <selinux@vger.kernel.org>; Tue, 11 Jun 2024 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130395; cv=none; b=nKtM4G46waKsCAPwV5FDBSHQIWFJ7RPYBO3b8LT/XzkeipjkTpp/+c2bdRjkragzog/4s4pQZb1u/zjSiv1PfaXWH68ILC7MPyWFkmt4PQtZTMcwBNi8uh3GrEtr47lmR1zS535A/wBN+//vOysWw0/yN1zgzTA4xm+nLTgceVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130395; c=relaxed/simple;
	bh=IcchQdhJ5F0uCvZ0Xlqc97P27vvPwIHCDyUuHeLwGZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKyCH7Y7qV5EODJdP1el9AnhAcqTN0NIrRYfFhPEDcVxX4tDpnl3pX+ZuAvTV/Dmw2Oh0bgS3G6kyn15nivz3K8BPENJsTh5UrIKl5f8ci42OyyDT0sawEQhTIO9e8BHYkbMqR5HIYH+RppFmOHAYQkqG0CLHkzt+oaFzJ8iLCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9e4HEl8; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9e4HEl8"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48a3989641cso1890659137.1
        for <selinux@vger.kernel.org>; Tue, 11 Jun 2024 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130393; x=1718735193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1ZX2dwO/XFopfPd3VxzT04aHtQ+gd0CiyJxe3NG54M=;
        b=c9e4HEl8riBtinZhTpNkp3vAZLjlZcHuu4m+1xXMBSyoWwe1deGAR/a4+76dJbdjIt
         87u60FUeLPwObdn50MEyFkTlXS+Ldm8inFmN73gTvO6F+RdZP+fvPsoLrJn2vAJwH7xb
         d1R7H187CNK8Urphs70YehPfUBi0a44hOdaGQdFnSdLoYZPI/vG+1UrADHu3ajRlUTY3
         Ga5fCChUfmI0Aqt4OFGnDXp5RfQj2JFo3par6le6he0/R9rslYTGYPZ4nY5L9QHzIese
         YAB6uNI/wiZtoC8N6VzQbiryz+Zq3FvSLTXYL/X0wcbCXLQ8kO0tKD5Nk/ccB3wrJ5DQ
         jaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130393; x=1718735193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1ZX2dwO/XFopfPd3VxzT04aHtQ+gd0CiyJxe3NG54M=;
        b=E3jBI01fbMlugp7ITAC1X0ByuFgGYCsQPZr5CeS++MBbF5IAmrGqOY4Jntj2TS4w7E
         M6uio8CAnzKNdhuTwEYw+9RycQX8XplKleIWLJkLlXibi9cM3oc8rHFihclms8Ypri6h
         PNcX9kj/4YzkNf+EEoUEJhwtZvq1OqqRPhKckBy5/hL0Ncb1y0v31nM1DRdaiLee+SK5
         7NN7bPXrS5ocnyKtj/smNCZt9v7p6RKlxpfOaKNNEYANY9B+PmDW7Ql4sH7+gJzzwxqW
         AiZeIQn+4djG/Y2UoqLlJBHWTuAm3I+lTF7i9rcxgUxCOxZNbxYIkj9aC/PSthIdJ0R4
         nGAg==
X-Gm-Message-State: AOJu0YxZ/hqZr1R/Pm6txYHC3SviK4R0rrR8rqJkZuf4xHUp6zIIXVVq
	qJegFK/XojqdnqYdT+0DsL0sEd4vKtuiQiZi5nsQ62dgiAPbnqgRs0h0LfDWdYYfQMizIA/L1WP
	UdozADNGPQitlmnpVnweW1uhq2LuFLWnp
X-Google-Smtp-Source: AGHT+IEXbKCKVU7da91DJ1tdRNuSbX2F37jxKRK+WmggvJexQnzPAOPVThRxipid9emY8NT85sDcnMWE2OEx++Y+jf8=
X-Received: by 2002:a05:6102:a08:b0:48c:38a6:85ed with SMTP id
 ada2fe7eead31-48c38a686b7mr10503107137.30.1718130393317; Tue, 11 Jun 2024
 11:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172142.138894-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240608172142.138894-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 11 Jun 2024 14:27:57 -0400
Message-ID: <CAP+JOzRvRn3kTeUKaN6ti921nMwJUJbDu4iW9JR7SnCt9J+wXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: move unchanged data out of loop
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:21=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Perform the lookup whether the class is in the current scope once, and
> not for every permission.
> This also ensures the class is checked to be in the current scope if
> there are no permissions attached.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/link.c | 38 ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index b8272308..a6f2a251 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -1925,7 +1925,7 @@ static int find_perm(hashtab_key_t key, hashtab_dat=
um_t datum, void *varg)
>   * Note that if a declaration had no requirement at all (e.g., an ELSE
>   * block) this returns 1. */
>  static int is_decl_requires_met(link_state_t * state,
> -                               avrule_decl_t * decl,
> +                               const avrule_decl_t * decl,
>                                 struct missing_requirement *req)
>  {
>         /* (This algorithm is very unoptimized.  It performs many
> @@ -1933,9 +1933,9 @@ static int is_decl_requires_met(link_state_t * stat=
e,
>          * which symbols have been verified, so that they do not need
>          * to be re-checked.) */
>         unsigned int i, j;
> -       ebitmap_t *bitmap;
> -       char *id, *perm_id;
> -       policydb_t *pol =3D state->base;
> +       const ebitmap_t *bitmap;
> +       const char *id, *perm_id;
> +       const policydb_t *pol =3D state->base;
>         ebitmap_node_t *node;
>
>         /* check that all symbols have been satisfied */
> @@ -1961,27 +1961,25 @@ static int is_decl_requires_met(link_state_t * st=
ate,
>         }
>         /* check that all classes and permissions have been satisfied */
>         for (i =3D 0; i < decl->required.class_perms_len; i++) {
> +               const class_datum_t *cladatum =3D pol->class_val_to_struc=
t[i];
> +               const scope_datum_t *scope;
> +
> +               bitmap =3D &decl->required.class_perms_map[i];
> +               id =3D pol->p_class_val_to_name[i];
> +
> +
> +               scope =3D hashtab_search(state->base->p_classes_scope.tab=
le, id);
> +               if (scope =3D=3D NULL) {
> +                       ERR(state->handle,
> +                               "Could not find scope information for cla=
ss %s",
> +                               id);
> +                       return -1;
> +               }
>
> -               bitmap =3D decl->required.class_perms_map + i;
>                 ebitmap_for_each_positive_bit(bitmap, node, j) {
>                         struct find_perm_arg fparg;
> -                       class_datum_t *cladatum;
>                         uint32_t perm_value =3D j + 1;
>                         int rc;
> -                       scope_datum_t *scope;
> -
> -                       id =3D pol->p_class_val_to_name[i];
> -                       cladatum =3D pol->class_val_to_struct[i];
> -
> -                       scope =3D
> -                           hashtab_search(state->base->p_classes_scope.t=
able,
> -                                          id);
> -                       if (scope =3D=3D NULL) {
> -                               ERR(state->handle,
> -                                   "Could not find scope information for=
 class %s",
> -                                   id);
> -                               return -1;
> -                       }
>
>                         fparg.valuep =3D perm_value;
>                         fparg.key =3D NULL;
> --
> 2.45.1
>
>
