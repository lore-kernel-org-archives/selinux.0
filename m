Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B78F5A
	for <selinux@vger.kernel.org>; Mon,  9 Sep 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872632; cv=none; b=LnJjoA3qCjFIoFK2U5Gu8yKj5Mf3BvUNyrDdvojiXx7Bl6fEzRYAK0hnFMm4lwVkmf/4PtNGkS13uB640ybPI4pi7iTCGzPfjbmlHWktYy/BBpVzjKz8e+6ImIZFuDqlCpB2YWBYdFarQhpw6gU0csoJ9rCVxwC+4+d9F2q6Zx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872632; c=relaxed/simple;
	bh=ICNFVWtsCz9hI8Xvx/FUEzotwSRizv7BxvMgVLHNE1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1x0WKllMItn8jhIxyT8thic7zOetzHK/xTlnzEr3pG4OvjEl+nAUXDYS5oqdYLbXNdIhHpfQ4itHBHyDCS83O0RrL3DitIVWR5NvZT1QfUulkRp+B6+wsiuo0jdFXCDFjpPZCQ5a1ycNof0SVC9s5DCMTUcS5YkfZ7rJhNUrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHo5JrBO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHo5JrBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725872629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICNFVWtsCz9hI8Xvx/FUEzotwSRizv7BxvMgVLHNE1w=;
	b=AHo5JrBONZ9wy/Hc041kTFMbc0l2JHRKJsJb1aQ//TrE56lORWftg4pWZzJgVosA1GyDiq
	oqtZl4ljjt9+gEBR5zk/hAvAocvEDq8gJ0YwsITvOe8q0tR6x1vLrGK6p/svwTN5h8wGV0
	gUJEmGDIRoyylJ4lXVeDAM1xT5qqAM0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-bKVHKKlkNlijJdwnqGj_6g-1; Mon, 09 Sep 2024 05:03:48 -0400
X-MC-Unique: bKVHKKlkNlijJdwnqGj_6g-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7b696999c65so3017691a12.3
        for <selinux@vger.kernel.org>; Mon, 09 Sep 2024 02:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725872627; x=1726477427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICNFVWtsCz9hI8Xvx/FUEzotwSRizv7BxvMgVLHNE1w=;
        b=IQtn7lTZeUdfOGprS5to7xyiZKVmER67Evb7/EXfnaYiUQkiZ9zXUQm3nRLFzjzuFV
         +O1WnO8DMw7p45iRCQa96Pb9xupTA8lf4FSYYe0X12qGmH5MAJGJdQHlfNb2ES3TW0J6
         CYLWxowL0hitmmnzyW/CrVwwgfCkSpKYvBMUo+om84Jr+hNm8s4YC9LNCUG8GzSBKLa9
         2WauLX7wTNx6vSTC0RCjkQhyJU8cQVrwu96KI6p1pvdwsRgG7sE8TR/elghhQQZKhc02
         iUVAYWAuflwdHQiaU9nxq3YY2hnYhuFEtTe1LMAdsvUfMEl0/ScO8rZlYuKqK6cDOUNT
         1blw==
X-Gm-Message-State: AOJu0YxT0lwUYRm0+Nk/i9M7/WJyrmJuFkHnu5cqmfyhtzaTRJsODgTU
	TEZHlyKU7pbrumvO24Md/PpDVRaHYTURQyLi4aofa3HTlQgzovcTNP29pvP5ojBXoZgx4ugC2++
	WAG6Seu8F9aYXIMFRvKhvrOcUqoPTCrJ3VmV9/njEtjbkbemMA9kY8vl2h+Ve1Vw0QNT3QNiNXq
	yrw+PxQc8vTsj9g52bA854HdBDrvltJvrQHvbnmA==
X-Received: by 2002:a17:90a:b702:b0:2d3:d066:f58b with SMTP id 98e67ed59e1d1-2dad50d19aemr8911727a91.12.1725872626685;
        Mon, 09 Sep 2024 02:03:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7aZsETlaI4dmYZqTPtHhkPAN/sbcjyx5qQieYjCR1K2kl+tz77NF5UjHJm1leueROYA0M9MNwKpe1gXRC3As=
X-Received: by 2002:a17:90a:b702:b0:2d3:d066:f58b with SMTP id
 98e67ed59e1d1-2dad50d19aemr8911712a91.12.1725872626290; Mon, 09 Sep 2024
 02:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNv7T8Tv_9AYX2xC_tJ9x10qPoPFQsQPBUDOuphUfUFPiQ@mail.gmail.com>
 <CAEjxPJ4o1cnQ3J8d2xE8Si_9QPM7JNuGin2Kz6NL+mu+Oj5u-Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4o1cnQ3J8d2xE8Si_9QPM7JNuGin2Kz6NL+mu+Oj5u-Q@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 9 Sep 2024 11:03:35 +0200
Message-ID: <CAFqZXNviYRwWrVqvh3VCSsOkubjUXAE955Y00+8NXev9B_1aOw@mail.gmail.com>
Subject: Re: selinux-testsuite / NFS symlink issue
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:29=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 4, 2024 at 11:13=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > Hello,
> >
> > While playing with migrating selinux-testsuite CI to Testing Farm
> > (more on that later) I encountered a problem when running the NFS
> > tests: When you create a symlink to the testsuite directory, cd inside
> > that symlink, and run ./tools/nfs.sh, the nfs_filesystem/test fails.
> > In fact, I also get some strange failures in unix_socket/test in the
> > general testsuite run over NFS, but only when I run this scenario
> > manually, not when running through the TMT tool (which also runs the
> > tests inside a symlink to the testsuite directory, but only fails on
> > the nfs_filesystem/test).
> >
> > Feel free to investigate if interested, for now I will leave the NFS
> > tests out of the CI, as it's not clear if the issues are in the
> > testsuite or the kernel (or both) and I don't want to add workarounds
> > blindly.
>
> I'd tentatively guess that the symlink problem is merely that the test
> policy isn't allowing the test domains to read
> <whatever-type-is-on-that-symlink>:lnk_file. I'd try that and if so,
> possibly add it to the test policy or relabel that symlink to an
> allowed type.
>
> Unix socket test failures sound familiar - I seem to recall an earlier
> email exchange about encountering that myself that turned out to
> actually be the bug in NFS that I fixed earlier this year.

Good point! I must have done my debugging runs in an environment with
an older (broken) kernel and not realize it... Back then even adding
the policy didn't resolve the failures, but with a recent kernel
adding two lines to the policy is indeed enough.

In the meantime I have refactored the way the tests are run, so it
incidentally no longer triggers the symlink bug, but I have posted a
patch with the policy fixes anyway, so that it doesn't become a
problem in the future.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

