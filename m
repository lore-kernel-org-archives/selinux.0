Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5EB1EB489
	for <selinux@vger.kernel.org>; Thu,  1 Aug 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538097; cv=none; b=ogosKZ1y1ZGI9pNHw09jYmQKoQlx/w0hjNH7D1hXdyirha/FofhOIGxhgEuORrZR7XuNlza8lkw+w0XNhjsXosPWkjN3/TJhNX36Bm6miFxA0s8nqwdDI34cTAVzvXgTl9nvccnSL17/EohWCpzYG7juq5GIeuPRWakyn0SoPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538097; c=relaxed/simple;
	bh=V6GeA6ELUmOP+ruSBpzvKj+31le2Prl6pjOJniotqX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uZmCKJSxwVSUGua0qPxfQjG4BX3HFm7aQQ5TlrbdvDn9QrfNjZbN5mRqon7D4J0cJX5wHC12SoKXTJAnOoZGl3pTLtz5Ymm/Jc3EgR0IGaWBROoQL+Bbtjpbc5JE8gcbSPscqZ/UCHfW2/6DV2ksFojLwAxH2a88Mfq2BKYh7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXHYExfS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXHYExfS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb4c4de4cbso4929212a91.1
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2024 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722538095; x=1723142895; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6GeA6ELUmOP+ruSBpzvKj+31le2Prl6pjOJniotqX0=;
        b=TXHYExfSieevwKGcHdKbzPuqmOhvQ8Z175FDiNpS/m1q0QhGHY0rFJCU8wMDLoUUem
         OQixq+4fIvaxKkkRtDjeWIUK8qs5luFliCLCkGhTHlc51eoLn9vbHYhlw/xQSFROQBSd
         Bp6yi/3aSsnXoDxVke7v7GU29DcQL4nzF1BIBj5wE9gZi21Byd8K1RiaTL5Fj0WbeMUn
         cFIFruoJM2FqMR/BVdsqQ4I6LCx4CKPPwE87YUr2sDHABuLCZiYyus9ot1htQqn8glxi
         jOGFPChURISejd46fL71rnxSISGRGNGZbqZL+JOoyZv39nHL5PxK7Xd1iyqmuOup2o2J
         U+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722538095; x=1723142895;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6GeA6ELUmOP+ruSBpzvKj+31le2Prl6pjOJniotqX0=;
        b=M3x7iJ6YQSopVLUX4Utz0AHci2Z4PPjbcmxx40pB3EoNVXthTH560Ajo51BMk0C5nJ
         gIzVNhCSzKQWndkvP+rt5AGTaCCAQF8htogTdJcIIQiQT1vyT+di5+uzZd7cFDwGVo5d
         9+Kpbwk2yTUWs4U9TO5RXig6icVA9rGkFGUcE3tztcdzMaTFQRPLHzAc/9HdOf/M96zI
         j8lUZyVgXpp0H5vQAgddWfIW9NHKHMxZdR5Ib1bbjsOBEnTcrPpdHS9Sd0mpd9wlpl0M
         oILpM1a6AIFM/01wIAv9DhtWUw+siKNQoOuyu8tmeqzmh5l4TjoM99gDz5jrqM/1zTot
         qG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX53Kr+1VxPUYVfHWYERx5MoC12jx9kws/loLtkMJXD6q98buZFix7Yw2wBPTZhYUofILjmikAZUvxBMs9/CpK4nsABaHqiHA==
X-Gm-Message-State: AOJu0YwM3Jmv+Te0Z17pU0dTFPKu6HAB0dZyc5j3ahCXuPfPaKXi53h0
	Qy2KbnCOX0msK21UpAcVvvmv9JO4v6FiGWyt1kjTMDBqe402tmgNUBv9m43jQRjLgBnih9CV0g6
	aehuGLc2UOmXqeoxstBQJujV2Nzc=
X-Google-Smtp-Source: AGHT+IFAE9EshbaeJ/unk40cD5FUZlUKkHPYkKs4HFaSi7RzgR0/n/Mp/+pK6AN3HlXTcntPb10FVtw95Rqy4W8KSoc=
X-Received: by 2002:a17:90b:f85:b0:2c8:da73:af82 with SMTP id
 98e67ed59e1d1-2cff943c31bmr1481278a91.10.1722538095245; Thu, 01 Aug 2024
 11:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ7WUzN=0Yv4POgPVHPG1wEjNn=-Tb53NiuMpWf+bEuF-w@mail.gmail.com> <CAEjxPJ758jx7X5Tauz=xQXsmWcZhx_V7AkU=PtsH6S3S9CUCbw@mail.gmail.com>
In-Reply-To: <CAEjxPJ758jx7X5Tauz=xQXsmWcZhx_V7AkU=PtsH6S3S9CUCbw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Aug 2024 14:48:03 -0400
Message-ID: <CAEjxPJ50ADVSOys58eYUktv4sjYYnEDroxA9Wnt6HiY9ySk=gg@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:03=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 1, 2024 at 9:01=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Aug 1, 2024 at 8:27=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > Given the recent discussion of the SELinux namespaces patches, I
> > > re-based the working-selinuxns branch of my selinux-kernel fork on to=
p
> > > of the dev branch. This required first reverting commit e67b79850fcc
> > > ("selinux: stop passing selinux_state pointers and their offspring")
> > > which I had created at Linus' request some time ago to avoid the
> > > extraneous overhead associated with passing those pointers when there
> > > could only be one selinux_state structure. Due to the number of
> > > changes, both substantive and coding style related, since the last
> > > re-base in 2020, there were numerous conflicts that required manual
> > > resolution. I also checked the coding style of each patch with Paul's
> > > scripts and fixed any issues introduced by the patches along the way.
> > >
> > > The rebase can be found at:
> > > https://github.com/stephensmalley/selinux-kernel/tree/working-selinux=
ns
> > >
> > > It boots, passes the selinux-testsuite (including the NFS tests), and
> > > passes the following
> > > trivial exercising of the unshare mechanism:
> > > $ sudo bash
> > > # echo 1 > /sys/fs/selinux/unshare
> > > # unshare -m -n
> > > # umount /sys/fs/selinux
> > > # mount -t selinuxfs none /sys/fs/selinux
> > > # id
> > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dkernel
> > > # getenforce
> > > Permissive
> > > # load_policy
> > > # id
> > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dsystem_u:syste=
m_r:kernel_t:s0
> > >
> > > All the same caveats apply - this is still not safe to use and has
> > > many unresolved issues as noted in the patch descriptions.
> >
> > Also, note that as before, this branch does NOT include the original
> > patches to support per-namespace superblock and inode security
> > structures. Given the known problems with those patches and recent
> > discussions, we likely don't want them anyway, but for reference they
> > can still be found here:
> > https://github.com/stephensmalley/selinux-kernel/commit/3378718ef7d4a83=
7f32c63bdfcc0b70342cdd55d
> > https://github.com/stephensmalley/selinux-kernel/commit/efb2ddadfdd0e10=
e75b6aa5da2ed9841df6ef2f6
> >
> > Without those patches, ls -Z will show as unlabeled any files whose
> > inodes were already in-core at the time of the creation of the new
> > SELinux namespace because their inode security structures will have
> > SIDs that do not exist in the new namespace's SID table.
> >
> > An alternative approach proposed by Huawei to my original patches can
> > be found here:
> > https://lore.kernel.org/selinux/20220216125206.20975-1-igor.baranov@hua=
wei.com/#r
> >
> > However, those patches also seem to have quite a few unresolved issues.
>
> Actually, re-reading that thread inspired me to take one of the ideas
> suggested by Huawei, so I just pushed up one change on top of my
> working-selinuxns branch to support saving the SELinux namespace in
> the inode security blob and re-initializing it when an inode is
> accessed by a process in a different SELinux namespace. This at least
> allows ls -Z to correctly show the security contexts of files even
> when they are already in-core.
> There still remain many issues though to resolve...

As just one example, if you setenforce 1 in the new SELinux namespace,
you'll instantly lose access to your open files since the file
security blobs (not the inode security blobs) still have SIDs that
were created in the parent namespace and aren't defined in yours. And
naively changing those to match your namespace will break access by
the parent process. Probably need to create a helper program akin to
newrole that handles closing and re-opening the fds in the new
namespace.

Then you still have the problem of the inode security blobs not being
refreshed on certain code paths because you can't sleep on those code
paths and fetching the xattr may sleep. Might require saving a copy of
the security context string in the inode security blob so that you
don't have to perform any blocking operations to refresh the SID to
match the current namespace, but that will come at an obvious cost in
memory.
