Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4413B29F
	for <selinux@vger.kernel.org>; Mon,  5 Aug 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867187; cv=none; b=H85Ms6NRITqt0FySLACnWn6zrcFG6V5SMEB/qYEcgwysa83UWrcfvXCakeH3GXeG5zIIt6345CfSLqisWLCTxzCQ1s6evD08yrWsRMgRD7y9lDp7+DoiXqR8Qsj1DDNpDa9BbWMYtNPPOKk+poX7ky4DRLaX4K6rvksCfBQzMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867187; c=relaxed/simple;
	bh=bIjFZzEq3Q2whmSBoejkzoRzPigfF3cG4R0nsVay+dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LTsIzRoIlqO5MRTis2sGzDY8od6NyZxRPIHCIxIKvrCff5L/Cf3azoVDohPzyA73AiVkr9qSENGon5RRrv0Hmcm8ZnOj5QCH3LoLR3MTBi7gxoypgez0TuB0nyp3CfMUBEYWlKp5QSrJRCVUkkcQ6BUJfCniIMqy0ZfvUjFdY1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1BUMysg; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1BUMysg"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-71871d5e087so8024617a12.1
        for <selinux@vger.kernel.org>; Mon, 05 Aug 2024 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722867185; x=1723471985; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbYLctpNtjtcJSeKhUcRXcWJ6w/wpHMYLO/Zegvassg=;
        b=m1BUMysgeWraaZ1aEuvFxwC7MPu4OQbtutDYavb/BWKyucKNocWlRWOvpFvar1wsGp
         AUTly68f1EVo9/4BT/HYC5Kt0aO0RScissEFL9xIAOjkYqpZwiw4MdpQz3O3FK4z93Dg
         SF05NhJPHhECMtmITGsUE9BQvIh/8K5bo+rCeC85TVko+seW3rDWlJS6eW7X7f5stz/w
         fm3st23JQkd0IQTEHoRLrfztMpwVoUhiuVwS0oYX4br4Mjio4P1Wf4gGryYopbbzYT6a
         lVYAKgvA0faDrEfV21nev6UEypAaEbV85xxUl3TPc0mtFTHo2K61d1EL7oLFQT8mJ/1/
         NKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722867185; x=1723471985;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbYLctpNtjtcJSeKhUcRXcWJ6w/wpHMYLO/Zegvassg=;
        b=KzjTnmbcPXq7bFy6yRZ6/NaRWDTOKnL+FAoluVMzEUBm9B0sr6suwqXu+zUo6IUUCr
         3cbo6JKlxTSJoxMqjy0hCAvDew5rKMuLo4XSyB88eociIcjB4JyczKQiYBwVcyggGgxN
         LA0BuZmQbO93emVemmwUY+DMrefFv0A7LT4tRLPjkR1GQCNFlu2Uk7btPnTiV9wy8JIR
         zj3Sd2XbYXlWr0yj9DOkyu4tL0qJl/smInPcBQvg3Z/qjORKULqYzed4aF7vBLOwtejI
         RwPQRWCmCqEs0OYeJFxx3dN+qbzi81lCPeDRM5jEu2ZRaNOduX8K70GflaR7Aalv081m
         BpAA==
X-Forwarded-Encrypted: i=1; AJvYcCVouH0BOvjwXRIEMGrY9rX3gE6DbHQDJl8kUgXAHhaLrYlo25jgNRhMcZjUXS/MuJx6ah9qxi3a9YsyyAsPEPh28VxnkuvhtA==
X-Gm-Message-State: AOJu0Yxes1FFp4pq0gS7oQV4SMM+0c+r4cfeWPqpv2B4hrvfzk2z0SY0
	s/HsfdKBwJ1apsUUVwlF/N0ZVC/duHaNtUQqdjonJegWXWRnnF2hhtNjWkCrQGTizpba9/4vJKg
	niPGs7y79gJUL58ZTlFm4b8KvokCGVQ==
X-Google-Smtp-Source: AGHT+IEeEx37Ht9vJ72neOCW1amomabo+PQ10GId2SH1ypSsHOCODKfaUfvu1x313weWnwquHWgF9cwF6LMWCdM0N0c=
X-Received: by 2002:a17:90a:f486:b0:2bd:d42a:e071 with SMTP id
 98e67ed59e1d1-2cff952441dmr13640700a91.30.1722867185322; Mon, 05 Aug 2024
 07:13:05 -0700 (PDT)
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
 <CAEjxPJ6p3oD99_aTEeSCx6FMob7BH8-2vxdoT69c8sw11oHuEA@mail.gmail.com> <CAEjxPJ5jup5o9piVPuA97_radSzvshpnRB1CdBde8sV3ZXVc2Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ5jup5o9piVPuA97_radSzvshpnRB1CdBde8sV3ZXVc2Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 5 Aug 2024 10:12:53 -0400
Message-ID: <CAEjxPJ7UtCjQw=v1--6ZWXo-bbkndGbwfXhcT8RkX_cddjCqkQ@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 2:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 2, 2024 at 1:18=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Aug 1, 2024 at 3:28=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Aug 1, 2024 at 2:48=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Thu, Aug 1, 2024 at 10:03=E2=80=AFAM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Thu, Aug 1, 2024 at 9:01=E2=80=AFAM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 1, 2024 at 8:27=E2=80=AFAM Stephen Smalley
> > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > >
> > > > > > > Given the recent discussion of the SELinux namespaces patches=
, I
> > > > > > > re-based the working-selinuxns branch of my selinux-kernel fo=
rk on top
> > > > > > > of the dev branch. This required first reverting commit e67b7=
9850fcc
> > > > > > > ("selinux: stop passing selinux_state pointers and their offs=
pring")
> > > > > > > which I had created at Linus' request some time ago to avoid =
the
> > > > > > > extraneous overhead associated with passing those pointers wh=
en there
> > > > > > > could only be one selinux_state structure. Due to the number =
of
> > > > > > > changes, both substantive and coding style related, since the=
 last
> > > > > > > re-base in 2020, there were numerous conflicts that required =
manual
> > > > > > > resolution. I also checked the coding style of each patch wit=
h Paul's
> > > > > > > scripts and fixed any issues introduced by the patches along =
the way.
> > > > > > >
> > > > > > > The rebase can be found at:
> > > > > > > https://github.com/stephensmalley/selinux-kernel/tree/working=
-selinuxns
> > > > > > >
> > > > > > > It boots, passes the selinux-testsuite (including the NFS tes=
ts), and
> > > > > > > passes the following
> > > > > > > trivial exercising of the unshare mechanism:
> > > > > > > $ sudo bash
> > > > > > > # echo 1 > /sys/fs/selinux/unshare
> > > > > > > # unshare -m -n
> > > > > > > # umount /sys/fs/selinux
> > > > > > > # mount -t selinuxfs none /sys/fs/selinux
> > > > > > > # id
> > > > > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dkernel
> > > > > > > # getenforce
> > > > > > > Permissive
> > > > > > > # load_policy
> > > > > > > # id
> > > > > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dsystem=
_u:system_r:kernel_t:s0
> > > > > > >
> > > > > > > All the same caveats apply - this is still not safe to use an=
d has
> > > > > > > many unresolved issues as noted in the patch descriptions.
> > > > > >
> > > > > > Also, note that as before, this branch does NOT include the ori=
ginal
> > > > > > patches to support per-namespace superblock and inode security
> > > > > > structures. Given the known problems with those patches and rec=
ent
> > > > > > discussions, we likely don't want them anyway, but for referenc=
e they
> > > > > > can still be found here:
> > > > > > https://github.com/stephensmalley/selinux-kernel/commit/3378718=
ef7d4a837f32c63bdfcc0b70342cdd55d
> > > > > > https://github.com/stephensmalley/selinux-kernel/commit/efb2dda=
dfdd0e10e75b6aa5da2ed9841df6ef2f6
> > > > > >
> > > > > > Without those patches, ls -Z will show as unlabeled any files w=
hose
> > > > > > inodes were already in-core at the time of the creation of the =
new
> > > > > > SELinux namespace because their inode security structures will =
have
> > > > > > SIDs that do not exist in the new namespace's SID table.
> > > > > >
> > > > > > An alternative approach proposed by Huawei to my original patch=
es can
> > > > > > be found here:
> > > > > > https://lore.kernel.org/selinux/20220216125206.20975-1-igor.bar=
anov@huawei.com/#r
> > > > > >
> > > > > > However, those patches also seem to have quite a few unresolved=
 issues.
> > > > >
> > > > > Actually, re-reading that thread inspired me to take one of the i=
deas
> > > > > suggested by Huawei, so I just pushed up one change on top of my
> > > > > working-selinuxns branch to support saving the SELinux namespace =
in
> > > > > the inode security blob and re-initializing it when an inode is
> > > > > accessed by a process in a different SELinux namespace. This at l=
east
> > > > > allows ls -Z to correctly show the security contexts of files eve=
n
> > > > > when they are already in-core.
> > > > > There still remain many issues though to resolve...
> > > >
> > > > As just one example, if you setenforce 1 in the new SELinux namespa=
ce,
> > > > you'll instantly lose access to your open files since the file
> > > > security blobs (not the inode security blobs) still have SIDs that
> > > > were created in the parent namespace and aren't defined in yours. A=
nd
> > > > naively changing those to match your namespace will break access by
> > > > the parent process. Probably need to create a helper program akin t=
o
> > > > newrole that handles closing and re-opening the fds in the new
> > > > namespace.
> > > >
> > > > Then you still have the problem of the inode security blobs not bei=
ng
> > > > refreshed on certain code paths because you can't sleep on those co=
de
> > > > paths and fetching the xattr may sleep. Might require saving a copy=
 of
> > > > the security context string in the inode security blob so that you
> > > > don't have to perform any blocking operations to refresh the SID to
> > > > match the current namespace, but that will come at an obvious cost =
in
> > > > memory.
> > >
> > > The last paragraph above actually rears its head even without fixing
> > > the fd problem;
> > > unfortunately that last patch I pushed on top of working-selinuxns
> > > will render you unable to ssh into the system if/when you end up
> > > creating a new SELinux namespace and accessing files needed by sshd.
> > > It seems that the patch is updating the inode SID and namespace to th=
e
> > > new namespace and then sshd is trying to access those files through a
> > > code path that cannot call  inode_security_revalidate() with
> > > may_sleep=3D=3Dtrue and hence ends up using the wrong SID and being d=
enied
> > > access.
> >
> > I just pushed up another change on top of my working-selinuxns branch
> > that fixes this issue albeit inefficiently memory-wise.
> > For the moment, it saves the security context in the inode security
> > blob when inode_doinit_with_dentry() first obtains it via getxattr(),
> > and later re-uses that context in the !may_sleep case. Ultimately we
> > will want to re-do this using an approach similar to Smack so that we
> > don't keep multiple copies of the same security context in memory.
> > This change combined with adding further calls to
> > __inode_security_revalidate() to the file*has_perm() prior to
> > accessing the inode security blob (now that we can safely do so)
> > eliminates the problem I was seeing with sshd, although I am sure
> > there remain other cases.
> > Next issue to address is the open fds when you unshare the namespace.
>
> Ok, I pushed up two more changes - one to fix a memory leak in the
> previous change (thanks kmemleak!) and one to update the security
> blobs of the open files of the current process when it unshares its
> SELinux namespace. This gets us a bit farther; now when I setenforce 1
> in the new SELinux namespace, it retains access to its
> stdin/stdout/stderr but it segfaults because it loses access to its
> memory mappings. I see the Huawei patch set had something to try to
> migrate the VMAs of the current process; that looks ugly and doesn't
> have a convenient helper in the mm subsystem unlike the open files
> situation (iterate_fd helper that was already being used by
> flush_unauthorized_files). So that's the next challenge. Might be
> better though to just defer the unsharing of the SELinux namespace to
> the next execve, similar to setexeccon(), so that we don't have to
> deal with it.

FYI, discovered and fixed several reference counting bugs and memory
leaks, squashed the fixes back into the original patches that
introduced the bugs, and force-pushed the updated working-selinuxns
branch.
