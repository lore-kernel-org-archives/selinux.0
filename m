Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A2415530B
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266923; cv=none; b=gTU73CVbvrKqHHW7ktbhBTT96Vvp6Jpod3nXbuIiJ5P9q37GEGlVfv+enkE8Sbl5wW9gdyV0WvyRarZbZzrn7Pi1EtEat5KHv6h+HX/FscqMVpAGELrKrYorLBRloPKhkBGBXGkQtAHIshlsEaJn05pu+f7Oh8rajySPgx11nIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266923; c=relaxed/simple;
	bh=eEMmGvgDxgRfYoG+/vNY7GEWhkl+OKmL98MU+hBgwTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwzNQtuJPlM3RgUoQx9ypGwv7Z95nXQ67mdAba1Fko874zXuDc8YjFdhuvB88IyNn2rl+KQnno9LP/nXnlj6Yc6hUBJvFvoIocM5dexgZ8qTcYZp5ukv8d5daTwr01QcvJ8tPigEDg0qWUVvaedeBO9Ao214dQmU/meXZ4BmS1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQduvACp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQduvACp"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2007600a12.1
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722266922; x=1722871722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Scs7tT+NXhsxlSuE80t2Nu2R+hL69nJEReevxghhxk=;
        b=MQduvACpqLU9cxrT0oR2t1JKukdxIv/gyV9TnYAxkf90NNZNhQ5hKfysGaiA6E7wBC
         JfFxAYb143GdlrDfN+UCnO58fFg3CIH7vzkFvrlsRhpk6qEOjodoJvXCbZowmSGzmrpf
         QxhhLww7QjierjavvSJ+SGwKtTx8IneG+BImKHz7WooExpVpKJlafXum83Beg0BchZuo
         DwLGaUEW/+wH9RpeI5JtHZt6E/CrZfhN2pcrwwEi0y87Y6l142NfQlflXI36AmdLKkFj
         Iw/MXqiUIUBTOmjy+dHaLI+i9HF9/OrEwW3klnKUkZyu5hBp/awv+I6hEV5lthcNyOV6
         cntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266922; x=1722871722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Scs7tT+NXhsxlSuE80t2Nu2R+hL69nJEReevxghhxk=;
        b=sFSzsTaL3N69aISGSQ34g83OVIhzEB+azq+yg1Ks8hUOEjYSWFCrARufgLh/Tuiys+
         2AYSAUTYg4+DYkvvJy4aHOhCSu3/dOB6KF4fTj5PsJMde4fa8eOUFxrLjDV8wRtPwZjN
         ka4wHzZ0u1CrPp/5uwiFAqjnf67d/640bRyqFw/od9oP4LJrR833jLX0XuNoTDTaGcKX
         oXSxffLb9UkEyJ+HVQbyX78eAZoTzfYybgooS4fJCYh7ETbPEXyWwSC5RseqCGBqfghc
         8bq7HjGeto8dWPHEucDUw4NB5uh2+UxrPd+1v7k5rFyZgnppLAD7QuHKcfkt8k2X9Ixl
         lz1Q==
X-Gm-Message-State: AOJu0Yx2oJBvbYN9Q26jsj2zjdPD+Agg08qLbXMt1gt9gA2S6S2/+OCz
	AWHoVyG9mQjVAGiA4Hu3CLRgLZj9C2lamHXY1lVBRs9bhlHxyL+3QXD60iYhPJYVpah6miC8eIR
	5eMj87au8PpPSFQ80prMFbL3PJaAAAA==
X-Google-Smtp-Source: AGHT+IEOAY212JZ6N1Cnh4vF70Y4nj0lpdJE7VYDEncfmGJj+61tWwJgF8EtZ3NdQs65az5WTB5nE5voQ7ujE1XHKNA=
X-Received: by 2002:a17:90b:1d12:b0:2c9:6f53:1f44 with SMTP id
 98e67ed59e1d1-2cf7e09752amr6164350a91.3.1722266921697; Mon, 29 Jul 2024
 08:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708165032.86647-1-jwcart2@gmail.com>
In-Reply-To: <20240708165032.86647-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 29 Jul 2024 11:28:30 -0400
Message-ID: <CAEjxPJ70EufOsd4O4E-Sc+KRGdv1Nhbac4GbkewAejp2GrMWBQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Check the right bits of an ibpkeycon rule
 subnet prefix
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 12:50=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The lower 64 bits of the subnet prefix for an ibpkeycon rule should
> all be 0's. Unfortunately the check uses the s6_addr macro which refers
> to the 16 entry array of 8-bit values in the union and does not refer
> to the correct bits.
>
> Use the s6_addr32 macro instead which refers to the 4 entry array of
> 32-bit values in the union and refers to the lower 64 bits.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  checkpolicy/policy_define.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 4931f23d..bfeda86b 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -5036,7 +5036,7 @@ int define_ibpkey_context(unsigned int low, unsigne=
d int high)
>                 goto out;
>         }
>
> -       if (subnet_prefix.s6_addr[2] || subnet_prefix.s6_addr[3]) {
> +       if (subnet_prefix.s6_addr32[2] || subnet_prefix.s6_addr32[3]) {
>                 yyerror("subnet prefix should be 0's in the low order 64 =
bits.");
>                 rc =3D -1;
>                 goto out;
> --
> 2.45.2
>
>
