Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5074A2D6622
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814156; cv=none; b=tHlB4yBz1HqM1lvNuKT19jHtqs4QHiwqZC7UOMn9i+8oXLYQUqI6KgIuwlbb2aO8hMHJ9BhPgPUeD8xBMpthSc8fsG7rkwJTygXZ4cxYQIXJX5gtP5mRD8CnZdg+5bRfIWvwSDbQMqiws00sNtr51//t9wCZTb4qxjQd7uuz0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814156; c=relaxed/simple;
	bh=89B4Abl22tJEBrdTy2pX7YTw6UmzFY3anY5odFWOnJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHRl8gO5jqEDZrifPkovNm6wG+znmpXmIpsnplkvzKIcKlbmWaziC476cYaPnLJOT1jmkfYGrsYgqVfCXQLVg5xFkwCvbVOhGjtQM//92YZdjyP3hJ4hwpUTYsMuYkIPIrGlbvEuqOBiCwqvX+w5Oviw8H1qZj94u/vTF6ckM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3tETIUr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3tETIUr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749814153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EIdt47eBjcvLnWSHlND9n8xbk1ns/EnbTBwvpyMDCWA=;
	b=V3tETIUrKb0ziIC/6e1EHEMJJ+AiUSfNnCpwC9OiV/wH+RMGxDm1w1UlvBQZuxy1KX4yL8
	v61NEw/lrGzDWCp4CIQQGLgWAhIlahSxYcYFCj3YcrJ5b9q9pj6J+jF0QlYSjjEsK5nIP6
	l89tIt6RfhXU2uffjmW9uD0XLpepeMA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-LaX34PbjOAONN_l1wQno3Q-1; Fri, 13 Jun 2025 07:29:11 -0400
X-MC-Unique: LaX34PbjOAONN_l1wQno3Q-1
X-Mimecast-MFC-AGG-ID: LaX34PbjOAONN_l1wQno3Q_1749814151
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313d6d671ffso1084563a91.2
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 04:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814151; x=1750418951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIdt47eBjcvLnWSHlND9n8xbk1ns/EnbTBwvpyMDCWA=;
        b=r95S4U1w8J5I7RBK/ZkzK7EXcXtwsGJPP9FZdYO/JZcv7KjR+BiBnXC8AHUKE1NtuZ
         g5onmEQJtMW86Ld6mV1wINYYt06IVtWspkRJDC8ebKoysBymMM8NOoi9vsM1O4TWuAW+
         mHfAqsgcROF9GtB+iAmkzTC82flzalKCvCXxWrItcOXkEsPKvDHRHbSqtyMc22ELUGk1
         GmXOsivD+M7tgJHepR6WVB9xviY1RhFGsZQoAVJXINx4vMI3pglOFieTgTbFxcYYhFXH
         4lMWSAaOGeISMoh5RTXX+ebjyE3dzsFq6kEOZpZATHvKya3yvYP9bSR1kIMC9HS6TmaL
         2AQg==
X-Forwarded-Encrypted: i=1; AJvYcCUeM0KoRR2dNvJZhWmIokuawtJ54eHDvze6nlvRQZnjlg7j7eJ51Rt1RUN8H9fkGnCRTCjFIN47@vger.kernel.org
X-Gm-Message-State: AOJu0YwXo/wMygMFocU4MDzw8B+5e7t9f1OgdakjGy8iQxLyAx8ERYGN
	UYhVMWUjJ9WnSXGHV1LkUXw0ZnSCwYz/z17S0Uzql6MRUGS2ITIYySFgijIkwcBc9LFuXM1vLmF
	j69e3JollRoJVSfwMTR96sO5tpC6PjEJSD4fG9eK+wp0UwQfMmf8SgY5OPYHS6/XmrvhO1SoDFX
	fPxaz1u+kUTi13WMzZYu9kLVVDTWtZY042Sw==
X-Gm-Gg: ASbGncs/EU2hGFloqFYz6u2PLYnBG+TumEUkvH1Wg+noUzw5Y0iru19M/dTQY0ZjeKJ
	4THa8i25ppnCiMPbJjKwDiHKAMLX/SjEcqbVltsP/tpUOFNEQrqgR5+GxzBloRBEM6pvGxoxMST
	Qy8ck=
X-Received: by 2002:a17:90b:2e52:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-313d9d70403mr4671112a91.9.1749814150809;
        Fri, 13 Jun 2025 04:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx+6gYznP4zaGEAbq7BXprCUqH3evJdzLtzeuLR+4hn5ytPlI0yJuBUhxtrnKEfkI5Th71kGiYoWh4WPCX6FM=
X-Received: by 2002:a17:90b:2e52:b0:30a:4874:5397 with SMTP id
 98e67ed59e1d1-313d9d70403mr4671086a91.9.1749814150449; Fri, 13 Jun 2025
 04:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
 <CAHC9VhR5CZSHKo41C4PdXbeJ3OuZUQ3ue1cbk9kjkHA6thjH6A@mail.gmail.com>
 <CAEjxPJ7JAJ2aypxVyjw4KKAvGBvUVK6eCzbXF3Wd8huTSPiSFw@mail.gmail.com>
 <CAEjxPJ7YixhZOmHVq92EBVoXO5ZO9__YXhhyD7iAWMkQNV-xsA@mail.gmail.com>
 <CAHC9VhTunOdxp2v=27sAxTjQc558nwnQCT=86WR5TNP3ihSdfQ@mail.gmail.com> <CAEjxPJ4MS4S+O3vj+mMuKkCVx53hnt91=2ZNPiP4eY9fKDyO8Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4MS4S+O3vj+mMuKkCVx53hnt91=2ZNPiP4eY9fKDyO8Q@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 13 Jun 2025 13:28:59 +0200
X-Gm-Features: AX0GCFs7F8fX_SKUWwdfiOcGKFiYcrxya8-7Lo7qOB0XmsSWWXTojWlu3T0npNw
Message-ID: <CAFqZXNtrNCHcybw4mEJZ6AZHGzTjtrf4LnBM6wZNVdpjqec-pw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 2:25=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 11, 2025 at 4:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Wed, Jun 11, 2025 at 3:34=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Jun 11, 2025 at 3:25=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Wed, Jun 11, 2025 at 3:23=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > >
> > > > > On Wed, Jun 11, 2025 at 2:34=E2=80=AFPM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > On F42, iptables and ip6tables are no longer provided; check
> > > > > > to see if iptables-legacy and ip6tables-legacy exist and use
> > > > > > those instead if so.
> > > > > >
> > > > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > > ---
> > > > > >  tests/inet_socket/iptables-flush | 20 +++++++++---
> > > > > >  tests/inet_socket/iptables-load  | 52 ++++++++++++++++++++----=
--------
> > > > > >  2 files changed, 48 insertions(+), 24 deletions(-)
> > > > >
> > > > > It's been a while since I hit, and worked around, this on my Rawh=
ide
> > > > > systems, but if I recall correctly, fixing the problem was a matt=
er of
> > > > > installing the iptables-legacy package and perhaps ensuring that =
the
> > > > > "alternatives" config was set to point to the iptables-nft
> > > > > implementation:
> > > > >
> > > > >   %  rpm -q iptables-legacy
> > > > >   iptables-legacy-1.8.11-10.fc43.x86_64
> > > > >   % alternatives --display iptables
> > > > >   iptables - status is auto.
> > > > >   link currently points to /usr/bin/iptables-nft
> > > > >   ...
> > > > >
> > > > > FWIW, I think there is value in testing with the iptables-nft
> > > > > implementation simply so we can test the new code paths.
> > > >
> > > > Ok, I had iptables-legacy but not alternatives set. We might want t=
o
> > > > note this in the README.md file.
> > >
> > > Actually, I had alternatives set to iptables-legacy but no
> > > /usr/sbin/iptables or /usr/sbin/ip6tables symlinks for some reason.
> >
> > It's been too long since I fixed this, maybe I setup the symlinks manua=
lly?
> >
> > %  ls -l /usr/sbin/ip*tables
> > ... /usr/sbin/ip6tables -> /etc/alternatives/ip6tables
> > ... /usr/sbin/iptables -> /etc/alternatives/iptables
> >
> > > Switching alternatives to iptables-nft causes failures during the
> > > tests due to "Extension SECMARK revision 0 not supported", so I think
> > > it has to use iptables-legacy?
> >
> > I just ran the selinux-testsuite again on my Rawhide system and didn't
> > see any failures in the inet_socket tests ...
> >
> > % make test
> > ...
> > Running as user root with context unconfined_u:unconfined_r:unconfined_=
t
> >
> > domain_trans/test ........... ok
> > entrypoint/test ............. ok
> > execshare/test .............. ok
> > exectrace/test .............. ok
> > execute_no_trans/test ....... ok
> > fdreceive/test .............. ok
> > inherit/test ................ ok
> > link/test ................... ok
> > mkdir/test .................. ok
> > msg/test .................... ok
> > open/test ................... ok
> > ptrace/test ................. ok
> > readlink/test ............... ok
> > relabel/test ................ ok
> > rename/test ................. ok
> > rxdir/test .................. ok
> > sem/test .................... ok
> > setattr/test ................ ok
> > setnice/test ................ ok
> > shm/test .................... ok
> > sigkill/test ................ ok
> > stat/test ................... ok
> > sysctl/test ................. ok
> > task_create/test ............ ok
> > task_setnice/test ........... ok
> > task_setscheduler/test ...... ok
> > task_getscheduler/test ...... ok
> > task_getsid/test ............ ok
> > task_getpgid/test ........... ok
> > task_setpgid/test ........... ok
> > file/test ................... ok
> > ioctl/test .................. ok
> > capable_file/test ........... ok
> > capable_net/test ............ ok
> > capable_sys/test ............ ok
> > dyntrans/test ............... ok
> > dyntrace/test ............... ok
> > bounds/test ................. ok
> > nnp_nosuid/test ............. ok
> > mmap/test ................... ok
> > unix_socket/test ............ ok
> > inet_socket/tcp/test ........ ok
> > inet_socket/udp/test ........ ok
> > overlay/test ................ ok
> > checkreqprot/test ........... ok
> > mqueue/test ................. ok
> > mac_admin/test .............. ok
> > atsecure/test ............... ok
> > infiniband_endport/test ..... skipped: test not configured
> > infiniband_pkey/test ........ skipped: test not configured
> > cap_userns/test ............. ok
> > extended_socket_class/test .. ok
> > sctp/test ................... ok
> > netlink_socket/test ......... ok
> > prlimit/test ................ ok
> > binder/test ................. ok
> > bpf/test .................... ok
> > keys/test ................... ok
> > key_socket/test ............. ok
> > glblub/test ................. ok
> > cgroupfs_label/test ......... ok
> > notify/test ................. ok
> > module_load/test ............ ok
> > tun_tap/test ................ ok
> > perf_event/test ............. ok
> > filesystem/ext4/test ........ ok
> > filesystem/xfs/test ......... ok
> > filesystem/jfs/test ......... ok
> > filesystem/vfat/test ........ ok
> > fs_filesystem/ext4/test ..... ok
> > fs_filesystem/xfs/test ...... ok
> > fs_filesystem/jfs/test ...... ok
> > fs_filesystem/vfat/test ..... ok
> > watchkey/test ............... ok
> > userfaultfd/test ............ ok
> > vsock_socket/test ........... ok
> > secretmem/test .............. ok
> > inet_socket/mptcp/test ...... ok
> > All tests successful.
> > Files=3D78, Tests=3D1427, 241 wallclock secs ( 0.35 usr  0.11 sys +  5.=
90 cusr 17.75
> > csys =3D 24.11 CPU)
> > Result: PASS
> >
> > The kernel-secnext testing doesn't show any failures either, although
> > I likely applied the same fix to that test VM as well.
> >
> > https://groups.google.com/g/kernel-secnext/c/w-oPYY1-HLo
>
> $ sudo alternatives --set iptables /usr/bin/iptables-nft
> $ sudo make test
> ...
> inet_socket/tcp/test ........ 23/34 Warning: Extension tcp revision 0
> not supported, missing kernel module?
> Warning: Extension state revision 0 not supported, missing kernel module?
> iptables v1.8.11 (nf_tables):  RULE_APPEND failed (No such file or
> directory): rule in chain INPUT
> Warning: Extension SECMARK revision 0 not supported, missing kernel modul=
e?
> <repeats for each invocation of iptables-nft>
> ...
> Result: FAIL
>
> $ sudo alternatives --set iptables /usr/bin/iptables-legacy
> $ sudo make test
> ...
> Result: PASS

On my end, the testsuite passes with both iptables-legacy and
iptables-nft on Rawhide (with stock Fedora kernel). Also the
alternatives symlinks are created automatically on package
installation. It looks like you had some weird issue with the symlinks
and perhaps some missing config options in the kernel.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

