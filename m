Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE43E63A4
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407265; cv=pass; b=ZhcI0EZKFErjxTlC22RTjbWuKcJysLCYgqkbPEQU7abDY8AKgpsHGmj3KebZ8MFNHI4Q3vJwQ61c+sb5f+fDcTGqh9b9aMAZYFpgMElkH2v3EjcD+Vhx3789eTGPhPHJ44LvvJUaznvQEjzm8T21zFNOkyMhB7XTfiCwoiKoux4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407265; c=relaxed/simple;
	bh=Mnp2mm95JlMmfhN+xR9wgR8NQI0O50N+s+Tk4ru8oI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa3qZrAL9AixwL3s731omWVz7yMSfqDfuXvOTNJ/9udDAwVrkNSD8i14rxdt/t8ryELbA9BoPNbXh1802GwYEvl5PXgq7yS3SShW9aaMDJ172jXcHwAXc95943EeZ7mXd5qsO2jwQlkXwMNzj4vDH8GM66kaY8Ggynl4dYpkf4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1MkKECW; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1MkKECW"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423efad617so1196063b3a.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 06:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780407264; cv=none;
        d=google.com; s=arc-20240605;
        b=a1rkN2bbjlzXdpfWv4951iI84N3LfmHjVeee7FMev2E9WQ9MvVKtuYb1Cz07v1H7C1
         /G6Xyk1YzwRAVWWCNyAjItnJwYx4Lbv6gRKoDekC/suER0P0BeteLWK8HMh4YNg/P0pe
         pOQeEBj5n6ZWBshyCxVcFL5MioEv7/88+Yx9/gbvywdLS0brvtn9ezKZLfMVa/gpephI
         rf1g/fSNCCIAZgRuje2cqt5xicIrc4z6VYdgNz6POzjafwu8LmOAE55cAW+aFxRSfNB5
         SrHthIx8lADqrkVgWw6/6dSZwzhBUB3iRtrjMGmK7UrhGrCr13IcxZk+9OOemryZZjO8
         A25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PQozq9KHiCBkkniXiwCDiI3Ejr+fI5qGMdaH8M292O0=;
        fh=yM0CKZu3WkoN94XXBorn6umQdzGfXURu/foajNHrSCo=;
        b=cxV7CnZVvEbuABC6WnF+JErZhkfuEMQSMjdBFvV6Fej9q8rT7EkV6VUThB52QnhSWJ
         tZ/X98bQm54J16cDOrQ8eZN+kKLBcHPWFbOxPhZMiT4O9k+8dotZHUASu64IbWRz2VmG
         93KgtwhGKZiL8YSxgf7kKEiUfljQrxli9KwndulVKnaj5WR/bJ9F0aUXP158V9zpqb6F
         c/zoPg+2ONY/2zamVKhNTmPlLGOD5h9RDKbr/99ahJcR/sbyoCtxjAA/3nGVQI1nSXbi
         aPIMBpvT91uOfPIprAmgUAB+3LvP29kx2LTmGiddbNefY8ICCH1A1jCR7ijHq72W9xyj
         jxWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407264; x=1781012064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQozq9KHiCBkkniXiwCDiI3Ejr+fI5qGMdaH8M292O0=;
        b=G1MkKECWR/6SVw4HZvR+H/qJV3WMITCBW4yJob4vz0FZd/e8X54s1CICIRKr+/lurX
         R0dLGVdwi2tLUkNEUddGAOt7u56VPNv1cxTT7JKJZpti0x5dVExSNw1Fiq5vTPfeoJuE
         YIa39Bsj0O9mB9HTk3ojzg0e6qs4hNCN6mCJ74fbwP/QDPzfhdTeU2nkzvzl4W+2ulZR
         HEM9VvIJWCETKRSnXLdNfb1MU+PZiZ1BXlDb9oo0CDTvlkmjintO3t3aMjqn2J4yngT+
         Bf2TaV8Q6vc0+qgyPdYfLXExBhw6i0VJgdxvBvnH+2jIf450NJrPX5sGOLtVJGxobGXE
         bPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407264; x=1781012064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQozq9KHiCBkkniXiwCDiI3Ejr+fI5qGMdaH8M292O0=;
        b=jP/NB482MFzaAygbnIv8m3G5rYQlcKRypios3IppCRN9ZJBduSsHYCReQF4EuPTY2X
         uKGNQ+E+LD6TLgBHY/NvG6H9UpSbs+fkh6JGBuKi+3UkeY+fPtLNVQvj6Xr1VqzHor93
         x2fK4Fd7hEqsYP3tJc3bIJHx8mm18ynmPONCQvvoa5rnkINjxX1B70CjjLtHAibmJWqM
         Y9VJu0ZxukmTPP52K+vvjWxcoGq17gK3qZb9BULR/0iatmFSaqTyUmV1zPUDW3aza/3+
         lvRvMa5M/EqYDCo/n6gFmum5Hz09kaOSxUzF9dgDROtIz8xwn3DXz6rKcO8M6IABZxib
         LO6g==
X-Gm-Message-State: AOJu0YyXyuUpU5icnxVqgeA6L4UmOHIWhP57cXIKXgvkY5E5Czb7u+eS
	nn8PGQ+PkLzXSFOFe+6C3U6xyTnWzKaVGwrXp2hC/v3kN7VQKHyG3JCf0mXpE50FwtPdrvjsxBv
	eH5d6paInPR8w0JeITWsFGZ7i6xwyyqbHtA==
X-Gm-Gg: Acq92OF/oyC8j0M59O93GBOGuwbRS5XRJywzy1D2zedOURuwbxQ1zNlHI+hmbCME0bD
	Jd2i2P2T4prWi0pJyns9LVr6xs64A3GyXFR4lqtCA6wZbx+nvzVDqSdd6oFG6NlS+hsNV+N8IAu
	+5yy5PX949kxvTfopyDbE7UHgZUDt6oGDtc/S4Y3o6o8WoJuE9FW+W0JvwzKGtkAVi80qcbuC6j
	fa9bnlv0Gaoz74U4MgyhD06O5qXt0AVLsZNcVkXKOHz61GJV4uVu/VtpUCozoubiOnDEMjZZRe7
	OE4Lne2BkuaPvyGEvA==
X-Received: by 2002:a05:6a00:228c:b0:842:4907:d077 with SMTP id
 d2e1a72fcca58-8424907d6abmr9235840b3a.48.1780407263319; Tue, 02 Jun 2026
 06:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601202911.1676130-1-slyich@gmail.com>
In-Reply-To: <20260601202911.1676130-1-slyich@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 09:34:12 -0400
X-Gm-Features: AVHnY4IDa-tG37p2-zh5O3uviU35fAO1EuKjJNvTJ1ftDGYRKcpSDoTI8npf5DM
Message-ID: <CAEjxPJ4DhfG8-p9=B5fvv6_GFNtEg7T-KekJyXsYQ8TmJzabKw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: drop long deprecated `-Wstrict-overflow=5` flag
To: Sergei Trofimovich <slyich@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 4:31=E2=80=AFPM Sergei Trofimovich <slyich@gmail.com=
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

Please add a Signed-off-by: line with your name and email. git commit
--amend -s will do this for you.

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
>
