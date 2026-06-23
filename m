Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0993D7D84
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228517; cv=pass; b=ktsH6tYb2q1/FqfzKipCNmzRaxAq7czfcRlzbE83dp569+b8t5MbhoQthnrEWZ434V1xt5ySLEAh2ozl3phUdc4vzdin2s3SJ67a6G4IYOHqUiypE0pni+Jgi3/ZjND72Cgo1kAY8o9HC+eLf+0ZWcgeORD8uZTd0+udiG20EG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228517; c=relaxed/simple;
	bh=mdB1NcGopcdspHTsvsxKthawdvcLg8PQNAYR3uwu/fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSCGZCo3N9u+LmAQf1DSQgCG86Sl+Rt7EXqhkv/PsINBOg1GNAaw7FyF21RPQ4+InS7X1in5E0lOKCFHjl8OXEjULRNDM/0z4vIkYwGsJzhcb2fJRbY2FPjXykF7ZKQGRRgJ86IxXbLs5aqboDp+N9EbMKVpnww7Zwq7JWl4lSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9uhO7op; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9uhO7op"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6bc87f4d5so22224275ad.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782228515; cv=none;
        d=google.com; s=arc-20240605;
        b=UtT41bVlsJtlQRj37aMPICwQAPHeTgFKNyK0r2ernycM24/VNwbx2LV9oj6qxU3FeQ
         EpocgDSFJY2035Dr+3/xh58q5uCb6Do9bMYLELpBqSKD1Rwm/KRFiyQC5/lnf92L1G2Q
         d7AaaLUClo5r9K7xAvedlHOHdeR+8xPu6gY99CAMe9hFRyzXWYdKpZYIFdXA7oUXHyID
         pY6L4euFKniIhrofpatkXtW9bUcszZbmfci6CT8XDusJVtPbYv3qkRkWIotiJWRmFTRo
         uIf+a+ucmJtNsT0kPdVx+Xxh5JDjYadgzYFXKBw1XtRVoI0NYRH9G+pBHQQC21C9glcP
         pBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6DbtgxSqrQlBOE3BOSIQ+meRXOCmzB5sfpCSmjPoxU=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=lqzPl7fvElaAhSVBu+vO3y9xeiQ0wHwLP4w7ZtbFHz94Dkf4LxtaeIhVdvzHEBSsn6
         4Pi3g9VOUw35CjboBDdVZr9DDGME1PU9iyFoRWTwEkRaui2NZkwNGzmHnSNH3W9WeYX8
         lmwI3Pg1KJHyFt2V2aEFGxoTheK2pjd/sQ4fPDfTGFYsBT9/6lZX2vVhVt4w5ah6LitF
         tJOyyrmkmPkjptdJPGTY9qpvzHkcKWLz2Ww46i35mXA8uoCJGnDzEq1rGIQhWyzVD1Cd
         GrICu3/VFgPt4g3P50KBO+LIEcmNrCjibSs6m9s5vdvtKNgnCLK1EyQtTmCehCm6D79n
         nwJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782228515; x=1782833315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6DbtgxSqrQlBOE3BOSIQ+meRXOCmzB5sfpCSmjPoxU=;
        b=B9uhO7opNILypZ660wSci9bV7HpujSvpKPiBIsp3IFFVIguSCszPejWQ7gM2AifPDT
         12QBkmIJWz5Y3DNI/K9/VCLJ2tgzf+4CUC9FmaXt2XrwxVcbf5AylD8AVci21o8iCjd3
         pOXzR1QcUpbENLgNXDuabd+rjcrrh2cU/fyvuhAaKi+jzPqSspNSfUzkSDNx7z9ApuG6
         wOjs6UjFq2y8uLPvi87NPvk4TDWnLdJeMfqfuExfkYKRVOgQRq/pngIfZcO38zWKBC20
         a/JSKGdj2Fd0PccaZw7yA4XT4MSwp9AVDhE7DppD/SLi0yGL2xCVIgTutaeU98M0QsQG
         8Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228515; x=1782833315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S6DbtgxSqrQlBOE3BOSIQ+meRXOCmzB5sfpCSmjPoxU=;
        b=W4koUstWA5yZePDmPsf4AUa0+Vz7wpER1A0ELWA00ZHwotD3FNuB0fFN6s2oRvGgrv
         8Zb+jxeMwktJ5Z1xyk27CfGqrz4STyWM1/V8hEL8LijjO4VtIh1KsVu7Xp83pTeLdAp5
         Bl8jPeaysiReC28PqJZC5rHlr7+LaLlWBOttT2icn6JC8kcNi75VfJ4FY7lUc/CFI89G
         qXOz94di4XMXd2gDy20vCi1eFXi9/mcmbHEEdzP9r9qrb/ZVz/e3vxzgZAKH/RIt+LGL
         2QU0u/TiyQdMFY2uaMZuZonXs0BRnt3GXqkUpeNZ0cTBNH4B+717nJT2w0k+SJ4DII29
         R8dw==
X-Gm-Message-State: AOJu0YzwzVVq2lbjNEvVtMmgvqNIzMa07zTVjc4jxiSMwNOQL1OPrkcO
	GkF+WEJ4vnW5W4wOpAcr2tasET2apwcSQP93UJRueBMC/uNPpI/cs8rak3khhjpnU3E9tafb8RR
	Lx+Ea8TaBdSZt6U2mWwunwQGftREYeSZLd9Zy
X-Gm-Gg: AfdE7cml+tbKxnaepc2Z5Q9yUWHRxZz5VJgjMgRWtNUbMc69OYSw3yHGrHIWlTVHFTg
	8d5dH7CIAH+kMQHIEd63OeoBXZqEfuwlXbAJofBdVrn7QHBswPrbq64DCkQVK7/wBFOb0UcQdSZ
	uVF7QuijAvRj9c9Dd59kIVMoW2liu5u6pkKssyRdB89WrLYWLhq2IiutA05duji6/BmsvDi7gau
	DzRlTE7qQU1cK7WUSX8JSdfLtx9BtSOYvRsx6oT3px1bqWo7fU5+/rwHLIx7zE0pngjIJE7
X-Received: by 2002:a17:902:f688:b0:2c6:6926:8968 with SMTP id
 d9443c01a7336-2c742b1c878mr148201335ad.20.1782228515013; Tue, 23 Jun 2026
 08:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-17-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-17-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:28:23 -0400
X-Gm-Features: AVVi8Ce-nWyTtPQzaoxkeEleGRQAolYoHue4GcuYu347Byz2raWHcK22YnV9RS0
Message-ID: <CAEjxPJ7yKSCX4RgwvgncjDWfV_xkhiGK+StbnbXeBWdk99+x4Q@mail.gmail.com>
Subject: Re: [PATCH 18/24] libselinux/audit2why: reject non-string entries in
 the permission list
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> analyze() passed the result of _PyUnicode_AsString() straight to
> sepol_string_to_av_perm() without checking it.  A non-string element in t=
he
> permission list makes _PyUnicode_AsString() return NULL with a TypeError =
set,
> which would then be dereferenced in libsepol.  Bail out and let the excep=
tion
> propagate.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/audit2why.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 268e9097..3c3aa105 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -376,6 +376,9 @@ static PyObject *analyze(PyObject *self __attribute__=
((unused)), PyObject *args)
>
>                 /* make it a string */
>                 permstr =3D _PyUnicode_AsString(strObj);
> +               if (!permstr)
> +                       /* not a string; exception already set */
> +                       return NULL;
>
>                 rc =3D sepol_string_to_av_perm(tclass, permstr, &perm);
>                 if (rc < 0)
> --
> 2.53.0
>
>
