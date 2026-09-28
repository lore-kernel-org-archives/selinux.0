Received: from mail-yx2-f32.google.com (mail-yx2-f32.google.com [74.125.224.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45367370AD4
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615859; cv=pass; b=LJin3VZIPCzUa4JczCAX8DFX9ZEmcmJUhp/WNiP8kqbJm+hZDfO6thUuncnYAlARBrwTezVgEqQfUUURasOvkjn307YA7U6KGZLWqEpBuCwmdMLolubpPJE34Rp9akksHZ86v51OFfSeNzqmqxpKuiij48DfvAtxgpiYBAmiSlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615859; c=relaxed/simple;
	bh=TAGQOPFDbrxfU8epIfeYulzaQB4TDQ5xzCvgM71GHII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkvtO6J0yPFW1aMRXZn2aC4jl7rbyDeeWaF0mGlv7ptwwuQvitlk4gYR5JMOizhl93KoE/Kgm8fypp/MRQVJ4ybTPb194o08DGqR1s5LSJqWoCK3BR0itVxGc7ngWzXSdz4dxv43WyxlYkWJEcUNjKx2afwo2dISkjiVP86rpE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTJ7akKr; arc=pass smtp.client-ip=74.125.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTJ7akKr"
Received: by mail-yx2-f32.google.com with SMTP id 00721157ae682-8aa75b33a26so13618057b3.2
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 10:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615856; cv=none;
        d=google.com; s=arc-20260327;
        b=baDBED/0cx+e6yagrWTT2daZ2jkOcVSIyUQz+Zy/F1ccgVE7TvIdEwiGf7B60ms3Sh
         cprxRC/4eUstdT0mgB2V1s/+FK5Q9dmx8+qACW1+PYqhPcS6K0GmE57c40tOGpyh6EjD
         AKyZt6j5oItTU4lQsBq2jJOlDxVxXPNtGnWKAqHmBVYeN0/6r1hmEz4J7knjkuTfCK/G
         iT57alV9qB6wlPfdnBmYf3h76TDR+8Csqk6jdAiZs6nXeQom4D1Ddf+aYCvfeq1fPdsV
         TkebMyrjAXDmNIp8Z7cuE32Yh4jOb4XM4cPeZhk8GdNtK8ujNs7HfrqGRB5wbbBnEJco
         nvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TtNp3ZAnmo1jwW6fhkVfV5KIVr7xWVDcoERvunoLqw0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=k+c9J+OYFrMYL1ji/WWf4Kb2mq8lbA4KowYMZ0UsQMCLNRZg7PYeU0irYqzhFtUR/0
         f5fmzxKhZwsHoXahU2E1z/xO2otXt4H2n2A30VTnxdsoPOhWK9wn1UVpTYeHTh+K43Jx
         0srUqAX+DcffzhQqP/Yt39LdMbMZRgZvp1k8dXR6+ulEXibrdlNrwG3o5PNps1XWW27X
         Sp7K2jAwPfjrNoHI1nZzSzjVu0yUobQn0WAzwtYavKno5EkUNGvxX1ZQuUavkdOBVxmK
         gv1gvmSitKUmmGFAAaqirdCW/sCk54FqF/+5reoNAaoOEgsnZyK9XQn1/L1Jt3Tavwk1
         IYFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790615856; x=1791220656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TtNp3ZAnmo1jwW6fhkVfV5KIVr7xWVDcoERvunoLqw0=;
        b=iTJ7akKrW5Zof2APdC5uZibixzAeBOR0k8ZovzR1j9uXLAwAJ7sBSrwNCaHDTg4elb
         FwZe7sh5jurYjwY3rJz2OVj9A0pVeZq58qZE1yg0yUMMrnlQ1B0+tO4brrZYO0+XONo5
         Q8VvgLM4nFRLzDgHkJhGnG521uGGwzGc5C/YHcNYiO9AByCY+7QJrH+/2M7uTh5/5Rj5
         k8H4jDk6znW18t/PDcfieqKBcXPEwocN7gTAED6tNyIuRQLxOLaykxoVFdiBi2JBEVFh
         0CvBTMM8652Yqfh06NCK7XyUySZQkFuENqErcKGu9cDOWrgCIVVyYxjoDy5zjG6Rck5B
         idAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615856; x=1791220656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TtNp3ZAnmo1jwW6fhkVfV5KIVr7xWVDcoERvunoLqw0=;
        b=lG7lxg0vvqaIc4ll0jubZm72H7juhN+MFC2zO3wAX2rdejjBDsrHcB4O7m2WnHlYrs
         m5CEBFY6sUOaNjMVNKZaG1IXTeTIVkE3/ItnY/yU7tbg83/iCrrgDP3TrHEZ3WbtVNEO
         7YFkcA6LtAm1xw3EaJdnhkmvGaqnCx+4/dh8Bf33QeK2B6/dZb/qyKraGEP4+zGMemEw
         0ygbzcl2uUmtWT6qOQkpNbnYFjyNkbphVyrHgmzUqNmSsFUfUm0mbfzYgmzqb5CEKDJ3
         PAfLb7L70nBf/tB/K90FVNMwQyF4W0qJqvI0dYTroipAzJxsoWJ2Q5QTnLC8Q3k4X71t
         YLtg==
X-Gm-Message-State: AFq9FYKCZaDWvYQ39eFlgNH60r3CvrdDzDqau95HsNJOY3her2UX19KT
	pezm9G1qRnZEusit6DIhbKj+kfa83fHN2qyZJUM5JWKWphqoTj3/UeG1Gm4IWHlqabxpK0xZCBm
	IiPFg0RDdEt16/INMrFAO1Ykky1D5vnU=
X-Gm-Gg: AYBFou0SpGMKDw/nsxSJWYXMkxOK5E51cTlhzP4x7rcjVcFHcUPvTwaLzJf9fAH61Xa
	76cfktQEjpp6EA4HpTJC/ENjzPiHmsGkORnaIE1xuMznjK1PQr7C2h+zqLjdFR0ijPVB/4rNRVF
	3nGXrGdlKnodJ2xZEYaQOn7sDd27EQxFWFzYZhEk513IlFWr49KmRS4cAWtH6Gi1GMj1ZxNwtKM
	ltw3cLsDLkAjoaxohc1CWCIIDGI/6cEkammaRVQJSxlPNAafACUh/gORiZLf4rEzIi5LNdPpGm8
	hocNF15er0iK6l+iU5Dzr1K39YAmipkE1Y9SmScGKIZY4ljbp045vR4=
X-Received: by 2002:a05:690c:399:b0:879:44a6:1076 with SMTP id
 00721157ae682-8a64af573a9mr75604667b3.32.1790615855795; Mon, 28 Sep 2026
 10:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-10-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-10-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Sep 2026 13:17:25 -0400
X-Gm-Features: AclHuK_MHLfXlBbKZGJVP5xhIG-DNTw2sUYErN-q1dRiPbR0HzxgHX9j04sNrkM
Message-ID: <CAEjxPJ6xDyxCik3v_2VN8MPkE42a2MzDsfbK8ThXNhqbSuLz3Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/21] tests: enable strictness for perl scripts
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:59=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For patches that have not changed, you can retain any Acked-by,
Reviewed-by, or Tested-by lines previously given.

> ---
>  tests/loop.pl        |  9 ++++++---
>  tests/nfsruntests.pl |  6 +++++-
>  tests/runtests.pl    | 16 ++++++++++------
>  3 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/tests/loop.pl b/tests/loop.pl
> index f5bf6ba..2c97b77 100644
> --- a/tests/loop.pl
> +++ b/tests/loop.pl
> @@ -1,12 +1,15 @@
>  #!/usr/bin/perl
>
> -$count =3D shift || 1;
> +use strict;
> +use warnings;
> +
> +my $count =3D shift || 1;
>
>  print "Running all tests $count times\n";
>
> -for ( $i =3D 0 ; $i < $count ; $i++ ) {
> +for ( my $i =3D 0 ; $i < $count ; $i++ ) {
>      print "$i: ";
> -    $foo =3D `./runtests.pl`;
> +    my $foo =3D `./runtests.pl`;
>      if ( $foo =3D~ m|All tests successful.\n| ) {
>          print $';
>      }
> diff --git a/tests/nfsruntests.pl b/tests/nfsruntests.pl
> index c3f0626..fa4e23a 100755
> --- a/tests/nfsruntests.pl
> +++ b/tests/nfsruntests.pl
> @@ -1,5 +1,9 @@
>  #!/usr/bin/perl
> +
> +use strict;
> +use warnings;
> +
>  use Test::Harness;
>
> -@test =3D "$ARGV[0]";
> +my @test =3D "$ARGV[0]";
>  runtests(@test);
> diff --git a/tests/runtests.pl b/tests/runtests.pl
> index a2ed7ea..7654a82 100755
> --- a/tests/runtests.pl
> +++ b/tests/runtests.pl
> @@ -1,20 +1,24 @@
>  #!/usr/bin/perl
>
> +use strict;
> +use warnings;
> +
>  use Test::Harness;
>
> -@dirs =3D split( / /, $ENV{SUBDIRS} );
> +my @dirs    =3D split( / /, $ENV{SUBDIRS} );
> +my @scripts =3D ();
>
>  for (@dirs) {
>      push @scripts, "$_/test";
>  }
>
> -$output =3D `id`;
> +my $output =3D `id`;
>  $output =3D~ /uid=3D\d+\((\w+)\).*context=3D(\w+):(\w+):(\w+)/
>    || die("Can't determine user's id\n");
> -$unixuser =3D $1;
> -$user     =3D $2;
> -$role     =3D $3;
> -$type     =3D $4;
> +my $unixuser =3D $1;
> +my $user     =3D $2;
> +my $role     =3D $3;
> +my $type     =3D $4;
>
>  print "Running as user $unixuser with context $2:$3:$4\n\n";
>
> --
> 2.55.0
>
>
