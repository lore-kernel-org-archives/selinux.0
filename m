Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63394298CBC
	for <selinux@vger.kernel.org>; Thu,  9 Oct 2025 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993420; cv=none; b=mPi0FNUrdoy6DkWOUbjRocKCfwjS+/N8IOMlfiz62b4OVHNxF6ZU+SQ6gsMk6eALXdHRXEfGpLrnJq8+TlX2vZDTQ57BohM2PiXoxRlBv6O5gFCEm41FAyrkdlgc+5wSANyHBGTghTsIflMJAs3keZxMlo4mZV0lMzBFXsYOqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993420; c=relaxed/simple;
	bh=OMWqoT/pRD/OYsmW6nnvGQet/0Bm2sCPB0cFb676HII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUSzjIeZkVECi3KVVmAPU33jCRyYnu3iA8XtF6qI4o9nDYsx3Rw5KQNMbXgaE5KYoQbDMveza0H9ablI0PYxKKVu3ZzdrI0nVbrFKKFHeYvQ+a93/t6q+N+vv3FrWIThlxUqpivkEYla7a/BMQayliRFeQJ457xpGVdjdj+jL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4Pg7M1u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4Pg7M1u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759993416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uuG+7rIZ1+A7hSEzrgVSxGZ6x549bORQjUZA+kWJQi8=;
	b=Y4Pg7M1uzBHP6a4jZ8ndblFrb9Jcl684kSoOTu8rWxwKJde/FGIRLOVEKYVgJaDg3mttRK
	06LA3PI+ZvJwmf5cp05a+E9FegZrIwuOtqfL/Xhyb/D43dwaZhkucqaifW3dEDt3ElEqT6
	H2a7RcUlufCcj2NTD4dROY1ZwOtzKyU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-TarZWMH1PbS1WovEqcBZLA-1; Thu, 09 Oct 2025 03:03:33 -0400
X-MC-Unique: TarZWMH1PbS1WovEqcBZLA-1
X-Mimecast-MFC-AGG-ID: TarZWMH1PbS1WovEqcBZLA_1759993412
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-336b9f3b5b0so1645692a91.3
        for <selinux@vger.kernel.org>; Thu, 09 Oct 2025 00:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759993412; x=1760598212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuG+7rIZ1+A7hSEzrgVSxGZ6x549bORQjUZA+kWJQi8=;
        b=eirHJ1paKc9RQ1OZ9HBiSBdyFjPY0yNfBd2F6gtINmholsj8rIVAWg074CRTWngvV4
         4r/c8W4guYz62Hlu9/SVBNxl/dNZDPcsEeDjKygFZkzyVQUQCBdQzrfPn+mc4ESvuxVi
         wocaZw90U6eZDVBIrglT+W8c2iYyAZoRc+ZI9CJ+m61nkDjD8BKsUrHY5DD+HGOkxOeJ
         1F+hsCqMCyGGAkBEoAEwEqexnNoo8/fKoOmEtHa2X3Czs+2aj1dMI9SWeYoHE3dDdSbl
         vE5saM+AJ6Pkvo7HzbKL+qdbL8l14wGKfuuaa10VDbAk3NOZRtcwraNz06jMZqMiPOFg
         LBCg==
X-Gm-Message-State: AOJu0Yx6glws3nbLzwoWob9goev67C022ueep10ILO+peSpXuoOcJp77
	PpW14KfpayVnJ5lv4Q6TqWPNinSjFBfKXJL0fiQXvI8A6s4xqB8q3/vsuIFZe4ancPInQpIdLjB
	WBXYOBdyHdnK5Vi0TqMlU1R0jY/mOYLAthQC2ADvU3HvSIjdI4pd0s18NLneS+zrGGu91Lhhaqk
	GPYqs2vyEXmrfN0K7WVc4ZpyYgiBSVv17d5w==
X-Gm-Gg: ASbGncu/bfiJh/+aFPeGtCwBstx9wmhoP61RFw6lE4lcT23rmwdkC763iePHt8w/jVR
	OANvACyre+rDqJVrSvcLmjhOJ8ZlB6G2Ne0L74Q613UNLd1/J84kTnCP7tkkOvu4WWORyoKZMXj
	tSzSj8uSrD0qvygaHCmMdikD4X
X-Received: by 2002:a17:90b:1651:b0:338:3156:fc43 with SMTP id 98e67ed59e1d1-33b51168e39mr9378923a91.11.1759993411719;
        Thu, 09 Oct 2025 00:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTHevCgLmGdRAgCRLlhi8d2o9V85Ube1AAGEo+UHurgdLNpLjSSTiq/hBkcg2hU7Q9J5pFD6T0zSXtbdoVWVk=
X-Received: by 2002:a17:90b:1651:b0:338:3156:fc43 with SMTP id
 98e67ed59e1d1-33b51168e39mr9378884a91.11.1759993411212; Thu, 09 Oct 2025
 00:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008143612.96917-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20251008143612.96917-3-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 9 Oct 2025 09:03:20 +0200
X-Gm-Features: AS18NWAIBzUiXtlGFZzmICrCls0kLMdlFOMw_eTHQgRPqhqaaW75VhhbDHACDjY
Message-ID: <CAFqZXNseFBS+u_ZVDZZ0Rqd+aMJrpUOftBUu_QJ+f1Sb2w0hPw@mail.gmail.com>
Subject: Re: [PATCH v4] selinux-testsuite: Add btrfs support for filesystem tests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 4:40=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Richard Haines <richard_c_haines@btinternet.com>
>
> This allows btrfs filesystems to be created to support the
> filesystem mount(2) type calls and the fs_filesystem fsmount(2)
> type calls.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v4 drops the mkfs size for btrfs to 128M since it doesn't require
> 300M, unlike xfs.
>
> v3 was just a re-base of Richard Haines' earlier patch which
> ended at v2.

Hm... indeed this passes in the CI now. I had recently rebased my
older branch with Richard's patch and it failed for a reason I wasn't
able to determine. The only significant difference I had was $mk_size
=3D 115000; instead of your 128 (not sure if that was in the original
patch or if I was just trying things out...), so maybe that was it.

Looks good to me except for two minor points below.

>
>  README.md                      | 2 ++
>  defconfig                      | 5 +++++
>  tests/Makefile                 | 2 +-
>  tests/filesystem/Filesystem.pm | 3 +++
>  tests/filesystem/btrfs         | 1 +
>  tests/filesystem/test          | 6 ++++++
>  tests/fs_filesystem/btrfs      | 1 +
>  tests/fs_filesystem/test       | 6 ++++++
>  8 files changed, 25 insertions(+), 1 deletion(-)
>  create mode 120000 tests/filesystem/btrfs
>  create mode 120000 tests/fs_filesystem/btrfs
>
> diff --git a/README.md b/README.md
> index f067eeb..973028e 100644
> --- a/README.md
> +++ b/README.md
> @@ -61,6 +61,7 @@ similar dependencies):
>  * e2fsprogs _(used by the ext4 filesystem tests)_
>  * jfsutils _(used by the jfs filesystem tests)_
>  * dosfstools _(used by the vfat filesystem tests)_
> +* btrfs-progs _(used by the btrfs filesystem tests)_
>  * nftables _(used by inet_socket and sctp tests if ver >=3D 9.3 for secm=
ark testing )_
>  * rdma-core-devel _(to build the `ibpkey` test program)_
>
> @@ -136,6 +137,7 @@ command:
>                 e2fsprogs \
>                 jfsutils \
>                 dosfstools \
> +               btrfs-progs \
>                 nftables \
>                 netlabel-tools \
>                 libibverbs-dev

You should add btrfs-progs also to the Fedora dnf command and also to
the tmt/tests.fmf (under "/run" -> "require").

> diff --git a/defconfig b/defconfig
> index b2d4a90..214eb26 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -122,6 +122,11 @@ CONFIG_XFS_QUOTA=3Dy
>  CONFIG_VFAT_FS=3Dm
>  CONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"
>
> +
> +# Test BTRFS filesystem.
> +# This is not required for SELinux operation itself.
> +CONFIG_BTRFS_FS=3Dy
> +
>  # watch_queue for key changes.
>  # They are not required for SELinux operation itself.
>  CONFIG_WATCH_QUEUE=3Dy
> diff --git a/tests/Makefile b/tests/Makefile
> index 903ab11..f002389 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -4,7 +4,7 @@ SBINDIR ?=3D $(PREFIX)/sbin
>  POLDEV ?=3D $(PREFIX)/share/selinux/devel
>  INCLUDEDIR ?=3D $(PREFIX)/include
>  SELINUXFS ?=3D /sys/fs/selinux
> -FILESYSTEMS ?=3D ext4 xfs jfs vfat
> +FILESYSTEMS ?=3D ext4 xfs jfs vfat btrfs
>
>  export CFLAGS+=3D-g -O0 -Wall -D_GNU_SOURCE
>
> diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem=
.pm
> index f169464..d5c68e6 100644
> --- a/tests/filesystem/Filesystem.pm
> +++ b/tests/filesystem/Filesystem.pm
> @@ -123,6 +123,9 @@ sub attach_dev {
>  sub make_fs {
>      my ( $mk_type, $mk_dev, $mk_dir, $mk_opts ) =3D @_;
>      my $mk_size =3D 16;
> +    if ( $mk_type eq "btrfs" ) {
> +        $mk_size =3D 128;
> +    }
>      if ( $mk_type eq "xfs" ) {
>          $mk_size =3D 300;
>      }

I'd prefer if-elsif here (no need to test for "xfs" when "btrfs"
matches) and maybe have the "btrfs" check below the "xfs" one (but
that's less important).

> diff --git a/tests/filesystem/btrfs b/tests/filesystem/btrfs
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/filesystem/btrfs
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file
> diff --git a/tests/filesystem/test b/tests/filesystem/test
> index a7d8b24..56f116a 100755
> --- a/tests/filesystem/test
> +++ b/tests/filesystem/test
> @@ -89,6 +89,12 @@ BEGIN {
>          $test_count   =3D 55;
>          $quota_checks =3D 0;
>      }
> +
> +    # BTRFS uses internal quotas requiring no security hooks
> +    elsif ( $fs_type eq "btrfs" ) {
> +        $test_count   =3D 55;
> +        $quota_checks =3D 0;
> +    }
>      else {
>          $test_count =3D 69;
>      }
> diff --git a/tests/fs_filesystem/btrfs b/tests/fs_filesystem/btrfs
> new file mode 120000
> index 0000000..945c9b4
> --- /dev/null
> +++ b/tests/fs_filesystem/btrfs
> @@ -0,0 +1 @@
> +.
> \ No newline at end of file
> diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
> index 9af8971..1d04bbc 100755
> --- a/tests/fs_filesystem/test
> +++ b/tests/fs_filesystem/test
> @@ -92,6 +92,12 @@ BEGIN {
>          $test_count   =3D 54;
>          $quota_checks =3D 0;
>      }
> +
> +    # BTRFS uses internal quotas requiring no security hooks
> +    elsif ( $fs_type eq "btrfs" ) {
> +        $test_count   =3D 54;
> +        $quota_checks =3D 0;
> +    }
>      else {
>          $test_count =3D 68;
>      }
> --
> 2.51.0
>


--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

