Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DAE3E7BD0
	for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477221; cv=pass; b=Om4MS0DzG8Bu5cuXCxvHNxO8U7TDV7bxGcXYBiTcHjC4bdA6Buf8z4Kb1EO1wOMKIXH59E77TvxoGmB4LxyiIICJwHCKB+3fQctPRdz2G4+eQvuyNS4nMWLGT8zS6R81gGhsSFcAvBDsJUntDB7vzoDEvYXM+n7BKj7BttbV/KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477221; c=relaxed/simple;
	bh=Y41+IO+eaKZK+ikeiVajbs+K6G0q11zCVz26+RESpPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InTG4O/jpWt/nGny7+89adekI35GfSpsYe8ATTOydu6pYHvIGCVk3kOsZIWM54hFzokKexzr0XRAFUVufgCX8vKvSTkXKNqkc2Mgmg1SLubxGG14HTGUXxt3pinoi+JaWvcVkecFujbfD9NQ67DjTuhrMTalo3eZt6YWE6ipe5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMRBKVGV; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMRBKVGV"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c979d03538so524065ad.1
        for <selinux@vger.kernel.org>; Fri, 26 Jun 2026 05:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782477219; cv=none;
        d=google.com; s=arc-20260327;
        b=A3DR3ovqRocWT74N8W9vYLYXlhCJXfIOgacEzXeGQEaJVtpa5vPXfd1eoM14KGU5ge
         OKtb94ZystyKXKHhlfLzX4wa34Psesx6eUx4ezwLoimMtcgpsoSKCDYEp3htvMqToL7B
         CZnscy/zhbqDhFOhRx2Xbc+WljM4eYQ6NHrt6v8PIdEraKDt54lvjLiR/BSztVW9ChPC
         plW8nmRC7B5KXtGtWGHex1zyXz8ksbTw54LqP1nkU4gkDavZCQoi175Wrtj91SYWs1Nm
         AqTw2kuO87sUXfIpkAIYT3KKGdf5dhOfXbG6UyOiLKIJBYXDrSqZ+i8MnWiSm/4VUBf3
         JwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKiii7sRDy26WbbBkMrjLHRLhE58fHpx4qsa98Lw9do=;
        fh=Ot1+FUDfWgzx49/olktJ/oaTVhm2+CK7GCIROF/R99c=;
        b=hbwLFatJWFdjpjNuXVmAGMNiUquXtgfqq978JLkt0xqZrmoS5JI6v1S7CsUYvhDaEO
         IqOlqUmTd6UGf1cRsyJclE3R5fUG5wzmhQ1pj4ygSJfyouWxp3i9suNdyPTO7Xw4Sw0G
         DJXdN1oa+cPJ1dSVpBAFkhJUjqzicub+3LLT+Mvuz92yKLQkFNoV8WYGHvXPbQIPcOzT
         oqW0/EQLXWRqcSf0HtstT7PR+SU2ki3PdSm81+ieOr8WLL/d0QRXA6glkuhjCc/8n6xs
         h+TIfYTSgS1d04jZL1jXf7sXnL8op4RBMV785qvt5iEvMQ0+yhntOjuhsjIwhwxYq+HU
         Ea4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782477219; x=1783082019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKiii7sRDy26WbbBkMrjLHRLhE58fHpx4qsa98Lw9do=;
        b=rMRBKVGVv/UosuGLh1FiIYgG3JKDZBqfkfqhWqinA9npJNxe1jjlBiJQepJHrePHN8
         3Fd+sHHDAJzhIaLSOGdz1/YABmuqN2fapZn6h2VljdLwNJY8WabbkM80AZDLR5PiHPW9
         qcLxlKYD6fbArE898xjVP8k7KKXXoo1xTjTxwZraTqxtRs4pgCGfBo/h1gsYdph3PC7b
         8xt+lTZjxiEg2TdDcqVWyKv0LZn5jUtZ2YXROeV3CmZz+ubt0+kq9iP2UPalSY4p3u3p
         albUMQdewklduLalORjPUYh5Za30vqQ1BfRltRB1zx5jEJaWXQW7zDicLFQrIMNskitv
         tvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782477219; x=1783082019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKiii7sRDy26WbbBkMrjLHRLhE58fHpx4qsa98Lw9do=;
        b=k8bPmG6FcLt+Zu0THsewt6x+WVAqlK5vLMTO5+2WR8i8G7AmpWpCAY5iioM5vIGd7e
         GVk5x8PmvNFuuRPaJQwa6axjrOUbuZ5HqC6o5RToDn+EzaP4ePqHrFEY8NkVzzblYPdO
         FrJh7bX14+IzYMDQFBGcNoikPfjhoA9HxL0e6DbEcIuLB6NisBoTZM3VGowbK8EEUBgQ
         qQHQOfXahc6LGg8fiQ7DAVss6OZvQhUehGMvqbz2FcHklr5LtbksVNrhLSuXgXAKP680
         IUpRNSwC0h2rsYQVCk72oOV462lJcN/+fMKTl1k+RkUVsYxulnKv1Rer3PsVPyxKCq3h
         221Q==
X-Forwarded-Encrypted: i=1; AFNElJ8gFSJBJlB9oYhUtj1CkcyNdtB2/no1IbHRN6n/4tl2YhIy2qhHXOo/srqJGpG9w+TfCsN38Zm9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fyTvKGcbepIRDEnmago7JrubCptvz+1M1DbGO3n3m1o5iSOR
	qTI4hyuqPahCA3yJMow51eYjAFmx8WsFYmkIzq0BcLrXEsFHc77euPX+wxq/lm9d3etDhnWhOot
	2hQEWuoYRfQ4LiwbDzx4ZhUoKp6rIXgw=
X-Gm-Gg: AfdE7cnG5RoeKv/mqGnULBdk45HsT/Bwyldy3AkIKYh7m2nNMkPcv1zrke2c9dRQkjH
	mVLWRmV3GdaQbgkELpI3UoioXQLfwDkLp5X9BpiTxhngZ3hTfIxHhllLziyjCJO/ziZ2EQhX7t6
	HM8t4TvfSPGapjJ44YctYyWfrVG0weeAIx/Gh4FXn07cUIYfNJnudc41VxBj1b+Wl4/v0IGCv4a
	Bppjl2lmBU1kFY+w5+u7xt0/6LOAbLzAvEinz1xp633EOfIAmWuWxDXIlaQxPbATAuO4VM/
X-Received: by 2002:a05:6a20:72a2:b0:3bf:6c07:b2ec with SMTP id
 adf61e73a8af0-3bf6c07b6cbmr170450637.47.1782477218795; Fri, 26 Jun 2026
 05:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625235336.3641828-1-tristmd@gmail.com>
In-Reply-To: <20260625235336.3641828-1-tristmd@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 26 Jun 2026 08:33:27 -0400
X-Gm-Features: AVVi8Ccp1iuAyE48UTPXyK784Xo-U5147VxNhSAxuBmnkYfUtw53ymAHJ6hbU2g
Message-ID: <CAEjxPJ6pneeDyPT6-OL+0S6J4SZwM4XQzSn2zK8JwmNnwNqjCA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tristan@talencesecurity.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 7:53=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
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

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changes in v3:
>   - Keep comment describing IPv4/IPv6 address processing loop
>     (Stephen Smalley).
>
> Changes in v2:
>   - Refactor selinux_socket_bind() and selinux_socket_connect_helper()
>     into sk-based inner helpers instead of adding a NULL check on
>     sk->sk_socket (Stephen Smalley).
>
>  security/selinux/hooks.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index fc926d3..1f202f6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4689,9 +4689,8 @@ static int selinux_socket_socketpair(struct socket =
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
> @@ -4825,13 +4824,17 @@ err_af:
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
> @@ -4924,7 +4927,7 @@ static int selinux_socket_connect(struct socket *so=
ck,
>         int err;
>         struct sock *sk =3D sock->sk;
>
> -       err =3D selinux_socket_connect_helper(sock, address, addrlen);
> +       err =3D selinux_socket_connect_helper(sk, address, addrlen);
>         if (err)
>                 return err;
>
> @@ -5409,13 +5412,11 @@ static int selinux_sctp_bind_connect(struct sock =
*sk, int optname,
>         int len, err =3D 0, walk_size =3D 0;
>         void *addr_buf;
>         struct sockaddr *addr;
> -       struct socket *sock;
>
>         if (!selinux_policycap_extsockclass())
>                 return 0;
>
>         /* Process one or more addresses that may be IPv4 or IPv6 */
> -       sock =3D sk->sk_socket;
>         addr_buf =3D address;
>
>         while (walk_size < addrlen) {
> @@ -5444,14 +5445,14 @@ static int selinux_sctp_bind_connect(struct sock =
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
