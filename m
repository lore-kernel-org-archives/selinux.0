Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66442202995
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484333; cv=none; b=bruP8bHIj4QNTmqgXPqXAa7sR1K4FNP6aAKRlUPVxecx47pEOyFbGAqXYk4QD2OamnhhvOBb4k/WZ96JSJw6YrQ0IS/CqQ37byqhFrbGgThFpIUiLF8u5wFuMP//unlC3wjQ8vhdrXEbV3ccFqdHvM3P25j183mw0ZvqpihkrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484333; c=relaxed/simple;
	bh=1D0gcFhcTz+R+c/oZaToJTc0uXK9wegse24TORZ7X68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT5HVc+TZGZTPNN2sS/s3OZlChvfYHAr0+rFcuo/3qUNlYx0/A4VoaSEI0rYaL9fr2U+m0EfOeH1u9i9Q7p5CLM5CSlF/QvgE01in7JaNGpudsCACWaydo8juLhBAWyjL8TT46HqXFV1kkYWmKSGtk1h6J1D9Mv2ANRCzmmV6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h04Rtab6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h04Rtab6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745484329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GmfudU2+DoK0pIJ/x9YJl9MQHciDQNIRSDIICWzbVIc=;
	b=h04Rtab6XWXE66wv1txVZQ8FaK5p+g9/v0l3LzbGknGoOgTwpVIA6j7qI0Jj3G+VVr+vD+
	CRf/BfTBDjfm2XMCiYXDCOQhmf4ga8Hh17Pu4lPzgSNXqZYpqoLQtH4n2zQPdzTTQJWMH+
	jovY/I31g7K9l3EbdIJMqjckMBvcASs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-xcCx0FqcPxqrXYVwoEZvbg-1; Thu, 24 Apr 2025 04:45:26 -0400
X-MC-Unique: xcCx0FqcPxqrXYVwoEZvbg-1
X-Mimecast-MFC-AGG-ID: xcCx0FqcPxqrXYVwoEZvbg_1745484325
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30364fc706fso686700a91.3
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 01:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745484325; x=1746089125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmfudU2+DoK0pIJ/x9YJl9MQHciDQNIRSDIICWzbVIc=;
        b=iMX2TedAwXNg+asdVXw8CMRK4H5Hnpaw/3AsXLkUFCBVRslo4GFFwsuEP86PA5QCIM
         aMOWbgWu5BoQ1zaWCG0DQ8Z6DTWoMj7o/skMeOkAXcuZUSiL2VLAiVWGfviXZfxDWwex
         5+6dfOHv8xLl50uBilFYAqETnafphe16MGgTyxFvIv+vaEhu22zb10M+EuneQZvKLwI4
         YdVRE5GQQt/C6iWnhuzRmu+d0zl2lVPfVAWb2+6TeIn2HsS4l1j+N8MQ9qquo4Fi1yhs
         sZAdIVEKjxZ54LjjhyLK8p0EzHS20GKm1MIKZRtlMK5fV4oB9m4b3DvzITfJjnszOu7y
         V45A==
X-Forwarded-Encrypted: i=1; AJvYcCW6IHmlZeOYOpl7ZNMxBkY/MFMjEKbmb/IPtDSiQJHdh+3UFL9TXXOV/xafol8Jb9P/S3cpeqxc@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMOtV1fRqYWo4Y6PviRkiXNxTZ8SObCRUSI4UmCZ6mzgR+KJE
	08DQelTz03dmOEPEkIzICBSi1IOLq1wo6YxWSErVwrb2bhOao6xUj2DuWVeNQhRCzMqfqU5pNrX
	nNlseC7H5nlQ1t8Vij/GT4sTx2Vo9BImsOpVqZyeC+WyqI9MMTr4bnq6FaEzK5P8Y4krL2ZKFYR
	jkpZSSgqWaXfBg43wuD8jpg6DgTwiDbw==
X-Gm-Gg: ASbGncvjuZAwmtM5p3M6XYubVp9yicjn9JZnDDCk/pVDw8gm//EeUEeoEzHpxRMb71U
	1OsJ8k5qYKcW3ypiwCp/dzZW4DJREFcQgpC3Sgdyv7F0iDj4tl/zqlhafLDS1F5NOAEo=
X-Received: by 2002:a17:90b:514c:b0:305:5f25:fcf8 with SMTP id 98e67ed59e1d1-309ed26d0c0mr2811308a91.5.1745484325256;
        Thu, 24 Apr 2025 01:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8qE1a9YJALnhvfCAjhCgX+1Cj02zt8jg/X3plOzAsRT1XwxMk+z6/FcBXilIihEZGe8znydPvPXUU9O669HQ=
X-Received: by 2002:a17:90b:514c:b0:305:5f25:fcf8 with SMTP id
 98e67ed59e1d1-309ed26d0c0mr2811289a91.5.1745484324925; Thu, 24 Apr 2025
 01:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
 <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com> <CAFqZXNtN_yv-KPfyrnaezX6QturnSbKGqgiY7ZBJmCg533u-+A@mail.gmail.com>
 <CAHC9VhTMc0kJo3Fh-CPPMz9WghANRGB6NpZARgvN-srDJeeXFQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTMc0kJo3Fh-CPPMz9WghANRGB6NpZARgvN-srDJeeXFQ@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 24 Apr 2025 10:45:13 +0200
X-Gm-Features: ATxdqUErmJ4l_wmskHtKDmVt3MK7rQGChN1VwoIXtcxZt1m219alXaKpdrJekYs
Message-ID: <CAFqZXNtZLPpspu4PcXsSU5Q7H07wgKGS6CmtOaQVXu9OujDiZQ@mail.gmail.com>
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Paul Moore <paul@paul-moore.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, SElinux list <selinux@vger.kernel.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 12:37=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Tue, Apr 15, 2025 at 5:22=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > On Tue, Apr 15, 2025 at 10:06=E2=80=AFAM Li Lingfeng <lilingfeng3@huawe=
i.com> wrote:
> > >
> > > Hi,
> > > Thank you for reporting this issue and sharing the detailed reproduce=
r.
> > > Apologies for the gap in my knowledge regarding security_label.
> > > Would need some time to study its implementation in the security subs=
ystem.
> > >
> > > To begin validating the problem, I attempted to run the reproducer on
> > > Fedora 26(with kernel -- master 8ffd015db85f). However, I didn't obse=
rve
> > > the reported mislabeling of the root directory.
> >
> > Hm... Fedora 26 is *very* outdated and not maintained any more - I'd
> > recommend using 41, which is the current latest stable release. Hard
> > to say if it affects the reproducibility of this bug, but it's always
> > possible that userspace is also somehow involved.
> >
> > >
> > > The modifications introduced by commit fc2a169c56de specifically affe=
ct
> > > scenarios where the /proc/net/rpc/xxx/flush interface is frequently
> > > invoked within a 1-second window. During the reproducer execution, I
> > > indeed observed repeated calls to this flush interface, though I'm
> > > currently uncertain about its precise impact on the security_label
> > > mechanism.
> > > [  124.108016][ T2754] call write_flush
> > > [  124.108878][ T2754] call write_flush
> > > [  124.147886][ T2757] call write_flush
> > > [  124.148604][ T2757] call write_flush
> > > [  124.149258][ T2757] call write_flush
> > > [  124.149911][ T2757] call write_flush
> > >
> > > Once I have a solid understanding of the security_label mechanism, I =
will
> > > conduct a more thorough analysis.
> >
> > I'm not sure how the two affect each other either... It almost looks
> > like the last mount command somehow ends up mounting the "old" export
> > without security_label in some cases, even though the exportfs
> > commands that re-export the dir without security_label had completed
> > successfully by that time.
> >
> > Thank you for looking into it!
>
> I just wanted to check and see how things were progressing?  I haven't
> noticed any failures lately on my Fedora Rawhide + patches kernel
> builds, but I wasn't sure if the problem had been fixed or if I've
> just been really lucky :)

I can still reproduce the bug on the latest Fedora Rawhide kernel
(6.15.0-0.rc3.20250422gita33b5a08cbbd.29.fc43.x86_64), which is based
on commit a33b5a08cbbdd7aadff95f40cbb45ab86841679e in Linus' tree.

Can we perhaps have the commit reverted for now while the bug is being
investigated? The change doesn't look essential and should be easy to
reintroduce once the bug is addressed.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

