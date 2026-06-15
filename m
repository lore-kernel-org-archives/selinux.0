Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA134DB56
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543058; cv=pass; b=fMp3qOBVfzygJwsuJ8rJjGbSsSQT/QYt90ENQ0d/BOY20I1DPNTUJoql2zkgPtyKFqFwBT+6+romSaD6op7XqcUrPRkXWh2xY3yZdQHSBJeOogoJM8VK/o0oWkcNpgpX619uhD2Pvno2DtdvfUp0WWJRgWjFHx5r7dqhb0akOfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543058; c=relaxed/simple;
	bh=fFaO2uh6CXkQI1VrTvhXPmchmmMRbYorT94kDRX9GGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSn4kHH5jGCYvyFflEa6tfYJGqJYEH+d4KDLi7yAdyHm8a2ze1twQ8sjbkZn3f6p79HlIbroC89JzJ3kF/wjkqldQE8L/WYQ+lprKUAxVBip9UDqHFh0hjSosXD7e+/o0gBVxNQ9vjhHfpfdQtKENbzeKcvVdCFZvrmm7F6iIes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Muk+MLia; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Muk+MLia"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso22485595ad.0
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 10:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781543057; cv=none;
        d=google.com; s=arc-20240605;
        b=IBoCsyESvlDot3hLhgShhdg9ig9NpyH/jvXA3S0ZyZGikTQIQIw7bYd8ezwM6pyeL3
         o2w1Kzl4ECm1E1sy0CPj4cLqJ2MLGEtpt2K+UIA5dVjYzLmgoIoYELvVAlpRBAex5BZ7
         zvqL+IlaGpAdrYkn3+W/21DyszZ5TwpchuF/nHFVpNxOCDKELB/Py/GO21zpCoPM8CWM
         cqF7EsGei9M8pJ6SmYpGxRJvSQESOyFFlJX55HxnIiZcAwjHWWd3Sk5Oh4w3Ms7ZFpdg
         bD68IuDPo76zxfUQd7cDX7pAYnh02NVWQJ6I1qUi05PwUIoodPCopApjbqNfT1hK0bMd
         rBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9LYMheeKt+/w4002R3970waRnpm9AvQ2BvoEpjhAxIo=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=kWh5SlHeceRM5i0PGriE8Wz+UCveNnX6qil+yfvxNGIsf05zapkguiJfTxCOcEiTED
         2pp/4WPuFe7CZHjl5aD+RKHoJ0zeA8uGqQRFvSJFS1dkAQOFy/vHJinzhkAvz6SeuBFv
         evQYQa7Zg2WvPvs0dTEE7pxcEM84VwdVgolwr+YrWEdjB/SSt8YMi84RzYGqaGktj75p
         5eVD39qWPtleYZaLfV5otxDaN09ytAULC2nMSHTfCGMu+kOjAJXJNfQ4dW3RTCzPD6WC
         7R+L/Yo3mGlcykOUmOmQ00ZO4OmcmjvlWqlS9r0XQLM7AwKWoZuX0s0GTu1dLPty8Xx5
         bvPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781543057; x=1782147857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LYMheeKt+/w4002R3970waRnpm9AvQ2BvoEpjhAxIo=;
        b=Muk+MLiafvnqSNdh6C5DIIRWm4FAafBfbKPMYh0jS6r7StQH95tDEMQZ8ytV2UOJom
         aQNcyXafC7VUwL3cJonQjSyof/Epyi7UY4LKsmkWkigDH2WlIF2houUiIodw3EtDPRox
         HYupt/GncTxReqHPXAELy2Nd29Jc8Fx+E3GV4/3lgI9Z0KbSJ08j27r4a8OneaN/CzD1
         q0hdYuPl2WWmZCJB7z/9PC939NXSo1ePe8NwnLbsk/UJWBhdWWb8qJP1cC9U/wFHjS9Q
         jQBeYukbk4Qug8qD+QH3WY2gDpnDrYk0KqdXyUpyiuPTE5hxinVX9ZHrpdqRxuIZDT2T
         QndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543057; x=1782147857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9LYMheeKt+/w4002R3970waRnpm9AvQ2BvoEpjhAxIo=;
        b=rDJHCyzuAzJwXAVNpC9wd/GOozYw2i1Zhj7Wnk+ESe7Re9dJembosKl7svqN7vkivB
         b37jQLr9HoKB+G6zsdjauBl9AQT/w+jeXejFT8MJ3ERZIq3fgHX5qP19Di2NVO7SPWcm
         awjKOH+iwY6vkhkZMNHBIAhbLB9Dk+hKfzcvF9avcPt6tfI+YbtN0HjzE26re8ErtxtL
         wF2GNTzGEeZfc1uNR1Vzom0gKpiYrYJCP9YNV7/6NhNzs7nG1m0QhKjK/DsvplQLk8xt
         dhfV5QDyW4L3ksDbZbk/0H/IzYdXraZJTVp4001VPY5HxTV+4srlD7WPhAKOSFjGrq9T
         wu/A==
X-Gm-Message-State: AOJu0Yyz7J7KAF9KnSRhX8A3qpthk/f+wzFm1Cwm2z8wuk4mkZYTSP32
	fxuuUAXlNbXxHFbgLUpqY4am8YhM8pVxjWAZ1CZfAbt2DdUxT94S3n8MJYJ3zHlS45C9lJmcxZ8
	QuEu0CYpRsaEdY6853l4DHQO+A5KkKwmhkWmn
X-Gm-Gg: Acq92OFqsPcXr0uID/U45beULQY/fSDv4jOB6vnOhJIIcSvxjqnSvD/4Bwq8khabB4R
	P2KG2940PlCULaQ8wyIMfT2kCecWf0aw62+CEl0vnWiN6nYaz/m0zdeztwY20vQqwxkwjzhz6DO
	+5bv/R5C9JA7DAE4pXM+yVDJb8MI1qsQ8Y9i/YZ6/q4A+RjVTJi0MyGQ6EVaeb4kw+WDBosNG4v
	S5Ziitif8fsSWxKhz/KQNQzgkuvRWIuLPooJvLu44mHRH4PmV8+cpAAcEIM1cAP5h4PJhYLu+H5
	EbKUNCA=
X-Received: by 2002:a17:902:da82:b0:2bf:dd8b:7cd with SMTP id
 d9443c01a7336-2c4110b3772mr173106305ad.10.1781543056899; Mon, 15 Jun 2026
 10:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615163937.38919-1-kalevi@kolttonen.fi>
In-Reply-To: <20260615163937.38919-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 13:04:04 -0400
X-Gm-Features: AVVi8CdtWhRrEXVWKWLzFFpJhqOMAtgMmz2-5jsJ5VsJvFYJZwfGeqtJfUXR1ek
Message-ID: <CAEjxPJ6L3ip0q3ivXxEzbaDhPWFhcwMhYhUiHs_jJS=OpGgHvg@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: use sig_atomic_t and bool instead of int
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:42=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
>
> Use sig_atomic_t to be async signal safe. Use bool instead
> of int to make boolean intent clearer.
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  mcstrans/src/mcstransd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
> index 2d07b3af..5bdaadb7 100644
> --- a/mcstrans/src/mcstransd.c
> +++ b/mcstrans/src/mcstransd.c
> @@ -2,6 +2,7 @@
>  #include <errno.h>
>  #include <poll.h>
>  #include <signal.h>
> +#include <stdbool.h>
>  #include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -56,7 +57,7 @@
>
>  static int sockfd =3D -1; /* socket we are listening on */
>
> -static volatile int restart_daemon =3D 0;
> +static volatile sig_atomic_t restart_daemon =3D false;
>  static void cleanup_exit(int ret) __attribute__((noreturn));
>  static void cleanup_exit(int ret)
>  {
> @@ -421,7 +422,7 @@ static void process_connections(void)
>                                 syslog(LOG_ERR,
>                                        "No color information will be avai=
lable");
>                         }
> -                       restart_daemon =3D 0;
> +                       restart_daemon =3D false;
>                 }
>
>                 ret =3D poll(ufds, nfds, -1);
> @@ -450,7 +451,7 @@ static void sigterm_handler(int UNUSED(sig))
>
>  static void sighup_handler(int UNUSED(sig))
>  {
> -       restart_daemon =3D 1;
> +       restart_daemon =3D true;
>  }
>
>  static void initialize(void)
> @@ -551,11 +552,11 @@ static void usage(char *program)
>  int main(int argc, char *argv[])
>  {
>         int opt;
> -       int do_fork =3D 1;
> +       bool do_fork =3D true;
>         while ((opt =3D getopt(argc, argv, "hf")) > 0) {
>                 switch (opt) {
>                 case 'f':
> -                       do_fork =3D 0;
> +                       do_fork =3D false;
>                         break;
>                 case 'h':
>                         usage(argv[0]);
> --
> 2.54.0
>
>
