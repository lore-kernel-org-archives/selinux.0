Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68641F5403;
	Tue,  7 Jan 2025 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736280837; cv=none; b=Z4B2voBW88kjP0Bix4zJ4RU+ZF/9kRrCBXHqVWaGnflEAZEBILpqL0KgV5daN8w0JOBsD8hBtVe6HgMqVVetxMghBX8WNLss18ujv/YxzvTLpIi/FMcD+ml2OvAE9xBMDEaQLTxc6/fJ/9YzQmD7dl6+UFZSXFkNwed4AlrS/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736280837; c=relaxed/simple;
	bh=3kcIL+tWZPZ6xyff7/YcEqBzVqFMeFbP2tjdE0P/huQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3PI/1YdAj8l696/I0IqC9TULC1iSO3ivGyFVrx3Kyy53x/NmOwIl66mVSQksAZcx6xrQfnxA/mc4X8TZ/d0YOCU0wZOQi+CJEMG+Q3KxNheNLt8AfW2iOLLJjO0II3/7M7lg8IJPzADAKybR7ZZrey5XgRjmgMltvP3knMz6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSeI+c1M; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSeI+c1M"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2156e078563so204955885ad.2;
        Tue, 07 Jan 2025 12:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736280834; x=1736885634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe6I76nih/tcW+ZVTIQEkuddkakXXmcyoO2FN3z0Byk=;
        b=nSeI+c1MOrBl32KM6daxsZy5hdoGQqHEOeC7vj6/kW7fdFRrRQLLzyJ5WTPs2cM/bK
         qmSFH5A9KVodO66xPKX1S8Q6RpzvaXTQjft4cqSv5njmGYoAxpP/XyOaf4kHtpnlelib
         T/ahaHl4WC/+4pVkOIxeZKv/WDaV4Wereubkac/uFFy0BL+Eyz+tNjYZfas1zpkx4Ig5
         YLYpS8SLetzURqqgx9OjwddzGZlW4OYNDt5PWbek1K404RL63w4GYDDFrikQ7yOKx9VO
         s62ngc3yYcwMzqk93cKM+eY75h6L+FwXjkpDIzvA74gA6EehRtBLOWb+n3VtlcjWxk8Z
         s/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736280834; x=1736885634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xe6I76nih/tcW+ZVTIQEkuddkakXXmcyoO2FN3z0Byk=;
        b=CJoHwA6z+RTe3sQqXBxHnr/XNz5C8iYV+pLBkYVeOSnI+65v9vTzV+/GAwJw+q7AS/
         /LiYJUlT5kbqSJs5S23GYnTOa1sW0OThCFGtYiAOdDHXn50ML2AV/Atqr5Ha48ovb+jd
         vHNey4VsX/zrJSRS2G66TYHQXAex0eRjeNgwj6AYT5jjaXck50XDuRltFts4Rs1acxD5
         DxMo1vbX6WOotIovgSSGy5k6ZCaXxep+yuBg3C15KwQ4nscBiAt6f22v3Q0lp6cA8Jfi
         L9mnaSdiAYGZa0tdeqh5hXfSabH6HgXOp6KjLrqPonYD2V5eboPBmnIrer0PrSOFgiUV
         8M6w==
X-Forwarded-Encrypted: i=1; AJvYcCUPoY+Z5eVzPugg4/uYKVIcuC7ivxlkaIVPHhNuXsGi2gLzYvqi1BS2hSINYFwFIQJPBqerfH0E8Q==@vger.kernel.org, AJvYcCXV6fcxpF0y+/TEsWkLxjnbLbNIsEidleuWcZrlrDbVemP7YRz3fswBK8s+GmtHkMoBflDJ4Kda@vger.kernel.org, AJvYcCXVk0QI6P9CjPphj+bOu2DY1qm7Wao41/PH7p6MrVI+bu9MRNw/GgJvQgJJtwD8zRwiq9Nwwbo/jtDRGcdNILZvJCasYfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YX9wxEbyYjnxfDOqgczO4B7PP2fGF8ehu085aexzrRnMOvKM
	YXSG0JeiH43/xu8iyOIkCRLxbtVjFhcmHELnCkOC2jhIsHK3k43iGlAs5dGJDtcFMeCTwJcf7rV
	UJlqv3LPCam4l0KGumawf0kOJNd0=
X-Gm-Gg: ASbGnctVRxztdplmwQcoPgsOcOj6M+FSQoa1nO9xMczIL1bhWsFYV5PPJs96wya1DvA
	EfpfMZY41It041ggeH0scLx57tT5DNfPgkyPBsw==
X-Google-Smtp-Source: AGHT+IFkqJ6vLHsulBo5xyNCuuNP74dO1HnIkeSZpO2wdErN5Vg+gzIxrzQSne8XZvPfD9QM2uxDktqffD8zXJKfmWU=
X-Received: by 2002:a05:6a21:3a8b:b0:1d9:3957:8a14 with SMTP id
 adf61e73a8af0-1e88d0a29f1mr900373637.1.1736280833908; Tue, 07 Jan 2025
 12:13:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Jan 2025 15:13:42 -0500
X-Gm-Features: AbW1kva3rh8K_eoyF-CAkCw28fW2h9KdyyXROt348inusrnWdQ_EGjOrs_Lw4HY
Message-ID: <CAEjxPJ6+Dvx2f1+LKe4VdFjwZ6vg=fBXFZcfkoGXtXBzu7fL1g@mail.gmail.com>
Subject: Re: [PATCH] selinux: Read sk->sk_family once in selinux_socket_bind()
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: paul@paul-moore.com, mic@digikod.net, selinux@vger.kernel.org, 
	omosnace@redhat.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, yusongping@huawei.com, artem.kuzin@huawei.com, 
	konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:20=E2=80=AFAM Mikhail Ivanov
<ivanov.mikhail1@huawei-partners.com> wrote:
>
> selinux_socket_bind() is called without holding the socket lock.
>
> Use READ_ONCE() to safely read sk->sk_family for IPv6 socket in case
> of lockless transformation to IPv4 socket via IPV6_ADDRFORM [1].
>
> [1] https://lore.kernel.org/all/20240202095404.183274-1-edumazet@google.c=
om/
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/hooks.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5e5f3398f39d..b7adff2cf5f6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4715,8 +4715,10 @@ static int selinux_socket_bind(struct socket *sock=
, struct sockaddr *address, in
>         if (err)
>                 goto out;
>
> +       /* IPV6_ADDRFORM can change sk->sk_family under us. */
> +       family =3D READ_ONCE(sk->sk_family);
> +
>         /* If PF_INET or PF_INET6, check name_bind permission for the por=
t. */
> -       family =3D sk->sk_family;
>         if (family =3D=3D PF_INET || family =3D=3D PF_INET6) {
>                 char *addrp;
>                 struct common_audit_data ad;
>
> base-commit: 034294fbfdf0ded4f931f9503d2ca5bbf8b9aebd
> --
> 2.34.1
>
