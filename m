Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC133FE0E
	for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646041; cv=none; b=UKFxMy5pLG+NUmtvhMP70kBBXrVC6diUI4N90yIw7BORkwPtyOwFwRht+r9PfO9j/6okYWMNNP5MnN2aQQGvbUZnhPuwikDCvHUXoxotMx6JuoEY1IjyjZsn48YOlx27T4urcOlgggyhyIUXW4LklFnLF+pwrtisKOWrNgnTvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646041; c=relaxed/simple;
	bh=pHBpmkbX7xph+TYQirCSauqPb/xo8LZJf7QS6C1FJps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+5TmPh+8tyhEViDmFvSjY62q8RxSp4zNui8eGYUv43jh6rDh4WICi64rKscyznPfKETK9e3l9X3Bsv/Rf8dxl55t0zY5p0KOQHJKRLYw7nRwTp6/qNGAgwMYKVvrcS5Dwa+jZm2jIxcn32+YPc0TT0jFOOhwrXqG9zmULNH2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAWhVjTY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAWhVjTY"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34361025290so649516a91.1
        for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763646039; x=1764250839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHBpmkbX7xph+TYQirCSauqPb/xo8LZJf7QS6C1FJps=;
        b=QAWhVjTYu9Evj7zCdgQP8mmdXaz3RW188aUtPXvK15t24QEtzYqlbTDwORFRr106Cy
         Pw3ABulIHo9Nd86jbrOdl3tOtFQA6QP4PglezT+S8IvdfrEhQWeeRwqyCU/qFgH0BJlM
         xBKceglQBWhwlD9kB5UL5pqysesL4ol3lCN3VSCqfCId9PPX25yhdhYUnZAfIPnmcmdr
         femZPeY7Nn3Ytt2y5rYT6mVtvmsQpeZCDebGzqCKxpdAOUm8dCWMyoWh1VT86xUa6/Pu
         FOnelw9rhFVZzxPw+T6MkKSM0/9pa7RNGjPpgYTQLpvDVFUtKZBK42+hk3EAxwwIQxf3
         f+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763646039; x=1764250839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHBpmkbX7xph+TYQirCSauqPb/xo8LZJf7QS6C1FJps=;
        b=EclW3xltsP7BKVIWiRn1RUxuGt4+iyLQDv6M2y6aEf2RaLdQiPJimQwXbrcgPo5Oqg
         v3Zzit+5FwS6VepVGycS0J9+WKxpid4mxe9Juq8BwYkKwYFvGG3HGlf2HjKbmRPCuR7J
         70+OSOX3rLb7STg4oIhP+8BOkMJkF8Wx//LHJez3YfnRTDsiFu5MlOkBdDcjGqvlZEdV
         fMPiLLtlqPDt7Ves27EaAsVXWrTx3i/QQTaGAGMhBKWFwfnm6v5yu8xl5UNKqUerLxXN
         QBcpDvdfRlrLjvr4Z6CcHPXllVCXmIR4JDCH2KNa3FdSzYFTLLux+sU21mWApO9ELhSY
         L22A==
X-Gm-Message-State: AOJu0YxwHWIhJML15Dj2i13vUNHvzLH8VH3YgPbIiQ1swcALw4qDrFw2
	QGB4YYkxbXprGaMXc4+90VIx63SxvXdgvHCBgrJSoIk49mTnmbvsi3iMMHscK9xQa1oK7KY79uw
	OLeD6T1FrvUvtdSPZhfNkV/XIXC1X220vjg==
X-Gm-Gg: ASbGncv/29N84horWcJ0Pr5Lmc5DeMcqXEYFKTEra5dSBn4fBL3WTADrCpe5aCH8e0w
	/KnwaMbRTGP9YDuB7QVGK6XpWj+SbG8xcycEzms5o/s299LOs0jwz9PUSVWl1Wmk9cY4VTAFzwz
	ppAKU0Wq5DOCMoucTTQI8o0ULAYem5bJY/qOVIhQAR7UhNYmagKEj9a+jpwjLJgaReRggBsg8Fi
	rgo5v1iS7ZX0L+7P6O7Fg9Glu7EoBx258/1XM1jkPf3alS1a90uIePCL0vLFtWAR4GB4fM=
X-Google-Smtp-Source: AGHT+IGewNF/0KgP4JlW4R8lfBsRcckkSLUT7vOe9Hy+qUWeng85Iux7Lr24Yz7GBz8lcHxEQMAPBsf4u+hq3fB4IGk=
X-Received: by 2002:a17:90a:d40e:b0:341:124f:474f with SMTP id
 98e67ed59e1d1-34727c4bb4cmr3387177a91.32.1763646039200; Thu, 20 Nov 2025
 05:40:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aoskc4jnsb2ivi7mgdkhxxxahwmrblzayvu7qdtpgjjnz7u7ca@6x6bz243yu4b>
 <CAEjxPJ4xff=wfvVpnSNuydWN4k1TX6f8GtBtWmv_Fc7yKMZaUA@mail.gmail.com>
 <54p5qlyfsj5twmuacf6nqmzaandshs34uwq7vdjycpcl4okgsw@fcovtdadvhlt>
 <CAEjxPJ4Ho+BFQ2Br6ajE0wF0Ueha04Z-EK45Fb3+2VC4hEVZBA@mail.gmail.com>
 <3b54lpvwc3eoyon4jf2vrkilmu2452ydz6zve5xdfofylioost@dgfwiuenwiqa>
 <CAEjxPJ4sVqtE5FuKrO708UR3towkdc_yAD64ixPZHsazoP_g6A@mail.gmail.com>
 <b2phzphz7lox6neiphbejtydndmgnz53y4jzfzpueffmqsn5im@2to32uoex2cs>
 <CAEjxPJ6P3NMfdw4t4E0dVvLsBAE+YEmgYkS+pRqYgDfApcv6Eg@mail.gmail.com>
 <CAEjxPJ6frshipeNk+f=_LDjeVwBNjMzBxqfZtk96rquWvUBHqQ@mail.gmail.com>
 <CAEjxPJ5vdrOuHUUCQe1qZbipr767DoJ0PUHD+H_3JBviDYw=zA@mail.gmail.com> <kcbjtuxe5j5otdjn6rd2qhgszhorubq36s7z6hfrzd3oqt523r@gggubmv5kpbc>
In-Reply-To: <kcbjtuxe5j5otdjn6rd2qhgszhorubq36s7z6hfrzd3oqt523r@gggubmv5kpbc>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Nov 2025 08:40:27 -0500
X-Gm-Features: AWmQ_bnq6pP9K22qu1QjDWqkCeTs-AjFMmY3MPW7Zb9GlNiZdzxbv7Uacrn0aQo
Message-ID: <CAEjxPJ4av=1X=RhLQYpL4HsDp_SeuMvV9sTf7makBxkH7h_Bjg@mail.gmail.com>
Subject: Re: SELinux Namespace work
To: =?UTF-8?Q?Martin_Erts=C3=A5s?= <mertsas@cisco.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 3:05=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cisco.c=
om> wrote:
>
> On Wed, Nov 19, 2025 at 02:01:01PM -0500, Stephen Smalley wrote:
> > On Wed, Nov 19, 2025 at 1:41=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Nov 19, 2025 at 9:00=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > I believe the kernfs nodes for the cgroup2 files that have host lab=
els
> > > > are initially being created by the kernel before the Android policy=
 is
> > > > loaded and therefore still inherit the parent directory xattr which
> > > > was based on the host policy. Not sure if there is something furthe=
r
> > > > we can do in the kernel to avoid this. I tried moving the Android
> > > > policy load earlier (before the unsharing of the cgroup namespace) =
but
> > > > that didn't appear to help. Need to track down exactly when these
> > > > kernfs nodes are created and whether they are shared across multipl=
e
> > > > cgroup2 mounts.
> > > >
> > > > In my testing, if the host is permissive, then I see a mix of host =
and
> > > > Android labels (i.e. system_u:object_r:cgroup_t:s0 and
> > > > u:object_r:cgroup_v2:s0) but if the host is enforcing, then they ar=
e
> > > > all shown as Android labels but the ones that had the host labels w=
hen
> > > > permissive are shown as u:object_r:unlabeled:s0. This makes sense
> > > > since if the host is permissive and we are running as root (with
> > > > CAP_MAC_ADMIN), the kernel will return raw contexts/xattrs on
> > > > getxattr(2) even if they can't be mapped to a valid context in the
> > > > current policy; otherwise the kernel will return the unlabeled cont=
ext
> > > > as defined by the current policy. I found that on the host, the new
> > > > cgroup tree is visible under /sys/fs/cgroup/user.slice/user-NNNN.sl=
ice
> > > > and on the host, it is similarly a mix of cgroup_t and unlabeled_t
> > > > (unlabeled_t for the ones with Android labels since they can't be
> > > > interpreted by the host).
> > >
> > > Ok, I finally realized that if you unshare the cgroup namespace and
> > > then mount -t cgroup2 none /sys/fs/cgroup, it just mounts the
> > > subdirectory for the cgroup to which your process was already assigne=
d
> > > - it doesn't create a new one. So if you cat /proc/self/cgroup before
> > > doing the unshare -C and subsequently mount -t cgroup2 none
> > > /sys/fs/cgroup, you are getting the same subdirectory that was alread=
y
> > > set up by systemd on the host (ls -i of both directories will show th=
e
> > > same inodes). That's why the base files are all being labeled with
> > > host labels, because the directory was created on the host. To avoid
> > > this, you would need to create a new cgroup subdirectory on the host
> > > after unsharing your SELinux namespace, assign your process to that
> > > cgroup, and then unshare the cgroup namespace and mount the cgroup2
> > > filesystem IIUC.
> >
> > I've tested this as follows (NB below I am using the libselinux
> > unshareselinux utility program which handles unsharing of the SELinux
> > and mount namespaces since my kernel no longer has the
> > /sys/fs/selinux/unshare API). This still depends on the 3 kernel
> > patches to work correctly, and appears to require loading the Android
> > policy before creating the new cgroup to avoid any labeling problems
> > since the base files are populated during the mkdir itself.
> >
> > $ sudo unshareselinux bash
> > # mount -t selinuxfs none /sys/fs/selinux
> > # ./myloadpolicy ./precompiled_sepolicy
> > # id
> > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Du:r:kernel:s0
> > # mkdir /sys/fs/cgroup/android
> > # echo $$ > /sys/fs/cgroup/android/cgroup.procs
> > # unshare -C bash
> > # mount -t cgroup2 none /sys/fs/cgroup
> > # ls -Z /sys/fs/cgroup
> > u:object_r:cgroup_v2:s0 cgroup.controllers
> > u:object_r:cgroup_v2:s0 cgroup.events
> > u:object_r:cgroup_v2:s0 cgroup.freeze
> > u:object_r:cgroup_v2:s0 cgroup.kill
> > u:object_r:cgroup_v2:s0 cgroup.max.depth
> > u:object_r:cgroup_v2:s0 cgroup.max.descendants
> > u:object_r:cgroup_v2:s0 cgroup.pressure
> > u:object_r:cgroup_v2:s0 cgroup.procs
> > u:object_r:cgroup_v2:s0 cgroup.stat
> > u:object_r:cgroup_v2:s0 cgroup.stat.local
> > u:object_r:cgroup_v2:s0 cgroup.subtree_control
> > u:object_r:cgroup_v2:s0 cgroup.threads
> > u:object_r:cgroup_v2:s0 cgroup.type
> > u:object_r:cgroup_v2:s0 cpu.idle
> > u:object_r:cgroup_v2:s0 cpu.max
> > u:object_r:cgroup_v2:s0 cpu.max.burst
> > u:object_r:cgroup_v2:s0 cpu.pressure
> > u:object_r:cgroup_v2:s0 cpu.stat
> > u:object_r:cgroup_v2:s0 cpu.stat.local
> > u:object_r:cgroup_v2:s0 cpu.uclamp.max
> > u:object_r:cgroup_v2:s0 cpu.uclamp.min
> > u:object_r:cgroup_v2:s0 cpu.weight
> > u:object_r:cgroup_v2:s0 cpu.weight.nice
> > u:object_r:cgroup_v2:s0 io.pressure
> > u:object_r:cgroup_v2:s0 irq.pressure
> > u:object_r:cgroup_v2:s0 memory.current
> > u:object_r:cgroup_v2:s0 memory.events
> > u:object_r:cgroup_v2:s0 memory.events.local
> > u:object_r:cgroup_v2:s0 memory.high
> > u:object_r:cgroup_v2:s0 memory.low
> > u:object_r:cgroup_v2:s0 memory.max
> > u:object_r:cgroup_v2:s0 memory.min
> > u:object_r:cgroup_v2:s0 memory.numa_stat
> > u:object_r:cgroup_v2:s0 memory.oom.group
> > u:object_r:cgroup_v2:s0 memory.peak
> > u:object_r:cgroup_v2:s0 memory.pressure
> > u:object_r:cgroup_v2:s0 memory.reclaim
> > u:object_r:cgroup_v2:s0 memory.stat
> > u:object_r:cgroup_v2:s0 memory.swap.current
> > u:object_r:cgroup_v2:s0 memory.swap.events
> > u:object_r:cgroup_v2:s0 memory.swap.high
> > u:object_r:cgroup_v2:s0 memory.swap.max
> > u:object_r:cgroup_v2:s0 memory.swap.peak
> > u:object_r:cgroup_v2:s0 memory.zswap.current
> > u:object_r:cgroup_v2:s0 memory.zswap.max
> > u:object_r:cgroup_v2:s0 memory.zswap.writeback
> > u:object_r:cgroup_v2:s0 pids.current
> > u:object_r:cgroup_v2:s0 pids.events
> > u:object_r:cgroup_v2:s0 pids.events.local
> > u:object_r:cgroup_v2:s0 pids.max
> > u:object_r:cgroup_v2:s0 pids.peak
>
> This looks very promising. I'll try that with my setup. Unfortunately I
> can't load the selinux policy before unsharing the cgroup namespace.
> Since the android policy is split up into multiple modules, that is
> runtime mashed together to a single policy and loaded that has to be
> done by android itself. So the container runtime will do the unsharing,
> and then android will load the policy at a later time, but before
> mounting the cgroupfs.
>
> The container will be running in its own cgroup subtree, I just saw the
> exact same with and without that, so ignored that part during my
> testing. But will test that part now.

Generally there is a precompiled_sepolicy file that is loaded by the
Android init program if the hashes match between the /system and
/vendor or /odm policies (i.e. there hasn't been an upgrade of the
base Android without a corresponding upgrade of its vendor policy or
vice versa). So you could potentially load the precompiled_sepolicy up
front just to get cgroup2 labeling correct before creating the cgroup
subdirectory, then let the Android init load whatever policy it wants.
That _should_ be harmless, as long as you leave it in permissive mode
and just let the Android init set enforcing mode. Otherwise, I think
you are going to need to modify the Android policy to allow access to
the unlabeled cgroup files created on the host.
