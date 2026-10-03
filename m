Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F242A17F
	for <selinux@vger.kernel.org>; Sat,  3 Oct 2026 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791031545; cv=pass; b=YemH2fwMVk0+eReP/4xO8/b+fxymQtdgNldmJ5OSPtp2fEh5YDUeHH5WycFICfkVSd2FhOGIt5o+xkbEfb2yYgfiDRUhe5BWeKOtlF/plpmgme8vkq9oyEENrdd3bimj/9vK8RjBwns9ume/sM8MD0PFlyFN52u7aew6+Sg0oKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791031545; c=relaxed/simple;
	bh=lVSSCQaDrrksmFia8hOGrjzs+X8iezFeEHJlfTm5rdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPoVO/PMPZHRWZxBdv20AYHGfW0EtKX4K2gWGZ1Ff9FO/Vr7JiiU/VZJ9Cjkk4Q69rSS5K/lsjG6Tjdnp6F5iwMzsgJZm+SPkIzCWvhXMSC9a/YQ8UE72qBJneCgOBZwhbuM4MIDvP9tb/dE4qqDoD8Z2foaWsBceiHmp4mYPDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSnE+kxF; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSnE+kxF"
Received: by mail-yx2-f38.google.com with SMTP id 956f58d0204a3-67561cbafd0so252007d50.2
        for <selinux@vger.kernel.org>; Sat, 03 Oct 2026 05:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791031542; cv=none;
        d=google.com; s=arc-20260327;
        b=d/RvSwe9iU6GUTVSicf90nFGoltZkPBSulKx60bDp4I2Ys81KGQD9ERyk4QMT6wOfX
         u97cToEDYlP+Sa1UuI33gLktzijG3KyWbe2/B/fs9HuTaQOHAohAdFkkNMTTSTXTCJ/A
         jR+aFUxGe0VK3LXpd1XO7WgzQdoooBTYR9CAc5noJv/X+oguCs9pqynpGkbRFH42bhob
         70B70nb2p+Xrf0PiKXjAlVnIgask73Gxy19rye+jaJgdI3EHXmXiDe5Aphoav2dTnlTt
         J7f5cDE6jRe0BsK3avMJlsAoi+JsNzEQ20eJRDInVAb+5FK8UQLal7z+gT2jRJLbMId0
         sf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l9sfEZkQmxl7rRh5XH8oibtJ2OI1ntwx0Ed4r64Lpww=;
        fh=0wZVB//CdI6gOCAY9HPOoQR/d2LCvBeX4QSAoPkfftY=;
        b=DCx1Phrc1VyqyPDlwegZ9j1V9eIErudo7+eEcQvz6yb0FTbXAzFPrxF8XwYXbUYJy9
         aenhOzdZkhX/2u/01Lu6KSwwR26bLqG1R5OYzAgmaE1WE8y5H1D5JFc9sBus+Y6KVTwP
         BZjnXFJdE+Xkuouodd+4eVcVFVQKFse0O4tUyuMYPTVw5aD6r2DkiXwRmRAw8ATWhlON
         BnenkZn3+4INOgNR32FFetiokRYeHLLEeON2cdzN6TZOV0bsd06v0hLyneklN2miC5FK
         PWdeq1yfr5tjV446yriGPSeVjqbZgrocnlRec4sSgs2EsnqAe+r7k/sU7Yqde54EQ5iA
         9+fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791031542; x=1791636342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l9sfEZkQmxl7rRh5XH8oibtJ2OI1ntwx0Ed4r64Lpww=;
        b=rSnE+kxFJ3ufJxsQOL0NPYjuC6tnorqK1vLFjSv023o/koL/aF8xhOUKofyYzSjDrF
         vYGpUWdPFdKJdfeR1mxepESxqSFN+9fQInpYtO+1Wb0AMvkyFtfsnM4D6cBO//mFRFn7
         rFDUy+C4oaq7E9JiKhTwSd5zE6VVirSvix+R+JFTaYC6QW9iWEu45Tq02PGExyq2zXfR
         20uAcOTZrr3GlpSDdAquMMvp7Os/aHib7sKBnG1a9/cA6Rq63RuysAMq1P8YKP8WgiHj
         IR8Ep8aSbohKrXQjbudU68BYMrcwzWZ6scnBGhxn4Qs5s4R80Jc4cUb5vGxNfWiyzJd5
         NemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791031542; x=1791636342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l9sfEZkQmxl7rRh5XH8oibtJ2OI1ntwx0Ed4r64Lpww=;
        b=hpr8fKFbAjfHABTlNTnV23i25Lel4pcTGJ9Iujjm/G0wp9eFEkFwe8rjEPBblcKpNj
         UQj8ARWHq+EsDjXv4Od639T0Bky8iI+BDdk1VT8kcOchdXifYy4A5B2N9Zg55F7PqY53
         GzVD9SSwbTihYDyQXD2ZCz8b2iCZslCkKnIbUrlFOpPbnU8PzVKVCxVDEzwzxQ6CEjyq
         PMtGyuvZ7hKRKQ7nL5sxQWsnjEvi9wAmwxAeTXSnxRXHaQxfCJQHuRkR+8/nOakDyYUJ
         sSDG7q/A3a60erzaCd0oocxdGpoDxCqCQZgoOamC2E7/PoU4VqTw7K+gUY4v8Bw3SBuq
         +vKA==
X-Forwarded-Encrypted: i=1; AKwUvBxaRMrqpE6vnFlwQWs3P947AqXdXtuKdMcBoZIh+12n/i+mvBGDyGPm+cjfhnHsl3rPpsI9VPbB@vger.kernel.org
X-Gm-Message-State: AFq9FYLmw7nB0M0gaPgC/HEqDs3JgEgfwTW3vrsiU21mhvBvSMV6FmaC
	+rreMo7yOlWh8u3Ta67DTRms1RR5bRpHg3Pgtk1V+x8pEMc1SmWMYhBdT7HksbM5XptgBirp3JT
	001Sk+MeZlmeBos/Lp0qdifqPiFN9OZs=
X-Gm-Gg: AYBFou0Bf8mPZahr+UcTBJ12DjxjXoGxnhr0jVw5Ld0geFPpSW+OhVEdGDwx8MEbAJb
	riaGDM2C5xcU4bujtQtbxq8G7628A30MonlBbuNve9YzGQHZbacukxkvkznJ7V0HfjPKn02U+vJ
	sN3wP6yNb8daIWbmsDgc3qtwjtNbTg+ReMWPhw0dk46Z8rF8Bk5ItvuUVYa3uBJcsNwAMcY6bY9
	v8r8A2VbPZJ5UU/PtRE+qMowukOSAbuTgnFWdmmFX80y6qOEo9UgsrXoD0CKnBP3EDWUhPZ0IS4
	PVdDwVkQQuOFJIC667iaF/BiZJg5dS75u9jTF2rX+1oufmm11b5XDlUQ
X-Received: by 2002:a05:690e:1512:b0:677:b728:4c81 with SMTP id
 956f58d0204a3-677b7285ab0mr1261617d50.38.1791031542051; Sat, 03 Oct 2026
 05:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ab19069-a348-42d0-89c3-3387b5d38c30@debian.org>
 <CAEjxPJ7_=ky-iy-6UHPS-Mh7GKc=BA-zyA4p96uKM3HEFEc=sg@mail.gmail.com>
 <CAEjxPJ4LTaiSc37j1bYwUkC04+BLaXVz5xArRRGEvf3rHQS7+A@mail.gmail.com>
 <CAEjxPJ6FBdnHvUmXfD7WNgsFRLy3JuFHkwN4p0=9Wm82L2nZXQ@mail.gmail.com> <833bdec5-3935-4f86-961c-f179e5f8fb9c@debian.org>
In-Reply-To: <833bdec5-3935-4f86-961c-f179e5f8fb9c@debian.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Sat, 3 Oct 2026 08:45:30 -0400
X-Gm-Features: AclHuK_xaj3EaP1JqVtzdttFZ95GzYeLXRIg73ZwSsnmNYqZNpB1rlcA4Axs2L8
Message-ID: <CAEjxPJ60od3GG5wqEYuoQQjtW+3VykX2J9L1e4uX0z7yAhRxRQ@mail.gmail.com>
Subject: Re: selinux_kernfs_init_security() ignores genfscon-resolved parent
 label, breaks type_transition on cgroup2/sysfs
To: Laurent Bigonville <bigon@debian.org>, Chris PeBenito <pebenito@ieee.org>, 
	selinux-refpolicy@vger.kernel.org
Cc: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	SElinux list <selinux@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 4:33=E2=80=AFAM Laurent Bigonville <bigon@debian.org=
> wrote:
>
> Le 1/10/26 =C3=A0 16:45, Stephen Smalley a =C3=A9crit :
> > On Thu, Oct 1, 2026 at 10:22=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> On Fri, Sep 18, 2026 at 11:46=E2=80=AFAM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >>> On Fri, Sep 18, 2026 at 6:44=E2=80=AFAM Laurent Bigonville<bigon@debi=
an.org> wrote:
> >>>> Hello,
> >>>>
> >>>> The other day I tried to troubleshoot (assisted with AI) why
> >>>> "memory.pressure" files in the cgroup2 hierarchy were never getting
> >>>> labeled memory_pressure_t, despite refpolicy defining:
> >>>>
> >>>>     type_transition init_t cgroup_t:file memory_pressure_t "memory.p=
ressure";
> >>>>
> >>>> My understanding: selinux_kernfs_init_security() decides whether to
> >>>> compute a transition for a new child by checking kernfs_xattr_get() =
on
> >>>> the parent =E2=80=94 kernfs's own private, per-node xattr store =E2=
=80=94 and bails out
> >>>> immediately if that returns -ENODATA. But /sys/fs/cgroup (and everyt=
hing
> >>>> under it) is still labeled cgroup_t for every other SELinux purpose,
> >>>> including plain getxattr()/getfilecon() =E2=80=94 that value comes f=
rom a
> >>>> genfscon rule, resolved live, with no real stored xattr ever involve=
d.
> >>>> So the parent "has a label" as far as policy and every other check i=
s
> >>>> concerned, but not as far as this one specific kernel check is
> >>>> concerned, and the type_transition never fires as a result.
> >>>>
> >>>> A simple way to confirm: force a real xattr to get persisted (e.g. c=
hcon
> >>>> system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/) and then
> >>>> restart a service =E2=80=94 its memory.pressure then correctly shows=
 up as
> >>>> memory_pressure_t.
> >>>>
> >>>> Tested on kernel 7.1.13 (Debian), refpolicy main branch,
> >>>> cgroup_seclabel/genfs_seclabel_wildcard policy caps active.
> >>>>
> >>>> Has anyone got a view on whether this is intentional, and whether it=
'd
> >>>> make sense for that check to fall back to a genfscon-resolved SID wh=
en
> >>>> there's no stored xattr on the parent?
> >>> Added Ondrej to the cc as the originator of this hook, first
> >>> introduced by commit ec882da5cda9 "selinux: implement the
> >>> kernfs_init_security hook", which says "The hook applies the same
> >>> logic as selinux_determine_inode_label(), with the exception of the
> >>> super_block handling, which will be enforced on the actual inodes
> >>> later by other hooks."
> >>>
> >>> I think this mixed model of some files labeled by genfscon, others
> >>> explicit, directory hasn't been explicitly set wasn't possible or
> >>> considered at the time. If we were to change it, we'd need to check
> >>> for regressions not only on cgroup but all kernfs-based filesystems.
> >> So there are two possible fixes for this that wouldn't require any
> >> kernel changes:
> >> 1. Enable the genfs_seclabel_wildcard policy capability (libsepol
> >> 3.9+, kernel 6.16+) and add a genfscon cgroup2 "*/memory.pressure"
> >> rule in your policy.
> >> 2. chcon cgroup_t /sys/fs/cgroup at boot
> >>
> >> We could modify the kernel as well but that will require some
> >> additional plumbing beyond just modifying that one hook function. Can
> >> you just use one of the two approaches above?
> > I should note that only the first approach fully fixes the issue for
> > all paths by which memory.pressure might be created in sub-trees. The
> > second one won't fix that. So the purely policy-based approach is best
> > if you can require libsepol 3.9+ and kernel 6.16+.
>
> I can indeed confirm that adding "genfscon cgroup2 "/*/memory.pressure"
> gen_context(system_u:object_r:memory_pressure_t,s0)" in the policy and
> enabling "genfs_seclabel_wildcard" capability is fixing the labeling
>
> bigon@fornost:~$ find /sys/fs/cgroup/ -name memory.pressure -exec ls -Z
> {} \;|grep  memory_pressure_t|wc -l
> 176
> bigon@fornost:~$ find /sys/fs/cgroup/ -name memory.pressure  -exec ls -Z
> {} \;|wc -l
> 177
>
> There is just one remaining one with the wrong label, not sure that's
> intended=3D
> bigon@fornost:~$ find /sys/fs/cgroup/ -name memory.pressure  -exec ls -Z
> {} \;|grep -v memory_pressure_t
> system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/memory.pressure

I assume you can fix this one too by adding a 'genfscon cgroup2
"/memory.pressure"
gen_context(system_u:object_r:memory_pressure_t,s0)' rule to your
policy.

> I guess the rule can be added to the refpolicy?

refpolicy recently reverted enabling of this policy capability because
it requires kernel 6.16+. So this won't work for stock refpolicy yet;
you'll need to apply it on top. The refpolicy minimum kernel version
on main at the moment is Linux v6.8 (for userspace_initial_context).
For comparison, the SELinux userspace minimum kernel version will be
Linux v4.3 starting with the next userspace release (3.12) since we
are setting the libsepol minimum supported kernel policy version to 30
(xperms_ioctl).
