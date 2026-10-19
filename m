Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429891;
	b=TJIRQYylYNrtZD2Long2lxli6Ul8pZCYt6x0UAixz0aU/f6XsyWrXRpoUnm2fKKYm2FN
	 ZTi3uwXVfk/JkcMrISW/8EFT1oNnYXRbdxdCklwcjOmhzrs7/hbXLPp8yUEsgNsQvqoQ4
	 LbwXwK2wZQxTlI1FxDjMoutiVi5QdDjriz8eYDe/VeT5/4jbX6r2tayBg6P8yt7NmtA7V
	 CIMo33kWwBBf4tHTzbuvAOh80lln0mfZXgLuHz1jC5cgJmchAoMEqcGuAcqgbGK2MJA7S
	 sX1n+jaKSTdJ4BkxZ0EDDCTbrCp5pIudZro7Uh8BvWRheUWWXrA37bYLX8y3HE7KY6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9zrh4InL7B7RSTcy8AVAOowveCNTFnpyiKIQKlkuqEo=;
	b=1Thiq+vn5XdnImY6sY/q2f3DA9xJ1RW85X0Q3+RqBitGt6O6vK28eYCBWXFq/7mcjhy8
	 gEJ67jYUc31Fa0/QrdiZ0SLgLfbuwChMhZeQ6XqqNZw+PBVkRjdNmEYlN8DPuOBiN1beT
	 zR8MqMBnVBXpCh++U3uioC4kX8OyESfFG3xRkGQje8OwS9GvfjiBezYQMMvXbtZqeHSYq
	 1qy0kANYcHfoQXemb1bJERD8nXY/+ELqHnXGjibxukZqXDkEzRgKAJpgVGNrNVefyzqVB
	 fEUFVEkCA2rNzMmV8NPW7ubbp3nZ+9HC9DqXaZHEdpeVpSXGmAH6QQF1Q1FkqrzempA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="I357S5/z";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F160606A319
	for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 17:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F160606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I357S5/z
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6740e7ae219so1943294d50.1
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 10:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792429889; cv=none;
        d=google.com; s=arc-20260327;
        b=Dng9Knnzi47okkSlcsi+CEqf4LWXvnjk2QAp3Y67Q5lpM9OztPDYV7GLhLJI/azhXF
         XWRcchaXeJUVgua0PxPinpiAXefnd6fBDQQSRudvx1i7V4sFy3v+3zM4PcZDF6E0ExqJ
         0T6mJBKHOkrGn9/0dd5q7pq8c1FnWPaqqo5mUo9qX4yeSz95xaYpP49Slxc7RFBCvmlJ
         GWk3XJL4unAJIJTton0lmKUZcO87BqCxNxS3hBA3mxQ5wzOXKVXKfd+ZDHHjT5b/X1dz
         FySBTZIcjijSQXDAzVp6mkzSKF9Doa6kNEZBltKTp6r9xt0RocG1dcASU0gitWPPHMrx
         Xggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9zrh4InL7B7RSTcy8AVAOowveCNTFnpyiKIQKlkuqEo=;
        fh=TmcX6VEReUQt9WZtoJjaSyS0EG8H3Pp6isyrMyvcgDQ=;
        b=QEZ37B070PQh+nLGWAIpxnWQF6d/XuJReo0wuyzu2zXcwClV+d30o0RH05vNHKYxPO
         jVn1YBMnepe+9YNOH4t89A/gthUxjBd+l9eWTIOTkzGcUJw93k5TL39I4m2OQsxyuNn1
         +UQNViDOxUgfFJm1A4H5cGYs/4DvuA8Lc0+zEpd0/FX3RDxve95zAXdq8c+2sBShj9Z/
         qDm6LkqUXygS7/0kUt04q+oGLImzGs2dYfql4QvvDUGXYA7oGVtXtbktf2ytRLfk8rN2
         ZajjG7T5na06hSnrKLe6NO2r3Ka4Yn5fFaAa6vYFWIPEfmNncY+AAgX4wQnIh5YRIWZp
         aeVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429889; x=1793034689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9zrh4InL7B7RSTcy8AVAOowveCNTFnpyiKIQKlkuqEo=;
        b=I357S5/zFKiP9lZYGiF/OZQesoEpEFpJBMieROrQxemRlX6B1dy3CRhAz09zqTdym0
         3wDvH5BH2q8tCyO0IMHvznZ767FOD2sysYfnKkmISkNvm/Eno9vhkAGPFHEoL12rhKjY
         bPfSx/mwIbMk6y72CyuZQ1S0F3pm5RYwSlkWIpy2mQlOMIbWYRwyPc689Mk6flnX/RVf
         Q0cyibM27lIx/feqEEzZRrU+VHUnjU0uaBOid+FWFgB3bB/VGdf5F938Dr1F3jTJkc87
         z7voHZz3adI4niTPGfC+bR2kmVjg+4ap9vrq4YhG+7uHXTU4eMGGBOeVetulnUB0Ll8G
         EwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429889; x=1793034689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9zrh4InL7B7RSTcy8AVAOowveCNTFnpyiKIQKlkuqEo=;
        b=rfcbGa4s1JCFkztpt3FjVs4RI82jByKFBk+luszW7QZFadDUVEvzcUti97kwrsYYOc
         4NAncwY0Y1XTRGgGEeKZMiwMRIrvO3FprQUJ4LrXPFJiazF8YGGl23THZwrpscVgirYG
         Rn1ITLjfVK1BjHc7PvHS8iPR64pBrI3Di0REawSQ8h/P7V2ulwZ8JBac7OwCE521dZw9
         tJJgc8tSvf31E2AXLCFiTfXNDjrL2WmmjKKGCD6tZPfpZJjgxefDt4Mx8JS+scQg2kVj
         0Zv1lUqgcAeYLcoI7KiL0JR0ipk26ZNiyQuAQOo3+ef2oK2kieM7Rji8b/wRn/igH9uB
         xDtQ==
X-Gm-Message-State: AFq9FYKnA1VP+fFYmYUKDp+eRlN/6EwAumRSc0ERDBJXsrziFmeCeq/f
	xakukad2s4iGisSmze2M1OSBDigDs0TBLRPvzO1Q8Fd5qog8XP00TKKOXEVwEsqX+7d1ZBs9dAJ
	IgsaZqhoeD+WG8AmUm/yaeRhtyHrCcCQ=
X-Gm-Gg: AYBFou2vKCiHNfJLvNp+qzt0wqo6aDPtcV8ap5IrGY/UoVuPI20ykeW/wynkpH3QSWi
	1js5sKrkaDqYAAKXlCMuHYyS6J/Cdth71qRW/If1D7J3mUfMsu4cR95g/OF13wmjeXhIq+DPY6V
	jq+HBml2dXyov382hJTgvH6fLNBfdTdiYyOavQVAUH979kdnQ2ds6TxQeh73CKNSSBrQFfvohE1
	MnfO7q2WsgBSD1xzmwB6DiUfXQWVhfuCkibZbPYeE1Tfa5e5cJwy0zJGNhJJfp9BwBZo5uIE0yS
	BlDifFbUOIoVBHYwca/nKb6OdSBPDz8h29NaJkrIwz9/lKoTf/tZaDw=
X-Received: by 2002:a05:690e:bc2:b0:677:ceec:5ebc with SMTP id
 956f58d0204a3-679ca94a2e0mr1834077d50.145.1792429889427; Mon, 19 Oct 2026
 10:11:29 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018012855.1795025-1-phugen@redhat.com>
In-Reply-To: <20261018012855.1795025-1-phugen@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 19 Oct 2026 13:11:17 -0400
X-Gm-Features: AclHuK_aUtbrHnd6PqbMTwNIhJVyG4n41TkCJT-Epr5dQc-taAim60797tk1BAk
Message-ID: <CAEjxPJ7yrA2Ua-t4VaXBfxUXZzg1BijZhv=FScW+-gC=BkZ8-g@mail.gmail.com>
Subject: Re: [PATCH] tests/keys: skip KEYCTL_DH_COMPUTE when unavailable
To: Pablo Alessandro Santos Hugen <phugen@redhat.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 9:29=E2=80=AFPM Pablo Alessandro Santos Hugen
<phugen@redhat.com> wrote:
>
> Since 32f07cc40c9b ("crypto: dh - disallow plain "dh" usage in
> FIPS mode") landed in linux 5.18, plain "dh" is disallowed in
> FIPS mode per SP800-56Arev3. As noted in the commit:
>
> > This change will effectively render the
> > keyctl(KEYCTL_DH_COMPUTE) syscall unusable in FIPS mode, but
> > it has been brought up that this might even be a good thing
> > ([1])."
> >
> > [1] https://lore.kernel.org/r/20211217055227.GA20698@gondor.apana.org.a=
u
>
> keyctl(KEYCTL_DH_COMPUTE) returns ENOENT in FIPS mode.
>
> So, this patch treat ENOENT and ENOSYS as non-fatal in
> keyctl.c (because the operation is unavailable, not denied by
> policy). SELinux denials (EACCES) still exit 9. Skip
> test_key_no_read_t in FIPS mode since KEYCTL_DH_COMPUTE is
> the only operation requiring key { read }.
>
> Fixes: 2d7aad8a1f8c ("selinux-testsuite: Add keys tests")
> Signed-off-by: Pablo Alessandro Santos Hugen <phugen@redhat.com>
> ---
>  tests/keys/keyctl.c       | 15 ++++++++++-----
>  tests/keys/request_keys.c | 15 ++++++++++-----
>  tests/keys/test           | 21 +++++++++++++++------
>  3 files changed, 35 insertions(+), 16 deletions(-)
>
> diff --git a/tests/keys/keyctl.c b/tests/keys/keyctl.c
> index e13c655..261c00a 100644
> --- a/tests/keys/keyctl.c
> +++ b/tests/keys/keyctl.c
> @@ -142,12 +142,17 @@ int main(int argc, char *argv[])
>         /* Requires key { create read write } */
>         compute =3D keyctl(KEYCTL_DH_COMPUTE, &params, NULL, 0, 0);
>         if (compute < 0) {
> -               fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
> -                       strerror(errno));
> -               exit(9);
> -       }
> -       if (verbose)
> +               if (errno =3D=3D ENOENT || errno =3D=3D ENOSYS) {

KEYCTL_DH_COMPUTE never returns ENOSYS; with !CONFIG_KEY_DH_OPERATIONS
the stub in security/keys/internal.h returns -EOPNOTSUPP, and the
sys_keyctl default case is also -EOPNOTSUPP. If you want to cover
kernels built with DH support, this should be EOPNOTSUPP instead (both
files).

> diff --git a/tests/keys/request_keys.c b/tests/keys/request_keys.c
> index 43b20d9..7cf7cd0 100644
> --- a/tests/keys/request_keys.c
> +++ b/tests/keys/request_keys.c
> @@ -127,12 +127,17 @@ int main(int argc, char **argv)
>         /* Requires key { read write } */
>         compute =3D keyctl(KEYCTL_DH_COMPUTE, &params, NULL, 0, 0);
>         if (compute < 0) {
> -               fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
> -                       strerror(errno));
> -               exit(8);
> -       }
> -       if (verbose)
> +               if (errno =3D=3D ENOENT || errno =3D=3D ENOSYS) {

Same comment as above.

> diff --git a/tests/keys/test b/tests/keys/test
> index 061bc62..9e50633 100755
> --- a/tests/keys/test
> +++ b/tests/keys/test
> @@ -51,8 +54,11 @@ ok( $result >> 8 eq 6 );
>  $result =3D system "runcon -t test_key_no_view_t $basedir/keyctl $v 2>&1=
";
>  ok( $result >> 8 eq 8 );
>
> -$result =3D system "runcon -t test_key_no_read_t $basedir/keyctl $v 2>&1=
";
> -ok( $result >> 8 eq 9 );
> +SKIP: {
> +    skip( "KEYCTL_DH_COMPUTE unavailable in FIPS mode", 1 ) if $skip_dh;
> +    $result =3D system "runcon -t test_key_no_read_t $basedir/keyctl $v =
2>&1";
> +    ok( $result >> 8 eq 9 );
> +}

This SKIP block and the one below shouldn't be necessary. In
__keyctl_dh_compute() the three dh_data_from_key() calls each do
lookup_user_key(id, 0, KEY_NEED_READ) and run before
crypto_alloc_kpp("dh"). key_task_permission() for KEY_NEED_READ ends
with security_key_permission() as the final arbiter, so for
test_key_no_read_t the SELinux denial fires there, lookup_user_key()
returns -EACCES, and dh_data_from_key() squashes it to -ENOKEY. ENOKEY
isn't ENOENT or ENOSYS, so with just the C-side change the no_read_t
runs still exit 9 / 8 under FIPS exactly as they do today; the
FIPS-mode ENOENT is never reached when read is denied.

> -$result =3D system(
> -"runcon -t test_keyring_service_t $basedir/keyring_service $v test_reque=
st_keys_no_read_t $basedir/request_keys 2>&1"
> -);
> -ok( $result >> 8 eq 8 );
> +SKIP: {
> +    skip( "KEYCTL_DH_COMPUTE unavailable in FIPS mode", 1 ) if $skip_dh;
> +    $result =3D system(
> +    "runcon -t test_keyring_service_t $basedir/keyring_service $v test_r=
equest_keys_no_read_t $basedir/request_keys 2>&1"
> +    );
> +    ok( $result >> 8 eq 8 );
> +}

See above comment.
