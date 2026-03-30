Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACD5397E96
	for <selinux@vger.kernel.org>; Mon, 30 Mar 2026 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901079; cv=none; b=Bt9bopQuXbYRmc0vBbXRdqLkhwpqwBN5ubnCjS75yWs4yKYr59nOj4Yus0FsvBaqzYKb/NrQML7uMMi4QfGcT5S1RALUOv70IC/EWi1eJriMHDw7ydup0N+2ZYcIDY5VOYTOK/DCweX2koEOh15oL6pCLJX4FmhXW28dE3eZaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901079; c=relaxed/simple;
	bh=1X1yQpwKHXFHDTwoogHV/wsFWF8CFNxD4Jdw11uzolI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUXAExvVYk0iF3ALg0q6RJP3QmIWN2+p0IhFJDAVfltjbghUAKQPrxsDE+AkdEiF1tv9kQLqs6sMbqPRFVQ6eH+MSbqWfx3mcaCXdqzCZIdRFzt0rPVTxK6gp+khjrqI0tiTrsw9OYMngeP2TBonFIcQluXEG453Laylo7yA/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDfKIL10; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDfKIL10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B96C2BCF4
	for <selinux@vger.kernel.org>; Mon, 30 Mar 2026 20:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774901079;
	bh=1X1yQpwKHXFHDTwoogHV/wsFWF8CFNxD4Jdw11uzolI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IDfKIL10p1+7rBp/suyM4lQdQ9SgBcvMG7bQmtXVp1lqia4FLJ2nYQGmv4H6yOLPZ
	 fLnLW7At8v1FFAJqxDlsdrfOmUhgn52Taok0gZ8ZMlpqmxQAlkZ4VWEMa5HQiMHDfn
	 ro4PxhFWpmhbYWxD5w4Ys9mYFEwoXPQNebe5IjMdLbZyFXBUwJrktLCEIXnXb0vsth
	 0IvnJm7848RbA4U96ZBX1BX143qXHezDsBmu7s0pREUSC3LOB/vQ2XtKAdScrrSdIm
	 BTh7FKkOXYhPbP3L9teazTjzxQUoB6hOzDoEzqARuwy8G/LY6f+nbwa+1llwnbfory
	 X4sJlQr6yxwLw==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a093c784b0so19416156d6.3
        for <selinux@vger.kernel.org>; Mon, 30 Mar 2026 13:04:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPA/PE+/g7uWY6VROGuHrzi4H9KxRb/XAa1SZLkaYKkqiShQr9rEDcCnO/zyHopHtLcMLadFfp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx780F5NHzLASTHkmT60rz7DCViqArClYhSrnxXdZkQ439aaAjX
	111Mlp8YtZDR6SmC1FJMRHFHNZIRNsT3w0s1MJ/ACcc2ZvmBUCkHtjEGrGIc3tiJF8q0DaCeRd8
	4zUWnE13Wz90Si+DuI1FBvtNbQxuiak8=
X-Received: by 2002:a05:6214:2128:b0:89a:10d8:f9ca with SMTP id
 6a1803df08f44-89ce8dd0b9emr214870836d6.26.1774901078259; Mon, 30 Mar 2026
 13:04:38 -0700 (PDT)
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
Date: Mon, 30 Mar 2026 13:04:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6FewkhGoNCqJ9p5V4sGmJTC8pJM2BUv8Ekxcft93nuyQ@mail.gmail.com>
X-Gm-Features: AQROBzC66Kh9nC3Ny7eCdzD0vCLOETw0qurKeL6o2A35S67y_YeSqFGNhcnT1NY
Message-ID: <CAPhsuW6FewkhGoNCqJ9p5V4sGmJTC8pJM2BUv8Ekxcft93nuyQ@mail.gmail.com>
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

Hi Tetsuo,

On Tue, Mar 24, 2026 at 6:02=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
[...]
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

After spending some more time on this, I think we should not add
fc->source_path. This is because in many cases, dev_name for a new mount
is not a dev, or a path. For example, I can create a btrfs raid0 volume on =
two
devices, and use either of them as dev_name to mount the volume. It is not
accurate to put the path of either device in fc->source_path.

OTOH, if a LSM really wants to monitor the devices used by this mount,
security_sb_kern_mount() is a better hook to use. This will require the
LSM understands s_fs_info for specific file systems, which is not easy but
necessary.

For now, I think it makes sense to keep security_mount_new() in this set
as-is, and let LSMs like tomoyo and apparmor call kern_path when
necessary.

Thanks,
Song
