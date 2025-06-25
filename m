Received: from aer-iport-5.cisco.com (aer-iport-5.cisco.com [173.38.203.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28533C17
	for <selinux@vger.kernel.org>; Wed, 25 Jun 2025 05:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750829194; cv=none; b=PdBCaBZKQITu2mYCxLjFXdZcOC7wWDrhK96XxE0xWYwIlgqRYyMo8FGXWbS8Zvb0FBgY69CAqTSVE+O8Xa4p3RmtdxOT4KKSYiRo+XmNofBeePMs1D7Ts63rliNs6AjybVW//6jKRP6ppigEtt9NTzdYbk45A2yjee5fTq1pHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750829194; c=relaxed/simple;
	bh=aZsgQ1pE7JI6HaEzQfE1je34EccQ0I0RNG/UXH6L7iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7vuwa2lfckt9KdGvY9y/2KJAtlmUYzuqgRxN6GHJgl66ypZvIsNqDrHhae3M0dhMtYbqUarEEgvUauwdW09Grr1irbzHXKxc1MwrUZkC93Ru+AvxRoon2ebKu2X39j8Hwnw0ZcZ4CAVaZN2lrL4dNfZ8qpSZn3MpO8lAIgI49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=kS/DOE1s; arc=none smtp.client-ip=173.38.203.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="kS/DOE1s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4274; q=dns/txt;
  s=iport01; t=1750829192; x=1752038792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=e1c2nD6mjRAire/KMqG1yJ5deX7VpLBEVuaEWLi0Z5A=;
  b=kS/DOE1saz7m+e9ogkDlINbPpiK8gCydDze32J9fBc2jdMXE1dMA9g4I
   rXz+Di65oSL5kbTW/hT5i2XLtJeFP3YzdE0Fxg+g3v5pSsVe7pNF8q2wr
   S+wuU8srUeLwsxtaRxZykzAAJfB1jgYvhE+ljl1G2gjYqUKkgt/nf+Dy5
   DqZV+2A2jQTOY9OHWgLXl35FNnbEdPmwVrt9D/TI0/bJECF8KNmbTBV3f
   6/NzjNQjhqaWCafZrut7mCJH5T2CDnEMl+C6DkKLQRW4q3sDqUbfbDMhK
   ZHcDyw03lx1ghi56CPEvCyFtnhFFPopxeqiQ7IkgwZHIpIC7GkWUv1P6u
   g==;
X-CSE-ConnectionGUID: wEgP8pSgSVmoW7gkfCxE0Q==
X-CSE-MsgGUID: iwTMxAdzTvi2zco7qjB35Q==
X-IPAS-Result: =?us-ascii?q?A0BsAwBch1to/9RK/pBaH2qBU4JLgVJDSYRUj1CCIQOLZ?=
 =?us-ascii?q?IcFiy0UgREDVw8BAQEPUQQBAYUHAottAiY0CQ4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBAQELAQEFAQEBAgEHBYEOE4YIhlsBAQEDIw8BOwsQCxgCAiYCAiA2BhMIh?=
 =?us-ascii?q?TQDMgOwLnqBMoEB3T0NgTKBKSxvLogzHgGKYycbgg2EBzg+gh+BbwESAYN8g?=
 =?us-ascii?q?mkEgiI9A1aCQoYOhD+BXYotUngcA1ksAUsKNQwzbUMDgTJLBTdoEkCCThyEP?=
 =?us-ascii?q?IRFgyJ7gX5lQYFWGIIOcw8GgSEtQAN4PTcUG5Mtg2UdGzUITgd4GQwYDDovk?=
 =?us-ascii?q?yydZpQlcYQlm1iGEkkDqkuZBJIOlyyBaDxpcDMiGxU7gmdSGQ/RXEQyAjoCB?=
 =?us-ascii?q?wEKAQEDCYI5jxUBAQ?=
IronPort-Data: A9a23:An4FOq14Wan6xpZ0p/bD5Ylwkn2cJEfYwER7XKvMYLTBsI5bpzUAn
 GFLDD2Ca/qPM2b0LY8gati2/UlV7cSEyIM3G1Fq3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmG4E70aNANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU5
 7sen+WFYAX4g2AubjpPg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGE2w5Bd0AwelMP2RJy
 qMXKz4mfj3bvrfjqF67YrEEasULJcTxeYdasXZ6wHSAVLAtQIvIROPB4towMDUY35wSW6yDO
 4xGNXw1NU6ojx5nYj/7DLo7kf20nXDkWzZZs1mS46Ew5gA/ySQriea3b4qOJbRmQ+1UgXq9t
 kvK7VjnA0sIP9vA0DivqS+V07qncSTTHdh6+KeD3uV2jUWTy2pVExgfUV+2sL+mjVS9c91aI
 k0QvCEpqMAa70GvT9/gTzWmr3Oe+B0RQdxdF6s98g7l90bPyw+UHC0ACzVGctFj7ZZwTj0x3
 VjPlNTsbdByjICopbum3u/8hVuP1eI9dAfuuQdsodM53uTe
IronPort-HdrOrdr: A9a23:82F586DDE+q4rg/lHemX55DYdb4zR+YMi2TDGXofdfVwSL38qy
 nIpoV+6faUskdyZJhOo7q90cW7LE80sKQFhrX5Xo3SPzUO2lHIEGgK1+KLqAEIWRefygc378
 ldmsZFZOEZyTNB/L/HCM7SKadH/OW6
X-Talos-CUID: =?us-ascii?q?9a23=3ANFI0E2ixeYJK+YcogrNDMBIU/zJubVDS9CfIGEC?=
 =?us-ascii?q?DN2Nud+KaSlG76I48qp87?=
X-Talos-MUID: 9a23:aUuboAQRRZphFbeZRXTtmw1HJO5k8ZiwCRofmpJZosuubnFJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,263,1744070400"; 
   d="scan'208";a="21627837"
Received: from aer-l-core-11.cisco.com ([144.254.74.212])
  by aer-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 25 Jun 2025 05:25:20 +0000
Received: from aginor (unknown [10.47.82.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-11.cisco.com (Postfix) with ESMTPS id 8CB1E180001E1;
	Wed, 25 Jun 2025 05:25:20 +0000 (GMT)
Date: Wed, 25 Jun 2025 07:25:20 +0200
From: Martin =?utf-8?Q?Erts=C3=A5s?= <mertsas@cisco.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: SELinux Namespace work
Message-ID: <bpvbw7d57yffcnidwtgg2oquuurshkf73udfudp52wavdokuqo@grvftl5767yq>
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
X-Outbound-SMTP-Client: 10.47.82.139, [10.47.82.139]
X-Outbound-Node: aer-l-core-11.cisco.com

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

Aaah. Thank you for the help. This helps a lot.

Best,
- Martin
