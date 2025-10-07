Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C5215F5C
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865610; cv=none; b=A5wF34qTxpi6HJPpgmMH2fBo10vBfF4Vr4ByvLTTX5oNzVX88s9+OGmsbMNFdCmvffq+OlIJZdyGTq1W9wY6upholL812xSWRRNg7w18HYuXE4MJvRfo61RYZQ5dcHhVE8BfpbSmdUTXzsPkYm17PyGlsgCxaKhTiZFVPZGJg7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865610; c=relaxed/simple;
	bh=/5imUuhaLAC8+29xdE5G5rzLWDMITn93G/Xa5g3u4QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2c0B7pWf5BC8K+j61A3PfrtZFsZiA3dSAL6BPoqW0/WLAaRtC80r7YYVAx+iOEx32Lrm+7c+Yu6ENqFEh8I83A89nc+uaqVE0vML4bCfWyoTg3dw0/4+UvXoZ4t5ymK+NssnejTuvmEnjmRGZ+r0UgTfMZlM4BFX3w0Jkg5Lhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BJ6ifBzy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BJ6ifBzy"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so7288179a91.0
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759865608; x=1760470408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCbMjU/44Rb5LslPn8iw9xssHvBWZItWWmRbtZOK+cY=;
        b=BJ6ifBzyAfCC0zTJu0Jft0yfIxFq8Un19OIxVbt5sbXKSLVr8pXHaGD43mUUrFkhJw
         VJrAExW9ecvfm/a9gufrmipzzguJjlLyKRhirV2HaXYGQOg4IM7b2zvuThSu4alKe3OY
         A3KPucGOl9XKjc+K6VP0HWEkhZ95OTGs/YjuynkVgmeFrCQHGR/QGE3nMhy3CqnHIenW
         eM+W94o1CucCh6KaUg0Ik8AnUhOAiYlMQIoWiG1O3Z6AP7uuBmn/wid2Dou35DwSsNkh
         6dAQp3PDdd2lsjyXMs1C5tMapVC0troycPSGEcao84gMXO7GpBv2/FjekJp5g9+WRWMg
         lGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759865608; x=1760470408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCbMjU/44Rb5LslPn8iw9xssHvBWZItWWmRbtZOK+cY=;
        b=vI75vL4WBvSrjy24w+eYNVwbV2GR6+XdCwHuqRCK+FsAZDi31oOvjsAdKwiQa7wqHy
         2dlMaS7bbHi3EKeBpoByHmy8NnjHCeMLqaAZ2wPvmvUULxl1xTRGug5xSAzEhM+08aZL
         1U3UYMcZP2ALxu2Z14iQfBxsa4DMo8mSZ3+TY/1bFR2hEGWX5pwPzxDhXGRvQ58R6iC8
         nQJH2w7LeqdVpsJeP80j750XDc1DFy9PV8EbiYDvM2PhcrmNihcIb7L4mLCeD4bhtpYf
         BXLU2vJ5AWpMFcfvlrI74DtFPdAwFoU7OzIm8cyaHWIvfX7t8eyDH879W5HYJ1AF+dZm
         AETw==
X-Gm-Message-State: AOJu0YzcG46X/zj644NHFihrRayTih9V7+7Aud63IVeY+LtuBaBjEmlJ
	oK+XIJAe5uZ8UmAYftVoRpubLEhQyDZZtGF1daAOrvLp4maQP1KVsNwBfjd3gyWS2JBkYxYm+ls
	i8lwJQuU6iRWNSUMmRB5B+lGHQfrje3t4Y0+sC9UL
X-Gm-Gg: ASbGncvloBj1kieisOC7m4HcwSmS7N7jUk0ac0I5TiOuldq0+wp8N1JaHnD/Fr/PEk3
	I9xaa+Xng92NUV2euxRL7PkK+0JvjQBhPO0QNMnsgooQCGS4aVm8zSj6XgcG2tejypjq2Ay6GmE
	4YKh0hxkmwyROE26FLrbwBZSWW7ASMfDqx1S3v+oP5edcmJkpJQI0Sh3yb+KsrA5OSmo1F5j3fk
	tWgSNeXHRcxsMaUlq9YstRmpdyAywI=
X-Google-Smtp-Source: AGHT+IFk28ULwWSQOytu0w3WEYX3MYWa+P4MNwTrnl6fL//BD+SFJu8vtTP7OnuTCHnvQOp/wwlFsc2mUdllmyORLhg=
X-Received: by 2002:a17:90b:1806:b0:32b:bac7:5a41 with SMTP id
 98e67ed59e1d1-33b513eabc3mr758918a91.37.1759865608141; Tue, 07 Oct 2025
 12:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007183552.74330-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6gFMPFj-9im_EeencH2B4d6CfCa0TQs=5XZG4O7vBvew@mail.gmail.com> <CAEjxPJ6FtXxkqQEPUPMDkX+4aKV_u+oWzYRnnS9AUOOtEr_3eQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6FtXxkqQEPUPMDkX+4aKV_u+oWzYRnnS9AUOOtEr_3eQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Oct 2025 15:33:16 -0400
X-Gm-Features: AS18NWBdmcBuH4IJCWY0MiL5h1Y8r3OFng_rsJNMX2Hwpxl-AKZ_ceYB-cLF5rU
Message-ID: <CAHC9VhQ=Fegv_+_hZ=aBqgHLYmuT39JBZeY0+_JbsmgS4V5gCg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux-testsuite: Add btrfs support for filesystem tests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:14=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Oct 7, 2025 at 2:46=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Oct 7, 2025 at 2:37=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > From: Richard Haines <richard_c_haines@btinternet.com>
> > >
> > > This allows btrfs filesystems to be created to support the
> > > filesystem mount(2) type calls and the fs_filesystem fsmount(2)
> > > type calls.
> > >
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > FYI, these tests pass cleanly for me on a current kernel.
> >
> > > ---
> > >  README.md                      | 2 ++
> > >  defconfig                      | 5 +++++
> > >  tests/Makefile                 | 2 +-
> > >  tests/filesystem/Filesystem.pm | 3 +++
> > >  tests/filesystem/btrfs         | 1 +
> > >  tests/filesystem/test          | 6 ++++++
> > >  tests/fs_filesystem/btrfs      | 1 +
> > >  tests/fs_filesystem/test       | 6 ++++++
> > >  8 files changed, 25 insertions(+), 1 deletion(-)
> > >  create mode 120000 tests/filesystem/btrfs
> > >  create mode 120000 tests/fs_filesystem/btrfs

...

> > > diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesy=
stem.pm
> > > index f169464..7ea9031 100644
> > > --- a/tests/filesystem/Filesystem.pm
> > > +++ b/tests/filesystem/Filesystem.pm
> > > @@ -123,6 +123,9 @@ sub attach_dev {
> > >  sub make_fs {
> > >      my ( $mk_type, $mk_dev, $mk_dir, $mk_opts ) =3D @_;
> > >      my $mk_size =3D 16;
> > > +    if ( $mk_type eq "btrfs" ) {
> > > +        $mk_size =3D 300;
>
> Looks like I could drop this down to 109 if we care. 109M =3D=3D 11429478=
4
> bytes is the smallest supported size reported by mkfs.btrfs. I don't
> know how stable that value remains across different versions or how it
> was derived.

I'd be worried about tests failing at some point in the future if they
are running right at the limit.  Did you find 300 to be problematic in
some way, e.g. excessively slow?

Assuming the exact number is arbitrary, as long as the minimum is met,
we could always make it a little smaller while keeping it to a power
of two, e.g. 128.

--=20
paul-moore.com
