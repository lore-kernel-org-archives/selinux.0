Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248921E5B68
	for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745119; cv=none; b=ed5yuRD60JS5eBetO16uKqP3FXnRrAI5blzkU7NH51FilY+xuo6As2xCgvX9H0Whmck6nO7hQn5kHqVNCk1C3wUuZ77SdBGzqpc/2PnZCahroPOiVLtF8YB1cQjtxHLd1ix38VHWyy194GXPzoR+S/5Ad0irGbtIoBqjWi5ICsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745119; c=relaxed/simple;
	bh=X12tHxB6JCVB9Rt3QqDE9Q4qImfVqf0/pOSe9DH7Tc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUYKRqS8to682xAlZH3PFVa7M0r8CPFvOLOCj6a/NXadugxd+kVOuyCZvRNNb4V8sNoGKcKbU1uBA6R1ykRbXHKEf2eAJiDtSLtuKKiofTz+X4ODR5bA/sqq7+siM/GFMSoMiXfAGvqCiUGIjQkXFIPX+LmEacyRoY74y6kO9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDobAEIC; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDobAEIC"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2c49373c15so826944a12.3
        for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749745115; x=1750349915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht6qh+hQP0bU9qwB6Z7h9S5UyPsdXOxCzXPzxEkNVC8=;
        b=PDobAEICWR41ft2+3WMPI91XbgFoRMioYh8Sbu+kXdeHq5bP8CBNYbG+ngFSobWnNS
         ydyb/WJKsoC5fmJlzcgPby0s5FxGqPRwCl9ccVvOW0HtPcIJXiG3FjWS8KUmBu78cNoA
         jI1BDsZI9V8i5MGsL+JF++0ww2Uv94U4hWcJsKZox1PKS7+2u0icOVxp/iHnAlwkpKsp
         PSWk//hzSj+fZ13NTKZdjottapBJB6TljW7r9a1cBSejUVEMleUd6oKg9Zvo6tRLrzgc
         YLrtjEjZPB87wVSTJ22O6mP/LdgS0ltpxeLBBE+DbC9IOAkkz/H0d2y9TsGn3+z/ApwK
         iIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749745115; x=1750349915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ht6qh+hQP0bU9qwB6Z7h9S5UyPsdXOxCzXPzxEkNVC8=;
        b=RJZrW84rSDbrP04Gs8LLaafvTd03US8qosaFtyFPiUx5QiAc+QQXY2VmBaXyfIMXrT
         uqqB0QU0PraWxjIBfV3z4GNIeiBQJtE/r88BorzKtdJg4eD1B+8CDS9HcwqVRBX15WAR
         H5N7rOSdiEABr2/M1s0GLmolP1U4tKcfcgoeJieQOCNUE9LPk4uo3SrHGPq6Ng7O8kfD
         In5iU2c/y3SscCGBzTnL3A3hWHKRam7+jG0XJuK1YvwvH6ueSOdjxDkv9/yfzsAQ6T17
         5O7rGKIp1HuLk6opjYxEmcz9USDG6fFhsjW0Qrj1snvl8nOs92Pi4wp2AgHYDWxSfg9/
         0FRw==
X-Gm-Message-State: AOJu0Yxf49rm/1YPDDJQ1YTNuotDppa+Mf9n/t8CeezmWDnzIOLv7erK
	ZD9lYPUcd8NGccrSc4+BRyLuCAXkkRfXXTcDl2vBO0LXd/Yi9DkU2SODrWySuj4wMxQg+ED5CVj
	Rq4QAugHzr1eU2+o9TzmdhyKRcJdpqIU=
X-Gm-Gg: ASbGnctxJInBzWWunTNcDt23nRB8FcJmHl9IjRl8HQkhCJgMRfOx3/w0/8nDtDscLWS
	N1i4TlSQfhfpb2Ee7YhH8LS45n/krjYyk+V1C9Ftf1jHQaj3fJddCTnQmnO1zcgpxg6XNFM7sR5
	JOMvxpXZRfnuN3pKVR/5Fd+BA4FKunv0x4PoAGilNyzDA=
X-Google-Smtp-Source: AGHT+IHmUdyZFkMH8hST+el5itHpD4p/Vja71ySd9n//1SQ8CDfq3LoTxTOBd7m55CVkmJillX2KWZZuNIqBzXp5hhM=
X-Received: by 2002:a17:90b:2d90:b0:312:1dc9:9f67 with SMTP id
 98e67ed59e1d1-313bfb4e3f3mr6204382a91.2.1749745115182; Thu, 12 Jun 2025
 09:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612081208.1721183-1-omosnace@redhat.com>
In-Reply-To: <20250612081208.1721183-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Jun 2025 12:18:23 -0400
X-Gm-Features: AX0GCFvQmJw8540ZbP70M1zFXjuVHX1vqkw9Kl5j6eyFMVXBXqFKazStrbCdySc
Message-ID: <CAEjxPJ43XpL49FZmb6Ds7CD71mZffNMKSiOfpesh2Lgw1eah4Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: properly detect IPSEC support
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:12=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Check if XFRM itself is supported by the kernel when deciding whether to
> run the IPSEC tests, so that the testsuite can be run on kernels with
> CONFIG_XFRM_USER unset, too.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Feel free to merge it yourself. BTW would appreciate your input on the
patch/discussion for inet_socket iptables-legacy vs nft issue.


> ---
>  tests/inet_socket/test | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/inet_socket/test b/tests/inet_socket/test
> index ae06ae7..4cc3852 100755
> --- a/tests/inet_socket/test
> +++ b/tests/inet_socket/test
> @@ -25,7 +25,9 @@ BEGIN {
>      }
>
>      $test_ipsec =3D 0;
> -    if ( system("ip xfrm policy help 2>&1 | grep -q ctx") eq 0 ) {
> +    if (    system("ip xfrm policy help 2>&1 | grep -q ctx") eq 0
> +        and system("ip xfrm policy list &>/dev/null") eq 0 )
> +    {
>          $test_count +=3D 4;
>          $test_ipsec =3D 1;
>      }
> --
> 2.49.0
>
>
