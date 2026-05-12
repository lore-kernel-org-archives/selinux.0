Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B9A3C2BAF
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600122; cv=pass; b=Eu6dXGIz480SfeFzmSmkTrd1sQhJtrANwsER6/Aj9YeOFwTaNo7GG7vFqlBjV3+KGCPWPfRsw9hJvWt86vG1Az2yMHBQcLVuo+jS6Xx2vhuLg4DZVU08/nPEXhmRa8hyBgLQ4WVj5Vh2/lxutlojDuud0IXMNbyejmc2cOZQG9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600122; c=relaxed/simple;
	bh=7N9D+iXzO7zeO5mOeYrL0xzcPL874SDxIvAMQj6GaZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUDIdtnD8eCaLjMUe4hQcFjuxERZu+4+aWJtaIn1my92EuFgl9lcOJAt8+AAAqnNhTkyaVw2/e8G6IMUL2r2BQk+5LPOK40m2PENitTyvs949Trx6+m50aZSbjP2pGF1v38Q9oIFsBDj+Nk0auh/3CGXAC5bRgrQHICiHoRs+Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTmOgveo; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTmOgveo"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso2770994b3a.0
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 08:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778600119; cv=none;
        d=google.com; s=arc-20240605;
        b=gzfZej3SUhud1Hak7unE90zz/RCsFvQ3zJPuRPpoxPkJen+RVsKNZvmqm6gCgYeF2f
         G8tMBL5OjwYQQHLbH6/HQbCUhC5EsQ3CxAoVYnrkT64I8Q4eSpJ+yK0WDFlv9mVdEAbp
         Lp1CCLDmyNNp2w1oddxII0Y0o2JjOlBxIxp3leRDjTCFhoodUJhnLLGa48MyqFCby/0S
         TR1CrvI8d6B1eWGMNK5SW4ZZBcsPX5wJ0cscXuXoNFnO6A+iiwUat18LalWW0iTnhX1N
         gtiUDXLOcw0scovWG1WhdzmkYgjTjHezyNa86ak64eWg3p8IijBqxnj+pe6rY67OpH9k
         +FIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CKtOJCRRr8PscKtbYPiDQ7NgLQbzkQkBJ4Z4P4SzvkY=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=SRIn24d8/XKuZHerT9p01xExkCkViUf80V6Aw12wOYgi4T9eCaAQYuc3OywmMd5INY
         x4J4r397kxVheutFOchydsvuh1h4rpv9yowxz6Qf5wZF/xNjB/VeINdPWvc8nlhzyRbg
         M8eO3iVS7hLYxhaqdVKZIJ9ZA+stAyWxQEv5B3bVhHncRh2wuaaoq+uOHEGjAXqgM34C
         Zlp94PSGuT21EdZoPWhM6qz/tFPPf6Q3UW5m0PHy6DYMswKCQ9ziQKBp8MRmthUgkvOU
         UE6FvjM/GBFpV7LKB7MtJaX8yLvvewJ08yq6gydGEr/jgdjYJw7p0C9F64h/FF2DuKab
         PKlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778600119; x=1779204919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKtOJCRRr8PscKtbYPiDQ7NgLQbzkQkBJ4Z4P4SzvkY=;
        b=PTmOgveofQ6ViC006QnFuu5PyukxQhOH0hTk7Y/ApjbZl2d8u+SYRFnJFPd6bHg4u8
         PfsLOC2aue++8dvR2TyokQAN4So0SCzMu0B0JXnckO64+loGidaksAiM8SKR7+R3sbL/
         JL/9vcUmJ1xgeneEUKAWm7YLPxC9RuDIKY47ZaRuOQXDGU5InA1b+RC+8iM9xIUih8SS
         1UOWBqC3QRVGLv3wuBQp7a24r1tdeXqq2jJCNR0fvJKgR35h/lpgR5qLECX0E/+ZZ3WW
         UUioTbpWXdhBVFrCbDgtYkeE2Rtq6ra/ha6OK/VjRBaX8+Qabzum/fn/Gua+lVUWSyUH
         HxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600119; x=1779204919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CKtOJCRRr8PscKtbYPiDQ7NgLQbzkQkBJ4Z4P4SzvkY=;
        b=oZ3jJN1lCPBxsuvlewYkncsNT/e4EgV8l3pnCZPdWrbPXIi+qvP51ljAl51Rx1SZwZ
         E1FnC+lHDhocAT4pPZWFy4otU4IfDoRKAcvOVU8uZSDiLEQhNd1OddMEuVS03WByVD/T
         2jr+5cnnHGY5B6Y/6v4L+2pu1MtF1yETTEfGpf8VFZbvcZBv8ecWlBjP2TbkRyrAP61y
         CcKQYdEVZVZ1wh7C6YmstuTiHeoxZ9mZnukXIr04mPf3GKUS7FjT4gNcro78sJkdBx8u
         4Z2wN4mp5gNblTn+K4XibRjueL/UwHmPsnRrROlUjVar86YMyeJR9RjPf6l6fjF0pcsW
         BoAg==
X-Gm-Message-State: AOJu0YzCGr5U6GTjNXi1m9NFsuTZHRpSemWGt6cNpbVZG7SrXpMKUcwZ
	afELDjG6eV0t0BTEheUQyzgIm0z+tQIb+Ee46k/Oa3adbcYGkjBJz43x9AkV0/kCQb4r65OyyR9
	WCxowsILkp2V0eNiEM7JaQj0OYR3INX0=
X-Gm-Gg: Acq92OHmYk6fGPdebAMr9ZUb4gVBMY23iiNL0PCH6xB+/clP3zUxEREmQ3aDQUjrrmW
	PNs/6RZwkhlMXJjguhCexyw511FW+uUQpWxXQkOh9lEaQlUHicRXdXS/5i0W2GmkeNpfbCFtAtO
	Lba59y3HDfplDAMQlcO/CYqz4bjfYVa7VtksaJSF/bajHleSVgMdq4vBvjnSVrVfme1nQhKlyLr
	elTXc/j1T5M6+q9Bc8d6qGN8Qf3xjT2n5InDkHg7gpkotDlgNaPj6xxJe3/4DLP4vVMzhWlNP0O
	JLzS/fw=
X-Received: by 2002:a05:6a00:a02:b0:829:7a62:6a with SMTP id
 d2e1a72fcca58-83ee83a80dfmr4073133b3a.22.1778600119211; Tue, 12 May 2026
 08:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427162452.132118-1-lautrbach@redhat.com>
In-Reply-To: <20260427162452.132118-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 May 2026 11:35:07 -0400
X-Gm-Features: AVHnY4LV7YmjRELRtOpdReNuZEoVmf7C2fDNHlBCYSCGgVkFxJY4FEehgvc2rIA
Message-ID: <CAEjxPJ426jE5yu5A9rLWZmpOawChP_uTk5XTCMzNJkE91D6ONg@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: do not discard const qualifier
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 12:29=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>
> Fixes:
>     selinux_config.c: In function =E2=80=98selinux_set_policy_root=E2=80=
=99:
>     selinux_config.c:284:29: error: initialization discards =E2=80=98cons=
t=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifie=
rs]
>       284 |         char *policy_type =3D strrchr(path, '/');
>           |                             ^~~~~~~
>     cc1: all warnings being treated as errors
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/selinux_config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_con=
fig.c
> index e1bc1b79fb10..1e6da288aaeb 100644
> --- a/libselinux/src/selinux_config.c
> +++ b/libselinux/src/selinux_config.c
> @@ -281,7 +281,7 @@ const char *selinux_policy_root(void)
>  int selinux_set_policy_root(const char *path)
>  {
>         int i;
> -       char *policy_type =3D strrchr(path, '/');
> +       const char *policy_type =3D strrchr(path, '/');
>         if (!policy_type) {
>                 errno =3D EINVAL;
>                 return -1;
> --
> 2.54.0
>
>
