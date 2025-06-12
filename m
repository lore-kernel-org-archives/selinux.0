Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7CE2343C2
	for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731131; cv=none; b=M7Z1Vw9KOgkFXDOW7i7e9mTWG4mBvC+2VbotbVq6I6kdTq108ZCVGUUgFQDBqyzQ5/4G8KVBJFSKxRcD8ik92gh0YbkOatQYRmoJskYXneFbect0wxFJckRQk5sVtVXvVG8PdrBBq9dqJGiChMCPhhMYsmQaj8L30ujRnqdSGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731131; c=relaxed/simple;
	bh=Rijk9GGqZjkuCBEuLsiV8f7QZRhnLeWg9EubIvxZVsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjxrUp1w+fUDURD2MJQBQrgPENhKdSnucsMxmDQmbWejZ2tZZR9kP7k9nWbXpZqriTEVVYeQ71aqlqgqmCVCSvnUWaD9Hg2VdqiU1fkWse7RVSnil7dLw4ViGgmhcOz99DovYr3FQT/0IvoI4SZIfttQzl5aFLNucKipCrj44Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhsPXRGS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhsPXRGS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2363616a1a6so7733065ad.3
        for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 05:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749731128; x=1750335928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ofgQdEudBo/3IEPVTA5plVQxs2K7AvEtogQuNKtgWk=;
        b=HhsPXRGS9ao/81DktF/c/SQlGqEE8lgKENzS6Tzz3yqgXaRDImzsIXCeH8Cw0Nsg91
         l5Y2WPIIwZlefKZrbz3/KkwsmzCv1JNUCnfcIoVk7nGNejl4IxWGo7ztm0bz3V8J4ojO
         SYUKTxFL2vBVM/32+tGl1JTXML4VE08I7yT28NTj7PBdA9Bv4qn2TtYuWuquEXD+GBEe
         V7CxE7i2aILWInPsLIC11l+HyYtnE23F+beJAQIpDu9s/8O0WoX/pBB/yTuq+CGSB0uN
         NnwUEvQq5P8CvF2Qx0sPpzMTgHCd6lwDhqOzpKM7y+dM0MOqInXWSwTWmDKN5XEWA4aM
         uytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749731128; x=1750335928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ofgQdEudBo/3IEPVTA5plVQxs2K7AvEtogQuNKtgWk=;
        b=OacRZEA/IV7fMNPsSbj92Uevep6coNXsPxzzD8gufwfH3hA8u9zguM71GNN39ezpXO
         mFe7PgBCzUkRqPMUqkeY2WFQnCZRwPpUyNrm4GprbWA6kkacGTYRf+YwbcNi7nyqR2Y+
         LNpmhaJnRLSdCoFUHl2Uzj+UGsXOuyYb+gJyU6l+75Slx9LSCOX4JOlpeqZHWNO3Dzlc
         Dg6yUgpcmLz3+9XZ0W/GR+vvh0iA0RK4KWP49oQDr0MPfI6v0cJyIsiF7evRpwQXGaEq
         axyI2flvcJXZGqhs0BALqmU6X6og6M7FxBFwZU9sJymzbB9VmNLdn1sTfziz6ZA1S887
         X44g==
X-Gm-Message-State: AOJu0YyRiIekmxEBtNPQhCCezwKawcMh31a04f0GD7BXT61ARynItK9p
	nUQU+ZeLk/YSmaNOCISJ4mvMZTQ5/KoZEjXfaeuA/+wrUnUTkklcDXhx6xuSjILXhGbpWORCWtR
	gjGvW+Mh13hiViW/FEzPx1DEa8gV9ghQt75vh
X-Gm-Gg: ASbGncuPD/E3mrusBxRNp++xqBOJmkZfN06hnn65XezAGDgBxm+Y2lQ/2aQpwDXbKG2
	32Kue4r+20ie1XBGdbJWOMsZO7EDKE11kheZyA1vBmKM6zkQqW24CirGcYDZad3B8jPZCIKEAmT
	qEyIixzJR5uew+gOTQsLCQIwovuFxwe60AFUlYA7TCy+o=
X-Google-Smtp-Source: AGHT+IENJ37ffel59e4hAmGKq25p3Ie4k33Cr+ZHYL0HTTCr9T02gBAvuCNlTTPuA2z4nUyGXEQfPfcrMIMDrl0J4go=
X-Received: by 2002:a17:90b:3d87:b0:312:ffdc:42b2 with SMTP id
 98e67ed59e1d1-313c08c8c51mr3178440a91.23.1749731128267; Thu, 12 Jun 2025
 05:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
 <CAHC9VhR5CZSHKo41C4PdXbeJ3OuZUQ3ue1cbk9kjkHA6thjH6A@mail.gmail.com>
 <CAEjxPJ7JAJ2aypxVyjw4KKAvGBvUVK6eCzbXF3Wd8huTSPiSFw@mail.gmail.com>
 <CAEjxPJ7YixhZOmHVq92EBVoXO5ZO9__YXhhyD7iAWMkQNV-xsA@mail.gmail.com> <CAHC9VhTunOdxp2v=27sAxTjQc558nwnQCT=86WR5TNP3ihSdfQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTunOdxp2v=27sAxTjQc558nwnQCT=86WR5TNP3ihSdfQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Jun 2025 08:25:17 -0400
X-Gm-Features: AX0GCFufBS4g6UXvEmrRptqyRQNoQOrFT_m-2H95Jv_arscClCx6xX4fxL1MDzE
Message-ID: <CAEjxPJ4MS4S+O3vj+mMuKkCVx53hnt91=2ZNPiP4eY9fKDyO8Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 4:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jun 11, 2025 at 3:34=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Jun 11, 2025 at 3:25=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Jun 11, 2025 at 3:23=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > On Wed, Jun 11, 2025 at 2:34=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On F42, iptables and ip6tables are no longer provided; check
> > > > > to see if iptables-legacy and ip6tables-legacy exist and use
> > > > > those instead if so.
> > > > >
> > > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > ---
> > > > >  tests/inet_socket/iptables-flush | 20 +++++++++---
> > > > >  tests/inet_socket/iptables-load  | 52 ++++++++++++++++++++------=
------
> > > > >  2 files changed, 48 insertions(+), 24 deletions(-)
> > > >
> > > > It's been a while since I hit, and worked around, this on my Rawhid=
e
> > > > systems, but if I recall correctly, fixing the problem was a matter=
 of
> > > > installing the iptables-legacy package and perhaps ensuring that th=
e
> > > > "alternatives" config was set to point to the iptables-nft
> > > > implementation:
> > > >
> > > >   %  rpm -q iptables-legacy
> > > >   iptables-legacy-1.8.11-10.fc43.x86_64
> > > >   % alternatives --display iptables
> > > >   iptables - status is auto.
> > > >   link currently points to /usr/bin/iptables-nft
> > > >   ...
> > > >
> > > > FWIW, I think there is value in testing with the iptables-nft
> > > > implementation simply so we can test the new code paths.
> > >
> > > Ok, I had iptables-legacy but not alternatives set. We might want to
> > > note this in the README.md file.
> >
> > Actually, I had alternatives set to iptables-legacy but no
> > /usr/sbin/iptables or /usr/sbin/ip6tables symlinks for some reason.
>
> It's been too long since I fixed this, maybe I setup the symlinks manuall=
y?
>
> %  ls -l /usr/sbin/ip*tables
> ... /usr/sbin/ip6tables -> /etc/alternatives/ip6tables
> ... /usr/sbin/iptables -> /etc/alternatives/iptables
>
> > Switching alternatives to iptables-nft causes failures during the
> > tests due to "Extension SECMARK revision 0 not supported", so I think
> > it has to use iptables-legacy?
>
> I just ran the selinux-testsuite again on my Rawhide system and didn't
> see any failures in the inet_socket tests ...
>
> % make test
> ...
> Running as user root with context unconfined_u:unconfined_r:unconfined_t
>
> domain_trans/test ........... ok
> entrypoint/test ............. ok
> execshare/test .............. ok
> exectrace/test .............. ok
> execute_no_trans/test ....... ok
> fdreceive/test .............. ok
> inherit/test ................ ok
> link/test ................... ok
> mkdir/test .................. ok
> msg/test .................... ok
> open/test ................... ok
> ptrace/test ................. ok
> readlink/test ............... ok
> relabel/test ................ ok
> rename/test ................. ok
> rxdir/test .................. ok
> sem/test .................... ok
> setattr/test ................ ok
> setnice/test ................ ok
> shm/test .................... ok
> sigkill/test ................ ok
> stat/test ................... ok
> sysctl/test ................. ok
> task_create/test ............ ok
> task_setnice/test ........... ok
> task_setscheduler/test ...... ok
> task_getscheduler/test ...... ok
> task_getsid/test ............ ok
> task_getpgid/test ........... ok
> task_setpgid/test ........... ok
> file/test ................... ok
> ioctl/test .................. ok
> capable_file/test ........... ok
> capable_net/test ............ ok
> capable_sys/test ............ ok
> dyntrans/test ............... ok
> dyntrace/test ............... ok
> bounds/test ................. ok
> nnp_nosuid/test ............. ok
> mmap/test ................... ok
> unix_socket/test ............ ok
> inet_socket/tcp/test ........ ok
> inet_socket/udp/test ........ ok
> overlay/test ................ ok
> checkreqprot/test ........... ok
> mqueue/test ................. ok
> mac_admin/test .............. ok
> atsecure/test ............... ok
> infiniband_endport/test ..... skipped: test not configured
> infiniband_pkey/test ........ skipped: test not configured
> cap_userns/test ............. ok
> extended_socket_class/test .. ok
> sctp/test ................... ok
> netlink_socket/test ......... ok
> prlimit/test ................ ok
> binder/test ................. ok
> bpf/test .................... ok
> keys/test ................... ok
> key_socket/test ............. ok
> glblub/test ................. ok
> cgroupfs_label/test ......... ok
> notify/test ................. ok
> module_load/test ............ ok
> tun_tap/test ................ ok
> perf_event/test ............. ok
> filesystem/ext4/test ........ ok
> filesystem/xfs/test ......... ok
> filesystem/jfs/test ......... ok
> filesystem/vfat/test ........ ok
> fs_filesystem/ext4/test ..... ok
> fs_filesystem/xfs/test ...... ok
> fs_filesystem/jfs/test ...... ok
> fs_filesystem/vfat/test ..... ok
> watchkey/test ............... ok
> userfaultfd/test ............ ok
> vsock_socket/test ........... ok
> secretmem/test .............. ok
> inet_socket/mptcp/test ...... ok
> All tests successful.
> Files=3D78, Tests=3D1427, 241 wallclock secs ( 0.35 usr  0.11 sys +  5.90=
 cusr 17.75
> csys =3D 24.11 CPU)
> Result: PASS
>
> The kernel-secnext testing doesn't show any failures either, although
> I likely applied the same fix to that test VM as well.
>
> https://groups.google.com/g/kernel-secnext/c/w-oPYY1-HLo

$ sudo alternatives --set iptables /usr/bin/iptables-nft
$ sudo make test
...
inet_socket/tcp/test ........ 23/34 Warning: Extension tcp revision 0
not supported, missing kernel module?
Warning: Extension state revision 0 not supported, missing kernel module?
iptables v1.8.11 (nf_tables):  RULE_APPEND failed (No such file or
directory): rule in chain INPUT
Warning: Extension SECMARK revision 0 not supported, missing kernel module?
<repeats for each invocation of iptables-nft>
...
Result: FAIL

$ sudo alternatives --set iptables /usr/bin/iptables-legacy
$ sudo make test
...
Result: PASS

> > On a different but related note, wondering how long we even want to
> > retain these tests and the corresponding config options in the
> > testsuite defconfig fragment. Ditto for some other config options
> > there that aren't commonly enabled anymore or may be blocked before
> > too long e.g. SHA1.
>
> As long as the upstream kernel supports the functionality we should
> retain the tests.  Some tests we might even want to retain longer in a
> dedicated branch for those doing distro testing, or we just leave that
> as an exercise for the distro.
>
> I'm more concerned about the new things that are coming up which we
> may not be adequately testing in the current selinux-testsuite.  A
> perfect example is nft; we're using iptables-nft, but should we also
> have a dedicated set of nft tests?

We already do, see inet_socket/test and inet_socket/nftables-load/flush.
