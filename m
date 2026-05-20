Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ED23D75BC
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291162; cv=pass; b=E0Q6igc+OORfRy1BbJfWXiu4DB4/bffQgeJy03wY5c91EArH1K0R+DLV3w1AMf0QIXVUR+WjK5EvdDNGqXbWoCk2uYvRSX1SwNTVJGDk/KMQWFDrAqLyH03cyHAcK6JfQ9GOHqYU6Bf1wprmMhtwr5VaypCmS/dY5Dyo2K+i064=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291162; c=relaxed/simple;
	bh=irtARuettyuB7ZNtGZarGSsf9UY04ouq3fw0blHy6Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8RamxzXuytKvonH3yWGizfYG1AlPQIJSGF4Snw+xEkzAuSQpqpmcjMuOH29YYd6Md9mNht2iv07n3d+IBIslgbw3UAyQ0I7CjjQQKCJHlk/V7SPMwjK9Xj3ooNsGpHCZUB2QXDbIp3/fecyHX4ATud36wefn7g4hnFay/CPxXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7zHctIE; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7zHctIE"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3697c35eab7so2847907a91.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 08:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779291161; cv=none;
        d=google.com; s=arc-20240605;
        b=B7htqL7aqReKCgFmRBrKgjksOIgzHlw6Mp+4Ut4sqJVCC4TfspyZY6M9X1tYmLCKBq
         D5tsSFbDDXvrr/5pHSY/ddq98q3nzOMm/UcniksaqiCt30+fPDbMfrBBethMXsdHLF3h
         09ivbML4nUucQjI8JPPHyo3NWQ87cU/QO7WzJHm27AFipfF48VeVx2l2FlAjaT3crY0k
         Kcdh8YB76Rd1+17Uk+4z871SFgVJULjxUQQ4BHPnKyL74kwtg24Jjbl8WMIeg41vGZc5
         LV0UqX3OYuPH5WYWVJMmwWV0mZ0IvaKNTfSVQr0oUiM+rm4U5iCuHBv3hGiSjKlnUfbE
         CFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iVR/0H+WuuGM7BKNJW4h0suXyaeXJfvhmg1Pq701KdA=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=BQpTQIeDV+fOIz11qoDpD3oX+GdTFEhS/GE/MZ68Zwz298Pwju0zbQCmqEnZoRXbSc
         fyQpHmuwoVuRJIivqfZumvus1mLf8kQaxsK7cQeGzrGGlIC6Pl4K9DAXfrz1V+ZtbG3B
         FS9jHg8sCfJv6T0N+Ip5THSaKkF+a+B4iUae7wVt6vp7+St1/kLNrOujRDiUD4Rj6Hoy
         ndRrJcTfJjQFZL3nC+cryjLzjMPQ6PGROGPcMl6n0+NEsFCgfReEQMo703Zy8XY4mXT2
         WBislzwg28SzYYE6iWUyAMRKRqRx1QwKWhSy/WGygUhF9k00qwZEmOm06phWUaoJoEQc
         wE1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779291161; x=1779895961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVR/0H+WuuGM7BKNJW4h0suXyaeXJfvhmg1Pq701KdA=;
        b=g7zHctIEUAgF0yhpiwoNbs6EZ4UgVDfklWDdy59Md9tf/LoOrJ7oqJgtoGwV9AtZVo
         KHt2WMhuLTu3BrPxrryB4pvpzGY93W5M235oFuIhiDcsDCaQpqA9xMwQp1/wn9IfUGMG
         lKFzb9R3ztXSICJMmo4fLTGZ7N1jwrUEXaJ9QReW9ZwmRfmrygBKM69uMLTERHKt//M3
         vPOYHEtoMareQ+TkXLVqNBmt4wvqKGMG/COGZlX0ixKXPdpJJRu06eRyLNMI4lJpCsf+
         /znXUtPtEFVBztCEu/cYB0y/j0+q9iu+YngeEfEUR/e6jMVMbFqbasKppM9OHtCDDXt2
         stDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291161; x=1779895961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iVR/0H+WuuGM7BKNJW4h0suXyaeXJfvhmg1Pq701KdA=;
        b=UI6OTT+rGvPk3ixN8+1OahySCb9kNWdBQ0Gj8OPWyYs2MU/PO4UcVfoZ+GR685pL0g
         /J9N+xtijxBoyhw/HlZJ1ze0GWEIUZnRZWikj+QCwv4RGhcUtNiPnAdneM6vEkalOSbB
         cgAzYf7WX9dvD0HAnOHeZl1bmYRRitgP2isWJxopseRQEiCkGYjfVj49z/gzeqZLFfYk
         nI0J+0FsqVvDG30AQDkMO6sjJDBEIGNDjPCAX1AIwTLd7vW39ri04T9TQ8XNVse6dLxX
         aF2jBEotPPAu0llJsZk/ZYVLV7eI81CZrMNvdgfxRoMq6RJboOlahwoCDyrZnBCXCFWk
         HDAw==
X-Gm-Message-State: AOJu0YyYwRfIAXXa4qaAx17qOnW4cveRlki2PoWDtwm7MSof89uJgIJt
	5Nqp/l0oCWxnwGPFFT5hMAzsfFiUD/om6dndIS1VICy78gtDy4nxcWpKtrkqAA/9ySQ3jkDnvU+
	cbhRsGxShRBdxZWUHiWOSfufI05xrnBEdlZFQ
X-Gm-Gg: Acq92OGYVibkP8Jm5MJPqJjlUchQgZS2xpwBGaItdCmCFFRFLQ7zy8DU3s/K0Kv4vhu
	i8ON/xRmiBFC66xFDhCTqcJoe5Ps/IUynL/EnGCybDPa+RGJTava/MrWqaFU9zPklb2sb33ur8S
	P0OdXlphNcOqQW8eVI+bv7+vuKjSqNjjoJXuJ7WOdVyk6/wyu1cOdRZc8Eb1qE8sfYhECyp/Qf3
	ByNczrm+UiXif4jAL9SxJIpL5twCwPr5LPQkuReKqaVFE/4IRWkScFopj7ghL7sqc7QjaAwh0c9
	DbbAGzyVv0vTUXGwAw==
X-Received: by 2002:a17:90b:1344:b0:366:4f8a:9847 with SMTP id
 98e67ed59e1d1-36951b711dcmr23658574a91.17.1779291160746; Wed, 20 May 2026
 08:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520121051.20863-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260520121051.20863-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 11:32:29 -0400
X-Gm-Features: AVHnY4KF15tXC6LS3FbikOd8Hh0KK_L4WEfiK3gOTgYBRvC0fCH8Xks6qzpCxRA
Message-ID: <CAEjxPJ7tHxw7mJewLzO1yik0-S==HwMAu=xgsnsB3m8WVsjuNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux: reset scanned file count at
 selinux_restorecon(3) entry
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 8:19=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Reset the scanned file count at startup in case the calling process
> calls selinux_restorecon(3) multiple times during its lifetime.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index b4d58b05..b7defffb 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1446,6 +1446,8 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>         int error;
>         struct dir_hash_node *current =3D NULL;
>
> +       fc_count =3D 0;
> +
>         if (state.flags.verbose && state.flags.progress)
>                 state.flags.verbose =3D false;
>
> --
> 2.53.0
>
>
