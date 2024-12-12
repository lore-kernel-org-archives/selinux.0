Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E022C36C
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019386; cv=none; b=J86rzpoweF153pfVf7e1l6zMtw4IQMtRXP3SYBnrqNt9amt/gwmklGOYgJO+1YSNVkg9z2bYMnM4ag/3TSbMfeLu5FkJXS0VgQJVmNidVnB82HoZV7bZrcdi9jO60o0LU2IwFsMKbMjsxJZ2QFg4OSdCAJgrZe0D0Brx6rz1P1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019386; c=relaxed/simple;
	bh=WdNaGXIJeztMDdXv4oE41kZ6rTeQNYqf/AaAXLw2/wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKtextOUPkxABUdLHu0ewLJNy59k9P7Ar+9XAp1JYFnnzAIQMq7BCXk8kNduLfwufzH5xmTGozgLgCZU1ot9VQkkdusvGdKJ0q7nnmLYHY9vYu6tYhI+HeOTwjTM0EU8FpTJw++T7RsI25XCNlSDVoIWfyYqFzP1YeJ6Q8HYL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQ0yzJQ4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ0yzJQ4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2163dc5155fso7383225ad.0
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 08:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734019384; x=1734624184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1flX2YRH5/VXhs2QA7UuscpVmKNWozeziZIEVV+SlsU=;
        b=EQ0yzJQ4wphclIcy5A8y2woRqPqoK/TmEfkn+h7OOUz71sjQLRrjtcR/6Y9HY0Rqlz
         c1bnm8wFgo7A7qyZFtzxtyMsODXiUi1u2MlmafUmsM6Rn+w/j5S+dcbKwBmw8WmEdp1+
         a8kjEMljXqWy1dPhnD2miUfmkzw+xxMFM1V4DaD0Nug4xwb+Fs395lNNUCUJGkV7m19F
         2RY0H+3id/l7e2rCkm/doOB3j1/JJG2lrqVSDlpciPjR6lu/gU0miObN6nABaSybcL/s
         qgUNLnyb+RDonp0Pvy/uBaSL15BGxLqeCVoIjbqoDpZhMkcpgrLGQaxXXB63lhbULdcG
         592g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734019384; x=1734624184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1flX2YRH5/VXhs2QA7UuscpVmKNWozeziZIEVV+SlsU=;
        b=vMgHndDFweJhX3CbsCHriA50k8yCz809OYYCsRrJxLWk6sYCTEsyqvOeaQt7KJVKFs
         RWJzOhsOHPJ8LyhjfTRthWIXfiuJBzDRKorA6zId+duJCZJvKBdRbPugr3xyIyHY9Q0b
         4z7AxX8qO53mN9C4B2snBt/vRgN91SMtTXRT6Y88Yiddn2S5E2OSeeej9ba14nSSlkQN
         LDZsj5xLmEYKYVRXvQmyToFF1MFRUEWJZ/w513j/pAa0Xexqf3la2KcJL6vXJ1aGVcJf
         aUzXgv+nANU1nYzDTxAZMt9AIfKQYtzUhGNQMEyy9/FxCkGL+LS2NGPyaG2pvrzmYhwY
         wrFQ==
X-Gm-Message-State: AOJu0YwRAu3Ip2B3RX/z7UO1PptuOGj5vFvA7v/7+qtY9max4xdHzwJJ
	CfosD0ChSRT8rSq1dbFX/2OfRsBXoRn5Zu+ZNsf7RZmPdetH/LxJ9opi12fUgR8yZe27BL1SBP4
	gXTkMZq1qj+/cAUAPqdjDPcP+/dE=
X-Gm-Gg: ASbGncsxcWlRLQH58pDrS0Sre5qYEzyq06SumtDrSZdrS+XDGKGzQYpZxET7JmeqYDN
	b4fbkf9hxaSvGn6yMCq8DblOaLvN9KdPW6bsvmw==
X-Google-Smtp-Source: AGHT+IGWF9bsca2aP0Z85RwBC4rW7W3kwxqLurc+feONM4cGD4YPOz2Xbx2DbUyUOghnGyM4wv0w0tqo4BPS3CLABXU=
X-Received: by 2002:a17:902:e845:b0:216:1cfa:2bbf with SMTP id
 d9443c01a7336-217785059b7mr118200015ad.35.1734019384223; Thu, 12 Dec 2024
 08:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128152851.14704-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241128152851.14704-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Dec 2024 11:02:53 -0500
Message-ID: <CAEjxPJ44D7kW9T7yxDVTsjzqTXnSqELFo=2GEmPu+iWN1bUNRg@mail.gmail.com>
Subject: Re: [RFC PATCH] ioctl: add test for conditional xperms
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 5:56=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Add checks for extended permission av rules in conditional blocks.
> Requires policy version 34.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

One minor note below but otherwise you can add:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> diff --git a/tests/ioctl/test b/tests/ioctl/test
> index f313f06..6c33bf5 100755
> --- a/tests/ioctl/test
> +++ b/tests/ioctl/test
> @@ -62,6 +68,78 @@ if ($test_xperms) {
>      ok($result);
>  }
>
> +if ($test_cond_xperms) {
> +    #
> +    # Attempt to perform the ioctls in the false configuration
> +    #
> +
> +    #
> +    # First round with boolean set to false
> +    #
> +    $result =3D system "setsebool test_ioctl_cond_xperm_switch off 2>&1"=
;
> +    ok( $result, 0 );
> +
> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifname =
2>&1";
> +    ok( $result >> 8, 7 );
> +
> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifindex=
 2>&1";
> +    ok( $result, 0 );
> +
> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifname =
2>&1";
> +    ok( $result, 0 );
> +
> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifindex=
 2>&1";
> +    ok( $result >> 8, 7 );
> +
> +    #
> +    # Second round with boolean set to true
> +    #
> +    $result =3D system "setsebool test_ioctl_cond_xperm_switch on 2>&1";
> +    ok( $result, 0 );
> +
> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifname =
2>&1";
> +    ok( $result, 0 );
> +
> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifindex=
 2>&1";
> +    ok( $result >> 8, 7 );
> +
> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifname =
2>&1";
> +    ok( $result >> 8, 7 );
> +
> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifindex=
 2>&1";
> +    ok( $result, 0 );
> +
> +    $result =3D system "setsebool test_ioctl_cond_xperm_switch off 2>&1"=
;
> +    ok( $result, 0 );
> +
> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifname =
2>&1";
> +    ok( $result >> 8, 7 );
> +
> +    #
> +    # Third (control) round with boolean set to false
> +    #

Shouldn't this comment be moved up before the setsebool and test above?

> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_a_t -- $basedir/test_siocgifindex=
 2>&1";
> +    ok( $result, 0 );
> +
> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifname =
2>&1";
> +    ok( $result, 0 );
> +
> +    $result =3D system
> +      "runcon -t test_ioctl_cond_xperm_b_t -- $basedir/test_siocgifindex=
 2>&1";
> +    ok( $result >> 8, 7 );
> +}
> +
>  system "rm -f $basedir/temp_file 2>&1";
>
>  exit;
