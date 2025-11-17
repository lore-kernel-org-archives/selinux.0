Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623073346B6
	for <selinux@vger.kernel.org>; Mon, 17 Nov 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389732; cv=none; b=MpqaYJquhdSZp+vIOpfpZWbAUbrKJ6wnW8AhFpuh1UlpFlt9I6aYUIxVx3Dius4KKvhrJIzKgEhf7OAIku889OVlV/AK4+QwxCYcuV3j93q/Y30jquCVZBHEz7oCkRonu9vkYEtg5E1/qAAQA5trta2MCJXzkh7S613xOt5IIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389732; c=relaxed/simple;
	bh=plrF1OpVfIeXGp9emgsMzur+7bvAc/Kf7qEekcQZn60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOHcO37c/tK78QV+I5EQJK9iD/cmx1nuyQhFLfzHWD3SMQCEdEIy3W2jKBaejZdGRiXIV83FU9BoSq/KQffd6Tc+Kub6DQ7mpfX/+1Oex2JhWhCMpAXAEJ3+zGtjkMb1cUhfPj3jnG+ZzjN9WAZwJNir6UmsfWCLrB18kRh/Hl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHIKUxTk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHIKUxTk"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3437af8444cso4490964a91.2
        for <selinux@vger.kernel.org>; Mon, 17 Nov 2025 06:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763389729; x=1763994529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mlf6u5Mio8lLAhcHMozUj13WcoUNeli21y7DvtWTkE=;
        b=ZHIKUxTkmPgnyDykVg2E9pOgwMwxCpIYBx2zXsvfSyc7kDG6Gbk50cwUS5B/dBDZfO
         sdS15gE+o42B3Tp3J5X5SJcvyz9TJ4EdTeJHIMWIAq7zAw2x+mSBJB8SkPX+mkYit2eX
         2QHaxaW4xA2K0Mo4BfK+HVd8kRnWOygNOPgXXoG7bfUhP+3NuoVxl2fkt0s2f3iWZpi2
         GswE7/XFSFV6ix8SbJ4g6A5RgMYNA0QPivux0GtF5FDZbBIuZYh1D5dOw8Oehu8OqTw0
         Ln7Ss/UYgraE8v7TCUqSlA7xqgVCTPl1ytT+h/LiiWeURRn7h9Tvoo5nXU087NMeAJsh
         IxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763389729; x=1763994529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mlf6u5Mio8lLAhcHMozUj13WcoUNeli21y7DvtWTkE=;
        b=Yn+5h3xc7KHyABhzO6yWF/NLTZIJHsFnzdnAdCMRKfauSvQcGnkx97MBdHUB9lvClM
         sLtg8/DoR7mIlgFd91JEbR5CVhh4Lxj7LG1UC7FYKHAOupONPw7US7wz/WO5CtIO1GpM
         Ko87DTFYP0pydJfK3hXesWPTadWeK/qTGwk3dRkYJ5OdUEHRzjH22sM50ci9Bb7rs30y
         CH0i+LvFBAnJQW37EkYa6Z9nr7UFUxMsMYZsmW6WOdrs+rPe+7TyaYtbspVh7fg/bXGo
         gHujae0p+jG8m6Wi6DJbRmBEwm/8YjJ8/oaMAiRHxjxJcS2PGHOHRCqAOkVfUw/Nbo6n
         013g==
X-Gm-Message-State: AOJu0YwX3+vPRQJcUsLSWkmYI1E/DbHPggJZCC1YT3ks2scukGYiwlV3
	tOCFa0LAwtVNnZZkNiSmv3zPoXy5jvuJW63iS/1iGKKjQTzeMmo/sz2SALalMWR7ImvrqFIpXzP
	uAsSwoe3L8/rDxmLl/P21P6vYjXtHL7E=
X-Gm-Gg: ASbGncteDKXoDb8e+mTa8mzFeICRsHEnbR77qowUGhAxHuJ1lSdBhiJ5B9iq6Xp5yvi
	LM7rAATM9Y4h/ttS0c5PErGV9mz3+vdFmkw1zTBlLPSpCmQSRlSCursHZ7OFBwwlfXK0xQDTxvA
	Hacy7Up7AKPPlM+FVDuTQZogaBUo2gpJ3NS7pn6gwizZZ0ySLC93uhXl1Tz3CJ7ZEaEJ3vdMwgw
	hLHW6Ski7P27fvSg2ISPFYzKHj3HQmIQxoGPkrDxBrd6l9z1NSuN0dvy81be+M86Ch7YN0=
X-Google-Smtp-Source: AGHT+IFkMWeEdFlSGiqzcPanRNtG7Z9z/7CIvmZp0tn6BEmkeBZUIgRVUINPmnCJ8SCfnO/xa5yFLu9uErdQWJlvN3A=
X-Received: by 2002:a17:90b:2fcf:b0:340:c179:3666 with SMTP id
 98e67ed59e1d1-343f9e92a3emr12670139a91.8.1763389729381; Mon, 17 Nov 2025
 06:28:49 -0800 (PST)
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
 <CAEjxPJ4xff=wfvVpnSNuydWN4k1TX6f8GtBtWmv_Fc7yKMZaUA@mail.gmail.com> <54p5qlyfsj5twmuacf6nqmzaandshs34uwq7vdjycpcl4okgsw@fcovtdadvhlt>
In-Reply-To: <54p5qlyfsj5twmuacf6nqmzaandshs34uwq7vdjycpcl4okgsw@fcovtdadvhlt>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Nov 2025 09:28:38 -0500
X-Gm-Features: AWmQ_bkZy8XyBw1i7whe5e9QmruVABQ5_V4DapWjIj_uMjIucV_j5ahHZbGn164
Message-ID: <CAEjxPJ4Ho+BFQ2Br6ajE0wF0Ueha04Z-EK45Fb3+2VC4hEVZBA@mail.gmail.com>
Subject: Re: SELinux Namespace work
To: =?UTF-8?Q?Martin_Erts=C3=A5s?= <mertsas@cisco.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 3:09=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cisco.c=
om> wrote:
>
> On Fri, Nov 14, 2025 at 10:25:38AM -0500, Stephen Smalley wrote:
> > On Fri, Nov 14, 2025 at 9:15=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cis=
co.com> wrote:
> > > Thank you for the help so far. I have dug quite a bit into an issue w=
ith
> > > this together with the cgroup namespace, which is required for runnin=
g
> > > Android in a container.
> > >
> > > What I see is that before mounting the cgroup namespace, it is labele=
d
> > > based on the new selinux namespace as expected. But when mounting the
> > > cgroup2 filesystem, some of the labels change to the host labels. Thi=
s
> > > causes problems, as I on the host have the user system_u, while andro=
id
> > > only has u. So when I try to make a subdirectory in the new cgroup, I
> > > get -ENOMEM as selinux can not find a system_u user.
> > >
> > > This is what I can observe:
> > >
> > > # echo 1 > /sys/fs/selinux/unshare
> >
> > Note that my current working-selinuxns branch has switched from the
> > /sys/fs/selinux/unshare interface to the system call-based approach
> > recommended by the discussion on the LSM list so at some point you may
> > need to switch over to using that as well. That however is not
> > relevant to your issue below; I am just mentioning it for your
> > awareness. It remains to be seen what the final upstream API will be.
>
> Yes, I noticed. I will switch to this one as soon as I have a working
> prototype, as this seems to solely be an API change. If the branches
> starts to diverge I would need to swap ASAP though.
>
> > > # unshare -m -n -C -p --fork /tmp/setup_namespace.sh
> > > [cisco:/] $ load_selinux_policy
> > > Loaded selinux policy. Enforcing=3D0
> > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 9p
> > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 bpf
> > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 cgroup
> > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 ext4
> > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 fuse
> > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 nfs
> > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 pstore
> > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0            =
      0 Nov 14 14:05 selinux
> >
> > Looks like your container sysfs mount was labeled per its policy
> > rather than the host policy, as expected. Did you do anything special
> > when mounting sysfs?
>
> No, just did `mount -t sysfs none /sys` I have attached the script and
> the selinux policy.
>
> > > load_selinux_policy-3.2# mount -t cgroup2 none /sys/fs/cgroup
> > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 9p
> > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 bpf
> > > drwxr-xr-x    2 root     root     system_u:object_r:cgroup_t         =
      0 Nov 14 13:53 cgroup
> > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 ext4
> > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 fuse
> > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 nfs
> > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                =
      0 Nov 14 14:05 pstore
> > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0            =
      0 Nov 14 14:05 selinux
> > > load_selinux_policy-3.2# ls -lZ /sys/fs/cgroup/
> > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0            =
      0 Nov 14 13:53 cgroup.controllers
> > > -r--r--r--    1 root     root     system_u:object_r:cgroup_t         =
      0 Nov 14 13:53 cgroup.events
> > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0            =
      0 Nov 14 13:53 cgroup.freeze
> > > --w-------    1 root     root     u:object_r:unlabeled:s0            =
      0 Nov 14 13:53 cgroup.kill
> > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0            =
      0 Nov 14 13:53 cgroup.max.depth
> > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0            =
      0 Nov 14 13:53 cgroup.max.descendants
> > > -rw-r--r--    1 root     root     system_u:object_r:cgroup_t         =
      0 Nov 14 13:53 cgroup.procs
> > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0            =
      0 Nov 14 13:53 cgroup.stat
> > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0            =
      0 Nov 14 13:53 cgroup.subtree_control
> > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0            =
      0 Nov 14 13:53 cgroup.threads
> > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0            =
      0 Nov 14 13:53 cgroup.type
> > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0            =
      0 Nov 14 13:53 cpu.stat
> >
> > That's very odd indeed - I would expect them all to be labeled based
> > on either the container policy or the host policy, not a mix of the
> > two. cgroup2 and sysfs are both kernfs-based so I'm wondering how/why
> > they differ.
>
> My suspicion is that since the cgroup namespace gives you a subhierarchy
> view of the host cgroup hierarchy, the superblock is reused as for
> cgroup it's actually the same hierarchy. Just with a different root.
> While the sysfs is a completely new sys mount. But I'm not 100% sure.
>
> I will dig into why some, like cgroup.subtree_control, are labeled with
> the new selinux policy, while others are labeled with the host selinux po=
licy.
>
> > > load_selinux_policy-3.2# mkdir /sys/fs/cgroup/foo
> > > mkdir: can't create directory '/sys/fs/cgroup/foo': Cannot allocate m=
emory
> > > load_selinux_policy-3.2#
> > >
> > > The setup_namespace just creates a new rootfs and mounts the android
> > > container and selinux policy into that. And load_selinux_policy is ju=
st a wrapper that loads the android selinux policy.
> > >
> > > What I have traced it down to is that when kernfs_get_tree from
> > > fs/kernfs/mount.c is mounting the cgroup, the superblock is reused fr=
om
> > > the old cgroup namespace, which also has the security context from th=
e
> > > old selinux namespace. This causes the labels to be mixed as shown
> > > above. This doesn't seem to involve SELinux code directly, but just t=
he
> > > kernfs code.
> > >
> > > Should the kernfs test function for the superblock involve checking t=
he
> > > security context as well? Not sure what a proper fix for this would b=
e?
> > > Or if I'm missunderstanding something and doing something fundamental=
ly
> > > wrong here?
> >
> > First I'd like to understand why it seems to be working for sysfs but
> > not cgroup2 since they are both kernfs-based. What's different between
> > the two?
> > And since you unshared the cgroup namespace, why doesn't that trigger
> > a new superblock creation by itself? It's better if we can avoid
> > introducing a special check just for SELinux/LSM here.
>
> Good questions. I think I answered my hunch on these above, but I'm
> truly not sure. I have attached the setup_namespace.sh script I use so
> you can see, as well as the selinux policy I load.

And just to confirm, is your load_selinux_policy just a program that
does the equivalent of open+fstat+mmap+security_load_policy() on the
Android policy file?
