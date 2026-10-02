Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69994AB1C0
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950450; cv=pass; b=gnpzxgiHIv1fFlc/DnsUjnDN66GFhkkQjouy6IMvnOFIuwI/r13eCvlZI9vwyNucWKrMQSF29PVKzulyAhO2DKL5Ix2PyvzAdsipP+9aEWvfhcYoHamTw0+dkyGi7yreTzk3az7WAV8sbgdRkWfddW1DmjZkSasUMBtjrxf61+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950450; c=relaxed/simple;
	bh=Dl89B/pH4xU1X6TKtQ5nwsS6uzoxfgbLjNw85IBq+eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhDb96iU6f8EvTTtyt25yZkMXAzB4vMKhW2x/Ioie+tfpHNIKZVDWBNAaowWjOy3eAOF9d9JnzZIesqQEeqYDCM0Y7cwl4roccCXTXXs3ilMIJWwKca4GLhv9iLXqu1dnzru2iBVEcmT7kGb0AgmcjhDvR4BDAN3tjnAX303unQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUHFxnw4; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUHFxnw4"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-67375a844dfso7325755d50.2
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2026 07:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790950444; cv=none;
        d=google.com; s=arc-20260327;
        b=iomJKq2iXgqcXFCzqJDkq1BvkWMqlCZq4fFasqH9G14Daf27k/62jl0/GVdenEibML
         hEJ0uB1Jf+8LeK5bXJcj7bfEMjuq1iRwJaIsoZEC54bl/7lb+baNIR25fJuWsBvHfIz3
         CHOKOuzuMSdYDCapa5YBnGzc5kKoNN6HmfzBv8bLmcZFZr4LEBkmP8bJJV1WrjYVq79q
         Eo70f3IggpEfTJS4h14jFgLKqEI2S3e/3DKR8EMKEO5zpPl47pMQiZ67xUJ7IJrzmQm8
         oNMcZ62Jpm+RWRDlUrLPQNVcjHFDTSg6aYLzCwqOK4JgkF8epdlU0lkuZ5QwPmN8wOM9
         NZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bIkxGo5VegCyGTXmPoTouSI8mW4kYAzlrTHiIXWwxPg=;
        fh=OUbBEH133zFuN6mlBCCH+gcSK5T7Z5g0RHaKVLhh0II=;
        b=hlmiLeF5t1hfKGYre6MtifPXiZmiUoM/7lupO+9Xzhp4ZHDspN6Y7rftJjiPXLormg
         KY7O2q5QZoXB7NGijJV3acMA5lids64TOCDtW3qJ1vIOk+GP2Yx3LlI6bDhrqpMgaQVa
         rucZUg/+T7H5uHJWIvVsJbWPeFdjLBhu7zu25QaxKNxCUMsVrvipJOfCRW905sOsVRpF
         n2dF2OfjgrdsAO+WN9zePk0bWdE94m7mdz+Cv+78u2gU73TW3q9KKY/bOGAI4rWyvfPj
         RGyFbmSxh3bT3DfN8V/klbboH4J7WBadYh4YureGljvisggds+o21pgtP2NOU/7tDAqp
         z2hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790950444; x=1791555244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bIkxGo5VegCyGTXmPoTouSI8mW4kYAzlrTHiIXWwxPg=;
        b=LUHFxnw46NAgVFVoW7TS1uuMJEDcHjl1pd7Yt4CySeBtfR9arGa0Ud/ieeRAEasj3q
         YMFBhf1Np+l4ikk8Qcj4R53+Gmpsg7K9QeUdFdUNYth0PJcg18OWGdAzoyCueGCH6PtI
         G2LR02x+s7vvN6pS2ksiPnzoQyzzOQYpWYwR1ZcwgpbTNX0nFbQePdbpkt6D3j7qdBdC
         SZHZK9g5oTEJVBQy5j8NIYLKOuU6Urnkwh3TqLkdXHFBcGenx91cy6VoQI5JmMHoaKa0
         OH0r/FBbr6Dp7NqnsCA/XWLhSioIq51PaxtRzRkl8+IMzbuWSA3afKKck9HhpyKN0ZY5
         bq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950444; x=1791555244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIkxGo5VegCyGTXmPoTouSI8mW4kYAzlrTHiIXWwxPg=;
        b=ynxWKuPFP+oHk7CfqDiveRaeH/9WUADQkGSPKpEK1/w5VX/gWM7QO2wkUG1hqposf7
         5CJQmq08P02ay7oX8YSp+PGQ0q9yilK3I+oYD5wFu8mihSRVEahDP4J25ExcsmijKc/v
         CGXHgUwN+WAEYvmcuHSDZRlv3O0yatwNYl4Q6BXMzS+MGvFYGcTEl0qd8Vg9n1VhVT2q
         J1bkqJIDZ1EfQxtNmHuc0zK0CPTq06K/hl4IvsHAn93qrQYlateyJ06c6fyD1RoIEJfI
         i/FmAAKevf5eRZ8M/hZRrJvIV3c3OEIkN75g0QenXpONilNwKRtWitFn3ia7dJh3//l2
         cRSA==
X-Gm-Message-State: AFq9FYIuoamFX71mlgBf37mCkolXnhEUIZaHjK7T+izLrTRdPqod2W5s
	jjGlV49TJEgOAWa+xzBEA4tAmsGHEfWGtnCSjk6xiORU2e6Qw99otBJ7yTKL8O3iXiHVIU7MPRq
	UfyalxbWMvqjrgCqc8eguvMIKKJUJg7g=
X-Gm-Gg: AYBFou10updV7Mvw6B7d5LXJ956uDRo2NhvAWVHQXJunzHjFtIaeZ/n0UMfWRjDTJEK
	1S7hQJBr5HtsO6OfKpH+ZTO6QhSlMvPfq9Wd/C2ivkLyLPp5bekn2odLSMsOdqh4/O9dM8NXNlF
	nEpbrOziwDUllpNGaahZ1iUP675bmNDVdlFBFIucNt/jMP5wKF7sCrkbB1uBp2arwEm1tBFYE+E
	35e4lDMEfhB0SDbOltAqKhUabUO9HTRYSDHJvNM0eRkRhlbS6ONaqICofo1U/ZBzdyFdHHlBo9F
	6DJ7I+9AaFy5RhzY9qBWNYis7RWSfAizG0NDI9CsRCTgsUJ2GFBtNzU=
X-Received: by 2002:a05:690e:15c9:b0:675:3dfb:4187 with SMTP id
 956f58d0204a3-677ac1929f8mr881773d50.99.1790950443677; Fri, 02 Oct 2026
 07:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001153212.102261-1-bgrech@redhat.com> <20261001153212.102261-2-bgrech@redhat.com>
In-Reply-To: <20261001153212.102261-2-bgrech@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Oct 2026 10:13:52 -0400
X-Gm-Features: AclHuK9x-mALmwiB_aOOt6hEYga1YmOiLt5a6D19Ukrsl_GtsOojgYPEh-SvRT8
Message-ID: <CAEjxPJ7jsTmPNgrVd56P6tSh2akQ=vM5SMYNaG6+jEirSPruEQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] tests: skip io_uring when unsupported or disabled
To: Brian Grech <bgrech@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:45=E2=80=AFAM Brian Grech <bgrech@redhat.com> wro=
te:
>
> Gate the io_uring SUBDIRS entry on liburing.h being available at build
> time. Runtime kernel support is checked in the test itself instead of
> via /lib/modules/$(uname -r)/config: that file isn't reliable for
> hand-built/booted kernels. Since the kernel.io_uring_disabled sysctl
> only exists when CONFIG_IO_URING is set, checking it at runtime covers
> both the "not built in" and the "administratively disabled" cases
> without relying on the config file.
>
> Also fix a latent bug from converting to Test::More: ok($result, 0)
> treats "0" as a test label, not an expected value, so it silently
> inverted the pass/fail logic for the "should succeed" cases. Use
> ok($result =3D=3D 0) instead.

Nit: this file was still on "use Test;" before this patch, so the
ok($r, 0) -> ok($r=3D=3D0) rewrite is a consequence of this patch's own
Test -> Test:More conversion, not a pre-existing bug.  Also see
comments below.

>
> Assisted-by: Claude Code:claude-sonnet-5
> Signed-off-by: Brian Grech <bgrech@redhat.com>
> ---
>  tests/Makefile      |  6 ++++++
>  tests/io_uring/test | 35 ++++++++++++++++++++++++++++-------
>  2 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index 084c788..d53684a 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -172,9 +172,15 @@ ifeq ($(shell [ -d /sys/fs/selinux/class/memfd_file =
] && grep -q 1 $(SELINUXFS)/
>  SUBDIRS +=3D memfd
>  endif
>
> +# Skip when liburing-devel (providing liburing.h) isn't installed to bui=
ld
> +# against. Runtime kernel support (CONFIG_IO_URING, io_uring_disabled) i=
s
> +# probed by the test itself rather than here, since kernel config files
> +# aren't reliable for hand-built/booted kernels.
>  ifeq ($(shell grep -q io_uring $(POLDEV)/include/support/all_perms.spt &=
& echo true),true)
> +ifeq ($(shell test -e $(INCLUDEDIR)/liburing.h && echo true),true)
>  SUBDIRS +=3D io_uring
>  endif
> +endif

I'm not clear why we need/want this - liburing-devel is stated as a
build dependency in the README.md. Not strongly opposed but not sure
we do this for other stated build dependencies?
Not sure we want to silently skip tests because we forgot to install
something required by the README.md file. Open to other maintainer
feedback here.

> diff --git a/tests/io_uring/test b/tests/io_uring/test
> index dd97027..36e1d49 100755
> --- a/tests/io_uring/test
> +++ b/tests/io_uring/test
> @@ -1,17 +1,38 @@
>  #!/usr/bin/perl
>
> -use Test;
> -BEGIN { plan tests =3D> 11 }
> +use Test::More;
>
> -$basedir =3D $0;
> -$basedir =3D~ s|(.*)/[^/]*|$1|;
> +BEGIN {
> +    $basedir =3D $0;
> +    $basedir =3D~ s|(.*)/[^/]*|$1|;
> +
> +    # kernel.io_uring_disabled only exists when the kernel has io_uring
> +    # support built in, so a missing sysctl means CONFIG_IO_URING isn't
> +    # set. A value of 2 means io_uring is administratively disabled even
> +    # for privileged processes. Check this at runtime rather than kernel
> +    # config files, which aren't reliable for hand-built/booted kernels.
> +    my $io_uring_disabled =3D `sysctl -n kernel.io_uring_disabled 2>/dev=
/null`;
> +    my $sysctl_rc         =3D $?;
> +    chomp($io_uring_disabled);
> +
> +    if ( $sysctl_rc !=3D 0 ) {
> +        plan skip_all =3D> "io_uring not supported by this kernel";
> +    }

The kernel.io_uring_disabled sysctl was only added in v6.6 while the
SELinux io_uring class/permissions this test exercises have existed
since v5.16. On a 5.16-6.5 kernel built with CONFIG_IO_URING=3Dy the
sysctl doesn't exist, so this will skip_all a test that currently runs
and passes.

I'd suggest treating a missing sysctl the same as 0 (run), and probing
the "io_uring not built in at all" case directly - e.g. a tiny probe
mode on the iouring helper that just does io_uring_queue_init() and
exits 0/1, run unconfined like 1/3 does for netlinkcreate. Then the
sysctl check only needs to handle the "=3D=3D 2" admin-disabled case.
