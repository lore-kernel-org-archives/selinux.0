Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B41B94D
	for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423052; cv=none; b=HSalxSv+cb5QqOlaT7Gk/O220d+r1lf2ECC91J+RwctkrmQplgn4HxH6nHGbpZFTITcS+NT93nV2MminazFI93eFmdr08za0cpISnILnwEEupB9YE7xenqau7hQoKiPiyrSD3m50r5FG/zIKLa6WcC2BCJZK0GEMqcoouQdE4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423052; c=relaxed/simple;
	bh=hRP/cEDB5ouWRWmeHp/or8DRH7PdUQMqDehEjMqU9H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBwo0CqSaem3KhmKT7VZFtsnolL8R6EZZ6wrskJOhU0k8P3kQWejUEt+GL5euv018to6F+urymCUGLmUaE5MxXdnV5CH6WKh91wKIJQIMLgIYFHp04soNvQpZqN5S9MtarXkiL1v9/mPkMlY7oXCwJ/9Q4kVEvd9jX4YC8SwpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRMCnTWj; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRMCnTWj"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d858501412so63710101fa.0
        for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714423048; x=1715027848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVTBDxEReBu/q/EiiIL+pF5u57zLsiUBalGu5hlew5c=;
        b=YRMCnTWjGaa+uFEnDfpRT44QREJzuef48oZd1biamPZLsX9Za5zLMwslC2h9UaCQ0T
         HdFvh+R5Hqw9v7hX0zxdCGInpFxuXwHw/Kc4o1p9+stM7JZPHvpdqM+w2tEgkjYkbDht
         ypexc8cx6xcjeze8NNRCOsFANpLefQdP1YAronGCU29SYeofyzsKDWObckl1y9cH97dQ
         gh7x5m0D/GI0b0MhK7UGUEpgSMHpUQQ+HwGEe0PXDywRdC66morLGevTUYpZrowXSekY
         OnB9NpAdpYWvyFSFnyXby360h0/3NcZz3W2BynsKLZKi27bnP/BVtfXjrFNCGjOWSRb5
         XRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423048; x=1715027848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVTBDxEReBu/q/EiiIL+pF5u57zLsiUBalGu5hlew5c=;
        b=ZMb7do60ujd4PitGBSsz/dINu7QR/xc8VBF8W6sGVlHFRy89UkaepndDg2tvccmbDr
         WNJ7T53lxBGdqdvXPCyWc2ww9fDZROPVVlH34ryBvXjSk59QBkIwjAJuiSPQICn2eG8f
         N6w+pYu+rS09xwDfRS7GbXt1neLFT/5WTcpsNLjwGOIj91NtlYvQoXlDd6UqAH9IB9jW
         0w1Zraj5J0NxQkNa92anZ86fKXzPsbxbH7blxCNMbn9tYcygYqE9wuSVYN8LbHAsatSH
         s1slB0TjniobM7t8z8YYHEaRtlvg5KQstzdTkWwpvqAEb1vuLRGW4+D9Vmrgfz9HMV5F
         DrEw==
X-Gm-Message-State: AOJu0YzauimNHBsaN54KGU7xHMXZAgl0WwYwjQ7GiLE7+72PmxH4NyM9
	nyQ6+kQ+5JM7M4vZfVgEAuJUb+nJVi8w3JmSk4CveZVNi38Emt4jqgNB0sA9ykHupq/EQPKau/2
	qJ+HFtYwEJSneTlvhcManT6hit+R3tw==
X-Google-Smtp-Source: AGHT+IEsa8FNwxlIlXM84bxMnTOhhS2b/oWMEVZ8EPVJ2LioNkOoc/ds6tqSTXwOZtbxep2l35TlN1a+ipS0yM38D9M=
X-Received: by 2002:a05:651c:b13:b0:2d8:e05f:633e with SMTP id
 b19-20020a05651c0b1300b002d8e05f633emr694363ljr.1.1714423048217; Mon, 29 Apr
 2024 13:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429163901.65239-1-cgoettsche@seltendoof.de> <20240429163901.65239-3-cgoettsche@seltendoof.de>
In-Reply-To: <20240429163901.65239-3-cgoettsche@seltendoof.de>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 29 Apr 2024 15:37:17 -0500
Message-ID: <CAFftDdpHZpz+bN1qEbRyE2s0OKwdipB7-gVqcPr9RTuiedS6ug@mail.gmail.com>
Subject: Re: [PATCH 3/3] mcstrans: free constraint in error branch
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:52=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Free constraint, like in all other error branches.
>
> Reported-by: Cppcheck
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  mcstrans/src/mcstrans.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index fded3235..7667e131 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -477,6 +477,7 @@ add_constraint(char op, char *raw, char *tok) {
>                 }
>                 if (asprintf(&constraint->text, "%s%c%s", raw, op, tok) <=
 0) {
>                         log_error("asprintf failed %s", strerror(errno));
> +                       free(constraint);
>                         return -1;
>                 }
>                 constraint->op =3D op;
> --
> 2.43.0
>

Ack, but this code could be cleaned up to use a common error label. I think
that would clean this code up a lot.

>
