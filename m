Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562221805E
	for <selinux@vger.kernel.org>; Thu, 19 Dec 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617848; cv=none; b=FJOJUEubitFpdQ7JmbbXsIPByqu1ASdItKHD5Rx/f8Io1fA8kPpBb5rMBvTqmCpN3jytScPD6M9Eo4WT0B5tyr7p3OZg7DTH3UA1ewAq1pVbv5cliamhZ8UbVuB8cbg4yDnyQFo4M2RkEFS/o4XOZH+gYe70Sm3T9nyFqg1x0RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617848; c=relaxed/simple;
	bh=76vbspSX5S0c0ix9X1gkaZyTaQlGgWC7C2cSAXJxcN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tABNoTR8yFfiXxJUBM/xo+ZkisVvB10evTMsGWaXmWMSPzJ8BLP8AymOKowmB0LDdugb29JCuu5ExEThmlj9RVLfEqIcET3c7ZMOAlO4/LcJHESOcjL3KzUVgEVt+x+/ee3oAcKQOiv42LHbYPHHii+T4n7bt1+KC+pHe0WcEfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQfUOXxx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQfUOXxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734617845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ug5ZfqMCf0kFopl70Hdcc3pYcK2lkyarcEqqfur20To=;
	b=KQfUOXxxi9sW1OlcBCoKG1yI72YL/Ly1V0g4Dc75REef8dHQh5ilVrAoNHQsXREu04VBuW
	uUJrAT1xANgBzXOtLIzkh5qzXac5Ku6qSg8XO/aHNIK4rz6YrM2TUKcXTIa4DMQA+zq/ox
	VOCgV6vLrZZc8wE6AJsE+8IyLK0J1IA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-AQavoT8qOn-S5tV7wET2QA-1; Thu, 19 Dec 2024 09:17:23 -0500
X-MC-Unique: AQavoT8qOn-S5tV7wET2QA-1
X-Mimecast-MFC-AGG-ID: AQavoT8qOn-S5tV7wET2QA
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-725d8bdc634so834402b3a.3
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2024 06:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734617842; x=1735222642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug5ZfqMCf0kFopl70Hdcc3pYcK2lkyarcEqqfur20To=;
        b=NA327nSbD8CQSHMg+3pTKG9/v3zF/0NNYaTnQ8PWeW7H1GSie3wdA+DhcJThgEMQcL
         ccd3mTN1qYXSVFoV+tXSnz/8wFERsfU00NcyL+DZXI40BPe4wPuz16KRh8TKbi/sPMef
         yh4BP02F5+Tq404bcgv0KnxWZJGmFsICmB8JPNzEzn/7UIF2negKVRNRcG5Btk/aGtvC
         x1TlotcZ4Qmty1OKQCb8sJthoDiFme4ZSKBHtZEeU2S3m95sZhPOEjqAg8Kl5Zs0PPBt
         AzEOc4skFw5ACrYaP5RZpbDap8SN6S3TWiVKtZrPeEaGFz3r+qyYE1Gm4OxcS20hlU3u
         I/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVd2UIrRSaAL3WZ9PK89ixcT/ak3DRPb46DTz0rPgKNU7ZosjNdnPyjOKCkuFKBk7i5pC51XvEb@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJOlnvvRdRJ/ee+gG0pmR34/EJqG0ckQyFwVpF3K663sWHNgm
	jy6MAXBYacGSnsV5KlOoPRbxMFVMEq0/SS0INMtloXFvJs0AycGEuDypQxCKhtAVvbZ6nxEilv9
	0IY+w5+ZfFgk30pBcv1aAW5vy+O6FCh5oLKGrDKrV4Uz+LGE0kOBBfnPBwzXddZfdidknPY9lhT
	TsZAKHOANUyzKkEv4aWsHfAwfoB60F4A==
X-Gm-Gg: ASbGncseYk9WoiuWBmvJv0YbUSLBYvbE8E+TlJi2XQyMyqIVs1vzkjjddd7oQ7sUMhZ
	ESl23U3GHTjIit9NdDGe1E4j80MvHSgfX9MavL/Nsij7Fn4nrIEUgv+YQuUImOiFyHy5luJE=
X-Received: by 2002:a05:6a21:999d:b0:1e1:a8e1:b104 with SMTP id adf61e73a8af0-1e5c76d1cadmr5761127637.45.1734617842626;
        Thu, 19 Dec 2024 06:17:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZQ7uI/EylE/umX9w0tu/dPHC6MDel6ZZk3oSSEs36muBMJdtn/mdKwO5FDgb6vTXQAgd9rZLDcm2IsLeDQbk=
X-Received: by 2002:a05:6a21:999d:b0:1e1:a8e1:b104 with SMTP id
 adf61e73a8af0-1e5c76d1cadmr5761083637.45.1734617842224; Thu, 19 Dec 2024
 06:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNuVK=Pt6Vx8xiUF7WFhCD3VrqjW=dvox4wHWZfHBCEDTQ@mail.gmail.com>
 <CAHC9VhTqe9roT1dySDXDMQzbOSZyA0f34H0a1xinDSLd-TyQTw@mail.gmail.com>
 <CAHC9VhTTGA5LADsn4OxJAUkd4V0auS4LrPQs87JqmRVV4nraxg@mail.gmail.com> <CAHC9VhTSeC3NAbAA192ZHQsRZe2aYELHM9inYOPRsR31wSyh2Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTSeC3NAbAA192ZHQsRZe2aYELHM9inYOPRsR31wSyh2Q@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 19 Dec 2024 15:17:10 +0100
Message-ID: <CAFqZXNvJAQNLWZ795cj64FVG5zVzYtiTTuFzxOS5AwcfD7kV-w@mail.gmail.com>
Subject: Re: kernel-secnext aarch64 builds missing?
To: Paul Moore <paul@paul-moore.com>
Cc: kernel-secnext@googlegroups.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 5:41=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Dec 17, 2024 at 12:29=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Tue, Dec 17, 2024 at 11:28=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Tue, Dec 17, 2024 at 4:17=E2=80=AFAM Ondrej Mosnacek <omosnace@red=
hat.com> wrote:
> > > > Hi Paul,
> > > >
> > > > It seems that aarch64 builds of the secnext kernel stopped appearin=
g
> > > > in [1] some time ago (and kernel-secnext testing results for aarch6=
4
> > > > stopped appearing as well). Were they intentionally stopped or is
> > > > there a problem that prevents them from being produced?
> > > >
> > > > The new Testing-Farm-based selinux-testsuite CI matrix includes
> > > > aarch64 + secnext kernel, so it is somewhat affected (until [2] it =
has
> > > > been quietly installing rawhide kernels instead and passing; now it
> > > > will fail when no secnext kernel is available). Any chance the aarc=
h64
> > > > builds could be reinstated?
> > >
> > > [NOTE: adding the selinux list since it is somewhat related]
> > >
> > > Hi Ondrej,
> > >
> > > Yes, sadly for some reason Fedora Rawhide, which I use to build the
> > > kernel-secnext kernels, started panicking my aarch64 system *hard*
> > > after an update some time ago and I was forced to disable the
> > > kernel-secnext builds.  Unfortunately the issue appeared to be due to
> > > some userspace, or compiler change, that affected the entire system
> > > and once my build chroot was updated using dnf the entire chroot was
> > > bricked.  I saw similar problems on my aarch64 dev/test VMs.  I dug
> > > around on the RH bugzilla and didn't see any reports, nor anything
> > > obvious via google searches.  I was hoping to go back and try to debu=
g
> > > and/or restore the chroot and VM but I haven't had the time.
> > >
> > > As a reference point, Fedora 41, Alama v9.5, and Ubuntu 24.04 are all
> > > working fine on my aarch64 system so I doubt there is some hardware
> > > issue.
> > >
> > > Are you aware of any nasty aarch64 problems in Rawhide, either now or
> > > starting back in October?
> >
> > I'm still interested in hearing if anyone has any info on a
> > aarch64/Rawhide breakage in October as it may help me recover my VMs,
> > but I just now tried creating a minimal aarch64/Rawhide chroot (only
> > installed bash) and it seems to be working now (!).  I'm going to try
> > to rebuild a new Rawhide chroot that can build kernels and see how it
> > goes ... more info later.
>
> I was able to rebuild the Rawhide chroot and recover the Rawhide VMs
> and it looks like everything is back and working again.  It will
> likely take several days to catch-up with the src rpm backlog, but you
> should see secnext kernels starting to appear in the repo in the next
> few hours.

Thanks for making it work again! The aarch64 secnext CI runs are
passing now. I'm not aware of any bug that could have caused the
issue, but it's Rawhide where unfortunately even nasty bugs might
sometimes appear.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

