Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76413E41A
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628853; cv=none; b=ALNFObMnfuoBbfOrpb28GAIJIBwTIuoFVPjTOUZwoEJI4tu3635HArq/RAT2odXJZDTMOAmot+1NH2E4QrRdKV1OijLxZEepDsETCH7uW+J41sn3i8ruU17q6ti01pakKlF9pLOjCTze3SZkV00nIROgZQf6XgK7i74IOZYEamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628853; c=relaxed/simple;
	bh=C5iERYscM1c2IRPi8qzik4CZJoRho/DQNPQbSVOvHIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+G7LpBnBj6yiZp8zmqD0YU1ZJABlas/cJP4igpuFU+gOit3yve2E3sNx5mZ4qEbwDETb899Vm2Ud8pkY5L59hF3tSZsVOLKomJ7n7hRTJccb12FOO5HyTDI3eXPoS9GzmzK2fKyrpqrEmKxerKxd6bgNt+HFDHD8Cy396IbTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIM6IW1B; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIM6IW1B"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fb86af725so1705835241.0
        for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 13:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729628850; x=1730233650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjKEkh2fcnMq6MC7+qIa6A6k2wz6En1vF6SrjNcrkAo=;
        b=eIM6IW1BSMGMQtyzeban7bYnBdQOieA9nRAuM7ek9Sv/D70Wbd+VstayFs6jpNdvMS
         RukfNYXW9A+P/bYenZ2bFUrR3JBk9AMZSRyr0p1QZ67ubLs9hgdeOwPslTcDivQB7uvM
         h5LlnPZo7nVMEOWSpmoRVKZlK4Ve/Pi7QereIxn+lsALTafTrL2jJw3OmyEBfi3W510C
         s6VzJ5VQktPTx+1j/DFvh9vI4IR4KFKXxwX4Dkw2pg8KSy31Pt/h3tbtGR0KuyQdpUxU
         uptSFX24Q4KIZIHCvWZ+S3uRnjKQlsF74H5k5HWT2RWn4gZvhskgZA2lsv4aEePpCzYV
         awnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729628850; x=1730233650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjKEkh2fcnMq6MC7+qIa6A6k2wz6En1vF6SrjNcrkAo=;
        b=NpaJ6MzIGm3gG+WgXdG9PVuOFYsONl1FV4DuiK8DuTduR7pxB/9qGxDOZw3vvel+bi
         QdP4etHHFhtHJtjRiHZB86KGve4WqqnKLCSIOsDiV3SzCOfF48UvAARaIct+dARsfUmW
         xyX0fcxiGQo9fslb/A9uFv+Ud0vFX4XaE+UFu8R7kVr2OnRhY5/QVrgssz1QIdCIpdjf
         9Ji8XvQlW+UvwVInUbarF1nLygxohq9ycHAGAAyAqPDoLWn9HQmbbMoWNlF5wQqMVu0u
         U2raEfAGg2ykQo0XVxgaZ5vBSHLm70B66wTnce4ouQSBjoUUFX9Pjx/cfmUNFZPMeZeG
         bbhA==
X-Gm-Message-State: AOJu0Ywx5EmzcZCuoowLlRefDtkfTBdguCup8th5wmFDwUI20eZr2xls
	k1zclEjco4WlGfACPjCEUlb1Gzt+qB47UIbfG/9Owiou2lYWXivuWYbFgL736zBwkQhZwKLs65h
	S8OyisdXl1OCmOFY1JDek8E/ImiM=
X-Google-Smtp-Source: AGHT+IHQca3iUx9l+KbL1wLxQHBbxRyqIyZDLsne/10ufrxLowLb+3Bldpz3BwalifBHiuLmBAGwcSnwfFJngN00nJQ=
X-Received: by 2002:a05:6102:5112:b0:4a3:d9da:16d6 with SMTP id
 ada2fe7eead31-4a751a8c663mr367570137.3.1729628850656; Tue, 22 Oct 2024
 13:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022090314.173002-1-vmojzis@redhat.com> <20241022090314.173002-3-vmojzis@redhat.com>
In-Reply-To: <20241022090314.173002-3-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 22 Oct 2024 16:27:20 -0400
Message-ID: <CAP+JOzSyQf4NsAX7Fy28xt3NOzmPY+C5RQrQPU6V0R8bSEgP8g@mail.gmail.com>
Subject: Re: [PATCH 3/4] libsepol/cil/cil_post: Initialize tmp on declaration
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:09=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> tmp.node was not always initialized before being used by
> ebitmap_destroy.
>
> Fixes:
> Error: UNINIT (CWE-457):
> libsepol-3.7/cil/src/cil_post.c:1309:2: var_decl: Declaring variable "tmp=
" without initializer.
> libsepol-3.7/cil/src/cil_post.c:1382:6: uninit_use_in_call: Using uniniti=
alized value "tmp.node" when calling "ebitmap_destroy".
>  \# 1380|                               if (rc !=3D SEPOL_OK) {
>  \# 1381|                                       cil_log(CIL_INFO, "Failed=
 to apply operator to bitmaps\n");
>  \# 1382|->                                     ebitmap_destroy(&tmp);
>  \# 1383|                                       goto exit;
>  \# 1384|                               }
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsepol/cil/src/cil_post.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index ac99997f..c8dbfd3e 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -1306,7 +1306,7 @@ static int __cil_expr_to_bitmap(struct cil_list *ex=
pr, ebitmap_t *out, int max,
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *curr;
>         enum cil_flavor flavor;
> -       ebitmap_t tmp, b1, b2;
> +       ebitmap_t tmp =3D {.node =3D NULL}, b1, b2;
>
>         if (expr =3D=3D NULL || expr->head =3D=3D NULL) {
>                 return SEPOL_OK;

I would rather have "ebitmap_init(&tmp);" here. That is how we
normally initialize an ebitmap.

Thanks,
Jim


> --
> 2.47.0
>
>
