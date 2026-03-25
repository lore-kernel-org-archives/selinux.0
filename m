Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3A239E6C
	for <selinux@vger.kernel.org>; Wed, 25 Mar 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402535; cv=none; b=AeC+FMDADKAiLi48bf5QGMC1W3T3ruLi8yGVXJj4tHJxaaFp9d4Fv3jbxnYYo1zt12lZF0jOoy0sqDeFi1uzVrMtlCGomu2RGFq9yCbAzx6fFPaURkivHIyDk7OF+cZCYJy/+3J1ur+ETEMLYZcT77Kyy9Qn6b92eZt+eOWrTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402535; c=relaxed/simple;
	bh=4xDuZMlV9e8lExmR4AbKxuLD7XwJlcqYoE+mf8VIJIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMzMurNX5wIjoNRIGNcORxK5QcKjPbuIbvzKZQmbxiNjUF/UmEuLPhOEngv2ZdUOEy0v24pLf033Nt6KFPQBk0aTMv3TdPzI5wuuPwMG050YW0hNuKw4tv4Rtzju5/tCLkHQMzDkbcGgM8TCNPlmsos1Flo/GebUTUH/CVXHovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPT6VNEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPT6VNEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F8BC2BCB6
	for <selinux@vger.kernel.org>; Wed, 25 Mar 2026 01:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774402534;
	bh=4xDuZMlV9e8lExmR4AbKxuLD7XwJlcqYoE+mf8VIJIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OPT6VNEgSp49B7SzieME+r0RdMr6DcX3TBWBxOMq4nctzJS1QhSaWpvD81GchzZpH
	 VO8xodud0fb50cOsaSgghn4TsiGpX6cDRGo6dlXtVFQSOQr1TmaQEmJ52VTeDyG+lB
	 tryrRhj1Ma3YjpdJFcsVRphMcTYVx1Tgh71yGkL4CIbjsfpf9TLCsBWP3sd2Qbwfhy
	 s0KM6NYQlENSCHdHKpy+rO62f5mDqNvl8gDpFFkzqfGC+WuLI+jXS8nwX3/zrZt8DA
	 SWZ+ZZKWADTYMMZQ/3AF+cCtwRmin9qZhfwj/jm/t0o1ON+49TOhdIvbi+rQAfoyBd
	 7l3zkLCWWoCjA==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899e87b04d8so65359986d6.3
        for <selinux@vger.kernel.org>; Tue, 24 Mar 2026 18:35:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXv2TQ9ViqKYHn1BC37bWZUQ3fwZ3aY+jRjCaoppKHgaIkLJCt3OgveVvMmVxTu3sK1Rgi5wn/R@vger.kernel.org
X-Gm-Message-State: AOJu0YyokzLeq4Chqo2fHkby/IFANsBHXZ04b8/nXCW9d6upDdYZZDya
	Y8VIBYpC7MrKx8vfQVI9N8Bdc8DcoUWYBH0CHkgZd+3qmIIgueQRPwecgz9Hzuh6bMp127lT7MO
	9+eSvEWOdcIsEu0wE+V0pmAvvee3W+aU=
X-Received: by 2002:a05:6214:1245:b0:89a:b7:9a9b with SMTP id
 6a1803df08f44-89cc4b5569cmr31645146d6.58.1774402533738; Tue, 24 Mar 2026
 18:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <20260318184400.3502908-7-song@kernel.org>
 <b720f521-e930-4f35-9505-1bfdf9e2818c@I-love.SAKURA.ne.jp>
 <4DF5C4A8-7C92-4F76-9B34-2262089E7289@meta.com> <33abcf34-13e2-4a37-83f3-78bb27ecbc11@I-love.SAKURA.ne.jp>
 <F0A0D13E-8208-49A4-9AC6-89AC4BF3F4FB@meta.com> <20260323-klappen-atemschutz-7a0af8c6b087@brauner>
 <714a614b-cfb4-4b20-af8c-df3cc56dfb92@I-love.SAKURA.ne.jp>
 <CAAeYb7k+TWArOKyOomkLZ8fwqUPjha9iORpJaj4nMyN=o4ZRQg@mail.gmail.com>
 <6609e11e-90aa-4021-974e-e9937688dd49@I-love.SAKURA.ne.jp>
 <CAPhsuW4G7vo-JZqenZ-sFHw9z02wZUJa1-+9U81U--vQhnfG_Q@mail.gmail.com>
 <6c298238-8d87-4c41-84a7-e0373d466a15@I-love.SAKURA.ne.jp>
 <CAPhsuW4E_BrF0ap5yg_6TbRAna=2Ajk2nuoT6WGwkS5cyyYB3w@mail.gmail.com> <4f5d1b1f-ecb2-421a-8a46-36c7a12d48de@I-love.SAKURA.ne.jp>
In-Reply-To: <4f5d1b1f-ecb2-421a-8a46-36c7a12d48de@I-love.SAKURA.ne.jp>
From: Song Liu <song@kernel.org>
Date: Tue, 24 Mar 2026 18:35:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7+EMzgCHAVm3XiVy1A7+EVQPxqi0hBqbq5ZsKeAWaXJw@mail.gmail.com>
X-Gm-Features: AaiRm530ufNvd5819opx61Zyxwl96gRjG09W7nRQkfMrynp8a4TROET-huwTlyg
Message-ID: <CAPhsuW7+EMzgCHAVm3XiVy1A7+EVQPxqi0hBqbq5ZsKeAWaXJw@mail.gmail.com>
Subject: Re: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Song Liu <songliubraving@meta.com>, Christian Brauner <brauner@kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "paul@paul-moore.com" <paul@paul-moore.com>, 
	"jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>, "jack@suse.cz" <jack@suse.cz>, 
	"john.johansen@canonical.com" <john.johansen@canonical.com>, 
	"stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>, 
	"omosnace@redhat.com" <omosnace@redhat.com>, "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>, "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>, 
	"herton@canonical.com" <herton@canonical.com>, Kernel Team <kernel-team@meta.com>, 
	"selinux@vger.kernel.org" <selinux@vger.kernel.org>, 
	"apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 6:02=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
[...]
> >>>> I guess something like untested diff shown below would work.
> >>>
> >>> I think this doesn't work with erofs on file (requires
> >>> CONFIG_EROFS_FS_BACKED_BY_FILE). erofs may not be the
> >>> only one that has this problem.
> >>
> >> This is incomplete but I think this is better than now because current=
ly
> >> mount() operation likely fails with -ENOENT if the requested filesyste=
m
> >> does not interpret fc->source as a pathname despite tomoyo_mount_acl()
> >> always interprets fc->source as a pathname when FS_REQUIRES_DEV is set=
.
> >
> > If I understand Christian correctly, the main challenge here is that
> > FS_REQUIRES_DEV doesn't imply fc->source is the path of a device.
>
> Correct. FS_REQUIRES_DEV no longer implies that fc->source is a pathname.
>
> > Changing this assumption is a major change between VFS and many
> > filesystems.
>
> Wrong. I'm not trying to change this assumption. I'm trying to move LSM h=
ook
> to a location after fc->source was interpreted by individual filesystem.

OK, I can understand your point now. And I don't see a big red flag with it=
.

> >
> > I was thinking about something like:
> >
> > diff --git i/fs/super.c w/fs/super.c
> > index 378e81efe643..91ce3003bc23 100644
> > --- i/fs/super.c
> > +++ w/fs/super.c
> > @@ -1676,6 +1676,9 @@ int get_tree_bdev_flags(struct fs_context *fc,
> >                         errorf(fc, "%s: Can't lookup blockdev", fc->sou=
rce);
> >                 return error;
> >         }
> > +       error =3D security_mount_dev(fc, dev);
> > +       if (error)
> > +               return error;
> >         fc->sb_flags |=3D SB_NOSEC;
> >         s =3D sget_dev(fc, dev);
> >         if (IS_ERR(s))
> >
> > This allows the LSMs to monitor the dev being mounted in a new mount.
>
> Splitting into multiple LSM hooks does not work, for TOMOYO wants to chec=
k
> all parameters (parameters currently passed to security_mount_new() + the
> "struct path" which was resolved by individual filesystem from fc->source
> parameter) in one location.
>
> I'm not sure how security_mount_new() is called for fsconfig() case.
> Does https://man7.org/linux/man-pages/man2/fsconfig.2.html#EXAMPLES mean
> TOMOYO cannot check all parameters until move_mount() is called?

We need to add hooks for fsopen(), fsconfig(), etc. I have some basic code
for these. But I would rather we address this set first. After this, the ot=
her
hooks should be more straightforward.

Thanks,
Song
