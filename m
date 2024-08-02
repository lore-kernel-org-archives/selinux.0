Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F616BE0C
	for <selinux@vger.kernel.org>; Fri,  2 Aug 2024 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619107; cv=none; b=bWty94FE35DND4i4AGeNXxOhWdfjTThdUDxy9Ad2sqPd21bTNUwFe/BOF2mUroo25N3iDmVGhWvazv2K34nFEkrQByhahMoDEi/WooYqq0Wc0jrIPyDDEE+hKtmNVFAXUeIfN9tGO27exWIg+QNh8JlrsMvpMlJ4QaX9xtzxSbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619107; c=relaxed/simple;
	bh=fSpMTgXD/Xd8nPv76udyIJMIiZUWeohvrls9bi81OHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=t+nQ7bIDvlM6Y+UF2+q2G9FCuO8sDTWRXypuzKXwzLfGd38bCRHC8cBvpl53cVRAkO1oqF+J4tjn9UTsfM6aHJNW/2PrEFBPa8c8UNNgiE2DU2wRXFbfaVs1lIobX2OqVzBuJXKKldRyqCygl7IjoR1jaA8LhPQIhDs0X862uOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPBwSEMg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPBwSEMg"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso5521875a12.0
        for <selinux@vger.kernel.org>; Fri, 02 Aug 2024 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722619105; x=1723223905; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVS2TVLNVKFwDiX8Nl0podMOGXJJu0BKhPJERKMk898=;
        b=HPBwSEMgqcf2pFCgprUBgIJb39VdU+WcimjIkQlIzjkOVTchNPMDh8CBC9J0RgUqrd
         ZdGyix8IlyF6vp5QZnc2giVuaO2Un7OQRLQddFKK/DiFqkH4oKZF4XojolMWccJO3DtQ
         WuOSpneR2pQuRiffnRmAi3/xwSdfeRmPKyenbvbgFZvFBIs2QfvUFCG1CLGJyeezPaLf
         6Q0cOOmVPsjcNLIVCuS33RmlTzl9Qp11EkuhwT6lTmT32bzjN1sP613oXIVwYuhUj/G7
         8DT5p0esXaDtcK1Kv5gZiIyggrduW+FVOoc9wtbQgGRu6xuMF74fOc0N4PQ7jwjE09+n
         Tmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722619105; x=1723223905;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVS2TVLNVKFwDiX8Nl0podMOGXJJu0BKhPJERKMk898=;
        b=jI6PnJEXvkaHtqOPU2Wkmpf77dOAu3KLhdjUoOJac/XH80nbG/7DGK2aOvLbWgytUF
         pgmk824039PTP32ZJJ1ciT5EWLS5H8d3p2BE783MvQ5TlPzXpr3pfzyJdAxrCchu3WJh
         /Yv80YnXnhZtgScCV0gpGApPN4k3h90QQnoISt8UwKJqjEb9VsI5T938wxY/B9DWdr+1
         FQTiiGpDSFi/493zw96gp1qhYBjhWloD4rKqLQ2dixphc3HzD6uIQKTi2m3gxPZQvEIU
         gUJ20e4XLBXDdePNBK06MFEk6bCMyyptRgQQ+V+ayvWZ7AUJatVimT/xCbLPkQvIoMNX
         ujXw==
X-Forwarded-Encrypted: i=1; AJvYcCXJiVYhm+mNuKd/UkYVpl7daV1ctt3MqttyOu0QAozD6C1EOUuK87VqYbpzwJAJv5+gSu5VdvrLIaMuU5hQNzQNEJVfC+WGww==
X-Gm-Message-State: AOJu0Yx0eLVglml8ORTwkN6NkUsLR9cnUSErvFV1YK+HA81ScviuJRuC
	1pr90rtL6TMoE1F5MSEOJsMWBqEB6ZhZZ5sL7oosLEdagbmJgXVc4YOim5GKRTvdISxBQDqChqo
	cXiUAj606DWG1O0uSzkM5xY5Xtskvow==
X-Google-Smtp-Source: AGHT+IElY3TEuh8slrhJFsPPHi0odl3gsSJjTrTcMpKlz1+0JoMzn91+fPim45SDvNjjdyQqE/VxXQ/KcyBqybO2CJw=
X-Received: by 2002:a17:90b:16ce:b0:2ca:7e87:15e6 with SMTP id
 98e67ed59e1d1-2cff955ce4amr5149695a91.38.1722619104601; Fri, 02 Aug 2024
 10:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ7WUzN=0Yv4POgPVHPG1wEjNn=-Tb53NiuMpWf+bEuF-w@mail.gmail.com>
 <CAEjxPJ758jx7X5Tauz=xQXsmWcZhx_V7AkU=PtsH6S3S9CUCbw@mail.gmail.com>
 <CAEjxPJ50ADVSOys58eYUktv4sjYYnEDroxA9Wnt6HiY9ySk=gg@mail.gmail.com> <CAEjxPJ6QsYR-Kj8k0C=54cix8rdpBsCphDV5_QnjGONDuOm+ew@mail.gmail.com>
In-Reply-To: <CAEjxPJ6QsYR-Kj8k0C=54cix8rdpBsCphDV5_QnjGONDuOm+ew@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Aug 2024 13:18:13 -0400
Message-ID: <CAEjxPJ6p3oD99_aTEeSCx6FMob7BH8-2vxdoT69c8sw11oHuEA@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 3:28=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 1, 2024 at 2:48=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Aug 1, 2024 at 10:03=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Aug 1, 2024 at 9:01=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Thu, Aug 1, 2024 at 8:27=E2=80=AFAM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > Given the recent discussion of the SELinux namespaces patches, I
> > > > > re-based the working-selinuxns branch of my selinux-kernel fork o=
n top
> > > > > of the dev branch. This required first reverting commit e67b79850=
fcc
> > > > > ("selinux: stop passing selinux_state pointers and their offsprin=
g")
> > > > > which I had created at Linus' request some time ago to avoid the
> > > > > extraneous overhead associated with passing those pointers when t=
here
> > > > > could only be one selinux_state structure. Due to the number of
> > > > > changes, both substantive and coding style related, since the las=
t
> > > > > re-base in 2020, there were numerous conflicts that required manu=
al
> > > > > resolution. I also checked the coding style of each patch with Pa=
ul's
> > > > > scripts and fixed any issues introduced by the patches along the =
way.
> > > > >
> > > > > The rebase can be found at:
> > > > > https://github.com/stephensmalley/selinux-kernel/tree/working-sel=
inuxns
> > > > >
> > > > > It boots, passes the selinux-testsuite (including the NFS tests),=
 and
> > > > > passes the following
> > > > > trivial exercising of the unshare mechanism:
> > > > > $ sudo bash
> > > > > # echo 1 > /sys/fs/selinux/unshare
> > > > > # unshare -m -n
> > > > > # umount /sys/fs/selinux
> > > > > # mount -t selinuxfs none /sys/fs/selinux
> > > > > # id
> > > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dkernel
> > > > > # getenforce
> > > > > Permissive
> > > > > # load_policy
> > > > > # id
> > > > > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dsystem_u:s=
ystem_r:kernel_t:s0
> > > > >
> > > > > All the same caveats apply - this is still not safe to use and ha=
s
> > > > > many unresolved issues as noted in the patch descriptions.
> > > >
> > > > Also, note that as before, this branch does NOT include the origina=
l
> > > > patches to support per-namespace superblock and inode security
> > > > structures. Given the known problems with those patches and recent
> > > > discussions, we likely don't want them anyway, but for reference th=
ey
> > > > can still be found here:
> > > > https://github.com/stephensmalley/selinux-kernel/commit/3378718ef7d=
4a837f32c63bdfcc0b70342cdd55d
> > > > https://github.com/stephensmalley/selinux-kernel/commit/efb2ddadfdd=
0e10e75b6aa5da2ed9841df6ef2f6
> > > >
> > > > Without those patches, ls -Z will show as unlabeled any files whose
> > > > inodes were already in-core at the time of the creation of the new
> > > > SELinux namespace because their inode security structures will have
> > > > SIDs that do not exist in the new namespace's SID table.
> > > >
> > > > An alternative approach proposed by Huawei to my original patches c=
an
> > > > be found here:
> > > > https://lore.kernel.org/selinux/20220216125206.20975-1-igor.baranov=
@huawei.com/#r
> > > >
> > > > However, those patches also seem to have quite a few unresolved iss=
ues.
> > >
> > > Actually, re-reading that thread inspired me to take one of the ideas
> > > suggested by Huawei, so I just pushed up one change on top of my
> > > working-selinuxns branch to support saving the SELinux namespace in
> > > the inode security blob and re-initializing it when an inode is
> > > accessed by a process in a different SELinux namespace. This at least
> > > allows ls -Z to correctly show the security contexts of files even
> > > when they are already in-core.
> > > There still remain many issues though to resolve...
> >
> > As just one example, if you setenforce 1 in the new SELinux namespace,
> > you'll instantly lose access to your open files since the file
> > security blobs (not the inode security blobs) still have SIDs that
> > were created in the parent namespace and aren't defined in yours. And
> > naively changing those to match your namespace will break access by
> > the parent process. Probably need to create a helper program akin to
> > newrole that handles closing and re-opening the fds in the new
> > namespace.
> >
> > Then you still have the problem of the inode security blobs not being
> > refreshed on certain code paths because you can't sleep on those code
> > paths and fetching the xattr may sleep. Might require saving a copy of
> > the security context string in the inode security blob so that you
> > don't have to perform any blocking operations to refresh the SID to
> > match the current namespace, but that will come at an obvious cost in
> > memory.
>
> The last paragraph above actually rears its head even without fixing
> the fd problem;
> unfortunately that last patch I pushed on top of working-selinuxns
> will render you unable to ssh into the system if/when you end up
> creating a new SELinux namespace and accessing files needed by sshd.
> It seems that the patch is updating the inode SID and namespace to the
> new namespace and then sshd is trying to access those files through a
> code path that cannot call  inode_security_revalidate() with
> may_sleep=3D=3Dtrue and hence ends up using the wrong SID and being denie=
d
> access.

I just pushed up another change on top of my working-selinuxns branch
that fixes this issue albeit inefficiently memory-wise.
For the moment, it saves the security context in the inode security
blob when inode_doinit_with_dentry() first obtains it via getxattr(),
and later re-uses that context in the !may_sleep case. Ultimately we
will want to re-do this using an approach similar to Smack so that we
don't keep multiple copies of the same security context in memory.
This change combined with adding further calls to
__inode_security_revalidate() to the file*has_perm() prior to
accessing the inode security blob (now that we can safely do so)
eliminates the problem I was seeing with sshd, although I am sure
there remain other cases.
Next issue to address is the open fds when you unshare the namespace.

> Smack's equivalent to the SID table allowed one to safely pass around
> pointers to the label string, which was never de-allocated, so it only
> needed a single copy in memory of each label. We could add something
> similar outside the security server in SELinux so that
> inode_security_revalidate() could re-map the context string to an
> appropriate SID without requiring sleeping.
