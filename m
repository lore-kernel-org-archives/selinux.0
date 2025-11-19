Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96D3596E2
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763578882; cv=none; b=Qwb72HitTGOcIdX1Gue8RscQF56nf7+A3rsGd3SqScy45G36q+VEDMyHfLBRzD/8bhqnqhKnkHqMz1oH2byIyDt5FlHxnwwh/6YpM/U57697xB5usHARXErQSuUamQKW7tYR8NYS0TpCYZTBQZ3cvDXElLRJye2ZllGTBMlqJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763578882; c=relaxed/simple;
	bh=N3nPa22g/IscJG4A7FisXkeax1g8GVpncsF4jIktZJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsqy/Vfqx6eD/EXrayg/c1baeoZ5jqv8bLGUfbNfOVcdsM7DlWRiCvGuuLbFmJB7VYMlx0yYR8soOwrRLornP60CAoEywN/4EvUHqpzNLtce4Eh0D6YYUNorT8EhLJwRMpFcWUCi4siJLdttmyrtan0o0cKLe/d5TSdqrXXQb4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ+rQY3v; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ+rQY3v"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3436d6aa66dso754560a91.1
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 11:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763578873; x=1764183673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3nPa22g/IscJG4A7FisXkeax1g8GVpncsF4jIktZJw=;
        b=TQ+rQY3v/orlDQNSlTNvhIQVuiwb7eSEpPNQ2+r95TEW48tNZQFx5xwNUbWQVTUc69
         3H3jY8PLEf/tsI8uevhhrGwoUm8gxS/ByGYl6l45jbSYYFpBnEdrybjkbvVVAFERK9MU
         rknBAOJboXQq2l/jis8KQbwG6gKFs+neG1UM/3ZSkjjXafcFwpy1ElmIXtYMeqb3uUlx
         CTRi7oi0hJS6/hmOP+edSKkgcFSNRhXviVUIgwxEkQlzQtw3RI1gPEr2pp/a46i9VGgz
         /r/Sf5NSbFcc8cvcW7/Ur6G5IPOkT/hGlll/jWrnfkQGVOEqZp2kp6jiWW+QccGGuOCO
         /CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763578873; x=1764183673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N3nPa22g/IscJG4A7FisXkeax1g8GVpncsF4jIktZJw=;
        b=safPH+zjAMoOw7XN593Sk/edNGbT2kBZAglSbxtPHP/fRnDM6bFLlXLTxiTl65BO/7
         N1ThIh13PwlHxWFBX4MEdv8LgNYrQeHEbv1RzisXm6EuH9jlQQG5+38xpNdkvfDwDXc9
         +zHR8+3BnFEXiayyb7B6PCp55VNkusTsLeFkVHR92nN5nloCBCMjnNWBqY9cFYbouC2F
         F2qeCDS1syjEaSnTaDB2r8SHVGf4EvXUmWdNgAONLS4kxxIZGijeKxJvTYSV9cTBlcYa
         615RvF9CFC64ZItMd5F07TfwLDsZG+ppPkC+lFjyWorwxyULRiaxD31Dqbs5PQfuLaUb
         HlUA==
X-Gm-Message-State: AOJu0YzVeceE+mJ4yUjP9seXKgciFNn1gk8OX1fCm4may/xA7BF9KeOO
	KAeDtrwQI7Ra2ViCbUhrfGXxlMoREzo3OV91E+RZ9HxZ+doso3TCqVrYLFtQ5V94SWG+ziqylYI
	AC0lqVfESI5pKzmqeLXvdo5XKxxRKzV8=
X-Gm-Gg: ASbGnctEHN7Nt2w2VQqxOSHJNBpV2dgdjk6u78e3mE9qYQk+qR9AAdXb98qB6WmICuX
	iopveRWKMJ/YazAJTLkIXQf9sdPt4K3fz5OKVzrt5wmf9Tmmr+iMGOU4r0lsdOHe6YrQOlL7rPF
	dhEwQWozs/oYZWMxKVaQbQVf5OpTYBL/LevGr/MqACRt03bpLj/BX0Jp86ECkpTLgSnkvgZ4MVQ
	Q18Oj1kYbXwoXrWScsnUvF74wJOOgl59OhM0EHjEvwo5xnmIQnKEMz/nJPgIQdnSqICIggBnZPr
	fzUaDw==
X-Google-Smtp-Source: AGHT+IHxNDImHpZd6MzTiSceSlQpugwz9AIfDTYiROoMEiYDFFgmooUJj/s99Ad6UBGeL47HkFdO2sI2NbFErtokXQg=
X-Received: by 2002:a17:90b:1345:b0:340:29a3:800f with SMTP id
 98e67ed59e1d1-345bd3038cemr3600082a91.15.1763578873236; Wed, 19 Nov 2025
 11:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5cGzHDrsUGKCOxOUZm-0d8shoPahbZB7zVFTivujRNsw@mail.gmail.com>
 <kakoxc3dfli7fjjistybeqhf34abzqovkmq2gs4fg5sv7nviam@w36m2srscmbu>
 <CAEjxPJ5rD7Fq_t5EDoy8EYHzMhgntR+KK=3OZAAuA0V047yKWQ@mail.gmail.com>
 <CAEjxPJ744wutA3FZmA88OMyay__P0qVAYTB6RRnh=v+LiPyxJQ@mail.gmail.com>
 <aoskc4jnsb2ivi7mgdkhxxxahwmrblzayvu7qdtpgjjnz7u7ca@6x6bz243yu4b>
 <CAEjxPJ4xff=wfvVpnSNuydWN4k1TX6f8GtBtWmv_Fc7yKMZaUA@mail.gmail.com>
 <54p5qlyfsj5twmuacf6nqmzaandshs34uwq7vdjycpcl4okgsw@fcovtdadvhlt>
 <CAEjxPJ4Ho+BFQ2Br6ajE0wF0Ueha04Z-EK45Fb3+2VC4hEVZBA@mail.gmail.com>
 <3b54lpvwc3eoyon4jf2vrkilmu2452ydz6zve5xdfofylioost@dgfwiuenwiqa>
 <CAEjxPJ4sVqtE5FuKrO708UR3towkdc_yAD64ixPZHsazoP_g6A@mail.gmail.com>
 <b2phzphz7lox6neiphbejtydndmgnz53y4jzfzpueffmqsn5im@2to32uoex2cs>
 <CAEjxPJ6P3NMfdw4t4E0dVvLsBAE+YEmgYkS+pRqYgDfApcv6Eg@mail.gmail.com> <CAEjxPJ6frshipeNk+f=_LDjeVwBNjMzBxqfZtk96rquWvUBHqQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6frshipeNk+f=_LDjeVwBNjMzBxqfZtk96rquWvUBHqQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Nov 2025 14:01:01 -0500
X-Gm-Features: AWmQ_bm865ei-D7Ou8MkUIHmXzD1WSp4p7zzV4SGmpgwKoYcIz5ZjH2Fd7mUWtQ
Message-ID: <CAEjxPJ5vdrOuHUUCQe1qZbipr767DoJ0PUHD+H_3JBviDYw=zA@mail.gmail.com>
Subject: Re: SELinux Namespace work
To: =?UTF-8?Q?Martin_Erts=C3=A5s?= <mertsas@cisco.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 1:41=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Nov 19, 2025 at 9:00=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > I believe the kernfs nodes for the cgroup2 files that have host labels
> > are initially being created by the kernel before the Android policy is
> > loaded and therefore still inherit the parent directory xattr which
> > was based on the host policy. Not sure if there is something further
> > we can do in the kernel to avoid this. I tried moving the Android
> > policy load earlier (before the unsharing of the cgroup namespace) but
> > that didn't appear to help. Need to track down exactly when these
> > kernfs nodes are created and whether they are shared across multiple
> > cgroup2 mounts.
> >
> > In my testing, if the host is permissive, then I see a mix of host and
> > Android labels (i.e. system_u:object_r:cgroup_t:s0 and
> > u:object_r:cgroup_v2:s0) but if the host is enforcing, then they are
> > all shown as Android labels but the ones that had the host labels when
> > permissive are shown as u:object_r:unlabeled:s0. This makes sense
> > since if the host is permissive and we are running as root (with
> > CAP_MAC_ADMIN), the kernel will return raw contexts/xattrs on
> > getxattr(2) even if they can't be mapped to a valid context in the
> > current policy; otherwise the kernel will return the unlabeled context
> > as defined by the current policy. I found that on the host, the new
> > cgroup tree is visible under /sys/fs/cgroup/user.slice/user-NNNN.slice
> > and on the host, it is similarly a mix of cgroup_t and unlabeled_t
> > (unlabeled_t for the ones with Android labels since they can't be
> > interpreted by the host).
>
> Ok, I finally realized that if you unshare the cgroup namespace and
> then mount -t cgroup2 none /sys/fs/cgroup, it just mounts the
> subdirectory for the cgroup to which your process was already assigned
> - it doesn't create a new one. So if you cat /proc/self/cgroup before
> doing the unshare -C and subsequently mount -t cgroup2 none
> /sys/fs/cgroup, you are getting the same subdirectory that was already
> set up by systemd on the host (ls -i of both directories will show the
> same inodes). That's why the base files are all being labeled with
> host labels, because the directory was created on the host. To avoid
> this, you would need to create a new cgroup subdirectory on the host
> after unsharing your SELinux namespace, assign your process to that
> cgroup, and then unshare the cgroup namespace and mount the cgroup2
> filesystem IIUC.

I've tested this as follows (NB below I am using the libselinux
unshareselinux utility program which handles unsharing of the SELinux
and mount namespaces since my kernel no longer has the
/sys/fs/selinux/unshare API). This still depends on the 3 kernel
patches to work correctly, and appears to require loading the Android
policy before creating the new cgroup to avoid any labeling problems
since the base files are populated during the mkdir itself.

$ sudo unshareselinux bash
# mount -t selinuxfs none /sys/fs/selinux
# ./myloadpolicy ./precompiled_sepolicy
# id
uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Du:r:kernel:s0
# mkdir /sys/fs/cgroup/android
# echo $$ > /sys/fs/cgroup/android/cgroup.procs
# unshare -C bash
# mount -t cgroup2 none /sys/fs/cgroup
# ls -Z /sys/fs/cgroup
u:object_r:cgroup_v2:s0 cgroup.controllers
u:object_r:cgroup_v2:s0 cgroup.events
u:object_r:cgroup_v2:s0 cgroup.freeze
u:object_r:cgroup_v2:s0 cgroup.kill
u:object_r:cgroup_v2:s0 cgroup.max.depth
u:object_r:cgroup_v2:s0 cgroup.max.descendants
u:object_r:cgroup_v2:s0 cgroup.pressure
u:object_r:cgroup_v2:s0 cgroup.procs
u:object_r:cgroup_v2:s0 cgroup.stat
u:object_r:cgroup_v2:s0 cgroup.stat.local
u:object_r:cgroup_v2:s0 cgroup.subtree_control
u:object_r:cgroup_v2:s0 cgroup.threads
u:object_r:cgroup_v2:s0 cgroup.type
u:object_r:cgroup_v2:s0 cpu.idle
u:object_r:cgroup_v2:s0 cpu.max
u:object_r:cgroup_v2:s0 cpu.max.burst
u:object_r:cgroup_v2:s0 cpu.pressure
u:object_r:cgroup_v2:s0 cpu.stat
u:object_r:cgroup_v2:s0 cpu.stat.local
u:object_r:cgroup_v2:s0 cpu.uclamp.max
u:object_r:cgroup_v2:s0 cpu.uclamp.min
u:object_r:cgroup_v2:s0 cpu.weight
u:object_r:cgroup_v2:s0 cpu.weight.nice
u:object_r:cgroup_v2:s0 io.pressure
u:object_r:cgroup_v2:s0 irq.pressure
u:object_r:cgroup_v2:s0 memory.current
u:object_r:cgroup_v2:s0 memory.events
u:object_r:cgroup_v2:s0 memory.events.local
u:object_r:cgroup_v2:s0 memory.high
u:object_r:cgroup_v2:s0 memory.low
u:object_r:cgroup_v2:s0 memory.max
u:object_r:cgroup_v2:s0 memory.min
u:object_r:cgroup_v2:s0 memory.numa_stat
u:object_r:cgroup_v2:s0 memory.oom.group
u:object_r:cgroup_v2:s0 memory.peak
u:object_r:cgroup_v2:s0 memory.pressure
u:object_r:cgroup_v2:s0 memory.reclaim
u:object_r:cgroup_v2:s0 memory.stat
u:object_r:cgroup_v2:s0 memory.swap.current
u:object_r:cgroup_v2:s0 memory.swap.events
u:object_r:cgroup_v2:s0 memory.swap.high
u:object_r:cgroup_v2:s0 memory.swap.max
u:object_r:cgroup_v2:s0 memory.swap.peak
u:object_r:cgroup_v2:s0 memory.zswap.current
u:object_r:cgroup_v2:s0 memory.zswap.max
u:object_r:cgroup_v2:s0 memory.zswap.writeback
u:object_r:cgroup_v2:s0 pids.current
u:object_r:cgroup_v2:s0 pids.events
u:object_r:cgroup_v2:s0 pids.events.local
u:object_r:cgroup_v2:s0 pids.max
u:object_r:cgroup_v2:s0 pids.peak
