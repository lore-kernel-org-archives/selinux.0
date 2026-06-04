Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2814883F
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600484; cv=pass; b=QUZ26GCXdbst2gYR1Ds32p7aLKj3VQpVO3VDjG9600aEnyXnJS6nDXf7IBfqjaDFsvLgHF9KsTbdROydxuhM/9Dqvl0n69XntqGhJrblZPYfcAT+NHJSmjNaHV2UdNg1vzP2v/eVWTCCcU2er35a7FBU3GvlmVN2i8VeFseRvIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600484; c=relaxed/simple;
	bh=NnGJhTW/uOsJ65262IiwsaI9UpU8+so4aBfrb1PV0Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtSsetkg+3VyV8obXKSJzjwINSlWDJT4VVSwvgBqlND1LMnk4G6OtUswOl0riwyKHmyAtMXcfo20e2Q96bT0DB7w4uIM7hNnwAYdDh4YuelHtWBMAWk4raOXbbyIPTMrFO/Ei01Ba1ZdDE9y2kf4hAb6kqHQLqjAS2DSJ2/aCW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcR7mLjr; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcR7mLjr"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c132ac5ec2so11116775ad.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 12:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780600482; cv=none;
        d=google.com; s=arc-20240605;
        b=ki1k/yez1YHt+6rZlpKJnigZS8TeabZs3j+7IGeTXvBkpYwmgt1wG+VdI7tX7ekHyX
         R0gqughvUVILuWk+qiYKZp6TebL6wMIv292IqomdyY5VOknzadXGWd5qVFJkFOCSq3yv
         j2Gii2EmafxTudmnnxatnfb3tEuWF+7LX7/j2epQGp9Ba5vXw85kJEqbFl5qTDLUgKU3
         1noNQlHgO58whbozjk1rztwZKq1Egb5SVcw70vHmqnoR8GGfRQaitcRpRJmuPbaaQErv
         3RLbJppXkwdSYjQNnO9/aIE0OIg9JVarCbYTNUvY9wuGNjIUDIqf3CeQnciQA00JTbMm
         KL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sByf2niRep32VDuw1vhH/WeRjLQACbPRaS49ebYGU9A=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=D84WZx6AWyltzjlxq2WNDdJeK3dJ67Ka4SKiojI1siTKOZsFot1D1wT0pfswIRKT1p
         4qOuL/etLkVdp0cpKfm5o2rg0Oqdd7VZTAVBclPmeQ/HZQhjyupkefQMHAhTUOASE6hv
         I/KlHingmH6PyWbpHDb21aBv1GNnXkcVgcwAuCOiNht2bwiS8FozR8pvPqIqMQznJOu/
         zD1ACM6shAx7d7DUVc5fJG+fE0Rt045GBPsuJLTbIKZGUqdFJJDCaNKmDlNObg2OjxJh
         Y4si2UyyJclraDKWVqVrPDRICnAnyblfsE90QKuA2mfGrb/0mr0C9HVGpEnmVHWg2hGJ
         B1Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780600482; x=1781205282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sByf2niRep32VDuw1vhH/WeRjLQACbPRaS49ebYGU9A=;
        b=gcR7mLjr2B6igtx+V2Gi4lCPk8Mux7D5R8k1Y6tZ1TTeTTzvLApOhh6sBAvMxeRkqG
         4TwDlxIypCScmkWGopKrPFbjyjwKtQqFOyqZ933JaHerHUxEh+cd+SeDhogeu1Y37Qpq
         sGoupMByrQCh3/69lPYr/oXD0YiERHzOZFUQ+86jPADQ8eEL9mFFjA2knCgoP1CA14A0
         nikv4I8EsvPXKw8553ob2Zv72u8JTBIm1fQ29N3Yua8xnk1rDeX8Nal44TADYw6bgx1z
         jaUe7eqwW5QGzrhhngepatCajrhSfIAWY3pT+kdoTxqH2VnhDOnAthtnPAJ1ZSyUhac0
         6ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780600482; x=1781205282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sByf2niRep32VDuw1vhH/WeRjLQACbPRaS49ebYGU9A=;
        b=ms9uUDBLvg2kTXD6z2sUThrU6ObWVl6t70TiB+5Yckepd4a0Curghw64CrISPjCQsN
         skslJ3Fe0qGWMrQiRrZitGY58euRvcSaUlcA7nwp7f8SITQMEE+gR4JfPHrG9qfXomSp
         J8MTMj2+dntohQAtK/dTuLSiHQvXFtFkQy9U/2APcMJDjlpL45K9Bg2hcHY7fYmPcMNB
         HI65uUvn9yTmCexgKr/7dZ9fXA29vZxaRm6cinr2k2BQe1Gss+CiMkPRCComr04qcZ38
         6DaTJwlE3JKJlaSN9jij9YWUO+Oe5+R8aK7JJ0ul0m3qOZrvo5u36ZWXHLMaPdOb6ZJu
         Gi6g==
X-Gm-Message-State: AOJu0YzYyu+uXJaTrMb4RZSwEpbG4fpJ/TMcVojFpZJdhw5lljuOEm/6
	G6MRPqju+2sHZ/UW0V19zGAu11GyBoJFzv1ArDXdvZMWqxsdYxiq5RcvUE4DaM3UoxjmSPrYfV1
	jWxjj8dzfUpF7TYd96Y/efH46gdEIggi1dg==
X-Gm-Gg: Acq92OGevNaUp/Bq4eXYtNZ/z/TDyI5UXoMYVWmm/IVj750g4tQSWisIp5dL5z7+3ay
	v6hqmekJA3k9aiN18eyfe+Zal0wAq3P+I0sOKlqKygWQosun7bRBhQAVVqpne5y82or2w30vhP6
	xrJLbwjI28cPLKtj1Ut9zVFi0f/4nZ9E/Mu1W4BNYS5J8ZDzdlCcr4I4RhRylHBZ3TIIF81Iv7A
	C1LKpYWH2ltKf6NHJ53JqTGXKjozHmss9sXdZf56oOYHP9Cz4en2tJrqr+EGP5wHUNgGakuUwfs
	yZFZv552dmXvNDazZA==
X-Received: by 2002:a17:902:d481:b0:2ba:3e2f:6883 with SMTP id
 d9443c01a7336-2c163fa845bmr97892585ad.19.1780600482376; Thu, 04 Jun 2026
 12:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604190843.47747-1-jwcart2@gmail.com>
In-Reply-To: <20260604190843.47747-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Jun 2026 15:14:31 -0400
X-Gm-Features: AVHnY4IQLKICQ2g3ps3WN7JdoGol6Xq_0JBi-QpR6wby11_c39wefCe5UMiyFkw
Message-ID: <CAEjxPJ4xLjiJ=z6uH6pfxG_pz70TiaR-OOyaCtqcH483s71SqQ@mail.gmail.com>
Subject: Re: [PATCH] secilc/secilcheck: Remove extra sepol_policydb_free(pdb)
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 3:11=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> Since sepol_policydb_free() gets called at the end regardless,
> do not need to call it in the error path.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  secilc/secilcheck.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
> index bf12a812..a2cfd9e2 100644
> --- a/secilc/secilcheck.c
> +++ b/secilc/secilcheck.c
> @@ -78,7 +78,6 @@ static int get_binary_policy_db(const char *filename, s=
epol_policydb_t *pdb)
>
>         if (sepol_policydb_read(pdb, pf) < 0) {
>                 fprintf(stderr, "Error reading binary policy: %s\n", file=
name);
> -               sepol_policydb_free(pdb);
>                 rc =3D SEPOL_ERR;
>                 goto exit;
>         }
> --
> 2.54.0
>
>
