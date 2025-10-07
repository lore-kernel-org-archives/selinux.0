Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1E1E50E
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862816; cv=none; b=VtSo/tROBKmGqHnFxAMSkAEpVpUGNkDu5PQTIAaNIWSki+2rBKr3t4ADeeJatWWpoawbrdS6QTBurikGs/qi5o96h6XesSSdz+/VTydxHZ+3tl0kzuI0DjSfxDpwDxdk9XHOQKRp2MJxi09t+BBqRlDc0VeQpLSezoiLfmJoRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862816; c=relaxed/simple;
	bh=qp3B+xH/9f1/oN+4zbb2eQAiwKICOvdLWzxlm6tvCQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQIdId9ox9DqjNDkq+UDJ/hufG5BZTUDkQ+6/FMScAgN7AzfZsNQW9dgXD9ZFkbsUTgOWk72GUmQeGytnX2CwWrXm/Y+1j+x1sBbIxhP9Bqn7d0WaxvLOkAvstqRpVl2H6DU98LKBk99OP9zWIeSW86hwvJfsM/JWyrSc656PFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVEIrm9q; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVEIrm9q"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so7243258a91.0
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 11:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759862813; x=1760467613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24KHwNlMCYKbe178rUpATDNsKN2FHh+kgkNz34GcBFE=;
        b=IVEIrm9qfS6/bHQ8CPAwoPV3j1EvolWfc7b0UtscIeZkmm3NZqYgSmi6RowHmSwbVH
         b50OCN8lXQFrOwxu6IIw0wDKBDOQH+Vc/JTBCjtp1yDgQ7EqY4unDnPN66Cn22KAhQ9W
         +w6rdLGh+oYtKdKotUvaGmm70wPWRl9cqdmEV2WTTKBEedJDuGINeYPViphoCy1gW1wW
         nuRPZSP6fo1NKwcQl6YIxwA87krfEfi8e2laeweIU9mdfQAYtiJ4xz7hi4BdD5kycjQ6
         GUuOspw2lKGZUaUgVuCJtxjxFkAJIKpBnHSqYMByQ/SUXBnBw5y8BFqjqi7SmA3Nbw6i
         4YjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759862813; x=1760467613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24KHwNlMCYKbe178rUpATDNsKN2FHh+kgkNz34GcBFE=;
        b=datEhz8o5eF+OMUAiO7+bh4Unjit4Go+bPaYMVPSAPyakpguZPL4+FQaItmHf+d6Yz
         Gjhic2ZOewMULzYUVdZqqDrv9NS4X9AMz7B1oWKR+Scv3aPLmLOsmQWIwadZEtjStqH1
         lwCA6FPW325wENHvaWLL7jV7RXwdr495Ceyw7osr1XPnTzpkjVdoJnOuvwKVKjh56Hyu
         b9mGtDT5xUieAtag5EgBCXfjruGsEqoFVGGVBTdapoYG8WRe40mLawSn1eTb2CoNJ8Vi
         nT3qFgzQ0mTLUw9OHIQ/xC0rwyy6IxxzpSAsGmv2FUAXGr8QtPhOqzRFV66pk11EoUB0
         dLlQ==
X-Gm-Message-State: AOJu0Yz0TtsTmYmRFfjBu3NaKEvj8SFSXRcZn/YiAaqA7CzrRo5Gs0C5
	uje4/0akorRtYAP4SujNbOIUgmD2QfzB61xPr8JXS1zhil08Xedktbgp8WL+luSHHJWYDRkZixR
	F5058NDQq34tBe48ojr654DeXOxNlLS25rA==
X-Gm-Gg: ASbGnctE7bpVRpDI4wBoHlkWMOllNwm+ztVlmluOv2Rptqzccd9oDOkZa65hiRmUjSf
	g5srM6b2fqrw6QFiLXG0Kvm+7bb/Vz4ROk96o3Om1MyxaH9fKEHFo4UW+tLPkZbDjxKsF2FkWCH
	jMIZ1tX+vDYHPgflbSndTHjeXNTrpoCcedLngMJaFKQXpxOUDNnTVbPCpo/XG/LJQOM3Z8W+lN0
	VWX4qaEI0hJlJgWzrWBerOe7vXdFVM=
X-Google-Smtp-Source: AGHT+IGhtvlf8aUNVMHA0EI5LRRJ7l8lrjjcb5e155RDaqlFRZeDA3QHj06lxK4xseJVbLs3nDBN/bUd0Wdmjo0EwRQ=
X-Received: by 2002:a17:90b:4f8e:b0:339:ef05:3575 with SMTP id
 98e67ed59e1d1-33b513cd915mr610829a91.26.1759862813507; Tue, 07 Oct 2025
 11:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007183552.74330-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20251007183552.74330-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 14:46:42 -0400
X-Gm-Features: AS18NWA-58ihQSiL85svCDYJpHLpkTF4BoaagQRzdv2KqYhse0wVNVp9g8uGnEQ
Message-ID: <CAEjxPJ6gFMPFj-9im_EeencH2B4d6CfCa0TQs=5XZG4O7vBvew@mail.gmail.com>
Subject: Re: [PATCH v3] selinux-testsuite: Add btrfs support for filesystem tests
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:37=E2=80=AFPM Stephen Smalley
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

FYI, these tests pass cleanly for me on a current kernel.

> ---
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
> index f169464..7ea9031 100644
> --- a/tests/filesystem/Filesystem.pm
> +++ b/tests/filesystem/Filesystem.pm
> @@ -123,6 +123,9 @@ sub attach_dev {
>  sub make_fs {
>      my ( $mk_type, $mk_dev, $mk_dir, $mk_opts ) =3D @_;
>      my $mk_size =3D 16;
> +    if ( $mk_type eq "btrfs" ) {
> +        $mk_size =3D 300;
> +    }
>      if ( $mk_type eq "xfs" ) {
>          $mk_size =3D 300;
>      }
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
