Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6788431E76
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975177; cv=pass; b=VHlJhiAjhubJA4CDUCNi+nLbHtbMwfxfTPyatfX3id7fLJcGYDrcWMVBXx8fPVQGyIDPgzdlP+injAAiIu+gTcIhKvYNwvW4QJBUWZ9tzjZALzzux9eNEPWa5K/Eg+I/tNuKvkfWojQAq0TkEhbwzz9U2cF8VzIXAK2mT/XNLEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975177; c=relaxed/simple;
	bh=Cgtx3O1VLk8YCSFiHhqNSUOJH+89CcOnuoclbt4zUoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rivMzG2igqSoAoffPWuxOKTj79N/6qha3jPKbcbxPCbcPe6XkmYwRPVvuqgob5VV7t9aRgg5Swit85nM7JT2wyn92z7ZYaSnIBZ/pusmyginkSix+x8wKzuqgtI7pNV0tgbyewMxaYJLv4DkGNbGw4CeUx7U7iDrnyPfKIe3zrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPXycQkn; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPXycQkn"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39f927721f2so21492491fa.0
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 06:59:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786975174; cv=none;
        d=google.com; s=arc-20260327;
        b=JnivMKGKIpr5AutMSQw9o02+DOS1vERtLasZALXHLXJ8QKk1YW2FGb3HQgP0DycMM3
         UARPj+A88KrwS85P2NJUsH79iYmd1Eq2ahwrB9U7kZG5AmtwtNjcBF6g21vyCnvElEs2
         L3UKJrvlBZjFQ9eUnOoq5yrH/Z8D1Dy5ZnGaDz6ru9Gek5PQubQsH9OfeQ2DDIjCj+Mc
         7btaU9KPEoO8/+WF8cFYut3KysL0q+RGYQMVM5/Hu2lLHQZmX+9zwiCiDtwNZatJFALg
         3D1kpfEKaccdK1m4TdaqgKTufpUEEeBkQsBDBZ4+4QBK07jmaX65HSdrNzcZV5VvtbKL
         C5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GgaOWdt8NjTl7b6qNQwatX1bwpfDKxCosbQVvwNvIn8=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=l/KyOK5s1EI0JvLGoXYTOs3KDVH9qpFRFprKoCszxdj2dt7uyl5vNnxyOmaG7mwhV9
         /y4Sd3Y6kRz8lIT8/6H9vfdsyYKe3J1KTLAub5E9hrFdOgaelpWHFu/rcM5iHOyQiuzV
         DDneS6V5BlO2bnm6xNSbp1DGdggXicxEANI7iQ6wVzPxsteVLn2Qy2/5q/7c99PPtQE8
         EsdgP7dKptHxRhHFiRv8iis0ZFvRPaVEPB/GQglavMlfXUiBXJHGmYwySGGsdmN9ROzH
         ubc9/pgU97S63Ek9oFJ3S0bu2aJFxNNvYp6jtlv/ieKdzTs/rRZFdhPF3zJhdyBqcUw2
         qyMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786975174; x=1787579974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GgaOWdt8NjTl7b6qNQwatX1bwpfDKxCosbQVvwNvIn8=;
        b=DPXycQknOqFPD6GQXtjO7ZFZaBoHVB+dQmexujsfWI76y+lg5mO+yVWAoasMFpU0Oo
         uXEMAdakYZR+Gz7qjt9Tp99Ax9jnkyXWFV14vl3/+Ps1F8ZaHIk8J+Ff7ZSJyhxX9Jp9
         QBnssg+cdPm++RC/GkgkE17ilzHnc53aE27W9iEu8shI0ectolIuDQHdRWifQK0iXn9g
         +/OsnEkrnBVts/3t2aYx8c2p1Peluj6OeLGKZbKgioWE2o6a7ghthS3ws74AArT991L0
         702f8TJekp3ES4qcRE+NOAV7zKgGXHCcKSzoMsgaXf6D1AKaLCer7OTUEqYD2xezzsVz
         +VNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786975174; x=1787579974;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GgaOWdt8NjTl7b6qNQwatX1bwpfDKxCosbQVvwNvIn8=;
        b=ogEDYaogmOoAfn+nHTSQ67s472oysyO0CyxkAPuHxkGH0Z9l2QkXWyPWaE1flRJKLk
         zBGZCscPvdBIvmIzKPEwJdZxgrjShqfJJemXWqfK5xz9zPktDKvL3Fh7rh+9b+DKDdql
         wXnbour/GgGJHZSlkvhUDwNMERv6FWFByiEqPQmwNDVAllZAxXTogEa2fuu0zdmMXlxm
         8MbHtQ67DC/JoQ7At6Svfz0i31jcFKI7btULu1X7JmEprxQtAg4CanQOU/OnZNCSzyIw
         EhorMWFuJ/rag9ALTMFFFfcuCRU9RlHdc1XOxgX6jxlv9/9Jf1+ml+rEns5KZIMRrXwQ
         kp/g==
X-Gm-Message-State: AOJu0YzOcMKdpTA6rFj80PmNXIRf4xcMO/WgHa3NrIdUotT1SFeTsvAA
	9LQJiMRTQ0JhvRvQMLvROULlgsv6v2IUaaVsJ73kEX10JFRVlK/Eh+wu+1jNqN+19oyM/ZaQTUi
	K8XIE+46ZlbP5l7Voz1z9eX6ysYwu5S0=
X-Gm-Gg: AR+sD10Gzv7uH3E3+9/NwtCzxL5asB+H809i9dYVi0oi3f4YL7Iuk+1QoGwFM9XOUby
	PZHn/vu24NENrRbiUd/f6OogRRvzbA+eH5qcDT0G4hFhqouayuuQfRZnF3HVebHaTM3AGdEfEK1
	lif/+v7+PGgmduUjdzn7Duo9a9j1SJgEzFAYd5bVXt17JYe0XPN1gBzrL1az9KhDGSsym1lMY65
	qe/4usq3R2S4dexIkd6ky69PHwbxY6dH+B6UgYL67t5/FG3LB9GMKQadiggFa4LA4ls1xp6ZhGz
	FxH6NwDp9tDIFmg97wP655opPOzz2idd5cfNvmXFHw==
X-Received: by 2002:a05:651c:a205:10b0:3a1:4b92:76b8 with SMTP id
 38308e7fff4ca-3a14b927e42mr9904061fa.4.1786975173406; Mon, 17 Aug 2026
 06:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813184042.185689-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260813184042.185689-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 17 Aug 2026 09:59:22 -0400
X-Gm-Features: AcwNN1UbfRQGiIoTgU9u6ZupnNq4ke5FrGQI7MfLoPjbvOEY1Cc5zeD6q0zg-NA
Message-ID: <CAP+JOzTUaOSwBfiEmCf-9aB9qZsSXknbGKqr31M6=vWj+NvVoQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: selinux_check_access: fail cleanly if
 avc_open() failed
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 2:40=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> avc_init_once() calls avc_open() but discards a failure result, and a
> subsequent selinux_check_access() proceeds to avc_context_to_sid()
> which now hits assert(avc_running) and aborts the caller.
>
> Latch the initializer outcome and have selinux_check_access() return
> -1/EINVAL when the AVC never came up, so callers see an error rather
> than a SIGABRT.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/checkAccess.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
> index d8f485e9..3cdd2413 100644
> --- a/libselinux/src/checkAccess.c
> +++ b/libselinux/src/checkAccess.c
> @@ -9,14 +9,13 @@
>
>  static pthread_once_t once =3D PTHREAD_ONCE_INIT;
>  static int selinux_enabled;
> +static int avc_ok;
>
>  static void avc_init_once(void)
>  {
>         selinux_enabled =3D is_selinux_enabled();
> -       if (selinux_enabled =3D=3D 1) {
> -               if (avc_open(NULL, 0))
> -                       return;
> -       }
> +       if (selinux_enabled =3D=3D 1 && avc_open(NULL, 0) =3D=3D 0)
> +               avc_ok =3D 1;
>  }
>
>  int selinux_check_access(const char *scon, const char *tcon, const char =
*class,
> @@ -33,6 +32,11 @@ int selinux_check_access(const char *scon, const char =
*tcon, const char *class,
>         if (selinux_enabled !=3D 1)
>                 return 0;
>
> +       if (!avc_ok) {
> +               errno =3D EINVAL;
> +               return -1;
> +       }
> +
>         rc =3D avc_context_to_sid(scon, &scon_id);
>         if (rc < 0)
>                 return rc;
> --
> 2.55.0
>
