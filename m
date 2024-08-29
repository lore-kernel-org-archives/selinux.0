Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802619048C
	for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938633; cv=none; b=IwOWPMHrigiFg6GZyOVGwJqVRJndg6ofqyYSPqWO32ha/9JS4PVBBo6Kd+30y4WUwDA47xYMGUXcto8f3TnqAVjM62z/eV3LEggxo6yKwS+wgnfIfzCEgxAQexXYBd7hdzZWQnv2Mu7qJtm2Wo0KMb7sISTzUMR169QI1SAQK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938633; c=relaxed/simple;
	bh=lmif4Y9aFnpb6/KE+X0Mgxk7UuP8fat/+m8TDSCPPTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1d0J3Bh0YldqI7FlIjRRTUNV4IFKcLLN0LdIt92T+zICNuIX8+Ot+9ckbj7cipo0M3L9eIDt4l/w30l3oOfLsr2geIOqfykuW/8lFCIBIuDJUPRYVVNSPQ+aDZsJAUKQidwgBDKBktsq6w54el7qpn/1nAVDDmFRVVt43sDnF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URFTiIqD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URFTiIqD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201fae21398so4681115ad.1
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724938631; x=1725543431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMqH8k4nienyElkSON/8nRU7RJYi9oF0aMbmdXddj3w=;
        b=URFTiIqD4HY+Btebu3Thf5npPRaE9FHLd0ztWBqF7Q3FEKME7JBVNZCc9+Y8XpC5WI
         iCQlNM096J0MR+anl6hGMyiDlzQbdm1BNffUOGfgRrgoka9z/aILTi7KVJuuJtMMuF1P
         WPhpAVjxCKAfBflVM63FTGXPpVUVwxoFLcsx5CSj1q/f7V1gmsownpLSO+RSj8BhlFh7
         1bFeFeRmEwy1j/7C/cz5vvZBf8aYTvflYhfDn4iiNkkUiV49edAnb30RQa2gjWCunhKk
         xiJf/9z4YnV+iMPZfupAJYYUn80HR/LGVxadOCkRcEikKxaAQC3BcisOw2io2M4ydp05
         PD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724938631; x=1725543431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMqH8k4nienyElkSON/8nRU7RJYi9oF0aMbmdXddj3w=;
        b=CnC8Pr9FPzXBUuhHWulzFoL5ABi7nkiHPlA82ez/YBcnwxnzhu7fCne3+8j8pGE/KD
         gNmn4Sk2kypIZbM6KN//YHvdgnDif6gQtk02otmBnUnK5XOPTQzRxuCE/4NehObmTt3c
         4gPYPG1RaKRsskKCmTx65kOcGRPWNz48HwP0B2XEp7X3oIpeKbOgOoecn5B71IUt4vTE
         SHwE1FZtBhb8oj5pX63mzw6e+afWpbAKKUADAPYrN92/8QAa/Gr+ZfxPRveuKY9fJ9BW
         K+mVZhg/nUr8OAgBtzYLGdtSK5raiFdzZ9jpFcklmkyqgWgxLPzCoDQO32gw+PYkaoZ1
         w6XA==
X-Gm-Message-State: AOJu0Yz7MFa922cjXT3qKcbY4moD/cPhO/g4vIK59Qv8Pxnv/yDUeMZx
	p2d4q1keSwQ04ufcM8vYinh+pWLlvk2XqFfsGRjZDC1IKXDRWOmWA2QWdHpT4rWtJTiJhR94fYm
	FpOpDJxt/MCphqv551tyeGTyxoJQ=
X-Google-Smtp-Source: AGHT+IHCCX9vjQUSqMccCWzJaoN/sXuq9sMe40o8rVjhehUSjhCXhcioQ2w31+m+tpv1Y7u/2nApejPJtcAby0XzqrI=
X-Received: by 2002:a17:902:e5d1:b0:202:3b7c:c3b0 with SMTP id
 d9443c01a7336-2050c3e03fbmr33961155ad.38.1724938631058; Thu, 29 Aug 2024
 06:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827145518.469490-1-omosnace@redhat.com>
In-Reply-To: <20240827145518.469490-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 29 Aug 2024 09:36:57 -0400
Message-ID: <CAEjxPJ5LXdzRXrLZH1FCJ31h6qCD6WFaUTkoaOyad5Qsdk8rMw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/key_socket: skip the test if
 CONFIG_NET_KEY is not enabled
To: Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 11:09=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> RHEL/CentOS Stream 10+ and Fedora ELN will have CONFIG_NET_KEY disabled
> [1]. Make the test skip itself when it detects that PF_KEY is not
> supported so that the testsuite can still pass out-of-the-box on these
> platforms.
>
> [1] https://gitlab.com/cki-project/kernel-ark/-/commit/99d6d1c86fe1bb1df5=
c0b80f4717826c2330e291
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Wondering if we should drop NET_KEY from the testsuite defconfig too then.

> ---
>  tests/key_socket/test | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tests/key_socket/test b/tests/key_socket/test
> index a13327f..3f371fe 100755
> --- a/tests/key_socket/test
> +++ b/tests/key_socket/test
> @@ -16,7 +16,13 @@ BEGIN {
>          $v =3D " ";
>      }
>
> -    plan tests =3D> 5;
> +    $result =3D system "$basedir/key_sock $v 2>&1";
> +    if ( $result >> 8 eq 97 ) {    # EAFNOSUPPORT
> +        plan skip_all =3D> "PF_KEY not supported by kernel";
> +    }
> +    else {
> +        plan tests =3D> 5;
> +    }
>  }
>
>  ############ Test key_socket #############
> --
> 2.46.0
>
>
