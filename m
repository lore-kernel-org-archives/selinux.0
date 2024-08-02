Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CD1ABEC5
	for <selinux@vger.kernel.org>; Fri,  2 Aug 2024 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623679; cv=none; b=Kza/n4gWpardm7fk/fXqfwg4HfxOKmIr1iFZ31aK3psn8A82v47L+/+GiVYCZdF2ACwVkcXhQOXX6v42xb86Snz4sfHvxpyczd1SYPQGpIFkOFKK4ibCFHHY94lAyulHXBPhIsSYHBrxt/oL18JE6zzkxWolqT9l4ITfWPolyHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623679; c=relaxed/simple;
	bh=izZwWZ5N7Y62yJEjOB01tSsJOQJs3ylKR9qAMQ26g8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fvRdh5UcbodXcg66zS2EiQPYjFJmfvsWfydt8hTYTZXmEcTEdwsw9mfVNsOShxD4rmJ1JlnBeBL/9xJrNfgD56Ktw/vA4XfIhnT0haTkhZZSGqxK879ecfo5uAMf2t5t4iS5H7ujiMyCqTKSnNj/kXGa5L6GArohxK+Q55lQwwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2b4q0KI; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2b4q0KI"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b7a3773a95so48157226d6.2
        for <selinux@vger.kernel.org>; Fri, 02 Aug 2024 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722623676; x=1723228476; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBD+Q7UJOLV/7W6W8+4AzDKwz66TyVkCIT4BpFpdWY8=;
        b=e2b4q0KIY2GFw4exLJXpDTi4VSwuQgyVChYoJWnah8ltBjd5mEECRnS8yQZ7XijJm1
         gkFIQsLSM7ZFV0KmW5Ak1INAahyOEtxYzQurZ66/dJCdtehHGhuLayVHQpM7zsnHXKKq
         Rt+ZLHneGY5OpPftka62COGLrZZYirTEq++pi4MCRnn+0rbKeUo6E92evCwnQJpBCpR1
         BUidyhApjGB2zk71GbRNli2Gew8zV8TTkgXxf/sKzr7AGiGZfifZvcTrmOaZsrD97NA8
         5O4u5HNMZxM6SQkMeevPkmLqOdUP2qAhd9/3MjKqw6wxvwYxACzL2lmTJCU6YEFnVosR
         FKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722623676; x=1723228476;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBD+Q7UJOLV/7W6W8+4AzDKwz66TyVkCIT4BpFpdWY8=;
        b=QKjWHHWQ1QcnOjicZDPmAJX+7J6VCWNOx+wWdJPlZoU5tT+lfh9G0XGCPs5+sqRCUW
         ke5mTmqZemvnL0rAMtWxQCaImwoGWhvg17feOfWvHPBC0KF/DcJFvrdXmL7ITBo9b9+B
         IE8o+cjCcUayynUCA3T8YEVfXGw8yHwBGNXXuqduUhgrFDWdy2FSmG0chVFPUnSV9mTS
         azEfMvHJenq/KqrW1N3WNEgEu15EAvvz8OkMbR1k/wH6CK/Pzy1xNrcEet+ONSOWSsqe
         6hqb1fn6ALjV+xiN9/PPgVm+ND0L3qNQ2XQ8X5XufCh10kRIUOFzgMYzAK0lofbafz+f
         P6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUr51o+ib0cNvTQRA9SVW9plUwTm3Xe57R59Hv3E0Dw/RvAH7lkibNVK0f+36OayAMAbvgBPupldl21jCtZxHzlLF63797qfQ==
X-Gm-Message-State: AOJu0YzOx9u3USEP6T0Woktz6gX3m/ynPE0ytkyQeDbfO7HOF0+TQbVO
	+Qur4XwWusZ4N0Mc4TjlIDAh5msQ5Kjlfk3Ay9h/aBXYIp9ceaz4dH4Ai69tvE8bH/fWb9Np6Ek
	2gEwpewtRWsHYrydQkHqRIkIaehe0Kg==
X-Google-Smtp-Source: AGHT+IEVKAEhMQQWW9EVyij4qJe6OzH24DND+C5qrFIX7o46q601tTjhBKVmjkufykvNguqkcUgNYDCC35rz8jfdXyw=
X-Received: by 2002:a05:6214:2e47:b0:6b0:72c7:88d8 with SMTP id
 6a1803df08f44-6bb983efb52mr51162016d6.35.1722623676304; Fri, 02 Aug 2024
 11:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ7WUzN=0Yv4POgPVHPG1wEjNn=-Tb53NiuMpWf+bEuF-w@mail.gmail.com>
 <CAEjxPJ758jx7X5Tauz=xQXsmWcZhx_V7AkU=PtsH6S3S9CUCbw@mail.gmail.com>
 <CAEjxPJ50ADVSOys58eYUktv4sjYYnEDroxA9Wnt6HiY9ySk=gg@mail.gmail.com>
 <CAEjxPJ6QsYR-Kj8k0C=54cix8rdpBsCphDV5_QnjGONDuOm+ew@mail.gmail.com> <CAEjxPJ6p3oD99_aTEeSCx6FMob7BH8-2vxdoT69c8sw11oHuEA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6p3oD99_aTEeSCx6FMob7BH8-2vxdoT69c8sw11oHuEA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Aug 2024 14:34:23 -0400
Message-ID: <CAEjxPJ5jup5o9piVPuA97_radSzvshpnRB1CdBde8sV3ZXVc2Q@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 1:18=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 1, 2024 at 3:28=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Aug 1, 2024 at 2:48=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Aug 1, 2024 at 10:03=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Thu, Aug 1, 2024 at 9:01=E2=80=AFAM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Thu, Aug 1, 2024 at 8:27=E2=80=AFAM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > Given the recent discussion of the SELinux namespaces patches, =
I
> > > > > > re-based the working-selinuxns branch of my selinux-kernel fork=
 on top
> > > > > > of the dev branch. This required first reverting commit e67b798=
50fcc
> > > > > > ("selinux: stop passing selinux_state pointers and their offspr=
ing")
> > > > > > which I had created at Linus' request some time ago to avoid th=
e
> > > > > > extraneous overhead associated with passing those pointers when=
 there
> > > > > > could only be one selinux_state structure. Due to the number of
> > > > > > changes, both substantive and coding style related, since the l=
ast
> > > > > > re-base in 2020, there were numerous conflicts that required ma=
nual
> > > > > > resolution. I also checked the coding style of each patch with =
Paul's
> > > > > > scripts and fixed any issues introduced by the patches along th=
e way.
> > > > > >
> > > > > > The rebase can be found at:
> > > > > > https://github.com/stephensmalley/selinux-kernel/tree/working-s=
elinuxns
> > > > > >
> > > > > > It boots, passes the selinux-testsuite (including the NFS tests=
), and
> > > > > > passes the following
> > > > > > trivial exercising of the unshare mechanism:
> > > > > > $ sudo bash
> > > > > > # echo 1 > /sys/fs/selinux/unshare
> > > > > > # unshare -m -n
> > > > > > # umount /sys/fs/selinux
> > > > > > # mount -t selinuxfs none /sys/fs/selinux
> > > > > > # id
> > > > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dkernel
> > > > > > # getenforce
> > > > > > Permissive
> > > > > > # load_policy
> > > > > > # id
> > > > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dsystem_u=
:system_r:kernel_t:s0
> > > > > >
> > > > > > All the same caveats apply - this is still not safe to use and =
has
> > > > > > many unresolved issues as noted in the patch descriptions.
> > > > >
> > > > > Also, note that as before, this branch does NOT include the origi=
nal
> > > > > patches to support per-namespace superblock and inode security
> > > > > structures. Given the known problems with those patches and recen=
t
> > > > > discussions, we likely don't want them anyway, but for reference =
they
> > > > > can still be found here:
> > > > > https://github.com/stephensmalley/selinux-kernel/commit/3378718ef=
7d4a837f32c63bdfcc0b70342cdd55d
> > > > > https://github.com/stephensmalley/selinux-kernel/commit/efb2ddadf=
dd0e10e75b6aa5da2ed9841df6ef2f6
> > > > >
> > > > > Without those patches, ls -Z will show as unlabeled any files who=
se
> > > > > inodes were already in-core at the time of the creation of the ne=
w
> > > > > SELinux namespace because their inode security structures will ha=
ve
> > > > > SIDs that do not exist in the new namespace's SID table.
> > > > >
> > > > > An alternative approach proposed by Huawei to my original patches=
 can
> > > > > be found here:
> > > > > https://lore.kernel.org/selinux/20220216125206.20975-1-igor.baran=
ov@huawei.com/#r
> > > > >
> > > > > However, those patches also seem to have quite a few unresolved i=
ssues.
> > > >
> > > > Actually, re-reading that thread inspired me to take one of the ide=
as
> > > > suggested by Huawei, so I just pushed up one change on top of my
> > > > working-selinuxns branch to support saving the SELinux namespace in
> > > > the inode security blob and re-initializing it when an inode is
> > > > accessed by a process in a different SELinux namespace. This at lea=
st
> > > > allows ls -Z to correctly show the security contexts of files even
> > > > when they are already in-core.
> > > > There still remain many issues though to resolve...
> > >
> > > As just one example, if you setenforce 1 in the new SELinux namespace=
,
> > > you'll instantly lose access to your open files since the file
> > > security blobs (not the inode security blobs) still have SIDs that
> > > were created in the parent namespace and aren't defined in yours. And
> > > naively changing those to match your namespace will break access by
> > > the parent process. Probably need to create a helper program akin to
> > > newrole that handles closing and re-opening the fds in the new
> > > namespace.
> > >
> > > Then you still have the problem of the inode security blobs not being
> > > refreshed on certain code paths because you can't sleep on those code
> > > paths and fetching the xattr may sleep. Might require saving a copy o=
f
> > > the security context string in the inode security blob so that you
> > > don't have to perform any blocking operations to refresh the SID to
> > > match the current namespace, but that will come at an obvious cost in
> > > memory.
> >
> > The last paragraph above actually rears its head even without fixing
> > the fd problem;
> > unfortunately that last patch I pushed on top of working-selinuxns
> > will render you unable to ssh into the system if/when you end up
> > creating a new SELinux namespace and accessing files needed by sshd.
> > It seems that the patch is updating the inode SID and namespace to the
> > new namespace and then sshd is trying to access those files through a
> > code path that cannot call  inode_security_revalidate() with
> > may_sleep=3D=3Dtrue and hence ends up using the wrong SID and being den=
ied
> > access.
>
> I just pushed up another change on top of my working-selinuxns branch
> that fixes this issue albeit inefficiently memory-wise.
> For the moment, it saves the security context in the inode security
> blob when inode_doinit_with_dentry() first obtains it via getxattr(),
> and later re-uses that context in the !may_sleep case. Ultimately we
> will want to re-do this using an approach similar to Smack so that we
> don't keep multiple copies of the same security context in memory.
> This change combined with adding further calls to
> __inode_security_revalidate() to the file*has_perm() prior to
> accessing the inode security blob (now that we can safely do so)
> eliminates the problem I was seeing with sshd, although I am sure
> there remain other cases.
> Next issue to address is the open fds when you unshare the namespace.

Ok, I pushed up two more changes - one to fix a memory leak in the
previous change (thanks kmemleak!) and one to update the security
blobs of the open files of the current process when it unshares its
SELinux namespace. This gets us a bit farther; now when I setenforce 1
in the new SELinux namespace, it retains access to its
stdin/stdout/stderr but it segfaults because it loses access to its
memory mappings. I see the Huawei patch set had something to try to
migrate the VMAs of the current process; that looks ugly and doesn't
have a convenient helper in the mm subsystem unlike the open files
situation (iterate_fd helper that was already being used by
flush_unauthorized_files). So that's the next challenge. Might be
better though to just defer the unsharing of the SELinux namespace to
the next execve, similar to setexeccon(), so that we don't have to
deal with it.
