Received: from aer-iport-2.cisco.com (aer-iport-2.cisco.com [173.38.203.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEF5223
	for <selinux@vger.kernel.org>; Tue, 24 Jun 2025 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750743916; cv=none; b=rBNxOlbXOn075SOkLU/TsgrCij9jYXkBYBcKitsGXsISGp4YzF49wl8cE4KbeRQMovzpsKgWMtV82kYP22LWhYgiXFqlDh4IRf1x2rbrouNx4zyfY+dVz1abQmApkNocxHJTTtYSVyscyPI+pogkAlhZNfDezn4mTN4EjCGolhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750743916; c=relaxed/simple;
	bh=toACJ5BTXHrDu07ysCSP3ZQAmeIFKOwXl2Qa9flqR1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMl2rmOXad8Ad9zg1uYKyNfmEfH2gbQA8s/TDlYgB60HfSYL7S0yNAfT1yd/o+4PTrI/VsNlwMIy8+0bVwmXe76/fE+JP7zNEhSJPEKl/C9NHj66HRZwtWs4rz7FdmZYdhxgs2s/VAg9bCCR4iFnmbRklyno+zwQeBjrSEt0LTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=ELB15h6M; arc=none smtp.client-ip=173.38.203.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="ELB15h6M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2328; q=dns/txt;
  s=iport01; t=1750743914; x=1751953514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JS93abfxXlrit9LPqtgy4O/IW+j0A+2wp4Jr/ZUjRDM=;
  b=ELB15h6MdR6AbF7McznX57IkDVUNeaQ9btWuNncm3DYCffL2Rx8gtCgu
   EDsiRflaDY2xfJxlxd2T9XVZgsKpC4zBtySyAp4tWKcyarWdqXwt5YGru
   yVJToslL9GCwF7vaM8Dp1x6iyBmUSwC8TlyeRTIApQGYi/UOUOmsivjS9
   wfjTa7ifqn1r4cA9wCARLvy36UQsl1SOYuW0fKvLDtty4el6R4tFr3Hzb
   KTpBW+NBNHa9eI+QEwurNkhM1KFRxNwfPdC1VQIWlg85SGdRPd8+mEbPr
   bwOxg6aimxJkvxaokpm+E4ERHfV5itgDlvBV5/EbJUozEjM1KqVwbZZEY
   Q==;
X-CSE-ConnectionGUID: cipytztXQjyPk2NKGihLsw==
X-CSE-MsgGUID: EeK9vGlyR4q9/LbDZYFo9Q==
X-IPAS-Result: =?us-ascii?q?A0AoAABQOlpo/8xK/pBaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJKgVJDSYRUiByHNIIhA5Jpiy0UgREDVw8BAQEPUQQBAYUHAotoA?=
 =?us-ascii?q?iY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4YIhlsBA?=
 =?us-ascii?q?QEDIw8BOwsQCxgCAiYCAlYGEwiFaQOwA3qBMoEB3nyBKSxvLgGIUAGKYycbg?=
 =?us-ascii?q?g2EBzg+hA4BEgGDfIJpBIIkPQNWHYImlkZSeBwDWSwBSwo1DDNtQwOBMksFN?=
 =?us-ascii?q?2gSQIJQHIQ8hEWDInuBfmVBgVYYgg5zDwaBIRlAA3g9NxQbkyaDZB0bNVYHe?=
 =?us-ascii?q?BkMGEYvkyydZpUWhCWhakkDqkuZBKk6gWg8aXAzIhsVO4JnUhkP01NEMjwCB?=
 =?us-ascii?q?wEKAQEDCYI5jzUBAQ?=
IronPort-Data: A9a23:gCkBfKNvXaLKyoLvrR3/lsFynXyQoLVcMsEvi/4bfWQNrUoh1jMGz
 DdLXGGHOqnYMDegc4sjbN7g8RwB6JOGy9RiTXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFDmF/03F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/Wl3lV
 e/a+ZWFZQf7gWUsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/5vFFAqL5Eow+RmOWIU0
 983KTApdQ/W0opawJrjIgVtrs0uNozveYgYoHwllWqfBvc9SpeFSKLPjTNa9G5s2oYUQKqYO
 JZfM2IzBPjDS0Un1lM/DZ8kgPyhnVH0ciZTrxSeoq9fD237llAoj+O0aYS9ltqiaMh2z1i3o
 nP8o32oRTUQGO6u5z3Uyyf57gPItWahMG4IL5Wj6vNygFCVgHcWARkSWEr9vv6jiWaxXtteL
 wof/S9GhbM/8E2tU8nVQRK1ujiHswQaVt4WFPc1gDxh0YLd7hzcAi0PSSRMLYR98sQ3Xjctk
 FSOmrsFGABSjVFcclrFnp/8kN94EXF9wbMqDcPccTY43g==
IronPort-HdrOrdr: A9a23:93j84K8tGMmurPAIpi9uk+DjI+orL9Y04lQ7vn2ZhyY7TiW9rb
 HKoB19726RtN9xYgBDpTnuAsO9qB/nmKKdpLNhWotKPzOW21dATrsC0WKK+VSJcBEWtNQ86U
 4KScZD4bPLYWSTSa3BkXCF+xFK+qjgzJyV
X-Talos-CUID: 9a23:mSdvN2C6xgZZeyn6EyJm7F8ICNwVS3/M9HSKBWyXCGZNU6LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Ahu2UjQ+WA9a78xdl2/jHk6eQf+plwPWwJ0Qcq8k?=
 =?us-ascii?q?f6o6gPwBCChma3Q3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,260,1744070400"; 
   d="scan'208";a="24173116"
Received: from aer-l-core-03.cisco.com ([144.254.74.204])
  by aer-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Jun 2025 05:44:03 +0000
Received: from perrin (unknown [10.48.246.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-03.cisco.com (Postfix) with ESMTPS id BF89A18000233;
	Tue, 24 Jun 2025 05:44:02 +0000 (GMT)
Date: Tue, 24 Jun 2025 07:44:02 +0200
From: Martin =?utf-8?Q?Erts=C3=A5s?= <mertsas@cisco.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: SELinux Namespace work
Message-ID: <kakoxc3dfli7fjjistybeqhf34abzqovkmq2gs4fg5sv7nviam@w36m2srscmbu>
References: <io56y7r63uyeduqe7ukx3wcjvhzfnnsxle2go5raxqy76lrn3n@edx4doao3gv3>
 <CAEjxPJ5cGzHDrsUGKCOxOUZm-0d8shoPahbZB7zVFTivujRNsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ5cGzHDrsUGKCOxOUZm-0d8shoPahbZB7zVFTivujRNsw@mail.gmail.com>
X-Outbound-SMTP-Client: 10.48.246.234, [10.48.246.234]
X-Outbound-Node: aer-l-core-03.cisco.com

On Mon, Jun 23, 2025 at 08:09:34AM -0400, Stephen Smalley wrote:
> On Mon, Jun 23, 2025 at 7:37 AM Martin Ertsås <mertsas@cisco.com> wrote:
> >
> > Good day.
> >
> > I have been looking a bit on your SELinux Namespace work, as we have a
> > usecase for it where it will be necessary. Basically we're running
> > Android in a lxc container.
> >
> > Currently we just have a single label for everything happening inside
> > the container, and disabled every SELinux handling from the Android side,
> > as that doesn't work.
> >
> > So we're looking into if your namespace patches will allow us to let
> > Android do its own SELinux handling, and it seems very promising, so
> > thanks a lot.
> >
> > My question is about user namespaces and the selinux namespace. I see
> > you very consciously have not linked the two, and I was wondering if
> > the problem I'm seeing might be due to that?
> >
> > What I try to do is, as root in the init usernamespace:
> >
> > ```
> > # unshare -m -n -U --map-root-user
> > # mount --make-rprivate /
> > # echo 1 > /sys/fs/selinux/unshare
> > # umount /sys/fs/selinux
> > # mount -t selinuxfs selinux /sys/fs/selinux
> > ```
> >
> > The problem is in the umount step, it returns with:
> >
> > `umount: /sys/fs/selinux: not mounted.`
> >
> > Do you know if there's a way I can make this work? Or is this a
> > limitation of the current implementation? Seems like the flow today has
> > to be to first unshare and remount the selinuxfs, and then enter the
> > user namespace.
> 
> So, first, unless your email contains proprietary information, I would
> recommend cc'ing the selinux mailing list.
> Then, with regard to your question, the above doesn't appear to be due
> to anything in SELinux itself, as the same
> behavior occurs even if I don't unshare the SELinux namespace and even
> if SELinux is permissive.
> I would have to look further into what unshare -m -n -U
> --map-root-user and mount --make-rprivate / does that is causing this
> behavior but it doesn't seem like it is something in SELinux itself.

Thank you for the reply.

You're correct. I was asssuming it was due to the SELinux namespace, but
testing without the patches at all shows the same behaviour. I'll dig
into that and see what I can find then. Thank you.
