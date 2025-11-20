Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832FD26E161
	for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625924; cv=none; b=o0mm7ArNcty/8dpeWr3bvfQfqnlScW2Fkn8LM7Kv9Lc2gHBi1PDkO7nMrBruJuoXZy2dyw8WSeARRHCR2byVlGGcrx4wt6dk7C79keEi/P2hfDG6JInGNa6WQN8ovLEecieBuPNBxy9J4rLFTlzOnvutlvonkvOR00hnC0R3SAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625924; c=relaxed/simple;
	bh=YSCtUINccV2YLDCEKKBf346dd/wbzmvMnuqxQzEBtAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwGULs9zedux+edzhAypIdD93XUuodpd+m+qbg1t1oc4jUIcdjPCi7Z6QrZm7Bfqb+Zy/IUXseNFOojKhrML+eNeL6RVPmn6dgbn3r6/suhhu2IA6EsXB6CS00gLPLrRyV3CJNJEBTpIzwDHdDcSoHzixq59VXvXMboOo7rmTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=cxD0Kcyn; arc=none smtp.client-ip=173.38.203.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="cxD0Kcyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6400; q=dns/txt;
  s=iport01; t=1763625922; x=1764835522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/wbTF0ybROGNGclQlfvJh6YfbBCLFvjSRmKehmR2HdY=;
  b=cxD0KcynGWvTJ+T+5xxq0TbYynywLRrbU+KRVwHy6gM4nxousgrbrVx+
   +WBa+BmbVVQy5Rvs2/0NT4M5bN7ORaATPwASlUfvqe23Rwcx6zM0rATF/
   YtF3VThCziJdgjUlfkKnZu45V5qBY7OWvpiaDCyyMozF2bV3psJDCmA0D
   CS8yZd8H0/K4vu4CXmy2sV0iFuHTJv1mGUEwxFNxfYXwC4nfl0jomn1hh
   IOiyfrUIkRBSQcWsj7ysVz0hBlhfJ7Oo0BZ8CIRmXBWIudfU5abxFlPyy
   sYQ01s6y93zXQ9EUhRU8Xm4gtvlYJw/31ya9BuIOo6Ot824mlB1AqkFgv
   w==;
X-CSE-ConnectionGUID: /S6n1735Q+ChZvhofXQ4Ig==
X-CSE-MsgGUID: zwzVX3vBQ2aY9KxvNTqvVg==
X-IPAS-Result: =?us-ascii?q?A0CWCwBSyx5p/81K/pBagQmBUIJHe11DSYRUj1OCIQOLZ?=
 =?us-ascii?q?IcHiy+Bfw8BAQEPNxoEAQGBU4M0AoxdAiY1CA4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEFAQEBAgEHBYEOE4ZPDYZbAQEBAyMPAUYQCxgCAiYCAiA2BhMIg?=
 =?us-ascii?q?nuCOgM2A7I7eoEygQHdPg2BMoEpLHAuiDQfAYpmJxuCDYEVgyo+gh+Ff4JpB?=
 =?us-ascii?q?IINFTxSgXqELYJxiSmHClJ4HANZLAFLCjUMM21DA4EuSwU3ZRJAIh8pYFRAg?=
 =?us-ascii?q?UYYggduDwaBEhlJAgICBQJAOliBEAYcBhwSAgMBAgI6VQyBBHMCAgSCGH6CC?=
 =?us-ascii?q?g+IWIEJBSMvA3g9NxQblUxRgmpSFIESUgQyOA0GKZJGswBxhCaMHo89hhNJA?=
 =?us-ascii?q?4VFpRCZBpIRlzCBagM3gVkzIhsVgyIJSRkPji0WhGKBBcBcRTICOgIHAQoBA?=
 =?us-ascii?q?QMJgjmRLgEB?=
IronPort-Data: A9a23:5GJ9tqzczHKQ/1Sv1516t+c7xyrEfRIJ4+MujC+fZmUNrF6WrkUOy
 mEdUTiEbKzcM2HxfYtyaom3oxtTvsXcyYRhQQc/qVhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/VH1buSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 IKaT/H3Ygf/hmctaDpMsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJAYNY4tBpb0qOCJl9
 c4GKDcDXinfpu3jldpXSsE07igiBMDmJsYb/3pn1zycVapgSpHYSKKM7thdtNsyrpkSQbCEO
 pZfNmYpNkydC/FMEg9/5JYWmeqymmL2aBVTqUmeouw85G27IAlZi+ayaYaNJYTiqcN9jFmKm
 FKd4U7AWBgrZf+P1xy562ySibqa9c/8cMdIfFGizdZxnFCLxmEVTgYTXF+/rOj/lUmkWPpQL
 kUV/mwlqq1a3FSiU93VRxSlpDuBuRkGVpxbFOhSwAaIzbHS6g2ULnIJQj5IdJots8pebScn0
 l6PgsPBGzNiqvuWRGib+7PSqim9URX5NkcLaDVBSU4O5MPu5dlvyBnOVd1kVqWyi7UZBA3N/
 txDlwBm7517sCLB//zTEYzv6950mqX0cw==
IronPort-HdrOrdr: A9a23:JGyZXamu0OJpkX4D7C8Qod1RL6fpDfIX3DAbv31ZSRFFG/FwWf
 rAoB0+726QtN93YgBFpTngAtjjfZqyz/RICOUqUItKGTOW31dAT7sSjrcKoQeAJ8SWzIc0vp
 uIMZIfNDSaNzZHZKjBjDVR170bsaC6GGfCv5a580tQ
X-Talos-CUID: 9a23:VxzfGmGqwz2Gu2SpqmIgzxASQ59+L0Se53fiPU+/B1ZQFJyaHAo=
X-Talos-MUID: 9a23:3gCftgVZ1sQc91nq/C3zlg9Sb9lC2v6nOREugYsgh9CaCyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,317,1754956800"; 
   d="scan'208";a="36714070"
Received: from aer-l-core-04.cisco.com ([144.254.74.205])
  by aer-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 20 Nov 2025 08:05:12 +0000
Received: from perrin (unknown [10.48.246.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-04.cisco.com (Postfix) with ESMTPS id 5AE7C18000348;
	Thu, 20 Nov 2025 08:05:12 +0000 (GMT)
Date: Thu, 20 Nov 2025 09:05:11 +0100
From: Martin =?utf-8?Q?Erts=C3=A5s?= <mertsas@cisco.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Subject: Re: SELinux Namespace work
Message-ID: <kcbjtuxe5j5otdjn6rd2qhgszhorubq36s7z6hfrzd3oqt523r@gggubmv5kpbc>
References: <aoskc4jnsb2ivi7mgdkhxxxahwmrblzayvu7qdtpgjjnz7u7ca@6x6bz243yu4b>
 <CAEjxPJ4xff=wfvVpnSNuydWN4k1TX6f8GtBtWmv_Fc7yKMZaUA@mail.gmail.com>
 <54p5qlyfsj5twmuacf6nqmzaandshs34uwq7vdjycpcl4okgsw@fcovtdadvhlt>
 <CAEjxPJ4Ho+BFQ2Br6ajE0wF0Ueha04Z-EK45Fb3+2VC4hEVZBA@mail.gmail.com>
 <3b54lpvwc3eoyon4jf2vrkilmu2452ydz6zve5xdfofylioost@dgfwiuenwiqa>
 <CAEjxPJ4sVqtE5FuKrO708UR3towkdc_yAD64ixPZHsazoP_g6A@mail.gmail.com>
 <b2phzphz7lox6neiphbejtydndmgnz53y4jzfzpueffmqsn5im@2to32uoex2cs>
 <CAEjxPJ6P3NMfdw4t4E0dVvLsBAE+YEmgYkS+pRqYgDfApcv6Eg@mail.gmail.com>
 <CAEjxPJ6frshipeNk+f=_LDjeVwBNjMzBxqfZtk96rquWvUBHqQ@mail.gmail.com>
 <CAEjxPJ5vdrOuHUUCQe1qZbipr767DoJ0PUHD+H_3JBviDYw=zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ5vdrOuHUUCQe1qZbipr767DoJ0PUHD+H_3JBviDYw=zA@mail.gmail.com>
X-Outbound-SMTP-Client: 10.48.246.234, [10.48.246.234]
X-Outbound-Node: aer-l-core-04.cisco.com

On Wed, Nov 19, 2025 at 02:01:01PM -0500, Stephen Smalley wrote:
> On Wed, Nov 19, 2025 at 1:41 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Nov 19, 2025 at 9:00 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > I believe the kernfs nodes for the cgroup2 files that have host labels
> > > are initially being created by the kernel before the Android policy is
> > > loaded and therefore still inherit the parent directory xattr which
> > > was based on the host policy. Not sure if there is something further
> > > we can do in the kernel to avoid this. I tried moving the Android
> > > policy load earlier (before the unsharing of the cgroup namespace) but
> > > that didn't appear to help. Need to track down exactly when these
> > > kernfs nodes are created and whether they are shared across multiple
> > > cgroup2 mounts.
> > >
> > > In my testing, if the host is permissive, then I see a mix of host and
> > > Android labels (i.e. system_u:object_r:cgroup_t:s0 and
> > > u:object_r:cgroup_v2:s0) but if the host is enforcing, then they are
> > > all shown as Android labels but the ones that had the host labels when
> > > permissive are shown as u:object_r:unlabeled:s0. This makes sense
> > > since if the host is permissive and we are running as root (with
> > > CAP_MAC_ADMIN), the kernel will return raw contexts/xattrs on
> > > getxattr(2) even if they can't be mapped to a valid context in the
> > > current policy; otherwise the kernel will return the unlabeled context
> > > as defined by the current policy. I found that on the host, the new
> > > cgroup tree is visible under /sys/fs/cgroup/user.slice/user-NNNN.slice
> > > and on the host, it is similarly a mix of cgroup_t and unlabeled_t
> > > (unlabeled_t for the ones with Android labels since they can't be
> > > interpreted by the host).
> >
> > Ok, I finally realized that if you unshare the cgroup namespace and
> > then mount -t cgroup2 none /sys/fs/cgroup, it just mounts the
> > subdirectory for the cgroup to which your process was already assigned
> > - it doesn't create a new one. So if you cat /proc/self/cgroup before
> > doing the unshare -C and subsequently mount -t cgroup2 none
> > /sys/fs/cgroup, you are getting the same subdirectory that was already
> > set up by systemd on the host (ls -i of both directories will show the
> > same inodes). That's why the base files are all being labeled with
> > host labels, because the directory was created on the host. To avoid
> > this, you would need to create a new cgroup subdirectory on the host
> > after unsharing your SELinux namespace, assign your process to that
> > cgroup, and then unshare the cgroup namespace and mount the cgroup2
> > filesystem IIUC.
> 
> I've tested this as follows (NB below I am using the libselinux
> unshareselinux utility program which handles unsharing of the SELinux
> and mount namespaces since my kernel no longer has the
> /sys/fs/selinux/unshare API). This still depends on the 3 kernel
> patches to work correctly, and appears to require loading the Android
> policy before creating the new cgroup to avoid any labeling problems
> since the base files are populated during the mkdir itself.
> 
> $ sudo unshareselinux bash
> # mount -t selinuxfs none /sys/fs/selinux
> # ./myloadpolicy ./precompiled_sepolicy
> # id
> uid=0(root) gid=0(root) groups=0(root) context=u:r:kernel:s0
> # mkdir /sys/fs/cgroup/android
> # echo $$ > /sys/fs/cgroup/android/cgroup.procs
> # unshare -C bash
> # mount -t cgroup2 none /sys/fs/cgroup
> # ls -Z /sys/fs/cgroup
> u:object_r:cgroup_v2:s0 cgroup.controllers
> u:object_r:cgroup_v2:s0 cgroup.events
> u:object_r:cgroup_v2:s0 cgroup.freeze
> u:object_r:cgroup_v2:s0 cgroup.kill
> u:object_r:cgroup_v2:s0 cgroup.max.depth
> u:object_r:cgroup_v2:s0 cgroup.max.descendants
> u:object_r:cgroup_v2:s0 cgroup.pressure
> u:object_r:cgroup_v2:s0 cgroup.procs
> u:object_r:cgroup_v2:s0 cgroup.stat
> u:object_r:cgroup_v2:s0 cgroup.stat.local
> u:object_r:cgroup_v2:s0 cgroup.subtree_control
> u:object_r:cgroup_v2:s0 cgroup.threads
> u:object_r:cgroup_v2:s0 cgroup.type
> u:object_r:cgroup_v2:s0 cpu.idle
> u:object_r:cgroup_v2:s0 cpu.max
> u:object_r:cgroup_v2:s0 cpu.max.burst
> u:object_r:cgroup_v2:s0 cpu.pressure
> u:object_r:cgroup_v2:s0 cpu.stat
> u:object_r:cgroup_v2:s0 cpu.stat.local
> u:object_r:cgroup_v2:s0 cpu.uclamp.max
> u:object_r:cgroup_v2:s0 cpu.uclamp.min
> u:object_r:cgroup_v2:s0 cpu.weight
> u:object_r:cgroup_v2:s0 cpu.weight.nice
> u:object_r:cgroup_v2:s0 io.pressure
> u:object_r:cgroup_v2:s0 irq.pressure
> u:object_r:cgroup_v2:s0 memory.current
> u:object_r:cgroup_v2:s0 memory.events
> u:object_r:cgroup_v2:s0 memory.events.local
> u:object_r:cgroup_v2:s0 memory.high
> u:object_r:cgroup_v2:s0 memory.low
> u:object_r:cgroup_v2:s0 memory.max
> u:object_r:cgroup_v2:s0 memory.min
> u:object_r:cgroup_v2:s0 memory.numa_stat
> u:object_r:cgroup_v2:s0 memory.oom.group
> u:object_r:cgroup_v2:s0 memory.peak
> u:object_r:cgroup_v2:s0 memory.pressure
> u:object_r:cgroup_v2:s0 memory.reclaim
> u:object_r:cgroup_v2:s0 memory.stat
> u:object_r:cgroup_v2:s0 memory.swap.current
> u:object_r:cgroup_v2:s0 memory.swap.events
> u:object_r:cgroup_v2:s0 memory.swap.high
> u:object_r:cgroup_v2:s0 memory.swap.max
> u:object_r:cgroup_v2:s0 memory.swap.peak
> u:object_r:cgroup_v2:s0 memory.zswap.current
> u:object_r:cgroup_v2:s0 memory.zswap.max
> u:object_r:cgroup_v2:s0 memory.zswap.writeback
> u:object_r:cgroup_v2:s0 pids.current
> u:object_r:cgroup_v2:s0 pids.events
> u:object_r:cgroup_v2:s0 pids.events.local
> u:object_r:cgroup_v2:s0 pids.max
> u:object_r:cgroup_v2:s0 pids.peak

This looks very promising. I'll try that with my setup. Unfortunately I
can't load the selinux policy before unsharing the cgroup namespace.
Since the android policy is split up into multiple modules, that is
runtime mashed together to a single policy and loaded that has to be
done by android itself. So the container runtime will do the unsharing,
and then android will load the policy at a later time, but before
mounting the cgroupfs.

The container will be running in its own cgroup subtree, I just saw the
exact same with and without that, so ignored that part during my
testing. But will test that part now.
