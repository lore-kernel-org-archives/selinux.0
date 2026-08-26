Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7CF42FCA9
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767927; cv=pass; b=UAGF8CbaBNQNTbzOWKSKgtgPylqEVPLp1ncNzMdwKAd/r8q1Dketd1RKCRLK1R8rxHe38u0p2A2uujcmBo+X6/h1Il9KDsuwNcsrfEiu7rSJL6mVthgPkOcnbdCje+IklPIEsCMwLEj9CMEMsSU3YdnwRgLecPm6thBkqyMEFaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767927; c=relaxed/simple;
	bh=VYmJNjczVuOKgh/F/msI/hNpsKvlLRoHV6utMLGlPww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQpfVRm4B6/+HW1lb3NF7BEX8qjmNQLPU1X2wMOoUzmotWsP15NunJz8GiJcz+boThCtCms6jY6RaPgwJbYBbPK1lr6zWOglNFX0QJbpSdzs5Rhw7rPU7BdkcjMR+i6Pm63L3p/8w/g33xPLHAx852tQ6dag4iaGY5zRn48DZ+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0IPI2LZ; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0IPI2LZ"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a1a3bb6c5dso12484611fa.2
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 11:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787767912; cv=none;
        d=google.com; s=arc-20260327;
        b=STDw5OvOeqiL72C26ryfvXT1FSFN/g4VyBJ1WVDaMd0/jjkQ4uXym/WQBGfKzNr8bU
         SCV2RwiayJpM+rHOfVrpgUNraXZxp7KtTpd3OrbKp8osS1mPMaM2iOOm/xAYgDpkNXvg
         ty0dFqZag0UEy+2K253+hcMWqXmdGliqVOcGDWmyU1Zg3XEyVXVlLR/1/SFbnzQGvobt
         yEbfYPJERC6jCEe0FTFtu5Kgzvc8fin31zhssQatVlVuskKGC2fLCQUhI3XfzpFhd68N
         wXJ7Uyo3xELU7rjLQaujcQ7/Qz5iQ4tWlDdNP1sHLmAmuoSGVhS99hVnTnSCWHGssRAj
         TpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JLGxpJ1XhajnujKs/Ug5ZCCunWfUZVinHOHB3n40IGk=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=NpAyZ+bG62FOYIMnf053uM06hrZKwWkivh88GKAgrPVjccAkTXGjRbkeGN5i48vzEg
         RGuZCCwDjSRItK/5SZgJOlLDm9MmEKx+D2u//3vJa/1DXgQJzUVdeN8lkFWpmHEgx8/I
         ME9lM8Ol3f1krgPrIjwYKZ6tv1Im8Ymaz0iBMxuVB868vKqlCwfKpvIZe9TpgRhd9rbD
         SLLhv08Rlg0YKa9/cfPCO2+YylwSAlA7KqJb1ySijyTkOn+zBX4TUDib6RsMigd5KFdd
         hIuGDe5ejZrdrY/iviUZEWUFw9aST3Ew3Ryr+AsTEEfjFZEBLPzm0Qw8vSndkC/WyMAW
         +Dag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787767912; x=1788372712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLGxpJ1XhajnujKs/Ug5ZCCunWfUZVinHOHB3n40IGk=;
        b=n0IPI2LZoC0HwsG6QO4lqAHGXI69NTy3uC99hozMEtQrErzqddrrD2Zg/7kp79ZpLW
         pM6g422hlMoQ+4+ssOjXyTFUkdoA2HtYC8Hyu6g5jpm1KFRc6qFFdpo9wfnNFfFhIf1b
         TNsdeiwgkRCnGzky9PgrjUovFpfXyYmMjoaBtEv968d7dddg5JxRSzWZaGsOhNsMag9m
         +Qq9WZqm+GUMcVE7URV/3X69dJm+ULEwCq5u2xoRXCC4cMRjWRCX8YY8nxveoGcZ7m+R
         T7KXvrztazhzwkFhIwSXuyZko6v73JuBOVrLz31UYlRuabgvFlEqpIn3+a19LjLZuRsx
         xmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787767912; x=1788372712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLGxpJ1XhajnujKs/Ug5ZCCunWfUZVinHOHB3n40IGk=;
        b=BoO5RscakL1EhGagmvoK8FGUNZwVxMBFxgDn7/vdgWSQYvz7mAG/2QLIg9BB9Fw+a0
         7MW8vWzH1q1FCgNiC101fK8fI3fwCtaUuKE+Sp1IycYz5E8SA3f3xTC6S2PmWO4OoDGy
         91H8l5D6gp7/iRtzPw38TlgCqs4but0J5QRi93cfuIB5NMq3TxZxI1jLbcFaAbz2zx2K
         gHjPpK0EcO1cRiOYKrJTGgUYHN6KPxn8ujo3HdlgTtVQgNu/UyKneUv47uRqiAZ+i2Re
         Svp8u4G2zMqFM1AMAYe5fQVVQoixIOy5fFE1dJulFt8wikhtpH3FbXnbSScPWrDU2tgZ
         ROnA==
X-Gm-Message-State: AFuF++mxp5YxGo+gbzIhWy+cUpuRoUybSTkzh9Q3qqSpVj0p3sCWh8P0
	1eFaz6+RQ3dOkOXpweM7vfUd+CUZ22rmXePUQ2hDvHFbR5PkxOjVzqM3muTxfVwr49KZaPqU3sE
	FZILfdOiJDlqBikhJy/uHzah4MQjQNb0=
X-Gm-Gg: AR+sD11ABeJYed/q/3xkasu1EZ53XqXyvDbGZEfRH/j5AHmdJBb5JX3HL1KD89UibYB
	KZSNbHK9FFrh3oOlBnz7DFluTMQydAlRi4wiTWcqdcOFAazFzHkzAp9B5JvQClALhW1V3ag61Yp
	y5j/TzMS2XT9tNTeuy/5U3GniFpz9AcLmJBxpZaRWJKJDgvAVAC+1zZRmEQV4TdBh3lX21yKUgH
	Ww3aihrmHzkvU1/Qqmp365k4eHMwdSPxpFdfkjEChF+e9xtlIJBTQZTlvEb6guAgyTxQcYYhz1s
	Wqp8QfvEQ2RFSV6kynlD/vA8iZ08L7FpwgDgKHXp+w==
X-Received: by 2002:a05:651c:31c4:b0:3a1:93cb:fa44 with SMTP id
 38308e7fff4ca-3a1fd660d67mr23164261fa.10.1787767911518; Wed, 26 Aug 2026
 11:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826140626.40798-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260826140626.40798-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 26 Aug 2026 14:11:40 -0400
X-Gm-Features: AcwNN1WanXo1qNXA7q5_DV0Vbz40hb1x8q8XOuRa7rwNyRRm5oi9L6QhJxLDghg
Message-ID: <CAP+JOzTrwtHA0zbdq-Qbv6WNxSL-FN9jUFgutH_PMiTwP0mz1w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: setrans_client: free daemon response on error
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:06=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> receive_response() writes the allocated response buffer into *outp on
> any successful read, regardless of the ret_val the daemon reported.
> The static helpers then propagate ret_val as their own return, so on a
> translation failure the caller sees a non-zero return with *outp still
> pointing at the empty response, and selinux_raw_to_trans_context() or
> selinux_trans_to_raw_context() overwrite it with strdup() of the
> input (i.e. they fall back to the identity function for translations).
>
> Free and NULL the response on non-zero ret_val so the helpers hold the
> same *outp is NULL on any non-zero return invariant as their other
> error paths.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/setrans_client.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_cli=
ent.c
> index b0adb308..46cbde79 100644
> --- a/libselinux/src/setrans_client.c
> +++ b/libselinux/src/setrans_client.c
> @@ -218,6 +218,10 @@ static int raw_to_trans_context(const char *raw, cha=
r **transp)
>                 goto out;
>
>         ret =3D ret_val;
> +       if (ret) {
> +               free(*transp);
> +               *transp =3D NULL;
> +       }
>  out:
>         close(fd);
>         return ret;
> @@ -243,6 +247,10 @@ static int trans_to_raw_context(const char *trans, c=
har **rawp)
>                 goto out;
>
>         ret =3D ret_val;
> +       if (ret) {
> +               free(*rawp);
> +               *rawp =3D NULL;
> +       }
>  out:
>         close(fd);
>         return ret;
> @@ -269,6 +277,10 @@ static int raw_context_to_color(const char *raw, cha=
r **colors)
>                 goto out;
>
>         ret =3D ret_val;
> +       if (ret) {
> +               free(*colors);
> +               *colors =3D NULL;
> +       }
>  out:
>         close(fd);
>         return ret;
> --
> 2.55.0
>
