Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB31359A8B
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272157; cv=none; b=Zuf5ybOfqijt2dlh//vFgiqy66btsTkffMziBxTX03ohv0Sn4H8Yp18zeTxLOABPrIQct1xF/oZ+niARi0inRmWUqV5sadDntwR6JM5FhzNo4kP8Mx8xPpT6AtUDkviwhdaVUwH6H+0f9mI7y6EMRoc7p/Xp9VYNYp5gLgpUSWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272157; c=relaxed/simple;
	bh=LFbJezyej/RamRova8N5zk+E6+LJuk5RpehIIlVX+dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLY7Ddzut4S7k0i8oohe6+gTt0OPMyOpM33rrCUQxdlEzjNglb81ROFKXULKIOqTV5wlzsp2LSMzf9Q9q+M3pqN2pRie0RP3/8TUZUeAmUMzZe947BH6sEizVaWI2bG3wXLcRI0EV+ngU/eKnptdCSZMuNux3JVP/2FF4P4pLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8as32Q6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8as32Q6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B64C2BD04
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 20:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778272157;
	bh=LFbJezyej/RamRova8N5zk+E6+LJuk5RpehIIlVX+dE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E8as32Q6GDztGu2LEQLH14Pw20N6CICvff/6dRyVjQbwjMaTvFS4GVX9RHx2cQVli
	 Afy9ypcLfZaT6W7hN/VfLGF6RBuU5LbWlpg5MNLO9dCjNxJX5E3vSaXOT1nWK1fET/
	 IPszMZ/eiQ/6e8gMTXzeIPYAylxfmT5OhHngf2AwLAP+AFVqZdNyw/PhZ6YXQN/0DK
	 Rw7RxlryN9FkNmODvPPg//0fbitIQWuDiSPKopvL2c7ZHdEwlK6zFDfDsYAUIXtiR1
	 drtT1TffpxIqGuoTr/Zpq2VWlajM0vJjYBkWNZFXGKbxlV/iQRm9bsqiJkqtanlwae
	 tLnDGAr3pcjqg==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8f15e900586so122767285a.1
        for <selinux@vger.kernel.org>; Fri, 08 May 2026 13:29:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8OzTmFFGCUasGrrW50O2SHwXHJkGz5u/Zq/LaK3upTlJNq+04M4xtiymx2/omOO1ykGXh3U3Y+@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9H2xz34QmtREtjvQG2jnDvPq6l3ugGEwjvStjJuClTm8hCi/
	uiXMiJq2yZjt+lD8dKNDSpxSFmmaCmSxbUlzU0AyytyilCfMZ8EnKEh06rLu1rJv6YZDHpsL7wg
	zlWyIwFLvXOEDuCO3rxzPqQpspsA3mhc=
X-Received: by 2002:ad4:5ded:0:b0:8bd:75c2:5528 with SMTP id
 6a1803df08f44-8bd75c255c0mr162188686d6.12.1778272155948; Fri, 08 May 2026
 13:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430000315.918964-1-song@kernel.org> <20260430000315.918964-2-song@kernel.org>
 <CAHC9VhT6YxJQqSkBbSeACFL6+AoL0031u2VT4fuRqPxDkGzSfw@mail.gmail.com>
In-Reply-To: <CAHC9VhT6YxJQqSkBbSeACFL6+AoL0031u2VT4fuRqPxDkGzSfw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 8 May 2026 22:29:02 +0200
X-Gmail-Original-Message-ID: <CAPhsuW6VqfPGnMqwSu-3EC9suWScOBZDHh16d5Bsg6dcjcB4ww@mail.gmail.com>
X-Gm-Features: AVHnY4Li5XRpBjwgHrnFV0QsoHxiEid2uDBKSpAKmsfa6C_FEechGcPyhIjAY-8
Message-ID: <CAPhsuW6VqfPGnMqwSu-3EC9suWScOBZDHh16d5Bsg6dcjcB4ww@mail.gmail.com>
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

On Fri, May 8, 2026 at 1:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Apr 29, 2026 at 8:03=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > Add six new LSM hooks for mount operations:
> >
> > - mount_bind(from, to, recurse): bind mount with pre-resolved
> >   struct path for source and destination.
> > - mount_new(fc, mp, mnt_flags, flags, data): new mount, called after
> >   mount options are parsed. The flags and data parameters carry the
> >   original mount(2) flags and data for LSMs that need them (AppArmor,
> >   Tomoyo).
> > - mount_remount(fc, mp, mnt_flags, flags, data): filesystem remount,
> >   called after mount options are parsed into the fs_context.
> > - mount_reconfigure(mp, mnt_flags, flags): mount flag reconfiguration
> >   (MS_REMOUNT|MS_BIND path).
> > - mount_move(from, to): move mount with pre-resolved paths.
> > - mount_change_type(mp, ms_flags): propagation type changes.
> >
> > These replace the monolithic security_sb_mount() which conflates
> > multiple distinct operations into a single hook, and suffers from
> > TOCTOU issues where LSMs re-resolve string-based dev_name via
> > kern_path().
> >
> > The mount_move hook is added alongside the existing move_mount hook.
> > During the transition, LSMs register for both hooks. The move_mount
> > hook will be removed once all LSMs have been converted.
> >
> > Some LSMs, such as apparmor and tomoyo, audit the original input passed
> > in the mount syscall. To keep the same behavior, argument data and flag=
s
> > are passed in do_* functions. These can be removed if these LSMs no
> > longer need these information.
> >
> > All new hooks are registered as sleepable BPF LSM hooks.
> >
> > Code generated with the assistance of Claude, reviewed by human.
> >
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selin=
ux only
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  fs/namespace.c                |  35 ++++++++++--
> >  include/linux/lsm_hook_defs.h |  12 ++++
> >  include/linux/security.h      |  50 +++++++++++++++++
> >  kernel/bpf/bpf_lsm.c          |   7 +++
> >  security/security.c           | 101 ++++++++++++++++++++++++++++++++++
> >  5 files changed, 199 insertions(+), 6 deletions(-)
>
> ...
>
> > @@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct path *=
path, const char *old_name)
> >         if (err)
> >                 return err;
> >
> > +       err =3D security_mount_move(&old_path, path);
> > +       if (err)
> > +               return err;
> > +
> >         return do_move_mount(&old_path, path, 0);
> >  }
>
> While the security_sb_mount() hook calls into do_move_mount_old(), the
> security_move_mount() hook calls into do_mount_mount().  As you remove
> both of these LSM hooks in patch 7/7, should we consider moving the
> new security_mount_move() into do_move_mount()?  If not, how do we
> ensure that we don't lose coverage when removing the
> security_move_mount() hook, or can you explain why it is not needed?

Patch 7/7 _replaces_ security_move_mount() with security_mount_move()
in vfs_move_mount().  IOW, security_mount_move() is called from both
vfs_move_mount() and do_move_mount_old(), so we are not losing any
coverage. Did I miss something?

vfs_move_mount() has a special case (MNT_TREE_PROPAGATION).
If we move the hook to do_move_mount(), we are missing the coverage
for this case. Therefore, I think current code as-is is the best design at
this point.

Does this make sense?

Thanks,
Song
