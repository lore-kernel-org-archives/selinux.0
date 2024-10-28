Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7118BBB9
	for <selinux@vger.kernel.org>; Mon, 28 Oct 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135744; cv=none; b=nB/z5ZMoKOU9p3Jp1AwcTt+2u+gRtkqzA4oVF8fPhbGixE7ZSisYd7XWVGkfBOkHPO6ZC93Ur6tv7JwDPVm2Dimzu3fWbOUUobPXwcMxzY1Ajw+EVlNpF1IBOPM/821FQG1Lz/Qp2+Z+1uLottZzrj195vTSpiT0ZjuyNtimECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135744; c=relaxed/simple;
	bh=QaqQbDeN4oy5xyJQDH5xHUGeiBWgeozW60a4gidVw6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPTFy+SSz8Bi5VifKP6IpXQ0V+dTTHqIzP+xqiFFjXr0fTYuMZvo9ekv0do1Qk02ULGHZhe4NiSqKnIB3kEGfNFgSlz2bBaPw7iB2MPanlbXPB75J14AzEbkzR3dbp3NFQmM+Ftz1zu3aafw+4WS9DIVGa6hCAktZF7RKiuR0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UesYYiz2; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UesYYiz2"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fd057a993so1382863241.3
        for <selinux@vger.kernel.org>; Mon, 28 Oct 2024 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135741; x=1730740541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIvUv9t4fCtRipHcKMJJWAPMHxIaw3BkfjmkqJUu5ig=;
        b=UesYYiz2ysAA3J6xD2TS1H88mhfQWUTRJIO7YiLJDTPS9ErTrbbGHrc+KFljLlSQwt
         o5oNYeF4m/IRWjPCTjzG+sA38JEUX3jcxh0fwMYA2/tszPNJJlC4eSJvuigkTIeuS2Et
         L2syOKUvFt4uJw251XeSSNNMZfWIAn32P+voh3HMcRmimfD6hMAI0ceHCF5a/LVp8rGp
         b4KeK71NvjLuhS1Lq3mrsRbRRsBvfLSdU7Wd2EWWBO6w7IGFDdPUtIoqQ3LX8seGqcZP
         otETgTkO7iuLdoFEvcKWJ3UJXgCdagbS20qH15GVVgiu4V01+8TCe4vMjJ+HNchafBlJ
         biDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135741; x=1730740541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIvUv9t4fCtRipHcKMJJWAPMHxIaw3BkfjmkqJUu5ig=;
        b=i1rFvKferFdZjzNjRoJHBPXCuefHyJczSnaY4cxqqvlsZ2sP4OKKzfI2DvRDovpfTF
         T9UDRoCfwql/J/qXQg01TTm+t1igq4JHjKHN9IDdgFZBY5NlUDa3UpOjLJNbuszWg7o4
         YCgsKU4XEwoEQy+yrU/cFjXjK7Vie3vhG0D9p4MzaWR5T0fRDAKBsPYq1RNqpWj5n4IE
         NtZgbLXr6sCn+D0mgdUzjsE1CrL3XTsnGHhJXndwF3Nl7yUP+npqC2em7ys/Pb+bNWmu
         VkjxK2b8c5JFoA8sjIiFHRbs5tRoGljbZx9dJd678dbbW2cEUsLkheniO0j+rNm0yDsK
         YmJg==
X-Gm-Message-State: AOJu0Yy1ZBgwf9VdrG9wXpDATYQgdKebS52G2SDqVlqzXBA0dr+x2AsO
	wTCW28ioZkky0JE93fhYOJBuUbhUXJOq9aoJdOwAR14IUuVn1GWygXRr+UosQKp+VCtAHJBEMaQ
	UUzXpVGI+AgA59HR6YcsCsUAbvBgqMYyH
X-Google-Smtp-Source: AGHT+IHa2ZxN9mevIHrWSKkG1bNVBnReOVEg73LoC24VUaJ/jSkV1eNSSjxTAQ4k2AxwY7YKOWlut55huN5+ghYy4wA=
X-Received: by 2002:a05:6102:38c6:b0:4a4:94f3:7de4 with SMTP id
 ada2fe7eead31-4a8cfd4fb7cmr7492198137.22.1730135741287; Mon, 28 Oct 2024
 10:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025183014.1826149-1-vmojzis@redhat.com>
In-Reply-To: <20241025183014.1826149-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 28 Oct 2024 13:15:30 -0400
Message-ID: <CAP+JOzRxvQM=2oUEcrcPn=2OU1oh=MTT3C1zQajo0CMsyE6=hg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux/setexecfilecon: Remove useless rc check
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 2:31=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> Fixes:
>  Error: IDENTICAL_BRANCHES (CWE-398):
>  libselinux-3.6/src/setexecfilecon.c:45: implicit_else: The code from the=
 above if-then branch is identical to the code after the if statement.
>  libselinux-3.6/src/setexecfilecon.c:43: identical_branches: The same cod=
e is executed when the condition "rc < 0" is true or false, because the cod=
e in the if-then branch and after the if statement is identical. Should the=
 if statement be removed?
>  \#   41|
>  \#   42|           rc =3D setexeccon(newcon);
>  \#   43|->         if (rc < 0)
>  \#   44|                   goto out;
>  \#   45|         out:
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/setexecfilecon.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/libselinux/src/setexecfilecon.c b/libselinux/src/setexecfile=
con.c
> index 2c6505a9..4b31e775 100644
> --- a/libselinux/src/setexecfilecon.c
> +++ b/libselinux/src/setexecfilecon.c
> @@ -40,8 +40,6 @@ int setexecfilecon(const char *filename, const char *fa=
llback_type)
>         }
>
>         rc =3D setexeccon(newcon);
> -       if (rc < 0)
> -               goto out;
>        out:
>
>         if (rc < 0 && security_getenforce() =3D=3D 0)
> --
> 2.47.0
>
>
