Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6158AB4
	for <selinux@vger.kernel.org>; Thu, 14 Mar 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422364; cv=none; b=aiBHQFF9Dmv8GFahhgXSb9wDOjH85vWfAh9ozgGochbUpDwJLYZNhCWGHyyDwB5/FuuvGFBau1CXD/uk2JgTsGXVy9PIF+Q9fi1NjqzPM26a7mGMH+lCf8QK8b33c+DK+vLsODVawYGJwDnfT+SmrXQvbp/5WXqm2B8KMKgEKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422364; c=relaxed/simple;
	bh=/FOdKgx1fqU16oij9TiXe/gckVl9X7JF7/pn+BFVXCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yd/Zf5iGi8rSgU6XvjmwTHnRBr3TRKN2w61AfCyl48fuqzLE6qwrtO7YvNpwJCNzuB7UV7BF8fb8D4AisuzaEy6GNHgTtbeFMu/VstuIVQRc1B504KOwQkXTOir31+/P8S9W7zVI9KZmmbobhoxhBRaswKVs+ERuTPlEJZzl3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9HxojU/; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9HxojU/"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so804287276.1
        for <selinux@vger.kernel.org>; Thu, 14 Mar 2024 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710422361; x=1711027161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb80toS0cyKHDMnjZwPrB9Rgv1aCjruop80aYwcTj0g=;
        b=D9HxojU/iGLELnY6ngdTV7kvGsiIxJkY3SBcmXsDhuQBv5KhALo/LkqMYIbJpy+w/Y
         RmSY5A8Z13hw5nLj5Ddaqq9UwpWF9ck9C8UHdX1UhGTsTn2jhS5kEEzA3Q5jvfFQlRTH
         HXnOb/R4ZzKUu5kWz4DPSWzkjAL1GLlS1igcFoxCpE8Xigs+D70KpAdaZEIVHdTrLK+n
         ydI/rYqD8la/HD1DVtH62f5eJRzQO7RpoI13Uro9lJzdPjpLvTQ/EajPdpeA2zLqyJrs
         UY6qFiPCn2shpUV0YqRYS8IMg1OhhB1UqX14NbDtsPM8PS9iX4sFJzUKVpdDN6hqe24V
         wHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710422361; x=1711027161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb80toS0cyKHDMnjZwPrB9Rgv1aCjruop80aYwcTj0g=;
        b=bfjs+VBI4m/YYDEKk4dMQHVqbopKgLtI8YWNbmt5Wxf9WRTQEKW1g34bbCw4B1chC8
         Ahdfjdq4A45Gyn8/AwqOOGP03RwFthEcWhgvOOmNQh8WTCaKCC8xgzMNGzuu8l+G46MW
         ORHHua2+N9sox62D4hm9G3tu2NlqBEV03FZSQGCoP3pBQh5npoLoDFfUe4Ixux625D2a
         Kvtu1YHRaxvJPCVKzamoPg+MoJ1Hk1iNBCKUozZlArWzHpvmZldXjcnA0XTzES+iAybC
         est4kY6JJl4XlBW9t7yKHwDXzLBhkTDXroyGJD2CCZEs6IonzyVqwz3HZOzsw3onGab8
         HUTg==
X-Gm-Message-State: AOJu0Yx/0Qj1fFsm3U8Nf972LQzLDcuLsa1h11FRHr6Kj5+fhFzlTWVb
	TjCpMYqY3lkjO3P/g0qFfCMe06VY4L5s9j3zCBP+NCASJBbb0pIOUCWqXcULzPbVFLAx7FBNWge
	HjAhGmGJsHSawobmK3X7agDVz5429nl342Oo=
X-Google-Smtp-Source: AGHT+IEWJEkE8za26yNoiqOqwc3sByUE6RvaVpB/EiXR3XNU2VtoFCqHquDsffBZh7ySl9vAWscUdsU6fUwBkuvMvy0=
X-Received: by 2002:a25:8142:0:b0:dc6:ddfc:1736 with SMTP id
 j2-20020a258142000000b00dc6ddfc1736mr1604593ybm.17.1710422361501; Thu, 14 Mar
 2024 06:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311145706.34885-1-cgzones@googlemail.com>
In-Reply-To: <20240311145706.34885-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 14 Mar 2024 09:19:10 -0400
Message-ID: <CAP+JOzQ7BspHg7ZMQs2WSJQ0RDdz=hjSB=DohU6KZvQhLOyG-g@mail.gmail.com>
Subject: Re: [PATCH 1/5] checkpolicy/fuzz: drop redundant notdefined check
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 10:59=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The level_datum_t member notdefined is checked to be 1 during validation
> and the fuzzer calls policydb_validate().
> Drop the redundant check (as announced in the TODO).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these 5 patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/fuzz/checkpolicy-fuzzer.c | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/che=
ckpolicy-fuzzer.c
> index a3da0b57..f3a17cce 100644
> --- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
> +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> @@ -130,21 +130,6 @@ static int read_source_policy(policydb_t *p, const u=
int8_t *data, size_t size)
>         return 0;
>  }
>
> -static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *a=
rg __attribute__ ((unused)))
> -{
> -       const level_datum_t *levdatum =3D (level_datum_t *) datum;
> -
> -       // TODO: drop member defined if proven to be always set
> -       if (!levdatum->isalias && levdatum->notdefined) {
> -               fprintf(stderr,
> -                       "Error:  sensitivity %s was not used in a level d=
efinition!\n",
> -                       key);
> -               abort();
> -       }
> -
> -       return 0;
> -}
> -
>  static int write_binary_policy(FILE *outfp, policydb_t *p)
>  {
>         struct policy_file pf;
> @@ -198,8 +183,6 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
>         if (read_source_policy(&parsepolicydb, data, size))
>                 goto exit;
>
> -       (void) hashtab_map(parsepolicydb.p_levels.table, check_level, NUL=
L);
> -
>         if (parsepolicydb.policy_type =3D=3D POLICY_BASE) {
>                 if (link_modules(NULL, &parsepolicydb, NULL, 0, VERBOSE))
>                         goto exit;
> --
> 2.43.0
>
>
