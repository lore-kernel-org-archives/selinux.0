Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF413DDD9
	for <selinux@vger.kernel.org>; Thu, 15 Feb 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022496; cv=none; b=E043H79oG+i/eK7wdPAK6dugH+jIHDiiXUhHmO3ghM66+b7gynWsGNSAKuP7uVqAIKOD7MXZFsgZA1EKPnsM3lE2ge2E7FOX374YiXfgChatn7RonKknanYbr2IKJWl94YOaRz0WnAJes5cluSczXukCrcHdZuFQygPGnsu25ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022496; c=relaxed/simple;
	bh=cTk9sf5TlU71O3IlTKaYQ0BMfi6luC/sn5i3xEKNoQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrFKPps0YL+N8Cr01xymF++76WcPI6X/ijnG49QTXGJ/z6YwdILlgh3kd+0wKhv0NCNCJlSdSdJRWjZSmuHUwb1M2hKRxpUyAtlsJ/+Dt81kDUQw6Vnm8bPRPx5g9IeGk3f6oEhgTD3P5H8NEbnKCNZetlvMjRmvCaF01cnklyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lEG99ksW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lEG99ksW"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60495209415so12527237b3.3
        for <selinux@vger.kernel.org>; Thu, 15 Feb 2024 10:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708022493; x=1708627293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CwUJShXq7XURZTvCJwNdc3OzbzaIKs1Vn0oVwZhBvlQ=;
        b=lEG99ksWyV3LMcDJZVP/3IUFTdmWd9hnwnvM+ZFDXGh3OKGH2neiNN7BjXXYX/9AZ6
         C3Aqx24EkNVWzMmsi3oLQiFjVm872FsFwctbDD8eza0OFwWWI+JcxaVMRIJc1h0zGepf
         qgRr6Zo+xbCMdknxEvikUqKkrNqrs4pMGWHIljr34UtFnlA1/vwP8j2B1AdodncFDkbH
         eCwKGLJP35O2QeRmkF/BFp4ZDktdO35r23lFYo/DcmgRZiO1dAraY3zzFCW/9kiNp4Kr
         mXEpb7zcse0bi1ATwWnsXronWDYSkyaJlATLDEMBzkFJxgV1yiLPdRAK7SMQmPEiPGGH
         RZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708022493; x=1708627293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwUJShXq7XURZTvCJwNdc3OzbzaIKs1Vn0oVwZhBvlQ=;
        b=kFdkzxt4YUCwsA/wrK0okDgnQC+7a++jCniC2v135T6Mmygbfsa6EhaWefrtobbB8L
         pPkapRY/WKm8ppVVDnF3EXzBkDvkrZwYfAx/ffYGRpku8kOkWeupG2kAVb4fxM1/hvyb
         LopJUrpumvCkLTl/HX4pLO2+yZrxWw+DS94n/cDaYScXn8rhzlt5HU5UABxnrB/VDG6i
         +S1u10WrDGls2vzSmapzXTcyenwZAwV3XqmwPu50QXmfjTNjGkk9DMq9L3KmSY7ej6X2
         WGnkteA6X4hNppzfFRRjDPTybkf2TxhT29wBN1idjQc4tYZ2q1FJxS/W90bpJkW8+ZWs
         sm2w==
X-Gm-Message-State: AOJu0YzEfr2wuzaR7IsZU/sK8e6mfQtdxxNMn/pXa0WKSyJIIeEur3Ko
	vsU8UVH7iC12M0MEIX5uHgOvwjjHaDAjEbPLc7Iei8NQo+BEdb5jW6If12g8980cC3mLoEENXKF
	VHKQTejOTt1FxtQF+pQ90utmQORWVoqTPSbE=
X-Google-Smtp-Source: AGHT+IHWy5J1wwVgG+Trf+C83OocV5axfazFqyfoK7/tS48jBXLR6cwA4E0FL41BzUilDwmaanXaZPNjgryfCL09/18=
X-Received: by 2002:a0d:db08:0:b0:607:7e98:763b with SMTP id
 d8-20020a0ddb08000000b006077e98763bmr2622504ywe.12.1708022493515; Thu, 15 Feb
 2024 10:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213205605.830719-1-jwcart2@gmail.com>
In-Reply-To: <20240213205605.830719-1-jwcart2@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 15 Feb 2024 19:41:22 +0100
Message-ID: <CAJ2a_Dfj7kLxm1JKKZXjqD7cfdamDoW0pDXqyNBtJaHi_5bxbg@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy, libsepol: Fix potential double free of mls_level_t
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 21:56, James Carter <jwcart2@gmail.com> wrote:
>
> In checkpolicy, sensitivities that have aliases will temporarily
> share the mls_level_t structure until a level statement defines the
> categories for the level and the alias is updated to have its own
> mls_level_t structure. Currently, this does not cause a problem
> because checkpolicy does very little clean-up before exiting when
> an error is detected. But if the policydb is destroyed before exiting
> due to an error after a sensitivity and its alias is declared, but
> before a level statement involving either of them, then a double
> free of the shared mls_level_t will occur.
>
> The defined field of the level_datum_t is set after a level statement
> is processed for the level_datum_t. This means that we know the alias
> has its own mls_level_t if the defined field is set. This means that
> the defined field can be used to determine whether or not the
> mls_level_t pointed to by an alias level_datum_t should be destroyed.
>
> Since the defined field is not set when reading or expanding a policy,
> update libsepol to set the defined field.

I tried to avoid touching anything related to the `defined` member in
the checkpolicy patchset, since my plan was to remove the member in a
couple months, when the fuzzer has verified it is redundant after the
new member `copy` was introduced.
Currently the member `defined` is only checked once in the entire code
base: in a sanity check in checkpolicy that I never saw triggered.
So it is unused during binary policy parsing and CIL policy
compilation (and also unnecessary for correct cleanup there, since the
two active fuzzers have not found any related use-after-free issue or
leak).
Thus my preference is to have in the end only the `copy` member from
my patch 10/15, which does not need to be set everywhere manually
since the default calloc'ed value of 0 is the correct default, and
it's only going to be used in three places:
libsepol/src/policydb.c:sens_destroy(),
checkpolicy/policy_define.c:define_sens() and
checkpolicy/policy_define.c:clone_level().

> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  checkpolicy/policy_define.c | 11 +++++++----
>  libsepol/src/expand.c       |  1 +
>  libsepol/src/policydb.c     |  7 +++++--
>  3 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 260e609d..542bb978 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1006,9 +1006,10 @@ static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum
>         mls_level_t *level = (mls_level_t *) arg, *newlevel;
>
>         if (levdatum->level == level) {
> -               levdatum->defined = 1;
> -               if (!levdatum->isalias)
> +               if (!levdatum->isalias) {
> +                       levdatum->defined = 1;
>                         return 0;
> +               }
>                 newlevel = (mls_level_t *) malloc(sizeof(mls_level_t));
>                 if (!newlevel)
>                         return -1;
> @@ -1017,6 +1018,7 @@ static int clone_level(hashtab_key_t key __attribute__ ((unused)), hashtab_datum
>                         return -1;
>                 }
>                 levdatum->level = newlevel;
> +               levdatum->defined = 1;
>         }
>         return 0;
>  }
> @@ -1057,8 +1059,6 @@ int define_level(void)
>         }
>         free(id);
>
> -       levdatum->defined = 1;
> -
>         while ((id = queue_remove(id_queue))) {
>                 cat_datum_t *cdatum;
>                 int range_start, range_end, i;
> @@ -1121,6 +1121,9 @@ int define_level(void)
>                 free(id);
>         }
>
> +       if (!levdatum->isalias)
> +               levdatum->defined = 1;
> +
>         if (hashtab_map
>             (policydbp->p_levels.table, clone_level, levdatum->level)) {
>                 yyerror("out of memory");
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index e63414b1..0e16c502 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1191,6 +1191,7 @@ static int sens_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>                 goto out_of_mem;
>         }
>         new_level->isalias = level->isalias;
> +       new_level->defined = 1;
>         state->out->p_levels.nprim++;
>
>         if (hashtab_insert(state->out->p_levels.table,
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index f10a8a95..0c950bf1 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1390,8 +1390,10 @@ static int sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
>         if (key)
>                 free(key);
>         levdatum = (level_datum_t *) datum;
> -       mls_level_destroy(levdatum->level);
> -       free(levdatum->level);
> +       if (!levdatum->isalias || levdatum->defined) {
> +               mls_level_destroy(levdatum->level);
> +               free(levdatum->level);
> +       }
>         level_datum_destroy(levdatum);
>         free(levdatum);
>         return 0;
> @@ -3357,6 +3359,7 @@ static int sens_read(policydb_t * p
>                 goto bad;
>
>         levdatum->isalias = le32_to_cpu(buf[1]);
> +       levdatum->defined = 1;
>
>         levdatum->level = malloc(sizeof(mls_level_t));
>         if (!levdatum->level || mls_read_level(levdatum->level, fp))
> --
> 2.43.0
>
