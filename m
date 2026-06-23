Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15A225F99F
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227307; cv=pass; b=XOcPGdZ5mNIP5iZQiJPaWLobjF8DfMW9ALkdRQ6wiAH7xQESNqpDcTLro+TYv+MKLp4L0kwV/83JaWCOTmhPifTdwDPaCJnr0hR/hJSRy5ho+ed6goz5buLqoy/RwkloQzP9mqZKATONJ+ZNTyE5xDwTphOrduXEfHb1amUI+Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227307; c=relaxed/simple;
	bh=Vcoc9U0fILdX5oSCTHL4/hpCO7vRAR5BHOojL5gn5t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5R1KomPuiv03XNyBJTHqMorne5gVbNFU7DB6/rtl1g7DAPBPz2466Cg9oOPW7zrq/ZjdLZuH2djz+n3l7nU+WPWCVa/dtcycRvK25yT9F0tzdUVfffHmqOZVfBghcxT3iZYVk1JEUpkIyZ80sEPgZIUqQDvoHcAAUVS5X32A00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7UFw1SL; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7UFw1SL"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so2554608a12.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227305; cv=none;
        d=google.com; s=arc-20240605;
        b=e6b+C7/gR2+0zMausJi5uSctsgmShIAXcAvE9ZpIRPyQSh2baJXSNErmHVUrqyWj8L
         hue5k0AlBj6PEcazAdf6fCD9zd/J+H++mwc+UVoa5guOfMgDHdziethYrTLEGlxQtYsr
         bEhv29xGy9AWTQtnbRRYSLt77MTbX7Z3o1MM9QiYWATRfGV+7s+8nOV3oNJl7JMr+O0F
         ucoUknUG/jbCw/le2J0tz5fdaeESyVrXIUuBCPjbQkzTMcmre/tXoHJUIwq6rwVkhbzC
         HPcb5CjnYky18n/FsIRZtoilw8rWdwTpVVUxUEGbASAZmlGBifXMIVXuOcCVyLeAS3fn
         jA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oBGdvdUYLW6lxgvSuISF3hhloV7GnjJ1FPle1G6POUo=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=BgjURZ5CZB5F1e04V0MNDfemQX2SngOfSq4aAKM+x/71DeatehOGkmAsko1HwbwFNk
         FfM0SIcUfON9nrrwmxThrGBbgLYJMtvmw8U7nroHvcQGYSRmXX9LSDnx/K3JyYXxGxm1
         op5lPU7xHskil0QStXx9wGNBWZTnUUv5AenZurKkHi5qXBGJ2KTuuZt/zI84+oRmssF5
         wXQnX/A2rdDu672UHUY4jmtfl2w3FhtwsIJnTWtqRL6EeHQ93fMxAQI9kLNbZP8Tua8p
         Ugjr9CmfaD1R3GbgJ2XUvu1Augp8idKICHlO5ROG8kugf8o5mhmBWo3zF8HsqULB4c0m
         NNeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227305; x=1782832105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBGdvdUYLW6lxgvSuISF3hhloV7GnjJ1FPle1G6POUo=;
        b=N7UFw1SLpQETGo0EFISx6b+MeDn2Un7MffCLQFPKMvNAYb0p9VLQzzn+sz5UJMaBuT
         vHOpX67GSU/rq6h3xjUYVAqV3iJz+C4m4sN/RnfgNioWRi+fIjvz0dfMUCrzhWaqVKTd
         g5nu/15ojWUV3z4//6XgifqIqeFGQKE1NcOQHi8JeV01ReOyQbbBlXbn/mOV4jQhqm20
         wGCwf4VsvXXlj8h+KlMJju3wJjehBhk3q5/PXpLIsFi17kehrEQBg6PgNhgM4a8rB4jw
         iJqf+WZl2l81/3RJ6d5Ykq1CCU5mycWmAdhPwp6mxHv1U1wmKwDFBzXjRt3jftY2EZza
         0R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227305; x=1782832105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oBGdvdUYLW6lxgvSuISF3hhloV7GnjJ1FPle1G6POUo=;
        b=qwhlSYmIUDkWq/rPVFy2LJkyi8iTGACMpnULe1G8N+lYPQh1Et//rx9T7zKUnBo3pj
         TI/KPE2JZOzoXmMNTsDAa11L8zdXY8xWfhK6OFH6e+9sVmQ8CzvLP5Z4KEb/JKHlna7l
         m5AtohyVr9TFxErj5fx7yR/T6Or1Q8CbNJI4Yc4W8kbSc/zhWnE1sbgN8T4idfdT1Ksf
         J2wZ50Z/ahJor9NdE1EpvGSC+kN59KvcnHBw7jzuUlKrEjaQn4ZGHumUlCCG5eLgIFCl
         4usk4TZd5aLDVAgmswi2V8zTWN4k1QARobuFN8A/P5bBM01ixCSjJSCrdrDF8dd83vW+
         0bhw==
X-Gm-Message-State: AOJu0Yw483bhyKyHapq0b7LIRxeyFbo3Fiw3pKjJ4E2Jet+cppn101fk
	w5rylryndKSwyrMB+ReAD9KUBD14RgOGzSSODhgtiu2lcjPHahqCfz18NQygQjJGz0FjsKbkrTO
	tVB/Vdp9t2637LNngTTJd+ks01sZGJDSJWjNA
X-Gm-Gg: AfdE7ckVDNvPOq/MFDvgVi97+g3/3+km5VR4ZviWwqlI2+Q/IDZpQim9JSPIXD/p6wp
	U5f+zxiLeoUZdLfAOD6LBfOlBIee/xIr8jqjpcTL17EgkwkpvDcMdTS9kESO4B7XxFu9bJVXZZL
	3xj1vxLAgS5dH6YPEwn95LkPwZOB/bV/1OkYzcHQnh/N03StRBiQBa0/9E2PtiFFuSoTJesQMUj
	QbRIiAvqM0ya+Nai7YK2LOJxIXfeYsocg48eGL3QenR8wvBCbphegLuQNEzsmaAgclZTfOP
X-Received: by 2002:a05:6a21:3392:b0:3a2:e0d3:37db with SMTP id
 adf61e73a8af0-3bd18f6bc76mr3688222637.11.1782227305145; Tue, 23 Jun 2026
 08:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-9-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-9-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:08:13 -0400
X-Gm-Features: AVVi8CfaQjo8NeWklGdDJCrQTX_9XbUJyxZXHb_ZsEyRMxcFB6JEGRBullCTj3o
Message-ID: <CAEjxPJ6CCHjeVuKkx4c5wnmYBi+fEoUhHpbnby+SoYkxrBFfQQ@mail.gmail.com>
Subject: Re: [PATCH 10/24] libselinux: initialize output context in raw_context_to_color()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> On an early failure (e.g. setransd_open() or send_request()) the helper
> returned without touching *colors, leaving selinux_raw_context_to_color()
> to return -1 with the caller's pointer uninitialized.  Its sibling helper=
s
> raw_to_trans_context() and trans_to_raw_context() already clear the outpu=
t
> first; do the same here.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Still leaks the context but that's not new here:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/setrans_client.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_cli=
ent.c
> index 2b550a92..b0adb308 100644
> --- a/libselinux/src/setrans_client.c
> +++ b/libselinux/src/setrans_client.c
> @@ -254,6 +254,8 @@ static int raw_context_to_color(const char *raw, char=
 **colors)
>         int32_t ret_val;
>         int fd;
>
> +       *colors =3D NULL;
> +
>         fd =3D setransd_open();
>         if (fd < 0)
>                 return fd;
> --
> 2.53.0
>
>
