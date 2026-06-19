Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD43563D4
	for <selinux@vger.kernel.org>; Fri, 19 Jun 2026 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781849677; cv=none; b=peWYqGvNuk6OkdO/W9VdGMfSmPjOdPN+OTc4Su8n+rUnY3393M775OlxGJbGBZ6IBGCGWUTNrPy/JWOVuqHzJ6mU/sf9DV0hjeO1hyoKPcfOp25cjBUMUxX6lx661gE8XAiERlE6Z/lOFaD4c3RW7fA7l5jnN2J9OhE/rNXg8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781849677; c=relaxed/simple;
	bh=wRAo93ZUqMz04OP2boe+0dqRxeddM8OJa8v4zeW88Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgWUNjEQ0QbU+x8FFZjNkMxq5U+YAp60xEqFA3dlrdCG+m6WVCdk9RBy4cF+LM+Vk+nEXAjNq/tHdTqO6wIzDbt3H6uHxtqqi+uL8LKXMyp4TsmEVMAEBJYrAq1+g0UYEz7L45EiURc0EUZsUVCR5MT4OV5M8Vu64th7yNF7Dbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqlH2Mo9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqlH2Mo9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65EF1F0155F
	for <selinux@vger.kernel.org>; Fri, 19 Jun 2026 06:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781849675;
	bh=uaS3aq1w7tNyZN2i2xHKVcafg5dLA5x8H8lD5mfIIDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FqlH2Mo95LuxodL/sUr9qWXO5x73GefOOff774qkhHhgj3PlJA2IWpCLT/OnVlfCN
	 lgKCOLeoWCjJtkwcPnut/M+p2hMtlwn4HUlaEBNLbwwMtHWdaXztjNUMEgBtzRv6XF
	 IJYeu7B/QKtfaRha7Vq8lXSm8e0rQr/JbuiXxxv6mSXVz2NxdZHsztwLQG1H5LZLvP
	 HkDlvTYFf5M4k4VumO5sLikluuLk6EJN4013YJ3VDBhbin9/zfTenZBB4/PqtkxTlc
	 5afZJ2NfE3f6O1DJ4hD1611H4vVa+gZg+ZPZhxwgW8SZHm7yGPRwP/vLFrfWiF+5sh
	 3bxpwnqAHy+Rw==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9157b94a07aso193277885a.0
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 23:14:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8s6yhA8HhvDWlbSxUo91z1q2ZDMWeov0b7MiCOKBBWHDJFJ/dZYQufJN3t4AJZzWuUZUGLNce+@vger.kernel.org
X-Gm-Message-State: AOJu0YxSc5s8NW9DiafI7hWP9Z7JPN/hNw+87VPChusX6wikCaOs0dIy
	9AXsCYXlOXJZHTbGe07oFAiS5ydyabPX4nQKiUYOrvJVXQVU4LvmT+VG0A3FOVUs/9kJ7lDdSea
	FXMSu0EjEbYwrJazQuG5vcij0ES5yAG0=
X-Received: by 2002:a05:620a:4082:b0:915:eec4:1ec8 with SMTP id
 af79cd13be357-920d27aeaa7mr178047085a.18.1781849675053; Thu, 18 Jun 2026
 23:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528182607.3150386-1-song@kernel.org> <20260528182607.3150386-8-song@kernel.org>
 <20260617-laufbahn-eifrig-charmant-a48f357a0c52@brauner> <CAPhsuW7Wn8GYrsrRhEFXQH5buaP+pdTKc0UV8Mn0B3OnNN-44g@mail.gmail.com>
 <178179134209.111814.12159888808546010170.b4-reply@b4>
In-Reply-To: <178179134209.111814.12159888808546010170.b4-reply@b4>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jun 2026 14:14:21 +0800
X-Gmail-Original-Message-ID: <CAPhsuW5CFi6J24NDeennaKnJmqDj5Z6DTAwU++naaohTo9_yPQ@mail.gmail.com>
X-Gm-Features: AVVi8Cc6mfJ09GK8HpE04iMyTYX7fa7D8MYecMOWIn8bxD1E_fS_6I-twUXEXoY
Message-ID: <CAPhsuW5CFi6J24NDeennaKnJmqDj5Z6DTAwU++naaohTo9_yPQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] vfs: Replace security_sb_mount/security_move_mount
 with granular hooks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 10:04=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On 2026-06-18 18:56:42+08:00, Song Liu wrote:
> > On Wed, Jun 17, 2026 at 9:53=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> >
> > > On Thu, May 28, 2026 at 11:26:06AM -0700, Song Liu wrote:
> >
> > [...]
> >
> > > >
> > >
> > > This again is racy as it is called outside of the namespace semaphore=
:
> > >
> > >         err =3D security_mount_bind(&old_path, path, recurse);
> > >         if (err)
> > >                 return err;
> > >
> > >         if (mnt_ns_loop(old_path.dentry))
> > >                 return -EINVAL;
> > >
> > >         LOCK_MOUNT(mp, path);
> > >         if (IS_ERR(mp.parent))
> > >                 return PTR_ERR(mp.parent);
> > >
> > > After LOCK_MOUNT @path might point to a completely different mount th=
en
> > > the one you performed your security checks on.
> >
> > I thought we agreed at LSF/MM/BPF 2026 to add the LSM hooks
> > before taking namespace semaphore, so that it is possible for LSMs
> > to defend against DoS attacks on namespace semaphore? Did I
> > miss/misunderstand something?
>
> I think there was a misunderstanding. What I pointed out was that it's a
> trade-off. If we do call security hooks under the namespace semaphore or
> mount lock than anything that's called under there must take care to not
> cause deadlocks - which is especially easy to do with mount lock and
> even with the namespace semaphore it may get hairy (automounts etc). The
> dos thing is another worry but if an LSM does stupid things we tell it
> to not do stupid things and to go away.
>
> But as the hooks are done right now they are meaningless from a security
> perspective. You might have a policy that allows mounting on dentry_a
> and deny mounting on dentry_b: before LOCK_MOUNT*() you may see dentry_a
> and allow the mount but after LOCK_MOUNT*() someone raced you and shoved
> a dentry_b mount onto dentry_b and now you allow overmounting dentry_b
> which your policy didn't allow -> hosed.

So the direction here is to move security_mount_bind() after
LOCK_MOUNT(mp, path)? This should be easy to fix.

> > > Placement of this hook suffers from the same issue as the bind mount
> > > hook. Here it's worse because the security layer isn't even informed
> > > about MOVE_MOUNT_BENEATH which completely alters the mount relationsh=
ip.
> >
> > Current hook security_move_mount doesn't handle
> > MOVE_MOUNT_BENEATH. But we can add mflags to security_mount_move().
> > Do we need anything other than mflags?
>
> I think you either need to pass three mounts (source, target, top_mnt)
> where for non-mount beneath target =3D=3D top_mnt or you need two separat=
e
> hooks. Because for MOVE_MOUNT_BENEATH you may want to have a tri-part
> policy: source, target, top_mnt.

One hook with (source, target, top_mnt) seems easier here. But let me take =
a
closer look at this.

Thanks,
Song
