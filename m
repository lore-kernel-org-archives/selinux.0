Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA8123395F
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180594; cv=pass; b=LPbGINVk2pwbwdF/4K46NB8j/WFFAvNuELDGG2qe+pneKzGpVj4fOj53KUTo9kTFiFlSmqOcxWjAf0Tg/B6S6Fj2GPd4LSuX8EGsf+t1ynQ6F1DOe9ifLgG8VEAYwIkpqCACUguNOJks0+/qY8ZmssLN9WdvmzxZXbi3nf3B3vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180594; c=relaxed/simple;
	bh=KQbWujv+HwyLqMf2Y+nNtCJMhLoGlGTSF6nfB2FfAB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2lSH2VXNAs7ZL0hqZtEhPmWeSSDZNa9Rt1XeHWuZBdXOBFCJqt5o5Ji4xWYiFmWdQes5oGLjA8H3g3hKRvDxnFye/zEoSbCZMuVOGxxNC7FbIuGSp0if9m1YBHWi8R7MwW+61GXljbLKL5j6Wso7RuYbzZBgBYx0HYBdyfI0Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFyJq8oW; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFyJq8oW"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423610ec93so6141325b3a.2
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 05:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781180592; cv=none;
        d=google.com; s=arc-20240605;
        b=V7h7kpd8PgmR71FAo69rmxcyF3CAa+Pb7bt7rBwB+dXrxLmPH0zvJhn/5eruJpEgAg
         +PGarcbm0w89oG8Y5MJ4zEQVxgSlHuaSSp/vKEPfuD/dnku78ih81hGzgECGhVR0gppt
         ylwTds4R6FRCDZSKOBQ4XpTjK3qAaYtUrOYX4lz7MoS7IGtFX09ubtlf0R+yoQNcWX9y
         HYv9HQKgYVINOHEbgXqwjCVhLi8/60vOyieHQtmOZmRdnTSqhqiICnUcVnzYTljrUl24
         wCRxGe53obIPnTDubhLFwY5C3T8QFlhbN/aq0sNlDeionRcmO9aWhkPrdpHwdMCQOxWe
         8AYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+bydRt5gdp3KpXxngd7pJHLuk4FTPPW3YwraLbuoqOQ=;
        fh=wY8gy0iOksnwzvOC7hqRV0Sf7JK9ec7jJ+1ccj8gvlo=;
        b=JMSfk7Sfa4CAlBiBKJM7HTUbJqkIgCFLL2G2FtUj8B5wp6MSbMH6H1BmhCmAKwGmOV
         CpydQap9Kym0CbJV8vXqVaLnQvfuT1QyiSlQVO43wCjjBZF1/Ep28m9q+IepssY2e9Bf
         4YbHoUkd7ZPh9wHljb/sf1TGL4jysVg5H9Iyj/9A8bQ02CshVmOx7gOFV9g9Tv0E19DE
         4ZoE0LlhE9Dzfsmpsbrq7cTpLN7cI6+GyHwIIYkDIRcmKOyooO2eBQrnHuMWGnCp1J0m
         3sN6jSFN5OkE7R6YOEt+d0YMaLh0S/hiE16lZhAWjziUgEhV0UN9zJ/Niflv3WEP1wkq
         UF4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781180592; x=1781785392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bydRt5gdp3KpXxngd7pJHLuk4FTPPW3YwraLbuoqOQ=;
        b=RFyJq8oWNEyVn8/qsZaL38ZCMRkbNzt0EEBRFhvDg2g/r7t95jtOfEUAQSFBM5q7kH
         7p5wn4qRXeK5JbnzfuXeMh1gDphCoaial2kxd8MnM+I0v5peQP1cYsMlBzLetWAyJpEM
         LFzawc+q8kg7ZF6eOOBpOxR61QgIcSbA3D5IqIH93AjDyfIUi74zz+P0BOYIG1zLvHBY
         96CeFC7s9IaThX+ltI02xBHu26d3NEnby5cnVJv3N4IpKGQ96+WtvPLonLMpTiup4OE0
         6piOAO/ynLp73LFbjrN05udh/SffxiUPAlw2+hzQhZzcATSMWKqUB5I/LUw30ObWNyj+
         IYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781180592; x=1781785392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bydRt5gdp3KpXxngd7pJHLuk4FTPPW3YwraLbuoqOQ=;
        b=g03FY05fZS57Vu/E8Zn7BpQ/6acJRwjRcwhpPoh+e4GhlcksBi4qGzw1sikSeNp38/
         EGagh7wliDGYV03oc/Mkr0mwvpQPqypgV7rW+tHK2KqxGb6I1Vx2mT1+6+TsHNkPpI6E
         PQ9zWMMze/1Xdkok/vUbEayF4jc/LKegkv9oLOSIVstMJ8hx5+nyFQzGq4M80lFtMW2x
         wC0Tq4LOXjb/kdmvb+P/ppAsgA8aSBcJUDt3ZAZwfKIUcLz3PLAD984tPSx3M4RaGfo1
         CqgkICNFdKcpMXbkKvdbwePnLQU4cKts17DY4HtJqdOHJZd9qJxxFTWWQkjYE1171mKe
         wqYg==
X-Gm-Message-State: AOJu0YwsgyQylJmKFGip/z/bC0wChA0jXsXJBDvddvmxC0tLya761cD3
	adEpBX/KKP+a0g83ZH6iH3FjYpX559RVvyyKXlFIKk5/J/NVdAOCAMjzIkiU0FoYpa0IK+WFwGl
	KnCOOTm5HJGME2Ak4wXbYbLOTqUsmwMhWsQ==
X-Gm-Gg: Acq92OGK6IMNW7Ya4TxtckFv4/fzxUdf3YO11Ev4JZBXVT+Drz2BunqAh3zm2XPelAP
	pVVybGhmGNHdipo5854kW6zbYo4+T+Hz5xlxrQ38nRuIj6ek22Clg+cpG2jgmQ7MGa5iXHCMMmU
	PYilzPSsrPRKfqzZgCYPtOXMJ3LuvBOVYuZh1VdVZb38E65+wgKnor3L1mq+coTidzCR6IUP2is
	ErzyAAU+FT/IeCAykG7HIydQcdQk9NRG98tdmfG+IY9umqSkwE/wINgjuSHLXP7/b9xQtfUbPaC
	uqeeDnU/lzN+eUoxpw==
X-Received: by 2002:a05:6a00:1412:b0:823:d2c:b156 with SMTP id
 d2e1a72fcca58-843367ea5a6mr3007346b3a.5.1781180592528; Thu, 11 Jun 2026
 05:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193945.10035-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260610193945.10035-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Jun 2026 08:23:01 -0400
X-Gm-Features: AVVi8Cf2DG2BUVnNjL4Q-nesucfN-5anNMP1Kvf9-iVYEIxUvMCUZaA1fK93LT0
Message-ID: <CAEjxPJ7-YVAWqg2a73OaPtie=zJV50sz8erniyTwz-rKcs=KQg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: always provide matchpathcon_filespec_add64()
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	Pepper Gray <hello@peppergray.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 3:40=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> libselinux.map lists matchpathcon_filespec_add64 unconditionally but
> the symbol is only defined when the public header renames
> matchpathcon_filespec_add() to the 64 variant.
>
> On musl and 64-bit glibc and USE_LFS=3Dn, the rename macro does not
> fire, so only the plain symbol is emitted and the version scripts
> references an undefined one. GNU ld permits this, but lld defaults to
> --no-undefined-version and fails the link.
>
> Provide matchpathcon_filespec_add64() as a thin wrapper in every
> configuration that doesn't produce it via the rename, so that the
> symbol is always defined.
>
> Fix: #512
> Fix: #513
>
> Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
> Reported-by: Pepper Gray <hello@peppergray.xyz>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Based on further discussion on #513, I am NAK'ing my own patch and
will follow up with one that fixes the linker flags.

> ---
>  libselinux/src/matchpathcon.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index 2623e5dc..292ab7d9 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -299,7 +299,17 @@ int matchpathcon_filespec_add(unsigned long ino, int=
 specind, const char *file)
>  {
>         return matchpathcon_filespec_add64(ino, specind, file);
>  }
> -#elif (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) || \
> +#else
> +
> +extern int matchpathcon_filespec_add64(uint64_t ino, int specind,
> +                                      const char *file);
> +
> +int matchpathcon_filespec_add64(uint64_t ino, int specind, const char *f=
ile)
> +{
> +       return matchpathcon_filespec_add(ino, specind, file);
> +}
> +
> +#if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) || \
>         defined(__INO_T_MATCHES_INO64_T)
>
>  static_assert(sizeof(uint64_t) =3D=3D sizeof(ino_t), "inode size mismatc=
h");
> @@ -310,6 +320,8 @@ static_assert(sizeof(uint32_t) =3D=3D sizeof(ino_t), =
"inode size mismatch");
>
>  #endif
>
> +#endif
> +
>  /*
>   * Evaluate the association hash table distribution.
>   */
> --
> 2.54.0
>
