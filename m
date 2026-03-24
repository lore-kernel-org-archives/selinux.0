Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C9834D4FD
	for <selinux@vger.kernel.org>; Tue, 24 Mar 2026 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338389; cv=none; b=Al3/3NFmwsb5nkZ9eMeqx9SapfGp4WP0aWDvMxxZxE7ficEzpyVPeiBqcjtPfEiMfvfXZc60wFMWWl0eUw2UTCrKn+D1Ztx6XV4ieba4V4dgH7kTKBWfmmVtdo5nnYiSwsvtYN5RuxzpTi5ay1vCF6teL2MTU5anLkIqho7dSJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338389; c=relaxed/simple;
	bh=iUlva4BooMrpubtin+0WCDkkfD2Hd/2XLRbG6sh91Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snGiocmVYEI7Yxv+1hfA878baB7fgMQCrbXJXL8bCfkxkNXguZBDeC6+VG06DjC6Bm2d/s9F9eGkkZM3Zld486NJYFhh9nS4+6vxT0Wj37unsceXYILY+A9TO/5ERpWoD9lNUk1NzK7V3/kZek60JbpBklogndpoAy7asQTZ29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXoM6wJ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXoM6wJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B8FC19424
	for <selinux@vger.kernel.org>; Tue, 24 Mar 2026 07:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774338389;
	bh=iUlva4BooMrpubtin+0WCDkkfD2Hd/2XLRbG6sh91Hg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qXoM6wJ5SDtfpCKAvrg9IZpbtOqD3HNlC9cqFQS6LEvBNqLd4z5OoT4VW6Oso3pGj
	 xIs/YdvIflXOhTd/TEB+BzFK8o9NvwAbrSWYoqPGtVdutPM3+M4gLPyJ/8C89pyoXj
	 3UMuYsFdBq3ldk2b3zBECxIDnO04UYOQ4grFh1/SbUWyxvDmJbGlpnbn7sFDhVDJPv
	 D2kbnK2AZwlrwO01ZyABF7sFRdgFATI9Ekn+lkAuySzso+vv7j3/m6lzTAFE1NUxi/
	 YCSX8Cg4gZx9DsWPXi6dJZ7dtvW8/FHacDamwaI3fvzefVEVYn5Y1FJ+YTBCR1ZGJL
	 gbEzAIRttKLTg==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899eabc5292so50309626d6.0
        for <selinux@vger.kernel.org>; Tue, 24 Mar 2026 00:46:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/CKI15ykmW7o4icM7Q603jnNrL72dwb9u3wBh1DfD3CQzYxEYQTkRlh5VZtTABx1goy2LU1/a@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54C7bWfbv2tmGhOhmJyZ789j4xH+1T6Cy7O3F30dp49Qlzb91
	5HLz2IPcvjJ45/KoCy9GKAgu764K1iOFdmKiNyqPM1959fzcqkHcjIBg21eaQrIVsH9mX1O4yTF
	fYFbsdwf/nOjEhiTjRVEKbcv8B7OY7Z8=
X-Received: by 2002:a05:6214:5906:b0:89c:505e:a96d with SMTP id
 6a1803df08f44-89c859cbdeemr239575626d6.3.1774338388149; Tue, 24 Mar 2026
 00:46:28 -0700 (PDT)
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
Date: Tue, 24 Mar 2026 00:46:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4G7vo-JZqenZ-sFHw9z02wZUJa1-+9U81U--vQhnfG_Q@mail.gmail.com>
X-Gm-Features: AaiRm506A2zyXhnXAmb2ykNyYlK8IVmugvF-QlKi507zb4QISjJyjO9IU61QDFw
Message-ID: <CAPhsuW4G7vo-JZqenZ-sFHw9z02wZUJa1-+9U81U--vQhnfG_Q@mail.gmail.com>
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

On Mon, Mar 23, 2026 at 11:12=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2026/03/24 4:31, Song Liu wrote:
> >> Then, how can LSM modules know that how the requested filesystem resol=
ves
> >> the dev_name argument, without embedding filesystem specific resolutio=
n
> >> logic into individual LSM module?
> >
> > IIUC, if an LSM cares about the dev_name of a new mount, it will have t=
o look
> > into each individual filesystem. We can add a LSM hook for the filesyst=
ems to
> > call. But this will require changes to individual filesystem code. OTOH=
,
> > dev_name can probably bridge the gap as we change filesystems.
> >
> > Would this work?
>
> I guess something like untested diff shown below would work.

I think this doesn't work with erofs on file (requires
CONFIG_EROFS_FS_BACKED_BY_FILE). erofs may not be the
only one that has this problem.

Thanks,
Song

>
>  block/bdev.c               |   26 ++++++++++++++------------
>  fs/fs_context.c            |    4 ++++
>  fs/namespace.c             |   10 ++++++----
>  fs/super.c                 |    2 +-
>  include/linux/blkdev.h     |   12 +++++++++++-
>  include/linux/fs_context.h |    1 +
>  security/tomoyo/mount.c    |   26 ++------------------------
>  security/tomoyo/tomoyo.c   |    2 +-
>  8 files changed, 40 insertions(+), 43 deletions(-)
