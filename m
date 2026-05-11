Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531A3B7B7A
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533616; cv=none; b=lPnmUWL7Ne/LOPxOEiaKwxhEo27OAGx6dgy10oBvRfUOXeLYjA76I9AWFL7NavjFg/Ilrd+1JOFmWiuYZzuzdIHvllvW1kokESx7wKSDwFn+35ATLtyjIIGjg+yWalY0t57OsyAvOM5dLZZZtmRQW3UM8YrG2/cqvUKmoq7DySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533616; c=relaxed/simple;
	bh=Vhk6YYwPEmJxuRm5pxOHa9xAnh8YRHsA1LM0oPK12V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSSYpLC67iAGb1Z0IsToS1ZmuXfd6YdxAU2EHbJ7Qb+N3+JJt4k5Zkf8ueL82QOEy5O1V9wbbjvPrp9YPE6p1uHopKXiinvV6twEHF/o7dYkaf4ZUzF0YAUTIN2CxhnmQe67+2ld8px2A9MgE1Gx0x1hnfPhg+wyqWuU4ydMaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3i74jbT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3i74jbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1A6C2BCFF
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 21:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778533616;
	bh=Vhk6YYwPEmJxuRm5pxOHa9xAnh8YRHsA1LM0oPK12V4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i3i74jbTMB0TTyQ6dyczHPKD/1xlrC/ylIEq/9ZaehQsFB22ZuXrjVHHTW3NI6zef
	 AdO0EUU5R2QrsDeYQxxZ43qt4hYcioBIH7Z9TBnP7oDv2d0/HacEbbuaabBDiinucG
	 TdjP4RngoMCowIP7hlISfLW2Z1ySyyDzltmB9hpfrpdpbULh3Br7bLUaenM1P9nuPT
	 zlI8rBcsUg9Kyy1SFZgA2mqCBoBy7nE6qzCaA/nTxvr0cGJGN78Z8tuUR2rbGUAD7j
	 fsUlRRK84eiNJ1sjpYQ/bzvyO33bbiL9ChnnCgJYx299jb13zrHWq4B7z+zWp8SyEp
	 YsAzMLAfr9Bnw==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d7e7f48499so521288085a.1
        for <selinux@vger.kernel.org>; Mon, 11 May 2026 14:06:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+hY/szKbVVHYTJl5o5YhVhQ0tskPuUH6/GpAQqAmZVjek12cakHucB6XkB3zBwm1URe+LFQhn3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+JC0n8eJS8PYOd9BRu8zquWIfZWYNh8b9JLJf91ID3S9WLf3
	v6NcJOuI6ubOyMb7uDbxTpQucafaE/DvDq9uXFTxAjCeP06Qnb7MxDAk7WTcpbDF7J3w/xp+Tae
	lwVcicTXlgkqUIhJHPKhjYVbe4t5fNgA=
X-Received: by 2002:a05:622a:588e:b0:509:1b76:e9b2 with SMTP id
 d75a77b69052e-514621e4ceamr367968911cf.55.1778533615092; Mon, 11 May 2026
 14:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509015208.3853132-8-song@kernel.org> <37ceb04c4c37370a2359f73a24b9c07b@paul-moore.com>
In-Reply-To: <37ceb04c4c37370a2359f73a24b9c07b@paul-moore.com>
From: Song Liu <song@kernel.org>
Date: Mon, 11 May 2026 14:06:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4=oP5OGY3c9H1Ctp-Nq_o9O8f8dJc3Ox_MBkqur04vDw@mail.gmail.com>
X-Gm-Features: AVHnY4KL21_s0gqGE1PGALd_1tRQ5STcRZqygN-IW3-LqKvndAAGqAiFc8IsSho
Message-ID: <CAPhsuW4=oP5OGY3c9H1Ctp-Nq_o9O8f8dJc3Ox_MBkqur04vDw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] lsm: Remove security_sb_mount and security_move_mount
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

On Mon, May 11, 2026 at 12:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
[...]
> >
> > -     LSM_HOOK_INIT(move_mount, selinux_move_mount),
>
> This should be in patch 4/7 when you convert SELinux.

Good points. I applied these changes to my local v4. I will wait a bit
longer before sending v4, though.

Thanks,
Song


> >       LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security)=
,
> >       LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files=
_as),
> >
> > --
> > 2.53.0-Meta
>
> --
> paul-moore.com
