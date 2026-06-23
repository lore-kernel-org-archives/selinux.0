Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73573D566E
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217322; cv=pass; b=OZuy6CXn4mScrmHaD532RHcuMG4i7vmAFZsEOKFXptUeVQiGG6Rg6roSFRCUUit6rHYly/lYugOfHBF+bR+gIqpOOEIF3f+R+7wJQlSBHkHSRUynI2Ze8M9DkhwteGGHKd6L2mqly1MPoDdu7+Fo/CIoDtPdfCOVQMzIZOce8nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217322; c=relaxed/simple;
	bh=lrbCLEPGJTNUtD3BgZCajTRgrXSGt2/8tpvlmaF5vNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R53MlAKgZAMSf0P4dNvInfPP0dyT/RFYFnzTLOS7vIWAcX3RGIEcsz5/AEJVft4Py6TTENAoUiiNx1K8ZEuczZ4PDANHAVjo9RrLRkB7Zw9eakiYRoQWrpsDgclAvQwmHZWiyej3D8K7J31KjTQHXE6AJ+ZZrkluTISusoQ9PkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExcaMXp4; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExcaMXp4"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so398120a12.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 05:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782217320; cv=none;
        d=google.com; s=arc-20240605;
        b=UHX/Fbgc8pjUC7sa26ykigbk+yS94kf/M6Nn0i8eBdnPnOlRrWd/fUEgpVAOXJ6AKR
         GYpoh3WYnylnPg+p/OVXgiVzx2aDwiQlGjNpJA+5Yn9h0TkaYz7LDXzLnMIZeAYw2UH5
         cUrGSHZr20wyDWfKsgG77qW7btqtdRxQOMc2oEJnpDG133brHA26lvQLUDhfQe+CB+4O
         GOLYKRfyu//Kx1DmFYY8K1FqfMASaWZP6WEcDe9wM2Ql4zjVaf/jcCP0ilfrT+QYEoPj
         dpcn+whWwQjGNJwH7XpZROI6tQxxpctt+JL6iMJelnEm1yfgvwyJ9EAYAKRQy2Ohh81/
         3/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuFR3/6LFoFU0zSu0VzULNjfNKPzwppMVDxzsvPNJ6k=;
        fh=Wgz43/NRhP/DUHYDoWgO3bp+zaC8B6jayPRgZRKoWaM=;
        b=lufB/2WKGh0G7yy7q/0uySYl2zD2m+glehjc2Uvs880bXS/JWfuMLr27VYntONHyss
         T8JktdbjEWCuW2ttWZVGTE/EJor2DULorZVxWnH6eo6Fr9peZ/AmXVo5JQVzO7D+xsn9
         q/QutQxmmarJKHwUbwxWmSBBu+z+Wy4G85FBsDckw9VhHqDhtk5oKCUMFqHDhBNgR4Oh
         H1QK8ENXBM7rhSCPdXwlCqz95UjtCrdQBT53dZL8oBtD617lFw0r1+DIAytR6kPxcj0N
         GDDyNdJUvCP6VFKWm3ahGZp9NZgOJj4njsKn6mCsvHeAqg9Ii4YhPb5SNtsYxbGLI6eD
         w0/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782217320; x=1782822120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuFR3/6LFoFU0zSu0VzULNjfNKPzwppMVDxzsvPNJ6k=;
        b=ExcaMXp4+0zSEUEtweofoo6ikED9yqzV80OLY11IneyxSJf5EW48TKytDO8AMcVyrO
         o/MKDKi5XEdX4pTyqvQhaBcJQhuV9pv1jOcAV5gCe0khVgcGAOaJXK1f6TioiRQcEAg6
         f016BbvXBqYSEEXfFqjKgl5WevWRicQ5eDIBsBqn85iIn2G2lPZQfClHWoCwqjrofIfe
         xTrWBlcvsHGq/0b9VoAXGlll363S/7/EstbT2XItEwWKUM2O73zs3jWrVeKlGRrGgRcG
         yTu/2dAQzCEpIxR5CIkjCZxKXLpUKzSzW5NqiqgWmiM6viiJkKIscXC+Qd43uBzXQB5s
         kwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217320; x=1782822120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuFR3/6LFoFU0zSu0VzULNjfNKPzwppMVDxzsvPNJ6k=;
        b=OYbiSkjwyHIt0GvYoEks5DY0DZekOXha4ckus3RhUvkl2YKWXZFSYNtQwPhHPuebTv
         UhpsLt5CzTpN+HUFqYV8ew4su//glygjw9iDQ8vBb6/tvISdoF8mr6mLTRRere4bjjuX
         75mLT0l3RnG8MzkgIHfG9HCWtQZ0IJLmEqT+6kZ26uBz4GqxHXD1vgU+7f5/z2bLTMMK
         8DcdKjydSD3oDOSChzB0LKAL9GuhKyA7dH4+iyLew9WaqvGwXVksiEjCLbVoll+qdntx
         iOXVzYi2xDv6lW92hKM//VnChqHORhHx5F4g2oFgJY7RjpL/PYSin+HzxYJxpvfc7nD7
         YlpA==
X-Forwarded-Encrypted: i=1; AFNElJ/s4/6zXXBBX32b2vJxfly8ewXR9JSEW5t1JyDtO5v1ElO1Go/nQs5OZIBySVXgitrRuWlSKzlj@vger.kernel.org
X-Gm-Message-State: AOJu0YypzQOLUYvw/C1fT7MeGtsc381WLc2Eq9dQ+UKV7ySuCnefXnu1
	gLfaTyrAcEyJ60QOeeQo5a6eom9d1QhdyrRhkW46l5kwVmrBQ5jWSJIB7kwpwA+Yw+A9l6yIXyi
	AwRI6AG2Yl+jAnoWumOJm+7IvANnwOk8=
X-Gm-Gg: AfdE7ckA+FGM85EYGUAkO804odI3OXS9YwWAuBgf3gfbv78ASyesVcv4EdqNDl5xuMv
	VwWdtxo8BBy/FsFmpq4Mc40hcn+nTiDa9+8xrA04GLuz1W7zBcl9h+P1PQqnS/XumnpWVlHuBo1
	P52TAwVBmQdFs9ElmN81rNXvETdS1Q6+r37hRz+Z6fr2Kk9YS8Fl0Kvixy8umTBYISUwG+iNE1r
	vheybSnO1cfZC1nUGXqqEvgx7hvP6+OdRXMbjjz0K/hYzWqtCyQBGB93f5aHxxJIB3O0gV1
X-Received: by 2002:a05:6a20:3946:b0:3b4:6a31:6d0f with SMTP id
 adf61e73a8af0-3bb34e72975mr20752819637.41.1782217319845; Tue, 23 Jun 2026
 05:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618232149.1780219-1-tristmd@gmail.com> <20260622210330.3187099-1-tristmd@gmail.com>
In-Reply-To: <20260622210330.3187099-1-tristmd@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 08:21:48 -0400
X-Gm-Features: AVVi8CeIpvPNGZ0JTtt7DlppUyHKoB5i9DPzflCT466N-OeyDpTPwPP0r_SGGf0
Message-ID: <CAEjxPJ5pFjTvS5n4DMqL=bjdCKoTfSSUKRhZcHuR+99XaoGKAA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tristan@talencesecurity.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 5:03=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> selinux_sctp_bind_connect() dereferences sk->sk_socket to pass a
> struct socket * to selinux_socket_bind() and
> selinux_socket_connect_helper().  However, when the hook is invoked
> from the ASCONF softirq path (sctp_process_asconf), there is no file
> reference guaranteeing that sk->sk_socket is non-NULL.  The setsockopt
> callers (bindx, connectx, set_primary, sendmsg connect) hold a file
> reference and are not affected.
>
> Both selinux_socket_bind() and selinux_socket_connect_helper()
> immediately resolve sock->sk, never using the struct socket * for
> anything else.  Refactor the inner logic into helpers that take a
> struct sock * directly so that selinux_sctp_bind_connect() never needs
> to touch sk->sk_socket at all.
>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v2:
> - Refactor selinux_socket_bind() and selinux_socket_connect_helper()
>   into sk-based inner helpers instead of adding a NULL check on
>   sk->sk_socket (Stephen Smalley)
>
>  security/selinux/hooks.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1a713d96206f..aa58a17da219 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4994,9 +4994,8 @@ static int selinux_socket_socketpair(struct socket =
*socka,
>     Need to determine whether we should perform a name_bind
>     permission check between the socket and the port number. */
>
> -static int selinux_socket_bind(struct socket *sock, struct sockaddr *add=
ress, int addrlen)
> +static int __selinux_socket_bind(struct sock *sk, struct sockaddr *addre=
ss, int addrlen)
>  {
> -       struct sock *sk =3D sock->sk;
>         struct sk_security_struct *sksec =3D selinux_sock(sk);
>         u16 family;
>         int err;
> @@ -5126,13 +5125,17 @@ static int selinux_socket_bind(struct socket *soc=
k, struct sockaddr *address, in
>         return -EAFNOSUPPORT;
>  }
>
> +static int selinux_socket_bind(struct socket *sock, struct sockaddr *add=
ress, int addrlen)
> +{
> +       return __selinux_socket_bind(sock->sk, address, addrlen);
> +}
> +
>  /* This supports connect(2) and SCTP connect services such as sctp_conne=
ctx(3)
>   * and sctp_sendmsg(3) as described in Documentation/security/SCTP.rst
>   */
> -static int selinux_socket_connect_helper(struct socket *sock,
> +static int selinux_socket_connect_helper(struct sock *sk,
>                                          struct sockaddr *address, int ad=
drlen)
>  {
> -       struct sock *sk =3D sock->sk;
>         struct sk_security_struct *sksec =3D selinux_sock(sk);
>         int err;
>
> @@ -5221,7 +5224,7 @@ static int selinux_socket_connect(struct socket *so=
ck,
>         int err;
>         struct sock *sk =3D sock->sk;
>
> -       err =3D selinux_socket_connect_helper(sock, address, addrlen);
> +       err =3D selinux_socket_connect_helper(sk, address, addrlen);
>         if (err)
>                 return err;
>
> @@ -5706,13 +5709,10 @@ static int selinux_sctp_bind_connect(struct sock =
*sk, int optname,
>         int len, err =3D 0, walk_size =3D 0;
>         void *addr_buf;
>         struct sockaddr *addr;
> -       struct socket *sock;
>
>         if (!selinux_policycap_extsockclass())
>                 return 0;
>
> -       /* Process one or more addresses that may be IPv4 or IPv6 */
> -       sock =3D sk->sk_socket;

The comment should remain since it wasn't specific to the line of code
you are removing.

>         addr_buf =3D address;
>
>         while (walk_size < addrlen) {
> @@ -5741,14 +5741,14 @@ static int selinux_sctp_bind_connect(struct sock =
*sk, int optname,
>                 case SCTP_PRIMARY_ADDR:
>                 case SCTP_SET_PEER_PRIMARY_ADDR:
>                 case SCTP_SOCKOPT_BINDX_ADD:
> -                       err =3D selinux_socket_bind(sock, addr, len);
> +                       err =3D __selinux_socket_bind(sk, addr, len);
>                         break;
>                 /* Connect checks */
>                 case SCTP_SOCKOPT_CONNECTX:
>                 case SCTP_PARAM_SET_PRIMARY:
>                 case SCTP_PARAM_ADD_IP:
>                 case SCTP_SENDMSG_CONNECT:
> -                       err =3D selinux_socket_connect_helper(sock, addr,=
 len);
> +                       err =3D selinux_socket_connect_helper(sk, addr, l=
en);
>                         if (err)
>                                 return err;
>
> --
> 2.47.3
>
