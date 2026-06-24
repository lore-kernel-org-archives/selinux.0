Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580F24676D
	for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307942; cv=pass; b=SGh5Q6do8/OFMpLLx/MyiTLDFJYIIvZo3NI0s5UmRSn8JDGJ5l436Ai2mhAo+f8UsqYODsYnXHeEG3EUxK3F2uVcFS5sAnYSi0U4bJuP5WAmd8YapD7cEwJp2Wdkz3osEPu0DeV6dxFJBF6kDO2wjiOb1u1VMlXJaClHdCPlAEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307942; c=relaxed/simple;
	bh=C+l5GobmrB6mE3BPCch3fEweK2FOcixqDFb2jvsam3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaQHQYhsMHB6YKgdUhGLN8F9YxtDEfn6FUJEizDInkGEkmKfJIvBKD/5RrJuEhEqTFsLBDQew7uJxqyjYuepwJozYp6jug5jqGJI+JO+o6qdGjOVS6+KX3FYPaz+3UWD61s/mfchmn/3Q5B56Gs+uzrfbfv0fUeakzp0+rWjxwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZI6nxzW; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZI6nxzW"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37cae9b7536so750746a91.3
        for <selinux@vger.kernel.org>; Wed, 24 Jun 2026 06:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782307940; cv=none;
        d=google.com; s=arc-20240605;
        b=fvzbXat83ArWD1OT/yWyHnYFUNdYpfFLiXAx2Lq1U7jfaVOwU+iqVXW3gbN2Rkvv+T
         tNWtPg/k/hk/9CdM4K8tU5RNtQ1WLlSEwyik+gmDurxxp7WB135wPZdWMEoaY4MpK3O9
         2gDZpeImUv/4Up+Dbo7+LzQ5PqnWoJ2BsT9Wb6/6CasiRTvnLZd434/xVJFpbWIGnDQb
         mTzhPv4IuTtvAXOlKYRkDhPs8/QTn6B2r0BfEAgov204ngAX1nLJ9T86gZAB3Pt6xNjy
         HUl2yGBtKnNZz4oLyhjr3o42TBKixFu9gVtfgnWT6Q9z+Uiu+Y7o6AzFxmRslcrI7TEZ
         MYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qZnh10D6aEPenMlTcWcujbarlCnsRAuLfiObGVAkNws=;
        fh=yplUIZTQ8EtyJ55HHbxtXslJzgSwqY+IJUch5sLafaU=;
        b=ljEY+ePnWfwTH4jZMmQSuZ9Am3D05uXM7N1DsLn8jHxKOGSm6+yM7DvVImpG7UYLzL
         7G9G3SlkAoG0Re64g4qMdtcUfDpE+jVNiHbCRWuLb2JKREpMA8hYZx/zyhBChubBkhnj
         Y4MzmehWGHM1oRh9euVj6pXZVhJR+YzrfcpIhNVLb+hLzx8aADG8JTSokREX+x6oBrk+
         pQa0+CSgD+tRD4eOtvY2VzcyGgkpI/IH8+xKgcx8S26wlaKQODjbIrQkCEpS9Mf3bJyr
         RboWpqOjHADSuibeDgZFF4dAWBH1uLu3nEYdXnyMDUARdb/X10BJrfTrX3I4C0UANFif
         OJ+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782307940; x=1782912740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZnh10D6aEPenMlTcWcujbarlCnsRAuLfiObGVAkNws=;
        b=fZI6nxzWdjeRntmm41OX/OJAK5GuDH2wv05RdY7SCNo2zAuseHx77osewXsseCnszm
         D5odfN4PlvaMfsikVBn6h8jBGgZstNCkIc73BwY5PFz8cVabU33D6VGYkirXl6PBECo8
         MS1ILoU72pgBhV9d0EsA9MYBB++k859qw9j0z+mp8RFUtX8DWgLqyy5HLoqRflLd0fME
         BxFRMhb1FqVyFDDvAGMFCcj+zSXUhMITvrkmji0e8gw4uRDJKXv3LiYzV4aH77CFiHTo
         hDE0qGC56PSK6nK/kMvMqte2hdcmvTewh7R4FW/leuVUeFao1b81NyPEXylVDI48zEjA
         rbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782307940; x=1782912740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZnh10D6aEPenMlTcWcujbarlCnsRAuLfiObGVAkNws=;
        b=QjXuoUpQtJKurKJ45bj2Jd+RMei58Da+NZXoaa3y+JtvhcOhd9ZqpJ/STdHeduVMol
         9RX/rck2JXChLa9+zU7mBCdSZu+F4ZTZjvONWgtA50q9ILJRbEQe6YEKYZ6eJNDjcK3G
         s8PIkd4SLWq/QMD0zprl+SwigONjLwfZb1pEInqM8SWc5Y+FBhH7gdPNkueIGGscQlui
         3WRzcArM/Db6GBrsb86jmwJp/NUEpdEq2iFrA5JY66hxao32e1zfOmR+RHAvLD0dUQAh
         VKmvH642DtwZ03b5YgV4kJb1NoWxwMwnT2Y+mB49C/OF5MmR/tacj225nvu1XaglQepJ
         6VaQ==
X-Gm-Message-State: AOJu0YyinzGWSDkpjrfnaXUeuN4exSbOk7Q6EPjU9IQFmsuj/BnwciBP
	nhs+on1XqOLSxoRx6Shn4xd+TacmXpbMIpbNNSi8gdCYPqGvTOKa7Jqzeqo1DWKPL410pH8pbtQ
	50LHPGMwE9hpzov3tI1zZjKerra7dYGLEi1PI
X-Gm-Gg: AfdE7cnF26/TtAPIMOhY588uJsMrWWCWbOtuYlx7g5aKpuQFMF2Qcx3Lch/oJdsT3SG
	RoyHjcLEgG+5mzFsD7sy4fe8GSHGaMrG3A5UOSLPc4668YdiBqJ7jrv25lcFrLnIVyGoRcKnn2Y
	mjBILuKQ7XXH+hXfXQnz3tvFgLAFcCygbDX9eEOOV7sLF97CUtWdqb5hF9EyHH+oFmfi/bocn7Y
	5I61eCD8UgoZ82fVUq/dOsoN6WP7YkiSukKDPARa7lCH3DZHyJ5mnAeJtqnUaXbRSdJhJKp
X-Received: by 2002:a17:903:1c7:b0:2c6:db18:ae44 with SMTP id
 d9443c01a7336-2c7e14f24b2mr31395495ad.15.1782307939113; Wed, 24 Jun 2026
 06:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618175513.112443-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260618175513.112443-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 24 Jun 2026 09:32:08 -0400
X-Gm-Features: AVVi8CcX64Dqew5Y_tu_gfY2QrNBqkehyUXIBuVh5wM0jYWzACqgiG4cMID92dU
Message-ID: <CAEjxPJ7YHAKhb7ipZom_gBbQsyBYK9ie=0c=E_swmbyeXn9-pA@mail.gmail.com>
Subject: Re: [PATCH] selinux: check connect-related permissions on TCP Fast Open
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, 
	Bryam Vargas <hexlabsecurity@proton.me>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 1:55=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Similar to Landlock, SELinux was not updated when TCP Fast Open
> support was introduced to ensure connect-related permissions are
> checked when using TCP Fast Open. Update its socket_sendmsg() hook to
> call selinux_socket_connect() when MSG_FASTOPEN is passed.
>
> Link: https://lore.kernel.org/linux-security-module/20260616201615.275032=
-1-hexlabsecurity@proton.me/
> Link: https://lore.kernel.org/linux-security-module/20260617180526.15627-=
2-matthieu@buffet.re/
> Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
> Reported-by: Matthieu Buffet <matthieu@buffet.re>
> Reported-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> NB Build-tested only so far.

Note that I have subsequently tested the selinux-testsuite with this
applied, both with and without the new tests in:
https://lore.kernel.org/selinux/20260622135757.2172-2-stephen.smalley.work@=
gmail.com/T/#u

>
>  security/selinux/hooks.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 97801966bf32..855cc32a7653 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5270,7 +5270,23 @@ static int selinux_socket_accept(struct socket *so=
ck, struct socket *newsock)
>  static int selinux_socket_sendmsg(struct socket *sock, struct msghdr *ms=
g,
>                                   int size)
>  {
> -       return sock_has_perm(sock->sk, SOCKET__WRITE);
> +       int rc;
> +       struct sockaddr *const addr =3D msg->msg_name;
> +       const int addrlen =3D msg->msg_namelen;
> +
> +       rc =3D sock_has_perm(sock->sk, SOCKET__WRITE);
> +       if (rc)
> +               return rc;
> +
> +       if (addr && (msg->msg_flags & MSG_FASTOPEN) && (sk_is_tcp(sock->s=
k) ||
> +               (sk_is_inet(sock->sk) && sock->sk->sk_type =3D=3D SOCK_ST=
REAM &&
> +               sock->sk->sk_protocol =3D=3D IPPROTO_MPTCP))) {
> +               rc =3D selinux_socket_connect(sock, addr, addrlen);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       return 0;
>  }
>
>  static int selinux_socket_recvmsg(struct socket *sock, struct msghdr *ms=
g,
> --
> 2.54.0
>
