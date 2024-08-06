Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAEE2BAEF
	for <selinux@vger.kernel.org>; Tue,  6 Aug 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963377; cv=none; b=gR/4rUk3SGCDAZV99/RhIbIjMXNmMfuOPSWn4njMw8S+uG/+ODJfTmkjz0BzsSXvyqqkV2ToYxiYZF9KK248RS1Kx2Si2oTPbNw5UqwiF8x00OnQCZOe1qekRnv/rhRVjDP+fQW3ICKsN6EcQlmVkKRcSwV5tB61OuHeB2LUNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963377; c=relaxed/simple;
	bh=YHKm0krp7IuWUokLKnFzNKa/prFHZnoH54RPfvNOshw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YWR8N8lR0eEgVe2zKlzr8lI2e48fhH5/iwgwR2qHQ4MiV+UlgI5n4mhuVidWNcKYkBBHciP/aYpBJ3FZJas2/BRuDL17YA6IvoeNspSSXtm7gTXJZ92O7r0X9jx7cCzZO9E/6PCz37FYV2RNBbRKNq3SdFDRsjBVhyuyNEJ5sYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH315XFP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH315XFP"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso544407a12.2
        for <selinux@vger.kernel.org>; Tue, 06 Aug 2024 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722963375; x=1723568175; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBstJHGAaekVjMWq4L3YQl96O9NG20o/txPYI7Y7Aq4=;
        b=MH315XFP7CYYPnOrq5a23QXEWtUKCF+fuGOPuOLXRUk/f8dH4GBKhb+vHLiuwfUKY6
         YxjUzsuQN8CACkAXouGxVu95GNmiteyYBSVxPXFUGUq/zjl0559z3//IYcw5iEMlZ8+L
         phjaouIfV9+HkNJXk1W1zWTwXh/3jtPlQDE3org9DV/mCP90CA8PmInvj3aJum1fc/EV
         5p4uwZ29tFyQv7oiLXP4TwVqLceLjG7SJ2rU57y3/FtLVA4JqcUoxqmeqen9uMNdFLhl
         G5pW57e7+5N737O04Mw8eIVSGumBcZDqUsqI1q2c4rjBz7oSqcXf4Nz4Oh563Pnw8dHC
         0wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722963375; x=1723568175;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBstJHGAaekVjMWq4L3YQl96O9NG20o/txPYI7Y7Aq4=;
        b=phH5FHE6idpvZaZ0sXd97alutUBwJW0plwevfztEvEulnktziqjgXbFuaR2v7WKBRY
         +TChr6y73KpZEQcqdDzKZ4SNBMe8FFaAU70sWaE+9EXnpWcOXLuvuKlC8U3r55GVlSze
         7HAB+6o7OkOKEqc2XOeB3Htqqb6sc+p1x+QlWdWezpeWkRkeRFtjzef2RWzOEXsrO0gy
         aboz4ebQaALAIPSi3Kmsw3Uik+c6fYddUMffVdeRMiIPDbsrZiwEU2ygv8kCj4NGDurw
         0t6gi4sAPWUJax4Ay4TPW53+y2YMbn7X6qSueaL1lFPjVBUhSQoQowC8WyJm5o0ID/bZ
         eBEA==
X-Forwarded-Encrypted: i=1; AJvYcCU2l/67c66Z8deGyaYTkxEtBQq8AxM9BIiUtdaIH+EG0dzUSgaZZ28+NnCHhlnCRAKCGwoC/6N+kZgt/YJxzEfLND0tIBbX9g==
X-Gm-Message-State: AOJu0YxOIc5vBvv0kD9/JrgTt8U1wfaNavUD+UY/sv8GYtd/Sf2XP8zr
	hwIPfCeFZucg5iGAhUVG3dtS5f2Gk5L1aMwnPWi57n5A5CR3FTkV6eH3O/rT2Fz4w5D/JrmWnhH
	Z04cHSkgnTPO/9PlTeos1L4bKAIbcEvYT
X-Google-Smtp-Source: AGHT+IEZwit5N7UNiBtcrGqZJa3N6GtP/7TtTZ5ku0iWJ80RHDCUtoTIdnTlTssHp2iCQf6BR3K3uGjsNvebnN9AFj4=
X-Received: by 2002:a17:90b:2790:b0:2c9:6f06:8009 with SMTP id
 98e67ed59e1d1-2cff93d59e1mr15914575a91.1.1722963375261; Tue, 06 Aug 2024
 09:56:15 -0700 (PDT)
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
 <CAEjxPJ5jup5o9piVPuA97_radSzvshpnRB1CdBde8sV3ZXVc2Q@mail.gmail.com>
 <CAEjxPJ7UtCjQw=v1--6ZWXo-bbkndGbwfXhcT8RkX_cddjCqkQ@mail.gmail.com> <CAEjxPJ5a1KzSjB31gcqWqJW_zdy8OCmwKKGYwCivvFG4Jvncyg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5a1KzSjB31gcqWqJW_zdy8OCmwKKGYwCivvFG4Jvncyg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 6 Aug 2024 12:56:03 -0400
Message-ID: <CAEjxPJ6WupdxzSkh54NLJkZoH=Umayj8+HrX5TmbAXvVYzgPfw@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 11:50=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 5, 2024 at 10:12=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Aug 2, 2024 at 2:34=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Fri, Aug 2, 2024 at 1:18=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Thu, Aug 1, 2024 at 3:28=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Thu, Aug 1, 2024 at 2:48=E2=80=AFPM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 1, 2024 at 10:03=E2=80=AFAM Stephen Smalley
> > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Aug 1, 2024 at 9:01=E2=80=AFAM Stephen Smalley
> > > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Aug 1, 2024 at 8:27=E2=80=AFAM Stephen Smalley
> > > > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Given the recent discussion of the SELinux namespaces pat=
ches, I
> > > > > > > > > re-based the working-selinuxns branch of my selinux-kerne=
l fork on top
> > > > > > > > > of the dev branch. This required first reverting commit e=
67b79850fcc
> > > > > > > > > ("selinux: stop passing selinux_state pointers and their =
offspring")
> > > > > > > > > which I had created at Linus' request some time ago to av=
oid the
> > > > > > > > > extraneous overhead associated with passing those pointer=
s when there
> > > > > > > > > could only be one selinux_state structure. Due to the num=
ber of
> > > > > > > > > changes, both substantive and coding style related, since=
 the last
> > > > > > > > > re-base in 2020, there were numerous conflicts that requi=
red manual
> > > > > > > > > resolution. I also checked the coding style of each patch=
 with Paul's
> > > > > > > > > scripts and fixed any issues introduced by the patches al=
ong the way.
> > > > > > > > >
> > > > > > > > > The rebase can be found at:
> > > > > > > > > https://github.com/stephensmalley/selinux-kernel/tree/wor=
king-selinuxns
> > > > > > > > >
> > > > > > > > > It boots, passes the selinux-testsuite (including the NFS=
 tests), and
> > > > > > > > > passes the following
> > > > > > > > > trivial exercising of the unshare mechanism:
> > > > > > > > > $ sudo bash
> > > > > > > > > # echo 1 > /sys/fs/selinux/unshare
> > > > > > > > > # unshare -m -n
> > > > > > > > > # umount /sys/fs/selinux
> > > > > > > > > # mount -t selinuxfs none /sys/fs/selinux
> > > > > > > > > # id
> > > > > > > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dke=
rnel
> > > > > > > > > # getenforce
> > > > > > > > > Permissive
> > > > > > > > > # load_policy
> > > > > > > > > # id
> > > > > > > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dsy=
stem_u:system_r:kernel_t:s0
> > > > > > > > >
> > > > > > > > > All the same caveats apply - this is still not safe to us=
e and has
> > > > > > > > > many unresolved issues as noted in the patch descriptions=
.
> > > > > > > >
> > > > > > > > Also, note that as before, this branch does NOT include the=
 original
> > > > > > > > patches to support per-namespace superblock and inode secur=
ity
> > > > > > > > structures. Given the known problems with those patches and=
 recent
> > > > > > > > discussions, we likely don't want them anyway, but for refe=
rence they
> > > > > > > > can still be found here:
> > > > > > > > https://github.com/stephensmalley/selinux-kernel/commit/337=
8718ef7d4a837f32c63bdfcc0b70342cdd55d
> > > > > > > > https://github.com/stephensmalley/selinux-kernel/commit/efb=
2ddadfdd0e10e75b6aa5da2ed9841df6ef2f6
> > > > > > > >
> > > > > > > > Without those patches, ls -Z will show as unlabeled any fil=
es whose
> > > > > > > > inodes were already in-core at the time of the creation of =
the new
> > > > > > > > SELinux namespace because their inode security structures w=
ill have
> > > > > > > > SIDs that do not exist in the new namespace's SID table.
> > > > > > > >
> > > > > > > > An alternative approach proposed by Huawei to my original p=
atches can
> > > > > > > > be found here:
> > > > > > > > https://lore.kernel.org/selinux/20220216125206.20975-1-igor=
.baranov@huawei.com/#r
> > > > > > > >
> > > > > > > > However, those patches also seem to have quite a few unreso=
lved issues.
> > > > > > >
> > > > > > > Actually, re-reading that thread inspired me to take one of t=
he ideas
> > > > > > > suggested by Huawei, so I just pushed up one change on top of=
 my
> > > > > > > working-selinuxns branch to support saving the SELinux namesp=
ace in
> > > > > > > the inode security blob and re-initializing it when an inode =
is
> > > > > > > accessed by a process in a different SELinux namespace. This =
at least
> > > > > > > allows ls -Z to correctly show the security contexts of files=
 even
> > > > > > > when they are already in-core.
> > > > > > > There still remain many issues though to resolve...
> > > > > >
> > > > > > As just one example, if you setenforce 1 in the new SELinux nam=
espace,
> > > > > > you'll instantly lose access to your open files since the file
> > > > > > security blobs (not the inode security blobs) still have SIDs t=
hat
> > > > > > were created in the parent namespace and aren't defined in your=
s. And
> > > > > > naively changing those to match your namespace will break acces=
s by
> > > > > > the parent process. Probably need to create a helper program ak=
in to
> > > > > > newrole that handles closing and re-opening the fds in the new
> > > > > > namespace.
> > > > > >
> > > > > > Then you still have the problem of the inode security blobs not=
 being
> > > > > > refreshed on certain code paths because you can't sleep on thos=
e code
> > > > > > paths and fetching the xattr may sleep. Might require saving a =
copy of
> > > > > > the security context string in the inode security blob so that =
you
> > > > > > don't have to perform any blocking operations to refresh the SI=
D to
> > > > > > match the current namespace, but that will come at an obvious c=
ost in
> > > > > > memory.
> > > > >
> > > > > The last paragraph above actually rears its head even without fix=
ing
> > > > > the fd problem;
> > > > > unfortunately that last patch I pushed on top of working-selinuxn=
s
> > > > > will render you unable to ssh into the system if/when you end up
> > > > > creating a new SELinux namespace and accessing files needed by ss=
hd.
> > > > > It seems that the patch is updating the inode SID and namespace t=
o the
> > > > > new namespace and then sshd is trying to access those files throu=
gh a
> > > > > code path that cannot call  inode_security_revalidate() with
> > > > > may_sleep=3D=3Dtrue and hence ends up using the wrong SID and bei=
ng denied
> > > > > access.
> > > >
> > > > I just pushed up another change on top of my working-selinuxns bran=
ch
> > > > that fixes this issue albeit inefficiently memory-wise.
> > > > For the moment, it saves the security context in the inode security
> > > > blob when inode_doinit_with_dentry() first obtains it via getxattr(=
),
> > > > and later re-uses that context in the !may_sleep case. Ultimately w=
e
> > > > will want to re-do this using an approach similar to Smack so that =
we
> > > > don't keep multiple copies of the same security context in memory.
> > > > This change combined with adding further calls to
> > > > __inode_security_revalidate() to the file*has_perm() prior to
> > > > accessing the inode security blob (now that we can safely do so)
> > > > eliminates the problem I was seeing with sshd, although I am sure
> > > > there remain other cases.
> > > > Next issue to address is the open fds when you unshare the namespac=
e.
> > >
> > > Ok, I pushed up two more changes - one to fix a memory leak in the
> > > previous change (thanks kmemleak!) and one to update the security
> > > blobs of the open files of the current process when it unshares its
> > > SELinux namespace. This gets us a bit farther; now when I setenforce =
1
> > > in the new SELinux namespace, it retains access to its
> > > stdin/stdout/stderr but it segfaults because it loses access to its
> > > memory mappings. I see the Huawei patch set had something to try to
> > > migrate the VMAs of the current process; that looks ugly and doesn't
> > > have a convenient helper in the mm subsystem unlike the open files
> > > situation (iterate_fd helper that was already being used by
> > > flush_unauthorized_files). So that's the next challenge. Might be
> > > better though to just defer the unsharing of the SELinux namespace to
> > > the next execve, similar to setexeccon(), so that we don't have to
> > > deal with it.
> >
> > FYI, discovered and fixed several reference counting bugs and memory
> > leaks, squashed the fixes back into the original patches that
> > introduced the bugs, and force-pushed the updated working-selinuxns
> > branch.
>
> Made further changes to defer the unsharing of the SELinux namespace
> until exec (to resolve the memory mapping issue and simplify the file
> inheritance issue) and to re-initialize the inode security blob in the
> correct namespace. Branch updated.

With these changes applied, the following sequence works to
demonstrate creating a new SELinux namespace:
# Ask to unshare SELinux namespace on next exec
$ echo 1 > /sys/fs/selinux/unshare
# Unshare the mount and network namespaces too.
# This is required in order to create our own selinuxfs mount for the
# new namespace and to isolate our own SELinux netlink socket.
$ unshare -m -n
# Mount our own selinuxfs instance for our new SELinux namespace
$ mount -t selinuxfs none /sys/fs/selinux
# Load a policy into our SELinux namespace
$ load_policy
# Create a shell in the unconfined user/role/domain
$ runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bash
$ setenforce 1
$ id
uid=3D0(root) gid=3D0(root) groups=3D0(root)
context=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

NB This new namespace is NOT currently confined by its parent. And
there remain many unresolved issues.
