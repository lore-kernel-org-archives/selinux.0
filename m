Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F4F38E135
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968458; cv=pass; b=gKBuW+ajXsRv6bhxK8NBYDkhD7y0IC+URapFBeVWFJoD3eq3VcyZueLWdb613xVH3NMZ/8+JFZTqnNKxMM3uIJthGS6cti9mKg1ccbRhu4V7/kSIORj5HekVO5bf7a8CLJDzAas79nCxzSJAUU2rBNQx2fD0mQK4POBfhUiEHtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968458; c=relaxed/simple;
	bh=SOWmdwyTH+B+zF7/Qt+lnFyY+JFPCzXgJQwdoaZsi7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAd2mhbRp2ZadT9jSyHcAu6pnCB2Dgmvits4rQaGYmQ0zEeKCuVgTaSmbAmLJ92Ji7NPHNakEzuUtfGK7S5N5aoLx33h7FFmymQbB8Of2chN99cDYpE4r30giEpsHMmqZnK8JMIDx/cap9Of1dWSdqruRvq8Jq84Ch7Ngy+xb94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg10tg2u; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg10tg2u"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso461156d50.3
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2026 12:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790968456; cv=none;
        d=google.com; s=arc-20260327;
        b=oiYcJE5mAgd2LRuizB/QuZLSvY4bqWN26vs2EX2FrLURWFmrsmQ0nvcLDPX1z50dxv
         /M9qTnvhxy9Nln8t3l6DDcCE9f3KqbM5EoM3frI29bEFDmiqGgDgm1/EuTdhCMqH1gFk
         zJJQHsuJRu+coOFqqYifEGCJkhUpfN2+JZ13gwVcpWow2cBGSmWUsSIGpqMQScklYz/n
         IYNKDLpZ+Vv7lcVMC3bvE8hxOKSM/BjpGX99JgRDEWf7y5siedvOaKk+aeB3Q22EClVK
         Cm98COe+YeGlEoL4BNpMDt//cPzkIubexPqLs1KDs+1SZ5bMyAqSxgXcuKUtk7snKI2L
         5TPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rSWihMJ99jTSHGmmE83qFJIOiPuM9toYn0B2S2C7TYY=;
        fh=E95boLTiTkq8XsjKw8GK1wyz25DmW0RgNCvDUxEAbME=;
        b=kBoUL8IhA1pbLkPUBqlv+hGQBMOHi5CiVTf29C49lxtny6vFWaGo28+tHsIAgNicF7
         xK+Go0PNkwEHAxcbHvlz2QTmyu5wvmlrvKiT94zd/d4Zacu2JPEV93UaCZ6uQjZT+eVy
         xyTyDNDyNX0+n/nur+7gLSCSA8d7rJKh0kLgOS9c6ZD1K0UxH0tpjBSY/2dCVnx8+u0S
         i9Ed/p/02Tv69aYrHMlOhQdiOcFJ/NwwoH6hCTpiQfvm7UG/n0MfGYwgxVpLRezdqcaJ
         O+tyczJt2YvLIKNMD0zdo4qlulhSpMftkpvSTIAXkVRoAWeUPKZ+ZyjWri8GFmw1ju5c
         4KRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790968456; x=1791573256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rSWihMJ99jTSHGmmE83qFJIOiPuM9toYn0B2S2C7TYY=;
        b=Mg10tg2uuvS5yM1KOJMs8CnIYJ4hEBvaDvjh1h2/IBavjRbJYuGoARQMmQwLMuFeF2
         zPYC9zDBht6H0KEXkD9rv3s99j2ULGgfuFDuyrxjDegn9ywgcET3psFNhlOpOm9Wd6/3
         2rUIn25i90m5uiemcal8HrwNJCDRNeA+MvrDKF1L7I8Nsj636wcDmC8HaIm6Ev8VXkp8
         dpPkOAryHPkLst+LNONDVDid0xG2SRTbPOKiBoFQ+RqbGyznnGniyvrpXFahrbyeFHu4
         y4356XQHQqOSdnQMRBE1i4y6pnWgIHO63ymOvfjVdwdviSadL7IlfUgxocHq6PmLrbLZ
         NXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790968456; x=1791573256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rSWihMJ99jTSHGmmE83qFJIOiPuM9toYn0B2S2C7TYY=;
        b=XhpOwjBsFd91kL5H2nV2GetNcT8K/WWVdaTVeiHiNdaNiGbVIHzMSXtnZGl1w/n7hz
         6RpKrLweZTPLkRwfU/1SbmPTMhF+RlCazA5KWVlp+j+TnfBeiZjITkx7sZj25tNbJLcq
         o5NrV5SNRrurzlDjWsv6dHiiTbbgk4ouFrCUFzHOHCjCcPMUavRyP598QQHbcve4oMeW
         4szcNDaXueksKyckrHNXIItNWz8mCUnkWE1URi09pj99B3yPVy+C+MIsVImi2pFhW0Ul
         zOziDU+JNEd2vTQoczOGmwdc83GoC34CfSxa9S4ez/soypZ7QY8iKfJ7SpHvLMkjBqvU
         Tlaw==
X-Gm-Message-State: AFq9FYJ6+/m/1Tr/NUWOAp0Q6t9nBDmSHvhlrLLhSMVvukBmkxh3gNaU
	bVw/ljjaLv3Jy6tfwj1hKQlz8FHvXkIbgNLY0tfg3oNW2Kbm4srj9whcWr/TpDv3NRx9C4ga+BR
	W1yxo7aZ09vGT6WymwSX7mQV+3KwTmkPncLhU
X-Gm-Gg: AYBFou2PKMyQltkgmEOF9fapdz0UOQ2Afpc01cTGOmOfmYiU/da5J61+jO6VBqNAahA
	rrTtaQfbwb6orO8wohfjdU+uI6UN463hLN6CrJ8YJKK/1SK2Q/OpcoD+hBTfUuZzZ5YEjFB6xeN
	3pHZRHGp+17N9BdZjwtakD6/8k18vyj5xJosb9NBio8yGg21q2C6iK9j9XG7LSf7UFcfZahI9BK
	ZooSyWWg4vwI+MqbGbSFdyKoAw21XeAESdpgQStrefOZZ8DwdtAOwlafiVBtK4A4P4BTGORD49v
	oSwYaOSC17j0weND6VOtqxcz+huaK08EhKw4QSDwkUNzskIejGeaen0=
X-Received: by 2002:a05:690e:d08:b0:670:f743:6eb0 with SMTP id
 956f58d0204a3-677ac15da18mr1731900d50.98.1790968455606; Fri, 02 Oct 2026
 12:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001153212.102261-2-bgrech@redhat.com> <20261002154617.751470-1-bgrech@redhat.com>
In-Reply-To: <20261002154617.751470-1-bgrech@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Oct 2026 15:14:04 -0400
X-Gm-Features: AclHuK-T7H_h7NxoTdF1KQYzG_xXAXvpC4bbgZ8BWfH-2MiyH1ukZGFK9n96iD4
Message-ID: <CAEjxPJ4iGzxjwKZ+eBBeo_CfLFy1XNj8t3YMg3Fo0V_uRMz4Tw@mail.gmail.com>
Subject: Re: [PATCH v2] tests: skip io_uring when unsupported or disabled
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 11:46=E2=80=AFAM Brian Grech <bgrech@redhat.com> wro=
te:
>
> Gate io_uring on liburing.h at build time (documented dependency,
> same pattern as key_socket/keyutils.h).
>
> At runtime, probe unconfined via a new iouring "probe" mode
> (io_uring_queue_init()/exit()) rather than kernel config files or the
> io_uring_disabled sysctl alone: that sysctl (v6.6+) postdates the
> io_uring permission being tested (v5.16), so its absence does not mean
> unsupported. Use it only for the "=3D=3D 2" admin-disabled case.
>
> Converting to Test::More also requires ok($result, 0) -> ok($result =3D=
=3D
> 0): the two-arg form silently inverts the "should succeed" checks
> under Test::More.
>
> Assisted-by: Claude Code:claude-sonnet-5
> Signed-off-by: Brian Grech <bgrech@redhat.com>
> ---
>  tests/Makefile           |  6 ++++++
>  tests/io_uring/iouring.c | 20 +++++++++++++++++++-
>  tests/io_uring/test      | 38 +++++++++++++++++++++++++++++++-------
>  3 files changed, 56 insertions(+), 8 deletions(-)
>
>
> diff --git a/tests/io_uring/test b/tests/io_uring/test
> index dd97027..fb6528e 100755
> --- a/tests/io_uring/test
> +++ b/tests/io_uring/test
> @@ -1,17 +1,41 @@
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
> +    # Probe unconfined so a failure here means io_uring isn't built into
> +    # the kernel at all, not that it was denied by policy.
> +    my $io_uring_supported =3D
> +      system("$basedir/iouring probe >/dev/null 2>&1") =3D=3D 0 ? 1 : 0;
> +
> +    # kernel.io_uring_disabled was only added in v6.6, well after the
> +    # io_uring support being tested here (v5.16), so its absence does no=
t
> +    # mean io_uring is unsupported - only a value of 2 means io_uring is
> +    # administratively disabled, even for privileged processes.
> +    chomp( my $io_uring_disabled =3D
> +          `sysctl -n kernel.io_uring_disabled 2>/dev/null` );
> +
> +    if ( !$io_uring_supported ) {
> +        plan skip_all =3D> "io_uring not supported by this kernel";
> +    }
> +    elsif ( $io_uring_disabled eq "2" ) {
> +        plan skip_all =3D>
> +          "io_uring is disabled via the kernel.io_uring_disabled sysctl"=
;
> +    }

One non-blocking observation: with io_uring_disabled=3D2 the unconfined
probe itself fails (io_uring_setup() -> -EPERM) so the first skip_all
fires with "not supported by this kernel" and the sysctl elsif is
never reached. Harmless - the test skips either way - just the message
is less specific than it could be if the sysctl check came first.

Otherwise,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>


> +    else {
> +        plan tests =3D> 11;
> +    }
> +}
>
>  # Remove any leftover test files from prior runs.
>  system("rm -f $basedir/iouring.out");
>
>  # Verify that test_io_uring_t passes the t1 test
>  $result =3D system("runcon -t test_io_uring_t $basedir/iouring t1");
> -ok( $result, 0 );
> +ok( $result =3D=3D 0 );
>
>  # Verify that test_io_uring_no_override_t fails the t1 test on io_uring =
override_creds
>  $result =3D system(
> @@ -44,7 +68,7 @@ chomp($serange);
>  $childctx =3D "$seuser:$serole:test_io_uring_child_t:$serange";
>  $result =3D
>    system("runcon -t test_io_uring_parent_t $basedir/iouring t1 $childctx=
");
> -ok( $result, 0 );
> +ok( $result =3D=3D 0 );
>
>  # Verify that test_io_uring_child_no_override_t fails the t1 test on io_=
uring override_creds
>  $childctx =3D "$seuser:$serole:test_io_uring_child_no_override_t:$serang=
e";
> @@ -72,7 +96,7 @@ ok($result);
>
>  # Verify that test_io_uring_sqpoll_t passes the sqpoll test
>  $result =3D system("runcon -t test_io_uring_sqpoll_t $basedir/iouring sq=
poll");
> -ok( $result, 0 );
> +ok( $result =3D=3D 0 );
>
>  # Verify that test_io_uring_no_sqpoll_t fails the sqpoll test
>  $result =3D system(
> --
> 2.55.0
>
