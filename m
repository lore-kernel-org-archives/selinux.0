Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B143383983
	for <selinux@vger.kernel.org>; Sat,  3 Oct 2026 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791031799; cv=pass; b=N4zPVpqahpuLOn3RbBsK0/eSihVnBKb3H+aWVB5uXR3/IHMfpdMtunM/ATx5hB4RImMff5I6SefF7xCieSoI9UjGFiSEv7+v6FlpUpKGO2F8fBh0MejReUaEhZ4YcXlwJ21AvWFHidZpITK6/cnv9sc6Ba1M1+hH4JWZQV6Ge/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791031799; c=relaxed/simple;
	bh=hZ0qtCYRp+nsn/a1OjzqXF74Al42Q961RHcd0OkDTAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRhYKoF+9kmHG89cweYxx98RfxvUbzq0tBY7kSzjjaFeebHC4vY5jnfvgD6Zo65MeyBqakfPq1+9GLz2mpEPNfA3OubzZe6GNKf1/J5oKa65mZV0ud1nxAwSKUj4A2IUkxjspUikvB5q4yDySLSJsD1D7mr1qBkj2iLuQU6KeoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4s61Xp7; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4s61Xp7"
Received: by mail-yx2-f38.google.com with SMTP id 956f58d0204a3-67561cbafd0so253558d50.2
        for <selinux@vger.kernel.org>; Sat, 03 Oct 2026 05:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791031797; cv=none;
        d=google.com; s=arc-20260327;
        b=qbI+8iwTFsHYV7YUYb4ImsfpsBl6XfqZUDzXARpOWxz5OZ5hvazzYml3IxUPx3YfJP
         VB5rFDZ/JQepRCymCmIINjWLBglUb/vmhuFm5K6Ez252dlVopqwEGCiink7vlwoCpqeB
         LNsgwFF+3i8KSDH8OTYJvyYj1cg+U+xTJ1Tq8/MYd0hZJuuS615drYQTlkuyMGqeLhAu
         iwDdDpWc0kKB8oCt1NpI1LqKfOHUwp1OJe004pZ0MjOGBwY/LrZPQ1C63Dcm8I8QB0Nw
         cqXjadDDxvLRVQAgzSZAPPnsWePdi1xEKL+b9GEFA8B3PS6etLxYuOyI1fpEwjQYDR0k
         m8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nGuMn52Zsj7Zn39Hsw5N4fNhVIZHLv3BXDILGXJdZAM=;
        fh=BBJqc/5aupG4u6naVoVIc4TKTfiX7+XPEq6N+O0Hd0U=;
        b=e40jI2163jzD8KtRKNaAT6iZ0vrD9gXVKB2No60K8Gm2+O6wm9ryTXkjHqhkeXXbEq
         E7/ndPHO719wkoKrk+LYsF0Tpi7aGRgAsYCnkXWyswcdEehZLmjnoG0svL1YIeHiGmaJ
         7ibmP6RmFlgxWlSujuMY3oxr/9vb/3imgTfFGYJCiSHYsyWZcVRwzwlzTNE9//uYNbpB
         VmOTX6CN4skENbcLIyU7IZP2L6PylVREQdu7w2/F0+rilIQ+asrtlGgTEN26GnCgHMA1
         eim88W+JrVbDVu7CcMKvn/0/L7wpSr0B9vwfNxVGhUV1eevYE5Y6Ob38vEJ66882D7Km
         5P9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791031797; x=1791636597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nGuMn52Zsj7Zn39Hsw5N4fNhVIZHLv3BXDILGXJdZAM=;
        b=V4s61Xp7VJPu5fmjyna1vzbZX+zdZai02HRw0lLqBVQ8XjPoo8JlViClvmTzUThawo
         JekCI/qLTjbJ2OON5V8xfeCrQgE4n5gzKGS/p5cJ/0uext/JZnNU8KaOtQEyBOqXHpg9
         /I7AjWnikYKlo6wYa2jxCP0qgE1PVt6bVc7L1f6bQSNpVNAGd1+xwLdywBUuWWUtI+31
         Cb5V1gqxahYGydxYwkU/fS1AVJ5Q0pdl1ExO2mRTzG3JLG9jETmTDmqwE2+xxJkgwm1T
         Z+H1b40vIy1WW0zbXDUJsSR1C7+7YrNVAhj5ul2hpiV/yPyfVT/UvQRukyVX1IJuSFeS
         J41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791031797; x=1791636597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nGuMn52Zsj7Zn39Hsw5N4fNhVIZHLv3BXDILGXJdZAM=;
        b=aYn0DuX0vFwEHIjYg8IV/w1nLuHoddOYpzV3Ryqeh9KS0V9CDUbjjxxlpgN1M3PzME
         wJNqCNtlmmL3KN8OxuCLz7XzN9utVI/ttTEgWh25zm038qRt0ukQwEL/RfEhyGRJqnwN
         6NShTAPM0hPcaOIH6M+Gj2PXM8lh3f/rRzkL7lDF/TzT2AF0cM9GcU13+eDSk7DRlbad
         pJs0YWGV23cnRlg3LNNARE2Sh+lQ47o6PYYCvOps1ft7v9Zo4g7GBZo4TnvQMMhuVKUH
         I8Icg7L2j0ylcY6wtmsRWRxla3YjvkKWIf7Ky4eS2yzf8JBBM8RZK1dsl+U8OZdz1bmR
         OJ8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxu3+t2e19FLFVd4yJC95HzrNr+Yp5B3uikCoVOWit0h+tJZB9uoOq+Px2LzJk7psd7n9yrIrza@vger.kernel.org
X-Gm-Message-State: AFq9FYK88LAMp3ZD0IqfDp7b319QqsCNI4lsmJmpjpNZiFL2/HWTw4Jc
	H5cn545QAiONbNRRK9f7vNQ8UWSMR1Nod8PTBaaiqSesx+SV0+9eeUNgBkHdtHoyKLII5aXvpAm
	wf1HWis3yql/qrew3QvrAuZ44sPkUU7c=
X-Gm-Gg: AYBFou3otNDzMTe6JeoVBwP5l7VwTlFyKQlKVp4gvt8ykpS7HcAxaZEwpEEXrgOHKXV
	6EVn0ncRh6ySMwRLiutpumwYuVW9AN1ljadUxtX4dhwPyjofo6/Knt+v7l54xCmdbLq7n44h9OY
	A1mkuQ21FSmbalVH/6KQlYUj3JlI5COWb4SKe860Ua4KJxaVizZkxdCQZKDHx+x2Cr7DOoLKBIm
	M+SeFGWjoy2rTFfmmnCRGUYZCm3iFjJxDjiLERqpIXA2smi+bH8ioGPN2YQ2s8nX5aBtF0iPFO1
	nH0LlxUdXMnwajYSTYIJbQgJFevKyL1c0cNdOBwKnJ5IO6c2YfDFDGUR
X-Received: by 2002:a05:690e:b8e:b0:677:c014:29c9 with SMTP id
 956f58d0204a3-677c0142abdmr591836d50.19.1791031797186; Sat, 03 Oct 2026
 05:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ab19069-a348-42d0-89c3-3387b5d38c30@debian.org>
 <CAEjxPJ7_=ky-iy-6UHPS-Mh7GKc=BA-zyA4p96uKM3HEFEc=sg@mail.gmail.com>
 <CAEjxPJ4LTaiSc37j1bYwUkC04+BLaXVz5xArRRGEvf3rHQS7+A@mail.gmail.com>
 <CAEjxPJ6FBdnHvUmXfD7WNgsFRLy3JuFHkwN4p0=9Wm82L2nZXQ@mail.gmail.com>
 <833bdec5-3935-4f86-961c-f179e5f8fb9c@debian.org> <CAEjxPJ60od3GG5wqEYuoQQjtW+3VykX2J9L1e4uX0z7yAhRxRQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ60od3GG5wqEYuoQQjtW+3VykX2J9L1e4uX0z7yAhRxRQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Sat, 3 Oct 2026 08:49:46 -0400
X-Gm-Features: AclHuK-GF9EGcPoh5hYpXB-tgRMTEboJMSytV9uCWhwpRL0pGqfqasqrJXeUBKw
Message-ID: <CAEjxPJ4W1JJqAYYv8CJ6USGMYpOpMW+7TD8UhT5gKO1w0sgxfw@mail.gmail.com>
Subject: Re: selinux_kernfs_init_security() ignores genfscon-resolved parent
 label, breaks type_transition on cgroup2/sysfs
To: Laurent Bigonville <bigon@debian.org>, Chris PeBenito <pebenito@ieee.org>, 
	selinux-refpolicy@vger.kernel.org
Cc: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	SElinux list <selinux@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 8:45=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sat, Oct 3, 2026 at 4:33=E2=80=AFAM Laurent Bigonville <bigon@debian.o=
rg> wrote:
> >
> > Le 1/10/26 =C3=A0 16:45, Stephen Smalley a =C3=A9crit :
> > > On Thu, Oct 1, 2026 at 10:22=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > >> On Fri, Sep 18, 2026 at 11:46=E2=80=AFAM Stephen Smalley
> > >> <stephen.smalley.work@gmail.com> wrote:
> > >>> On Fri, Sep 18, 2026 at 6:44=E2=80=AFAM Laurent Bigonville<bigon@de=
bian.org> wrote:
> > >>>> Hello,
> > >>>>
> > >>>> The other day I tried to troubleshoot (assisted with AI) why
> > >>>> "memory.pressure" files in the cgroup2 hierarchy were never gettin=
g
> > >>>> labeled memory_pressure_t, despite refpolicy defining:
> > >>>>
> > >>>>     type_transition init_t cgroup_t:file memory_pressure_t "memory=
.pressure";
> > >>>>
> > >>>> My understanding: selinux_kernfs_init_security() decides whether t=
o
> > >>>> compute a transition for a new child by checking kernfs_xattr_get(=
) on
> > >>>> the parent =E2=80=94 kernfs's own private, per-node xattr store =
=E2=80=94 and bails out
> > >>>> immediately if that returns -ENODATA. But /sys/fs/cgroup (and ever=
ything
> > >>>> under it) is still labeled cgroup_t for every other SELinux purpos=
e,
> > >>>> including plain getxattr()/getfilecon() =E2=80=94 that value comes=
 from a
> > >>>> genfscon rule, resolved live, with no real stored xattr ever invol=
ved.
> > >>>> So the parent "has a label" as far as policy and every other check=
 is
> > >>>> concerned, but not as far as this one specific kernel check is
> > >>>> concerned, and the type_transition never fires as a result.
> > >>>>
> > >>>> A simple way to confirm: force a real xattr to get persisted (e.g.=
 chcon
> > >>>> system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/) and th=
en
> > >>>> restart a service =E2=80=94 its memory.pressure then correctly sho=
ws up as
> > >>>> memory_pressure_t.
> > >>>>
> > >>>> Tested on kernel 7.1.13 (Debian), refpolicy main branch,
> > >>>> cgroup_seclabel/genfs_seclabel_wildcard policy caps active.
> > >>>>
> > >>>> Has anyone got a view on whether this is intentional, and whether =
it'd
> > >>>> make sense for that check to fall back to a genfscon-resolved SID =
when
> > >>>> there's no stored xattr on the parent?
> > >>> Added Ondrej to the cc as the originator of this hook, first
> > >>> introduced by commit ec882da5cda9 "selinux: implement the
> > >>> kernfs_init_security hook", which says "The hook applies the same
> > >>> logic as selinux_determine_inode_label(), with the exception of the
> > >>> super_block handling, which will be enforced on the actual inodes
> > >>> later by other hooks."
> > >>>
> > >>> I think this mixed model of some files labeled by genfscon, others
> > >>> explicit, directory hasn't been explicitly set wasn't possible or
> > >>> considered at the time. If we were to change it, we'd need to check
> > >>> for regressions not only on cgroup but all kernfs-based filesystems=
.
> > >> So there are two possible fixes for this that wouldn't require any
> > >> kernel changes:
> > >> 1. Enable the genfs_seclabel_wildcard policy capability (libsepol
> > >> 3.9+, kernel 6.16+) and add a genfscon cgroup2 "*/memory.pressure"
> > >> rule in your policy.
> > >> 2. chcon cgroup_t /sys/fs/cgroup at boot
> > >>
> > >> We could modify the kernel as well but that will require some
> > >> additional plumbing beyond just modifying that one hook function. Ca=
n
> > >> you just use one of the two approaches above?
> > > I should note that only the first approach fully fixes the issue for
> > > all paths by which memory.pressure might be created in sub-trees. The
> > > second one won't fix that. So the purely policy-based approach is bes=
t
> > > if you can require libsepol 3.9+ and kernel 6.16+.
> >
> > I can indeed confirm that adding "genfscon cgroup2 "/*/memory.pressure"
> > gen_context(system_u:object_r:memory_pressure_t,s0)" in the policy and
> > enabling "genfs_seclabel_wildcard" capability is fixing the labeling
> >
> > bigon@fornost:~$ find /sys/fs/cgroup/ -name memory.pressure -exec ls -Z
> > {} \;|grep  memory_pressure_t|wc -l
> > 176
> > bigon@fornost:~$ find /sys/fs/cgroup/ -name memory.pressure  -exec ls -=
Z
> > {} \;|wc -l
> > 177
> >
> > There is just one remaining one with the wrong label, not sure that's
> > intended=3D
> > bigon@fornost:~$ find /sys/fs/cgroup/ -name memory.pressure  -exec ls -=
Z
> > {} \;|grep -v memory_pressure_t
> > system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/memory.pressure
>
> I assume you can fix this one too by adding a 'genfscon cgroup2
> "/memory.pressure"
> gen_context(system_u:object_r:memory_pressure_t,s0)' rule to your
> policy.
>
> > I guess the rule can be added to the refpolicy?
>
> refpolicy recently reverted enabling of this policy capability because
> it requires kernel 6.16+. So this won't work for stock refpolicy yet;
> you'll need to apply it on top. The refpolicy minimum kernel version
> on main at the moment is Linux v6.8 (for userspace_initial_context).
> For comparison, the SELinux userspace minimum kernel version will be
> Linux v4.3 starting with the next userspace release (3.12) since we
> are setting the libsepol minimum supported kernel policy version to 30
> (xperms_ioctl).

Some references for the above:
https://github.com/SELinuxProject/refpolicy/blob/main/policy/policy_capabil=
ities#L120
https://github.com/SELinuxProject/selinux/blob/main/README.md#minimum-suppo=
rted-kernel-version
https://github.com/SELinuxProject/selinux/commit/2ae2a7d0a4c9ab85eaf5824c2d=
25693e8aa58d80
