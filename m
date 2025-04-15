Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982F4C96
	for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708951; cv=none; b=QXuTXP6d7RH5XPtVnnp2UH1tGzpjfgcUvHmXSRBgjrWxr7Ftspbn6l2RCyQX6zHbU/XavjKlghOpD3GugS2pJyhwrAW34DNu/t2MTchDofNNKrnRuuNExuSw8Jtotsiyo4Pq/UamueH5tV4goN9PrQ52LKDmcT73IV3MYb3NObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708951; c=relaxed/simple;
	bh=L2nWfw2F0tLGeLqEgrlZKJT4ce2TPKIFWvGneYycIcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmbsJI92SMCuTDLEIIK+D/O1Ik0wHSBb+dg2F6VjEXnU7fNq6YOjMQsgS/d+ugCdh8/Mzlf3kolMnHT+Phbj5z13Hxfom037qnzLesUwae5NWQpC5o3xarrGAx9BDrinMGiupZFi6H+NxPg7q4X298ICKFCoduUpajB6c5smvyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYann2vV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYann2vV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744708948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwNS1SE90wwYANhRaW3iTs78GQICoY6XUxQmxD7SYsA=;
	b=FYann2vVNQXueibHGv/igp04IkuKL9uKzrR5ZlvVbtFuc7xC9MiOFGU++SSl96x8DhjSYb
	B5xOAuvE9guGfSE9m9ggOph0Ks1GuD4JtZQhjtfFrEwrE32Lmdt++slfOpT9g3X9XieCuA
	yUUz65lF3GLqIyg43HkUghdnTS07EiA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-exi1PKvfNpuSrsRCRjBJ-w-1; Tue, 15 Apr 2025 05:22:26 -0400
X-MC-Unique: exi1PKvfNpuSrsRCRjBJ-w-1
X-Mimecast-MFC-AGG-ID: exi1PKvfNpuSrsRCRjBJ-w_1744708945
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso6518830a91.1
        for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 02:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744708944; x=1745313744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwNS1SE90wwYANhRaW3iTs78GQICoY6XUxQmxD7SYsA=;
        b=S+Nqcj1z6h05KtQneib4JrJgnLMKD2/Lol2JrAbUd0+Yt+zku8hr4FtR4WfTbuX0iR
         I3ua+RgZmV5MyaM4wQqnu3Zw5BxJd0Q53oo9iYOL8rAMAeRZKZ2Jm0CxcDzIqRvSq+5H
         eAE7pO0Ru/voC4RdYjKpC4Q4Z6RugCIetjY+16ZVZPA5c6ZyuEGHpjxcgT6/PPscxgFZ
         g8sLm33Xws1TVPRC3JybGcqlfrcs0puvUqsObMeiKXevER4yrGenTDPSW4qbBo0klVe8
         MiD0bXf8Oy7h9zhNWdjtaDbX6DXsLr3Agkx0C3DzdLXEl3yMHB64+twnsAeErInxl3S1
         LE6g==
X-Gm-Message-State: AOJu0YymF0DTeQv5il6ReO+Jue2Xo1gPDdkC3zLqx7MJJlC3WC25oxTP
	57LHbMarPHIuuYvD7q4cek3qAXCvZUzUT3SaRUIeCjXHO7TGqW0TxTIEdUyI33tENnkrOfLWW+z
	sXk3Reiq7rgDv8VgRwy9Sruo4hzZLECkylYObb4O1NeNDjbDz4Y4ufmJCf+ADxib8IH7EG+Cw0g
	ExZlMo+5wVyvDdXao46sy9t7DztDgddAy9+sOE5c2N
X-Gm-Gg: ASbGncsR+iL3hLUqetxENVZfZvwEI/waGnLMmDxBuEr/JSLTDO9ZgPqC3MN7OOyitBY
	WOTVVmblxOfz8soiLxcT8IErQlwiMSTmXEWHnOOm6Xp9mCf5SbvhWnLkdNuIIn4YViq8=
X-Received: by 2002:a17:90b:2704:b0:2f9:cf97:56a6 with SMTP id 98e67ed59e1d1-30823646dfdmr26106701a91.14.1744708944346;
        Tue, 15 Apr 2025 02:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1CAt76U8SavVKceq8kJnownH+pKS9Scm+WgQR62mshC+5trjXhyT/zpf1OeB3BzbjRRhoyhx28BBh1+FcoCE=
X-Received: by 2002:a17:90b:2704:b0:2f9:cf97:56a6 with SMTP id
 98e67ed59e1d1-30823646dfdmr26106666a91.14.1744708943950; Tue, 15 Apr 2025
 02:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
 <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com>
In-Reply-To: <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 15 Apr 2025 11:22:12 +0200
X-Gm-Features: ATxdqUERFL4o6Oi2kLnJks5OQH5A0wbbTbsXqcyxtDAIb6yZQ1tnBZn6Pj1woq8
Message-ID: <CAFqZXNtN_yv-KPfyrnaezX6QturnSbKGqgiY7ZBJmCg533u-+A@mail.gmail.com>
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: SElinux list <selinux@vger.kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:06=E2=80=AFAM Li Lingfeng <lilingfeng3@huawei.co=
m> wrote:
>
> Hi,
> Thank you for reporting this issue and sharing the detailed reproducer.
> Apologies for the gap in my knowledge regarding security_label.
> Would need some time to study its implementation in the security subsyste=
m.
>
> To begin validating the problem, I attempted to run the reproducer on
> Fedora 26(with kernel -- master 8ffd015db85f). However, I didn't observe
> the reported mislabeling of the root directory.

Hm... Fedora 26 is *very* outdated and not maintained any more - I'd
recommend using 41, which is the current latest stable release. Hard
to say if it affects the reproducibility of this bug, but it's always
possible that userspace is also somehow involved.

>
> The modifications introduced by commit fc2a169c56de specifically affect
> scenarios where the /proc/net/rpc/xxx/flush interface is frequently
> invoked within a 1-second window. During the reproducer execution, I
> indeed observed repeated calls to this flush interface, though I'm
> currently uncertain about its precise impact on the security_label
> mechanism.
> [  124.108016][ T2754] call write_flush
> [  124.108878][ T2754] call write_flush
> [  124.147886][ T2757] call write_flush
> [  124.148604][ T2757] call write_flush
> [  124.149258][ T2757] call write_flush
> [  124.149911][ T2757] call write_flush
>
> Once I have a solid understanding of the security_label mechanism, I will
> conduct a more thorough analysis.

I'm not sure how the two affect each other either... It almost looks
like the last mount command somehow ends up mounting the "old" export
without security_label in some cases, even though the exportfs
commands that re-export the dir without security_label had completed
successfully by that time.

Thank you for looking into it!

>
> Best regards,
> Li Lingfeng
>
> =E5=9C=A8 2025/4/14 18:53, Ondrej Mosnacek =E5=86=99=E9=81=93:
> > Hello,
> >
> > I noticed that the selinux-testsuite
> > (https://github.com/SELinuxProject/selinux-testsuite) nfs_filesystem
> > test recently started to spuriously fail on latest mainline-based
> > kernels (the root directory didn't have the expected SELinux label
> > after a specific sequence of exports/unexports + mounts/unmounts).
> >
> > I bisected (and revert-tested) the regression to:
> >
> >      commit fc2a169c56de0860ea7599ea6f67ad5fc451bde1
> >      Author: Li Lingfeng <lilingfeng3@huawei.com>
> >      Date:   Fri Dec 27 16:33:53 2024 +0800
> >
> >         sunrpc: clean cache_detail immediately when flush is written fr=
equently
> >
> > It's not immediately obvious to me what the bug is, so I'm posting
> > this to relevant people/lists in the hope they can debug and fix this
> > better than I could.
> >
> > I'm attaching a simplified reproducer. Note that it only tries 50
> > iterations, but sometimes that's not enough to trigger the bug. It
> > requires a system with SELinux enabled and probably a policy that is
> > close enough to Fedora's. I tested it on Fedora Rawhide, but it should
> > probably also work on other SELinux-enabled distros that use the
> > upstream refpolicy.
> >
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

