Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50E2F0C45
	for <selinux@vger.kernel.org>; Wed,  3 Jun 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490199; cv=pass; b=J0854oQj+zFf+wzuaL3JnvX7eg4NL5uhYqEMSEvjFl0qjskkPwJoiK6NWmEvsxkM4O7JeBfl/xNiB2fMMnHNwf5Bn5I8r1GhR9iyF3nSy55AjUHoyHrJO8HOWzGQ01TiTeFU8IAPMILvRSF+Jd+kh7d0NDMaKlp1MSQEksrC/iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490199; c=relaxed/simple;
	bh=LNdJ0llEl4TfN3QpVbt0zYQ8weygXE8Xh1XK5xoMBQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5IjOdX+kfn57HJmOnu/Ol7kOU5wa7cB4ohqrzkeIVvVeRjGbDeeE6IiBff1dYCanvNe6R5wvZ0VDWBJHiOO9ZBwEPevmxv523G3gsPcp2w67B/1bsLeX3WmZEoe0V8/VWCV8GXKJb+hFFcpVLRLjqyOTB9pxqrlCAnVFLk+I3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVMpjaQa; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVMpjaQa"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf1cda2b17so4552975ad.1
        for <selinux@vger.kernel.org>; Wed, 03 Jun 2026 05:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780490197; cv=none;
        d=google.com; s=arc-20240605;
        b=MU9Mg3g8+2mPnp+yzk8XGx+Ew3llxcGEvlTg9i9O2CswEx7ehMB2brWTffXO8eLgZC
         cQ6S82lPWgJvo3dD//cwQYiUF3VQl89tRENnMNYy1BLBuZomamw7a+CG4OxkOsuqgbi9
         C9NEsHuwubisrrW0rjO5ZkvS11Rp8qHKKAmO+WCeUeyDdSJUBe4XwSu9ZRIGDClVFM+a
         HnO5rDAec9t37/3k31w3b/o7eFYt4tcdVVHmWmy7zDFtFh8l5vdIkGpZkwuz8TtpkgYK
         luaxEuHTZ9IduqtRtL3eLbUv/cBAisLVhVFp11V2DEJFboQ3nYim0ybablygl8TAUVzu
         QTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hj3W3nrqRCKQAHKqI4ObXrECr9ZCrrb4gwHOOAFM37A=;
        fh=yM0CKZu3WkoN94XXBorn6umQdzGfXURu/foajNHrSCo=;
        b=G+94TXyUWz6HvBw55vFz5/eGVU6oi6q3/kw3/okKowhVx2pP38TJKvdbG4BHgFbJWD
         KVyJlQwpRe733touSsNI/qXPUgAK0El9DayimcFyrp/DgpUjjuMQlzPiLZc9+v8D9h79
         7Y2csyNLnRYBOMSvyDiXQHCZSNRmhMWHLEVBM/mvFio/1bCUFQvGGqet4Uin8NGm1OtL
         CHCeGfYXW7S3ZvuPYRTcMY9vSaz0bOJjAY1lLA5FmTZOf1z/WLEaO9e2ne3CdwT9NQa2
         OJnujXTy/JaTEYMAg0RPy/GBar9ZQz7IyYDtUDQWnmhwKAOgP9R9lmntSZm2k3qN28tM
         QpTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780490197; x=1781094997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj3W3nrqRCKQAHKqI4ObXrECr9ZCrrb4gwHOOAFM37A=;
        b=TVMpjaQaIwzuFHPoWU/RXUgXWoDQtUuqbty71/CQU4uybB2mH26UU0tZJrtM3zK/2s
         PwOSijyDWF+VjSIApibZ3gYdgknyMh4R0hpDVy7QFj47k34bsqqcWrCfKOi+gvSqDq9h
         RxlZiCjGJTyWsfUMz/yyQ8+R+jSrjxF/o404pEpF9cFeWKSJQFc1cS1bShnui6qgsMwM
         9IHsgppouQLqzE8dO3y9sd+W8N3PAdZD5Sh8cwuwsMJS+eeDHjNHUeK9WfJCANpKTt/z
         w4I8/EtoE4asMZVsMzGf9gRC4AUdJlpKB+T99AyO/Jq8xdBBEjerg4Iqm2dazQPbO+p1
         dbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780490197; x=1781094997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hj3W3nrqRCKQAHKqI4ObXrECr9ZCrrb4gwHOOAFM37A=;
        b=RzagMHPx/dSinyV203Rh2VCE7Gj+XrtiKKFJmd6RbJyfISKOwb51+eWx91uGTfmWoL
         oGQ7l1ZaqSztCpWoGo/gj8M9BzRZ1lp8W/G2zctkl1BZNIB+MVTRzWEIMFMh9VpnhLEX
         hyDctpdY4qS7x2j96AjE4eMN2s3HRCehO7V/PE02cqqPm85xA3v7O7wPX1ykKfE5gOO9
         adygV85LLj+PgPwOPArSR+g26ofqIx1YNuq+jM6JH7BphTutRwbXD9jS15sJxqNPK49j
         9HH1RgylxA2b/qxbcVnzG6rGptgYg8wFpsZOwaTRJvlVLV6e/n12EPRvTPJ7yrLI55lt
         81mg==
X-Gm-Message-State: AOJu0YzwUOVfHq8qzprHocOyw+oUrZfIvyGeoVli35rDP+cLZE9woTMe
	FZuSJuS5VERd+e5s5KiUH8ApJBrtdU2eNGjTrX3iZsMxys0SAlsENMpdXwgjowcIXkdSrhGlnDX
	6oF/hyIYuvb0QRSrZef5dp5XbQ2u8+YVj9g==
X-Gm-Gg: Acq92OHpEDVXW5fFj/1Qi1hf2Xlfjhu3J07LmDhZY7Wf8f1FnYdJ/Q8dOCjl7aTqQRD
	7FViI/CB96wsozjJSGjt6lBvIJoxuWwDtkzuZ3DvIpQDFGDt3keT73XKk4T9T0xOWLLAZnwONOk
	4QLTJpAioG0QsrBXSTdT3jeoRudF6aSgbX0XoMtcDSqdBVIhpl4I2wvf1cukoOxWeoe7tSZDbWD
	fDhG8u207GOAqOJ+Mfe+fzqrquNXcC2LV7keOingUd0LTx7Tndy7EcsBD9KjRCnEU6hBeWGfGQv
	mzJve0VDc5GETPTPtw==
X-Received: by 2002:a17:902:c40d:b0:2c1:13cd:f801 with SMTP id
 d9443c01a7336-2c164d71c6amr26187155ad.29.1780490197095; Wed, 03 Jun 2026
 05:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4DhfG8-p9=B5fvv6_GFNtEg7T-KekJyXsYQ8TmJzabKw@mail.gmail.com>
 <20260602205343.3692139-1-slyich@gmail.com>
In-Reply-To: <20260602205343.3692139-1-slyich@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 3 Jun 2026 08:36:25 -0400
X-Gm-Features: AVHnY4I3gLi1sogDZY3Hor1OBbx4C7cyQEOFs4bAeEFdsF3yziyQeFFusU-8flk
Message-ID: <CAEjxPJ7-Eaiqactq3wXw3spXcC2zcHHNTgrsB9HZnz_aS3oFFQ@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: drop long deprecated `-Wstrict-overflow=5` flag
To: Sergei Trofimovich <slyich@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:54=E2=80=AFPM Sergei Trofimovich <slyich@gmail.com=
> wrote:
>
> `gcc-17` formally deprecated `-Wstrict-overflow` options in
> https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommitdiff;h=3Db31a43560e88600d4=
12318f75a43ac8e562ba8c5.
>
> I only noticed it because `gcc-17` deprecated it slightly incorrectly and
> started to fail `libselinux` build: https://gcc.gnu.org/PR125558
>
> While it's a `gcc` bug `gcc` devs suggested removing use of the flag.
> This change does the removal.
>
> Signed-off-by: Sergei Trofimovich <slyich@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Will defer merging until after the code reformat but shouldn't
conflict since these are just Makefile changes.

> ---
>  libselinux/src/Makefile   | 2 +-
>  libselinux/utils/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index c62ad1ed..373a6251 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -65,7 +65,7 @@ EXTRA_CFLAGS =3D -Wlogical-op -Wpacked-bitfield-compat =
-Wsync-nand \
>         -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=3Dnf=
c -Wsuggest-attribute=3Dconst \
>         -Wsuggest-attribute=3Dnoreturn -Wsuggest-attribute=3Dpure -Wtramp=
olines -Wjump-misses-init \
>         -Wno-suggest-attribute=3Dpure -Wno-suggest-attribute=3Dconst -U_F=
ORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 \
> -       -Wstrict-overflow=3D5 -fno-semantic-interposition
> +       -fno-semantic-interposition
>  else
>  EXTRA_CFLAGS =3D -Wunused-command-line-argument
>  endif
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 20dc44eb..ddbd2445 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -33,7 +33,7 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-s=
ecurity -Winit-self -Wmissi
>            -Wno-format-nonliteral -Wframe-larger-than=3D$(MAX_STACK_SIZE)=
 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 \
>            -fstack-protector-all --param=3Dssp-buffer-size=3D4 -fexceptio=
ns \
>            -fasynchronous-unwind-tables -fdiagnostics-show-option \
> -          -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-ov=
erflow=3D5 \
> +          -Werror -Wno-aggregate-return -Wno-redundant-decls \
>            $(EXTRA_CFLAGS)
>
>  override CFLAGS +=3D $(LFS_CFLAGS)
> --
> 2.54.0
>
