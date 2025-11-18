Received: from aer-iport-5.cisco.com (aer-iport-5.cisco.com [173.38.203.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92E2F531A
	for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449281; cv=none; b=naKpofjO4GQclzTDj1hgmkiUfp+iX1zJPdSRkcVzXxN53BAhLy2c7eGdrQCZPZ1F1TN0829a6sTorCO2CWsvSDmsVz3afM3Cp7/EErQUFnb2BPGmV2B2xloRhnhLeYvS3vStTHHZfqmKabgwT9gB3rRdhutAmKtmpd5V0AfaRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449281; c=relaxed/simple;
	bh=N1/aGNXsyceuigNlG6L1nF2SlZBefutLCELkbgG2uKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMZjIZK0h9kxk89+aU9PfBZQY4H2fhdOEtGQtVmnBR4FBlCtSwiqRGMNd5Y/FBJXmVY+h2dsXnh1dItEuuvjQ7oBB9EcYF4yX9bRf4mIzHjDvj65rh0AZRwE0QKM6m6O+vyCEsYWOGAoLdcC6IMqvbx98HspZCAVrANNibCnVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=ICSM0qMk; arc=none smtp.client-ip=173.38.203.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="ICSM0qMk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7238; q=dns/txt;
  s=iport01; t=1763449279; x=1764658879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gy8iwwXGzNvH/G83V3qBWs+PwFPEAqehJPc2YZQWM54=;
  b=ICSM0qMkcDTjkdY9JM+6hclW9iKumnxayLt+cI1ewZK9jn5/XasCksXD
   aFGYcbo6POFd0AEuxBheLNlwW8EoDpZF26JOO9lUQI+vkvLt07tfoLZ6X
   Jf77Crcf4AHTuBN3luUq0Sut4f+HPfjzzZmltykwb3CcxKR9AxvruW51x
   o+YVmc8oZ7u2lC7YmY1IRrDBP1xKYBv7NAv9crFLj0muJpwEqp7EzR0uU
   Xrm+I12DqJAclpB5TBZvFFrKxZ3wIPyTInzCDFpXvpTA4+975XjcvBgUl
   JTP7UJd/75cb7FE1Nzbr4yGYye0/Mhakw48Xvx8bF4rXDdI+XwJf5ZKsW
   g==;
X-CSE-ConnectionGUID: iaTJ75+mTbmTucz+UJlrqw==
X-CSE-MsgGUID: +0LlfrfKRdGMq6QYb57ayQ==
X-IPAS-Result: =?us-ascii?q?A0BqAwA/GBxp/81K/pBagQmBUIJHe11DSYRUj1OCIQOSa?=
 =?us-ascii?q?4svgX8PAQEBDzEgBAEBgVODNAKMWgImNAkOAQIEAQEBAQMCAwEBAQEBAQEBA?=
 =?us-ascii?q?QEBCwEBBQEBAQIBBwWBDhOGTw2GWwEBAQMjDwFGEAsYAgImAgJWBhMIgnuCc?=
 =?us-ascii?q?wOtVHqBMoEB3n2BKSxwLohTAYpmJxuCDYQ/PogegmkEgiI8UoYngnGJQIZ9U?=
 =?us-ascii?q?ngcA1ksAUsKNQwzbUMDgS5LBTdlEkAiHylgVECBRhiCB24PBoESGUkCAgIFA?=
 =?us-ascii?q?kA6WIEQBhwGHBICAwECAjpVDYEEcwICBIIZfoIKD4h6gQkFOwN4PTcUG5VRU?=
 =?us-ascii?q?YFoRAI8URUHMGARQA4MGSgcIA+SQgSzcYQmjB6VUEkDhUWlEJkGqUGBaDyBW?=
 =?us-ascii?q?TMiGxU7gmcJSRkPji0WhGLBUEUyPAIHAQoBAQMJgjmRLgEB?=
IronPort-Data: A9a23:Gu2starMX88ny5QNmJSs7EcgKVZeBmIUZBIvgKrLsJaIsI4StFCzt
 garIBmEP6qNN2qkfYwlPtnnpxhTvZPXzYRqSlM4qCAxFi1E9uPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQ7NNwJcaDpOtvva8UM35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0ud+PUMRq
 L8dFDoIUg2IlaGL4rahU/Y506zPLOGzVG8eknht13TdSP0hW52GG/mM7t5D1zB2jcdLdRrcT
 5NFNXw1MUiGPEEJYA9KYH49tL/Aan3XdjBCtEmcvoI84nPYy0p6172F3N/9IYDTGJgLxhbwS
 mTuvDzdBh8AOv+lxRWg6yyVt+WSwirqYddHfFG/3rsw6LGJ/UQIFBAOVVa95+K8g0q6VsMZN
 EsO+QIhqKEz8AqgSdyVdwWxvXqsphcBX59VFOog5UeGza+8ywGcAXMCRzVMQMYruM8/WXoh0
 Vrht8jkAT1pra29V32Q7PGXoCm0NCxTKnUNDRLoViMM7sOmpMQ4iQjCC44/VqW0ldbyXzr3x
 lhmsRQDulnatuZTv43TwLwNq2vESkThJuLt2jjqYw==
IronPort-HdrOrdr: A9a23:HInmVq9zLkQgsmVOZZpuk+DjI+orL9Y04lQ7vn2ZhyY7TiW9rb
 HKoB19726RtN9xYgBDpTnuAsO9qB/nmKKdpLNhWotKPzOW21dATrsC0WKK+VSJcBEWtNQ86U
 4KScZD4bPLYWSTSa3BkXCF+xFK+qjgzJyV
X-Talos-CUID: 9a23:1V+45GDFJNdhqT36EyhuyGxLR4MgTnfY8GrbMQyFK2JzUaLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AtMCQVwyJrHVYIW63n+WuxvGYoiGaqOf2LEQDi5s?=
 =?us-ascii?q?lgcWrEDUuAgaX0Wu+U7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,314,1754956800"; 
   d="scan'208";a="34155608"
Received: from aer-l-core-04.cisco.com ([144.254.74.205])
  by aer-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2025 07:00:07 +0000
Received: from perrin (unknown [10.48.246.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-04.cisco.com (Postfix) with ESMTPS id CAD60180001E2;
	Tue, 18 Nov 2025 07:00:06 +0000 (GMT)
Date: Tue, 18 Nov 2025 08:00:06 +0100
From: Martin =?utf-8?Q?Erts=C3=A5s?= <mertsas@cisco.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Subject: Re: SELinux Namespace work
Message-ID: <3b54lpvwc3eoyon4jf2vrkilmu2452ydz6zve5xdfofylioost@dgfwiuenwiqa>
References: <io56y7r63uyeduqe7ukx3wcjvhzfnnsxle2go5raxqy76lrn3n@edx4doao3gv3>
 <CAEjxPJ5cGzHDrsUGKCOxOUZm-0d8shoPahbZB7zVFTivujRNsw@mail.gmail.com>
 <kakoxc3dfli7fjjistybeqhf34abzqovkmq2gs4fg5sv7nviam@w36m2srscmbu>
 <CAEjxPJ5rD7Fq_t5EDoy8EYHzMhgntR+KK=3OZAAuA0V047yKWQ@mail.gmail.com>
 <CAEjxPJ744wutA3FZmA88OMyay__P0qVAYTB6RRnh=v+LiPyxJQ@mail.gmail.com>
 <aoskc4jnsb2ivi7mgdkhxxxahwmrblzayvu7qdtpgjjnz7u7ca@6x6bz243yu4b>
 <CAEjxPJ4xff=wfvVpnSNuydWN4k1TX6f8GtBtWmv_Fc7yKMZaUA@mail.gmail.com>
 <54p5qlyfsj5twmuacf6nqmzaandshs34uwq7vdjycpcl4okgsw@fcovtdadvhlt>
 <CAEjxPJ4Ho+BFQ2Br6ajE0wF0Ueha04Z-EK45Fb3+2VC4hEVZBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ4Ho+BFQ2Br6ajE0wF0Ueha04Z-EK45Fb3+2VC4hEVZBA@mail.gmail.com>
X-Outbound-SMTP-Client: 10.48.246.234, [10.48.246.234]
X-Outbound-Node: aer-l-core-04.cisco.com

On Mon, Nov 17, 2025 at 09:28:38AM -0500, Stephen Smalley wrote:
> On Mon, Nov 17, 2025 at 3:09 AM Martin Ertsås <mertsas@cisco.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 10:25:38AM -0500, Stephen Smalley wrote:
> > > On Fri, Nov 14, 2025 at 9:15 AM Martin Ertsås <mertsas@cisco.com> wrote:
> > > > Thank you for the help so far. I have dug quite a bit into an issue with
> > > > this together with the cgroup namespace, which is required for running
> > > > Android in a container.
> > > >
> > > > What I see is that before mounting the cgroup namespace, it is labeled
> > > > based on the new selinux namespace as expected. But when mounting the
> > > > cgroup2 filesystem, some of the labels change to the host labels. This
> > > > causes problems, as I on the host have the user system_u, while android
> > > > only has u. So when I try to make a subdirectory in the new cgroup, I
> > > > get -ENOMEM as selinux can not find a system_u user.
> > > >
> > > > This is what I can observe:
> > > >
> > > > # echo 1 > /sys/fs/selinux/unshare
> > >
> > > Note that my current working-selinuxns branch has switched from the
> > > /sys/fs/selinux/unshare interface to the system call-based approach
> > > recommended by the discussion on the LSM list so at some point you may
> > > need to switch over to using that as well. That however is not
> > > relevant to your issue below; I am just mentioning it for your
> > > awareness. It remains to be seen what the final upstream API will be.
> >
> > Yes, I noticed. I will switch to this one as soon as I have a working
> > prototype, as this seems to solely be an API change. If the branches
> > starts to diverge I would need to swap ASAP though.
> >
> > > > # unshare -m -n -C -p --fork /tmp/setup_namespace.sh
> > > > [cisco:/] $ load_selinux_policy
> > > > Loaded selinux policy. Enforcing=0
> > > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 9p
> > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 bpf
> > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 cgroup
> > > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 ext4
> > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 fuse
> > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 nfs
> > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 pstore
> > > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0                  0 Nov 14 14:05 selinux
> > >
> > > Looks like your container sysfs mount was labeled per its policy
> > > rather than the host policy, as expected. Did you do anything special
> > > when mounting sysfs?
> >
> > No, just did `mount -t sysfs none /sys` I have attached the script and
> > the selinux policy.
> >
> > > > load_selinux_policy-3.2# mount -t cgroup2 none /sys/fs/cgroup
> > > > load_selinux_policy-3.2# ls -lZ /sys/fs
> > > > drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 9p
> > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 bpf
> > > > drwxr-xr-x    2 root     root     system_u:object_r:cgroup_t               0 Nov 14 13:53 cgroup
> > > > drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 ext4
> > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 fuse
> > > > drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 nfs
> > > > dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                      0 Nov 14 14:05 pstore
> > > > drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0                  0 Nov 14 14:05 selinux
> > > > load_selinux_policy-3.2# ls -lZ /sys/fs/cgroup/
> > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.controllers
> > > > -r--r--r--    1 root     root     system_u:object_r:cgroup_t               0 Nov 14 13:53 cgroup.events
> > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.freeze
> > > > --w-------    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.kill
> > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.max.depth
> > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.max.descendants
> > > > -rw-r--r--    1 root     root     system_u:object_r:cgroup_t               0 Nov 14 13:53 cgroup.procs
> > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.stat
> > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.subtree_control
> > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.threads
> > > > -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cgroup.type
> > > > -r--r--r--    1 root     root     u:object_r:unlabeled:s0                  0 Nov 14 13:53 cpu.stat
> > >
> > > That's very odd indeed - I would expect them all to be labeled based
> > > on either the container policy or the host policy, not a mix of the
> > > two. cgroup2 and sysfs are both kernfs-based so I'm wondering how/why
> > > they differ.
> >
> > My suspicion is that since the cgroup namespace gives you a subhierarchy
> > view of the host cgroup hierarchy, the superblock is reused as for
> > cgroup it's actually the same hierarchy. Just with a different root.
> > While the sysfs is a completely new sys mount. But I'm not 100% sure.
> >
> > I will dig into why some, like cgroup.subtree_control, are labeled with
> > the new selinux policy, while others are labeled with the host selinux policy.
> >
> > > > load_selinux_policy-3.2# mkdir /sys/fs/cgroup/foo
> > > > mkdir: can't create directory '/sys/fs/cgroup/foo': Cannot allocate memory
> > > > load_selinux_policy-3.2#
> > > >
> > > > The setup_namespace just creates a new rootfs and mounts the android
> > > > container and selinux policy into that. And load_selinux_policy is just a wrapper that loads the android selinux policy.
> > > >
> > > > What I have traced it down to is that when kernfs_get_tree from
> > > > fs/kernfs/mount.c is mounting the cgroup, the superblock is reused from
> > > > the old cgroup namespace, which also has the security context from the
> > > > old selinux namespace. This causes the labels to be mixed as shown
> > > > above. This doesn't seem to involve SELinux code directly, but just the
> > > > kernfs code.
> > > >
> > > > Should the kernfs test function for the superblock involve checking the
> > > > security context as well? Not sure what a proper fix for this would be?
> > > > Or if I'm missunderstanding something and doing something fundamentally
> > > > wrong here?
> > >
> > > First I'd like to understand why it seems to be working for sysfs but
> > > not cgroup2 since they are both kernfs-based. What's different between
> > > the two?
> > > And since you unshared the cgroup namespace, why doesn't that trigger
> > > a new superblock creation by itself? It's better if we can avoid
> > > introducing a special check just for SELinux/LSM here.
> >
> > Good questions. I think I answered my hunch on these above, but I'm
> > truly not sure. I have attached the setup_namespace.sh script I use so
> > you can see, as well as the selinux policy I load.
> 
> And just to confirm, is your load_selinux_policy just a program that
> does the equivalent of open+fstat+mmap+security_load_policy() on the
> Android policy file?

Correct, that's all it does.
