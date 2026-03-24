Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B131986C
	for <selinux@vger.kernel.org>; Tue, 24 Mar 2026 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378996; cv=none; b=SUYtrE94P3seRXyVjtCI9bOFvIXXyl6IGUCiIoaAvFV7mrTxslE2sADAk75nE3jfff1N/q6A0qR8rIJP24GNWWoKUGOUO/rkVhSjoJK04HwuITefZlW1U5uX5Rcq3t44UNn70uop9aC0IQHhI/72TcTddCzoCTVMhd34U6Soc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378996; c=relaxed/simple;
	bh=8ERkArUkKAJMAJlGeP18u5PgNVycSZvsdsG8KYtB5t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXOO76C6btUVyT87IJbHOQ0ik8M4vppAB8Mktrr5QKxHKEUjHgT2Pj/qdq2aAxQjSY9CvA4zoskvBjOixeyhQA0SJ6TODL+0/Y9ZBAMmdbogYN24dSp9HP0COyP6qkm/t3AUxzyU4zJjDnXCFJTcjL7zyoE+Fev8k91XF1iyopk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trXb3kjA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trXb3kjA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B4FC2BCC6
	for <selinux@vger.kernel.org>; Tue, 24 Mar 2026 19:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774378995;
	bh=8ERkArUkKAJMAJlGeP18u5PgNVycSZvsdsG8KYtB5t8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=trXb3kjAHLI67smIXDwwAf48RXbt+0nCdIkpi3H788qXY723neQjh0YgPKFYvJIm1
	 8m+Qi0x7+ZYZ+j8uHWv4Pwuj41UI1OoGGOlXzac/EtNVqCbwDBg2TenOBSN0CjUzUW
	 uRfCFut55vMk8wAEa2+r10jCxNCx/Ph/T3GpC26ah0s7U6N8q3g6elCfMTC/GqVFGE
	 Hx5LEbi55a865esBlPBGVQDuhVy6wBi+4U9S3OkvLpCjRc2CpYLkPEqcnbUFWklkze
	 CYKsXLgE5pkjR09Y1ziWls4GwsBm0SI6nANr2jkkwCHe8fArJRHbqhEgXzpqA8V7Lk
	 zQfjKx2T2QbkQ==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfc5941028so627614885a.1
        for <selinux@vger.kernel.org>; Tue, 24 Mar 2026 12:03:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkIX5sVGMU9ed0iYcE2jD9frPKcE5bYV/2vGFDXaRX4YHKd/Ro9zg5KqVMepE2POJ2CiW3sWYZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8ODaQ0W+D39LqP+nxYasiA21BjCcpFnnoF8N2sZSF2hxqNWE
	qyzm6j/0ekcSAPY5rjfpVsKPc+xHa/s/MiMh6dKSuOsqYv0a8Vp9R9R9I7K7E8vdaEtUIaD0DdX
	CFXPUYuI8vpFfeEgnl84kNKzMTS1KItw=
X-Received: by 2002:a05:6214:1316:b0:89c:5b90:3d7e with SMTP id
 6a1803df08f44-89cc4ad7e94mr14077846d6.36.1774378994278; Tue, 24 Mar 2026
 12:03:14 -0700 (PDT)
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
 <CAPhsuW4G7vo-JZqenZ-sFHw9z02wZUJa1-+9U81U--vQhnfG_Q@mail.gmail.com> <6c298238-8d87-4c41-84a7-e0373d466a15@I-love.SAKURA.ne.jp>
In-Reply-To: <6c298238-8d87-4c41-84a7-e0373d466a15@I-love.SAKURA.ne.jp>
From: Song Liu <song@kernel.org>
Date: Tue, 24 Mar 2026 12:03:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4E_BrF0ap5yg_6TbRAna=2Ajk2nuoT6WGwkS5cyyYB3w@mail.gmail.com>
X-Gm-Features: AaiRm53BtyNmgu2U1A-lRqlHK3FKxeh66Hvb786qvSu1X2siuc6pnMMByLeZto4
Message-ID: <CAPhsuW4E_BrF0ap5yg_6TbRAna=2Ajk2nuoT6WGwkS5cyyYB3w@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 2:59=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2026/03/24 16:46, Song Liu wrote:
> > On Mon, Mar 23, 2026 at 11:12=E2=80=AFPM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> On 2026/03/24 4:31, Song Liu wrote:
> >>>> Then, how can LSM modules know that how the requested filesystem res=
olves
> >>>> the dev_name argument, without embedding filesystem specific resolut=
ion
> >>>> logic into individual LSM module?
> >>>
> >>> IIUC, if an LSM cares about the dev_name of a new mount, it will have=
 to look
> >>> into each individual filesystem. We can add a LSM hook for the filesy=
stems to
> >>> call. But this will require changes to individual filesystem code. OT=
OH,
> >>> dev_name can probably bridge the gap as we change filesystems.
> >>>
> >>> Would this work?
> >>
> >> I guess something like untested diff shown below would work.
> >
> > I think this doesn't work with erofs on file (requires
> > CONFIG_EROFS_FS_BACKED_BY_FILE). erofs may not be the
> > only one that has this problem.
>
> This is incomplete but I think this is better than now because currently
> mount() operation likely fails with -ENOENT if the requested filesystem
> does not interpret fc->source as a pathname despite tomoyo_mount_acl()
> always interprets fc->source as a pathname when FS_REQUIRES_DEV is set.

If I understand Christian correctly, the main challenge here is that
FS_REQUIRES_DEV doesn't imply fc->source is the path of a device.
Changing this assumption is a major change between VFS and many
filesystems.

I was thinking about something like:

diff --git i/fs/super.c w/fs/super.c
index 378e81efe643..91ce3003bc23 100644
--- i/fs/super.c
+++ w/fs/super.c
@@ -1676,6 +1676,9 @@ int get_tree_bdev_flags(struct fs_context *fc,
                        errorf(fc, "%s: Can't lookup blockdev", fc->source)=
;
                return error;
        }
+       error =3D security_mount_dev(fc, dev);
+       if (error)
+               return error;
        fc->sb_flags |=3D SB_NOSEC;
        s =3D sget_dev(fc, dev);
        if (IS_ERR(s))

This allows the LSMs to monitor the dev being mounted in a new mount.
If a filesystem doesn't use get_tree_bdev*(), we will need something else
to cover this specific filesystem. I am not sure whether this is acceptable
for VFS and LSM, specifically tomoyo and apparmor.

Also, before we go too deep into the hook for new mounts, can we focus
on this set, which will fix some existing TOCTOU issues?

Thanks,
Song
