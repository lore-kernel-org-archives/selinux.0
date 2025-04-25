Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09F7E9
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580879; cv=none; b=A38+CvOO5oiQ0or01SrD8/0qWDKPL5uNVJMpVuN0P+y5rUVg+3d38XpuMyo0w4sojy2y38Qny4h+CzQuv7eYRpsdJXbiS2Pc5JrRh77kb5KhzlqlHwF+ZkTmSOtTQuap7NlvgJAAu36Zgg+7gZpY6bySl+jAqhXQL8ip4+j+KsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580879; c=relaxed/simple;
	bh=Fwziz23al86klMSTNS8NCYDkke85c/AxN527h2yeshc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObADQjulTdPk55bcNi8wPA259PU5ZH+y8edvsjzk7DSEu1oOhU7UtxLf+5GXPN7qfFOOFN4YQPUb914FD0W9JbK+xXjtTdSsYXcypCIYqfCXendR8GrArzKLvBp+rJHJpyAGl+pRZlK959ftjIwJ7wUnXcF0V1Io7QaxWePBC+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wt1iMwq1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wt1iMwq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745580876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tAIdmmTJk/iQ6F5Z1do66dnxSKaku6TN9cr331Al2s=;
	b=Wt1iMwq1IWRBIKOz0OZZJM71qZy9jkIVSMZVTC/RRze+/4HGxRYG7Sy+aiMeawrRja8jmp
	3I4qeFMg1QhWsY9/WWNhuTFmbstYq2bGjOSM57OVnBCxMpcoLnXsKAJddTb8cVLOUteAnW
	5W3r33qLCLZSEciXje4mylwbwmeI2ck=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-ogV_Do2UNgq1-t0qmBU8aw-1; Fri, 25 Apr 2025 07:34:35 -0400
X-MC-Unique: ogV_Do2UNgq1-t0qmBU8aw-1
X-Mimecast-MFC-AGG-ID: ogV_Do2UNgq1-t0qmBU8aw_1745580874
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so2069093a91.0
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 04:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745580874; x=1746185674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tAIdmmTJk/iQ6F5Z1do66dnxSKaku6TN9cr331Al2s=;
        b=f5X/q9MxlEzO+sInEyZQw0XA1lmKwR1zKrNJKOkQWwU5a4pjgUA0I4gu0U9Ura3y0+
         cEXMVxwfGNeYoT+AdSqI8vrapoXU55DBEvzdiKTP25zs0mPT/hGOKDm0DHkCvgT3EYXH
         ioWJhqLffOGHOrjH4QXZdZPp7sgfZaMCm4zsKt1Pxx6eTvaln87RgC0p4J8VwcfM6emC
         J7RGkMFv9EoVS4C4ceT5Lmy4lfy/Dpp1lZN/w6YazsarAILXZO0hVsuvuO19R2EuEtQZ
         9ffY0mRdswkOgkxIYbQdgEQ/G9OhKUaU+KFTMzRxRhjtg+q3h6/GR+U+sWDosrn9Tw2m
         nL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpUWtWx49grRkbdHjfQO41EK2rHf35STD5pt8KSZ76C5dDZZ9u9wQZKhSY+IXWMM9ejlzkbaLI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5L2LGNZaxYBKVxrxKMBWcba/gOdKBq91RsMOqOla4LdYwmIeI
	8WOUjiwoowZeFGPlqGYN07SnLYbWrzU38Jno++aD2Ak2I8ZfhERvbyU0qM93mVh+QtsnqRMUCKe
	OlXZnJstddFlSZFvuQPf/1lhZiiP3sjkaSVFlu2diihagk5O5rATp/v9SRzrP8sB0IB/TLDjGyk
	K4HdB4TG/BVrwRfkc6ABV8hVv0jtkfTw==
X-Gm-Gg: ASbGncu6rIMR3OJSv/3Brv2E8LTB1sD/bGhQ7sikIqzQE+a244SM3KkGjDjpiQeQc6n
	ev0xu1KoM5TEvfYHKP9qJwtY/M7yN4jD+a2FV8M7VSD9CsLMAF+ybTXiV2O2+e8ZeqH+SlPD6F0
	n+2LoeWfk7vubtWy2ZBd0D3T6f8g==
X-Received: by 2002:a17:902:fc87:b0:223:64bb:f657 with SMTP id d9443c01a7336-22dbf73ba01mr33702795ad.46.1745580874317;
        Fri, 25 Apr 2025 04:34:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDtRjmo2YbrMRAhqN25kqMB8l0TbqgI3Zi8XAI2eGYwE8e8qkfvb2sJw9/JgIaJJwtTWOFR103dnZGv1JnuVo=
X-Received: by 2002:a17:902:fc87:b0:223:64bb:f657 with SMTP id
 d9443c01a7336-22dbf73ba01mr33702585ad.46.1745580874024; Fri, 25 Apr 2025
 04:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
 <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com> <CAFqZXNtN_yv-KPfyrnaezX6QturnSbKGqgiY7ZBJmCg533u-+A@mail.gmail.com>
 <CAHC9VhTMc0kJo3Fh-CPPMz9WghANRGB6NpZARgvN-srDJeeXFQ@mail.gmail.com>
 <CAFqZXNtZLPpspu4PcXsSU5Q7H07wgKGS6CmtOaQVXu9OujDiZQ@mail.gmail.com> <9cb6e931-799b-46d4-b773-9b6fb4fd13ec@oracle.com>
In-Reply-To: <9cb6e931-799b-46d4-b773-9b6fb4fd13ec@oracle.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 25 Apr 2025 13:34:22 +0200
X-Gm-Features: ATxdqUFsp-pz53G3HZaZG_x9MlyMD8aG6ozlup192uibwCSfa7PCzF2pOWCnjds
Message-ID: <CAFqZXNsMXhmZncF_u+vNqG_=ho-rns85maw5fYGux9zQG6J=dg@mail.gmail.com>
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Paul Moore <paul@paul-moore.com>, Li Lingfeng <lilingfeng3@huawei.com>, 
	SElinux list <selinux@vger.kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>, 
	yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 3:34=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 4/24/25 4:45 AM, Ondrej Mosnacek wrote:
> > On Thu, Apr 24, 2025 at 12:37=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>
> >> On Tue, Apr 15, 2025 at 5:22=E2=80=AFAM Ondrej Mosnacek <omosnace@redh=
at.com> wrote:
> >>> On Tue, Apr 15, 2025 at 10:06=E2=80=AFAM Li Lingfeng <lilingfeng3@hua=
wei.com> wrote:
> >>>>
> >>>> Hi,
> >>>> Thank you for reporting this issue and sharing the detailed reproduc=
er.
> >>>> Apologies for the gap in my knowledge regarding security_label.
> >>>> Would need some time to study its implementation in the security sub=
system.
> >>>>
> >>>> To begin validating the problem, I attempted to run the reproducer o=
n
> >>>> Fedora 26(with kernel -- master 8ffd015db85f). However, I didn't obs=
erve
> >>>> the reported mislabeling of the root directory.
> >>>
> >>> Hm... Fedora 26 is *very* outdated and not maintained any more - I'd
> >>> recommend using 41, which is the current latest stable release. Hard
> >>> to say if it affects the reproducibility of this bug, but it's always
> >>> possible that userspace is also somehow involved.
> >>>
> >>>>
> >>>> The modifications introduced by commit fc2a169c56de specifically aff=
ect
> >>>> scenarios where the /proc/net/rpc/xxx/flush interface is frequently
> >>>> invoked within a 1-second window. During the reproducer execution, I
> >>>> indeed observed repeated calls to this flush interface, though I'm
> >>>> currently uncertain about its precise impact on the security_label
> >>>> mechanism.
> >>>> [  124.108016][ T2754] call write_flush
> >>>> [  124.108878][ T2754] call write_flush
> >>>> [  124.147886][ T2757] call write_flush
> >>>> [  124.148604][ T2757] call write_flush
> >>>> [  124.149258][ T2757] call write_flush
> >>>> [  124.149911][ T2757] call write_flush
> >>>>
> >>>> Once I have a solid understanding of the security_label mechanism, I=
 will
> >>>> conduct a more thorough analysis.
> >>>
> >>> I'm not sure how the two affect each other either... It almost looks
> >>> like the last mount command somehow ends up mounting the "old" export
> >>> without security_label in some cases, even though the exportfs
> >>> commands that re-export the dir without security_label had completed
> >>> successfully by that time.
> >>>
> >>> Thank you for looking into it!
> >>
> >> I just wanted to check and see how things were progressing?  I haven't
> >> noticed any failures lately on my Fedora Rawhide + patches kernel
> >> builds, but I wasn't sure if the problem had been fixed or if I've
> >> just been really lucky :)
> >
> > I can still reproduce the bug on the latest Fedora Rawhide kernel
> > (6.15.0-0.rc3.20250422gita33b5a08cbbd.29.fc43.x86_64), which is based
> > on commit a33b5a08cbbdd7aadff95f40cbb45ab86841679e in Linus' tree.
> >
> > Can we perhaps have the commit reverted for now while the bug is being
> > investigated? The change doesn't look essential and should be easy to
> > reintroduce once the bug is addressed.
>
> I've queued up a patch to revert fc2a169c56de in the nfsd-fixes tree
> for v6.15-rc.

Thanks!

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

