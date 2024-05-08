Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564412E1E3
	for <selinux@vger.kernel.org>; Wed,  8 May 2024 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194248; cv=none; b=idl6ACcyQZ0Zw1fGFJIl6EF9Ve6eHwIJ9AHf9Khl4E/3wC04PteajHYvaB+CLKmrfEKkY7dKi3AXAynFqqG1RSHlqks/zEDwcrQwo0y6r3qS1l23njb6Y8mNkmr7Kkz65tKu9Y+fj++K58nzYFqbx1sQ5n7iSRLafRiveyh27k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194248; c=relaxed/simple;
	bh=Jbrb2/FfA+j7X6zcBs7EZ8lWljtRMrz/ViDHEAd2wC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opJf1RUIvMdORaLow7zeJemzmGVBGnditmufyQeemgJAB0MqJofNOl7aMeTAEpXg1jqYtFvYrtG548fBoSydgChNzclu1EcX9/Qo1fBllYeuXCdn5h6h5Dx194VVEHvQVWuYjAw8YKTVyUB8C3W3nKZHXsPW+GhlRBTbxD6EnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9fGGelD; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9fGGelD"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7f17efe79a1so10573241.2
        for <selinux@vger.kernel.org>; Wed, 08 May 2024 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715194246; x=1715799046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42f3nu83PIO5Ry3f6xm+ciwZ/uPHzarp/fcwnpO5FSA=;
        b=X9fGGelD/8RR9B7bWglfVorC9fCIWKeoX9BGgJjcmP9ma3RDxPyORGwveij4cXbSUt
         o9ohqYFmjxnEySRisXY3uHI3FS1XhYWWMMEKPl3cjLQYsteSVW73r7opD7L83SHTG88V
         61rPaeIvz2iEZQpDxl3gTYSX1KuWRPvS2MteYzEkXv0zI4kB+/czpIsSLRNI6kwXz/Ed
         du3pRAmjNi68e0otM9EOvvXLzRSkznGEkmAW4GnsKauSTGTr+M4qZ0ahjw1klTepyJnh
         ids8Y/3gj/ewRx3FX9lqdPJnhKYp+MIHBbEOxZaP1BEt9K1F6Wvu9TT453ka0C73TCuF
         UN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715194246; x=1715799046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42f3nu83PIO5Ry3f6xm+ciwZ/uPHzarp/fcwnpO5FSA=;
        b=BXgC1cRcRZ7MSiQlcFrJ46sFl8VAeN1blBWZl0Kx04H91/cnAv7ofWIRVX2bMb7bi6
         bdxo4XeSw1aLPuI3Ui0u523LBo1H6dVuZYMW4AKrvGhT1ZYssHV/5JYpAZHzr9WoU6ZD
         Y4ph07qrsbiJts72Aot9oSC2+KWyHDmEJosfALWK/qsskI1dl29TxOlLvr/pBRSKST89
         kIAEcOSyEoyaLNlvZIGGIquY5pxWARPDeGMHuQYaeaVFE9mn3w3xwufkboSIfp95zFC0
         hp9wEq8Gjcl4a1jSg3CGak0ijabipy7/RuHqawK95zVxnpjGk6Jmg3dU67LfgdH2QAMS
         E7sg==
X-Gm-Message-State: AOJu0YxrS7ew+YLTvGot6Q0MoP5dZoj4G2t1553s/mlupERLaZY5rm5K
	SwjAnT8XUGPeCGlhgsGIJBn8vqIvbOUViT5bJPRTJrA2UhgX9M7PASpfuJx91EyQib3iCKspq1M
	gSTtxHgG9TkekWz2gI6z7ygMv/ow=
X-Google-Smtp-Source: AGHT+IE2H3yyCAksHT3t3bviu8YV63BQzqrVqF0Ij+6A2Xe+9CAci9NpTIYGLfiuqidjW/9c5t3iXq96SWz3W4xsmds=
X-Received: by 2002:a67:efc3:0:b0:47b:9fd6:233b with SMTP id
 ada2fe7eead31-47f3c38c4f2mr3128039137.31.1715194246152; Wed, 08 May 2024
 11:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506173110.220702-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240506173110.220702-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 8 May 2024 14:50:34 -0400
Message-ID: <CAP+JOzQHF9Y35MTVZfKw5gCPVwmsNZe4fbDk_ED2iSbXVza7tQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol: reject self flag in type rules in old policies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The flag RULE_SELF in type rules is only supported in modular policies
> since version 21 (MOD_POLICYDB_VERSION_SELF_TYPETRANS).
>
> Reported-by: oss-fuzz (issue 68731)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index e1623172..be3ebe5f 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1077,6 +1077,10 @@ static int validate_avrules(sepol_handle_t *handle=
, const avrule_t *avrule, int
>                 switch(avrule->flags) {
>                 case 0:
>                 case RULE_SELF:
> +                       if (p->policyvers !=3D POLICY_KERN &&
> +                           p->policyvers < MOD_POLICYDB_VERSION_SELF_TYP=
ETRANS &&
> +                           (avrule->specified & AVRULE_TYPE))
> +                               goto bad;
>                         break;
>                 case RULE_NOTSELF:
>                         switch(avrule->specified) {
> @@ -1503,8 +1507,16 @@ static int validate_filename_trans_rules(sepol_han=
dle_t *handle, const filename_
>                         goto bad;
>
>                 /* currently only the RULE_SELF flag can be set */
> -               if ((filename_trans->flags & ~RULE_SELF) !=3D 0)
> +               switch (filename_trans->flags) {
> +               case 0:
> +                       break;
> +               case RULE_SELF:
> +                       if (p->policyvers !=3D POLICY_KERN && p->policyve=
rs < MOD_POLICYDB_VERSION_SELF_TYPETRANS)
> +                               goto bad;
> +                       break;
> +               default:
>                         goto bad;
> +               }
>         }
>
>         return 0;
> --
> 2.43.0
>
>
