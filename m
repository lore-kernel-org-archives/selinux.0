Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5F4D17A5
	for <selinux@vger.kernel.org>; Thu,  8 Oct 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471535; cv=pass; b=sYzSco2gvlnbi4a7R3jH1l0WojtxYSXHEWjImopE4Qydy/jJqLrymeB3ip8a+a8PK4aouj3cC8Q69Bm/8RL64dIlopD/wMgRzM4buWl5KsCDIVEQ2mMi8erXXysz8KL5JIc5y4UCB7n+qAnmmU/RsDzQWTlPQF8wn5n6N2hXtJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471535; c=relaxed/simple;
	bh=+llYzy/PHUr3EhwJ6BCjnIAG9mZ8cZDRpFgVaQn6LPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8mTi6df9CnRw+6/UuBU6TfbNnD2L5owu3RkKalFwyBOEvVPfJnYw92AJuzefQNehm6eNH5ImWX9jkPF+WhSyYzgv+XZuIE9Q/8buqSnK4K2Iw9BYfvUjsQSONVbccyi1X6R4fbyb+F1frGiSxgKlrMN7tt/C0D9uKPE4l827pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1d0gXsR; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1d0gXsR"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67699afea08so3308573d50.3
        for <selinux@vger.kernel.org>; Thu, 08 Oct 2026 07:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791471522; cv=none;
        d=google.com; s=arc-20260327;
        b=dRCkNfy570ZDc5XJQk+2wR7jZfGNXO6xa230Ls2FLZZWWQF6gWU4B1WuCrkGliw7Nw
         bntwYhWYBNJ+foglLd3caPuCUs3N5XT/+uHb487r5UMZPxSnaIvGLYLYq+PpGHFkJSxy
         iuOC8y50ruIq24SHswUr7H6xneqn5f4VNYm+E4sVc+n4TtRMJu53taZm+ofE3xb0MDUK
         eJU0t4xKI4jpxJw0XOE1Lwq5OF2+V2NtoqJxwjRfq4KCBdKQInyFZ3KgcUvzxD5FDn7v
         8B1m8J9YJ9kRLBm9HlHD2fpJLD0FLApiikXseRx4U1vY9sD7271LKlOxBcRKHirNayVI
         vhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mSpowJSpZlfyKE3Lid+bo8aXuWnr9jv1T2Uq9yAdJ4o=;
        fh=0lV2+1N9LYX6/0U2UvxMCkn2c0ttJ1RBNIVPFMYdkF4=;
        b=Cf6uiifjbXsC+ezwHuMZaVbj8y3oGW05OyE/c7sdkmNg3vgdzfCn5pp31uD8i2mLfo
         eaulm5RLaXA+t0LahUcFpNgA2b1gZXEh+GUrA6I8ZPMuASX2Yb+m+td/7bmEwnVuV7As
         c3DZJdJwqzm5F67zP8Io7YzDY8VfBxgaFqy4wOUsouoHQGHHMk+v8P9NHkOheeuRmy01
         ugHhQWqcxyzD3Hxk3xju/u6pz/4pxJpEiN+t4fjTTkObDBgDnDAAyJ8hAOpQoHRNLYV4
         QLpNvf+C9IKmh1P0Fmc8crcrdy4imwSWRKOSeYC1zKdKkX769ovHGc9Fm8tkcaGuGTQj
         /hHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791471522; x=1792076322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mSpowJSpZlfyKE3Lid+bo8aXuWnr9jv1T2Uq9yAdJ4o=;
        b=P1d0gXsRRkxzWZvSElrTnp1bj2Dwg5wFhfSfNq34qklHwRPUKqZCI21be5C/lKA1cV
         XT7NBgij3O3Mm17ntoRR/iih8vhWZ0x8bqRKrmaCnPbpi59qzRF2z2e8/6Cfq/qnHzrn
         hiKTRGbqCX7R66PayyGfvwz0CvtPcWidLJKggCX0xTxSJyOWdXwZCderd51mFlLSAJ11
         vLtZvXAFgibz6eKIljZfvxFyAByOubG09oU3mGmvSMAnuzsl3Zmk0jukAmrAQBfLuYfS
         4T1WHyQeBCQs6qfY019YpD3+BVnVNtjW8WSibMHu/St7PNdXwXBTh/OEY4HDSFBBt7nK
         SdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471522; x=1792076322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSpowJSpZlfyKE3Lid+bo8aXuWnr9jv1T2Uq9yAdJ4o=;
        b=VTHkW+j3W47oEsFUpDl9GKW367MPKRQDyPD1DChgx/+v+bUjcP855zxKlRJVLI8pRd
         Q8tRH5Ok50EW6PrX3iF09pzslCiV7kSPHPs5dzo6An4WUT93QBFzD/P+3dAit3ZZrUPd
         Q3DvJruA6lUKvpdo6gblkC2JijLcTFWOzaBRORYT4D7VYM4QjF9h/f6DAaULwKmr6IuK
         oMTmyWZJAuRDrdW+pVDTQQb7/d0Ckx/B/hs9XATiGUwkzWwxzAHdH9nhVdspffBhdcYI
         WRGxqWuQ8TBder6uivYa23sgxtAd4mw8GCCpv9qMvUX/m2gPjDQTc240kCJ8KqIJccam
         naig==
X-Gm-Message-State: AFq9FYLZ+V1ehQKdjz71STTqaIZtVN8guKv0I+3jbMdXqoxz0xVLvAn6
	84YmeLsOXNau4AgmlKxfVzm1LjJpAX9lan0BbfVYYOuoFiz0/Mqd1yRJxGNpKt0izpruPGgDCWX
	A7rRSlFYJLWnLTvF9WJprJcKSLBbXcxc=
X-Gm-Gg: AYBFou16HDzy4+MyiIlMCGfBnLYTtoyoK+w0DJ6j3kxyInjLBfTvjoK39oluOMm9pml
	slXgiQclq+/Gw72h7YbLNH6LI2oVKOjqnnNzYIcxXjetALmf+sVqOKrcpmcPmxz2lcmMzsv5uYx
	Od9gewjiMC8BQ9kYmTKdntruVK0UiebrCPapumQljRtjt3Ov6IlbuQNdg7K8lmEIAGQjf972fKM
	dGeFVk/hR/8Qm0yo2jgP9PSgRsZddD7WNSiBiSYO/BcQtKjtS3fr94sefYL2vsB8INdlWDmYJAm
	PcCdX6je+bPXNFVtKtjQr0bSRKZXHadzQBbedngqmLEyw8r3FXSXIjw=
X-Received: by 2002:a53:acc4:0:10b0:66f:a8e8:7140 with SMTP id
 956f58d0204a3-6790a0b324bmr2095649d50.5.1791471521995; Thu, 08 Oct 2026
 07:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008072710.41831-1-esgor@altlinux.org>
In-Reply-To: <20261008072710.41831-1-esgor@altlinux.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 8 Oct 2026 10:58:31 -0400
X-Gm-Features: AclHuK-5_gqzTtp-Ib2GTmhl9qdKovXGF5fxlNdrOU7YYikTQckASuJemsHFcEA
Message-ID: <CAEjxPJ4Uh+_GsevF3xtxeKPkz=KAgwj-=+JNq3Uc7SWrLDq04Q@mail.gmail.com>
Subject: Re: [PATCH] libselinux: avcstat: reject out-of-range interval values
To: Evgeniy Gorbanyov <esgor@altlinux.org>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:33=E2=80=AFAM Evgeniy Gorbanyov <esgor@altlinux.or=
g> wrote:
>
> strtoul() returns unsigned long, but avcstat stored the result in a
> signed int and passed it to sleep(). A value above INT_MAX becomes
> negative, and sleep() then treats it as a large unsigned duration.
> Compare the full strtoul() result with INT_MAX before narrowing it.
>
> Signed-off-by: Evgeniy Gorbanyov <esgor@altlinux.org>
> ---
>  libselinux/utils/avcstat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/utils/avcstat.c b/libselinux/utils/avcstat.c
> index 640a7a05..0c534f51 100644
> --- a/libselinux/utils/avcstat.c
> +++ b/libselinux/utils/avcstat.c
> @@ -13,6 +13,7 @@
>  #include <libgen.h>
>  #include <stdarg.h>
>  #include <errno.h>
> +#include <limits.h>
>  #include <string.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> @@ -122,9 +123,9 @@ int main(int argc, char **argv)
>
>         if (optind < argc) {
>                 char *arg =3D argv[optind];
> -               unsigned int n =3D strtoul(arg, NULL, 10);
> +               unsigned long n =3D strtoul(arg, NULL, 10);
>
> -               if (errno =3D=3D ERANGE) {
> +               if (errno =3D=3D ERANGE || n > INT_MAX) {

Since you are touching this: errno is checked for ERANGE but never
cleared before the strtoul() call so a stale ERANGE from earlier would
reject a valid interval. Pre-existing and probably not reachable with
the current call sequence, but addin errno =3D 0; before strtoul() would
make the check future-proof. Up to you whether you fold it in and or
leave it for a follow-up.

Otherwise,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

>                         usage();
>                         die("invalid interval \'%s\'", arg);
>                 }
> --
> 2.50.1
>
>
