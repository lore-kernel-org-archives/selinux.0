Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8E2E62C3
	for <selinux@vger.kernel.org>; Thu,  9 Oct 2025 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012969; cv=none; b=QLG2PrDHEqMneJbJ2HBsJDom2TTIBaWn5NKENLd+iqsqZ75Eo/vUwhDNkfVGnmyhVfsOQL437sxkUejdnE0W65eZugvfNBkoGqDxial+HYtGEYWHzhKa/hZmOkhiubiSN/F3l52OfwepvX+iA8EmCmZtmkzfrs1G4rq2DYE7GV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012969; c=relaxed/simple;
	bh=1CpV8Pq+dTxvpS5kOgSgl95UjScR/p4ui1fxOCWSrAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5JZZcEUE/2LqAndfyzNCY4GEb32QSfOUR55CeJUchoFk4Hd//pBHu9Q1QYfTUSXG02cmP7TZItwwYPvcVKh+TWcT/yRodHI/M0zo1Y4QRYKGXAI41jQG1PEwlgHcmtk6fespKwl2SuZH2EVCeUVYnKRVb+9rD+J0d46nkdTK6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQTghXyW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQTghXyW"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3306d93e562so992731a91.1
        for <selinux@vger.kernel.org>; Thu, 09 Oct 2025 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760012967; x=1760617767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPKPJ6m3MhrFIxesD7EVLLvafL4PHHUFLmBsJYfhNxQ=;
        b=UQTghXyWriygWrkQdU+8SdPkuoESOfEOhLkdVfpNFjqJDOCAwMAqbRK7obfCNWDFSE
         NhJhF9cVgHmlgnFdk1se1taJaDPKpSf0+Mlj3WBKmuI5ltWMXArhKaFv8wYCywK/Rjr1
         EfZP8UkSNLozCtVYwu8v8HnEIFpa/Se/ac7N8ty1lzuH6uBzRfc3bgMJov/pooRqHh6i
         aFnrG7laOZl9JXTAix/NKTxdqdqd7qyU64jnHgu4k8TRIYdOGI7fQ8R/cOwFMxz2U/SE
         5qegRn/gCk6AEF8TWyvXOmj4LbdblluduOBLhmd58KwKjteNeXilcjc+N2CblPjH/k+D
         wdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012967; x=1760617767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPKPJ6m3MhrFIxesD7EVLLvafL4PHHUFLmBsJYfhNxQ=;
        b=h6hgsHpp2hN/3OZIWPkUD+5T71HCWE+iBns8EbbfVAEid7vtDYpRRMKfRTwFDWMsKO
         JDSKay9SDn+eXTQKRkCfctCMIXodnA4Wc7tn6S49Ymu8hRGJRHhHorsh5UK8EkA8GhWL
         8ujGSQ04KZoSP7VlQFJCwW5eYaacv9gM3pa38L8cuvzQI1kn2pRlEQW1+3OJzsGTuC/q
         tqXMups51KtoiIhyhwU4Vs0CQ6PSJWcBXt8Gpv2ehJHIfVoWzThaTx0+ikdHo8JpEqP6
         A6Hyj3hM2DeseZeRJBoXc5hZ7itXerw3bGbmmKKpXTA3MJydj2FtK6TL8wKbID8+5XGX
         5ryw==
X-Gm-Message-State: AOJu0YxRGYeDw4aIMO3AqjU3utsrKCblughEiDtryn3ynwBcBtoAVjoe
	gydSy26CS2/mItiOjPjbM9PsYWgRMFO+UhAX8Iu0gRynQLX+P4j5g2kAlv93Mp90Cth2X8s16ZI
	Ktl4Khkj6XogAW4wUSkiWUaAhmngP7mM=
X-Gm-Gg: ASbGncsjiIVFLbj/R3eZhtwJLaQQ5lNRdv9l50ccQxEjU8Xtgdl+4TDK5FdHV1nElzV
	nM2KE6lInUGW9GX/uAiMvPsDc+9Q1Hp+vCLvINGmGPeksoJdsJW9XvdgBQBNAP4qTDQltRQYd/Y
	zTknPcHATWZljqtVYaZYg2DCFmRnU67++8XFGY1SPeiZSR+RUzCQVl0QGxibKR5NbU3RpuFvTbH
	lKE9DYfsGwVrZowHfSg57rDwC7kzlbfMSx3Qqpagg==
X-Google-Smtp-Source: AGHT+IE3RFkEj1+CyfigVmyUaFkcObu7qhppkxEwYcJVbBpOUKd8Kb/X9GpqYppr+ETOWMiqbS8YHm+cu5azNz8rAvE=
X-Received: by 2002:a17:90b:4a84:b0:32b:96fa:5f46 with SMTP id
 98e67ed59e1d1-33b51148aa0mr9714899a91.5.1760012966645; Thu, 09 Oct 2025
 05:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008143612.96917-3-stephen.smalley.work@gmail.com> <CAFqZXNseFBS+u_ZVDZZ0Rqd+aMJrpUOftBUu_QJ+f1Sb2w0hPw@mail.gmail.com>
In-Reply-To: <CAFqZXNseFBS+u_ZVDZZ0Rqd+aMJrpUOftBUu_QJ+f1Sb2w0hPw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Oct 2025 08:29:15 -0400
X-Gm-Features: AS18NWAS54KS0U46wVpilfWfv77S_y7DRhky-CBIM_8Tuqm5EcEh8t2xmOGr2-8
Message-ID: <CAEjxPJ5Z9EQNGqeNdyaAH-m3yu6w=ucg1gBUCOn6V=9k3crwcQ@mail.gmail.com>
Subject: Re: [PATCH v4] selinux-testsuite: Add btrfs support for filesystem tests
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 3:03=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> On Wed, Oct 8, 2025 at 4:40=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: Richard Haines <richard_c_haines@btinternet.com>
> >
> > This allows btrfs filesystems to be created to support the
> > filesystem mount(2) type calls and the fs_filesystem fsmount(2)
> > type calls.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v4 drops the mkfs size for btrfs to 128M since it doesn't require
> > 300M, unlike xfs.
> >
> > v3 was just a re-base of Richard Haines' earlier patch which
> > ended at v2.
>
> Hm... indeed this passes in the CI now. I had recently rebased my
> older branch with Richard's patch and it failed for a reason I wasn't
> able to determine. The only significant difference I had was $mk_size
> =3D 115000; instead of your 128 (not sure if that was in the original
> patch or if I was just trying things out...), so maybe that was it.

I should have mentioned that in my changelog - the original patch from
Richard was based on an older version of Filesystem.pm where the dd
command was invoked with a block size of 4096 but this was
subsequently changed upstream to a block size of 1M, and his patch set
the count to 28000 based on a minimum btrfs partition size of 115M. I
likewise was trying different count values to get it to work but
stderr is redirected to /dev/null for the mkfs command in
Filesystem.pm to avoid noise in the output which made it hard to
debug. I ultimately found that a count of 109 would work (109MiB =3D
114294784 bytes =3D the reported min size from mkfs.btrfs) but Paul
suggested bumping to 128 just to provide some future proofing.

> Looks good to me except for two minor points below.

Ok, v5 coming up.

>
> >
> >  README.md                      | 2 ++
> >  defconfig                      | 5 +++++
> >  tests/Makefile                 | 2 +-
> >  tests/filesystem/Filesystem.pm | 3 +++
> >  tests/filesystem/btrfs         | 1 +
> >  tests/filesystem/test          | 6 ++++++
> >  tests/fs_filesystem/btrfs      | 1 +
> >  tests/fs_filesystem/test       | 6 ++++++
> >  8 files changed, 25 insertions(+), 1 deletion(-)
> >  create mode 120000 tests/filesystem/btrfs
> >  create mode 120000 tests/fs_filesystem/btrfs
> >
> > diff --git a/README.md b/README.md
> > index f067eeb..973028e 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -61,6 +61,7 @@ similar dependencies):
> >  * e2fsprogs _(used by the ext4 filesystem tests)_
> >  * jfsutils _(used by the jfs filesystem tests)_
> >  * dosfstools _(used by the vfat filesystem tests)_
> > +* btrfs-progs _(used by the btrfs filesystem tests)_
> >  * nftables _(used by inet_socket and sctp tests if ver >=3D 9.3 for se=
cmark testing )_
> >  * rdma-core-devel _(to build the `ibpkey` test program)_
> >
> > @@ -136,6 +137,7 @@ command:
> >                 e2fsprogs \
> >                 jfsutils \
> >                 dosfstools \
> > +               btrfs-progs \
> >                 nftables \
> >                 netlabel-tools \
> >                 libibverbs-dev
>
> You should add btrfs-progs also to the Fedora dnf command and also to
> the tmt/tests.fmf (under "/run" -> "require").
>
> > diff --git a/defconfig b/defconfig
> > index b2d4a90..214eb26 100644
> > --- a/defconfig
> > +++ b/defconfig
> > @@ -122,6 +122,11 @@ CONFIG_XFS_QUOTA=3Dy
> >  CONFIG_VFAT_FS=3Dm
> >  CONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"
> >
> > +
> > +# Test BTRFS filesystem.
> > +# This is not required for SELinux operation itself.
> > +CONFIG_BTRFS_FS=3Dy
> > +
> >  # watch_queue for key changes.
> >  # They are not required for SELinux operation itself.
> >  CONFIG_WATCH_QUEUE=3Dy
> > diff --git a/tests/Makefile b/tests/Makefile
> > index 903ab11..f002389 100644
> > --- a/tests/Makefile
> > +++ b/tests/Makefile
> > @@ -4,7 +4,7 @@ SBINDIR ?=3D $(PREFIX)/sbin
> >  POLDEV ?=3D $(PREFIX)/share/selinux/devel
> >  INCLUDEDIR ?=3D $(PREFIX)/include
> >  SELINUXFS ?=3D /sys/fs/selinux
> > -FILESYSTEMS ?=3D ext4 xfs jfs vfat
> > +FILESYSTEMS ?=3D ext4 xfs jfs vfat btrfs
> >
> >  export CFLAGS+=3D-g -O0 -Wall -D_GNU_SOURCE
> >
> > diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesyst=
em.pm
> > index f169464..d5c68e6 100644
> > --- a/tests/filesystem/Filesystem.pm
> > +++ b/tests/filesystem/Filesystem.pm
> > @@ -123,6 +123,9 @@ sub attach_dev {
> >  sub make_fs {
> >      my ( $mk_type, $mk_dev, $mk_dir, $mk_opts ) =3D @_;
> >      my $mk_size =3D 16;
> > +    if ( $mk_type eq "btrfs" ) {
> > +        $mk_size =3D 128;
> > +    }
> >      if ( $mk_type eq "xfs" ) {
> >          $mk_size =3D 300;
> >      }
>
> I'd prefer if-elsif here (no need to test for "xfs" when "btrfs"
> matches) and maybe have the "btrfs" check below the "xfs" one (but
> that's less important).
>
> > diff --git a/tests/filesystem/btrfs b/tests/filesystem/btrfs
> > new file mode 120000
> > index 0000000..945c9b4
> > --- /dev/null
> > +++ b/tests/filesystem/btrfs
> > @@ -0,0 +1 @@
> > +.
> > \ No newline at end of file
> > diff --git a/tests/filesystem/test b/tests/filesystem/test
> > index a7d8b24..56f116a 100755
> > --- a/tests/filesystem/test
> > +++ b/tests/filesystem/test
> > @@ -89,6 +89,12 @@ BEGIN {
> >          $test_count   =3D 55;
> >          $quota_checks =3D 0;
> >      }
> > +
> > +    # BTRFS uses internal quotas requiring no security hooks
> > +    elsif ( $fs_type eq "btrfs" ) {
> > +        $test_count   =3D 55;
> > +        $quota_checks =3D 0;
> > +    }
> >      else {
> >          $test_count =3D 69;
> >      }
> > diff --git a/tests/fs_filesystem/btrfs b/tests/fs_filesystem/btrfs
> > new file mode 120000
> > index 0000000..945c9b4
> > --- /dev/null
> > +++ b/tests/fs_filesystem/btrfs
> > @@ -0,0 +1 @@
> > +.
> > \ No newline at end of file
> > diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
> > index 9af8971..1d04bbc 100755
> > --- a/tests/fs_filesystem/test
> > +++ b/tests/fs_filesystem/test
> > @@ -92,6 +92,12 @@ BEGIN {
> >          $test_count   =3D 54;
> >          $quota_checks =3D 0;
> >      }
> > +
> > +    # BTRFS uses internal quotas requiring no security hooks
> > +    elsif ( $fs_type eq "btrfs" ) {
> > +        $test_count   =3D 54;
> > +        $quota_checks =3D 0;
> > +    }
> >      else {
> >          $test_count =3D 68;
> >      }
> > --
> > 2.51.0
> >
>
>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
