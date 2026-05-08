Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3265335E95A
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273630; cv=pass; b=c3qTJXGlvRW/hPyxhOjYqQK4i1W2uByJGkA1N5Bin8wO4L8FYushp0uacCxrkMAVfAln5Mjbt7jo8yHD+EKuFFjiwuFvPZxJ13azOIbSyjTbsYNd1lxqdIMyxeQPAz0b9fJl5oC54/XuJsSNkgzFtHIDoTFRD9IUjhGhZ1ntWOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273630; c=relaxed/simple;
	bh=95IVxcvqWG/JPgHLoMmXlIvgmhSj0ZnffrludpYS+b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQL+YdUPYHc68gE+Nhqc0epMqkE1J6ZGDnC4db6fxcpTYaonQinOo5emxNDVZZRa5x3YRE5Cyf4GsprPCtkuAfsTcDSPyGbefw4vv6CfasqaPsrquffm6Bat3clmSBPuYpQmCbzx+UNAz9sKzb82aUZ/KEMUKZFX8QyGs37atFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dO9DTlgQ; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dO9DTlgQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba4efedbeaso17669135ad.1
        for <selinux@vger.kernel.org>; Fri, 08 May 2026 13:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778273627; cv=none;
        d=google.com; s=arc-20240605;
        b=S/CkUS3gbInzJ4NlJYS23dNUqrI2xRPn6NgnQgsmtIYo/O/k+dvDCGrrnvkvlfVH9t
         8BZj1GX5JGfB6BXGLIY6zkF0mGLXpfiu3uB98hfU1jnEsMyrqYr0VM9GG5vqLdlSTkYH
         cEJVgDEkPsFKtF368gRpLPaYkthWD6YDpdzslE71cuulXFnIGeh3uWUOqFUEltEHA7pa
         R+6bXC7uRWWnNEqoMvW8D7jiEJXhNRH2v11DnQK6hJ0ZiMWdjS/LPe9wAZkpWTFPiyhS
         2bUO9j49waTZ5eiUwd/MFqdEo9Ncf2uOsoqEInzUjpSdtAUIy/QkUHms3/qi7riZBWD3
         Y3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWh1iviHf4ogJ10OkMdUK6imNF3ForFBNVwSW2PZTR0=;
        fh=iXUkceXXUFPBnMzMFJxKtmYFDR+1kGgbWsSo2nfJ70M=;
        b=D6Cr8OGTWcqYJ29VyCY7vFVHBf8PymZw+pHH06k7TrSzlhLiRnFRHOWfKhzL2wzF5B
         Wkd0ZSZiMr36T9EX6H0u57RL/WYakA86iFaEyCdm6VLOvv0qtGlFYMegLFh9npPOx5u/
         rYmZ7HCHx3+kMNKg+macTyii3o/pMjB0SP9ksH8i2kfYUSO/rNl3r581+0IsdvzZs2XO
         y+tuBcbNhvlSvGBZDlfxi60ItQooK4NZlN+QqZRe43x3Jlv+pyaTyBzCVQZq17+A7dA0
         tGHjMTQRqvcBVaJlrhON2nH35Um0jsefvUSH+fRC3+7KHIMqNcPDQDzaBm2HnZtk6qwV
         bvgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778273627; x=1778878427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWh1iviHf4ogJ10OkMdUK6imNF3ForFBNVwSW2PZTR0=;
        b=dO9DTlgQfsP6r2/MbL7aMUDkGQ4OLsZv0vYaf15PRIss3gRaJnowuxUHcSTUva6W85
         j/J+VjqQFgVev2klxrYTwwe7wgIO74KBi8ycfATzCDimRON9YD75IEBw3xION86Y4N1t
         NjrhyMDHgZmXM4viWlybsq1Qt9tp3H+flY1WSkGRX/mJRBqcNybrwAi88BJWKbzj7tx4
         VLh0co/3VJAuzXKuJWe+SzfSACIdNtKXKNLmK2ezmduu2usGOLUfBvb/q7sVfyYt6BpJ
         FXSWp4s7M9aklH2uiCsBM/jSbStdmCIISoPD+PHofmTIhlSMS4yGPETjhs7ejJOMsnJ+
         YokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778273627; x=1778878427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWh1iviHf4ogJ10OkMdUK6imNF3ForFBNVwSW2PZTR0=;
        b=pqCakmCMLqKF99xQcuLuSAmyr/qyDDSDdxbsbuotWn8ShWEAvcXIQh4sJ+is4NnJ+7
         2x+ovpUEfk0W3b6qWpQQNacXKRvcDrpeYa65JPOdqQQzzAQpQtXz7e7zIgAS+4cL0ZE6
         Y5PjM19JYJWO9rt43VWa/25/31BpSQV5ssPKBaIhHYKxnYwPySXMVr+ryGvrWrPqOBFF
         l6iDp8iWPTTzox5oZr5z5X7dLoXsbbDnXCfTJDSFaMsHZeB5an7PEMzMuQsle38K0job
         qNzfAK5pv8ojsUfR9clZissbSkAyoDcroxRLyw1X6GehQGLBdWa3i3iCiG++0s5ozcwm
         D1Cg==
X-Forwarded-Encrypted: i=1; AFNElJ+HR25mMxZJaOpMfkcvWLtfMOEn4WhXoR7aaf7EpArJTsfhDN3br/Q/nqeTO0Fvu5WEpB8TXGfx@vger.kernel.org
X-Gm-Message-State: AOJu0YxPD0thlWMt2/u4I9wYW8gSXW9DpdmyTd93PI84cjb13v1McpAK
	CzvC60qDbwoAIMyd1jMiugq/WsJp6P2LYoX6hwb5aauMen37uS1h0zeC8EoD2xenkB1pSxmiS4x
	zyLpobsPRbKcifWgGDWDe6LvQ1R6r7tB50naPsvIt
X-Gm-Gg: Acq92OGMRyyKYlWafXG8DCp1RZM+JOvSwekNFmT6+wHPE0EbGKSeDe2onvpQ/9Vc70g
	e9ynWiky6YQX39y+EdXnMOD7q3LkjrxFqLBnS15Onsafj0GyNHFTZr8DhX6KrW+hcADKKEWJlJ0
	IWMjr8Mn93/03skVqTvpQybOkXbHfW3QObVK9fpAn9q7NX1e6ztsl5FG4s4NhhaBfFzRhtd8/fn
	dsaoVjQPAevoBLdc/sogoKNyzsYjsI1WSaAbi6nwK6vnWg0E/qCsDCBNomA8+W+M7PqOPmt+0hj
	ejL9QBrr/d+IgJ6YgnxlvhAFdH6X
X-Received: by 2002:a17:903:1b07:b0:2b9:eb6a:68b5 with SMTP id
 d9443c01a7336-2ba7a36022amr136938945ad.38.1778273627590; Fri, 08 May 2026
 13:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430000315.918964-1-song@kernel.org> <20260430000315.918964-2-song@kernel.org>
 <CAHC9VhT6YxJQqSkBbSeACFL6+AoL0031u2VT4fuRqPxDkGzSfw@mail.gmail.com> <CAPhsuW6VqfPGnMqwSu-3EC9suWScOBZDHh16d5Bsg6dcjcB4ww@mail.gmail.com>
In-Reply-To: <CAPhsuW6VqfPGnMqwSu-3EC9suWScOBZDHh16d5Bsg6dcjcB4ww@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 May 2026 16:53:35 -0400
X-Gm-Features: AVHnY4JRDMNUmX4JH5JunmLlULux3slQY9_dADVN9V7Jbwgw1Y6mP1Hb0ty2Ukk
Message-ID: <CAHC9VhQ237o27ej-_0tgv08KF-FaX9nrRyUF_9pE4uaVMGqU-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lsm: Add granular mount hooks to replace security_sb_mount
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, jmorris@namei.org, 
	serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 4:29=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Fri, May 8, 2026 at 1:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Wed, Apr 29, 2026 at 8:03=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > Add six new LSM hooks for mount operations:
> > >
> > > - mount_bind(from, to, recurse): bind mount with pre-resolved
> > >   struct path for source and destination.
> > > - mount_new(fc, mp, mnt_flags, flags, data): new mount, called after
> > >   mount options are parsed. The flags and data parameters carry the
> > >   original mount(2) flags and data for LSMs that need them (AppArmor,
> > >   Tomoyo).
> > > - mount_remount(fc, mp, mnt_flags, flags, data): filesystem remount,
> > >   called after mount options are parsed into the fs_context.
> > > - mount_reconfigure(mp, mnt_flags, flags): mount flag reconfiguration
> > >   (MS_REMOUNT|MS_BIND path).
> > > - mount_move(from, to): move mount with pre-resolved paths.
> > > - mount_change_type(mp, ms_flags): propagation type changes.
> > >
> > > These replace the monolithic security_sb_mount() which conflates
> > > multiple distinct operations into a single hook, and suffers from
> > > TOCTOU issues where LSMs re-resolve string-based dev_name via
> > > kern_path().
> > >
> > > The mount_move hook is added alongside the existing move_mount hook.
> > > During the transition, LSMs register for both hooks. The move_mount
> > > hook will be removed once all LSMs have been converted.
> > >
> > > Some LSMs, such as apparmor and tomoyo, audit the original input pass=
ed
> > > in the mount syscall. To keep the same behavior, argument data and fl=
ags
> > > are passed in do_* functions. These can be removed if these LSMs no
> > > longer need these information.
> > >
> > > All new hooks are registered as sleepable BPF LSM hooks.
> > >
> > > Code generated with the assistance of Claude, reviewed by human.
> > >
> > > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for sel=
inux only
> > > Signed-off-by: Song Liu <song@kernel.org>
> > > ---
> > >  fs/namespace.c                |  35 ++++++++++--
> > >  include/linux/lsm_hook_defs.h |  12 ++++
> > >  include/linux/security.h      |  50 +++++++++++++++++
> > >  kernel/bpf/bpf_lsm.c          |   7 +++
> > >  security/security.c           | 101 ++++++++++++++++++++++++++++++++=
++
> > >  5 files changed, 199 insertions(+), 6 deletions(-)
> >
> > ...
> >
> > > @@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct path=
 *path, const char *old_name)
> > >         if (err)
> > >                 return err;
> > >
> > > +       err =3D security_mount_move(&old_path, path);
> > > +       if (err)
> > > +               return err;
> > > +
> > >         return do_move_mount(&old_path, path, 0);
> > >  }
> >
> > While the security_sb_mount() hook calls into do_move_mount_old(), the
> > security_move_mount() hook calls into do_mount_mount().  As you remove
> > both of these LSM hooks in patch 7/7, should we consider moving the
> > new security_mount_move() into do_move_mount()?  If not, how do we
> > ensure that we don't lose coverage when removing the
> > security_move_mount() hook, or can you explain why it is not needed?

Ooof, I just read my comment above - that was all mixed up, my
apologies.  Evidently it's been a long week ...

> Patch 7/7 _replaces_ security_move_mount() with security_mount_move()
> in vfs_move_mount().

Okay, at the very least you should probably change the subject line to
patch 7/7, or ideally move that hook addition/modification to patch
1/7 so patch 7/7 is purely an unused-hook-removal patch.

> IOW, security_mount_move() is called from both
> vfs_move_mount() and do_move_mount_old(), so we are not losing any
> coverage. Did I miss something?

No, I assumed patch 7/7 was doing something different based solely on
the subject line.

Let's also put the vfs_move_mount()/security_mount_move() change in
patch 1/7 so that patch 7/7 is simply a hook/dead-code removal patch.
This should make the patchset much cleaner.

--=20
paul-moore.com
