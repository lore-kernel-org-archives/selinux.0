Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF192D8DC4
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638230; cv=pass; b=gZrJMkDE5GyAgEPGLIeByeyY5H3jt5RubNqz5e+l96m+Z1iaVNUMX7EdQ0/uejTJLxTXMFCg2E0WfLO9ytazb3FFobDOqRjOoG5kVjWJ95dNFG3c4t1YNG4FHahW6SGZ2UHOdW3wb6eKGtSG3uZfzMbPeVdsSLwcAdKeimtey1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638230; c=relaxed/simple;
	bh=ZXpuz/15pdhvDiuvfK4I1Ju17a8JkYD4MypaeIAM+1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqjLaL1DEy0+2yXgh9DmtK21M3mOTtxpecMU9Iqx6KAjQtpDPZl04cnUHQkXuEi7cz1J+i2alfSMA9+c9ahnmfr9337OYJVITqX32nBVJBo8BbcHYKkGCE76GWpFX4s3PdgMVJdyzSDNyG/vAf5eRiBzGcc932tzkAP6vjjGX6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJzKwy9r; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJzKwy9r"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381b831d535so9256622a91.0
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638228; cv=none;
        d=google.com; s=arc-20260327;
        b=Mz8iQFPJZ825B7xj9CSW2VUBVWRb7teSgDlgSCj3CsGlb9TiJnca9WVGPsC7rxNl5O
         3zrzhCYR0ws120NQWa0g6CE+1DG5donI97KAOXUHtC/uHNDN+DKA+RBH6gvTV9gqlxMb
         yuTyeYbuIfM5NilCivBXwNhupCuM9m0KbFonYLcNdtNo8//Z7Yq0ig0Qk6RFMowUsWGD
         7b47gGK8B1+/ii2idnlCSZhGFWYbeKMr6eLuNjCXEBBcov/xTBJR5V1zreM3Q6UGGIUV
         iKkUY+VMulumU1+i4TCW3lgSFj7w/XAmz0bj+G6/UcngIAylhb4L2WMk8VlNtMNWvwgH
         RkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ylb+Qya+PPHEgD0mtrdNPI5jEbXklFQ2fyUPAt/qSM8=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=r1g9Nz7CWXNDTjlp8v5EPeTpVif0f6YEWMVY9wlF+kJ1gVMeg1bLBpmM/NcvTFzVKw
         ajN7lHMS0EqcRP5CVhDqOLLgT79O2kOHFq6tI5QX1mj+gBcueSLLTBRPrEv0FcywhwKc
         n6y4iN8RSL8yDwg1LEGMA9V3rjeefJvZ9xPEeSMV9z4rPWk1eiOck/CZu7WJQP0xwGsk
         53FSfXnjTaRr570Rvc09KjA6ivcHm1UbQySfiveen8JTpn1VoVxCU6nHyPyLcwcS133d
         juc2CfqIJH026yms2/5228VpDoduFhwJgWCro19LET3cmcReIK7JkO9YMTVlOHyfVnEY
         KHYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638228; x=1785243028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ylb+Qya+PPHEgD0mtrdNPI5jEbXklFQ2fyUPAt/qSM8=;
        b=TJzKwy9rLPDgWRVwR4mITxcyuU9yb3Di1M4cvvxVM51Vm+v5BQZtSXDlFtK+R4GARy
         nen8WKUEzI0m+dxwtjkOtkFG08fQ/28DKaQlvqP01MJCGmoHpoupc6xNmQrvGJww4EPd
         DGSPNMH1YdDfqQykYmeTzjYusWgK1eu/dz8P3vfWwgZ/MNzOwuCu0RqyHjVFXch0qU+9
         Hls81z8kNDMHZmBBXUxPpbSEo2VfeU4q+QnFGZBFJLeml5OnvCYIcjJSIKeaS5UccIix
         bPekEVdwdeVSI1jwmlX5S2chM+Fb4uyZIEZ+1IvI0PsoCE+Ie88ALJD36vZLRXGrXVCd
         GQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638228; x=1785243028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ylb+Qya+PPHEgD0mtrdNPI5jEbXklFQ2fyUPAt/qSM8=;
        b=I/9nTeAvJ+SwHdH6kJxqNJ7jRzZdxvj56rYJMAuw5jQ81cBdWjvvtJ3LNBPFygOsra
         7pFyRg144b/QE840UJV08z70brnL14hr9R2Lfo9lVj5dS5xERp6fd18TYv4pxLiEud7M
         viS/vjgNeDAwHcEZyK6Ej9crrYsNkufCX9uQJ8YTJcnZPB0snKpo1Rbo/KlbOR4n7zyA
         jWoyfAG3bzIUEHYmhEFPncsFx6C5w3ruL9gjZkQz0MAjcqS6jdgfebaRIhf4ZK1TAf6V
         om0Au5+AwlPDbEGMFD2z+NGe6NcA5+m/jjzrWXbN+x98mmOxhAXKOw+15XddZzJ+zJaH
         lWLg==
X-Gm-Message-State: AOJu0YwXJhr2cR4bSNF+xCBJZyhWbi3n8IZuQOqL4m8jiIqX0GLZ2U38
	/XKD/2j1+fz9GyDJxSanhGYEHaDi+iX9Nt3eWFARUeBN1j5yZCbvBvuhdUb5JZSlbsAhbcKRmMz
	9b4SEGa+cA03T5rMqLdeqpHhAsqGODTKD4Q==
X-Gm-Gg: AR+sD126PjCxhOrptXrTnqpQ4Lg9MnTqS/euJZQHAidCEKyXh/JRM7PF6JEU2UZHC4a
	KdqJuXjbb9qrNU4AwzQqKoM+dF6gpL/ZmjnSj4BbbOW54rgo/ncn8ktMid/whore3p7GEbkgnmw
	rDY5xUNl9pu/EqeDzORuSabXH06OuWDpnmuwxJWrOpGXQATxFfVYUL4qnuwRKRu+fPN61lS+r/9
	husF4f8gJjjuA1AflAtaaufF4f938s9nd2RO7cv37DJUYgnm1D3Qws/jApRqA==
X-Received: by 2002:a17:903:2287:b0:2ca:b8fd:1a8f with SMTP id
 d9443c01a7336-2cf349c2497mr199338295ad.39.1784638228569; Tue, 21 Jul 2026
 05:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716144239.8681-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260716144239.8681-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:50:17 -0400
X-Gm-Features: AUfX_myUPDSo1vgsaOSDRg4b46Z00j-N8lebM1NstyvHPxsPXCb___w7IqSChBY
Message-ID: <CAEjxPJ6s47_951mtwj=EbjiAWa=6AOizEVm4rvodX8FxigWgZg@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/hll/pp: use argv[optind] appropriately
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 10:42=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The input and output filenames are read from argv[1] and argv[2]
> regardless of what getopt consumed so "pp -- foo.pp" tries to open
> "--". Use optind.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  policycoreutils/hll/pp/pp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
> index 7280a70b..08d2c56d 100644
> --- a/policycoreutils/hll/pp/pp.c
> +++ b/policycoreutils/hll/pp/pp.c
> @@ -90,8 +90,8 @@ int main(int argc, char **argv)
>                 }
>         }
>
> -       if (argc >=3D optind + 1 && strcmp(argv[1], "-") !=3D 0) {
> -               ifile =3D argv[1];
> +       if (argc >=3D optind + 1 && strcmp(argv[optind], "-") !=3D 0) {
> +               ifile =3D argv[optind];
>                 in =3D fopen(ifile, "rb");
>                 if (in =3D=3D NULL) {
>                         log_err("Failed to open %s: %s", ifile,
> @@ -104,8 +104,8 @@ int main(int argc, char **argv)
>                 in =3D stdin;
>         }
>
> -       if (argc >=3D optind + 2 && strcmp(argv[2], "-") !=3D 0) {
> -               ofile =3D argv[2];
> +       if (argc >=3D optind + 2 && strcmp(argv[optind + 1], "-") !=3D 0)=
 {
> +               ofile =3D argv[optind + 1];
>                 out =3D fopen(ofile, "w");
>                 if (out =3D=3D NULL) {
>                         log_err("Failed to open %s: %s", ofile,
> --
> 2.55.0
>
