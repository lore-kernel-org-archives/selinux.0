Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2127442
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263379; cv=none; b=Az5EoXzrssqBfehn1BfqZdv83bnZTiz/ws1AUUYrob5Yhh5oeHH9//XKbzPSsgFGZJFJ0ZaxD7RkH11urSDqWc7xPgL8ASiZ5oIIAimW3doK8LReTsUpCNMyhpjtpAOdIlwYzy9PMnFzurkqEbugnk7i5V9R+YLkuzyNerTA2RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263379; c=relaxed/simple;
	bh=Som9Tcnvuz/Dc6LrrnLb2+1RP3Cg+AQhfV4qF87Bw2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7raEE47LLMDnHIOj4WppFzQCRcjgOkEOWzBA6iAEmuJ1l4zZUl8m05ngTkqmu8onO+HwghTEFo8TV/WonL+W8vOdOC808RarI/GpwO75HvMdUWhPKstpJnlNXjrCKHjUWg6oWyTDd3bKwpP7g+MozDp3CoFSUFhifrpy6De2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkS+ZNEi; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkS+ZNEi"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313f928718eso3785738a91.0
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750263368; x=1750868168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3bdwB7W5TvRwkLQ4IH9n5FUseoLxhSX3YJRQlAeaZQ=;
        b=IkS+ZNEiXJDKKaylazLr5LzDMOS1819XY/cwNN3PQTYr6Dgko1WwKloR8NKgT4CSwy
         8eB0dnny4KJJWxi+dhOo+HxQL2pfpGuXp8rrmsTYQi0ICm1Pxym85bxd1Z9rAKrTs5Jo
         8iTvqHlR8NNBumi+3os6WBDRntEKQ6GHfGFBsOG+oyPLNngGoUIqsDIhFRUFfUeZCyI4
         4JJXstTQmsr4M2MnMLtyPgR07t6d/eX36HrZ+x4at3/znJCSeC8Z7IS6j/2IJiWlcsNt
         LHvMC8S7O0zoBz63xrREBumGpvoYN+tfT9N9l03snAp6cYD3jbh81EJHnAk3XcS9mlRm
         2ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263368; x=1750868168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3bdwB7W5TvRwkLQ4IH9n5FUseoLxhSX3YJRQlAeaZQ=;
        b=n0NIRY6BFx3jATrAORg/XTFjMSN9mlLF6Sp1dtlfURqxNtVZHhAwdqsVijAk/Qveln
         DNDI7aqX164z4rgJ/H5pZ9GauQmgZ8pBY3AMMU9tb29B9WTxz/l011ncDPFNo7PkkXKa
         eCFQTc2BMOya4cqzz3HskwqC6ZIm1oUHuk7GOIys0kHzoCSF62k74zAnWz6jbrq7k6TY
         2Lza9wmWdI/HNAbjGkT53N8nW7al/sO3iwYrKyaXFWkfQc7nwon4VcFRdkpARAFqv1OC
         2cB3Xc9bOVVyBRQHaM1mTaZSFkoteg5BEF5DSIsPoY6b+TtN31ASlwc6Sz3Gazc1TJPK
         Nq7Q==
X-Gm-Message-State: AOJu0Yyy/6XiBASv7hMr4zun6r9AXPtDV6Ct2d5XnLckqFxsFcvnuBdr
	HqbRUrhcS+Tqlj4okM4yXxvYnPHfNqw71ffqAeTluX3ZAUEgTPGou6hvuE1rthR1a4VVJHIIIqU
	TB9lYq/zq7xkcIq0OdGqwzvkXdF/NoGsLrA==
X-Gm-Gg: ASbGncu6KqVpshfhLfG/0ReS+zckKWSTenQp/P3LVcKJO4840wrtFyH+sTjsZQFIICy
	FIgP5rLNYnszmHMgpwveVYSDDg4AB+w0YdNW/UF2x8uoPOdah++9bKUgyMzElTvzk3av+6GZPmO
	PkPsaqn/XbwUe0BiRukrWQatfm56fwOhLhcLBgaaHzW5k=
X-Google-Smtp-Source: AGHT+IFA2pb3/a/cJ5TE8FmPfSzA92J4a3cALupTKJvd8Zb+7aC0KX6089Z3MxmdEhLWfpw17NmL+LCWAIHJl8YaQSE=
X-Received: by 2002:a17:90b:4cc3:b0:310:8d4a:a246 with SMTP id
 98e67ed59e1d1-313f1be1b4emr21831263a91.1.1750263367547; Wed, 18 Jun 2025
 09:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611190512.23743-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250611190512.23743-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 18 Jun 2025 12:15:56 -0400
X-Gm-Features: AX0GCFsAX1F0urNU0UrORwPtYkKXw8YhpBynGFfaqD2bf1GqEiHzzJPlmb9YZe0
Message-ID: <CAEjxPJ4z97xy2nwMzDjQoC6g2X2RtwK4u0nhh+Ki8MaRvmLUfg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/mac_admin: disable test of getting
 undefined label on nfs
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:05=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> We already had a workaround in the test script to expect a different
> result on NFS to the unique aspects of labeled NFS, but this
> workaround won't work when/if SELinux namespaces are enabled
> (due to the introduction of the global SID table and its
> correct preservation of the original context value) and was
> really only papering over the lack of support. Just disable
> this particular test when run on NFS filesystems.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied with a formatting fix via tools/check-syntax -f.

> ---
>  tests/mac_admin/test | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tests/mac_admin/test b/tests/mac_admin/test
> index 32161f3..8390d06 100755
> --- a/tests/mac_admin/test
> +++ b/tests/mac_admin/test
> @@ -7,8 +7,11 @@ BEGIN {
>      $basedir =3D~ s|(.*)/[^/]*|$1|;
>
>      $isnfs =3D `stat -f --print %T $basedir`;
> -
> -    plan tests =3D> 8;
> +    if ( $isnfs ne "nfs" ) {
> +       plan tests =3D> 8;
> +    } else {
> +       plan tests =3D> 7;
> +    }
>  }
>
>  # Verify that test_mac_admin_t can relabel a file to an undefined contex=
t.
> @@ -38,14 +41,11 @@ $result =3D system(
>  );
>  ok( $result, 0 );    # we expect this to succeed.
>
> -# Verify that test_mac_admin_t sees the undefined label value.
> -$result =3D `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_dir=
 2>&1`;
> -chomp($result);
>  if ( $isnfs ne "nfs" ) {
> -    ok( $result, "UNDEFINED" );
> -}
> -else {
> -    ok( $result, "unlabeled_t" );
> +       # Verify that test_mac_admin_t sees the undefined label value.
> +       $result =3D `runcon -t test_mac_admin_t -- secon -t -f $basedir/t=
est_dir 2>&1`;
> +       chomp($result);
> +        ok( $result, "UNDEFINED" );
>  }
>
>  # Verify that test_no_mac_admin_t sees the unlabeled context.
> --
> 2.49.0
>
