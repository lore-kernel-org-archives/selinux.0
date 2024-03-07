Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA2136989
	for <selinux@vger.kernel.org>; Thu,  7 Mar 2024 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844802; cv=none; b=TUAO/gvwcNMmShrKND4KGjQ2AUidb+rgNZq1PSS8c/COMJoZ+4qAYlTykdZJGNkgJvfOhDjgDy3zqs068qWKFF5FKiToALMgIE/IzBYtlXz+JPbWGFqBCFQCikbX0SgWuqEYP2sVUg4bRXGi0jThb5p5A3PCrreDqK266wPS46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844802; c=relaxed/simple;
	bh=hlcWpHdg3HVGkXhgYK01eUcBGSJbZz2AfrvF687E8Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUxQEC59+5nwLWEshA8IicIidOw2l40RltL9Qe+eQXhGlPb+m8V0A+aUYLOwaMppQxqIqUYAY7STZuXAuCrWyWeGPY3T2Sf3qOD89qQaCo3HGP92RZEGmkLeEcWPgvnUzZxSRoibNU56iT4oYQNV5oNokyqBLhj9pFzbRregHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAacpSr2; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAacpSr2"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7db797c5c93so124119241.0
        for <selinux@vger.kernel.org>; Thu, 07 Mar 2024 12:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709844800; x=1710449600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2dDuPGAQpKhzMRpU0vtdFaxdjy3I2kwlgMg3AJcFQ0=;
        b=OAacpSr2aoFRjc0ZBXZYpftLCOex4egT+YntqXprh/DSN0VexwWJXRxfN5/Rat75gD
         PZ5NfnT2wz9v8i5lgOczRzPK/SPyttH6Q5KIVO1zwFTzLF1wPAlFfs25cwcjMfwb/o/7
         dJk0A3lT09I2ahAfIASwrsHMtL3v0X0kJ5p6qB9bmwPaW8tC7iXUo8b6nVMJjdlF/hS7
         JDsWGHSLmTZGU0MhMRrNdqvxEaS+C3YSuBgDjMKX9PAV/3LHgYNQbbK2AyO0APpVVsJI
         f2LFkknLrySmpyYtUyFQC8CXRyz9bBBH7t0Qv7dztMe5vNSe2jhZYc2W7ZNtjYRgdNHs
         Kr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709844800; x=1710449600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2dDuPGAQpKhzMRpU0vtdFaxdjy3I2kwlgMg3AJcFQ0=;
        b=hfOduvq+JZp3YD4IVmgjzmFp4vJn/jlp6WqtoBsD15McAQO3yLuuUXCFoRfUMQ5gaK
         nroY9vLKCdgIqt6U4zH/5i1vhetwo1HOEclkQ4pW0/27sFvfKo8ExGHbsNPAr+ed7hEd
         hOFh6jz4xgb0psBbDwyxlyE9/2Pogqck6QJ2Go5ge9xttmmkTYWBYN2ZvP7B2dGXhO+4
         p+NT4jlqP4+sUs593dOd7Ij94+tVuUK0QjPf9d4CfEhPlVehE3BIqqJJQbkAYhoUU47I
         Vq1M3GQwzeERFqxnjsUBrfuIr4ctAIROSTZsoyEWf9gtKhV1C48ZaFbn07JLZWXMAngd
         k/NQ==
X-Gm-Message-State: AOJu0YxAdDQmPmg5HuuyyLchZ3LLSmm8tyQyjARE/zEKNnZPiJMzkwXv
	L6kbpkFZWkwA8vAzoW6KBzBiySRuF/t0iJ2RAgjxQ5eXTz3etCp3S533PxUhTkOS6oKtN1S1piN
	m/MM+2LbDq1Nf592cwlvV3PRp3cw=
X-Google-Smtp-Source: AGHT+IFdomvKPyerB5lGCGdoE9WD1Ah8tIC/ezftMBAbZcCwodxHP6+ZC4NByH03ZfhkJyoF4c4TFStKt0FHyamWUO4=
X-Received: by 2002:a67:f593:0:b0:472:fefe:e66e with SMTP id
 i19-20020a67f593000000b00472fefee66emr2906129vso.35.1709844800147; Thu, 07
 Mar 2024 12:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131130840.48155-1-cgzones@googlemail.com> <20240131130840.48155-6-cgzones@googlemail.com>
In-Reply-To: <20240131130840.48155-6-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 7 Mar 2024 15:53:09 -0500
Message-ID: <CAP+JOzTRKU8H3Ty0vmNQmLZkL-ZR5czmbbxnKWMJProT3kcT-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/9] libselinux: sidtab updates
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 8:18=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add sidtab_context_lookup() to just lookup a context, not inserting
> non-existent ones.
>
> Tweak sidtab_destroy() to accept a zero'ed struct sidtab.
>
> Remove redundant lookup in sidtab_context_to_sid() after insertion by
> returning the newly created node directly from sidtab_insert().
>
> Drop declaration of only internal used sidtab_insert().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>   add patch
> ---
>  libselinux/src/avc_sidtab.c | 55 +++++++++++++++++++++----------------
>  libselinux/src/avc_sidtab.h |  2 +-
>  2 files changed, 32 insertions(+), 25 deletions(-)
>
> diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
> index 9475dcb0..3d347cea 100644
> --- a/libselinux/src/avc_sidtab.c
> +++ b/libselinux/src/avc_sidtab.c
> @@ -44,28 +44,23 @@ int sidtab_init(struct sidtab *s)
>         return rc;
>  }
>
> -int sidtab_insert(struct sidtab *s, const char * ctx)
> +static struct sidtab_node *
> +sidtab_insert(struct sidtab *s, const char * ctx)
>  {
>         unsigned hvalue;
> -       int rc =3D 0;
>         struct sidtab_node *newnode;
>         char * newctx;
>
> -       if (s->nel >=3D UINT_MAX - 1) {
> -               rc =3D -1;
> -               goto out;
> -       }
> +       if (s->nel >=3D UINT_MAX - 1)
> +               return NULL;
>
>         newnode =3D (struct sidtab_node *)avc_malloc(sizeof(*newnode));
> -       if (!newnode) {
> -               rc =3D -1;
> -               goto out;
> -       }
> +       if (!newnode)
> +               return NULL;
>         newctx =3D strdup(ctx);
>         if (!newctx) {
> -               rc =3D -1;
>                 avc_free(newnode);
> -               goto out;
> +               return NULL;
>         }
>
>         hvalue =3D sidtab_hash(newctx);
> @@ -73,8 +68,25 @@ int sidtab_insert(struct sidtab *s, const char * ctx)
>         newnode->sid_s.ctx =3D newctx;
>         newnode->sid_s.id =3D ++s->nel;
>         s->htable[hvalue] =3D newnode;
> -      out:
> -       return rc;
> +       return newnode;
> +}
> +
> +const struct security_id *
> +sidtab_context_lookup(const struct sidtab *s, const char *ctx)
> +{
> +       unsigned hvalue;
> +       const struct sidtab_node *cur;
> +
> +       hvalue =3D sidtab_hash(ctx);
> +
> +       cur =3D s->htable[hvalue];
> +       while (cur !=3D NULL && strcmp(cur->sid_s.ctx, ctx))
> +               cur =3D cur->next;
> +
> +       if (cur =3D=3D NULL)
> +               return NULL;
> +
> +       return &cur->sid_s;
>  }
>
>  int
> @@ -82,27 +94,23 @@ sidtab_context_to_sid(struct sidtab *s,
>                       const char * ctx, security_id_t * sid)
>  {
>         unsigned hvalue;
> -       int rc =3D 0;
>         struct sidtab_node *cur;
>
>         *sid =3D NULL;
>         hvalue =3D sidtab_hash(ctx);
>
> -      loop:
>         cur =3D s->htable[hvalue];
>         while (cur !=3D NULL && strcmp(cur->sid_s.ctx, ctx))
>                 cur =3D cur->next;
>
>         if (cur =3D=3D NULL) {      /* need to make a new entry */
> -               rc =3D sidtab_insert(s, ctx);
> -               if (rc)
> -                       goto out;
> -               goto loop;      /* find the newly inserted node */
> +               cur =3D sidtab_insert(s, ctx);
> +               if (cur =3D=3D NULL)
> +                       return -1;
>         }
>
>         *sid =3D &cur->sid_s;
> -      out:
> -       return rc;
> +       return 0;
>  }
>

This duplicates the sidtab_context_lookup() code above, so why not
just use that. If that returns NULL, then insert the context.

Thanks,
Jim


>  void sidtab_sid_stats(const struct sidtab *s, char *buf, size_t buflen)
> @@ -138,7 +146,7 @@ void sidtab_destroy(struct sidtab *s)
>         int i;
>         struct sidtab_node *cur, *temp;
>
> -       if (!s)
> +       if (!s || !s->htable)
>                 return;
>
>         for (i =3D 0; i < SIDTAB_SIZE; i++) {
> @@ -149,7 +157,6 @@ void sidtab_destroy(struct sidtab *s)
>                         freecon(temp->sid_s.ctx);
>                         avc_free(temp);
>                 }
> -               s->htable[i] =3D NULL;
>         }
>         avc_free(s->htable);
>         s->htable =3D NULL;
> diff --git a/libselinux/src/avc_sidtab.h b/libselinux/src/avc_sidtab.h
> index e823e3f3..f62fd353 100644
> --- a/libselinux/src/avc_sidtab.h
> +++ b/libselinux/src/avc_sidtab.h
> @@ -24,8 +24,8 @@ struct sidtab {
>  };
>
>  int sidtab_init(struct sidtab *s) ;
> -int sidtab_insert(struct sidtab *s, const char * ctx) ;
>
> +const struct security_id * sidtab_context_lookup(const struct sidtab *s,=
 const char *ctx);
>  int sidtab_context_to_sid(struct sidtab *s,
>                           const char * ctx, security_id_t * sid) ;
>
> --
> 2.43.0
>
>
