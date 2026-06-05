Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97105369D41
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671004; cv=pass; b=VhIn2vBR6cl7SZawJasQppk3xMM4NVZPKDuHVCBkr0w0FXwopFeC5xFw/6hoZoZv7qWO3z+O33WmCO5fb0AO3k059Yez582/fQbyMBZglR+wy6p5smWi5UgoM9/caoku7uZjdEwlf7kWuc6dIzCImyB9/juczgIJMV86VD6ZZe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671004; c=relaxed/simple;
	bh=LKXsoGNk3/RqeYloG11lkmF6A3BTgxTXf3CokCQ+eUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma7p2sjJihS95G7hBGKb7mrAGZOCpXv3iZHPptMwOHcPMJ/O+HKe/g5MRbVnx8PaUKWy2Qx7qtsXqtTtbpQVHpiAwN5EeXd+nB4AXps2Wj+8D0kgR0NTX+xnCN/uwiMUCjbGvpWpDL8c2kfm0tZaOYRznQFhPKuEirySAJKrZOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJgkTigl; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJgkTigl"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39666ac91a2so31296001fa.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 07:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780671001; cv=none;
        d=google.com; s=arc-20240605;
        b=NDNk5qkWODC58UKr9OOV96Rk6tKis7qrJccWC+L038Rb7S7Zs2PcH8wXt8gaKJUleA
         ilSmamBIDo/DPXevJ3HTzZ4yaGIWvtPVd+ibJNNZaJ00rTwTNX1PxC89uN3kQ4u8IPyI
         OlkWHG/IvzbBr778GIkGF6fLNPtk2wzuouOmpm5f8DDdxk8WWJeYutw43h6l974a2s9G
         rXDWXJQuNNJ7ota7eCAFd9OerMRJNpmCgDFa6M954wqhDQmdw85XGXiHHj5vu2LuVHPc
         CgNkVcSHRYPMlZS1JWsSXfY86S1em2qWAWzReNO/dqO3uNU1AnJxO+UW89vTFidTKZ62
         rJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M1Il+c+x1asnSO+E1wgOqM73iLS5Gc0Zb999JE6lM3E=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=kUgJ4QOAgsV5ZCvE+rdobs5RU1bbFq6ap8OHrZjQENLIgB5xebo18hMPXBUvHHprtD
         bVP41wcR/F/qOAZ4a6eZCracANS1MP+7aynzTYxFOcEyqD3xJ0ibkb1dQ1dkBYnHLnZA
         VK2u6DSfGbDVE1RHVQagQPErqpSsOgE9wUlNMekbf18gAjghUkBpIAEoUgGF6GW4JGz7
         xq/rm3NRfY2R+JSoWkfbF+uz/gjljU+0XmxIfXSZ7UUxHNP+b4mh27VpZvvUWJwmoQiI
         FPC90Kh/ogzGyykcvw7dTfvLu59+WGKsr9ulK6+ofpo2TeTDb+nNhIBASbgWQ3m4PQaY
         wpYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780671001; x=1781275801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1Il+c+x1asnSO+E1wgOqM73iLS5Gc0Zb999JE6lM3E=;
        b=DJgkTiglaYWr/wsgJPqmes5PHwT0RcgDJmUKA0dOENYOrUZdVIF5AAarFHSJ3Z4Ey9
         bLXgqXSiywaCAK0x/EpOPqLT3oMWbBFB0+khQIXHo7j3jnuRqekthcm4FLog8bAnpcIz
         imu36XxPxLRNHtjVie9Zl/1UlD8hZKh/mj0GN6ySmG2nK4OJ186YQtEdn9w1ALQKxQ4H
         IflughZK61TBnOPBUKwM9qmdI3J96aStrWWDOozt/1vNsj8CHHD8omcHwnvm+c0SnUO4
         zbNDxdVXgSsGgRJFktHEdohrnIhVBPCms6AMg/6sQH+K2e+hGHXMgwyvODqLoT1mxhTU
         bJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780671001; x=1781275801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M1Il+c+x1asnSO+E1wgOqM73iLS5Gc0Zb999JE6lM3E=;
        b=ikS8SletDA5NY6h3T2dzmiPosGp42i+y1nVKiAZPN6TxqyUd/HaAH9N0OdeGCUvXw0
         hXAmX+KzDKSL0XCbERuPIjDK8QVGGO/g6LWxwv7ra3noDx9wNCNR6YWni7Tta3z9LTmt
         po7UilpyW9ZQDXih0UbmNDrxt1gxwk1qke6wZRMYr6Pm11IMQMczEJlSWXX58NCYPT2q
         atHmJlAW1ejJ0i1l69RKojPuFgdWcDskgbyORmbYa9+h/XHoOEI8C67oNT79eORtOTCE
         FHFt3d0/Vus2qo7OA8QuAL3LwBoDEwmvYNJMe6hV66YInENxgxtFOAliFrCz/MQb5r4s
         RvlQ==
X-Gm-Message-State: AOJu0Yy4iRIEsQtovxpE7i8OiXEoOwObMrmG4d8rZe0Pprb/LgCYXM/e
	IDCNxtw2DeLEdKchDdbFtnHrTAaok6TgljQvbjp9MJ0BvjDIR66buZrFQ/lqiNn5/x7Rz9oPemE
	87D1USTp6/4Z+EKx3abtRUl8sfiQf/wk=
X-Gm-Gg: Acq92OGutuJStK6YluOripk8JDsi6yUUKRmTcEl6E8CX5W5SIFLZDleIZ8dPryW7sQF
	Jwbc0Um3X7a5k5z2hsCRDf3h1D6SKwxlafVvcpOwCjLAuT0USjmwCcLWQcK+2m4KIe4oqTWYEF2
	f+gQOjkjQaSOlI/OLa1R12tQRDSEwxczLACyBNNSm3EaekoRawCxP0AKBiNov/p3oXwJK+wtCF7
	VSVpfH4rbQhNV+N5Tfn9OBR5HYERhTF+veG4d5vh3WMR86CVmH215RVks3HLf/MyA3ONuZlWCTu
	lVLP2HuT6m4P5YLlyvwGkIcrCQ==
X-Received: by 2002:a05:651c:555:b0:396:a4a2:beb9 with SMTP id
 38308e7fff4ca-396d285e8ccmr9096111fa.3.1780671000636; Fri, 05 Jun 2026
 07:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604182822.265426-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604182822.265426-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 10:49:49 -0400
X-Gm-Features: AVVi8CeVOd3Kbst2XEMxcSpMIqVQp32MDBTw-9I7uugWcPsRsaFYxkEmNPpldHY
Message-ID: <CAP+JOzT9hRsDQp8w+DrAb55vopYiUoSxXoA1MvT4+=tHMPnm0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] restorecond: avoid clobbering last character of
 config line
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 2:28=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> We only need to chop the buffer if it is a newline; otherwise,
> we will clobber the last character if the last line lacks a
> newline. The NULL-termination is handled by getline().
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  restorecond/watch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/restorecond/watch.c b/restorecond/watch.c
> index bfaf4f29..41497f49 100644
> --- a/restorecond/watch.c
> +++ b/restorecond/watch.c
> @@ -384,7 +384,8 @@ static void process_config(int fd, FILE *cfg)
>                 int l =3D strlen(buffer) - 1;
>                 if (l <=3D 0)
>                         continue;
> -               buffer[l] =3D 0;
> +               if (buffer[l] =3D=3D '\n')
> +                       buffer[l] =3D 0;
>                 if (buffer[0] =3D=3D '~') {
>                         if (run_as_user) {
>                                 char *ptr =3D NULL;
> --
> 2.54.0
>
