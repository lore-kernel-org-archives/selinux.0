Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A9514264C
	for <selinux@vger.kernel.org>; Thu,  1 Aug 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540533; cv=none; b=Dgip1s23b13ZcXgic5DYWMWEOIPeCTlr8caAcTcPXYlAwad3GWwn3KvlcRgX0aKQWk0BJK09zFK8iVd5MlhEqywZgZ/PPkTFz8wcadsjv0TDdbUSixoUR1pGVtS/u62ZcljpeiJraWlzFhbSYVyuin9mOeDmOMEZ1r1FS0RG3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540533; c=relaxed/simple;
	bh=xyfSHiiDFgwIdQ63IQyCbrfH+TX4yl8IHHNGtLJDF3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BxH+eBLb0j5fqpeOuFzfl9YB+WDaFELtyojZZhntDeRD6afgbDunEAKM6TbEqA7TuZbfdcWIDMFA4/sF84wv0ELVWG/DOyLDXhRQEKaKFKqegT6YRikS0h1PLhOVWStC4ow1ETrfvo/zSjgz8q+BOrmeD7cmUo/iRnL3vJSeKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkClAGog; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkClAGog"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7163489149eso5222267a12.1
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2024 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722540531; x=1723145331; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6pvEew+xtJmvYAHCCY9hG6R1nNkuZO8BsXZTImDsG0=;
        b=GkClAGognxC0f3N2oQZ2zCc2Ysw64eOzLXPBinrlN/c9xOq/YE3KC5qWqjfx2Bg0Jf
         ckniK9idLA5EY7tI30L7eVEfVWe0DQwBOWIqOWkRzQnAIS3uZD6VqL7WLuC2OTR28CVY
         U1fiEBtLql/EDykgSLrhCVm0jy4Se2dUcA/mGVyEapvo89SnLik4qceYmXTBxxl7DeEA
         owJq38fMzNLMnFL6t+cumZraSlVztFmkEYri8Tgyt5jDiKbXefrcR2a4oPFm8C331Ydu
         OQaRDyLGw3Z+rV/TNxzG7csssQSHvxwZebmqDNKone3rPViiZsD41HavuxxQ2IIZrmBl
         GlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722540531; x=1723145331;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6pvEew+xtJmvYAHCCY9hG6R1nNkuZO8BsXZTImDsG0=;
        b=DqemQTvt8BmOMZnUfwIuzXRzkxtVkYSXd3GhyStPrmYx6+0cXoVFDRFdkqO3TddqQZ
         UbR7qzCpJ5knM0d81heiXqyn0+1GRPa99DRkE4PYQ/NpjtKy8sK2tXgqdvKAvR8X4K6m
         IB4ndo/hd62LQF9KblRlmCyf0FHNUbi1TIAuo/6Nuk+kvBpxB+DfbC2VZXWcALQ0XzVM
         9yE+pNZO8zl76Ll2XZbfnIGMU0yRLPPUZdOtSHDiYV1zUffi3epsbjP5j+9G7G9MGsYS
         fyhAsV2LYhu+RA+XSiBVesCD0QgaY8w1O/Q7vVkQ6cRSOk9EOLUAyxzh5kgmDVGlzt7T
         dZbA==
X-Forwarded-Encrypted: i=1; AJvYcCW4o8X7wKCfz5N4Dn67h/7vi5nzXC46jtjLaC9gUUUfFR9P1p7RNNXT1L5dV720UfZmyvdBCwmQlx80WBKWSq01wsyf7hebbg==
X-Gm-Message-State: AOJu0YyXh/mAHA9g4KnIu6uwTL6fczy9odqGUfJQBrA3SLvAI5uWxxbq
	S7G0W/9UPMENBZMALT5uuCUzUQTdf6EqA0FYZNM37Hj5pCf6qHsDUbt+9zG1sRWYJ5LQ9rt0CH6
	aIjH8tGTAdcj/8u5rmzf0cyfpZVCgFg==
X-Google-Smtp-Source: AGHT+IGQ5qS+j8JWpojk747gsa220f6W0u7WFvzLj561l8TdfW2zamEJqidG4aQ9sSVkf8zzSDTmHTl0D478jf1sC/A=
X-Received: by 2002:a17:90b:1b12:b0:2c9:7611:e15d with SMTP id
 98e67ed59e1d1-2cff9487f29mr1545808a91.20.1722540531283; Thu, 01 Aug 2024
 12:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ7WUzN=0Yv4POgPVHPG1wEjNn=-Tb53NiuMpWf+bEuF-w@mail.gmail.com>
 <CAEjxPJ758jx7X5Tauz=xQXsmWcZhx_V7AkU=PtsH6S3S9CUCbw@mail.gmail.com> <CAEjxPJ50ADVSOys58eYUktv4sjYYnEDroxA9Wnt6HiY9ySk=gg@mail.gmail.com>
In-Reply-To: <CAEjxPJ50ADVSOys58eYUktv4sjYYnEDroxA9Wnt6HiY9ySk=gg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Aug 2024 15:28:40 -0400
Message-ID: <CAEjxPJ6QsYR-Kj8k0C=54cix8rdpBsCphDV5_QnjGONDuOm+ew@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:48=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 1, 2024 at 10:03=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Aug 1, 2024 at 9:01=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Aug 1, 2024 at 8:27=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > Given the recent discussion of the SELinux namespaces patches, I
> > > > re-based the working-selinuxns branch of my selinux-kernel fork on =
top
> > > > of the dev branch. This required first reverting commit e67b79850fc=
c
> > > > ("selinux: stop passing selinux_state pointers and their offspring"=
)
> > > > which I had created at Linus' request some time ago to avoid the
> > > > extraneous overhead associated with passing those pointers when the=
re
> > > > could only be one selinux_state structure. Due to the number of
> > > > changes, both substantive and coding style related, since the last
> > > > re-base in 2020, there were numerous conflicts that required manual
> > > > resolution. I also checked the coding style of each patch with Paul=
's
> > > > scripts and fixed any issues introduced by the patches along the wa=
y.
> > > >
> > > > The rebase can be found at:
> > > > https://github.com/stephensmalley/selinux-kernel/tree/working-selin=
uxns
> > > >
> > > > It boots, passes the selinux-testsuite (including the NFS tests), a=
nd
> > > > passes the following
> > > > trivial exercising of the unshare mechanism:
> > > > $ sudo bash
> > > > # echo 1 > /sys/fs/selinux/unshare
> > > > # unshare -m -n
> > > > # umount /sys/fs/selinux
> > > > # mount -t selinuxfs none /sys/fs/selinux
> > > > # id
> > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dkernel
> > > > # getenforce
> > > > Permissive
> > > > # load_policy
> > > > # id
> > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dsystem_u:sys=
tem_r:kernel_t:s0
> > > >
> > > > All the same caveats apply - this is still not safe to use and has
> > > > many unresolved issues as noted in the patch descriptions.
> > >
> > > Also, note that as before, this branch does NOT include the original
> > > patches to support per-namespace superblock and inode security
> > > structures. Given the known problems with those patches and recent
> > > discussions, we likely don't want them anyway, but for reference they
> > > can still be found here:
> > > https://github.com/stephensmalley/selinux-kernel/commit/3378718ef7d4a=
837f32c63bdfcc0b70342cdd55d
> > > https://github.com/stephensmalley/selinux-kernel/commit/efb2ddadfdd0e=
10e75b6aa5da2ed9841df6ef2f6
> > >
> > > Without those patches, ls -Z will show as unlabeled any files whose
> > > inodes were already in-core at the time of the creation of the new
> > > SELinux namespace because their inode security structures will have
> > > SIDs that do not exist in the new namespace's SID table.
> > >
> > > An alternative approach proposed by Huawei to my original patches can
> > > be found here:
> > > https://lore.kernel.org/selinux/20220216125206.20975-1-igor.baranov@h=
uawei.com/#r
> > >
> > > However, those patches also seem to have quite a few unresolved issue=
s.
> >
> > Actually, re-reading that thread inspired me to take one of the ideas
> > suggested by Huawei, so I just pushed up one change on top of my
> > working-selinuxns branch to support saving the SELinux namespace in
> > the inode security blob and re-initializing it when an inode is
> > accessed by a process in a different SELinux namespace. This at least
> > allows ls -Z to correctly show the security contexts of files even
> > when they are already in-core.
> > There still remain many issues though to resolve...
>
> As just one example, if you setenforce 1 in the new SELinux namespace,
> you'll instantly lose access to your open files since the file
> security blobs (not the inode security blobs) still have SIDs that
> were created in the parent namespace and aren't defined in yours. And
> naively changing those to match your namespace will break access by
> the parent process. Probably need to create a helper program akin to
> newrole that handles closing and re-opening the fds in the new
> namespace.
>
> Then you still have the problem of the inode security blobs not being
> refreshed on certain code paths because you can't sleep on those code
> paths and fetching the xattr may sleep. Might require saving a copy of
> the security context string in the inode security blob so that you
> don't have to perform any blocking operations to refresh the SID to
> match the current namespace, but that will come at an obvious cost in
> memory.

The last paragraph above actually rears its head even without fixing
the fd problem;
unfortunately that last patch I pushed on top of working-selinuxns
will render you unable to ssh into the system if/when you end up
creating a new SELinux namespace and accessing files needed by sshd.
It seems that the patch is updating the inode SID and namespace to the
new namespace and then sshd is trying to access those files through a
code path that cannot call  inode_security_revalidate() with
may_sleep=3D=3Dtrue and hence ends up using the wrong SID and being denied
access.

Smack's equivalent to the SID table allowed one to safely pass around
pointers to the label string, which was never de-allocated, so it only
needed a single copy in memory of each label. We could add something
similar outside the security server in SELinux so that
inode_security_revalidate() could re-map the context string to an
appropriate SID without requiring sleeping.
