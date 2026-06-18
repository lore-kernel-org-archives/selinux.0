Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE03EFFD5
	for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780219; cv=none; b=p2fAGAsbmb2Q8n13KygivKBG53fkhrWfxnC2PnGeOGWYtXuantj9SF5rR74g58InZEypy9ALjxGkGOKekDdCfswr+3OYTZvO4yxbxnh+/NcjXq7QPzkTkfx/H27rhIDKj6RwFLTShI7NWg5ekbuDFkgKWTiJwQwQp9XK0qz4Sfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780219; c=relaxed/simple;
	bh=qQdotgGscA6opjcuxC4Up5QVUCY1vyFuwJmwatHokyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It83Z+j3RVpEZ58sobanI/PW1YwY86gCfyeDnJiIjiSx2n+UZkqBWU81gynDvU+XLXNFB/GyKegc/QB3wmiZFe+tOacYWr5AukXpRSkE22m12IaFd/X4Ni1/czZvNV8VMOgE08anY6OU9Z8rkVXvDuST++xdTTBCIK1Dq9qknZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KausSAjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KausSAjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCE51F00A3E
	for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 10:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781780216;
	bh=2E/2JIqLB4ksBgWPBo43Ny8WcobpWESfD8u96j+vkuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KausSAjq/gG/n4m9EVaAp11Z/mDN7wDR+FlCTHVF+V5rcL+dtACUywY0Co3uZzKg+
	 gLB9yfTtjkk5Gjz7Vkd5/SCS7wcwcyLuvZhVopSVRyJXWhsfrC6CM8sxLv5+f106ng
	 qDcociUXofs++ILwCnPwIVADpqAw+6lJrvBDr/qjDgF7PiIrOK97mESwUmy3uUPDB6
	 PgDkPCK/89iv/LEEkQIy2W0LyH72Vvr7dggW4d0BT4kKxRWTD0f2dGSTJJpN3yG0kO
	 4GD+XQZadeP3ucXBc0yzdFeHVlvsaBFDMsP1C9gcr33kyC8dOzhrcgXV6VrLC65bR3
	 wm8hwJD1A7AjQ==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-91587626a3eso101236885a.2
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 03:56:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9IGYHpFmbhIPPprF04lNB4GGxalkhZugXT3j9EdNvFiOtat9gqNIc68nlvezDztSfRxG8oVhKy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jvWjf9gCr57jx1d0PgzklEzUcPADRV6dgoTw9tKAHqf6SDEa
	nWbQUOUnxPyPNrEg8t6mxnj54FqqIt2NT4gmYxLxEeBEPloAxBXn00lZrz4ZaknD2K/wtohULVL
	NJjSOoluLqoaLLl1ZNg+c1RUPUqZfuxU=
X-Received: by 2002:a05:620a:1a12:b0:914:cf92:46fb with SMTP id
 af79cd13be357-91dbc52c23cmr1206914385a.32.1781780215358; Thu, 18 Jun 2026
 03:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528182607.3150386-1-song@kernel.org> <20260528182607.3150386-8-song@kernel.org>
 <20260617-laufbahn-eifrig-charmant-a48f357a0c52@brauner>
In-Reply-To: <20260617-laufbahn-eifrig-charmant-a48f357a0c52@brauner>
From: Song Liu <song@kernel.org>
Date: Thu, 18 Jun 2026 18:56:42 +0800
X-Gmail-Original-Message-ID: <CAPhsuW7Wn8GYrsrRhEFXQH5buaP+pdTKc0UV8Mn0B3OnNN-44g@mail.gmail.com>
X-Gm-Features: AVVi8CdMwwBeVWKbgimKMTZIhDQrcn_xHhSmY9XN-Dvu7Mu1bTcCjMCtFLlmpHo
Message-ID: <CAPhsuW7Wn8GYrsrRhEFXQH5buaP+pdTKc0UV8Mn0B3OnNN-44g@mail.gmail.com>
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

On Wed, Jun 17, 2026 at 9:53=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, May 28, 2026 at 11:26:06AM -0700, Song Liu wrote:
[...]
> >
> > +     err =3D security_mount_bind(&old_path, path, recurse);
> > +     if (err)
> > +             return err;
>
> This again is racy as it is called outside of the namespace semaphore:
>
>         err =3D security_mount_bind(&old_path, path, recurse);
>         if (err)
>                 return err;
>
>         if (mnt_ns_loop(old_path.dentry))
>                 return -EINVAL;
>
>         LOCK_MOUNT(mp, path);
>         if (IS_ERR(mp.parent))
>                 return PTR_ERR(mp.parent);
>
> After LOCK_MOUNT @path might point to a completely different mount then
> the one you performed your security checks on.

I thought we agreed at LSF/MM/BPF 2026 to add the LSM hooks
before taking namespace semaphore, so that it is possible for LSMs
to defend against DoS attacks on namespace semaphore? Did I
miss/misunderstand something?

> > +
> >       if (mnt_ns_loop(old_path.dentry))
> >               return -EINVAL;
> >
[...]
> >
> >       err =3D parse_monolithic_mount_data(fc, data);
> > +     if (!err)
> > +             err =3D security_mount_remount(fc, path, mnt_flags, flags=
,
> > +                                         data);
> >       if (!err) {
> >               down_write(&sb->s_umount);
> >               err =3D -EPERM;
> > @@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct path *=
path, const char *old_name)
> >       if (err)
> >               return err;
> >
> > +     err =3D security_mount_move(&old_path, path);
> > +     if (err)
> > +             return err;
>
> Placement of this hook suffers from the same issue as the bind mount
> hook. Here it's worse because the security layer isn't even informed
> about MOVE_MOUNT_BENEATH which completely alters the mount relationship.

Current hook security_move_mount doesn't handle
MOVE_MOUNT_BENEATH. But we can add mflags to security_mount_move().
Do we need anything other than mflags?

Thanks,
Song
