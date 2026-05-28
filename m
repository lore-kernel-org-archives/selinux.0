Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F653EF65D
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971724; cv=pass; b=ZWtivQUgw/hb2GJxkWuXJgpRC4sW4AFoAeGUB7d/TUlyVRjn3yNyBbPBm5u0N35Iqp7SvHyjF20cLyZUlaXnVCxgGhZf18WTM8Yr9g9ecRdBi/Ha2OYA5FBmT8nAuv6HWK6Etf/QVTCm2jjg2HfqiEjY70ruboqKIuyNO7QxTCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971724; c=relaxed/simple;
	bh=hEIuO4cU5RSbFtpW/SpDWe1R6b76lazbKcWip2HeXyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTariHNow9CejUFFeAIAeFF7OSWv2snlNF5mgZX1opP/tt+n9yOihIPHmZKZ01XhKzxr+G9EnfNj/Dzfpz44eDVVhiEjnpqbN6kXGNfj8E3dzol6g1O4b6sPD5686YzaqEgvl4dlDtul7kWtvygDTaBmLzqLGwCYAi4MDDygwsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPhGNx76; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPhGNx76"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-841f722ac93so176957b3a.3
        for <selinux@vger.kernel.org>; Thu, 28 May 2026 05:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779971723; cv=none;
        d=google.com; s=arc-20240605;
        b=jyXrCv1EioSMksjo0J3BYdNL76vR+5yPjsLPbgTDLD8lHKDowEDdk5abRV8ICvuaO9
         XeIrfhSEwWDYr3OovlOBGcx24iLydwdDyr/Va1cthrgyTiY8ZaT0s2O6+21PnTTPvvjz
         FPt98Wc2jU0QmaSOqUZ4bdjKDJhcm8SPGhWn9GTzIeXtZveJGvkq+fkojQrUvamgJrGj
         jEW9PjfooZDsK1NYffwyFju1VWUs6XkLSu4/LwuzafSlmGeQkQQZLXc+6E8xcHoJSU3u
         Knar0PmQcMg8T5pt3FkOb29UeEiNa37KBf6IDYquf+0VKF6gEjcwW+4U9vTF7U7A8sRJ
         /Wcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LgLGmfDeIpkvRfmngkB+ba5kvmd/edaA9d1eANlj3s4=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=HcGXaJnRPuRmh1hoKmODccfzneZCbFhqxvuvUfKkTNIyykKjgnd1c9A7psRsSkKKs+
         PgktE/dz/E1NIFOqzzewpJSkx4PCMNDOZYfTQrgsxW30JrOpsfamtXdkKH68WXUc5P/w
         7pZK9fr3kq8k9VcBeKXWRydA55gPv3r0uyVqAMjzye1J2EWbR2912/O2VRd0vdMdTd0u
         lUoAByzLzAgqvnoQxB0R0kF9QAcTlSYvO/dJJi5jJS/QJA/olRimyiG9YjGRMY1XrwUh
         /H2ydQuWNUG/3hI1UgphrJM6X5Jt2N64tzLxLDoT0CUuW0ispnY3TZYsUE9Hk4QILzzR
         icaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779971723; x=1780576523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgLGmfDeIpkvRfmngkB+ba5kvmd/edaA9d1eANlj3s4=;
        b=oPhGNx76IOo+A+BCy9McdkN8kBlscdST1/YgzokUWkNoPRa9KqsihGYHz6IsMJ2GmT
         N56DoPztiq9iKRWSd5HRArga+Wl8EXnnUAKoBZkay8jyHsQfd46EzwCc4f2jnAuzzqcW
         qlaz2LZeCJpiste7zLlusnuw9mbb4nmdEVWvTPmxwUg98+fkxlwAcvHZc0atBPv47WQ4
         AGJ1WjTr37SaGOfAOxXeuT86axp8Fe9eY02ALY9XHTwe4C7/8CAfBS9Q7j4XzfghfVpq
         XePj6RHpnyFGTV14pbWiLp8uYFAu5Dx6lhBjBotbgxF+eBvMDihfEmTaAenHAlRAm8C7
         J1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779971723; x=1780576523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LgLGmfDeIpkvRfmngkB+ba5kvmd/edaA9d1eANlj3s4=;
        b=XCU/OShBPogplqRhLQb7/lmgB+vVKHw0V+qhZZaqRmpAqprjudm8w774wj/SDZThmx
         iHRwt4Lac3OMc/chTqx05UWg04MUMZbrukY9n6aX/OplWS8N5/5lB6sQj3b8pvKTtW4Y
         FCKKJh2da0AFfizVnSnbQUzoUDQW3JT+ngxr7E5aT2vwESn4+x55HeKEtS6JwfIy38WL
         jn/2zPcc8kk9GOsdNm5GNrgoDZgGyo9Q96FPpiOPBhC9OMGpxxTkJpNknzgdxf0BvjPB
         dMpAmi1oZEg8XmbtnFpXrxaE10y1Ss386+wYLqZVK7zYSlNCfu7LYNtG+Vpcr5YEZk9c
         LMmw==
X-Gm-Message-State: AOJu0YxQCtCu1oEjZpH2lWK26QcBe7kk3VXtkXXNzskoKCC6XUKPTVWj
	Molo6W0be20s0+BAY3b8brSbG2AVasibD7Mfv8JwJes6RjOS7QDHJkruSyLYT4roLmx4wdbhUw3
	GAI94T+K1nQm99BffGblGtRcHKoTM4ll4WQ==
X-Gm-Gg: Acq92OHw/7oP4flB2QSFv8rN5hEo+kwztc2l0bCF3CPJ8WITAsPmqSBDbEXh3mrbWDg
	3Rjw0KBiY+oX8ihF0yq5L3+eRCmVaQDOu0pSiRQXpj/5HC9PJ4z/y2SqpnzFnzl/07KYfwtpUPJ
	52L/KWPEVvWqVSZQXkUcwJIVKOr8jPi3xebIAUNMozfg144qBC2KWBha2EUq/rzbZ3eXvdu49dN
	OD61mdk+dAbBoCPhaj7ei+XyHMa7iDZCGhn1sOeQsPyW0mjSm+QZMZ//zbTt/b1UtSSQWhQTujc
	zuAkoSrFG145BySkpw==
X-Received: by 2002:a05:6a00:1312:b0:83d:c0dd:62ef with SMTP id
 d2e1a72fcca58-8415f6235aemr26321563b3a.45.1779971722933; Thu, 28 May 2026
 05:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528123020.35148-1-stephen.smalley.work@gmail.com> <20260528123020.35148-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260528123020.35148-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 28 May 2026 08:35:11 -0400
X-Gm-Features: AVHnY4L_EnqVwM6H_kgU_-0KggaODo3KSMnygCN5OYDWQvgzHBMhxZn6h6Bp6l8
Message-ID: <CAEjxPJ5u6LZenMHSNHaQ_qaHnu-1QeFFwXcK1OL8SeqpSW1=gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mcstrans: cap the cache size
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Cap the cache size and do not fail with an error if we are
> unable to cache a given translation.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  mcstrans/src/mcstrans.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Sorry, disregard this patch - wasn't quite ready.

>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index ff33621c..9e49ab7f 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -38,6 +38,8 @@
>  #include "mcstrans.h"
>
>  #define N_BUCKETS 1453
> +#define MAX_CACHE_ENTRIES 65536
> +static unsigned int cache_entries;
>
>  #define log_error(fmt, ...) fprintf(stderr, fmt, __VA_ARGS__)
>
> @@ -648,7 +650,15 @@ add_base_classification(domain_t *domain, char *raw,=
 char *trans) {
>
>  static int
>  add_cache(domain_t *domain, char *raw, char *trans) {
> -       context_map_t *map =3D calloc(1, sizeof(context_map_t));
> +       context_map_t *map;
> +
> +       if (cache_entries > MAX_CACHE_ENTRIES) {
> +               log_debug(" add_cache: cache full, not caching (%s, %s)\n=
",
> +                       raw, trans);
> +               return 0;
> +       }
> +
> +       map =3D calloc(1, sizeof(context_map_t));
>         if (!map) goto err;
>
>         map->raw =3D strdup(raw);
> --
> 2.54.0
>
