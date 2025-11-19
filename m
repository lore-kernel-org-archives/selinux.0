Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73B30CDAA
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577683; cv=none; b=YWqYjXTs6joQ/eg8DC1VToGSybws1svA5KflP2tA/JTxHr3eNHSOkof9l8oAvZa7olJdfzYcRDiqwF/yafMe0603iXFtPU47hwLMMjrYkL7R1kcjzgo0hVpxvHMThbSnz2wMBJeLjHHDB0rN2aCErTRkKu5NiFzLSnDA17Wm714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577683; c=relaxed/simple;
	bh=F7uD7D5hhazT3SvX8zTmvtw7NcunnXKl0+CYdAmV7U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzJG5UdBEwe5M7EM7ebi/Z6qYWizrVUPqvKLY5FlPMdWSC4mcO5V63fwNcca1rxMsjL3XH4JYjrxbOsQ1HE+lu01VyA09vAgbjHqm6RVu3/V24rW1NfeRO+q8bQzEipJU6bN6jU3uWtwSUjnojfaM7FC4AkxjT62BhNO9sv8vUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1mHoiXo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1mHoiXo"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso10343838a91.2
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 10:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763577673; x=1764182473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxGrjw1Njg2udWJwlhwjUTiBCHEHG4r4d53D/dLIynE=;
        b=g1mHoiXokHtBi+HnR97jgPAQy1srQk7oOZeyOLg5rSaQskwpBZ1qmLffZQE6lBeqrE
         LPDPndjxUXOfiQdQDl+q1BvGb8UzYtg5HmkKzy1b5K5QKeaoAq0s3BrbDZi642l+Nh9C
         SDxkXQqe6kD4W5Mwl6+sJhPwXdSThsRaVOycEaWjrAeQGa6uK3MxLTyDVEG4314QP/gL
         YJkKkSsLaV7agu/U9xBCr39rY6NPnrfFI/V9bv3a/O1TZESw8dJm1e8+VBukb0rwyRmB
         g5GShVs5XBaWp/rjDw3NPJROSZAaZjR4dKuR7Gq+58esYYhAtYUeLAKpaVTjByRMnh1F
         y26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763577673; x=1764182473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AxGrjw1Njg2udWJwlhwjUTiBCHEHG4r4d53D/dLIynE=;
        b=LfRAX+OIAGAFxyjYqniCbRegFmwlPjLun24LFO204FA2Btk+oHZ4uV35V8nQQd2xFQ
         dPQ1BfMF68HKJObPBDZSyuHZh3970nNPl+T02ktnnDnQz+jFE87mSU1TgDq0T9T/gbDN
         DnCRPgG2gCUnIw1bQKEQByKyazxjO28/v9R9xindzFdX+3j5DsoLOc+IG4QiNgXIMt2r
         u2ghICMaFQmC5RdwF8OeBWEFypGgMmLU/dvTWkIZd0lE1M39T5jkKa3ABNy0xe4AGxYb
         ZFUMOkMELgnChTMvjccux5tApwMGScwX8pTEvdLQQOOwwTpK+jSTy85vdrlRfujY3u51
         DECA==
X-Gm-Message-State: AOJu0Yztp13VK5pM6/LEuasYHHb2VIdAp50/o9xMu8gH3s6BclB0I/cB
	1jKKXOKPLvyUlhZaMlSWmaVJi22JHSZO2YGiOtc5rhWwHbA3puU4CJI568lwLoRR6whUquFRvTm
	iId7HD5LkFZiZK47ZtHg5XYdXjsWwhH0=
X-Gm-Gg: ASbGnctHUHoiyT7bEmqwVlVAcZ+CM6jJy3FecPKdHP6TtKHCjWhXz6wNXAK6WMKZFTx
	B5Gsgf8gQfcnSp2Uj8WyjiyU31AGhkE2xm/M/voj8hMgiHQqmfcfABhecb5Hc1dySWsIG29GQyY
	w7kcmIG1fhsCWMvZi5ySMvl3I1zzZkqUNmtp6iPc+KKHoTMQicD2WbWauxUp6bFwyOQDGUYcQI6
	7eRSVyx4tQLTAdlJu/2Uk5GRBka7pv7OgDP95VHdFbQM1mI0PArD4Pzgx8ODIi7bDWQZDjabDxl
	WNWiig==
X-Google-Smtp-Source: AGHT+IGeGyY9KropXXtbVfI6ZXLCvwIhNpucWX+e7IEsB4Ej2+nLkra/Cp3nMeAj2DJ+QGDYNlz7kjAFMx1+8AIN17Y=
X-Received: by 2002:a17:90b:2d0c:b0:33b:c9b6:1cd with SMTP id
 98e67ed59e1d1-3472841c319mr48376a91.19.1763577672914; Wed, 19 Nov 2025
 10:41:12 -0800 (PST)
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
 <b2phzphz7lox6neiphbejtydndmgnz53y4jzfzpueffmqsn5im@2to32uoex2cs> <CAEjxPJ6P3NMfdw4t4E0dVvLsBAE+YEmgYkS+pRqYgDfApcv6Eg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6P3NMfdw4t4E0dVvLsBAE+YEmgYkS+pRqYgDfApcv6Eg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Nov 2025 13:41:01 -0500
X-Gm-Features: AWmQ_bl_Zc2fXYqZn7uX9GHZpvzL2384dngpBEllIMVKNtKd37kbosLXDnCab_U
Message-ID: <CAEjxPJ6frshipeNk+f=_LDjeVwBNjMzBxqfZtk96rquWvUBHqQ@mail.gmail.com>
Subject: Re: SELinux Namespace work
To: =?UTF-8?Q?Martin_Erts=C3=A5s?= <mertsas@cisco.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 9:00=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Nov 19, 2025 at 6:09=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cisco=
.com> wrote:
> >
> > On Tue, Nov 18, 2025 at 10:55:01AM -0500, Stephen Smalley wrote:
> > > On Tue, Nov 18, 2025 at 2:00=E2=80=AFAM Martin Erts=C3=A5s <mertsas@c=
isco.com> wrote:
> > > >
> > > > On Mon, Nov 17, 2025 at 09:28:38AM -0500, Stephen Smalley wrote:
> > > > > On Mon, Nov 17, 2025 at 3:09=E2=80=AFAM Martin Erts=C3=A5s <merts=
as@cisco.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 14, 2025 at 10:25:38AM -0500, Stephen Smalley wrote=
:
> > > > > > > On Fri, Nov 14, 2025 at 9:15=E2=80=AFAM Martin Erts=C3=A5s <m=
ertsas@cisco.com> wrote:
> > > > > > > > Thank you for the help so far. I have dug quite a bit into =
an issue with
> > > > > > > > this together with the cgroup namespace, which is required =
for running
> > > > > > > > Android in a container.
> > > > > > > >
> > > > > > > > What I see is that before mounting the cgroup namespace, it=
 is labeled
> > > > > > > > based on the new selinux namespace as expected. But when mo=
unting the
> > > > > > > > cgroup2 filesystem, some of the labels change to the host l=
abels. This
> > > > > > > > causes problems, as I on the host have the user system_u, w=
hile android
> > > > > > > > only has u. So when I try to make a subdirectory in the new=
 cgroup, I
> > > > > > > > get -ENOMEM as selinux can not find a system_u user.
> > > > > > > >
> > > > > > > > This is what I can observe:
> > > > > > > >
> > > > > > > > # echo 1 > /sys/fs/selinux/unshare
> > > > > > >
> > > > > > > Note that my current working-selinuxns branch has switched fr=
om the
> > > > > > > /sys/fs/selinux/unshare interface to the system call-based ap=
proach
> > > > > > > recommended by the discussion on the LSM list so at some poin=
t you may
> > > > > > > need to switch over to using that as well. That however is no=
t
> > > > > > > relevant to your issue below; I am just mentioning it for you=
r
> > > > > > > awareness. It remains to be seen what the final upstream API =
will be.
> > > > > >
> > > > > > Yes, I noticed. I will switch to this one as soon as I have a w=
orking
> > > > > > prototype, as this seems to solely be an API change. If the bra=
nches
> > > > > > starts to diverge I would need to swap ASAP though.
> > > > > >
> > > > > > > > # unshare -m -n -C -p --fork /tmp/setup_namespace.sh
> > > > > > > > [cisco:/] $ load_selinux_policy
> > > > > > > > Loaded selinux policy. Enforcing=3D0
> > > > > > > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > > > > > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 9p
> > > > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 bpf
> > > > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 cgroup
> > > > > > > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 ext4
> > > > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 fuse
> > > > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 nfs
> > > > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 pstore
> > > > > > > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0  =
                0 Nov 14 14:05 selinux
> > > > > > >
> > > > > > > Looks like your container sysfs mount was labeled per its pol=
icy
> > > > > > > rather than the host policy, as expected. Did you do anything=
 special
> > > > > > > when mounting sysfs?
> > > > > >
> > > > > > No, just did `mount -t sysfs none /sys` I have attached the scr=
ipt and
> > > > > > the selinux policy.
> > > > > >
> > > > > > > > load_selinux_policy-3.2# mount -t cgroup2 none /sys/fs/cgro=
up
> > > > > > > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > > > > > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 9p
> > > > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 bpf
> > > > > > > > drwxr-xr-x    2 root     root     system_u:object_r:cgroup_=
t               0 Nov 14 13:53 cgroup
> > > > > > > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 ext4
> > > > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 fuse
> > > > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 nfs
> > > > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0      =
                0 Nov 14 14:05 pstore
> > > > > > > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0  =
                0 Nov 14 14:05 selinux
> > > > > > > > load_selinux_policy-3.2# ls -lZ /sys/fs/cgroup/
> > > > > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0  =
                0 Nov 14 13:53 cgroup.controllers
> > > > > > > > -r--r--r--    1 root     root     system_u:object_r:cgroup_=
t               0 Nov 14 13:53 cgroup.events
> > > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0  =
                0 Nov 14 13:53 cgroup.freeze
> > > > > > > > --w-------    1 root     root     u:object_r:unlabeled:s0  =
                0 Nov 14 13:53 cgroup.kill
> > > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0  =
                0 Nov 14 13:53 cgroup.max.depth
> > > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0  =
                0 Nov 14 13:53 cgroup.max.descendants
> > > > > > > > -rw-r--r--    1 root     root     system_u:object_r:cgroup_=
t               0 Nov 14 13:53 cgroup.procs
> > > > > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0  =
                0 Nov 14 13:53 cgroup.stat
> > > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0  =
                0 Nov 14 13:53 cgroup.subtree_control
> > > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0  =
                0 Nov 14 13:53 cgroup.threads
> > > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0  =
                0 Nov 14 13:53 cgroup.type
> > > > > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0  =
                0 Nov 14 13:53 cpu.stat
> > > > > > >
> > > > > > > That's very odd indeed - I would expect them all to be labele=
d based
> > > > > > > on either the container policy or the host policy, not a mix =
of the
> > > > > > > two. cgroup2 and sysfs are both kernfs-based so I'm wondering=
 how/why
> > > > > > > they differ.
> > > > > >
> > > > > > My suspicion is that since the cgroup namespace gives you a sub=
hierarchy
> > > > > > view of the host cgroup hierarchy, the superblock is reused as =
for
> > > > > > cgroup it's actually the same hierarchy. Just with a different =
root.
> > > > > > While the sysfs is a completely new sys mount. But I'm not 100%=
 sure.
> > > > > >
> > > > > > I will dig into why some, like cgroup.subtree_control, are labe=
led with
> > > > > > the new selinux policy, while others are labeled with the host =
selinux policy.
> > > > > >
> > > > > > > > load_selinux_policy-3.2# mkdir /sys/fs/cgroup/foo
> > > > > > > > mkdir: can't create directory '/sys/fs/cgroup/foo': Cannot =
allocate memory
> > > > > > > > load_selinux_policy-3.2#
> > > > > > > >
> > > > > > > > The setup_namespace just creates a new rootfs and mounts th=
e android
> > > > > > > > container and selinux policy into that. And load_selinux_po=
licy is just a wrapper that loads the android selinux policy.
> > > > > > > >
> > > > > > > > What I have traced it down to is that when kernfs_get_tree =
from
> > > > > > > > fs/kernfs/mount.c is mounting the cgroup, the superblock is=
 reused from
> > > > > > > > the old cgroup namespace, which also has the security conte=
xt from the
> > > > > > > > old selinux namespace. This causes the labels to be mixed a=
s shown
> > > > > > > > above. This doesn't seem to involve SELinux code directly, =
but just the
> > > > > > > > kernfs code.
> > > > > > > >
> > > > > > > > Should the kernfs test function for the superblock involve =
checking the
> > > > > > > > security context as well? Not sure what a proper fix for th=
is would be?
> > > > > > > > Or if I'm missunderstanding something and doing something f=
undamentally
> > > > > > > > wrong here?
> > > > > > >
> > > > > > > First I'd like to understand why it seems to be working for s=
ysfs but
> > > > > > > not cgroup2 since they are both kernfs-based. What's differen=
t between
> > > > > > > the two?
> > > > > > > And since you unshared the cgroup namespace, why doesn't that=
 trigger
> > > > > > > a new superblock creation by itself? It's better if we can av=
oid
> > > > > > > introducing a special check just for SELinux/LSM here.
> > > > > >
> > > > > > Good questions. I think I answered my hunch on these above, but=
 I'm
> > > > > > truly not sure. I have attached the setup_namespace.sh script I=
 use so
> > > > > > you can see, as well as the selinux policy I load.
> > > > >
> > > > > And just to confirm, is your load_selinux_policy just a program t=
hat
> > > > > does the equivalent of open+fstat+mmap+security_load_policy() on =
the
> > > > > Android policy file?
> > > >
> > > > Correct, that's all it does.
> > >
> > > I'm going to assume that forcing creation of a new superblock for the
> > > cgroup2 mount would introduce other problems for cgroup2 since I don'=
t
> > > see that happening even for cgroup2 mounts in systemd-nspawn
> > > containers. I've just sent a series of patches that appear to help
> > > with the cgroup2 labeling and allow mkdir to work, although I still
> > > see mixed labeling at the top-level and am not sure if there are
> > > shared inodes between the host and container cgroup2 mounts that will
> > > effectively fight over the one inode label. If this approach doesn't
> > > work, then we may want to revisit creating a new superblock if
> > > possible. Regardless, it would be better to mount the new cgroup2
> > > filesystem _after_ loading the Android policy so that its inodes are
> > > labeled based on that policy rather than the host policy from the
> > > beginning.
> >
> > Thank you. I just tried with your patches applied, and now I can create
> > the cgroup subdirectories. It's still a mix of labels I see, also when
> > mounting it after loading the selinux policy, but currently it doesn't
> > seem like it's causing any issues.
>
> I believe the kernfs nodes for the cgroup2 files that have host labels
> are initially being created by the kernel before the Android policy is
> loaded and therefore still inherit the parent directory xattr which
> was based on the host policy. Not sure if there is something further
> we can do in the kernel to avoid this. I tried moving the Android
> policy load earlier (before the unsharing of the cgroup namespace) but
> that didn't appear to help. Need to track down exactly when these
> kernfs nodes are created and whether they are shared across multiple
> cgroup2 mounts.
>
> In my testing, if the host is permissive, then I see a mix of host and
> Android labels (i.e. system_u:object_r:cgroup_t:s0 and
> u:object_r:cgroup_v2:s0) but if the host is enforcing, then they are
> all shown as Android labels but the ones that had the host labels when
> permissive are shown as u:object_r:unlabeled:s0. This makes sense
> since if the host is permissive and we are running as root (with
> CAP_MAC_ADMIN), the kernel will return raw contexts/xattrs on
> getxattr(2) even if they can't be mapped to a valid context in the
> current policy; otherwise the kernel will return the unlabeled context
> as defined by the current policy. I found that on the host, the new
> cgroup tree is visible under /sys/fs/cgroup/user.slice/user-NNNN.slice
> and on the host, it is similarly a mix of cgroup_t and unlabeled_t
> (unlabeled_t for the ones with Android labels since they can't be
> interpreted by the host).

Ok, I finally realized that if you unshare the cgroup namespace and
then mount -t cgroup2 none /sys/fs/cgroup, it just mounts the
subdirectory for the cgroup to which your process was already assigned
- it doesn't create a new one. So if you cat /proc/self/cgroup before
doing the unshare -C and subsequently mount -t cgroup2 none
/sys/fs/cgroup, you are getting the same subdirectory that was already
set up by systemd on the host (ls -i of both directories will show the
same inodes). That's why the base files are all being labeled with
host labels, because the directory was created on the host. To avoid
this, you would need to create a new cgroup subdirectory on the host
after unsharing your SELinux namespace, assign your process to that
cgroup, and then unshare the cgroup namespace and mount the cgroup2
filesystem IIUC.

> If/when you get around to moving to enforcing mode, you may need to
> either augment the Android policy with additional allow rules on the
> unlabeled type to permit access to the top-level /sys/fs/cgroup files
> where needed. We can't relabel the files from within the Android
> container because its policy doesn't support userspace labeling of
> cgroup2 files, and relabeling from the host to the Android labels
> would be tricky even if possible - would require that the process
> performing the relabel have CAP_MAC_ADMIN + SELinux mac_admin
> permission to set the xattr to an unknown label and even then I am not
> sure that would propagate to the actual cgroup2 inode within the
> Android container until it is evicted/refreshed.
>
> In any event, I'll toss those three patches on top of my
> working-selinuxns branch but may revisit them later - the last one is
> a bit of a hack and needs further thought, and the first two may have
> performance implications that we should mitigate in the case of only a
> single SELinux namespace.
