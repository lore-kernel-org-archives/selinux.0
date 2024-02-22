Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C21468ED
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614857; cv=none; b=a99nPrwzl/wMEMbvbETDFy98fqqn02e6oq6IcSseKr2JBqd+rU1sFYA9hTPOzJH6PgmJAtRtudgjIVJ6fHvLtkJmi+eFNahVRzXWOpYm4ONauwCHFebIXQWMbvWAltmT+gkbVDwrJd+zTNqUgzxCaMC0GnjspJf8t+V2ZwqQM7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614857; c=relaxed/simple;
	bh=L+n5OpWBmpV3L+udk1uMH2VFjM5EZkEKnVmkgmKzQ7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOaSIonFtHBrTlmmmJDvsUgfbRkBBOW3w7DdBtwzEwKBRovhn/7zTXw9W6WAqkI+6BfkugEDgcEL+K+4p2OdnMgpNBHSwltXRNrPY99K1QbZGjzMSliodr2aNYOA7P+snlS6yBzoscx5g743bRy3Y6ZWWfadtk6SB9GRlYz3HRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYpsBfVF; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYpsBfVF"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c132695f1bso6057994b6e.2
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 07:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708614855; x=1709219655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh4AQRDnCH38ENoHPQKIHhDEFBfmfJfmmmklcmO5Qho=;
        b=aYpsBfVFZTBkdmTPlu9WHlGibUVci0jPOGZvT0QLKKNP/Ar3bxd9scestotpcuNl8p
         Ip4UGlLrf60U7BdJ+GBCAVQkamVL/Q8AULwTjp3YIK1mo09/M/5ztZKFmY5xZSIdMz+9
         c8sZdeYur+XYztKnw7Euby7oU2LozUM+fsU+MTZmLQoNv38znT2gw8MIMmXim/xtmli3
         NZ9+h+js+HRZGcpvSdQHrziUkiF3h0cNLFE8hiNCyhAWrtYOS9W8WwkcKIQc1EM9QD7I
         vWb11ktL5OQTcI4Y8lEeZ0eGaLpDKna/11DU4wNixsRgvXeTKEECSto3WrrvH9r4+lXm
         Li5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614855; x=1709219655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vh4AQRDnCH38ENoHPQKIHhDEFBfmfJfmmmklcmO5Qho=;
        b=OT0zqlpgKK++76Lry2JlT6ipV90f9Q0QVVeFlXXTklQ8FYWbTHT5RnYok65vizTjYc
         +KqsvbMS73Y9F2fXlObssOHgNuwjTGZcmjZ+1Sr8RFyBomUDLiWpRaYyhvquoKWOGLTw
         txcM9+P6C+zjw8XABdIO7N/5y2JCowjZyLc02a1h1XnHDQK1UmoItw+G/chC8tBldDXy
         ohHc9InTl7TWmM0/X0Alfxg3PreSjMA64VwcjBxqFH+ucfDn94ABocponbYal5oGP/yg
         ie7NMhWQ34/y6eSq99JT3NDGV2Io9X3vNDSnqxqYxDnrP5AKyd3SUontPcnv8tqktfQK
         VTDQ==
X-Gm-Message-State: AOJu0Yz/8MqkYfoI7JtR+nvRmz7v/319lkB/Qm8WWHPuCiMgfUXw9/dt
	Rm/0VlvSnhXVLn1+IU9R+VAu78o4rclMBtnxdzruBtKwwrwn9Vgitiwz6zq735J5D2uTbQhqsPb
	5qY2B2TpAHVsRBucZOs7p9dXvHTCNAYyqaxw=
X-Google-Smtp-Source: AGHT+IHg74HhuyFy4kgvaR5WxMFIuM77brWXUdp4oJpRm5Wsg5IOBaX+Walv0JuNg3rU46BdHgerzwf91XTpNhD1uX8=
X-Received: by 2002:a05:6808:2108:b0:3c1:5f16:6c47 with SMTP id
 r8-20020a056808210800b003c15f166c47mr12670736oiw.11.1708614855287; Thu, 22
 Feb 2024 07:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131125623.45758-1-cgzones@googlemail.com>
In-Reply-To: <20240131125623.45758-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 22 Feb 2024 10:14:04 -0500
Message-ID: <CAP+JOzT+xzAxFaGBcrGK_ye1SPnLb_DvJtr7B2L25F2mfDrsSQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: ensure transitivity in compare functions
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 8:06=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Ensure comparison functions used by qsort(3) fulfill transitivity, since
> otherwise the resulting array might not be sorted correctly or worse[1]
> in case of integer overflows.
>
> [1]: https://www.qualys.com/2024/01/30/qsort.txt
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_common.c | 2 +-
>  libsepol/src/module_to_cil.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index 2422eed0..44f0be23 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -503,7 +503,7 @@ static int ibendport_data_cmp(const void *a, const vo=
id *b)
>         if (rc)
>                 return rc;
>
> -       return (*aa)->u.ibendport.port - (*bb)->u.ibendport.port;
> +       return spaceship_cmp((*aa)->u.ibendport.port, (*bb)->u.ibendport.=
port);
>  }
>
>  static int pirq_data_cmp(const void *a, const void *b)
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index ee22dbbd..c8dae562 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1680,7 +1680,7 @@ static int class_perm_cmp(const void *a, const void=
 *b)
>         const struct class_perm_datum *aa =3D a;
>         const struct class_perm_datum *bb =3D b;
>
> -       return aa->val - bb->val;
> +       return spaceship_cmp(aa->val, bb->val);
>  }
>
>  static int common_to_cil(char *key, void *data, void *UNUSED(arg))
> --
> 2.43.0
>
>
