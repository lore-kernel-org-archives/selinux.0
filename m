Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560FE249E5
	for <selinux@vger.kernel.org>; Tue, 11 Jun 2024 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130359; cv=none; b=WueGytOCJ6r1u0u5gfb8NcsdSb8Sj0L90UNHuWvqDlOgvx5pipr3OirsMRpIV5HxCIi+faxrP87HIdsulVzEn3e+z6KoW3KORTnMchSmAMWnsucm48I2lUk0JQrXQ+YO5czq7UOLjgHxP0pt4G2EnUQlUDjRS2YnazbLhKNqunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130359; c=relaxed/simple;
	bh=Wgo1dAJDge0MRIk0FPWox1ptqh9lKjJPVdWPjlgqE20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Et2M6Bvxh6UXvznxvDidCqAacfc9QuMmDSEA4iqUOZz9QMTkVA6AH/5k8qIATtpsJGRRyDGPBh3pQ8G14wWxtSPlb8mOzyHKQyu99j7Hz8TXH46ffelaABR/zTSTLmBZJZLKrg5BvLKZcN/Gs1XkCf1Gu5BHvbrTXkdjzeOxqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZHocSgX; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZHocSgX"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-80ae49954d3so1518371241.1
        for <selinux@vger.kernel.org>; Tue, 11 Jun 2024 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130357; x=1718735157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoZRY1vnie/n0RlxPBvb+SSCf8FCqlnPW6PLAX91/QM=;
        b=nZHocSgX3mTT5UsIBUhbAnFZoNAVDz4SXicrHTRbtp/ZGc/1YKnjrAD/6ce+MyRRFF
         c9PgfgOYGdHXosLkHy/GgGXPrtw5TSs42cqV3SC4nTqmiuTlWRBoPHesDw4U0umxotmk
         YvOPoUFykxd3pxgR/LfQXzxh+Jq1eY10Hjw4CiLmTZi0QH6//cXcUlsoZUlFr9G1Uw36
         EWWTSyLJWxkboqs/sdKIS7JYGwyTyoGcHFvZHK9gB60JykUpyuByaGm90HpL39mWOAGi
         IMO95f3ju/LiIUa2n/PJ08XI2/B4Bt9/edz94iGAs1FdSWBdmV1m2NJrpJNujtjGjRIb
         XMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130357; x=1718735157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoZRY1vnie/n0RlxPBvb+SSCf8FCqlnPW6PLAX91/QM=;
        b=K6IAZP+9hrHfF+KbRMCnYMDgfRMhFtx7FgSmpJ+YWrjW8XfkVpVXS+VLvXfRF6rM0S
         lEs4Rp0MgInZfMSuE06o7Ka6y+fN0vAvznhK6EbmIc8HrAMamMu8nrAwV+9b/W/ISvPj
         ipcKbWahH4n9P801LJ175DjN6RkHUIn3Oj6dJ6hVE8UNM7Polh4ucDlX1/wxbzicoWGK
         4vwBKv7b8KIAnDtcfYYZ0qxJyit/y9H7wbewDkDOKkYaPCWU6lTvl9yK/jCtlfXEOD/1
         HkTIeNCIJLvM6nthvduH8pvhYmmaCCkuGmu95+QUyIrDtdxRAJpUIHy3vjR1J6lawjyk
         632w==
X-Gm-Message-State: AOJu0Yz1ifvCQzEBGcAJYSUYb3rOq6wXD4BNhmADVJh48hTKFdB7/qzw
	Bq1qayoxpYdUgYBBu5GcMQYPYxUXd8zsS/92fKVDbkXsDWkvN6v30zm1glo9I75yFjzpgnGJnZH
	4GIsonBwDi2rRm+Ps09Lx0TdBv0RUOQ==
X-Google-Smtp-Source: AGHT+IEFdGHfVqCy9vhrM4N3lGTFgO3+PJaDQheMYb4SqLEOcykQEDJ7JxxRwzOwZ8cdTQrRVayxWXbv9ZJy+jFJ9rQ=
X-Received: by 2002:a67:fd53:0:b0:48c:3c3a:55a4 with SMTP id
 ada2fe7eead31-48c3c3a578cmr8303332137.35.1718130357266; Tue, 11 Jun 2024
 11:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172142.138894-1-cgoettsche@seltendoof.de> <20240608172142.138894-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240608172142.138894-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 11 Jun 2024 14:27:19 -0400
Message-ID: <CAP+JOzSOa4DRcZprPSMmY0FKUaVrqfdRgO6v_LVWs1ke=LXtbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: rework permission enabled check
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 1:22=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Check the class is defined once, and not for every permission via
> is_perm_enabled(). Also pass the class datum to avoid an unnecessary
> name lookup.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  .../include/sepol/policydb/avrule_block.h     |  4 +--
>  libsepol/src/avrule_block.c                   | 27 +++++++------------
>  libsepol/src/link.c                           |  6 ++++-
>  3 files changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/avrule_block.h b/libsepol/in=
clude/sepol/policydb/avrule_block.h
> index 27047d43..18a1dc78 100644
> --- a/libsepol/include/sepol/policydb/avrule_block.h
> +++ b/libsepol/include/sepol/policydb/avrule_block.h
> @@ -35,8 +35,8 @@ extern avrule_decl_t *get_avrule_decl(policydb_t * p, u=
int32_t decl_id);
>  extern cond_list_t *get_decl_cond_list(policydb_t * p,
>                                        avrule_decl_t * decl,
>                                        cond_list_t * cond);
> -extern int is_id_enabled(char *id, policydb_t * p, int symbol_table);
> -extern int is_perm_enabled(char *class_id, char *perm_id, policydb_t * p=
);
> +extern int is_id_enabled(const char *id, const policydb_t * p, int symbo=
l_table);
> +extern int is_perm_existent(const class_datum_t *cladatum, const char *p=
erm_id);
>
>  #ifdef __cplusplus
>  }
> diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
> index dcfce8b8..547021e9 100644
> --- a/libsepol/src/avrule_block.c
> +++ b/libsepol/src/avrule_block.c
> @@ -152,11 +152,11 @@ cond_list_t *get_decl_cond_list(policydb_t * p, avr=
ule_decl_t * decl,
>   * marked as SCOPE_DECL, and any of its declaring block has been enabled=
,
>   * then return 1.  Otherwise return 0. Can only be called after the
>   * decl_val_to_struct index has been created */
> -int is_id_enabled(char *id, policydb_t * p, int symbol_table)
> +int is_id_enabled(const char *id, const policydb_t * p, int symbol_table=
)
>  {
> -       scope_datum_t *scope =3D
> +       const scope_datum_t *scope =3D
>             (scope_datum_t *) hashtab_search(p->scope[symbol_table].table=
, id);
> -       avrule_decl_t *decl;
> +       const avrule_decl_t *decl;
>         uint32_t len;
>
>         if (scope =3D=3D NULL) {
> @@ -189,21 +189,14 @@ int is_id_enabled(char *id, policydb_t * p, int sym=
bol_table)
>         return 0;
>  }
>
> -/* Check if a particular permission is present within the given class,
> - * and that the class is enabled.  Returns 1 if both conditions are
> - * true, 0 if neither could be found or if the class id disabled. */
> -int is_perm_enabled(char *class_id, char *perm_id, policydb_t * p)
> +/* Check if a particular permission is present within the given class.
> + * Whether the class is enabled is NOT checked.
> + * Returns 1 if both conditions are true,
> + * 0 if neither could be found or if the class id disabled. */

It returns 0 only if the permission is not found.

Everything else looks good to me.
Thanks,
Jim


> +int is_perm_existent(const class_datum_t *cladatum, const char *perm_id)
>  {
> -       class_datum_t *cladatum;
> -       perm_datum_t *perm;
> -       if (!is_id_enabled(class_id, p, SYM_CLASSES)) {
> -               return 0;
> -       }
> -       cladatum =3D
> -           (class_datum_t *) hashtab_search(p->p_classes.table, class_id=
);
> -       if (cladatum =3D=3D NULL) {
> -               return 0;
> -       }
> +       const perm_datum_t *perm;
> +
>         perm =3D hashtab_search(cladatum->permissions.table, perm_id);
>         if (perm =3D=3D NULL && cladatum->comdatum !=3D 0) {
>                 /* permission was not in this class.  before giving
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index a6f2a251..9281a986 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -1968,6 +1968,10 @@ static int is_decl_requires_met(link_state_t * sta=
te,
>                 id =3D pol->p_class_val_to_name[i];
>
>
> +               if (!is_id_enabled(id, state->base, SYM_CLASSES)) {
> +                       return 0;
> +               }
> +
>                 scope =3D hashtab_search(state->base->p_classes_scope.tab=
le, id);
>                 if (scope =3D=3D NULL) {
>                         ERR(state->handle,
> @@ -1994,7 +1998,7 @@ static int is_decl_requires_met(link_state_t * stat=
e,
>                         perm_id =3D fparg.key;
>
>                         assert(perm_id !=3D NULL);
> -                       if (!is_perm_enabled(id, perm_id, state->base)) {
> +                       if (!is_perm_existent(cladatum, perm_id)) {
>                                 if (req !=3D NULL) {
>                                         req->symbol_type =3D SYM_CLASSES;
>                                         req->symbol_value =3D i + 1;
> --
> 2.45.1
>
>
