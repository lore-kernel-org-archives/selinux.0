Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AD46D2D7
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813495; cv=pass; b=PnbWOsMcEQm9RUksiESaynCORLJHUVOHdzLLbQBg39gzbfovEVHNKcupgMOCjzBC5b/hZTb58ASS3kx0kN5a0Hn+VIJN+3dzRwJyCedzksHiPuNIvz0vEA3AyICrxbqsmEJAM1rmwDOxp5JyO0x9fXdVQi9kPvj3eNeboEE5vSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813495; c=relaxed/simple;
	bh=qInZd17sbWIkl4eX3GdQ1dREo5WubkuCexzPI8s5UK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVHVEsZ14dkgPOgI4d9wKz7MTswUSbJ7wuHkcj4gk0s5TtSldMaZIDuN12XhXC6SUxOSZ7zYpI5/dz5K8iDOTRb1tTRGlFvW8joSI7GldzVzrBJ1fGU6yk3oxbsxPsAiveDtkS2EXTN3Fi4vcBiPcnCxTtK4XU9IBTnH+LTeRXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhMhfFH3; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhMhfFH3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caea3f742bso8127475ad.0
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 06:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784813493; cv=none;
        d=google.com; s=arc-20260327;
        b=L2Ku1be3WaC9TTldYhGSKm3I82hLTCwY61owv/RfisSA2RY24QXh2ucDLR6HulACW+
         rswa5llA2ksXqwF/8IJrMJyvyyM3Njt7bpiHsX8qYUt0qvRyLU2WqYqhun7PhAIxbIEk
         JY6PGZqI7flZd7gotXmuaMHFjbvTI3mfO4MGEXbeHOi0rB6cuJVAHP9xIAk/Z3hnU8D0
         r9hpaYTBBYRafPusVl4k07Bcuhc1j33KwYow7QMpPAy6KfEBVSpHKPruzDozQmds+3j/
         KWchzHMhCRE+yAmh9rtnvlHIvA4XMKS4k/z01IVcmk/1GS6iLrCiZvSALsmyvKe5Ftl+
         rHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qPSpR7jImQZb1l35NE68FYO6F3kDDEyvHg8vL/r8NFI=;
        fh=sEXXZHHOaetdSxeivqdrIFtWFCVaxn+K18VHEkjIQmI=;
        b=VIPIicKwmUH2M1wb/gxcdLoC+4Z20VImfZ+bOhv3zzjzwrmxm2+SejuCXrsi7To+dZ
         lLCgtgp+v7eYAyQaTUwkuvGNFQZVTwdEjuXcdp2C+mcXZ/JqfLOBtyymWH7YFeo1zKkm
         XTlu+W0pfyQqf7IvLwvilrrFVLyOV54Xxa7QK6Fyn+sHm7qcB7GrO9gWWeiiJ7M0IYEe
         haKMQEGsQjpdptx/u1C9kOXQ8HRv24bL/sdUIPplAcxhEm8Gj9E+WbI8zQ/rHweCE6Br
         We37OpGZNDA5xlVUQyXi64oh/A6AJjhjRi4HO3H8zKbC1Xlf6yvi+4b/ySoS9IRLdrp4
         Xs1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784813493; x=1785418293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qPSpR7jImQZb1l35NE68FYO6F3kDDEyvHg8vL/r8NFI=;
        b=ZhMhfFH3pIAgXhDx40KwytDEsFs1/esbRlc7VcZ8IeWJzT1YngCu/VMbO508ZbYKkU
         mErtqIQShqr2KDo5CKmHzOPnWs1RT3V7VB3mVYVOQ4dx+p4pQ6iKPFYLSQppnvheu5Tz
         ScWpnQUYM1dYhLBj+97CSktbrBTsz4rXFZ9l75tyzuby4rCpMf1T4vnUZTiO2WgWnFcF
         uuhZSCMQpXs1rLN7wZi4/iy4sKYAhnJajrAkJO4UabaJTpPNg1hDChE+S8oJJiybOHzb
         7mdnGb7bq5Oj60BVWUcqIdmX+NpSQ/egtoGR82Z1wG90uWkSsiL8w3NBElV7KyugjjdH
         zH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784813493; x=1785418293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qPSpR7jImQZb1l35NE68FYO6F3kDDEyvHg8vL/r8NFI=;
        b=kMfZPzgedbKqF7sFVppDj1XH+kGRvPrz+ButgNDe+4sntArzSs4080bbHfmwMGB+fo
         /PYCzIowJG52bQiBkrNrHdXXf/9o5MiPP1cM79H56qzKdH4uhhLxY9N7pTH+anZJX3XF
         Jf6fje/TWHdQIF/alfyS1CR+zI5naBsBidFmDZvAH+gzcmVcqlH8by/LsNfW4J386OMp
         IzGB4Sk6nQC3/meegY31AaP3Bmii5BpZB690uNcXQcDJRxk3KdgOJMKTmJBB34CVe41p
         ystTPIzv6A9m84b60DwGItP4RICef6lz98i2USY8yOYzA3DzoVaGjL7RP+5egs4nXQDx
         uS4Q==
X-Gm-Message-State: AOJu0YzifxGaNKmIAiwYrHzNloZPMePoGWvspA1xGhgYMaz6uEiuLHOG
	8VUxVuOrs9smZb2z/s2HYKLnRioEOqa9C1QUmDJQqcGDWrs7NQEfENFqBbooVyH62J32/nPa01o
	vm9r5UoJm6RvQS84qnZKXK5wa+ik3OxY=
X-Gm-Gg: AR+sD13sZhEFeofqDxgAAHmn3yDLpALsx6Yw3rIJS/QTLtzNycrNe7cS8R6Ruotc338
	LuBe7a0f4cATGQCOKm7iraF0s6T5lPlZohTBJFgYW3lo9yFJIZ8QKTqSd+UI+JM6Y0yNGCXUI/E
	JgEeg3wmYe4g91qJK+1v8oHkDFslNiF1j9udaO7NqGmydKld9VOORg+wxpmETluGGYatASOEOhY
	7InXtOhoV97FJWl3tmoG/Rtajg9JMhaX6TU0anl9xYZXjGRdLYF1hEqbyL1lll7+9fB+LZE
X-Received: by 2002:a05:6a20:1604:b0:3c4:46ca:3350 with SMTP id
 adf61e73a8af0-3c44af7ab82mr3599331637.6.1784813493101; Thu, 23 Jul 2026
 06:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723062355.3096648-1-jason@perfinion.com>
In-Reply-To: <20260723062355.3096648-1-jason@perfinion.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 09:31:22 -0400
X-Gm-Features: AUfX_myD_ueoamMBi9443ssOb1zYTK1imp13zDSeZ7w_2ZSotWmRaDMyCFl3qxY
Message-ID: <CAEjxPJ4cexAeJbQdDWzD=NiyukP_THb9PHhTYi=n8ww+3bwrCw@mail.gmail.com>
Subject: Re: [PATCH 1/3] SECURITY.md: Update security contacts
To: Jason Zaman <jason@perfinion.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:24=E2=80=AFAM Jason Zaman <jason@perfinion.com> w=
rote:
>
> Part of the annual cleanup of security contacts, drop people that are
> not as active committers currently. Thanks for all the work over the
> years!
>
> Signed-off-by: Jason Zaman <jason@perfinion.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  SECURITY.md | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/SECURITY.md b/SECURITY.md
> index a1d02c4d..49c40e97 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -25,10 +25,6 @@ the issue before it is made public, but we will make e=
very effort to address
>  the issue as quickly as possible and shorten the disclosure window.
>
>  * Petr Lautrbach, plautrba@redhat.com
> -* Nicolas Iooss, nicolas.iooss@m4x.org
> -  *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 C5E=
B
> -* Jeffrey Vander Stoep, jeffv@google.com
> -* Joshua Brindle, brindle@gmail.com
>  * James Carter, jwcart2@gmail.com
>    *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 62A=
E
>  * Paul Moore, paul@paul-moore.com
> @@ -37,7 +33,6 @@ the issue as quickly as possible and shorten the disclo=
sure window.
>    *  (GPG fingerprint) 578C 4211 832F 0A7E A2C5  A7C2 21A4 6E60 3F74 4EC=
F
>  * Jason Zaman, perfinion@gentoo.org
>    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EA=
F
> -* Steve Lawrence, slawrence@tresys.com
>  * Ondrej Mosnacek, omosnace@redhat.com
>
>  ### Resolving Sensitive Security Issues
> --
> 2.54.0
>
>
