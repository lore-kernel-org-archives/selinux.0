Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793625278;
	b=wFPclzFOtwlTw2Vn5GFeskqJc+xKSBf0nsDYJ1bi34TgVVqYBj3aqnLe0VdjDCHcD+Cb
	 qLDjtIN8j+riUQLAAcycVDSKQzsYTprM4EOc3K1eo3trp3hlnbB/z/IcehtAq/OeT+Rd2
	 GLJcSuZyM6zelZwynlNf9LFWLzfwuESd4r94RLmpxtQ9KbK5LDu7mz+r7UZQX0srbMJvj
	 K6sEaMDQcHg8097lfXhP6dklOJ2i9fUOdU/AaOG5H6Rinqyc6e0wk/n7kD8Akzh1fcXA/
	 dfaTQier8T613W0b0huneYR4HilD4rGPEGpSBin75HIQi05gVxkB0Rroot1u7dq6ppw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=EIH0iKE6kfAQCSizmvu11oVjYAG0eqT/ZIDcemQVDgE=;
	b=V4l8UTvzcT900He3fV6ENK5zl+AE6cOoEZMMLG8uin1kCvf39lXsX+CYsb7Iq86/CSEY
	 fYxG72E33AoOsp+5zsfLyBZpGCzTbn9tNuFzkTiqdJPmpZAEOQ/Jt+KSI4PCc7FqHvY6d
	 Pd23Od073U3+itxqluS23+tJpPxk+1s7hvVTzXgFYWFOVYgNwV4wEXfHEddg8yvhujyT1
	 mFmmL6lihvlIm4/GVySGJq8oFg2rQHV957FyNXdWH21WV3Wd9YmLXQ+k+O/gLvN0frqvL
	 7QSLJ+uhXh+zZo1lNKRpdsmY+qCL7IxOzyGSBFxWw7zCZBZApFmkuMtEtQWLIE3nC6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I1g5Eocq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8528C60A2604
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 13:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8528C60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I1g5Eocq
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b1ce85287aso866424c88.0
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 05:14:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793625278; cv=none;
        d=google.com; s=arc-20260327;
        b=TVhnaFC+f6V8i9J+n92widoSZTyfARL2XkhKKEYq35ixcipIVJQQ58lmQAOAsr/Drw
         AIv+HZeZGlV+TEosz5+7P8hU3qQMYcskFZkVMPQ78vlnAsWjy/zuirLrgRcUvZF5iOTU
         CfRRvV8jX5vdDVC7eUDY40g5ulkavqKYvABw/XfEFz4ulaB+mNxRZLM4vSO3sG0UdemD
         vWLkjygr2TNQAWRr0iewLJ4ZQ6Vik8NkY7mwj8BBuW5zEiAcAMA4+kamaiMTC6FSeQm+
         8mOshaXUtDr95x1OWMiUrCRS5HZ1k4ablTjXaC9U2m2J0R8wKZPWDjW/1Tr0Ak4B1JN2
         le1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EIH0iKE6kfAQCSizmvu11oVjYAG0eqT/ZIDcemQVDgE=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=s7lJpmrYRnqdXLDSoAFA6vBHu/jbSA7W4KJhRTHHBCnSDHZNUhLpJSEV6GGgg/S4rD
         j56b2xQzDRM0ZdJS8AGTvw87u5KGjIv0DM2u36f7wE9QAgo2DNoh5+S190qKb1TgRWYK
         Htnn0mT8zmFw9oP8it99MyPpUjn/iJ4E0tk1uaL9QR8JEcKgcijj221E7/LVWb6SRMSX
         lOJN3gjXbGnurhv57x6G4+D5v3AyaUWzFXKwaICk61N+qCK+bIZ+JIJUYvyKITzkiZlc
         Y3b6AoY2v85R4pVdh37a+i/s97WgbLOT1IeJS+hIdWWuIKzq3f+ZoiWBIOOtUZWnXzib
         XXiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793625278; x=1794230078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EIH0iKE6kfAQCSizmvu11oVjYAG0eqT/ZIDcemQVDgE=;
        b=I1g5Eocq94/QJQ1ZGltnvRw6jmC7iyUS+SVnKTeDBXWypRf+ET2wP52NdwOp78LLkL
         /IkRaNYH43NRuYS7O6N9Hs5PJHKjrjrnjOZzRRMvoXhEdn+1bZuwrXybFtr+68EFlpm9
         7oPQTi8pi6LD1mQbtJkd5eZ7VCeZ7iGhkbM29qnybCCCpt3EgEpIS6//lw9u1GlwD/NV
         UJEgwfpL5c05054UPQgzAcumgIHLkeRMBWiSnkACeJI2MTWifnE4OoINFqsPICFyg/jB
         5kcNWjo8uElTGMP8y+AhOh6tj59qNYCLYNdlfO/5k5YcoEIqZ+I/PcpfTewKFnZ8jxdk
         9QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625278; x=1794230078;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EIH0iKE6kfAQCSizmvu11oVjYAG0eqT/ZIDcemQVDgE=;
        b=OzIf6/ypoS5iC9VxWJKj7X/fWkYOo40ItZ7SKoknyGKBPnTxpEHWAirwPItQv+z2KZ
         ySul8EltY3A4wpv+joI5NyEO7iHGBHyP61jgfNJ6VIARcqfAGa2oLxdMOVkNU3POVzaS
         v8yvtsMGvoG2Q/E8vOYavlMF1HNaruRXFt4xOlPGkzLISamlIxR9dRnZcrD8gNB2UTfr
         lInrrTNlgguxQXlUJ1ZXvwdobAMBXhhk5zq+sqmKp19O5xXN14t5uhIG23uFmoVoSGUu
         szb505qEmteN2UOhRkFLin5RAT8hHZHUogEhy3C6pjKt52TyP+pUHMGeovI59bKDWd55
         5zHQ==
X-Gm-Message-State: AFq9FYJLJ9PVYXjpK2Z8Amfz4e+23QA1onHzsnlgPcYiWFf0fnJYo98w
	AQ6CshDeu2cFbcedjNY4Y+ZCnyrvJieq/MxpwCK2DkSflusAmQGAGaazl+I8X6XkCqblmj06VOq
	YF8OJj93Tb9f5bful16eXUymqgyuYbSYVeM0//4c=
X-Gm-Gg: AYBFou1nFdKIz2w6jOqfYC1wSUuOOTc6DaQUhwpvmLzpQlNEwHJ2V4IHezhsbjEDPN6
	o8zZ8P/BXYVerO+kH+cXu2IfC0IDqdZNt7Uz0yklh7tBcecKUPztT4fNqCnPpaYxas+OK3Vx2Lx
	jwT9ixmKBJtWNcx2GBLMYyjK2ByKoafFEpkWpItCSF6PfiylKcxcrmbZVwHTOVti87vWqzzj/Hv
	HXUGeLQSluXMQMB6C85BGA2Wy4AntvMTY9zYQR9s+qIt4jlwG+BFOjCAT0lO98QyiqnbfDLXSpI
	byitU4pIt/cNnc2/rcWVIAqWLW035cWYD1wfM2serRTOmcumeqLWKxdw+tNfCDweG/NIOrGXphV
	XumUkXJngGJBCItv6aaDPI0VR5b1MfHnOwOkm3tz9lfeB6reQqpmnva3OQFHUt4Sxbs3e
X-Received: by 2002:a05:7022:2522:b0:185:b157:f271 with SMTP id
 a92af1059eb24-1ac5d2c58cfmr20369863c88.23.1793625277588; Mon, 02 Nov 2026
 05:14:37 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130834.253605-1-omosnacek@gmail.com>
In-Reply-To: <20261102130834.253605-1-omosnacek@gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Mon, 2 Nov 2026 14:14:25 +0100
X-Gm-Features: AclHuK94amz2PrwbSDk77D5LKPlyZSkODpV9ZpyqXSjzKPyeob0X8Kl7mvwOcVc
Message-ID: <CAAUqJDtEZ+FTxDjiEBYkWvLb8rD-uUM9C5xH+NnaXSD=XJfVWw@mail.gmail.com>
Subject: Re: [RFC PATCH testsuite v2] tests/unix_socket: add test for MSG_CMSG_SEALED
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Nov 2026 at 14:08, Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com=
> wrote:
>
> Test the new MSG_CMSG_SEALED flag for UNIX sockets. This flag allows
> forwarding file descriptors via SCM_RIGHTS without having read/write
> access to the file handle being transported. The file descriptor
> received with this flag is an opaque anon inode that doesn't allow
> accessing the original file handle - it can only be passed further
> via SCM_RIGHTS again and then received normally by the destination
> process. The LSM checks for a received "sealed" file are skipped and
> only performed when the file is eventually received "unsealed".
>
> The test verifies that a domain using this mechanism to forward a file
> handle doesn't need to have access to the file to do so and that the
> final recipient does.
>
> The test is automatically skipped when the kernel doesn't support this
> feature, which is determined using the SO_RIGHTS_SEALED_SUPPORTED socket
> option on a dummy UNIX socket.
>
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> ---
>
> v2: drop unintended debug patch
>
>  policy/test_unix_socket.te          |  50 +++++++++
>  tests/unix_socket/.gitignore        |   4 +
>  tests/unix_socket/Makefile          |   2 +-
>  tests/unix_socket/fd_forwarder.c    | 158 ++++++++++++++++++++++++++++
>  tests/unix_socket/fd_receiver.c     |  98 +++++++++++++++++
>  tests/unix_socket/fd_sealed_check.c |  26 +++++
>  tests/unix_socket/fd_sender.c       |  88 ++++++++++++++++
>  tests/unix_socket/test              |  83 +++++++++++++--
>  8 files changed, 500 insertions(+), 9 deletions(-)
>  create mode 100644 tests/unix_socket/fd_forwarder.c
>  create mode 100644 tests/unix_socket/fd_receiver.c
>  create mode 100644 tests/unix_socket/fd_sealed_check.c
>  create mode 100644 tests/unix_socket/fd_sender.c

The corresponding kernel patch can be found here:
https://lore.kernel.org/selinux/20261102130540.252894-1-omosnacek@gmail.com=
/
