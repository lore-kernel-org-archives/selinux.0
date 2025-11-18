Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12234F492
	for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481315; cv=none; b=uzN5cH8rh2CaEbAdJuTDMzMlvt/stEiy7vk30IbgNemfQ1Yo8qGI6ctu5M39xNb0RJcCRVdMueho5lsmW0sr/mpjRxB69cFnAUM2qgI5IB3SxKlFzHlY7urUtWi+WI7fgscHILXbfuKilVqzHLVUTB0UjPHpz5ltJdqhZpK/tSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481315; c=relaxed/simple;
	bh=tMK13PsPruJeucVjrm2qsyT+GQQEGSPyxNPmiRuJz4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5ZiZjwelsiB88IZSnNg+1Qt5BHjEpal9bz7EbUAcLcHN4yc6EN3AiWCjkrJSRy6XWlO+Dxg14YeI9iZsjpPGWFlmgKYuMFu62tpuxjAOKwwb3NcwD4xO05actRsidNmkTQMzR2Bd7LC/xZlN/UaKUY4QneWE/hmr9S7kJfEW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAyERK2p; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAyERK2p"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso5678481a91.0
        for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763481314; x=1764086114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4+qY3omShDCwhMUmTi3lgM/DxRUPvHKTJBeWMF7zOw=;
        b=mAyERK2pg9aXsH7A+BaMlNIk6jDMbwO/N1ABEPYyyJNOrDTWt3t2f+LqBFdYMXca6M
         ZMRb6GRB4oJyYjhMxRSZ+lnbw/Xxo/gjYsRjDYigKpwIpzxBw5hlrszkBWApPHXD+1w9
         FO7AqzEy7SEz2FDv3t3Q0ZK5rBdL7v6XC/61OLxuiSij+5jn+FymGMRW+pdWUuSAs36q
         QGKbnwAJ3ubqw26W7GUlFfpGQKzs89fBPc0cWzS9zV+ocpom5z3ZQZQAQ6sGpopIEpig
         5fP+gdhJvEo2Rq5zBd3MKAV1b3APU0ysk4BQHOmdqyzl/06eRyWCCN4JyuemYxwDw4Cl
         s8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481314; x=1764086114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m4+qY3omShDCwhMUmTi3lgM/DxRUPvHKTJBeWMF7zOw=;
        b=XgrsgRZbHYpOPYPwisPAFsg72P/iTdS+NnlQXBeS0HFx3wDmZFWtoyKvXBW1LnI4Rd
         cc7G8RA+hTv317Ne5zjvNfzTIj3qXxZdyo7AoW7nOj99jyznSWVTBuFVrlCAs04D9yWc
         //je84+JuhybdVnYbTqck5kdzGS5OxCZgN0b//FHqBMzEwVgoq+py7V2iggtXoeciLGa
         8H1nQ+X62GH0k5PhmY3p21SUhawUnf30Vv0uytAK0nerX2A8eeE3maNzfpGVmbXkr5o2
         sdImwMYoediix0gMVN7tpLII8+zDxHKs9nhTSWr22+19B9ZAfhUILVeSS5kI8JixRUpB
         I15Q==
X-Gm-Message-State: AOJu0YxQ0q5lJrZGCtx5kub7zINVcLvf8CxM1GFztB6qCLS7FroD3Ml/
	jMePJppOxc8uJbu6u+jQC/P2r1VoauFiG9GdygxwumnWIQ3T8s39TQZ+E+WcCiRsIIMBDRK6+6q
	sl9CIxU8KrplHOdnMRzu++wABi9p3GNI=
X-Gm-Gg: ASbGnctZNnojcWU8lGhCciIeqAc63o9IKt3voc8RQA79szsb7OtSw7gtgaR7fls0gLP
	gRI/llfYF14VY/Ko8qH649mt6gg2Zj+ar6Umhy0IAjmsjY9WeVXII/Vrj5nUVWLsS/ODgh/0EcE
	5JA1JGiyx3HYm33gx5wicKOpWyC44jj5Z8uQ1LpQAdy6HB66tUMjql7HvJpXCvgd4ceFJgPIBzu
	Ea5CGGZDzedri76NXc6XJ5V502vPqVjzQMOKezpuepEGr04fgtT+phMZAu8tM7g8iYKlkFxQjbu
	wDpnJA==
X-Google-Smtp-Source: AGHT+IEe51t7B/t55UuFszNHD7iS69E7ielXnEY9qlIwXKWlNhGU/cDKNDtXvOLq0GL3JrG80gkW0Zn2Nl7McSmdQIY=
X-Received: by 2002:a17:90b:3d45:b0:32e:2fa7:fe6b with SMTP id
 98e67ed59e1d1-345aec3ee92mr3684535a91.14.1763481313536; Tue, 18 Nov 2025
 07:55:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <io56y7r63uyeduqe7ukx3wcjvhzfnnsxle2go5raxqy76lrn3n@edx4doao3gv3>
 <CAEjxPJ5cGzHDrsUGKCOxOUZm-0d8shoPahbZB7zVFTivujRNsw@mail.gmail.com>
 <kakoxc3dfli7fjjistybeqhf34abzqovkmq2gs4fg5sv7nviam@w36m2srscmbu>
 <CAEjxPJ5rD7Fq_t5EDoy8EYHzMhgntR+KK=3OZAAuA0V047yKWQ@mail.gmail.com>
 <CAEjxPJ744wutA3FZmA88OMyay__P0qVAYTB6RRnh=v+LiPyxJQ@mail.gmail.com>
 <aoskc4jnsb2ivi7mgdkhxxxahwmrblzayvu7qdtpgjjnz7u7ca@6x6bz243yu4b>
 <CAEjxPJ4xff=wfvVpnSNuydWN4k1TX6f8GtBtWmv_Fc7yKMZaUA@mail.gmail.com>
 <54p5qlyfsj5twmuacf6nqmzaandshs34uwq7vdjycpcl4okgsw@fcovtdadvhlt>
 <CAEjxPJ4Ho+BFQ2Br6ajE0wF0Ueha04Z-EK45Fb3+2VC4hEVZBA@mail.gmail.com> <3b54lpvwc3eoyon4jf2vrkilmu2452ydz6zve5xdfofylioost@dgfwiuenwiqa>
In-Reply-To: <3b54lpvwc3eoyon4jf2vrkilmu2452ydz6zve5xdfofylioost@dgfwiuenwiqa>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 18 Nov 2025 10:55:01 -0500
X-Gm-Features: AWmQ_bkoWdWWiAIcbIDPq4IcPWg8S-gngSXV3yXNyq-znt2Tw9oKzf-1cE_HmtI
Message-ID: <CAEjxPJ4sVqtE5FuKrO708UR3towkdc_yAD64ixPZHsazoP_g6A@mail.gmail.com>
Subject: Re: SELinux Namespace work
To: =?UTF-8?Q?Martin_Erts=C3=A5s?= <mertsas@cisco.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 2:00=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cisco.c=
om> wrote:
>
> On Mon, Nov 17, 2025 at 09:28:38AM -0500, Stephen Smalley wrote:
> > On Mon, Nov 17, 2025 at 3:09=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cis=
co.com> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 10:25:38AM -0500, Stephen Smalley wrote:
> > > > On Fri, Nov 14, 2025 at 9:15=E2=80=AFAM Martin Erts=C3=A5s <mertsas=
@cisco.com> wrote:
> > > > > Thank you for the help so far. I have dug quite a bit into an iss=
ue with
> > > > > this together with the cgroup namespace, which is required for ru=
nning
> > > > > Android in a container.
> > > > >
> > > > > What I see is that before mounting the cgroup namespace, it is la=
beled
> > > > > based on the new selinux namespace as expected. But when mounting=
 the
> > > > > cgroup2 filesystem, some of the labels change to the host labels.=
 This
> > > > > causes problems, as I on the host have the user system_u, while a=
ndroid
> > > > > only has u. So when I try to make a subdirectory in the new cgrou=
p, I
> > > > > get -ENOMEM as selinux can not find a system_u user.
> > > > >
> > > > > This is what I can observe:
> > > > >
> > > > > # echo 1 > /sys/fs/selinux/unshare
> > > >
> > > > Note that my current working-selinuxns branch has switched from the
> > > > /sys/fs/selinux/unshare interface to the system call-based approach
> > > > recommended by the discussion on the LSM list so at some point you =
may
> > > > need to switch over to using that as well. That however is not
> > > > relevant to your issue below; I am just mentioning it for your
> > > > awareness. It remains to be seen what the final upstream API will b=
e.
> > >
> > > Yes, I noticed. I will switch to this one as soon as I have a working
> > > prototype, as this seems to solely be an API change. If the branches
> > > starts to diverge I would need to swap ASAP though.
> > >
> > > > > # unshare -m -n -C -p --fork /tmp/setup_namespace.sh
> > > > > [cisco:/] $ load_selinux_policy
> > > > > Loaded selinux policy. Enforcing=3D0
> > > > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 9p
> > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 bpf
> > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 cgroup
> > > > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 ext4
> > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 fuse
> > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 nfs
> > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 pstore
> > > > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0        =
          0 Nov 14 14:05 selinux
> > > >
> > > > Looks like your container sysfs mount was labeled per its policy
> > > > rather than the host policy, as expected. Did you do anything speci=
al
> > > > when mounting sysfs?
> > >
> > > No, just did `mount -t sysfs none /sys` I have attached the script an=
d
> > > the selinux policy.
> > >
> > > > > load_selinux_policy-3.2# mount -t cgroup2 none /sys/fs/cgroup
> > > > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 9p
> > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 bpf
> > > > > drwxr-xr-x    2 root     root     system_u:object_r:cgroup_t     =
          0 Nov 14 13:53 cgroup
> > > > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 ext4
> > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 fuse
> > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 nfs
> > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0            =
          0 Nov 14 14:05 pstore
> > > > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0        =
          0 Nov 14 14:05 selinux
> > > > > load_selinux_policy-3.2# ls -lZ /sys/fs/cgroup/
> > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0        =
          0 Nov 14 13:53 cgroup.controllers
> > > > > -r--r--r--    1 root     root     system_u:object_r:cgroup_t     =
          0 Nov 14 13:53 cgroup.events
> > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0        =
          0 Nov 14 13:53 cgroup.freeze
> > > > > --w-------    1 root     root     u:object_r:unlabeled:s0        =
          0 Nov 14 13:53 cgroup.kill
> > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0        =
          0 Nov 14 13:53 cgroup.max.depth
> > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0        =
          0 Nov 14 13:53 cgroup.max.descendants
> > > > > -rw-r--r--    1 root     root     system_u:object_r:cgroup_t     =
          0 Nov 14 13:53 cgroup.procs
> > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0        =
          0 Nov 14 13:53 cgroup.stat
> > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0        =
          0 Nov 14 13:53 cgroup.subtree_control
> > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0        =
          0 Nov 14 13:53 cgroup.threads
> > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0        =
          0 Nov 14 13:53 cgroup.type
> > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0        =
          0 Nov 14 13:53 cpu.stat
> > > >
> > > > That's very odd indeed - I would expect them all to be labeled base=
d
> > > > on either the container policy or the host policy, not a mix of the
> > > > two. cgroup2 and sysfs are both kernfs-based so I'm wondering how/w=
hy
> > > > they differ.
> > >
> > > My suspicion is that since the cgroup namespace gives you a subhierar=
chy
> > > view of the host cgroup hierarchy, the superblock is reused as for
> > > cgroup it's actually the same hierarchy. Just with a different root.
> > > While the sysfs is a completely new sys mount. But I'm not 100% sure.
> > >
> > > I will dig into why some, like cgroup.subtree_control, are labeled wi=
th
> > > the new selinux policy, while others are labeled with the host selinu=
x policy.
> > >
> > > > > load_selinux_policy-3.2# mkdir /sys/fs/cgroup/foo
> > > > > mkdir: can't create directory '/sys/fs/cgroup/foo': Cannot alloca=
te memory
> > > > > load_selinux_policy-3.2#
> > > > >
> > > > > The setup_namespace just creates a new rootfs and mounts the andr=
oid
> > > > > container and selinux policy into that. And load_selinux_policy i=
s just a wrapper that loads the android selinux policy.
> > > > >
> > > > > What I have traced it down to is that when kernfs_get_tree from
> > > > > fs/kernfs/mount.c is mounting the cgroup, the superblock is reuse=
d from
> > > > > the old cgroup namespace, which also has the security context fro=
m the
> > > > > old selinux namespace. This causes the labels to be mixed as show=
n
> > > > > above. This doesn't seem to involve SELinux code directly, but ju=
st the
> > > > > kernfs code.
> > > > >
> > > > > Should the kernfs test function for the superblock involve checki=
ng the
> > > > > security context as well? Not sure what a proper fix for this wou=
ld be?
> > > > > Or if I'm missunderstanding something and doing something fundame=
ntally
> > > > > wrong here?
> > > >
> > > > First I'd like to understand why it seems to be working for sysfs b=
ut
> > > > not cgroup2 since they are both kernfs-based. What's different betw=
een
> > > > the two?
> > > > And since you unshared the cgroup namespace, why doesn't that trigg=
er
> > > > a new superblock creation by itself? It's better if we can avoid
> > > > introducing a special check just for SELinux/LSM here.
> > >
> > > Good questions. I think I answered my hunch on these above, but I'm
> > > truly not sure. I have attached the setup_namespace.sh script I use s=
o
> > > you can see, as well as the selinux policy I load.
> >
> > And just to confirm, is your load_selinux_policy just a program that
> > does the equivalent of open+fstat+mmap+security_load_policy() on the
> > Android policy file?
>
> Correct, that's all it does.

I'm going to assume that forcing creation of a new superblock for the
cgroup2 mount would introduce other problems for cgroup2 since I don't
see that happening even for cgroup2 mounts in systemd-nspawn
containers. I've just sent a series of patches that appear to help
with the cgroup2 labeling and allow mkdir to work, although I still
see mixed labeling at the top-level and am not sure if there are
shared inodes between the host and container cgroup2 mounts that will
effectively fight over the one inode label. If this approach doesn't
work, then we may want to revisit creating a new superblock if
possible. Regardless, it would be better to mount the new cgroup2
filesystem _after_ loading the Android policy so that its inodes are
labeled based on that policy rather than the host policy from the
beginning.
