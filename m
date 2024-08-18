Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0658C8D7
	for <selinux@vger.kernel.org>; Sun, 18 Aug 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977147; cv=none; b=Y7fF4qVg4BXshOYgiUqfPF/qnOAL1KdutsDtDxDZd2hSthBanMPxZrrKZeAFAq3OGUFeqhPh++QoySW66ikdD3BfH5xR7w2hf/iFupU0Fc30L0bceA+fnYLjdauMgCE/62VyEXcXR/UiEk1yuiTwsxxPehCBfOXWH+z2rtIbCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977147; c=relaxed/simple;
	bh=DHVo9XGmfh04cK3tMUx4lYmKKKFqKy0Mvb0DLUNQIUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCP2tSybfaygcrfEBLLQiSFEAX+liFaZacMgiMqKXuWl5wJBT1liywmqgsSI8i5f8teiOkl/AS0Ds6YgBq9ovp28OMI1XA4Z2JL5pwvsSlY0H5ALvwJ28ir5eWutZM6HD66gE48M/rSMOjCMr4/gqZ6WwNIjo00oQBGg+GM9cmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSdg30X9; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSdg30X9"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so1967550a12.3
        for <selinux@vger.kernel.org>; Sun, 18 Aug 2024 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723977145; x=1724581945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FpsMXOr++yXuTMVO1gM8eSHp4YBKP4/Uh35Nk3y6QBk=;
        b=XSdg30X9c9PADIXu86e22OA8cB0hXRIXcy28kIIQHNloz11CeQ0YrC6o/4VFCtxi/b
         Q40iwmvsiQsIJj6UVu6bBnqtUASzmCLMpDqpMh4GmkzEV/A63hFtIj/TZio4Wi6btrEg
         cRY1sjyagbrYs2XcTeQHAzaH9acGK4Yf2MbG3WxKMETq9akPAyftHe0Smt+8xaT4vogh
         tkFfJuEmdYpoi2mznxyM8TYSqBxaP3/C0Da2csgZcpS5+YQXGFM1Qp9tnYL6NhLN38rF
         WuV02YWvrvF/UMrZgIpohawzHXL7p+aaYGOlSjK67Rd1Q6jLlYGod0YIiflipQvEKqzr
         3E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723977145; x=1724581945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpsMXOr++yXuTMVO1gM8eSHp4YBKP4/Uh35Nk3y6QBk=;
        b=okptc5su56ZMh6M+1iwBpY1KaqcUI3HdRF6TX3+Hgjgd0gEonLASEbZcshkpLXr6da
         U42o6ej1bwHN6oMYq06qulUmWXDbq/TsLQ6JY7oHAcsDHA9+d1xMjaMQYj6I+Tz2uHNF
         qAPmoyYLprNVUcUu6PKMVWeYpLwgTfT+lCcmyzC0MtyChdOvyoG2invorWGu3Ms+s4Gf
         yjTC+BN0n2MB/2zTjCm6qDRJDqfwHuImcr11ql5GupmaT4po2h1YZ7vV6WDWw0w+N/xw
         78hdP++ks7EeKQMvVR0kVy8gSsUKTNfZxerygCXcLFEuLrhJqqcsTf/IRQlEpW7je8ok
         ezSg==
X-Gm-Message-State: AOJu0YzdQb/nJ1ZZSlQbYdwDs6AR8P5G0OHHdOWB8PCIrE7Zo8t+pjmh
	+nKuJGgAmuyefZQgnQCy/tTOSxv+ZAlr85AM1z6YuzB6fRrHBoXuZN5BzAyzFH4+dT/15DJUiGr
	OkxC5/Dw8F1jkzfFHs1yhMsv7a7I=
X-Google-Smtp-Source: AGHT+IGHEiiX3ceNMDsU75vOFCt3SKaKFqoKxWcPRqJBVAXpC21YxEoO0/kBrJvblUpaa7kib09yXUekgNhuJePck+Y=
X-Received: by 2002:a17:90a:d904:b0:2d3:c5f1:d0d9 with SMTP id
 98e67ed59e1d1-2d3dfd8c5b3mr7193910a91.25.1723977145056; Sun, 18 Aug 2024
 03:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816144519.25600-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20240816144519.25600-1-stephen.smalley.work@gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sun, 18 Aug 2024 19:32:12 +0900
Message-ID: <CAO9qdTFOYFSO_eev6YVp6gYiLc5KXBo5AW=KKH-W_miOWijvhA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/extended_socket_class: test SMC sockets
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"

Stephen Smalley wrote:
>
> Enable SMC sockets and their dependencies in the defconfig and
> exercise them as part of the extended socket class tests.
> This only verifies that socket create permission is checked
> against the correct class. The tests cover both usage of AF_SMC
> and AF_INET using the recently introduced IPPROTO_SMC.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Looks good to me.

Reviewed-by: Jeongjun Park <aha310510@gmail.com>

> ---
>  defconfig                                |  5 ++++
>  policy/test_extended_socket_class.te     |  3 +++
>  tests/extended_socket_class/sockcreate.c |  5 ++++
>  tests/extended_socket_class/test         | 34 ++++++++++++++++++++++++
>  4 files changed, 47 insertions(+)
>
> diff --git a/defconfig b/defconfig
> index 47938c1..b2d4a90 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -131,3 +131,8 @@ CONFIG_KEY_NOTIFICATIONS=y
>  # This is not required for SELinux operation itself.
>  CONFIG_TRACING=y
>  CONFIG_DEBUG_FS=y
> +
> +# Test SMC sockets
> +CONFIG_INFINIBAND=m
> +CONFIG_SMC=m
> +CONFIG_SMC_LO=y
> diff --git a/policy/test_extended_socket_class.te b/policy/test_extended_socket_class.te
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
> diff --git a/tests/extended_socket_class/sockcreate.c b/tests/extended_socket_class/sockcreate.c
> index ee1d8f3..f72f2c9 100644
> --- a/tests/extended_socket_class/sockcreate.c
> +++ b/tests/extended_socket_class/sockcreate.c
> @@ -47,6 +47,7 @@ static struct nameval domains[] = {
>  #define AF_QIPCRTR 42
>  #endif
>         { "qipcrtr", AF_QIPCRTR },
> +       { "smc", AF_SMC },
>         { NULL, 0 }
>  };
>
> @@ -62,6 +63,10 @@ static struct nameval protocols[] = {
>         { "icmp", IPPROTO_ICMP },
>         { "icmpv6", IPPROTO_ICMPV6 },
>         { "sctp", IPPROTO_SCTP },
> +#ifndef IPPROTO_SMC
> +#define IPPROTO_SMC 256
> +#endif
> +       { "smc", IPPROTO_SMC },
>  #ifndef CAN_RAW
>  #define CAN_RAW 1
>  #endif
> diff --git a/tests/extended_socket_class/test b/tests/extended_socket_class/test
> index 86c706b..ce02f00 100755
> --- a/tests/extended_socket_class/test
> +++ b/tests/extended_socket_class/test
> @@ -6,6 +6,7 @@ BEGIN {
>      $test_count     = 6;
>      $test_bluetooth = 0;
>      $test_sctp      = 0;
> +    $test_smc       = 0;
>
>      # check if SCTP is enabled
>      if ( system("modprobe sctp 2>/dev/null && checksctp 2>/dev/null") eq 0 ) {
> @@ -19,6 +20,12 @@ BEGIN {
>          $test_bluetooth = 1;
>      }
>
> +    # check if SMC is supported
> +    if ( system("modprobe smc 2>/dev/null") eq 0 ) {
> +        $test_count += 4;
> +        $test_smc = 1;
> +    }
> +
>      plan tests => $test_count;
>  }
>
> @@ -131,3 +138,30 @@ $result = system(
>  "runcon -t test_no_alg_socket_t -- $basedir/sockcreate alg seqpacket default 2>&1"
>  );
>  ok($result);
> +
> +if ($test_smc) {
> +
> +    # Verify that test_smc_socket_t can create a SMC socket (AF_SMC).
> +    $result = system(
> +"runcon -t test_smc_socket_t -- $basedir/sockcreate smc stream default 2>&1"
> +    );
> +    ok( $result, 0 );
> +
> +    # Verify that test_smc_socket_t can create a SMC socket (IPPROTO_SMC).
> +    $result = system(
> +"runcon -t test_smc_socket_t -- $basedir/sockcreate inet stream smc 2>&1"
> +    );
> +    ok( $result, 0 );
> +
> +    # Verify that test_no_smc_socket_t cannot create a SMC socket (AF_SMC).
> +    $result = system(
> +"runcon -t test_no_smc_socket_t -- $basedir/sockcreate smc stream default 2>&1"
> +    );
> +    ok($result);
> +
> +    # Verify that test_no_smc_socket_t cannot create a SMC socket (IPPROTO_SMC).
> +    $result = system(
> +"runcon -t test_no_smc_socket_t -- $basedir/sockcreate inet stream smc 2>&1"
> +    );
> +    ok($result);
> +}
> --
> 2.40.1
>
