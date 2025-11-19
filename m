Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB614F881
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560833; cv=none; b=QpdT67mK5PnouWSFf0cDk+sBlspL6M6JPFABJNGqpdH8c4LWl4cP+EylBjs2//T51z5E9vEvcS9aLGzKSyNx6aN5030SyIaAcce4OtJZcVxQ+ISQRTDFp1P3am3qKFeJEudCKMXwkf2arWS+CnEwx4m/O+wpjhOmvcw85aBhGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560833; c=relaxed/simple;
	bh=ozCZG02hZ+/TA7i1mWkDPBvoA2mPPHm+/gIz8iz4boY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMVkarLM4CfZrUFhKLHKwZLRazKeHZBYmRkeTmDrkQAZ4ONvE/gGksKZHzuGWP9ygbO66YdrYxKmRGsuZP/OwR1jo7QlJJkqiKgo8ysKKw5s8+7L2z7Hj+L79pxkSjZqJ1lAIJiVRo50+j7Q4yLXRTKehNsBy0Zgq3h8sH6LR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV5pM/Kj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV5pM/Kj"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3436a97f092so8577856a91.3
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 06:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763560831; x=1764165631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4AkP+bopYXKbyditMM0amfKECcjSUj1C0vkLlhxqRc=;
        b=eV5pM/KjS8mRfds1FK8PQ41HCiX0ACehIZuXZjWJHJQCu0ZSdJKmWsiriq2+4U0edQ
         Msc4gsiAUVImteCD8WFhMCw0Rmbz+ldCFG/0Jj/wiXwc33QEQX0PUmT3HSiRH0RTr0zT
         s7sKobANRj4+mdP0Dkmn/iQnP+V31RlEsiott63ay8dyMKVvMjK8czi6zT12EH/QCNgR
         FB5F8bsVHQ0gLYbuNhIqoN9O7319Y7YWXMqkZqkPQomObZZDoarf8BS2ZR/UQEOK6BzL
         iFDZW0rhR3rEdvgQvW89GkAPRl/5HkWhqSQ1B/q2QXd5L8YsP+GOiESgszOqLhyFTWwf
         MaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560831; x=1764165631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4AkP+bopYXKbyditMM0amfKECcjSUj1C0vkLlhxqRc=;
        b=owjtZADUprgxKGDwPRuQadhRwIfEjdKxIWNRrx0OS9vCAAYardkhc6jtXzSAiH/J6Q
         DO5kVe7FWpMlhNw5h8K5+FDNEUw+nqYG41/+8frKU0izkihxMMZFClt04ufqfpmR787C
         EENtgJCPj/FRvnLqCOq2bTmlK4ZjCZ+9jSgUm5Fxkv3GqTt+vNLPZod3VscczUMOeWqs
         IWzUm2XyV/fZblmt8khh2/TEQqLY9j/RNFWVT+Ywb4hQ+d8U9wAg7tBTyeJ6RieBTZZE
         /VDYnh8UcG/v00SCue34jtVwcNd/qHjq97NZrHHnZgFsp8cq4/PqRFoN6SdFVG7S4KaY
         rpXQ==
X-Gm-Message-State: AOJu0YzOi/gnSTgUfYKjybn8m8IsQMlKduIqNr/kLLiJXDGW5wKZBtGO
	JlowM7vXjWUumOIcj71lAlH9my5PnLsie95ZoO3Y0bzrpAJC9y4BzFodz312qCuxbloWL0GNXV7
	IelLIF0dA5MFZx8WaD/SO2djICdT0e8E=
X-Gm-Gg: ASbGncv7VbhchdnQgQuthm3sN0ZHUwqg4TwKYf6AEPbWZTWoW6uSsjK9jAwQuiweALh
	MdZ3wmeTRhq7SMHph2Kh1uXjAm+/fQi+SgjorAqSZqhUMv1wo5UBdVzHlAUZyc5nj3bcve68agz
	IPfmYWozZQqpIzea13KWUeXto+f3pRCUpQHZ16eG7GjsnhM/Z10EWt8Iahel0vmLL/K5oE79hsK
	SNsU4C+Iwf1gLvGD9OnUgC6e+OB86TmX6OJfQLD1Bd6n/Y84/5f6TsAGRu1z+6Kyif+zUw=
X-Google-Smtp-Source: AGHT+IHiikl6jSoslZBZOgNcbKamR/GtRX2ttuldrPFqhP+gpAbsHnbKn52aTiFf0Loo/ZeY3s3Os1yxmwBgmCA9qL8=
X-Received: by 2002:a17:90a:ec84:b0:336:9dcf:ed14 with SMTP id
 98e67ed59e1d1-343fa52bea5mr23822177a91.23.1763560829888; Wed, 19 Nov 2025
 06:00:29 -0800 (PST)
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
 <CAEjxPJ4sVqtE5FuKrO708UR3towkdc_yAD64ixPZHsazoP_g6A@mail.gmail.com> <b2phzphz7lox6neiphbejtydndmgnz53y4jzfzpueffmqsn5im@2to32uoex2cs>
In-Reply-To: <b2phzphz7lox6neiphbejtydndmgnz53y4jzfzpueffmqsn5im@2to32uoex2cs>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Nov 2025 09:00:18 -0500
X-Gm-Features: AWmQ_blAuhNE-Y6fuREo3qcLQlRs-AaW52JQJRHSIzTPZ6xr7S4MojcnAcWqtd8
Message-ID: <CAEjxPJ6P3NMfdw4t4E0dVvLsBAE+YEmgYkS+pRqYgDfApcv6Eg@mail.gmail.com>
Subject: Re: SELinux Namespace work
To: =?UTF-8?Q?Martin_Erts=C3=A5s?= <mertsas@cisco.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 6:09=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cisco.c=
om> wrote:
>
> On Tue, Nov 18, 2025 at 10:55:01AM -0500, Stephen Smalley wrote:
> > On Tue, Nov 18, 2025 at 2:00=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cis=
co.com> wrote:
> > >
> > > On Mon, Nov 17, 2025 at 09:28:38AM -0500, Stephen Smalley wrote:
> > > > On Mon, Nov 17, 2025 at 3:09=E2=80=AFAM Martin Erts=C3=A5s <mertsas=
@cisco.com> wrote:
> > > > >
> > > > > On Fri, Nov 14, 2025 at 10:25:38AM -0500, Stephen Smalley wrote:
> > > > > > On Fri, Nov 14, 2025 at 9:15=E2=80=AFAM Martin Erts=C3=A5s <mer=
tsas@cisco.com> wrote:
> > > > > > > Thank you for the help so far. I have dug quite a bit into an=
 issue with
> > > > > > > this together with the cgroup namespace, which is required fo=
r running
> > > > > > > Android in a container.
> > > > > > >
> > > > > > > What I see is that before mounting the cgroup namespace, it i=
s labeled
> > > > > > > based on the new selinux namespace as expected. But when moun=
ting the
> > > > > > > cgroup2 filesystem, some of the labels change to the host lab=
els. This
> > > > > > > causes problems, as I on the host have the user system_u, whi=
le android
> > > > > > > only has u. So when I try to make a subdirectory in the new c=
group, I
> > > > > > > get -ENOMEM as selinux can not find a system_u user.
> > > > > > >
> > > > > > > This is what I can observe:
> > > > > > >
> > > > > > > # echo 1 > /sys/fs/selinux/unshare
> > > > > >
> > > > > > Note that my current working-selinuxns branch has switched from=
 the
> > > > > > /sys/fs/selinux/unshare interface to the system call-based appr=
oach
> > > > > > recommended by the discussion on the LSM list so at some point =
you may
> > > > > > need to switch over to using that as well. That however is not
> > > > > > relevant to your issue below; I am just mentioning it for your
> > > > > > awareness. It remains to be seen what the final upstream API wi=
ll be.
> > > > >
> > > > > Yes, I noticed. I will switch to this one as soon as I have a wor=
king
> > > > > prototype, as this seems to solely be an API change. If the branc=
hes
> > > > > starts to diverge I would need to swap ASAP though.
> > > > >
> > > > > > > # unshare -m -n -C -p --fork /tmp/setup_namespace.sh
> > > > > > > [cisco:/] $ load_selinux_policy
> > > > > > > Loaded selinux policy. Enforcing=3D0
> > > > > > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > > > > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 9p
> > > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 bpf
> > > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 cgroup
> > > > > > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 ext4
> > > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 fuse
> > > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 nfs
> > > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 pstore
> > > > > > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0    =
              0 Nov 14 14:05 selinux
> > > > > >
> > > > > > Looks like your container sysfs mount was labeled per its polic=
y
> > > > > > rather than the host policy, as expected. Did you do anything s=
pecial
> > > > > > when mounting sysfs?
> > > > >
> > > > > No, just did `mount -t sysfs none /sys` I have attached the scrip=
t and
> > > > > the selinux policy.
> > > > >
> > > > > > > load_selinux_policy-3.2# mount -t cgroup2 none /sys/fs/cgroup
> > > > > > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > > > > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 9p
> > > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 bpf
> > > > > > > drwxr-xr-x    2 root     root     system_u:object_r:cgroup_t =
              0 Nov 14 13:53 cgroup
> > > > > > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 ext4
> > > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 fuse
> > > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 nfs
> > > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0        =
              0 Nov 14 14:05 pstore
> > > > > > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0    =
              0 Nov 14 14:05 selinux
> > > > > > > load_selinux_policy-3.2# ls -lZ /sys/fs/cgroup/
> > > > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0    =
              0 Nov 14 13:53 cgroup.controllers
> > > > > > > -r--r--r--    1 root     root     system_u:object_r:cgroup_t =
              0 Nov 14 13:53 cgroup.events
> > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0    =
              0 Nov 14 13:53 cgroup.freeze
> > > > > > > --w-------    1 root     root     u:object_r:unlabeled:s0    =
              0 Nov 14 13:53 cgroup.kill
> > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0    =
              0 Nov 14 13:53 cgroup.max.depth
> > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0    =
              0 Nov 14 13:53 cgroup.max.descendants
> > > > > > > -rw-r--r--    1 root     root     system_u:object_r:cgroup_t =
              0 Nov 14 13:53 cgroup.procs
> > > > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0    =
              0 Nov 14 13:53 cgroup.stat
> > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0    =
              0 Nov 14 13:53 cgroup.subtree_control
> > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0    =
              0 Nov 14 13:53 cgroup.threads
> > > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0    =
              0 Nov 14 13:53 cgroup.type
> > > > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0    =
              0 Nov 14 13:53 cpu.stat
> > > > > >
> > > > > > That's very odd indeed - I would expect them all to be labeled =
based
> > > > > > on either the container policy or the host policy, not a mix of=
 the
> > > > > > two. cgroup2 and sysfs are both kernfs-based so I'm wondering h=
ow/why
> > > > > > they differ.
> > > > >
> > > > > My suspicion is that since the cgroup namespace gives you a subhi=
erarchy
> > > > > view of the host cgroup hierarchy, the superblock is reused as fo=
r
> > > > > cgroup it's actually the same hierarchy. Just with a different ro=
ot.
> > > > > While the sysfs is a completely new sys mount. But I'm not 100% s=
ure.
> > > > >
> > > > > I will dig into why some, like cgroup.subtree_control, are labele=
d with
> > > > > the new selinux policy, while others are labeled with the host se=
linux policy.
> > > > >
> > > > > > > load_selinux_policy-3.2# mkdir /sys/fs/cgroup/foo
> > > > > > > mkdir: can't create directory '/sys/fs/cgroup/foo': Cannot al=
locate memory
> > > > > > > load_selinux_policy-3.2#
> > > > > > >
> > > > > > > The setup_namespace just creates a new rootfs and mounts the =
android
> > > > > > > container and selinux policy into that. And load_selinux_poli=
cy is just a wrapper that loads the android selinux policy.
> > > > > > >
> > > > > > > What I have traced it down to is that when kernfs_get_tree fr=
om
> > > > > > > fs/kernfs/mount.c is mounting the cgroup, the superblock is r=
eused from
> > > > > > > the old cgroup namespace, which also has the security context=
 from the
> > > > > > > old selinux namespace. This causes the labels to be mixed as =
shown
> > > > > > > above. This doesn't seem to involve SELinux code directly, bu=
t just the
> > > > > > > kernfs code.
> > > > > > >
> > > > > > > Should the kernfs test function for the superblock involve ch=
ecking the
> > > > > > > security context as well? Not sure what a proper fix for this=
 would be?
> > > > > > > Or if I'm missunderstanding something and doing something fun=
damentally
> > > > > > > wrong here?
> > > > > >
> > > > > > First I'd like to understand why it seems to be working for sys=
fs but
> > > > > > not cgroup2 since they are both kernfs-based. What's different =
between
> > > > > > the two?
> > > > > > And since you unshared the cgroup namespace, why doesn't that t=
rigger
> > > > > > a new superblock creation by itself? It's better if we can avoi=
d
> > > > > > introducing a special check just for SELinux/LSM here.
> > > > >
> > > > > Good questions. I think I answered my hunch on these above, but I=
'm
> > > > > truly not sure. I have attached the setup_namespace.sh script I u=
se so
> > > > > you can see, as well as the selinux policy I load.
> > > >
> > > > And just to confirm, is your load_selinux_policy just a program tha=
t
> > > > does the equivalent of open+fstat+mmap+security_load_policy() on th=
e
> > > > Android policy file?
> > >
> > > Correct, that's all it does.
> >
> > I'm going to assume that forcing creation of a new superblock for the
> > cgroup2 mount would introduce other problems for cgroup2 since I don't
> > see that happening even for cgroup2 mounts in systemd-nspawn
> > containers. I've just sent a series of patches that appear to help
> > with the cgroup2 labeling and allow mkdir to work, although I still
> > see mixed labeling at the top-level and am not sure if there are
> > shared inodes between the host and container cgroup2 mounts that will
> > effectively fight over the one inode label. If this approach doesn't
> > work, then we may want to revisit creating a new superblock if
> > possible. Regardless, it would be better to mount the new cgroup2
> > filesystem _after_ loading the Android policy so that its inodes are
> > labeled based on that policy rather than the host policy from the
> > beginning.
>
> Thank you. I just tried with your patches applied, and now I can create
> the cgroup subdirectories. It's still a mix of labels I see, also when
> mounting it after loading the selinux policy, but currently it doesn't
> seem like it's causing any issues.

I believe the kernfs nodes for the cgroup2 files that have host labels
are initially being created by the kernel before the Android policy is
loaded and therefore still inherit the parent directory xattr which
was based on the host policy. Not sure if there is something further
we can do in the kernel to avoid this. I tried moving the Android
policy load earlier (before the unsharing of the cgroup namespace) but
that didn't appear to help. Need to track down exactly when these
kernfs nodes are created and whether they are shared across multiple
cgroup2 mounts.

In my testing, if the host is permissive, then I see a mix of host and
Android labels (i.e. system_u:object_r:cgroup_t:s0 and
u:object_r:cgroup_v2:s0) but if the host is enforcing, then they are
all shown as Android labels but the ones that had the host labels when
permissive are shown as u:object_r:unlabeled:s0. This makes sense
since if the host is permissive and we are running as root (with
CAP_MAC_ADMIN), the kernel will return raw contexts/xattrs on
getxattr(2) even if they can't be mapped to a valid context in the
current policy; otherwise the kernel will return the unlabeled context
as defined by the current policy. I found that on the host, the new
cgroup tree is visible under /sys/fs/cgroup/user.slice/user-NNNN.slice
and on the host, it is similarly a mix of cgroup_t and unlabeled_t
(unlabeled_t for the ones with Android labels since they can't be
interpreted by the host).

If/when you get around to moving to enforcing mode, you may need to
either augment the Android policy with additional allow rules on the
unlabeled type to permit access to the top-level /sys/fs/cgroup files
where needed. We can't relabel the files from within the Android
container because its policy doesn't support userspace labeling of
cgroup2 files, and relabeling from the host to the Android labels
would be tricky even if possible - would require that the process
performing the relabel have CAP_MAC_ADMIN + SELinux mac_admin
permission to set the xattr to an unknown label and even then I am not
sure that would propagate to the actual cgroup2 inode within the
Android container until it is evicted/refreshed.

In any event, I'll toss those three patches on top of my
working-selinuxns branch but may revisit them later - the last one is
a bit of a hack and needs further thought, and the first two may have
performance implications that we should mitigate in the case of only a
single SELinux namespace.
