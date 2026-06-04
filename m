Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004E349CF3
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600741; cv=pass; b=qulMBPywwOKbroZEuWSU/dZDH5Y7BU5qqvLeAItKFlC2j6IAk3mzL/9MC/8KE0ZRcYd7+AqnDwJKBUqnrOtQ3r7cfsw7BZgAzP62desHvpEdoaXk7K/oLwvVNC0nzfb5hQFXqq2VSjpUki8uh9cSC7HiLc73jX8gYwvIwGiXJuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600741; c=relaxed/simple;
	bh=A2gqq95GJEwxLYEaJi85QEUcYQkhn1AAdF4Ripy/sV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Khc1Mm0Q7kisIFGTm4TvdAZ1ZbYqwLCJodbeY71dZKqyWOL8qGIWq69yj5y8McMPHXWX+rmEbZ9E62fRz/udjHzYSLndfL/uDMMVVaQSQthc6NRuSrK/Z9IAqSNO6fyM72c1mzoajb9foISrbU7RnxxhHvC3MHgBIk49Yz86VUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COa8sp6x; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COa8sp6x"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso764137a91.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 12:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780600740; cv=none;
        d=google.com; s=arc-20240605;
        b=OEr6UR3Um68SRyRt8qW3X7sSrgdy0niBDDTNTQkOgIv6ZhbjXkDsSHM4XDlBjg3Lgg
         PjYrYrHUjv6GyS4pKYF5821B33DD6eHLgDaw4GHZrCLmxOdHPQuAXTjQF0+2Kzltsm3J
         2yAgfjk6bXEny6DrAQDgu9Z/7KY9YmNwSzmSiATK0QAV+bhj/5bPJh+mcoXUNdHEV9Su
         MMqPKpMcYgKWzlEyGCnMOcneBXevGD8jms2ztVOMMAjGCUMRwbre3XeydQFlB5j4yMOd
         br+FNUKsXwlA0vQg5Hap77qx6J1HKWoEVEX7pcuLyMdhmeioas9FrnM6pMuUC4guHIi2
         ujEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/ZX8nKPl/YAmewQIHb1lZQpaItlFxXyLV4wfbJHQXE=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=c96cLCZG9H5rIuBLPozLNWEhbObOiH6k57Y/ckjcBtYpTEjKC3YK/CT5gCLZJczbn2
         KUAbZkajUY9rBzL52symsvPXOMPP+b4y46BFg2E52Co4JoRgBZktnuhV9tet3WkgUcn6
         2V8PsuKVapFeoqeOpM9lMz5QIMSUO2xstq28LTR4nPKYPozbGITxI/TrKaeBkqAUlPmp
         GmTyupWfeEIIkf9BQgfhAIiqKN/G9nIPRk3rky5iV4EOsTNaBIODsq1bDpuIDbTDtL8Q
         D80JwbrzArzAkFrbL49g/B0Q8h2K+IcmYUYirtPwSuCzrd3Z/l/ORUAv0MMWV/LBu5hg
         LEiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780600740; x=1781205540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/ZX8nKPl/YAmewQIHb1lZQpaItlFxXyLV4wfbJHQXE=;
        b=COa8sp6xMJL5kwjww8LxQAuUP0rIrCgRVawrleB4gopOdG+shFEBBfWLaDYqizAE8N
         +eRLxrZNC0rt0KMA3D5MyR///dcDVbDmuJ3q3EaeVmt37vFMueFJXqC5WM/uh9yfiuX1
         rcCFAIVI96/pRngo9WEUVNzAgH8F3mvppx9OVcU1n6TNp5Z2XeT/4FUfcQXoX8XG9G9H
         IEJzn4+3mOVF7o557dSZhzaqWlquuIECTbjpt6TGoQlzwurAH/l6AWxlsxKWB2kTvASr
         BTCjI4yiv5Vko7phyeLCe8hYdm4ypdYyik6LjUfCEVzMzyFa3ZUzs1swK+jsIX5OcBx2
         CnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780600740; x=1781205540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u/ZX8nKPl/YAmewQIHb1lZQpaItlFxXyLV4wfbJHQXE=;
        b=oMAmN3Il8f8JBu0vPq6nGHOiorHGnap29B48QWo7IIe7vyXh7Yp7Rice0WEw2VgAgY
         cR4Lcw1WqLaGAsqbCqr7xH6Q4aZ7zRSb8EZ6EXxb7Wo4DphvMKx4S6jN3YfpMNB+HkU3
         AOGsMBQGRkODHfsLrFAyzDpK/LP+j+eFAZ/woadueay+MJMZRV5JE/nF11o3Vm4Fxpeh
         VOGRzRwfccaZKnrkmvCjNzZXrBVkk8pY6zD5YCJfpo1UToqWqbs8UMTxBy1v18X2tZfi
         ovDJhAfCraPSsAUEavqwnDA+mcmwDTVMOZYvwWK8btz7YY1W7J8+7ekwp2tfG/hKhNtL
         oldg==
X-Gm-Message-State: AOJu0Yyxd21uquCwYypQ/MMoHbMNFCy3wSki2moSladPmw3IQGHwARYd
	wABC9JFSzGrL0fTrS56YbXRHHz9O7aNgvA8Th0uNuGT6MI4t5BEvlSEgKqupMI9kkQ5TKuXDCLn
	dmkVLwfR+99TQrmT6S5TbGDdpqS88/vM=
X-Gm-Gg: Acq92OHG6L5Isd2sPOGGbcNH+SNf+lGQUzMygfIzuqQsb0v2aV+KBh1vA/zpPO9z5Jp
	lA/fZpl46hJN3sdTWdP0mLAzmG58giHB4bdtjxRfKk5eHdfc7pSB5KA+mJI0eV7Fogb9YfbNDBQ
	jv+DzaLFDNt7QzLG4pNeOLwOy+UySTBRHFvQ8GAPkWmv+IZgJksQyuQMH9jPnD/Dd86BEsr3KOt
	LNmDu7XnnJbrCO/BWBHoSgiBugN/H4h7T+IXbqFNKv9pD7grYl/sbtgknMeCNGkaaMqE21SYNLc
	sDNyhsTVCZzIuglUTw==
X-Received: by 2002:a17:90b:4990:b0:36d:649a:39f7 with SMTP id
 98e67ed59e1d1-370f0579c09mr281039a91.22.1780600739658; Thu, 04 Jun 2026
 12:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604191727.52013-1-jwcart2@gmail.com>
In-Reply-To: <20260604191727.52013-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Jun 2026 15:18:47 -0400
X-Gm-Features: AVHnY4J9MNjtGd4wH_-s-Qg_p4gRRXGdqNU5zz9SKFu-W-ZOKaqIIiRdku73Mcc
Message-ID: <CAEjxPJ6W9WpDmy-=eWx97OTpOdGyc5ypC8ODUEiOu8GE=9HJ+A@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: Add check for too large of file size
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 3:17=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> In cil_add_file() add a check for a file size that is too large.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2: Add '\n' to end of log message
>
>  libsepol/cil/src/cil.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 83377821..18b98fe2 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -549,6 +549,11 @@ int cil_add_file(cil_db_t *db, const char *name, con=
st char *data, size_t size)
>
>         cil_log(CIL_INFO, "Parsing %s\n", name);
>
> +       if (size > SIZE_MAX - 2) {
> +               cil_log(CIL_ERR, "File size is too large\n");
> +               return SEPOL_ERR;
> +       }
> +
>         buffer =3D cil_malloc(size + 2);
>         memcpy(buffer, data, size);
>         memset(buffer + size, 0, 2);
> --
> 2.54.0
>
>
