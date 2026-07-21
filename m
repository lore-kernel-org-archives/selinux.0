Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BFD30BF6D
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638423; cv=pass; b=mVYpFAMvf8p//Q1UR7pfFpF7Iv9IY0tsaKPCNWYRkUxEwlPOz01x3vLrV9/T91JNCH4higF+e+zdeHAvgAePo4yuKbnatMs0mOC1vdRYLEs+SVtv++4s+svijL2dhe42vsUXkOLT9GWYhdKzujlw2u+qW5nnoW3AR+LUnqLemvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638423; c=relaxed/simple;
	bh=WY3blOX8oqKMZsnuyG6+AFFaN43pNN51RedTDlJCA3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/Slc46tD+yyIFmCgqcFuhsbKHXGqWpg7aNrVubuRQEr8k/D1F2dv05DLYNxfAtuA6YXbyurdT8Q+6FAWiOMQzqfkTHz+pSvJOpPK5yp7mObVppoKi8oFG9ixL0o1J0dn08ZyGrzH+VMYZIuJSiGMISPOmMbl8Q4AhdRhQVX41s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHQhXFqe; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHQhXFqe"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc61541f8cso58696255ad.0
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638422; cv=none;
        d=google.com; s=arc-20260327;
        b=j3IraQSMhFCPIO/r59O07iK9SFpiF6rlzqPJGhUGRbMPD1NcZ5UbngiYhAWWK2dMY/
         tp3DoFV5R4bqLyn0+OeQYQ0JHjVbKP1vdaLxOZoQqyF3dQXU+UFDqzsNEKgORhTFVXnH
         hvdif9RSlIqX4lSiv+jwCMM9rHgmj9FXw/zRzLFFKMXqvUSliLk1Suymlc/+Ph3Xq2ZS
         B9wBlMkY2d/rr5CIqN2GzrMuDHgTgtjFRCNJKDBBZMXoFXeLgaN3iHhcJRM3FNMcnrdO
         2ib0KJsUMhR3LPVN0i5cWYCvZ72zx+nxGWFjh6Ry76EizTSVF6aOGiOTdJpVQZPn948d
         6onw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UI1QZJzNKO3chZEL+mjWSEgEdChuKq9kaZAJJ0g9dYw=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=iYssM1ZuVtPM6X4lEjBfQsMJD0owPxiG0PIkYuWdVSldY1Z8wbLFoVz7odhADO21NM
         DDyJB1kBWw9hqPTyvgh+yOXmm9npzdsKuT0K5h2/QSgwvWMv/WQuuhoti6D5qukT3fjq
         aj7tBCcaRbc9duUauQiJPZfNkBacnfqmF4jzJumIWzzHN2Bl3B+ZRJVOXsx9E60Jf22/
         5S+DA5g360d6uZBE+5iyP7uUIHOyXK4amLbzIpP2Vq5fTeT6VYbeadIlDkQOPjrXO/XI
         CecwflxiJJnFENkSLqNuTh5tt2mMPx82B239FqHUptHD0WLABj/EaxJd7+DsUm5AapfN
         PQxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638422; x=1785243222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UI1QZJzNKO3chZEL+mjWSEgEdChuKq9kaZAJJ0g9dYw=;
        b=oHQhXFqejrgZ8BHhE6rtjoD/nUbURJyVrauhnMKXyPROlxG0H3ZT6oevtZaLhFzYnO
         ETTmBzmHepPAWsRch60dMOS92THtoJY64mPoLaI9Av3MDqGj2BRrUTn7qqLsuvSGHB0C
         bGymWfNhSrrNAtaZ2khqJm0GaQBJly5MuQMLUDiMiovvahY5q5TxhKC+m3siBFETJKsq
         zWMmKMrMWyuhlZXFRh1HWaCD2xeqe2i0qUVGxlxAIsO5v10pYyloXBzg0eUhesMet09E
         BAekOMx24Zwuq8GPLOCXMLXaeePyC46gSx8AyramRWTOL8vDJ3CEAoo8/WBkFGIT3fon
         S6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638422; x=1785243222;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UI1QZJzNKO3chZEL+mjWSEgEdChuKq9kaZAJJ0g9dYw=;
        b=pn7jXwsaa7Xs2EckX6kt3JqF8/uDQhDYikRIRsSFhUnXeqLJ3iSbvDl++hs4jyKMYs
         DDXB2RFciCZgFDufuu5pcJQbLcQXoJRcmG/1xCum94vY/D5toJsUUuU/o1l5Uc0fcLVV
         iL0a+wvTxXil/zDFhqPzJharW6SyW+z7+Wbr5fc+aRwDUHXrU8eol6BLMG/wYRNoguph
         4gi7kp624cmSRuQn7m3oVRHTQBX50tu6Mtxi9bBAiWWuaK84BOMq4bbWw82zEmfYReRz
         E+Kz1E+tW1BsjSPfgVQpsovhZwFtx1kHQxIOEHjshVLzmN5nMB47WCXMlKGsFXYQq/P1
         qwqw==
X-Gm-Message-State: AOJu0YzlxrteHhUJ04byppVzIwk2KDXp+RnUmDqcYEv/xcl1PONiqFfj
	9kdZkzSBkHFz7j0WX48KP05ekSMEjdDkbp31YO8ZDiPUjDpakHRsgIknyqxSpEKQNULcC4h33y/
	+VBVUZafFx5MVJEZjNDE+5mBGTAOkcOwRnw==
X-Gm-Gg: AR+sD108gBUXhwAI0bY3Prg3OWm6heqmGYYV7rIqHKLmVm+8wg7A3Kp/hfSOtWah3sv
	RfQfRtOdhEB5ByJhNvegRaIe5FcaYi+HVlkmKRCPqCHGmhZbIDI10ScC27NGJ44OHgevGFICvUF
	rWxQ0Xyp2GWEjsa1hRXblYacTqB08SAfMHWBp6jw+R7VX2Vc5P5Fo+ROXsG7x9KK2umP/31ldnd
	iyuC9003eBzlR16zi5G0rqPcjy5F+kGnz4q9T0cA3CERZSHKRpGNorRMukGHw==
X-Received: by 2002:a17:903:1a90:b0:2cf:8aa7:7810 with SMTP id
 d9443c01a7336-2cf8aa77c14mr4359625ad.2.1784638421904; Tue, 21 Jul 2026
 05:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716193737.11366-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260716193737.11366-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:53:30 -0400
X-Gm-Features: AUfX_myy1S2aGlQbdUt4seVxnah4EoUYU3x6hZnei7vQovlEOl8CTQgoiNSZQm8
Message-ID: <CAEjxPJ7aXzN_A2+Lq_098q0WpceyhCgeuEQjrwrCkqkGSxA20A@mail.gmail.com>
Subject: Re: [PATCH 1/4] restorecond: switch terminate to sig_atomic_t for async-signal-safety
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 3:37=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The terminate flag is written from a signal handler so switch it to
> volatile sig_atomic_t for async-signal-safety.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.

> ---
>  restorecond/restorecond.c | 2 +-
>  restorecond/restorecond.h | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
> index b8ca4b21..0e973d83 100644
> --- a/restorecond/restorecond.c
> +++ b/restorecond/restorecond.c
> @@ -73,7 +73,7 @@ struct restore_opts r_opts;
>  #include <selinux/selinux.h>
>
>  int debug_mode =3D 0;
> -int terminate =3D 0;
> +volatile sig_atomic_t terminate =3D 0;
>  int master_wd =3D -1;
>  int run_as_user =3D 0;
>  int foreground_mode =3D 0;
> diff --git a/restorecond/restorecond.h b/restorecond/restorecond.h
> index 9fb5c5d5..7e209226 100644
> --- a/restorecond/restorecond.h
> +++ b/restorecond/restorecond.h
> @@ -24,9 +24,11 @@
>  #ifndef RESTORED_CONFIG_H
>  #define RESTORED_CONFIG_H
>
> +#include <signal.h>
> +
>  extern int debug_mode;
>  extern const char *homedir;
> -extern int terminate;
> +extern volatile sig_atomic_t terminate;
>  extern int master_wd;
>  extern int run_as_user;
>
> --
> 2.55.0
>
