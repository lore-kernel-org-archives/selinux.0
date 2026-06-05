Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DF3B27CA
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670015; cv=pass; b=db1TiWxP0EobhWGKv+gNlfeVt9iYI48A3sQOYo206IRPGQnT+QaP7WHnCPpn4yLtt09yF8hcMgxCwq13Mkltj67xze5MapGMyYrtTNICGwuTYGBYGr2N99C2pLG42mkigLRi0MLrhOyWoLcSGyZozf+spQillJjgCvCf3B+l4OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670015; c=relaxed/simple;
	bh=DQZMVcAj0Y2pbFX6MRyZzyefSWeCxiD8L7iiSXpuFT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tn46ZRmXUAk7YvhjvSZC+UMgELB0SIcxpA6Alpx1mxVrfEGQ9iAolejsymjhXLSivNw6ti+cULi/KXyZnVrH0IM3RSShAiYtReBntJN3a16Oj5iMgEILhML0+sJJCdeV18uVzJOte11m+1Py3vHNRr/qQo6KUleFzR9kZvDUQNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYFIICyE; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYFIICyE"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39677234558so19706111fa.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 07:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780670012; cv=none;
        d=google.com; s=arc-20240605;
        b=MiIRS1oVxtwio7XZNzsiofNUzaNxNGQfh+uYciCoeHVWZvr1zADjNsIbp6xTmnevS3
         5bWA3rM8o4vFdrNn8DezckFDc79LSvVxcwh22J9AXsu7rv8yeuOfLB+9AXMCktuYgWQE
         G76e18epFsafkwrHK42iLJKy4ajKS52tYN+TAHuJKDfKcjnfbHiN+K2cWZelWpyAn6Rq
         t+S175vfoaVnzrsfdJO0zYLebA+ObnoTUBIunNLx2KdEzBSeSiQwMJmRXuHMr8wbRXwe
         Uj8Ho7yVkOUkf5b8tZ1IUP+bK63H6cHavXCitVSK7ixuO/8WmzmlTDAHCedqRFhm3pJc
         pdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JvPAoY8PA/zXkxlKCcZhj1YRLtJy+Sq25ISXJFrVuZg=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=IaFJwQZShyZC6Q5la0kHNzo6EErnavlnh2Zof61jE+qevte4+J+HOzCaRFs0VK0vxD
         2dLTCQF+Cp1lPAunfbm6IlkZ2dGfD8WJtQuhyMNi24aXdPefKapf7czXx/m/GTW1i1x4
         td56n66xvkMN7Pry561fY46nf3n2WRIC7CIbZmyL+EMO7vBcfjbYF6kp0ap3ddMKvGVT
         n7JmyuAoiLfaXKRgjE+qse2e8gJ4thbC15Dw/qRMrdHsH+dfthPlvnzKc2qgM7pvzAm9
         jF1pqJn6rJNb2mysVPHk19W78f3zmudO/LOHNTZIBbmuYFib9bgEHdHVjQAnAutNFVxZ
         HUDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780670012; x=1781274812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvPAoY8PA/zXkxlKCcZhj1YRLtJy+Sq25ISXJFrVuZg=;
        b=BYFIICyERL+ndAvy7VX4BrXLfdJJ1eNC6vaSsMKFIbz7MJaN2mmF/OtLnaxW8kTFNE
         mjzRYTEa+6I5z+RwxECmVFQ9TwBV7obfC559nR8pEgVHCL9Ae0lD2Sh0PJflB7YNSZlR
         5zE7w1Z99Wd1VEcHay2Jj9vkBKgutnV4fk+1Mm/ZwBdaLkx1T5wcx+8QmwUlCV6I/Jgy
         e3axxlspiaWbyz9SNpxD1ZnPE39yQrOHeYJVtW913EJUDvnp376frKcx9Y0t1bLQY4d4
         yMrttMKwN0cd6/ege/BY42IHOClrZPR1HFTdrsA/SkiYRujvKHiPH1rFbBfOjb7fUBGo
         mhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670012; x=1781274812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JvPAoY8PA/zXkxlKCcZhj1YRLtJy+Sq25ISXJFrVuZg=;
        b=rW1FxNsXbRJ08wRy158gqf4ISthMVXfeq5EvkDMeNwnP8kPbUZ1bM1npDXGAUgKORF
         +4CwYBB8ph1WdmYHJsDSUfhZt4QFoa6EQ6Abgg+QNqm0OOCu1CzwhVoqbhVD/95zALI1
         tsLvdTvWpv7kp6+c9DJSBA1hNd2HQPYOxdvXpU2wGQWa/FI4pOmg+enAd56qKaV+uVJM
         krUMfiqCmwb5SPrjMF8NL6rKR5TfzUg9cp5EvrFsTAWbplNhwUrs1r41lVlf2sM10l2f
         XIkXqVo+CKClC+7LdTg2iE1/Vc9XDNTjxcCwPwlPB5f/FbWpi1NcAigXD2AOoUCRrYKO
         687w==
X-Gm-Message-State: AOJu0YzzQc7i/9IyHScMM4MkkXqYgNwlkT7w+vxJtQfHElOxY/pJZCd/
	m/AtMlIcIlJjP3X1/L4+333mJS968/w7mMmpIh5jSmbBwrY379i7EuxbXXarsRxya91tQIb+/pZ
	RVIXoFryhw853/gvRRPIx6jqmud9vZ5A=
X-Gm-Gg: Acq92OGJ3Nh1Lubk8QB280DTWnfHXAEf22iGeBV10YgccZRWsFimOzKU5G3cIluk97O
	mh4qPWmraSMbDIfFQ72R46DM/Om/ovEwwCFp7JpYGgQSxKaN4w8yTN1E7O/rYBCh3QzTx082gJG
	t5qOh6Yjjg3QsRxIND0BKK1Di+p1LMvNqqUMBPC3lTnLHfSl5zYmNbiJA+T6PHxje0z6PQfHuZW
	x74lO5RxWHDR2FzuutxIhv7hoWn8OFzMvmiXcL6mRZKn+4E967TQxrZXIdAjGi2uWcjJwcnIfU4
	hvlKOXovVyjp34E=
X-Received: by 2002:a2e:b8c2:0:b0:396:672b:4bfa with SMTP id
 38308e7fff4ca-396d091c227mr11392831fa.19.1780670011803; Fri, 05 Jun 2026
 07:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604172002.263518-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604172002.263518-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 10:33:20 -0400
X-Gm-Features: AVVi8CfMLdIhtCssHTN1uXg8JTpkOoGlqh6jLKM9EZdf7lbT_JPgQ0-WZlL8aTo
Message-ID: <CAP+JOzRixd0WnraxwU5YXcp8ndzZwD6X99QBQ7w6Y7ZHf_v9BA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: audit2why: clear static variables on init failure
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 1:20=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Clear the boollist and avc after freeing them to avoid potential UAF
> on a subsequent call.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/audit2why.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 4e3fdc1c..2275ffbd 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -275,14 +275,15 @@ static int __policy_init(const char *init_path)
>         return 0;
>
>  err:
> -       if (boollist)
> -               free(boollist);
> +       free(boollist);
> +       boollist =3D NULL;
>         if (avc) {
>                 if (avc->handle)
>                         sepol_handle_destroy(avc->handle);
>                 if (avc->policydb)
>                         sepol_policydb_free(avc->policydb);
>                 free(avc);
> +               avc =3D NULL;
>         }
>         if (pf)
>                 sepol_policy_file_free(pf);
> --
> 2.54.0
>
