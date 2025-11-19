Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A55199252
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550634; cv=none; b=TlFAGAr7dsS3zbcCRH3+/Sub6ZqPfn0/Q8aiP6dHDGDm44hYkZzyMhOzeav7ZCz7fnI7E/wXQM27xvl+GuGywPVBlFKSLcKRkuq0r8P8c4aC0T36jGVvlFGqZAbUdpfOkSCQYPseuDR0F0aT0bvGLHNhocwe0iVE/T/+srziPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550634; c=relaxed/simple;
	bh=IeXLPKU9/YHFwQj750IoGN8lqyFW2mYNGFk11IcP7T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWiSLFfcEb67UVvw+idAoxOPTNZVg4WQYFhvCi2lrF1wWFqPJxIE5FJ2q7ogJoq19GbjWoC2rzLC+2T+65Q4m6Ay7qhV9iK1VMXr9/NX5w60ZTa0KvnDTWDzI+ODF/qRhy0yWLYHJRWZ3YLctTCCkF3LeqJFDQTnZRIHooQHnow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=XUELeLqR; arc=none smtp.client-ip=173.38.203.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="XUELeLqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8992; q=dns/txt;
  s=iport01; t=1763550632; x=1764760232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tmhJar5Q4TWpRxZ+OKrfBSNwN41CvpAgRtH74zHetsA=;
  b=XUELeLqRGhipKrLRS9qLup/4NQGW0nmyYUIvwYObUewsU0GLwljT15SH
   aNZ+hAoJlNhlZc9kCr0FadBaPIUUMZ5gSd2qX8U4tdHrNtEAO172I2+2d
   2jrsOtSemC1k1H48NyQoVYWeqkwZ7y1kcaL7xI6m8LJbUvful5I2W/bmB
   8aT7CGNnNjZ7yLQAUSddYp9CdiJRoXTL0IGM/Rm5kOx7aNhxDdcHtZOU/
   mJOqmUPnVBZF5VSq9kxd2GhqbEIxhqtSVRCm3g1PxEuPvQYW91XC+xeSX
   Bt2bln6cKJlL6dAu8G8peLi9EdOUVnpyAye83JeYNiUWvvWmKzJxYAcpM
   g==;
X-CSE-ConnectionGUID: lqL5NwahSXmNmCfQlXeXUA==
X-CSE-MsgGUID: QCSpEPSSSqK8s3qPA4QGkQ==
X-IPAS-Result: =?us-ascii?q?A0BNBAB0pB1p/81K/pBagQmBUIJHe11DSYRUj1OCIQOSa?=
 =?us-ascii?q?4svgX8PAQEBDzEgBAEBgVODNAKMXAImNAkOAQIEAQEBAQMCAwEBAQEBAQEBA?=
 =?us-ascii?q?QEBCwEBBQEBAQIBBwWBDhOGTw2GWwEBAQMjDwFGEAsYAgImAgJWBhMIgnuCc?=
 =?us-ascii?q?wOuK3qBMoEB3n2BKSxwLohTAYpmJxuCDYQ/PogegmkEgg0VPFKGJ4JxiSmHB?=
 =?us-ascii?q?lJ4HANZLAFLCjUMM21DA4EuSwU3ZRJAIh8rYFRAgUYYggduDwaBEhlJAgICB?=
 =?us-ascii?q?QJAOliBEAYcBhwSAgMBAgI6VQyBBHMCAgSCGH6CCg+IWIEJBUUDeD03FBuVR?=
 =?us-ascii?q?1GBaEQCPFEVBzACJDoRQA4MGSgPDSAPkkIEs3GEJowelVBJA4VFpRCZBqlBg?=
 =?us-ascii?q?Wg8gVkzIhsVO4JnCUkZD44tFoRiwHFFMjwCBwEKAQEDCYI5kS4BAQ?=
IronPort-Data: A9a23:OuAahKt36ZMFIbqQlOgGkfslyufnVFpfMUV32f8akzHdYApBsoF/q
 tZmKWuFa/3bMTT1f9EjbYni9U8PvcfRmIMyTgQ+r3hnRC1BgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGaTdJ5xYuajhJsvva+Us21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw/v9TXEdR/
 PwjGDUrazuNvuaGzYKGY7w57igjBJGD0II3s3x6iDWcBvE8TNWbH+PB5MRT23E7gcUm8fT2P
 pZFL2AyMFKfP1sVYgp/5JEWxI9EglH6fidEs1uOjaE2+GPUigd21dABNfKOJYDXFZQExC50o
 Er/1F/hLykhD+eG6mqeqWuUr7P2siDCDdd6+LqQs6QCbEeo7ncPBQUWWF39uvywjkqzSpRAL
 FYX0iUrpKk2skesS7HVRxSlpFactwMYHt9XFPc3rgqKz8L85AOeHW4NRTNpctEqtMYqAzct0
 zehhN7tBDpyoJWLRn+HsLSZtzW/PW4SN2BqWMMfZQII+Zzn5Yo0lB+KFoolG6+uhdqzEjb1q
 9yXkBUDa3wopZZj/82GEZrv2lpAerChotYJ2zjq
IronPort-HdrOrdr: A9a23:E4Men6CSD5EENALlHemX55DYdb4zR+YMi2TDGXofdfVwSL38qy
 nIpoV+6faUskdyZJhOo7q90cW7LE80sKQFhrX5Xo3SPzUO2lHIEGgK1+KLqAEIWRefygc378
 ldmsZFZOEZyTNB/L/HCM7SKadH/OW6
X-Talos-CUID: 9a23:jeBTd2PGk5jUz+5DXDBDqWgLE8AeQnj7yVzeGkuIBFZUYejA
X-Talos-MUID: 9a23:HTgU4AajmwTMfuBTjhTXnBxaD/xT+of+ExsUqbxaguaHDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,315,1754956800"; 
   d="scan'208";a="37458992"
Received: from aer-l-core-04.cisco.com ([144.254.74.205])
  by aer-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Nov 2025 11:09:20 +0000
Received: from aginor (unknown [10.47.82.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-04.cisco.com (Postfix) with ESMTPS id 2DBDE180001DD;
	Wed, 19 Nov 2025 11:09:20 +0000 (GMT)
Date: Wed, 19 Nov 2025 12:09:19 +0100
From: Martin =?utf-8?Q?Erts=C3=A5s?= <mertsas@cisco.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Subject: Re: SELinux Namespace work
Message-ID: <b2phzphz7lox6neiphbejtydndmgnz53y4jzfzpueffmqsn5im@2to32uoex2cs>
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
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ4sVqtE5FuKrO708UR3towkdc_yAD64ixPZHsazoP_g6A@mail.gmail.com>
X-Outbound-SMTP-Client: 10.47.82.139, [10.47.82.139]
X-Outbound-Node: aer-l-core-04.cisco.com

On Tue, Nov 18, 2025 at 10:55:01AM -0500, Stephen Smalley wrote:
> On Tue, Nov 18, 2025 at 2:00 AM Martin Ertsås <mertsas@cisco.com> wrote:
> >
> > On Mon, Nov 17, 2025 at 09:28:38AM -0500, Stephen Smalley wrote:
> > > On Mon, Nov 17, 2025 at 3:09 AM Martin Ertsås <mertsas@cisco.com> wrote:
> > > >
> > > > On Fri, Nov 14, 2025 at 10:25:38AM -0500, Stephen Smalley wrote:
> > > > > On Fri, Nov 14, 2025 at 9:15 AM Martin Ertsås <mertsas@cisco.com> wrote:
> > > > > > Thank you for the help so far. I have dug quite a bit into an issue with
> > > > > > this together with the cgroup namespace, which is required for running
> > > > > > Android in a container.
> > > > > >
> > > > > > What I see is that before mounting the cgroup namespace, it is labeled
> > > > > > based on the new selinux namespace as expected. But when mounting the
> > > > > > cgroup2 filesystem, some of the labels change to the host labels. This
> > > > > > causes problems, as I on the host have the user system_u, while android
> > > > > > only has u. So when I try to make a subdirectory in the new cgroup, I
> > > > > > get -ENOMEM as selinux can not find a system_u user.
> > > > > >
> > > > > > This is what I can observe:
> > > > > >
> > > > > > # echo 1 > /sys/fs/selinux/unshare
> > > > >
> > > > > Note that my current working-selinuxns branch has switched from the
> > > > > /sys/fs/selinux/unshare interface to the system call-based approach
> > > > > recommended by the discussion on the LSM list so at some point you may
> > > > > need to switch over to using that as well. That however is not
> > > > > relevant to your issue below; I am just mentioning it for your
> > > > > awareness. It remains to be seen what the final upstream API will be.
> > > >
> > > > Yes, I noticed. I will switch to this one as soon as I have a working
> > > > prototype, as this seems to solely be an API change. If the branches
> > > > starts to diverge I would need to swap ASAP though.
> > > >
> > > > > > # unshare -m -n -C -p --fork /tmp/setup_namespace.sh
> > > > > > [cisco:/] $ load_selinux_policy
> > > > > > Loaded selinux policy. Enforcing=0
> > > > > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > > > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 9p
> > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 bpf
> > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 cgroup
> > > > > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 ext4
> > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 fuse
> > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 nfs
> > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 pstore
> > > > > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0                  0 Nov 14 14:05 selinux
> > > > >
> > > > > Looks like your container sysfs mount was labeled per its policy
> > > > > rather than the host policy, as expected. Did you do anything special
> > > > > when mounting sysfs?
> > > >
> > > > No, just did `mount -t sysfs none /sys` I have attached the script and
> > > > the selinux policy.
> > > >
> > > > > > load_selinux_policy-3.2# mount -t cgroup2 none /sys/fs/cgroup
> > > > > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > > > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 9p
> > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 bpf
> > > > > > drwxr-xr-x    2 root     root     system_u:object_r:cgroup_t               0 Nov 14 13:53 cgroup
> > > > > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 ext4
> > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 fuse
> > > > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 nfs
> > > > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 pstore
> > > > > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0                  0 Nov 14 14:05 selinux
> > > > > > load_selinux_policy-3.2# ls -lZ /sys/fs/cgroup/
> > > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.controllers
> > > > > > -r--r--r--    1 root     root     system_u:object_r:cgroup_t               0 Nov 14 13:53 cgroup.events
> > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.freeze
> > > > > > --w-------    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.kill
> > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.max.depth
> > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.max.descendants
> > > > > > -rw-r--r--    1 root     root     system_u:object_r:cgroup_t               0 Nov 14 13:53 cgroup.procs
> > > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.stat
> > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.subtree_control
> > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.threads
> > > > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.type
> > > > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cpu.stat
> > > > >
> > > > > That's very odd indeed - I would expect them all to be labeled based
> > > > > on either the container policy or the host policy, not a mix of the
> > > > > two. cgroup2 and sysfs are both kernfs-based so I'm wondering how/why
> > > > > they differ.
> > > >
> > > > My suspicion is that since the cgroup namespace gives you a subhierarchy
> > > > view of the host cgroup hierarchy, the superblock is reused as for
> > > > cgroup it's actually the same hierarchy. Just with a different root.
> > > > While the sysfs is a completely new sys mount. But I'm not 100% sure.
> > > >
> > > > I will dig into why some, like cgroup.subtree_control, are labeled with
> > > > the new selinux policy, while others are labeled with the host selinux policy.
> > > >
> > > > > > load_selinux_policy-3.2# mkdir /sys/fs/cgroup/foo
> > > > > > mkdir: can't create directory '/sys/fs/cgroup/foo': Cannot allocate memory
> > > > > > load_selinux_policy-3.2#
> > > > > >
> > > > > > The setup_namespace just creates a new rootfs and mounts the android
> > > > > > container and selinux policy into that. And load_selinux_policy is just a wrapper that loads the android selinux policy.
> > > > > >
> > > > > > What I have traced it down to is that when kernfs_get_tree from
> > > > > > fs/kernfs/mount.c is mounting the cgroup, the superblock is reused from
> > > > > > the old cgroup namespace, which also has the security context from the
> > > > > > old selinux namespace. This causes the labels to be mixed as shown
> > > > > > above. This doesn't seem to involve SELinux code directly, but just the
> > > > > > kernfs code.
> > > > > >
> > > > > > Should the kernfs test function for the superblock involve checking the
> > > > > > security context as well? Not sure what a proper fix for this would be?
> > > > > > Or if I'm missunderstanding something and doing something fundamentally
> > > > > > wrong here?
> > > > >
> > > > > First I'd like to understand why it seems to be working for sysfs but
> > > > > not cgroup2 since they are both kernfs-based. What's different between
> > > > > the two?
> > > > > And since you unshared the cgroup namespace, why doesn't that trigger
> > > > > a new superblock creation by itself? It's better if we can avoid
> > > > > introducing a special check just for SELinux/LSM here.
> > > >
> > > > Good questions. I think I answered my hunch on these above, but I'm
> > > > truly not sure. I have attached the setup_namespace.sh script I use so
> > > > you can see, as well as the selinux policy I load.
> > >
> > > And just to confirm, is your load_selinux_policy just a program that
> > > does the equivalent of open+fstat+mmap+security_load_policy() on the
> > > Android policy file?
> >
> > Correct, that's all it does.
> 
> I'm going to assume that forcing creation of a new superblock for the
> cgroup2 mount would introduce other problems for cgroup2 since I don't
> see that happening even for cgroup2 mounts in systemd-nspawn
> containers. I've just sent a series of patches that appear to help
> with the cgroup2 labeling and allow mkdir to work, although I still
> see mixed labeling at the top-level and am not sure if there are
> shared inodes between the host and container cgroup2 mounts that will
> effectively fight over the one inode label. If this approach doesn't
> work, then we may want to revisit creating a new superblock if
> possible. Regardless, it would be better to mount the new cgroup2
> filesystem _after_ loading the Android policy so that its inodes are
> labeled based on that policy rather than the host policy from the
> beginning.

Thank you. I just tried with your patches applied, and now I can create
the cgroup subdirectories. It's still a mix of labels I see, also when
mounting it after loading the selinux policy, but currently it doesn't
seem like it's causing any issues.
