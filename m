Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F480383C85
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831960; cv=pass; b=Q5100CFK4CGHuwcOfKOQA+LrgbZPTBYXNPd/YDjRD3CY5UC4771ZFd30HsDhIf6k2/pUNfOdN5CD8dz2kvCCpxOyk6ba1AKNtPX0uKWAA0EUZ0QclDKWI4p3BcRdKkH7Ha/AalMeyFA8zhRmOpyrLl38MEa8iwd5+bcUNNO1pJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831960; c=relaxed/simple;
	bh=vd5dZD2UaDp2K63E5QWMZCEDfVIb7SU14WjlWu3K/vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtuPm/3gLAes5w0GzSiBpmaLSoXvTMpyAeNb2oTerQ/2H4Y/1rFbhpe/O9M5/JzOgmzCtYJewokmTiawG9UIBNmRYnVJyL56afHe6QOcuVVN0ZqJyPOfRWRQggCIpal5s/eVh6UYjQOOsISblXYZ8zySSEWyzyG24vDGBVJEWVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0xMJm/y; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0xMJm/y"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso848492a91.3
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 11:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784831958; cv=none;
        d=google.com; s=arc-20260327;
        b=gFxNm++drxTVuw/mY6WSldi7bgLXRrsJKCfZ6AX6m7zKJJvW6ERFTHETvDnzPtGm2K
         K0anJ5Qg7nFyKqWghzbNirjnOn/KIFmyPGJP5+9QjNmlZvnc9xbqSGGo25Hmg22u6Y6H
         Ny/SgEmsIBAyC/gqVYr4qrBtHRyROJ14j5fj3TZwEUlt0PI4B0OpIFxfok5eEewUvsfy
         0F0R01GO0H0unP7sZq7EFkLZ48mAXgPzdsG/Lit3CKFWEItxi/4VMfjHSV6n6BmpsCc2
         6MiAWrzhnUYov+h1YLzGNj0mEy5Q4v2B0fMix+I7Oegkwig57vluTP3+iwOcXiEBLlDq
         v44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zr39lJ2tw/jp/GJhbBFJ2659QhuK2/5eL64Ftt4/UEc=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=FGwMQB/ePwA85hYy41fUZZUUodohtLAN6Mk0IeBXN20QmhoYoZ9yxissMPQuSPF2R5
         0d6dRsauCtHPPozf5oOmDUhht4V7mhZOe0ZPGxWgBvTBmjgMOiEDvMVWr/W+ypnO7S7c
         ZpxmU+u9Iq2W0jikEsS2YetX2f0VJLkM1Kc5jqi86DvkqrKs/FzWYg7sBKF8dtU49hx+
         1j8odDZuDgbCYxEVF/LQdMMNTkVz6J9v6Uxrq9RsXKYPss4BapsNdQjKQ1S4v7LJmKWI
         jUJBH5MXdKtxNQiRFt5GzwS//foMwo61cyR/xwjkASZPfztKtzJqquU0NLstgTJnib9+
         Xjsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784831958; x=1785436758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zr39lJ2tw/jp/GJhbBFJ2659QhuK2/5eL64Ftt4/UEc=;
        b=c0xMJm/yCx636OANJBOHNdU2dCxOZwELO4Ejm5yW+NIs19fbM4CafynRXkFXMaZChy
         b/P83U+vHYLk2rTcRl5GKcaQSETAkdVOKzmNieBG3AZDmZRAGMstFeh4jBgetLvKtlxy
         meN6LtCvuSxR/XsNiHHhqncO7vTaW71eVwMGHMRvPRoT7qvbIdVElzRsljPI1ttWwFCw
         K3DAWrDabmqorNFzgOsFj8molwANwi1mN7Z/ZZ00EiasxIIMVWsEjMsNXjDlB4TLTtRk
         14ekNOpMqO6Ud5yHBIrq4jjFwvYwthgwkB/rTGyYXEQaP61XQ3mMWbLWqV7vX6pE52eQ
         MQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784831958; x=1785436758;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zr39lJ2tw/jp/GJhbBFJ2659QhuK2/5eL64Ftt4/UEc=;
        b=K6H3p1MD4N5Nhmv2zhlfi4K+yL2iT3XScntrd5ZtkmavojYzpMwyDSh0IvLHUMoC/d
         Zo/Rspl2iS1NsQLrslBWEC1uUUwIi7GCpXyzR4JJyY+edCZW6xxzEBQxDZMDlj07nQaH
         ZluafiZ+wJ9c8QVoHPjs70cBLc5QUls/16W5e/OlHcy20Ysnld3TGYacCRUJQlDYIoEQ
         9zl7XMe4MFzkW/B/t2qxpmFd+O2f4YVAjNZYaa5y4UKaabaesA4YxRv//FGv5xJLhLI+
         qxOVNuS3hn1+m8Vu4NV+W8dwnfh0WZ7kf2FFISvygwEWZHg5xmwJGIT6DpJ1AiTE3qiB
         YVDg==
X-Gm-Message-State: AOJu0Yz5Z/oJ3p1AzS7uXAfGFwJb6YZEsqOY25ASdklIhy/kZGWJBxoo
	ZyV9jH2gRLXIVdRyYo0yeI3oed5/8R4DHiPGPLklAypsuELTNIO/tyLnY0K0UyqsfM1c+ET+9We
	0KmxtsGNrGKYOmIa4jRFdQVhEnwVyagU=
X-Gm-Gg: AR+sD12LD+eHV8luRDHxwPST2vP4anXqGXiWmT0g4d+Fvgo9zgcbTa8TB0DRpfPyWvN
	xfotSvJliJzGj0GZawH4uA7KInfCFQDyVYxeVNc3z0SvjKORAZdWzMY+iZezTeYGqNJB251P+PJ
	508jeJtYb6LL98vj9Xa84q6hBWCHlgNtjhtEQdYEkEcV02WOaba/pqy/EUcfc3rZs8xQvR+v6gH
	7snXGK7ApsLwTcOjzdN9j4+CWJyRAkPnMroxS6txQY1jZTZ0Sshf3sFryGrKw==
X-Received: by 2002:a17:90b:586c:b0:38e:7446:d2b8 with SMTP id
 98e67ed59e1d1-38ec6890685mr4720213a91.41.1784831958412; Thu, 23 Jul 2026
 11:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722181325.107755-1-jwcart2@gmail.com>
In-Reply-To: <20260722181325.107755-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 14:39:07 -0400
X-Gm-Features: AUfX_mykkMBQ8I_VO_QvVWRapba-CjQSas3SY6SHFop_rl7IbEuC78p_b6mS3ak
Message-ID: <CAEjxPJ4yGX0joHcb4kajTozQS6jM2ddVckZB4VeeVUzmCw9PBQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Check for embedded NUL when reading from policy file
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 2:13=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Check that data read from a policy file does not have an
> embedded NUL to protect against maliciously crafted polcies.

policies

>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/services.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index e8f0e622..3e8bd38b 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1799,6 +1799,12 @@ int str_read(char **strp, struct policy_file *fp, =
size_t len)
>         if (rc)
>                 return rc;
>
> +       /* Check for an embedded NUL character */
> +       if (memchr(str, '\0', len)) {
> +               errno =3D EINVAL;
> +               return -1;
> +       }
> +
>         str[len] =3D '\0';
>         return 0;
>  }
> --
> 2.55.0
>
