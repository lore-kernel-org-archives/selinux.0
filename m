Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC915E55A
	for <selinux@vger.kernel.org>; Fri, 27 Mar 2026 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774572061; cv=none; b=avokBeVemFv97D9wx/uJEtN5fFmYwEyNmdH1qAz0p7zcs1+Doskljbg5Ae11MJPprYyqqhISaqFDhOqGe9TviMF8xEi9XT3zhCyb/S2QOFjw4u1IlGzyx7KWyJdc1y/kfihpthB0CjgJBAAhHLyQZhJaKLuhI+cycCzv8ZOS8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774572061; c=relaxed/simple;
	bh=vt7T/qUGOGLlqaNchVHzH7ZNkaAHnV/vULH5YOrsQpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofoTDr4n1TDZQYF+wfc5b0SQsFAp6K6egNLLEFg85lGAh7zI5a0nui792+DeIKh9xq6U+j6Q4r+I2HbBoWJCEGjvwjuvam2UwA47VN+tg4UqSPFQuucY/995lfFCx2X3SQbXKY2x9gwKfO3HovSogF21bMdIxrfrF141Z49phPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwQe+H24; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwQe+H24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878E7C116C6
	for <selinux@vger.kernel.org>; Fri, 27 Mar 2026 00:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774572061;
	bh=vt7T/qUGOGLlqaNchVHzH7ZNkaAHnV/vULH5YOrsQpM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RwQe+H24wpJs63oazuy6TuUNOuF2BjCXU/yfjRKeh++eEwS0at4Lvb8j79sHrpkpm
	 dA6moXoBljhfGWmtVN+lqV8oQ1LEfCVys/pV5Bx5hjE8LBehBDflEkggtG63v1Kwug
	 VncZhlxUAwK/3hTzlhWRzpfiLGjD9hGll5xRkrE/lTenAIXxuCHp7ek9OU5Bq8bJ/C
	 ciUcTKl9B4NtkXEMEbw7p6fsTmUbY9Pp54U51JPiYJJ4+pL8J9osKnXg1imB8bwrqG
	 MxBZFpGvt/u/vysUjaG794KzVBAmazVAXWbuE6t5vL1FZ8/KfRQWoVvondIaaPbn27
	 WlPl4szD3hdHA==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899ee87355dso18855836d6.1
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2026 17:41:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2QFgir1QA1VrMFDaPIxh/w1b1CRwT+oX9J7//ZwL2lk3T8HSABhYTDmzbHUQuhKTWM+5F7Ixm@vger.kernel.org
X-Gm-Message-State: AOJu0YyzSR0KiLoVh4zR4F/F+2pz78nl9J12nMulUmneT9HjvojEJnyA
	sDNrE9A+7eooikSV66eIhN7MT/wHfbr4o0xkLaCnGLICaocTatJeVzAH2zO2/36TSwdHgJaib/6
	8Oro341h1WiHGMEoJ0hX1YkE8ifTdlRI=
X-Received: by 2002:ad4:5cc7:0:b0:89c:99f5:52c4 with SMTP id
 6a1803df08f44-89ce8d43382mr7198476d6.15.1774572060621; Thu, 26 Mar 2026
 17:41:00 -0700 (PDT)
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
 <CAAeYb7k+TWArOKyOomkLZ8fwqUPjha9iORpJaj4nMyN=o4ZRQg@mail.gmail.com> <6609e11e-90aa-4021-974e-e9937688dd49@I-love.SAKURA.ne.jp>
In-Reply-To: <6609e11e-90aa-4021-974e-e9937688dd49@I-love.SAKURA.ne.jp>
From: Song Liu <song@kernel.org>
Date: Thu, 26 Mar 2026 17:40:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5PyqkkAbLr9JZKtJ7F0sys3pENdSOQqG=dggbrEf11iA@mail.gmail.com>
X-Gm-Features: AQROBzDUWLVisdSlnIPADASIVeAPQUaRFecDIf-Shx_lh3e_Wu7aKFzg04hWSF8
Message-ID: <CAPhsuW5PyqkkAbLr9JZKtJ7F0sys3pENdSOQqG=dggbrEf11iA@mail.gmail.com>
Subject: Re: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Christian Brauner <brauner@kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: Song Liu <songliubraving@meta.com>, "paul@paul-moore.com" <paul@paul-moore.com>, 
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

Hi Christian and Al,

On Mon, Mar 23, 2026 at 11:12=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
[...]
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ba5baccdde67..621b8205a0af 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3777,7 +3777,7 @@ static bool mount_too_revealing(const struct super_=
block *sb, int *new_mnt_flags
>   * be added to the namespace tree.
>   */
>  static int do_new_mount_fc(struct fs_context *fc, const struct path *mou=
ntpoint,
> -                          unsigned int mnt_flags)
> +                          unsigned int mnt_flags, void *data, unsigned l=
ong flags)
>  {
>         struct super_block *sb;
>         struct vfsmount *mnt __free(mntput) =3D fc_mount(fc);
> @@ -3786,6 +3786,10 @@ static int do_new_mount_fc(struct fs_context *fc, =
const struct path *mountpoint,
>         if (IS_ERR(mnt))
>                 return PTR_ERR(mnt);
>
> +       error =3D security_mount_new(fc, mountpoint, mnt_flags, flags, da=
ta);
> +       if (error)
> +               return error;
> +
>         sb =3D fc->root->d_sb;
>         error =3D security_sb_kern_mount(sb);
>         if (unlikely(error))
> @@ -3857,9 +3861,7 @@ static int do_new_mount(const struct path *path, co=
nst char *fstype,
>                 err =3D -EPERM;
>
>         if (!err)
> -               err =3D security_mount_new(fc, path, mnt_flags, flags, da=
ta);
> -       if (!err)
> -               err =3D do_new_mount_fc(fc, path, mnt_flags);
> +               err =3D do_new_mount_fc(fc, path, mnt_flags, data, flags)=
;
>
>         put_fs_context(fc);
>         return err;

Could you please comment on Tetsuo's proposal here? The core
change (moving security_mount_new after fc_mount) makes sense
to me. However, it seems to require a lot of code to support this
change.

Given the current patchset addresses TOCTOU issues of bind
mount, etc. Maybe we can land this set and address TOCTOU
issue with new mount in follow-up patches?

Thanks,
Song
