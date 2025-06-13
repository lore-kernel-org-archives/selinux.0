Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB18632E
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749820269; cv=none; b=Z+4VXP+3z0/Yhx7cASlzALGwdXMBFyHGq0wUN1EfE4L41x3AUL40Dm4I1ic71NySqYJkmsx2aJc9T3V4exGFT3lrepjhJAzPSkJFVo6U6Oce0VGZPv1TctzRZESsQwP7Z0PS8QtSuvtVl3aHI3M8OQLvOkQtdQLKvyIrGQ3FcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749820269; c=relaxed/simple;
	bh=iPRfqpKaIgoPoHndTt/gmQR8WlRSVjlaNIchDoDnKWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boQ4xOreVrMfiRUi+DTeCsT7hayPbN8Ary8Xa7nFmI4Rd1SETMnyAijp9XY+n9Fa6y1DrVPJJEe2C+ndtG/lyGRBK3HAffUTw23kF7FFqjCsc0ZOxrZdHYC7gVUiVBffFHYD5jrk1iIbfSGUo4iRrA08RlNFXmn08z9w1rwQF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpF+Fy/k; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpF+Fy/k"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-735b2699d5dso1149523a34.0
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749820267; x=1750425067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l7GaiiG+CtAXIkErTIKkvxUkSAWolfjymkjlkLqwc4=;
        b=XpF+Fy/kcjYyfrgoeW8c7OyOancygeFmfUDcACJF3Dva85UxIK/jhnM2KRlIga6cGx
         pcASX43z1uPMl6gY0pZWwo3G1jNRw2yTRdtFEhGMn66iUGHGzp6UlXhD3ow0iYf+/C4v
         ImkAixTUP2evWqHajVAqPrMZfSu84HCd5FhsaNCCtQyIdomtNLeQryzheN5Jo3V+Y9yR
         nVrLiCwxRzI7zbzAjmgbue95C3gTAhRG/gKOscgM3PJcedZQACfLMKvSE/0a8E50RO2s
         rf1H09PnYiBd3EQy/BVbfyQPcU9x5XZ94qCg80eWP3BqkJxmCjkR4AQDoEnzldnQ6Uv4
         tOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749820267; x=1750425067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l7GaiiG+CtAXIkErTIKkvxUkSAWolfjymkjlkLqwc4=;
        b=cdD8N/0fjyMNB5GQYmksc+4IMRltCi5RgBq//6pwdftcru0RaATLfnHq3xs+tbHq/T
         vrvWZEz7vRrKvqEU+OJ4MB0j637YHJ4CdmXHTvfQLYw9REqsdddx4EptJHXrnydNkBkZ
         NZ8Bk/n4+v8JydtMJgwYf6o0pmyeE1DKLi14DxBJhkcd4kwThWrnZ9ec2dZ8esuRAIEJ
         iRBI/oUu5s4wan1UAl/d2hqmOvMYBNfTlKuT/RNcZQetL4m8FMXR6D/FAhf3mYqFBd8m
         FZYAtiz4Z/R8iygTrlrclrYF3MPLqnFxM+df362dTT71hP7jMHnoOVd/BWaFizx7SRl9
         EWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8u6pZo7QBNebJ1dED3lbxFa/c1sTlOY8as80absa8+oD8fQYziqr284X2ZpuYHtJ8P7NoInP3@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ9ghjDuMEcs9PNCGjsdxLaBgEXalaL1ENz5SjMYidOhs6IKof
	VYJFCGtDIEgOrJx/DwBWd5hcu339kiwyX2vw0u5jlRyYBCkZwJsKSY615evdYoGXCdL6q4KUxnD
	DJkcgl+62WQxqbMBPimfyds22rdkqNUXDww==
X-Gm-Gg: ASbGncv4Pzqk4XzbyMbvF6fx0NTrH3MMtLKK78vQjSHUSuiqHl1xsywMz3NiSGzNkaP
	h2th1AQubiB6V+hAEg3Hi6bTJ42vPQ9nWlS6eXQFBG0BpEWn62vlXnOeO5C3/X5gryGMr6LWq3z
	JsJq9yLTTfUbMwNTMkdj5vlH31wzE8TOkiHpltij8EHMU=
X-Google-Smtp-Source: AGHT+IH8keo4FQvg+GXu0YFQcdtcNVqIZjFFxq9LVBr3xdaLxC9sFFEHyfmW9reWVbih6jpxAVebu/HJaAV1AvSdMsM=
X-Received: by 2002:a05:6a21:3946:b0:216:5f68:427b with SMTP id
 adf61e73a8af0-21facec4ab2mr4098891637.33.1749819800657; Fri, 13 Jun 2025
 06:03:20 -0700 (PDT)
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
 <CAHC9VhTunOdxp2v=27sAxTjQc558nwnQCT=86WR5TNP3ihSdfQ@mail.gmail.com>
 <CAEjxPJ4MS4S+O3vj+mMuKkCVx53hnt91=2ZNPiP4eY9fKDyO8Q@mail.gmail.com> <CAFqZXNtrNCHcybw4mEJZ6AZHGzTjtrf4LnBM6wZNVdpjqec-pw@mail.gmail.com>
In-Reply-To: <CAFqZXNtrNCHcybw4mEJZ6AZHGzTjtrf4LnBM6wZNVdpjqec-pw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Jun 2025 09:03:09 -0400
X-Gm-Features: AX0GCFuDPARPSFMa5oPEp5i88sAEnf0jo0hGCIwF5LytqOlKhqOBChXcyvGuJag
Message-ID: <CAEjxPJ4ErTOs5wRPA455cUAha22pCpvAD8joS5fZTtYaGitDZA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 7:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Thu, Jun 12, 2025 at 2:25=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Jun 11, 2025 at 4:43=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > On Wed, Jun 11, 2025 at 3:34=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Wed, Jun 11, 2025 at 3:25=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jun 11, 2025 at 3:23=E2=80=AFPM Paul Moore <paul@paul-moo=
re.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 11, 2025 at 2:34=E2=80=AFPM Stephen Smalley
> > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > >
> > > > > > > On F42, iptables and ip6tables are no longer provided; check
> > > > > > > to see if iptables-legacy and ip6tables-legacy exist and use
> > > > > > > those instead if so.
> > > > > > >
> > > > > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.co=
m>
> > > > > > > ---
> > > > > > >  tests/inet_socket/iptables-flush | 20 +++++++++---
> > > > > > >  tests/inet_socket/iptables-load  | 52 ++++++++++++++++++++--=
----------
> > > > > > >  2 files changed, 48 insertions(+), 24 deletions(-)
> > > > > >
> > > > > > It's been a while since I hit, and worked around, this on my Ra=
whide
> > > > > > systems, but if I recall correctly, fixing the problem was a ma=
tter of
> > > > > > installing the iptables-legacy package and perhaps ensuring tha=
t the
> > > > > > "alternatives" config was set to point to the iptables-nft
> > > > > > implementation:
> > > > > >
> > > > > >   %  rpm -q iptables-legacy
> > > > > >   iptables-legacy-1.8.11-10.fc43.x86_64
> > > > > >   % alternatives --display iptables
> > > > > >   iptables - status is auto.
> > > > > >   link currently points to /usr/bin/iptables-nft
> > > > > >   ...
> > > > > >
> > > > > > FWIW, I think there is value in testing with the iptables-nft
> > > > > > implementation simply so we can test the new code paths.
> > > > >
> > > > > Ok, I had iptables-legacy but not alternatives set. We might want=
 to
> > > > > note this in the README.md file.
> > > >
> > > > Actually, I had alternatives set to iptables-legacy but no
> > > > /usr/sbin/iptables or /usr/sbin/ip6tables symlinks for some reason.
> > >
> > > It's been too long since I fixed this, maybe I setup the symlinks man=
ually?
> > >
> > > %  ls -l /usr/sbin/ip*tables
> > > ... /usr/sbin/ip6tables -> /etc/alternatives/ip6tables
> > > ... /usr/sbin/iptables -> /etc/alternatives/iptables
> > >
> > > > Switching alternatives to iptables-nft causes failures during the
> > > > tests due to "Extension SECMARK revision 0 not supported", so I thi=
nk
> > > > it has to use iptables-legacy?
> > >
> > > I just ran the selinux-testsuite again on my Rawhide system and didn'=
t
> > > see any failures in the inet_socket tests ...
> > >
> > > % make test
> > > ...
> > > Running as user root with context unconfined_u:unconfined_r:unconfine=
d_t
> > >
> > > domain_trans/test ........... ok
> > > entrypoint/test ............. ok
> > > execshare/test .............. ok
> > > exectrace/test .............. ok
> > > execute_no_trans/test ....... ok
> > > fdreceive/test .............. ok
> > > inherit/test ................ ok
> > > link/test ................... ok
> > > mkdir/test .................. ok
> > > msg/test .................... ok
> > > open/test ................... ok
> > > ptrace/test ................. ok
> > > readlink/test ............... ok
> > > relabel/test ................ ok
> > > rename/test ................. ok
> > > rxdir/test .................. ok
> > > sem/test .................... ok
> > > setattr/test ................ ok
> > > setnice/test ................ ok
> > > shm/test .................... ok
> > > sigkill/test ................ ok
> > > stat/test ................... ok
> > > sysctl/test ................. ok
> > > task_create/test ............ ok
> > > task_setnice/test ........... ok
> > > task_setscheduler/test ...... ok
> > > task_getscheduler/test ...... ok
> > > task_getsid/test ............ ok
> > > task_getpgid/test ........... ok
> > > task_setpgid/test ........... ok
> > > file/test ................... ok
> > > ioctl/test .................. ok
> > > capable_file/test ........... ok
> > > capable_net/test ............ ok
> > > capable_sys/test ............ ok
> > > dyntrans/test ............... ok
> > > dyntrace/test ............... ok
> > > bounds/test ................. ok
> > > nnp_nosuid/test ............. ok
> > > mmap/test ................... ok
> > > unix_socket/test ............ ok
> > > inet_socket/tcp/test ........ ok
> > > inet_socket/udp/test ........ ok
> > > overlay/test ................ ok
> > > checkreqprot/test ........... ok
> > > mqueue/test ................. ok
> > > mac_admin/test .............. ok
> > > atsecure/test ............... ok
> > > infiniband_endport/test ..... skipped: test not configured
> > > infiniband_pkey/test ........ skipped: test not configured
> > > cap_userns/test ............. ok
> > > extended_socket_class/test .. ok
> > > sctp/test ................... ok
> > > netlink_socket/test ......... ok
> > > prlimit/test ................ ok
> > > binder/test ................. ok
> > > bpf/test .................... ok
> > > keys/test ................... ok
> > > key_socket/test ............. ok
> > > glblub/test ................. ok
> > > cgroupfs_label/test ......... ok
> > > notify/test ................. ok
> > > module_load/test ............ ok
> > > tun_tap/test ................ ok
> > > perf_event/test ............. ok
> > > filesystem/ext4/test ........ ok
> > > filesystem/xfs/test ......... ok
> > > filesystem/jfs/test ......... ok
> > > filesystem/vfat/test ........ ok
> > > fs_filesystem/ext4/test ..... ok
> > > fs_filesystem/xfs/test ...... ok
> > > fs_filesystem/jfs/test ...... ok
> > > fs_filesystem/vfat/test ..... ok
> > > watchkey/test ............... ok
> > > userfaultfd/test ............ ok
> > > vsock_socket/test ........... ok
> > > secretmem/test .............. ok
> > > inet_socket/mptcp/test ...... ok
> > > All tests successful.
> > > Files=3D78, Tests=3D1427, 241 wallclock secs ( 0.35 usr  0.11 sys +  =
5.90 cusr 17.75
> > > csys =3D 24.11 CPU)
> > > Result: PASS
> > >
> > > The kernel-secnext testing doesn't show any failures either, although
> > > I likely applied the same fix to that test VM as well.
> > >
> > > https://groups.google.com/g/kernel-secnext/c/w-oPYY1-HLo
> >
> > $ sudo alternatives --set iptables /usr/bin/iptables-nft
> > $ sudo make test
> > ...
> > inet_socket/tcp/test ........ 23/34 Warning: Extension tcp revision 0
> > not supported, missing kernel module?
> > Warning: Extension state revision 0 not supported, missing kernel modul=
e?
> > iptables v1.8.11 (nf_tables):  RULE_APPEND failed (No such file or
> > directory): rule in chain INPUT
> > Warning: Extension SECMARK revision 0 not supported, missing kernel mod=
ule?
> > <repeats for each invocation of iptables-nft>
> > ...
> > Result: FAIL
> >
> > $ sudo alternatives --set iptables /usr/bin/iptables-legacy
> > $ sudo make test
> > ...
> > Result: PASS
>
> On my end, the testsuite passes with both iptables-legacy and
> iptables-nft on Rawhide (with stock Fedora kernel). Also the
> alternatives symlinks are created automatically on package
> installation. It looks like you had some weird issue with the symlinks
> and perhaps some missing config options in the kernel.

Ok, so I was able to pass the tests after uninstalling iptables-legacy
(reverting alternatives to iptables-nft) and using the provided kernel
config. Will need to see if I can figure out what if any relevant
differences there are in the config since I was using the testsuite
defconfig, which is intended to enable all _required_ options for the
tests.
