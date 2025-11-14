Received: from aer-iport-2.cisco.com (aer-iport-2.cisco.com [173.38.203.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E7D3161B3
	for <selinux@vger.kernel.org>; Fri, 14 Nov 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129797; cv=none; b=iS9FXjke+DQ8xO7yHhlvBvkFGO1Npodh4jLLzbObd9/PGMG1tI7940vGbEXtBzXOSgbkIkS/XgJYPka3RZgCcB/exT7kfrFVSdi6dsf5sFEJz6jFjKAcHex+bkrUTMm8euhBUXBv6FA4/rMjE7rV9JePa6GI1qgL8czL9h3v1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129797; c=relaxed/simple;
	bh=7VUP20LPcIuzOM1Az25Qn3D4OYfMJxaWngMPe4L7X9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/Ap+UgiIcRx9VydhB1YlugiZDSSLLUcyVL1+QSzaAm7zA8ZKyyI3LDxLhd+tspUfWnMm4E5oway2TfW2bGFdgimcxecw/GoXA7AuACZ+LyjRuQGvq4suB2NYgtOQNXtV5uQQc9rN977I6IVuhLm1Hi8ag0sIJq/MNvLXBDrw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=aEfoi+Tz; arc=none smtp.client-ip=173.38.203.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="aEfoi+Tz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8143; q=dns/txt;
  s=iport01; t=1763129794; x=1764339394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tnODTS+AIZUHS3IEGHa12An2YaP2IAj8p1dHZvHKGao=;
  b=aEfoi+Tz7mpJJNufXRVmP+huhRgDrauR4qdnMKF7YHKcTTTIHMrxbDjS
   yi0Zjzdp0TdoDjeyBDAzNPlh180vvxR1OONcotAyRybr1VhgSIO2KnkpC
   V8llB9b3UfLNixrXJX+oikC+OD1qwOcMaEo7rpWotkjIpREQiogz35C6m
   DITkzw8CGd2PzHAgi5VlUPOY1HQ9Xq414Eocr8fJ7ZkKU05yJuhq7Yc34
   k+V2YThkeCEvVABRkdoiuYzT5xx27UwK19X00P0Mf6snolH2ATJ65ZnP9
   nYyuZezHz+6WeFVc/bx/JJRDh7wim71gs5iVnz6sCUJm5nY8ycF6E0cHC
   w==;
X-CSE-ConnectionGUID: MOwD6KStTb2h1n/luJam/Q==
X-CSE-MsgGUID: PIxD9YEkRwCuJeLSy8dnrw==
X-IPAS-Result: =?us-ascii?q?A0CDBAB0OBdp/85K/pBaHgEBCxIMQIFFC4JHe11DSYRUj?=
 =?us-ascii?q?1OCIQOLZIcHiy8UgWsPAQEBDzEgBAEBgVODNAKMWgImNAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGTw2GWwEBAQMjDwE7CxALGAICJ?=
 =?us-ascii?q?gICIDYGEwiCe4I6AzYDr3h6gTKBAd0+DYEygSkscC6INB8BimYnG4INhAc4P?=
 =?us-ascii?q?oIfgW8BEgGDfIJpBIEOgRQ8UoF6hC2CcYE4iBgVKYY6UngcA1ksAUsKNQwzb?=
 =?us-ascii?q?UMDgS5LBTdlEkAiHylgVECBRhiCB24PBoESGUkCAgIFAkA6WIEQBhwGHBICA?=
 =?us-ascii?q?wECAjpVDYEEcwICBIIZfoIKD4lJgRgDeD03FBuVWFGCLD4dGy4HMCYHeBkMG?=
 =?us-ascii?q?AIKHhwvky6dcpQmcYQmjB6PPYYTSQOFRaUQmQaSEZcwgWg8aXAzIhsVO4JnC?=
 =?us-ascii?q?UkZD5Mlw3RFMgI6AgcBCgEBAwmCOYQPjR8BAQ?=
IronPort-Data: A9a23:CwFrVa9wt8B1VHqJKTILDrUD2n+TJUtcMsCJ2f8bNWPcYEJGY0x3y
 zQaDTuFM/3bamL0et0kOYq/pxsCvJSHyddmT1M4rSBEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4EzrauS9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qjyyHjEAX9gWMtaztIs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kTGpI0pMVMHV1Er
 /xBLncJczKKgqWPlefTpulE3qzPLeHiMZlavjRryivUSK57B5vCWK7No9Rf2V/chOgXQaqYP
 ZdFL2UzKk6YPXWjOX9PYH46tOKlnGXkeiZwo1OOrq1x6G/WpOB0+OOzbYaJK4TWLSlTtn65t
 k6Xzkn6OA4xKf6S7QGUon6qnPCayEsXX6pXTtVU7MVCm0Ge3mweDlsNUFK/pfSozFG5QdF3J
 Ekd+y5opq83nGSwQ938WQCoiGCLswRaWNdKFeA+rgaXxcLpDx2xD2UeCzoEY9s8uYpuGHoh1
 0SCmJXiAjkHXKCpdE9xP4y89VuaURX550dbDcPYZWPpO+Xenbw=
IronPort-HdrOrdr: A9a23:W3/Qr6qv0tcRKzYSOUmh5icaV5oQeYIsimQD101hICG9vPb2qy
 mLpoV/6faSskd0ZJhAo6HjBEDuexnhHPJOjLX5eI3SOzUO21HYT72Kj7GC/9SIIUSXndK1l5
 0BT0EUMrPN5DZB4foTJGKDYq8dKB7tytHPudvj
X-Talos-CUID: =?us-ascii?q?9a23=3A+39uVmpvl3/VPFz+q4S5u5fmUeUCbVGD70zMH0X?=
 =?us-ascii?q?iCT9vD7mIa1aVv5oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AzIYniA0xiISVxVEOsu5/GwvQ6jUj24W+JBE8vJY?=
 =?us-ascii?q?8pOKZFyFUACbNgDKtXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,305,1754956800"; 
   d="scan'208";a="36544904"
Received: from aer-l-core-05.cisco.com ([144.254.74.206])
  by aer-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Nov 2025 14:15:23 +0000
Received: from perrin (unknown [10.48.246.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-05.cisco.com (Postfix) with ESMTPS id 9508C18000231;
	Fri, 14 Nov 2025 14:15:22 +0000 (GMT)
Date: Fri, 14 Nov 2025 15:15:21 +0100
From: Martin =?utf-8?Q?Erts=C3=A5s?= <mertsas@cisco.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: SELinux Namespace work
Message-ID: <aoskc4jnsb2ivi7mgdkhxxxahwmrblzayvu7qdtpgjjnz7u7ca@6x6bz243yu4b>
References: <io56y7r63uyeduqe7ukx3wcjvhzfnnsxle2go5raxqy76lrn3n@edx4doao3gv3>
 <CAEjxPJ5cGzHDrsUGKCOxOUZm-0d8shoPahbZB7zVFTivujRNsw@mail.gmail.com>
 <kakoxc3dfli7fjjistybeqhf34abzqovkmq2gs4fg5sv7nviam@w36m2srscmbu>
 <CAEjxPJ5rD7Fq_t5EDoy8EYHzMhgntR+KK=3OZAAuA0V047yKWQ@mail.gmail.com>
 <CAEjxPJ744wutA3FZmA88OMyay__P0qVAYTB6RRnh=v+LiPyxJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ744wutA3FZmA88OMyay__P0qVAYTB6RRnh=v+LiPyxJQ@mail.gmail.com>
X-Outbound-SMTP-Client: 10.48.246.234, [10.48.246.234]
X-Outbound-Node: aer-l-core-05.cisco.com

On Tue, Jun 24, 2025 at 09:04:10AM -0400, Stephen Smalley wrote:
> On Tue, Jun 24, 2025 at 8:43 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Jun 24, 2025 at 1:44 AM Martin Ertsås <mertsas@cisco.com> wrote:
> > >
> > > On Mon, Jun 23, 2025 at 08:09:34AM -0400, Stephen Smalley wrote:
> > > > On Mon, Jun 23, 2025 at 7:37 AM Martin Ertsås <mertsas@cisco.com> wrote:
> > > > >
> > > > > Good day.
> > > > >
> > > > > I have been looking a bit on your SELinux Namespace work, as we have a
> > > > > usecase for it where it will be necessary. Basically we're running
> > > > > Android in a lxc container.
> > > > >
> > > > > Currently we just have a single label for everything happening inside
> > > > > the container, and disabled every SELinux handling from the Android side,
> > > > > as that doesn't work.
> > > > >
> > > > > So we're looking into if your namespace patches will allow us to let
> > > > > Android do its own SELinux handling, and it seems very promising, so
> > > > > thanks a lot.
> > > > >
> > > > > My question is about user namespaces and the selinux namespace. I see
> > > > > you very consciously have not linked the two, and I was wondering if
> > > > > the problem I'm seeing might be due to that?
> > > > >
> > > > > What I try to do is, as root in the init usernamespace:
> > > > >
> > > > > ```
> > > > > # unshare -m -n -U --map-root-user
> > > > > # mount --make-rprivate /
> > > > > # echo 1 > /sys/fs/selinux/unshare
> > > > > # umount /sys/fs/selinux
> > > > > # mount -t selinuxfs selinux /sys/fs/selinux
> > > > > ```
> > > > >
> > > > > The problem is in the umount step, it returns with:
> > > > >
> > > > > `umount: /sys/fs/selinux: not mounted.`
> > > > >
> > > > > Do you know if there's a way I can make this work? Or is this a
> > > > > limitation of the current implementation? Seems like the flow today has
> > > > > to be to first unshare and remount the selinuxfs, and then enter the
> > > > > user namespace.
> > > >
> > > > So, first, unless your email contains proprietary information, I would
> > > > recommend cc'ing the selinux mailing list.
> > > > Then, with regard to your question, the above doesn't appear to be due
> > > > to anything in SELinux itself, as the same
> > > > behavior occurs even if I don't unshare the SELinux namespace and even
> > > > if SELinux is permissive.
> > > > I would have to look further into what unshare -m -n -U
> > > > --map-root-user and mount --make-rprivate / does that is causing this
> > > > behavior but it doesn't seem like it is something in SELinux itself.
> > >
> > > Thank you for the reply.
> > >
> > > You're correct. I was assuming it was due to the SELinux namespace, but
> > > testing without the patches at all shows the same behaviour. I'll dig
> > > into that and see what I can find then. Thank you.
> >
> > On further thought, I think that you aren't allowed to unmount or
> > otherwise modify a mount for a filesystem that was mounted by a
> > different user namespace, so when you unshare the user namespace, you
> > can no longer unmount the old selinuxfs mount. Hence, it does appear
> > that you would need to unshare the SELinux namespace first, then the
> > user namespace.
> 
> Looks like you also cannot mount selinuxfs from the child user
> namespace; again, this occurs even if SELinux is permissive, so it
> appears to be a DAC and/or capabilities restriction imposed on user
> namespaces. So the sequence would have to be along the lines of:
> # echo 1 > /sys/fs/selinux/unshare # unshare SELinux namespace
> # unshare -m # unshare mount namespace so we can unmount old selinuxfs
> # umount /sys/fs/selinux # unmount old selinuxfs
> # mount -t selinuxfs none /sys/fs/selinux # mount new selinuxfs for
> child namespace
> #  unshare -m -n -U --map-root-user # unshare user namespace
> 
> And then it is possible to load policy into the child namespace (or
> you could do it before, either way).
> 
> Note that we have a helper on my selinuxns branch of libselinux that
> handles the first 3 steps for you, leaving the rest to be done by
> systemd or whatever.

Thank you for the help so far. I have dug quite a bit into an issue with
this together with the cgroup namespace, which is required for running
Android in a container.

What I see is that before mounting the cgroup namespace, it is labeled
based on the new selinux namespace as expected. But when mounting the
cgroup2 filesystem, some of the labels change to the host labels. This
causes problems, as I on the host have the user system_u, while android
only has u. So when I try to make a subdirectory in the new cgroup, I
get -ENOMEM as selinux can not find a system_u user.

This is what I can observe:

# echo 1 > /sys/fs/selinux/unshare
# unshare -m -n -C -p --fork /tmp/setup_namespace.sh
[cisco:/] $ load_selinux_policy
Loaded selinux policy. Enforcing=0
load_selinux_policy-3.2# ls -lZ /sys/fs
drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 9p
dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 bpf
dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 cgroup
drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 ext4
drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 fuse
drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 nfs
dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 pstore
drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0                  0 Nov 14 14:05 selinux
load_selinux_policy-3.2# mount -t cgroup2 none /sys/fs/cgroup
load_selinux_policy-3.2# ls -lZ /sys/fs
drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 9p
dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 bpf
drwxr-xr-x    2 root     root     system_u:object_r:cgroup_t               0 Nov 14 13:53 cgroup
drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 ext4
drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 fuse
drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 nfs
dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 pstore
drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0                  0 Nov 14 14:05 selinux
load_selinux_policy-3.2# ls -lZ /sys/fs/cgroup/
-r--r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.controllers
-r--r--r--    1 root     root     system_u:object_r:cgroup_t               0 Nov 14 13:53 cgroup.events
-rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.freeze
--w-------    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.kill
-rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.max.depth
-rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.max.descendants
-rw-r--r--    1 root     root     system_u:object_r:cgroup_t               0 Nov 14 13:53 cgroup.procs
-r--r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.stat
-rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.subtree_control
-rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.threads
-rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.type
-r--r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cpu.stat
load_selinux_policy-3.2# mkdir /sys/fs/cgroup/foo
mkdir: can't create directory '/sys/fs/cgroup/foo': Cannot allocate memory
load_selinux_policy-3.2#

The setup_namespace just creates a new rootfs and mounts the android
container and selinux policy into that. And load_selinux_policy is just a wrapper that loads the android selinux policy.

What I have traced it down to is that when kernfs_get_tree from
fs/kernfs/mount.c is mounting the cgroup, the superblock is reused from
the old cgroup namespace, which also has the security context from the
old selinux namespace. This causes the labels to be mixed as shown
above. This doesn't seem to involve SELinux code directly, but just the
kernfs code.

Should the kernfs test function for the superblock involve checking the
security context as well? Not sure what a proper fix for this would be?
Or if I'm missunderstanding something and doing something fundamentally
wrong here?

Best regards,
- Martin
