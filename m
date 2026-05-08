Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38242314E
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275524; cv=none; b=c0brAM2P+MnSEjpF1k7dt/LahZvUE8DkC12fnKunG2od2iBOvHyJF8OkX/+0/FNvabHnKZ7StLZ7xmmBpr50YD4Ldu2t+k0cpj8uHc/ScJkCDKoy5d6zqNZraSE3iJoAj+UpJxKNyuNrYUYURHcMEb6RtqgJfK5OcYN1Z565+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275524; c=relaxed/simple;
	bh=XZHtksjzdIujB0L10yoqbxFHajKJMkMvwCda755Z7KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaaUedqcOwY90+rf4Xcw17xsMgJN89RRj0O23wMkJJhbsgInOywKZAgiFKfb+AdcH7N0NKok5DtNSxUSVHnV+1sWiLy9RBX2GxU5f2ISbvsQ26GOlUOP+ScVC5bpKsIbARQz/muNflf/yNNoRAWOJ64yoGHtTEYMhSEtIg8KqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glpfoZLp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glpfoZLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C84FC2BCF4
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778275524;
	bh=XZHtksjzdIujB0L10yoqbxFHajKJMkMvwCda755Z7KU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=glpfoZLpKvLxR/v407FkPkWIO/zQF9Rhqnp2aYdAM2BqZu1prVJ6A/m8Pv7PQM3sj
	 XmV5RrJoHXMKVAX6fwnP/uOTkC2e/BIZHJY2QBqFwNUc5PwhLiWwiZZocHasilGAII
	 SoeWOR9Kbus1IycxVNiwAh+w4+Hso2wxgod8M3xJiBB1SLFEoeYc+FADf44nsmojpT
	 nTTLE7ulSBfDI3ZA4o4G5mj86NSWdewcY8WojmspmAAgCAjeKDpljVE1fa1fG1wDKv
	 qMLGkeLTUQ0xNd6AU0qzu207IDXQl9vFTW5NhMdNfJ8lrgSHksStHzFGbf8eVWjou1
	 3xzG/ijA3n0ww==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8bb09239328so19359076d6.3
        for <selinux@vger.kernel.org>; Fri, 08 May 2026 14:25:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/TCls1i8eO34qNG3tn5cQWtM/Go8U3Lchov4Sc2c349w8sAYtfaRRK7fG0Opd//O8aBM18Mtar@vger.kernel.org
X-Gm-Message-State: AOJu0YyOGfg8elh4JZnYuTJEiN2M1H3PKLv+JePX03y3DWfOLxvpiAv4
	lNEhsaC3SpyNQ2X4LW5RO0ESIs+nZxeinjzOVgyh9thC3vau6ljDV5WOQ9uOtR5hl4XtYFr8LXJ
	/VwRCIlv2PWIttNzjcqri2U+Nwm9WWic=
X-Received: by 2002:a05:6214:4f15:b0:8be:1620:a98e with SMTP id
 6a1803df08f44-8bf41ea12a2mr59686806d6.20.1778275523639; Fri, 08 May 2026
 14:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430000315.918964-1-song@kernel.org> <20260430000315.918964-2-song@kernel.org>
 <CAHC9VhT6YxJQqSkBbSeACFL6+AoL0031u2VT4fuRqPxDkGzSfw@mail.gmail.com>
 <CAPhsuW6VqfPGnMqwSu-3EC9suWScOBZDHh16d5Bsg6dcjcB4ww@mail.gmail.com> <CAHC9VhQ237o27ej-_0tgv08KF-FaX9nrRyUF_9pE4uaVMGqU-Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQ237o27ej-_0tgv08KF-FaX9nrRyUF_9pE4uaVMGqU-Q@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 8 May 2026 23:25:12 +0200
X-Gmail-Original-Message-ID: <CAPhsuW4giJDVfutF0xkEQ5ZkKPc8r9apxP+pt_4x33VJ0+xi_g@mail.gmail.com>
X-Gm-Features: AVHnY4K98LQDDmTIZV509hGsUgrIi5GYj_lVWOCK6WffrNrfKGbMnPq1K5m60Zg
Message-ID: <CAPhsuW4giJDVfutF0xkEQ5ZkKPc8r9apxP+pt_4x33VJ0+xi_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lsm: Add granular mount hooks to replace security_sb_mount
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, jmorris@namei.org, 
	serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 1:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, May 8, 2026 at 4:29=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > On Fri, May 8, 2026 at 1:10=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Wed, Apr 29, 2026 at 8:03=E2=80=AFPM Song Liu <song@kernel.org> wr=
ote:
> > > >
> > > > Add six new LSM hooks for mount operations:
> > > >
> > > > - mount_bind(from, to, recurse): bind mount with pre-resolved
> > > >   struct path for source and destination.
> > > > - mount_new(fc, mp, mnt_flags, flags, data): new mount, called afte=
r
> > > >   mount options are parsed. The flags and data parameters carry the
> > > >   original mount(2) flags and data for LSMs that need them (AppArmo=
r,
> > > >   Tomoyo).
> > > > - mount_remount(fc, mp, mnt_flags, flags, data): filesystem remount=
,
> > > >   called after mount options are parsed into the fs_context.
> > > > - mount_reconfigure(mp, mnt_flags, flags): mount flag reconfigurati=
on
> > > >   (MS_REMOUNT|MS_BIND path).
> > > > - mount_move(from, to): move mount with pre-resolved paths.
> > > > - mount_change_type(mp, ms_flags): propagation type changes.
> > > >
> > > > These replace the monolithic security_sb_mount() which conflates
> > > > multiple distinct operations into a single hook, and suffers from
> > > > TOCTOU issues where LSMs re-resolve string-based dev_name via
> > > > kern_path().
> > > >
> > > > The mount_move hook is added alongside the existing move_mount hook=
.
> > > > During the transition, LSMs register for both hooks. The move_mount
> > > > hook will be removed once all LSMs have been converted.
> > > >
> > > > Some LSMs, such as apparmor and tomoyo, audit the original input pa=
ssed
> > > > in the mount syscall. To keep the same behavior, argument data and =
flags
> > > > are passed in do_* functions. These can be removed if these LSMs no
> > > > longer need these information.
> > > >
> > > > All new hooks are registered as sleepable BPF LSM hooks.
> > > >
> > > > Code generated with the assistance of Claude, reviewed by human.
> > > >
> > > > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for s=
elinux only
> > > > Signed-off-by: Song Liu <song@kernel.org>
> > > > ---
> > > >  fs/namespace.c                |  35 ++++++++++--
> > > >  include/linux/lsm_hook_defs.h |  12 ++++
> > > >  include/linux/security.h      |  50 +++++++++++++++++
> > > >  kernel/bpf/bpf_lsm.c          |   7 +++
> > > >  security/security.c           | 101 ++++++++++++++++++++++++++++++=
++++
> > > >  5 files changed, 199 insertions(+), 6 deletions(-)
> > >
> > > ...
> > >
> > > > @@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct pa=
th *path, const char *old_name)
> > > >         if (err)
> > > >                 return err;
> > > >
> > > > +       err =3D security_mount_move(&old_path, path);
> > > > +       if (err)
> > > > +               return err;
> > > > +
> > > >         return do_move_mount(&old_path, path, 0);
> > > >  }
> > >
> > > While the security_sb_mount() hook calls into do_move_mount_old(), th=
e
> > > security_move_mount() hook calls into do_mount_mount().  As you remov=
e
> > > both of these LSM hooks in patch 7/7, should we consider moving the
> > > new security_mount_move() into do_move_mount()?  If not, how do we
> > > ensure that we don't lose coverage when removing the
> > > security_move_mount() hook, or can you explain why it is not needed?
>
> Ooof, I just read my comment above - that was all mixed up, my
> apologies.  Evidently it's been a long week ...
>
> > Patch 7/7 _replaces_ security_move_mount() with security_mount_move()
> > in vfs_move_mount().
>
> Okay, at the very least you should probably change the subject line to
> patch 7/7, or ideally move that hook addition/modification to patch
> 1/7 so patch 7/7 is purely an unused-hook-removal patch.
>
> > IOW, security_mount_move() is called from both
> > vfs_move_mount() and do_move_mount_old(), so we are not losing any
> > coverage. Did I miss something?
>
> No, I assumed patch 7/7 was doing something different based solely on
> the subject line.
>
> Let's also put the vfs_move_mount()/security_mount_move() change in
> patch 1/7 so that patch 7/7 is simply a hook/dead-code removal patch.
> This should make the patchset much cleaner.

Sounds good. I will make the change in v3.

Thanks,
Song
