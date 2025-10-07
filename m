Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714261D95A3
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864487; cv=none; b=nGXXJBxyIcpSvgUherv5RI965Q/HuSGzqkTYPTHRd3uLmEijsMGvkCj8T2frij1z25mXVhyuEyaJwSCSGGlxXjSgw3Tol12iO6uCmwcET9FpKPeY6AOm+cRNUI/m69SvcD/OfNtaYEZKTQCQsv+MhM0Y1Z5s171f/5lXE+1L/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864487; c=relaxed/simple;
	bh=ied09BNLTt7NNc+1Jcck8svK1bR0cSco8R3YoH2u75g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFwDxnvLqAjtkZahyFd2wenIYJojOxUhs+PUv9/7MovHr0jNA+iX+Ig0LB6AAT94sfVJkd1N5ZyCTevWgAlaRXP7HWQKZ/iT5W5zNq70Ja+lTXFUN5uZPlzPCh0VkJDZ42PgMQLaBbfq+9susrZQeEyU+/HvwwtBksgrhaPuvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfAf1mj1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfAf1mj1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27d3540a43fso69550215ad.3
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759864484; x=1760469284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgd4KZUGOlDz3rB/lStVV3c+sYIrmTy/OCXKbn1THpE=;
        b=mfAf1mj1+428b7QYZuhysQfoMh+lBiXZGaY3ZtrfMRpb3nSRnTGSxgza+lJC5QhWfq
         PcESP79LrCMrPippaGfIWUf11HcmggSk9ttjOOwxr5hIQXzP+Z/zrdI9+GAomIPGiS0D
         jZVfdP1+gqDbv8CVEsX/b6B0ktQCzkn91m6xIoli1vVySAjxt20KyPa1mQkqLO4iJRgU
         SGIuuxej0GFMyr9B5QfyzkalurDXoY56AEPBtip+R0J2WHwLuDxL+dkI1RZjmCcb0JRS
         T1WKy3MOLJHPJ31HLK9qilgQYr7I4ycmy2xQReqRjoO4oH8r8Qq0qNfGU9KSbowjbmHk
         f3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759864484; x=1760469284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fgd4KZUGOlDz3rB/lStVV3c+sYIrmTy/OCXKbn1THpE=;
        b=xQY9EAvF80QojVTO6tiyCKpPt4Ti/PffZmkyqBnGTdzP6ilC3Bm30yPKUndF7A76ds
         aI8yhpmICIWfGn4hMVqsnq6aWHr9owavkNEqjhME7oSlLb4CXRmWJwocp8VfV9BY9tKj
         NzcR+ReRBwrZp1R1rf7orjk9VPqFJhbBhehoSLLgN6P2y1QU93sSChhUho++QxKMLyM0
         ystLEzdYOuHD3OcJqNMZQe+Xb0amweCJMxZQLjyZmenBjTFX1C06LGdLrF++oxr0ofdR
         EYRyoAuO0qgxItQr+6lgMmoC1Y75qB7nP9TUMiWmUeKrJ1gFGOPhYSe1qhkfFNi0VoFH
         JTkQ==
X-Gm-Message-State: AOJu0YzZlgYPoCiYnKDPG7rWSDV2r0B6oIo/LBbML1wNFOgbxbN2UOyh
	MsCf6LvymCH1rwpinmMxfC/N0dxoSIPujwYSwuK4ALRelQhc7TXLYJxfLc5hToCYENcRpPGQwr3
	Spa1zfwjwuRP6+S2wUmUHfK1KlklRB2A1T8WZ
X-Gm-Gg: ASbGncvJUB00Vhbhfi68sIevXMqRxqf7uV4OPP5LrkUgzsLXD/GSf9G5Zfd036RDeR1
	x80mvAEsNfDHNJ6ONQD2mM8g8eGGD3cAM5UHM6cPqRwbjdEI5sZrEtfOKKa2UR7gzPsfsRYBk73
	oVVhVPIfy9uqJm4IL95XOQXkRAWBHpupPPMvqEJJ+iy2DDAwr6+tmHchS/p/COBTqCrK63Bb0GF
	yCraHdsiK19E7ennwYJzHqDkAr2Eho=
X-Google-Smtp-Source: AGHT+IHYGpcm7mmtnfNvzBqem60IZgmytEoxhnqMtZGXjZnnV9hLGHMcva0kO6CfkhUgxPM+4r2z31nRpCtD0T/UtQ4=
X-Received: by 2002:a17:902:e943:b0:26c:bcb5:1573 with SMTP id
 d9443c01a7336-29027303192mr9945085ad.53.1759864484441; Tue, 07 Oct 2025
 12:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007183552.74330-2-stephen.smalley.work@gmail.com> <CAEjxPJ6gFMPFj-9im_EeencH2B4d6CfCa0TQs=5XZG4O7vBvew@mail.gmail.com>
In-Reply-To: <CAEjxPJ6gFMPFj-9im_EeencH2B4d6CfCa0TQs=5XZG4O7vBvew@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 15:14:31 -0400
X-Gm-Features: AS18NWB51w6aJ0M3je8UhtovRXCMK2r76eDdcJkNemt0TwcgsMEM9MVCbnfc1Wg
Message-ID: <CAEjxPJ6FtXxkqQEPUPMDkX+4aKV_u+oWzYRnnS9AUOOtEr_3eQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux-testsuite: Add btrfs support for filesystem tests
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:46=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Oct 7, 2025 at 2:37=E2=80=AFPM Stephen Smalley
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
>
> FYI, these tests pass cleanly for me on a current kernel.
>
> > ---
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
> > index f169464..7ea9031 100644
> > --- a/tests/filesystem/Filesystem.pm
> > +++ b/tests/filesystem/Filesystem.pm
> > @@ -123,6 +123,9 @@ sub attach_dev {
> >  sub make_fs {
> >      my ( $mk_type, $mk_dev, $mk_dir, $mk_opts ) =3D @_;
> >      my $mk_size =3D 16;
> > +    if ( $mk_type eq "btrfs" ) {
> > +        $mk_size =3D 300;

Looks like I could drop this down to 109 if we care. 109M =3D=3D 114294784
bytes is the smallest supported size reported by mkfs.btrfs. I don't
know how stable that value remains across different versions or how it
was derived.

> > +    }
> >      if ( $mk_type eq "xfs" ) {
> >          $mk_size =3D 300;
> >      }
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
