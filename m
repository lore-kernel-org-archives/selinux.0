Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1E35CB6F
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922982; cv=pass; b=K3o6dVE1Qeu6heaEuSU7vwcjMi3uVNkSNEcvFmb5wUmJtJjBnzGtPleJWCNoYJOKFW62LMT0Aokb4m/uOsEpquTpmj3QcNemF7PNzzhO1uu29mqjqL/SwJ74oHjfSVtYENgL/wkYq2uC7BM+w76beAaOlx55qQFtBgRM0BIqDYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922982; c=relaxed/simple;
	bh=xlO2lTkV0Saxtw64rHiI3e+mG65qYo8NXaXdnqdC/vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEB5iV+wNxBBilciXxDGADRkBYoxELX+v/+h0hSL4VNsX8BtNvk+KGj2AOCYA2p/L06g1B7h8x9K3H0KNsg+aZmxzQGD8uK77tuNHOUv1IAlWjmAaix5toBnrFvMqfIryWB58Ekt/YcVj3oI3tHVtAIG6T86RQUC8u5+ty2RIXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEX5bNmJ; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEX5bNmJ"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44856d185bcso597917fac.3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 12:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784922979; cv=none;
        d=google.com; s=arc-20260327;
        b=syvOXojiZc/nge+uz3MRhiOOTgQbDX3UAR4+xGitCoBJeqdno+cQOHBjkoLMq+Jtzi
         CSjv++VZ2v20aXErmdkQgw+iE2c6oNezzU2GhK/e37zUcrQFYM2Q/pZv4bbXkcZKdvr6
         AiX9fpC8upD851Wyjd11tNKer9vX/rR9ZOkjUyXhi6nnyxSialmruzRipw6YEY8/aQw0
         xa8KeNJZ62K2u1zJkB+xX3vua6QI5mVbH0sRbWzUfft40LBEPjt3Ks7znreNNO5Evu9f
         I3Q6W1QJNW168OEce9d+zk04lcXFDjpr6DzJZbQNZ9QDoWCyJVXDufaPETn9FDX0qSPW
         kzPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WZP6ZWqLceFT+VTVrnVJNQO4m2ZW1T2XmzWNVIzytFY=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=HVZe4Hf5QfPDGG65UQTemIoVYj3/oGwkGRWbM8ZxV03Tk6gZJWZJ8Muqv8NHqfX1ED
         A5vohZHm/PembarkoarR54gFW5k4yq2HoiDKW4OJDC2CqWnB1E9oAH9gM6WCa22aWXpc
         OpZeTnEKqWLGfUOX9Jrm3wOlWjBs2/XXIG9rFiqT8Ukxglr2j4qsRj7J+J8ytietEk/O
         w2Z7vZZ1jCJ+VVhcilHcAz98bv1diIsA7o2YEzgZeLGP3OZkUyv+azncb3/TjTMFyz2e
         TeOMPAIQsSHekUZtQweUR8Sd640oAQiSJU4zvmeLtq+xiYqB+XYQ0Jvkto8vUCLXKe78
         o8/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784922979; x=1785527779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WZP6ZWqLceFT+VTVrnVJNQO4m2ZW1T2XmzWNVIzytFY=;
        b=OEX5bNmJlj90kTuayET4pyU73wSSq4deyV3hq4P7C4sTOHr1SHioXdEvMJ6YtOh6Fe
         IOdS3UkFo7c6c8MwLf7J0f73C7rYqPSkMk72sjx6+6X2HZc9KKW8QRBKdDxibtZ4Yzjn
         DnOMLIFOX/VSB+TaKDrV3CK06we4nhCzmNNZrCNaqeLtVA0aznWNty84cnVYfnutI0nv
         iMNrIhMuWsaLTT66hpsE+ATtpnfmG/JBXs40FqBZ0hGVS+uVyUuNyahC50LLpWzaO/Co
         9QZhautO0BsmRX68nijwx8ipRD0Vl82mL/1W5RyjU+pI+l+rmFMaWq59iozTEIGXfc3q
         Ytfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784922979; x=1785527779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZP6ZWqLceFT+VTVrnVJNQO4m2ZW1T2XmzWNVIzytFY=;
        b=FaVBveDnzJ5ROINeR1nUfIrU8R9UehO4yFeZY7rHi2i9RZYtX3iKvcq5gdBGsVpJn4
         628cEWCaMZ7Uu1HEeSsGRHc8/VAKuN89HWQG2397rnZqHQXyqhkcTIziWYSeNR16/yD+
         DfLFpM9drDrnNHzvbaAQxZ3iRgq+VDwY+88QgTDiT7Q6OwLU8ve0idiYkkqGeO1NtCsh
         GSS2LZ5JUIQed4rPOc4K2qLZqmpF1A7YaaPpyv6XurKwg9+p0w+zZ2SB1snLFCLEwRwe
         C8fuVROl3jKowX3Ob9AD5p38ZZo1Ls1GHH4wHVjy8UUUp8cfg34c9t6K38RqjUeFDoKW
         glxg==
X-Gm-Message-State: AOJu0YzTGNJbo8aK2oXye50jKig8sfMPCI09pIKAmh57nVseDyAggLf/
	A9N3qt15es2ok7WEopgqhX5qges7qyy8q0osPwTPVFGPKJnNqQPUSOKbL2hVpQSKe5rbzpEZS21
	AC2AHML1hqhlW2cqJ6WNsli11S34n/r9OEQ==
X-Gm-Gg: AR+sD10g0bDy2vqiXPcEca3NInZmjGx1uvpK1rKo+jo3rlQrVztrjjOtCxVSpVIYVnA
	cBZ5rh45mb5TTx4cQHzvWj7vjkaqwJeZU+C4C47/aR0laZF9XcrsaRN+M7eiLbmAjjoq+JbraWF
	j0Ufutn4Q/LMYSLVkwF/X5B0MGdCMLUPw9xDlEMC7aKo1U4jE7jcAMVkxHBN6PmauPunXIX7E1A
	PQp6DS/AgE5q3+zV+0f8cUVpvlPtp6v1zvb+9trSUNeqhbZ3XgPfJtzesLmKw==
X-Received: by 2002:a05:6870:2896:b0:43e:942:dfab with SMTP id
 586e51a60fabf-457a1081c87mr5938699fac.33.1784922979295; Fri, 24 Jul 2026
 12:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724192831.106384-1-jwcart2@gmail.com>
In-Reply-To: <20260724192831.106384-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 15:56:08 -0400
X-Gm-Features: AUfX_mzk7M4C0KSIxkwZSlxdR3qo95lFHtIUk57ntWXIvxmc7adbCISDFioyw40
Message-ID: <CAEjxPJ7O4gO2cCYVsqrxpsN4cNHpMEi88HTNTM6c+bU5Ncs2aQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Add overflow checks when linking file and
 netfilter contexts
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 3:28=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Use __builtin_add_overflow() when calculating the total length
> of all the file and netfilter contexts.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/module.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> index 5fcf5870..8aaa693d 100644
> --- a/libsepol/src/module.c
> +++ b/libsepol/src/module.c
> @@ -249,7 +249,8 @@ static int link_file_contexts(sepol_module_package_t =
*base,
>
>         fc_len =3D base->file_contexts_len;
>         for (i =3D 0; i < num_modules; i++) {
> -               fc_len +=3D modules[i]->file_contexts_len;
> +               if (__builtin_add_overflow(fc_len, modules[i]->file_conte=
xts_len, &fc_len))
> +                       return -1;
>         }
>
>         if ((s =3D (char *)realloc(base->file_contexts, fc_len)) =3D=3D N=
ULL) {
> @@ -281,7 +282,8 @@ static int link_netfilter_contexts(sepol_module_packa=
ge_t *base,
>
>         base_nc_len =3D base->netfilter_contexts_len;
>         for (i =3D 0; i < num_modules; i++) {
> -               base_nc_len +=3D modules[i]->netfilter_contexts_len;
> +               if (__builtin_add_overflow(base_nc_len, modules[i]->netfi=
lter_contexts_len, &base_nc_len))
> +                       return -1;
>         }
>
>         if ((base_context =3D (char *)realloc(base->netfilter_contexts,
> --
> 2.55.0
>
