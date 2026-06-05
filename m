Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB83B7B7F
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670421; cv=pass; b=kgglXt7zBSW/EuQPejv8E9w0uEFYy1v9I7loVCccZC8+GbQyxfAOhAut5nARQETYi5z/6IC+ZiJxDkUMV/7MXEzXooHfjq6J7UO4xYHAHBeI6chdan1bBE4epcC8Xjz2nCrRjfWtFG5dS9e01EASiJZzKHIr29p82bnlQyAolYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670421; c=relaxed/simple;
	bh=3uIVvz+u6Y68ngcmX7qylPkawv9Up7S9JmIEyTM2J90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HObr21uKVMGV6KdH4qx3CoDV+sqs5uVQPHwmv/fVqB/PJg/kMbt24T0y/5XwQdE58fvjTkIh6qnS6euW2t2E4iMSXgvByp+h+f029MXwPxZroOtyrGRGanT6S//WTrT3V2fTk4nGIuyxMIHN+V3D7SJnLPZfrgQPAdQ31gvF1yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKvd1JmE; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKvd1JmE"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39677c434efso20545271fa.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 07:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780670418; cv=none;
        d=google.com; s=arc-20240605;
        b=btggf/PLCwmBVmAA03hwMyiQauo7BW/Zylh6khRNYRLlkYG353o6DI1cJRmqEDq0jo
         x1M/zf39rT6YFVopPBfmnMyNcV4P0Q3iwWXMC9BtdCEeD3jegZY+4AhPG7Hro9P3RRjI
         W6SvzQ3qqr7lB4i0JBgaxass2Hp4ngGIa+1VdmwswQeK0ryboUf3PL+aPs3p5OcxAD/o
         r7JYu7sPItYs5jAnsGUL3MDxK3t5DK/UlTpv8lWI+9HSMMO0p/2hBHxOZEIzwZalZxsb
         wOM/WrSH7Ap4vUraJ0U4XJ0q+wjLXU7Kzx2xQmdBGkmbrwognn/V+F90W2AOrSv8CEcc
         +sEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yUsQP0U86RaLbaFrxQMnOic927YMsj0BzeigLpw/z7U=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=Gfi4UBES24fF1BL9COn+tQ3Caa9PIebL4P+EKzFko3EJX6TfzkoLe/XkBuY+y1QkvQ
         3pdf5+frJoL7uS1wjkcZdJ/wrIveDzGHFuu/bOOi/TwL1M9bAvxnv9dxO5TRoQ5ZH4u+
         dVzqbIq1brUuFFilVAtZBduCgZD0bjATZAGeabCqf/VYrOegfsaakb+8xN4h8vgeIXSv
         AUTBMmQUuDkp58NwMTg6BrsaeCl+H9/X1CFWRLzemZ/oGiXPqrnR64Pyi5Qoo2OU7OVL
         t9fxfjnB1qKUS5rN8+VZBzd4HSy8KxbnNgIYHJEq1vYKSIIOC2g6hMoOWWaBtUBFZzxG
         OEyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780670418; x=1781275218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUsQP0U86RaLbaFrxQMnOic927YMsj0BzeigLpw/z7U=;
        b=cKvd1JmEBEfa6ByQmJqtcVXmSSPSb+NLEs0bSMHSjppX8jM+5l9wDJkvyJHY6ZIfXA
         s+XWQGDC4meXCF/t4yhVZKBQifkfydj34xxB/4NLnYl2Cz6F07jAMueEsyrcBgC89goV
         4jhsPqAEnk2n/KHmoXGxWRidiFLPInTcSFkr1wRHfQN5NHwLSKdEF1SMycu9e4v1MLEW
         /N1gwNWdDN0WJhIqQKsBbrqHAbmBpvwiAeXqOCMZ0LlbrrIK4fJ57TO8LYNUu3v/A4vB
         62m+ehcLVO259IH4DbEX4k7XgOAFfumkckyUZsQmLx+go+bRdYcojTG3G66mkJnQnjgt
         dXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670418; x=1781275218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yUsQP0U86RaLbaFrxQMnOic927YMsj0BzeigLpw/z7U=;
        b=Fhwt9LhgLrpTCZpgji2DnCD3ZjzD+O3zXblNk41E1DUNXcNbmEaxPe+qO1y6amcqo6
         kLjkfgfv9PgVA6w5MmXGMSiVnxPOknn/XIRMGD8Diaztoa8lboNEHuqFW/kAYQLw0g/h
         LKUW4O/YvFzrUESDVXG1wzWyqLOSAIm0b2OUTUBzGUlmrtr9mmVeX1AFdu6JNAUOAmLU
         rh9KJHDqP4rIQLp4safqdyfOfnkJOniG3iQrKJ4klPMMywxjCUTXGua+hHG/xorDU0eV
         HJ3W/CWOb5iFJyulKK2J7nBn/TdklaLNw6TE+HD49W62I4t//W67SlKfNjPH3WJkeMF2
         aaHw==
X-Gm-Message-State: AOJu0Yx0KwvtOvxwrNB6lLzZYd8G9UGzy3w6HyNaGuEhzlIvnDmKTx0G
	QN5OGEp6WB5P7Gi74hW6rBolwOPqJhCzg4+H/fNpkxXvKzKEc/YoCh7d7/HOYYg3JyQiZdrI2KY
	jfF2MLMf7xjAhTQY8BFMo7ZZmpjH2sZ4=
X-Gm-Gg: Acq92OGS6PP3UAEnLJpTbLY36h2dyGc4jirFellx8jtsYVNcFIWQR6+8ClUKk9CZ+np
	YHSV6SALiwmsp9bjrxX5oX0cdHWUcfGl9lOVpBgAuIf9JvCRRftLWKA9rUdRocvaxMyO7AMiCze
	LuwfN9ikgiIwikrcuyQ7dDyY1hdGd6SDiqtvrEyL/gMygFhwmeevmmF+AcClP97xDd8Q8pBtzqR
	vekXXXokoDcqsrWScxg+32NAH/5GgJ+/p3uJJRJ8d1nC+fBqfXeUbqtAMr5KCz/wuFJRIM4xNz1
	c2741ZNUNu5yei4=
X-Received: by 2002:a2e:ad93:0:b0:396:746d:a9a1 with SMTP id
 38308e7fff4ca-396d097aa92mr13535421fa.18.1780670418191; Fri, 05 Jun 2026
 07:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604172213.263551-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604172213.263551-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 10:40:06 -0400
X-Gm-Features: AVVi8CdbVfl09rb8h-CQ92TYXRJ0LXq7ldboi0Axkyu5Xt-Z-I3RMnRhf1d_J78
Message-ID: <CAP+JOzSJKtQc49Q9nxG8BpUWrDSMcDPgEWsuO_=KFunCpmwL2w@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: genhomdircon: handle NULL bsearch() in get_users()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 1:22=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> bsearch() can return NULL if the seusers SELinux user is not found in
> the policy user list. add_user() and get_group_users() can already
> handle a NULL user parameter using fallback logic so we just need
> to fix it in get_users().
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/genhomedircon.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedir=
con.c
> index d953b75f..68382b95 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -1276,9 +1276,11 @@ static genhomedircon_user_entry_t *get_users(genho=
medircon_settings_t *s,
>
>                 /* %groupname syntax */
>                 if (name[0] =3D=3D '%') {
> -                       retval =3D get_group_users(s, &head, *u, seuname,=
 name);
> +                       retval =3D get_group_users(s, &head, u ? *u : NUL=
L,
> +                                                seuname, name);
>                 } else {
> -                       retval =3D add_user(s, &head, *u, name, seuname, =
name);
> +                       retval =3D add_user(s, &head, u ? *u : NULL, name=
,
> +                                         seuname, name);
>                 }
>
>                 if (retval !=3D 0) {
> --
> 2.54.0
>
