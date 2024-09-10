Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256A1EEE9
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971599; cv=none; b=NMqKD35XIIAVmGnyOEjTXIPfQHYW/BYfaiIAJYjsVeTqDP4us6ciBWF5sjcVW2H0gDkJTunHxpeyxToIpsoTn+ZDCuiVIObYIrLylynwYMF+h9L+asQuD6zp5nzgW5ITMBbGxvyZ8HuAKimYIpydJ0+w+C3xaL/xD2Fnqkbec/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971599; c=relaxed/simple;
	bh=clej2FC8dU51u9uzUNobtkR/fsxHTKVnTHyYZXlVlJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1nOOhB/xoE3Xh000eRghW0+ySHmwDMsOyN4qxEZSw5p2L1ozJ8FyJfqNm+AFCwq9bowZeW+PpekCkTBHx7pKqENCslzQs0Vf1luKDBkp6D2nO9H6PNjcDgrO1oKG2MqcCU5zxzgNpNBeAOdyTVI1zy0oL2ZGqtLXYDN/yGOvS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKDv4RU9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKDv4RU9"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso478624a91.2
        for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725971597; x=1726576397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d07AAHLfDpmQzcGWFxm7JXmbsNZG2oXOtGu05AlNfWE=;
        b=VKDv4RU9haAVZ6RYi09aU3XCKx92eGT7hGnWI9KPr+5IsJm03zEuBr48prSYHeTSyz
         tCFV+mcK2XHnQbpkL5uhy0e7tErtg9bQpHHAthuvITRqfUXHYRZ5VtatIY8N+qD0a+UF
         hVEMD61B0Y3uvhs7KIU9zOLn2qB1f8FNNHk8h1JG8Xo5q6qMLQLaitS13LSXosS8uv8N
         895591p7daZQH0hHbjNM6Kkxwz/JaEzTOaOMqv3zQygxgIRAHeMSExMFL8XdBUVrXSNV
         j39qKBAiOpldLkY0j9aj7iNqTdLNatxJ7k9/ndFI7Chr1+4gmNJml21i1636yxnDw1qJ
         vE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725971597; x=1726576397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d07AAHLfDpmQzcGWFxm7JXmbsNZG2oXOtGu05AlNfWE=;
        b=bbPJnUCm+6FlebX18i4jK5bda9xEDDo0R1+FEMdVPmFlqVCHM5Mif01XvbjwyJwr5x
         uoMcJhgh72SrOgPI0NH7ERUYDbCiR2N5BJLMJO1jnYQFomucVcNa++hxHnxCyqxGhG8N
         2LrxoMiswkySF3c/JXUrGbcz7B/rUoojA36h2mlHB1W8vpG1O7OG9pet7HUbxjtJeka1
         IrLcdfGK483U/mWfqvIxtoszkfhMVjdGC0oTjdRT1IpDh6PvElInzSdsOgmhqCFtG0eW
         vPCCq9TYtv4aBh1TO+eMrTzw9jImKzWA1J6vA+mxe8d8DxdF+5elSspHcgp4pFZRHju/
         PVmA==
X-Gm-Message-State: AOJu0YzODeasrU6oLPY1aWpMgYzMG5BmY7GnASoNna1FaNFic84kadUG
	WubQRkaTHnUjvYj8ICMKaiHltCazhHFOChwtrJgAnL1SG9UuSir7XCZT2/4aVRW3PqNjh/uHlcy
	rRnd2GN5isa58tLt/Y4MvhzZFTVSNIg==
X-Google-Smtp-Source: AGHT+IGFsV6HhWTrDLDvytowZQgDBUJkbMmOK8Z57gHUVGB9yvW92PUMOWZ3zCUsNO6VH175QnxUTKKExqifkBOSHL4=
X-Received: by 2002:a17:90a:c706:b0:2da:8974:b3e3 with SMTP id
 98e67ed59e1d1-2dafd0971e1mr13420384a91.27.1725971596646; Tue, 10 Sep 2024
 05:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829132617.1610-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20240829132617.1610-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Sep 2024 08:33:05 -0400
Message-ID: <CAEjxPJ5FCyu9bDZt+8JsRh75ppWsmTwH2wHBf0-u_6qQsKGhpg@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests/extended_socket_class: test SMC sockets
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Enable SMC sockets and their dependencies in the defconfig and
> exercise them as part of the extended socket class tests.
> This only verifies that socket create permission is checked
> against the correct class. The tests only cover AF_SMC,
> not IPPROTO_SMC.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Ping on this patch?

> ---
> v2 drops the tests for IPPROTO_SMC since apparently that patch isn't
> going anywhere.
>
>  defconfig                                |  5 +++++
>  policy/test_extended_socket_class.te     |  3 +++
>  tests/extended_socket_class/sockcreate.c |  1 +
>  tests/extended_socket_class/test         | 22 ++++++++++++++++++++++
>  4 files changed, 31 insertions(+)
>
> diff --git a/defconfig b/defconfig
> index 47938c1..b2d4a90 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -131,3 +131,8 @@ CONFIG_KEY_NOTIFICATIONS=3Dy
>  # This is not required for SELinux operation itself.
>  CONFIG_TRACING=3Dy
>  CONFIG_DEBUG_FS=3Dy
> +
> +# Test SMC sockets
> +CONFIG_INFINIBAND=3Dm
> +CONFIG_SMC=3Dm
> +CONFIG_SMC_LO=3Dy
> diff --git a/policy/test_extended_socket_class.te b/policy/test_extended_=
socket_class.te
> index c8840b4..6f0ebaa 100644
> --- a/policy/test_extended_socket_class.te
> +++ b/policy/test_extended_socket_class.te
> @@ -48,6 +48,9 @@ extended_socket_class_test(bluetooth_socket, socket)
>  # Test use of alg_socket for Alg (Crypto API) sockets instead of socket.
>  extended_socket_class_test(alg_socket, socket)
>
> +# Test use of smc_socket for SMC sockets instead of socket.
> +extended_socket_class_test(smc_socket, socket)
> +
>  #
>  # Common rules for all extended_socket_class test domains.
>  #
> diff --git a/tests/extended_socket_class/sockcreate.c b/tests/extended_so=
cket_class/sockcreate.c
> index ee1d8f3..e3bbf0b 100644
> --- a/tests/extended_socket_class/sockcreate.c
> +++ b/tests/extended_socket_class/sockcreate.c
> @@ -47,6 +47,7 @@ static struct nameval domains[] =3D {
>  #define AF_QIPCRTR 42
>  #endif
>         { "qipcrtr", AF_QIPCRTR },
> +       { "smc", AF_SMC },
>         { NULL, 0 }
>  };
>
> diff --git a/tests/extended_socket_class/test b/tests/extended_socket_cla=
ss/test
> index 86c706b..1e6299f 100755
> --- a/tests/extended_socket_class/test
> +++ b/tests/extended_socket_class/test
> @@ -6,6 +6,7 @@ BEGIN {
>      $test_count     =3D 6;
>      $test_bluetooth =3D 0;
>      $test_sctp      =3D 0;
> +    $test_smc       =3D 0;
>
>      # check if SCTP is enabled
>      if ( system("modprobe sctp 2>/dev/null && checksctp 2>/dev/null") eq=
 0 ) {
> @@ -19,6 +20,12 @@ BEGIN {
>          $test_bluetooth =3D 1;
>      }
>
> +    # check if SMC is supported
> +    if ( system("modprobe smc 2>/dev/null") eq 0 ) {
> +        $test_count +=3D 2;
> +        $test_smc =3D 1;
> +    }
> +
>      plan tests =3D> $test_count;
>  }
>
> @@ -131,3 +138,18 @@ $result =3D system(
>  "runcon -t test_no_alg_socket_t -- $basedir/sockcreate alg seqpacket def=
ault 2>&1"
>  );
>  ok($result);
> +
> +if ($test_smc) {
> +
> +    # Verify that test_smc_socket_t can create a SMC socket (AF_SMC).
> +    $result =3D system(
> +"runcon -t test_smc_socket_t -- $basedir/sockcreate smc stream default 2=
>&1"
> +    );
> +    ok( $result, 0 );
> +
> +    # Verify that test_no_smc_socket_t cannot create a SMC socket (AF_SM=
C).
> +    $result =3D system(
> +"runcon -t test_no_smc_socket_t -- $basedir/sockcreate smc stream defaul=
t 2>&1"
> +    );
> +    ok($result);
> +}
> --
> 2.40.1
>
