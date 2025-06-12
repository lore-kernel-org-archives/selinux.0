Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90C221F0A
	for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732113; cv=none; b=SYN4IlMSOkxegttojGP8BBD5DbUDem7BV6Fg4a/WLVsmwHKfcPBdjwAtpHi/3gaZIudoA9k7xwsjOIxww8+mi4VtshUgHvLhYTgYkI+/ninblbq8/5M9auitvIsHKF94VYZ9Gcrxi8PZqUT5mFFvfb9adblnXLMDSdwHN+/U8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732113; c=relaxed/simple;
	bh=Js2nsjFygZgFK50ndqWFGLytAKW/1kngBNKHg84Z3Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak1NdlsVAJ0nLySq/hervudp2W1TNHvAOOeJz+Ez3Q4E/twZAkoSJs5K0mVqDaZhXxL8cu5elDxa3eLjTCW9dJB2vfZHr2MlzX3L9r0KkLhPvbJPIUSc+NWIHOI8t7WC8ynoza2DeZ4UKuNvI9JOFlhvtZIq23ngekMY0Ec+n3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+dkyrq9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+dkyrq9"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2f1032e1c4so826575a12.3
        for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749732111; x=1750336911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujZJWxIFSCAlXbAGihFEzQAEOg1xetO8PCdSDmSMAy8=;
        b=L+dkyrq9NJcbitT3QVhzV1twETXOpOzrqTfitSygxnQcgbw1iks11LOIz8ERjJNq9j
         c8iOAXPUYhMp0HQxStHglGNlxhq+ab/qXtIFQ4k7uX43D/Byoa3WiP6rg/7K4aFIYeGK
         gylQbbxhDs0Tnd34fEuXmbjX9NPkiwNypDmeqD/szZg3c9O+cw2yc2PKenfnlZr9dIb9
         QGRdJ8cAnr28i4+KlH3yLO4/1KYKrezpqJ+XL4jrHZuZsJLQYUrDtIl6maxfb730OiCN
         yD5cyqJQDinxfsMptjOisxxufv8N9PR677h4ncGXqGEmXhIFjA/pualWd9gI9X2kU1dQ
         4m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749732111; x=1750336911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujZJWxIFSCAlXbAGihFEzQAEOg1xetO8PCdSDmSMAy8=;
        b=r4zcUx0EzLDTD3F77wOAlSKR++bGdJaKPyj6Lr+yG5JfzTgGctOvJqaaha6wCj4m8a
         wLG5U5ZGEp+mIdu/cNnkGQC12wJEWuZiod2kpcAk5T8IfBgdw7JMSAlLSLFWMSa0Yz7n
         R5ZK8N5ahA9NRvPtVE5eC6BhNsuECzeSwTxxK+Fjxn/kqejJUX0Cq2nB1CHRQyVlaV57
         uLemDj1BgAmONDf04JseUwjv7UCjIK2bVYQwrJNtGlrTn+lBD5OshhLZR9fBvm7xWYNO
         SZil1DXF1BkgBKuiAY6AxtAmU0abPCMJR/74MbAEZ2NCTsFliuSMZSv0fAII/RaVcSVW
         f2Og==
X-Gm-Message-State: AOJu0YxYedot/3XMMnMUCpY/vSb0/PPPeTDvKrS2xvmoGdO83vsTxPoX
	6Oz+1ZuWp/9rHiadZnVF3XVnYNqKmxLWpXHDWHioXnDOeBa8YY+qv7EXnjuRotWKXl24SVuAEbG
	l2fbQEt2Qw0v/v5a1T/rSNik2g4CSSRs=
X-Gm-Gg: ASbGncsZNhLTAPYNrvqR5+ioOgMTSJ0k1mR61UGXTLSVd0o3std/bpnwv/RnamTViAF
	g7mbDJ2R6u85m1g6QWN7P8GN+W9vb3+6QpS/6teifxPEiZo/971z35pcnnve8jK+9N4uoH9+xLg
	C0efvuII8O1IPiwysgOKlXSDc+VrbF4aFmSua+UMgqbEg=
X-Google-Smtp-Source: AGHT+IEEWeyJsVs607rbtmzRgh9oNz4PvH6K7HnKUkIFrjiBlk0fh8QJd4AQ5R4UJX8aQNjpiiD3XwPFj2eAvWOoS8s=
X-Received: by 2002:a17:90b:53c8:b0:311:f2bd:dc25 with SMTP id
 98e67ed59e1d1-313bfbf4228mr4653074a91.16.1749732111096; Thu, 12 Jun 2025
 05:41:51 -0700 (PDT)
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
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Jun 2025 08:41:39 -0400
X-Gm-Features: AX0GCFummfaZF3BPk_8SPZ_HZDUVqBJJtALb-HweYjcGAOUCAXkHkjE-kfvPRdQ
Message-ID: <CAEjxPJ5EPGULk43TrRkjXyiBHLt5A-zaC3PYyTdjAnLfkhpokw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 8:25=E2=80=AFAM Stephen Smalley
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
>
> > > On a different but related note, wondering how long we even want to
> > > retain these tests and the corresponding config options in the
> > > testsuite defconfig fragment. Ditto for some other config options
> > > there that aren't commonly enabled anymore or may be blocked before
> > > too long e.g. SHA1.
> >
> > As long as the upstream kernel supports the functionality we should
> > retain the tests.  Some tests we might even want to retain longer in a
> > dedicated branch for those doing distro testing, or we just leave that
> > as an exercise for the distro.

So the following options are reported as no longer existing on latest
kernels when I run a merge_config.sh on the testsuite defconfig, not
sure if we should prune them from the defconfig or leave for older
kernels:

Value requested for CONFIG_INET_XFRM_MODE_TRANSPORT not in final .config
Requested value:  CONFIG_INET_XFRM_MODE_TRANSPORT=3Dm
Actual value:

Value requested for CONFIG_INET6_XFRM_MODE_TRANSPORT not in final .config
Requested value:  CONFIG_INET6_XFRM_MODE_TRANSPORT=3Dm
Actual value:

Value requested for CONFIG_EXT2_FS_SECURITY not in final .config
Requested value:  CONFIG_EXT2_FS_SECURITY=3Dy
Actual value:

Value requested for CONFIG_EXT3_FS_SECURITY not in final .config
Requested value:  CONFIG_EXT3_FS_SECURITY=3Dy
Actual value:

Value requested for CONFIG_XFS_SECURITY not in final .config
Requested value:  CONFIG_XFS_SECURITY=3Dy
Actual value:

Value requested for CONFIG_JFFS2_FS_SECURITY not in final .config
Requested value:  CONFIG_JFFS2_FS_SECURITY=3Dy
Actual value:

Value requested for CONFIG_ANDROID not in final .config
Requested value:  CONFIG_ANDROID=3Dy
Actual value:

Value requested for CONFIG_KEYS_COMPAT not in final .config
Requested value:  CONFIG_KEYS_COMPAT=3Dy
Actual value:

> >
> > I'm more concerned about the new things that are coming up which we
> > may not be adequately testing in the current selinux-testsuite.  A
> > perfect example is nft; we're using iptables-nft, but should we also
> > have a dedicated set of nft tests?
>
> We already do, see inet_socket/test and inet_socket/nftables-load/flush.
