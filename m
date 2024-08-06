Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C18B286A6
	for <selinux@vger.kernel.org>; Tue,  6 Aug 2024 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959445; cv=none; b=a91Kh6WV3L4WHxHojf7QUMks5oRLRwP+uY6YcQLfjJ6SUr2EbhbnS9LDUbOU6qQJwWm5HUFaImKfZ/GTchEZELC8VSe9iBsuPOQaqwk7txu0X8BftN/O45Thnlq/2NVxSRF/w0F7Eb75lOkV3Uj13xLoHmT+kdldrPMtVOv9li4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959445; c=relaxed/simple;
	bh=dom0+/nDDD4Rh32ETZMt/j2wlQR3MAzBJT+HZvjNRP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=B0a1IiCRzRQDpOKjm0uGrGxNjxORh7GD8Sz4bP6SIQ5MCjVNLsMC3OGuojG8BXi6iREZUhc7mw6aYVDhks+M04izXWe3wO2B24lW6kaQyWZiCk8q6WJjz+QQfDXXdeiyVx+VyEYEscEw4w/9UQMe05Rroj6J/ujogGNXGWBjMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=livKs/BP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="livKs/BP"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7bb75419123so565561a12.3
        for <selinux@vger.kernel.org>; Tue, 06 Aug 2024 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722959443; x=1723564243; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJMj8HKYfvVvtKkyYQKPqOvLAXJV9g7PsFauy3xS18Q=;
        b=livKs/BPiq99xfYYp6sk7ZSjVGwPK234rsOD2eXBlf/a4GHVKa9AJpurKWWDm6rCRT
         EueRoLp2+Yvma6bLvsOHtn5HDJSOGFFVj0w9hrqnrIu8oReB+jo5IVYF0ES6Jwj0/73K
         AJu1KZ37SpbiaFOpO1kOAYqpHxGMa73fjwUinQRI2DRPGqJX8uvpQjDTeaIEUgoxbPbF
         Fj1475nQySjIHHgQANGGX89QNlmsq7B33AM70TmRCi9bAWhsrpxV3JoqU6uunLRDV6Zv
         qhpft2pCfvV/0gPH8eOVwZtH5N90CWWOxDKhPSVsvylUfZdwVMKXkPoPTHA4tziKTk56
         aLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722959443; x=1723564243;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJMj8HKYfvVvtKkyYQKPqOvLAXJV9g7PsFauy3xS18Q=;
        b=EQLQbI1WJVOU0zgDfD4huixUEEM0jKplEeJfSJya3XykFtlMk59zFK+k22rNjkwcXD
         jVOMNHQRM3+F/bpyyA3pxZ6oJ15JCr+5ryjlYCRWFh/jebe4xLisskHDzw0k3MTne0TV
         xBQ82x/w02lj/f3Pwigx+n4zHhhCy2yCW7CCRpo7M7yKqnAsIhb9neRYI4Z0enJy1j3Y
         PupaOTpkNRixM++fRge5kiy7IRVKrm3hEmI4948kg8pNzDfbCTpLQCEsHz3E5mUUT3B/
         95BCjlkscglKK+TTmp2i8YSurQ1aX5tp71z5kSUuWM6X5+Crkcls3JA1cSJ3Vt/H95pa
         zegQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLf90FBOsl4q3Kq3kc9Qpb+dJjRZJfuS4Y9ELnxGRwHrW+A2+HVgQi6npDH3ZskkUbmBaT4DJDugwKS9p5ZrveMZ7TCzXY+w==
X-Gm-Message-State: AOJu0YwrzGPg1sU58l/qK11H7tJg4TwqAypNOBV7jolPSidyAWBPbcHK
	Kcopes+e19G/ZA3SQCZphUKwmxcupyJXgxXMWw7L2XxIdUCNsAOPg21i2Ko+sbrI1xd99nMocJ4
	NyHA11AqjsRV3SRmXz2TGVJFeoPGZbA==
X-Google-Smtp-Source: AGHT+IEG/9oFHORNew3xpClzW19EfOeeWIKZpTFWJLJSL0bmSfdi2rGzLfXaR4e7uz5aKBls0DNRbcVcjOEnjRYw8FU=
X-Received: by 2002:a17:90b:164d:b0:2c9:6f53:1f44 with SMTP id
 98e67ed59e1d1-2cff93db52amr14769433a91.3.1722959443297; Tue, 06 Aug 2024
 08:50:43 -0700 (PDT)
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
 <CAEjxPJ6QsYR-Kj8k0C=54cix8rdpBsCphDV5_QnjGONDuOm+ew@mail.gmail.com>
 <CAEjxPJ6p3oD99_aTEeSCx6FMob7BH8-2vxdoT69c8sw11oHuEA@mail.gmail.com>
 <CAEjxPJ5jup5o9piVPuA97_radSzvshpnRB1CdBde8sV3ZXVc2Q@mail.gmail.com> <CAEjxPJ7UtCjQw=v1--6ZWXo-bbkndGbwfXhcT8RkX_cddjCqkQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7UtCjQw=v1--6ZWXo-bbkndGbwfXhcT8RkX_cddjCqkQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 6 Aug 2024 11:50:32 -0400
Message-ID: <CAEjxPJ5a1KzSjB31gcqWqJW_zdy8OCmwKKGYwCivvFG4Jvncyg@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 10:12=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 2, 2024 at 2:34=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Aug 2, 2024 at 1:18=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Aug 1, 2024 at 3:28=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Thu, Aug 1, 2024 at 2:48=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Thu, Aug 1, 2024 at 10:03=E2=80=AFAM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 1, 2024 at 9:01=E2=80=AFAM Stephen Smalley
> > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Aug 1, 2024 at 8:27=E2=80=AFAM Stephen Smalley
> > > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Given the recent discussion of the SELinux namespaces patch=
es, I
> > > > > > > > re-based the working-selinuxns branch of my selinux-kernel =
fork on top
> > > > > > > > of the dev branch. This required first reverting commit e67=
b79850fcc
> > > > > > > > ("selinux: stop passing selinux_state pointers and their of=
fspring")
> > > > > > > > which I had created at Linus' request some time ago to avoi=
d the
> > > > > > > > extraneous overhead associated with passing those pointers =
when there
> > > > > > > > could only be one selinux_state structure. Due to the numbe=
r of
> > > > > > > > changes, both substantive and coding style related, since t=
he last
> > > > > > > > re-base in 2020, there were numerous conflicts that require=
d manual
> > > > > > > > resolution. I also checked the coding style of each patch w=
ith Paul's
> > > > > > > > scripts and fixed any issues introduced by the patches alon=
g the way.
> > > > > > > >
> > > > > > > > The rebase can be found at:
> > > > > > > > https://github.com/stephensmalley/selinux-kernel/tree/worki=
ng-selinuxns
> > > > > > > >
> > > > > > > > It boots, passes the selinux-testsuite (including the NFS t=
ests), and
> > > > > > > > passes the following
> > > > > > > > trivial exercising of the unshare mechanism:
> > > > > > > > $ sudo bash
> > > > > > > > # echo 1 > /sys/fs/selinux/unshare
> > > > > > > > # unshare -m -n
> > > > > > > > # umount /sys/fs/selinux
> > > > > > > > # mount -t selinuxfs none /sys/fs/selinux
> > > > > > > > # id
> > > > > > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dkern=
el
> > > > > > > > # getenforce
> > > > > > > > Permissive
> > > > > > > > # load_policy
> > > > > > > > # id
> > > > > > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dsyst=
em_u:system_r:kernel_t:s0
> > > > > > > >
> > > > > > > > All the same caveats apply - this is still not safe to use =
and has
> > > > > > > > many unresolved issues as noted in the patch descriptions.
> > > > > > >
> > > > > > > Also, note that as before, this branch does NOT include the o=
riginal
> > > > > > > patches to support per-namespace superblock and inode securit=
y
> > > > > > > structures. Given the known problems with those patches and r=
ecent
> > > > > > > discussions, we likely don't want them anyway, but for refere=
nce they
> > > > > > > can still be found here:
> > > > > > > https://github.com/stephensmalley/selinux-kernel/commit/33787=
18ef7d4a837f32c63bdfcc0b70342cdd55d
> > > > > > > https://github.com/stephensmalley/selinux-kernel/commit/efb2d=
dadfdd0e10e75b6aa5da2ed9841df6ef2f6
> > > > > > >
> > > > > > > Without those patches, ls -Z will show as unlabeled any files=
 whose
> > > > > > > inodes were already in-core at the time of the creation of th=
e new
> > > > > > > SELinux namespace because their inode security structures wil=
l have
> > > > > > > SIDs that do not exist in the new namespace's SID table.
> > > > > > >
> > > > > > > An alternative approach proposed by Huawei to my original pat=
ches can
> > > > > > > be found here:
> > > > > > > https://lore.kernel.org/selinux/20220216125206.20975-1-igor.b=
aranov@huawei.com/#r
> > > > > > >
> > > > > > > However, those patches also seem to have quite a few unresolv=
ed issues.
> > > > > >
> > > > > > Actually, re-reading that thread inspired me to take one of the=
 ideas
> > > > > > suggested by Huawei, so I just pushed up one change on top of m=
y
> > > > > > working-selinuxns branch to support saving the SELinux namespac=
e in
> > > > > > the inode security blob and re-initializing it when an inode is
> > > > > > accessed by a process in a different SELinux namespace. This at=
 least
> > > > > > allows ls -Z to correctly show the security contexts of files e=
ven
> > > > > > when they are already in-core.
> > > > > > There still remain many issues though to resolve...
> > > > >
> > > > > As just one example, if you setenforce 1 in the new SELinux names=
pace,
> > > > > you'll instantly lose access to your open files since the file
> > > > > security blobs (not the inode security blobs) still have SIDs tha=
t
> > > > > were created in the parent namespace and aren't defined in yours.=
 And
> > > > > naively changing those to match your namespace will break access =
by
> > > > > the parent process. Probably need to create a helper program akin=
 to
> > > > > newrole that handles closing and re-opening the fds in the new
> > > > > namespace.
> > > > >
> > > > > Then you still have the problem of the inode security blobs not b=
eing
> > > > > refreshed on certain code paths because you can't sleep on those =
code
> > > > > paths and fetching the xattr may sleep. Might require saving a co=
py of
> > > > > the security context string in the inode security blob so that yo=
u
> > > > > don't have to perform any blocking operations to refresh the SID =
to
> > > > > match the current namespace, but that will come at an obvious cos=
t in
> > > > > memory.
> > > >
> > > > The last paragraph above actually rears its head even without fixin=
g
> > > > the fd problem;
> > > > unfortunately that last patch I pushed on top of working-selinuxns
> > > > will render you unable to ssh into the system if/when you end up
> > > > creating a new SELinux namespace and accessing files needed by sshd=
.
> > > > It seems that the patch is updating the inode SID and namespace to =
the
> > > > new namespace and then sshd is trying to access those files through=
 a
> > > > code path that cannot call  inode_security_revalidate() with
> > > > may_sleep=3D=3Dtrue and hence ends up using the wrong SID and being=
 denied
> > > > access.
> > >
> > > I just pushed up another change on top of my working-selinuxns branch
> > > that fixes this issue albeit inefficiently memory-wise.
> > > For the moment, it saves the security context in the inode security
> > > blob when inode_doinit_with_dentry() first obtains it via getxattr(),
> > > and later re-uses that context in the !may_sleep case. Ultimately we
> > > will want to re-do this using an approach similar to Smack so that we
> > > don't keep multiple copies of the same security context in memory.
> > > This change combined with adding further calls to
> > > __inode_security_revalidate() to the file*has_perm() prior to
> > > accessing the inode security blob (now that we can safely do so)
> > > eliminates the problem I was seeing with sshd, although I am sure
> > > there remain other cases.
> > > Next issue to address is the open fds when you unshare the namespace.
> >
> > Ok, I pushed up two more changes - one to fix a memory leak in the
> > previous change (thanks kmemleak!) and one to update the security
> > blobs of the open files of the current process when it unshares its
> > SELinux namespace. This gets us a bit farther; now when I setenforce 1
> > in the new SELinux namespace, it retains access to its
> > stdin/stdout/stderr but it segfaults because it loses access to its
> > memory mappings. I see the Huawei patch set had something to try to
> > migrate the VMAs of the current process; that looks ugly and doesn't
> > have a convenient helper in the mm subsystem unlike the open files
> > situation (iterate_fd helper that was already being used by
> > flush_unauthorized_files). So that's the next challenge. Might be
> > better though to just defer the unsharing of the SELinux namespace to
> > the next execve, similar to setexeccon(), so that we don't have to
> > deal with it.
>
> FYI, discovered and fixed several reference counting bugs and memory
> leaks, squashed the fixes back into the original patches that
> introduced the bugs, and force-pushed the updated working-selinuxns
> branch.

Made further changes to defer the unsharing of the SELinux namespace
until exec (to resolve the memory mapping issue and simplify the file
inheritance issue) and to re-initialize the inode security blob in the
correct namespace. Branch updated.
