Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498B53E3B
	for <selinux@vger.kernel.org>; Mon, 26 Feb 2024 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965210; cv=none; b=PkPLisyvngWE02T7RU3wa+qzI0p6LPkiAedp3vWWDV0Txss1BeEKlXbDHvkG9BZrwmJUEuUoeydxR4hPfy7gC/JuHxk5sMLlZWuIYvCkWa0wGmaRm4Y0z8ho38vIv1gT16CP8OCKeAHd4Mu2UuOGK0ntyPRVf4X5Rrkps0GpCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965210; c=relaxed/simple;
	bh=pJvO8vvnZZGgG/5lOdtqriziIiTQdn8TZRRtGfAPFhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hazQOocxUqRKcsWFEH5XA/SOkF0+rJQC+p+OPt6XxhDUNvLW0IUq5vbR09GO+FQR7dxT97FHSOQ3mShSHg80J5cZDhscHb86VnClsNaunAEVlRCeLah3+cjyI2tM4vrq4wKfrl3ZwZ/FxR6IOug0Ps1HD2+ZUu9LER941oNB/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=A9bLf0u/; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="A9bLf0u/"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-608841dfcafso28480867b3.2
        for <selinux@vger.kernel.org>; Mon, 26 Feb 2024 08:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708965207; x=1709570007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d4gjOSJvpiRXnuajEbWOWldvqaD+PToBKzWCKCkbErY=;
        b=A9bLf0u/jgSfXhAu5+iPYW+H59H8e19GnCn2sV2lHfZeuHiBTqBF7Bw5bjbQRAWr0Q
         O4bV2QaesxLGi5WTo8fw4YLhEDiBZ7zKcaGn41v//15CtBnIh+5pDq6EjY4o5LMbS43p
         CBdMgZlSnGFbh+xsklyW4TJdGkoNkj/URLOcBAoN4qt6xMO2HSfqaQuKKsASyFf7Kz2C
         /R8L6g45A+YwFAkzZgoyJzN5yhQCo6PK/XbIQeqHZyA7BJ7XNsgtDpgsgvarZSGI/9sO
         N/AMoxHVFxm+2tIlvlLXZFYiT6GKa1MC4uJ0kFxEinvIgN1TYBMtjlcF1YNzAuKTdKJd
         m2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708965207; x=1709570007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4gjOSJvpiRXnuajEbWOWldvqaD+PToBKzWCKCkbErY=;
        b=NbZL5stCkZg1Hlyn6IpZKVbJckAnLcQxWsIouJjZlL0caVDBZlyhYkMcFIL+ZRVpLX
         QkzCDbnnZEod9AJtCYX2HpBPXKzs2hX6QORpX/AVBx73QzG6uurlYVpZoAagEMD5i6BO
         hPQiv96c7BR5ZkpM/7HOjo9RaOW7rs575birEltkxW5duU0aPk14VqnPO42bfhHb4ObO
         BRE3GfWcSXM5EthrzraRgipH2YMjzZX0X+9euQk548s86C7+0gs/H8MdCdygCDpbQ6do
         sw0+eqkIvONJT1ZICd85UuaRXs+Pkq6vuYzErd9JOHyjRI8ZUToCqyxQdbOlHyu+ueUk
         sA3g==
X-Gm-Message-State: AOJu0Yy5lTWokY/UdvfVbJ2iKKeClpMwu2Yi1de/CgyCm8AoKcs05k8K
	wrW7GB0qKgjAbjo0GA5Bp4EJpq8+4f2qjxdyCs4wDW9kesALzCCgMF2MNUyZRAizXNfg5T7MvyE
	mem+vWZ06CJgd2eN78t6XFMyyQ40=
X-Google-Smtp-Source: AGHT+IGTsRHUP9IO5MSbvnjZdrHpTG8q05NsuIf3zJloL8o8jC9Uk76VdS8bEcDfd9tUxHq3iQgue5JePw5BwnfWsnQ=
X-Received: by 2002:a0d:eb16:0:b0:608:8b1e:cee with SMTP id
 u22-20020a0deb16000000b006088b1e0ceemr7684949ywe.25.1708965207316; Mon, 26
 Feb 2024 08:33:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210759.1310310-1-jwcart2@gmail.com>
In-Reply-To: <20240221210759.1310310-1-jwcart2@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 26 Feb 2024 17:33:16 +0100
Message-ID: <CAJ2a_DcNB7nd2OejzukWiWKa+zpCitXzx1GMs0Ei0dszZYUG4Q@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy, libsepol: Fix potential double free of mls_level_t
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 22:08, James Carter <jwcart2@gmail.com> wrote:
>
> In checkpolicy, a sensitivity that has one or more aliases will
> temporarily share the mls_level_t structure with its aliases until
> a level statement is processed for the sensitivity (or one of the
> aliases) and the aliases are updated to have their own mls_level_t
> structure. If the policydb is destroyed while they are sharing the
> mls_level_t structure, then a double free of the shared mls_level_t
> will occur. This does not currently occur only because checkpolicy
> does very little clean-up before exiting.
>
> The "defined" field of the level_datum_t is set after a level
> statement is processed for a sensitivity and its aliases. This means
> that we know an alias has its own mls_level_t if the "defined" field
> is set. The double free can be avoided by not destroying the
> mls_leve_t structure for an alias unless the "defined" field is set.
>
> Since the "defined" field is only set to false while the mls_level_t
> structure is being shared, it would be clearer to rename the field
> as "notdefined". It would only be set during the time the sensitivity
> and its aliases are sharing the mls_level_t structure. Outside of
> checkpolicy, the "notdefined" field will always be set to 0.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v2: Change the field name from "defined" to "notdefined" and change
>     the logic to match.

Thanks, in my opinion this is a much nicer approach.

Maybe check in libsepol/src/policydb_validate.c:validate_level_datum()
that notdefined is FALSE?

>  checkpolicy/checkpolicy.c                  |  7 +++----
>  checkpolicy/policy_define.c                | 10 ++++++----
>  libsepol/cil/src/cil_binary.c              |  3 ---
>  libsepol/include/sepol/policydb/policydb.h |  2 +-
>  libsepol/src/policydb.c                    |  6 ++++--
>  5 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index fcec6e51..d7cafaa4 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -370,10 +370,9 @@ static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg __att
>  {
>         level_datum_t *levdatum = (level_datum_t *) datum;
>
> -       if (!levdatum->isalias && !levdatum->defined) {
> -               fprintf(stderr,
> -                       "Error:  sensitivity %s was not used in a level definition!\n",
> -                       key);
> +       if (!levdatum->isalias && levdatum->notdefined) {
> +               fprintf(stderr, "Error:  sensitivity %s was not used in a level definition!\n",
> +                               key);
>                 return -1;
>         }
>         return 0;
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 260e609d..ac215086 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -743,6 +743,7 @@ int define_sens(void)
>         level_datum_init(datum);
>         datum->isalias = FALSE;
>         datum->level = level;
> +       datum->notdefined = TRUE;
>
>         ret = declare_symbol(SYM_LEVELS, id, datum, &value, &value);
>         switch (ret) {
> @@ -780,6 +781,7 @@ int define_sens(void)
>                 level_datum_init(aliasdatum);
>                 aliasdatum->isalias = TRUE;
>                 aliasdatum->level = level;
> +               aliasdatum->notdefined = TRUE;
>
>                 ret = declare_symbol(SYM_LEVELS, id, aliasdatum, NULL, &value);
>                 switch (ret) {
> @@ -1006,9 +1008,10 @@ static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum
>         mls_level_t *level = (mls_level_t *) arg, *newlevel;
>
>         if (levdatum->level == level) {
> -               levdatum->defined = 1;
> -               if (!levdatum->isalias)
> +               if (!levdatum->isalias) {
> +                       levdatum->notdefined = FALSE;
>                         return 0;
> +               }
>                 newlevel = (mls_level_t *) malloc(sizeof(mls_level_t));
>                 if (!newlevel)
>                         return -1;
> @@ -1017,6 +1020,7 @@ static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum
>                         return -1;
>                 }
>                 levdatum->level = newlevel;
> +               levdatum->notdefined = FALSE;
>         }
>         return 0;
>  }
> @@ -1057,8 +1061,6 @@ int define_level(void)
>         }
>         free(id);
>
> -       levdatum->defined = 1;
> -
>         while ((id = queue_remove(id_queue))) {
>                 cat_datum_t *cdatum;
>                 int range_start, range_end, i;
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index a8e3616a..95bd18ba 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -907,7 +907,6 @@ static int cil_sensalias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alia
>                 goto exit;
>         }
>         sepol_alias->level = mls_level;
> -       sepol_alias->defined = 1;
>         sepol_alias->isalias = 1;
>
>         return SEPOL_OK;
> @@ -3163,8 +3162,6 @@ int cil_sepol_level_define(policydb_t *pdb, struct cil_sens *cil_sens)
>                 }
>         }
>
> -       sepol_level->defined = 1;
> -
>         return SEPOL_OK;
>
>  exit:
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
> index 6682069e..66d93999 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -217,7 +217,7 @@ typedef struct user_datum {
>  typedef struct level_datum {
>         mls_level_t *level;     /* sensitivity and associated categories */
>         unsigned char isalias;  /* is this sensitivity an alias for another? */
> -       unsigned char defined;
> +       unsigned char notdefined;

Maybe add a small comment that it's only used as an optimization in
checkpolicy and is 0 for fully parsed or generated policies?

>  } level_datum_t;
>
>  /* Category attributes */
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index f10a8a95..0c23a7a2 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1390,8 +1390,10 @@ static int sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
>         if (key)
>                 free(key);
>         levdatum = (level_datum_t *) datum;
> -       mls_level_destroy(levdatum->level);
> -       free(levdatum->level);
> +       if (!levdatum->isalias || !levdatum->notdefined) {
> +               mls_level_destroy(levdatum->level);
> +               free(levdatum->level);
> +       }
>         level_datum_destroy(levdatum);
>         free(levdatum);
>         return 0;
> --
> 2.43.0
>
