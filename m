Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D282206BE
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674624; cv=none; b=uBeLakxH3hg2/EtDQn8u/DiAa28YA8P2ieaEqqOdjL2zrp76k888BB2ZCQfXOQ5Lj0U5gnxPjbL2KWiRx79W3OMyTJrAGnZPSaxyj4hVDVJ84dxEWFnL4QxOSF8hpviGLKwhDyb+IMl/VHredIXT4iINPvwtVQNST4pFvLPoUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674624; c=relaxed/simple;
	bh=+0wMSJz7inwLLZx693m9IBiYzP5K1IHeAQ0LVfJSIMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlVVyh8pIGe8ogLwnK6uJQEHAgBDIDvkbmxWOxf2t8GrCDzTIGIoZrha98Ido28Fg1Lx6pAYT93n6yexHGKwkjViaqnjTbyubqllaxtrAtMGGk9+vsWuBNMU0ieEhUBO7zbXVwzX/cWsXkW+jkczE+wRhaqYtq2mlnn5rrK0JBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KsmJlfn0; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KsmJlfn0"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7d925ff60bso182652276.2
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749674620; x=1750279420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SajPFdhYrOQbyrr2a2aIidAt78Sx9ZRj6KKonEs77T0=;
        b=KsmJlfn0fs0BEanukIhHYToxb1k0TCqIxMh57jaLvJD/SpVCeMQR00xPk/CL07w0tX
         A55WHRmuohzx9YModVvJF/E4ddksVTr1NImUjmYx4aH08+gDpULQkTy2RTMP16Ol1MZQ
         6tPGeHwBZXxl0WTBzDHuu+O2sN7DKiWyAEIH9TLHArEFRRdl0v0hPtQqaYFQjKB1J6Vu
         OThxCktPc7lLRSexka579eGcIvpzezAq1gfjt3QQmeyM3NpJV8iWqACNl+5HHWPZmLBU
         sXWlD/IYgOHllBSEi9CNhFgd+OLtOjMxvREjLeezELrSof1KvivbrtVJtQi8FyzCWTug
         mLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749674620; x=1750279420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SajPFdhYrOQbyrr2a2aIidAt78Sx9ZRj6KKonEs77T0=;
        b=lDmsmp0ca1iBV/Um6URI/+VInNkWyuDr2jfNX2aqdyKxzNU5rjr6lv690vwV9tMhYH
         4tE7fYMbIF0c/bKLtIU7g21J4PT/E3fAsaSogu/siE06MwKrZK+u/MFB5prJjmIdHALN
         uI42qS/iYOkTnkIHWfNhMZa21iscOSMV4bfFaPG8fQYfVnUU1p+2J4kwRarZ4qxNdU97
         OGlJUUhh7lp9MmMRpaB6Mmeu7q7UBkZNJpTDwVciU0UH81135NNzGkk1/vpDtQx+KhpW
         Luvgh6NYJxRf2qA6t7lWhW4X5ex1JMjX0coW1X0+dXCxMh1alkeB5EwP+SO2KgiQbxph
         04ng==
X-Gm-Message-State: AOJu0YzzHb/kqS/tOgbh3WwxnBoNcttSmGi2jgvBUv7dATOR34CvzWgp
	ks+86iyeoSkQvOj4u/P9BHDj40FHW8SG0TVqUIXKbP64y1ktfMfCyumYsxQZ7ngizxrf3yfo7B4
	oEB7SEzUIAd/2F0yabKUHbc4PFZ5I8wxS5ER7l8aAJUh/0AMTmZ6hWg==
X-Gm-Gg: ASbGnct3qAp6PJSpQ9bvBCckIEpdUJiJIYU0RbDEyiEaNwraidUDzTMdvrUiH3UEM/G
	SMknk6Ih5oV25PWFSzC4I+ApiPGKwHLoNyz0rPhFTr4I8aTrhAzyutr8MfwOR9askaDzMYLIEgT
	5R4HWyGnArll4Kle1PaquGh6Cj5rzM5YzKtcszxl4sQ3U=
X-Google-Smtp-Source: AGHT+IEKPu82Zei0ChQ7A5M4zz5aNaAQFiPEElsYslHhoUid49Q/asuNn+g7DkTA3B9DRq17xB0D2Qk3whfOuCNGv/U=
X-Received: by 2002:a05:6902:a87:b0:e81:32c9:f9c5 with SMTP id
 3f1490d57ef6-e820b70bf48mr1405833276.30.1749674620459; Wed, 11 Jun 2025
 13:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
 <CAHC9VhR5CZSHKo41C4PdXbeJ3OuZUQ3ue1cbk9kjkHA6thjH6A@mail.gmail.com>
 <CAEjxPJ7JAJ2aypxVyjw4KKAvGBvUVK6eCzbXF3Wd8huTSPiSFw@mail.gmail.com> <CAEjxPJ7YixhZOmHVq92EBVoXO5ZO9__YXhhyD7iAWMkQNV-xsA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7YixhZOmHVq92EBVoXO5ZO9__YXhhyD7iAWMkQNV-xsA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 16:43:29 -0400
X-Gm-Features: AX0GCFvqsSscI0-kh0yP0yVBRQGwlHm7BDwtib5_qC8AvRyQ4X73OXhsNbbJ8SI
Message-ID: <CAHC9VhTunOdxp2v=27sAxTjQc558nwnQCT=86WR5TNP3ihSdfQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jun 11, 2025 at 3:25=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Jun 11, 2025 at 3:23=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > On Wed, Jun 11, 2025 at 2:34=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On F42, iptables and ip6tables are no longer provided; check
> > > > to see if iptables-legacy and ip6tables-legacy exist and use
> > > > those instead if so.
> > > >
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > > >  tests/inet_socket/iptables-flush | 20 +++++++++---
> > > >  tests/inet_socket/iptables-load  | 52 ++++++++++++++++++++--------=
----
> > > >  2 files changed, 48 insertions(+), 24 deletions(-)
> > >
> > > It's been a while since I hit, and worked around, this on my Rawhide
> > > systems, but if I recall correctly, fixing the problem was a matter o=
f
> > > installing the iptables-legacy package and perhaps ensuring that the
> > > "alternatives" config was set to point to the iptables-nft
> > > implementation:
> > >
> > >   %  rpm -q iptables-legacy
> > >   iptables-legacy-1.8.11-10.fc43.x86_64
> > >   % alternatives --display iptables
> > >   iptables - status is auto.
> > >   link currently points to /usr/bin/iptables-nft
> > >   ...
> > >
> > > FWIW, I think there is value in testing with the iptables-nft
> > > implementation simply so we can test the new code paths.
> >
> > Ok, I had iptables-legacy but not alternatives set. We might want to
> > note this in the README.md file.
>
> Actually, I had alternatives set to iptables-legacy but no
> /usr/sbin/iptables or /usr/sbin/ip6tables symlinks for some reason.

It's been too long since I fixed this, maybe I setup the symlinks manually?

%  ls -l /usr/sbin/ip*tables
... /usr/sbin/ip6tables -> /etc/alternatives/ip6tables
... /usr/sbin/iptables -> /etc/alternatives/iptables

> Switching alternatives to iptables-nft causes failures during the
> tests due to "Extension SECMARK revision 0 not supported", so I think
> it has to use iptables-legacy?

I just ran the selinux-testsuite again on my Rawhide system and didn't
see any failures in the inet_socket tests ...

% make test
...
Running as user root with context unconfined_u:unconfined_r:unconfined_t

domain_trans/test ........... ok
entrypoint/test ............. ok
execshare/test .............. ok
exectrace/test .............. ok
execute_no_trans/test ....... ok
fdreceive/test .............. ok
inherit/test ................ ok
link/test ................... ok
mkdir/test .................. ok
msg/test .................... ok
open/test ................... ok
ptrace/test ................. ok
readlink/test ............... ok
relabel/test ................ ok
rename/test ................. ok
rxdir/test .................. ok
sem/test .................... ok
setattr/test ................ ok
setnice/test ................ ok
shm/test .................... ok
sigkill/test ................ ok
stat/test ................... ok
sysctl/test ................. ok
task_create/test ............ ok
task_setnice/test ........... ok
task_setscheduler/test ...... ok
task_getscheduler/test ...... ok
task_getsid/test ............ ok
task_getpgid/test ........... ok
task_setpgid/test ........... ok
file/test ................... ok
ioctl/test .................. ok
capable_file/test ........... ok
capable_net/test ............ ok
capable_sys/test ............ ok
dyntrans/test ............... ok
dyntrace/test ............... ok
bounds/test ................. ok
nnp_nosuid/test ............. ok
mmap/test ................... ok
unix_socket/test ............ ok
inet_socket/tcp/test ........ ok
inet_socket/udp/test ........ ok
overlay/test ................ ok
checkreqprot/test ........... ok
mqueue/test ................. ok
mac_admin/test .............. ok
atsecure/test ............... ok
infiniband_endport/test ..... skipped: test not configured
infiniband_pkey/test ........ skipped: test not configured
cap_userns/test ............. ok
extended_socket_class/test .. ok
sctp/test ................... ok
netlink_socket/test ......... ok
prlimit/test ................ ok
binder/test ................. ok
bpf/test .................... ok
keys/test ................... ok
key_socket/test ............. ok
glblub/test ................. ok
cgroupfs_label/test ......... ok
notify/test ................. ok
module_load/test ............ ok
tun_tap/test ................ ok
perf_event/test ............. ok
filesystem/ext4/test ........ ok
filesystem/xfs/test ......... ok
filesystem/jfs/test ......... ok
filesystem/vfat/test ........ ok
fs_filesystem/ext4/test ..... ok
fs_filesystem/xfs/test ...... ok
fs_filesystem/jfs/test ...... ok
fs_filesystem/vfat/test ..... ok
watchkey/test ............... ok
userfaultfd/test ............ ok
vsock_socket/test ........... ok
secretmem/test .............. ok
inet_socket/mptcp/test ...... ok
All tests successful.
Files=3D78, Tests=3D1427, 241 wallclock secs ( 0.35 usr  0.11 sys +  5.90 c=
usr 17.75
csys =3D 24.11 CPU)
Result: PASS

The kernel-secnext testing doesn't show any failures either, although
I likely applied the same fix to that test VM as well.

https://groups.google.com/g/kernel-secnext/c/w-oPYY1-HLo

> On a different but related note, wondering how long we even want to
> retain these tests and the corresponding config options in the
> testsuite defconfig fragment. Ditto for some other config options
> there that aren't commonly enabled anymore or may be blocked before
> too long e.g. SHA1.

As long as the upstream kernel supports the functionality we should
retain the tests.  Some tests we might even want to retain longer in a
dedicated branch for those doing distro testing, or we just leave that
as an exercise for the distro.

I'm more concerned about the new things that are coming up which we
may not be adequately testing in the current selinux-testsuite.  A
perfect example is nft; we're using iptables-nft, but should we also
have a dedicated set of nft tests?

--=20
paul-moore.com
