Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A43EDE61
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609255; cv=none; b=hz3ZXyVT19TL5cu0MIPmvbH4+Ot4SDcd/pDiuLiEHeOTWAeWviRYrQSy8Si25kj8eUB4H2vW7259rpX6zpPa8dlqbtPeFK66GTULNFU70luXMLe9pwfgIlB6Lfdg2ECAzLWijLLqO+dByaWbYHq+U7fH9ftEFUbP+00OihLJeBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609255; c=relaxed/simple;
	bh=1+WG2MzbBw4FYQ+ZqlnfYUFJjE67o+yVompxx5/7iXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0z/2Y8TKmQ9MguCZjRwxX+/9IFIqCipZ/ckspfOXKH/R8YTUhEio5Ec7TQnV0QScfq8DxOjGpALwosc+EfMsCuD5gdD1fEdAIkSFRKSF7m+W4EJLYRo5xsAONGmQamDsrp62cJcJyfygkb6+z3gXJ9+KmwRCgoQ5pRFzAMz4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5T962cI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5T962cI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92C8C2BCF6
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609254;
	bh=1+WG2MzbBw4FYQ+ZqlnfYUFJjE67o+yVompxx5/7iXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H5T962cIa5YQAKbg2JMJpLHLXX0LIX4A/vsslTENuD40PviRXPDpCD1h2FG+Hc6h+
	 ClBj2aow5t3Uz0i6CoiVlmus+bX6E2j8L55/02Ho4CAzSRDsR9z3zam3QD8j9XBq9x
	 6Cr2zmoVJJJnhuC39AvIcDA6m66GNbMaPUaPmTfCagciAIFFlCgAA/0/ejUM8hmait
	 qWrXjjl0lS9+RJRtLVYic1P3T8/1bk28oBEapxMvuwuT27xzXSkpFWvr79YkCFqSAV
	 laF9tsuPrMN2TCCBLlDSJVWJKUh7ZEQa5GnDO0Nczt9ZME1RGNwWOkqpRopB4mEpnZ
	 CHtihsKXtf6jg==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso91847676d6.3
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 11:07:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/muRgWw1pQ8Fmhdc8bu/38p+HX/wVtAVwtRHgtRV9/N5Jm/KT7MOu/m5jwp0BPfBpFMeyfrm9Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxaDTYe5ko8ZcnoNJPAD759+KmkyBABwXNWghgFnPkKFePJrEey
	oSRwLWZ1n8Fj4QetxN3QUXeIiZerkdAhaFXmwwCbfKWZsehGP8wkSSASJZZF2clnoSRiFhpYIrn
	F2jQeiDgeqsZZKcOKLQ5KR4Hy3mHoz+8=
X-Received: by 2002:a05:6214:5981:b0:8c6:2245:3f49 with SMTP id
 6a1803df08f44-8c6632d9dd5mr59505866d6.32.1778609254036; Tue, 12 May 2026
 11:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509015208.3853132-1-song@kernel.org> <20260509015208.3853132-7-song@kernel.org>
 <42a9075e-a4b4-4eb7-b96e-48e5c0cd2f3a@I-love.SAKURA.ne.jp> <CAHC9VhT9vvaoYpRX4fPZ_H13+PaqG72CpRbS+d=9xgMBaKHo8w@mail.gmail.com>
In-Reply-To: <CAHC9VhT9vvaoYpRX4fPZ_H13+PaqG72CpRbS+d=9xgMBaKHo8w@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 12 May 2026 11:07:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6c4kbVmBJ+4=J2WgD8JKv7q_cZqXSE3+EPkWKro0dh1g@mail.gmail.com>
X-Gm-Features: AVHnY4LZp5deom77-xEaW01b2jRxtdWLWeWdvcHJesrle08Ns_ME_r63-071_KQ
Message-ID: <CAPhsuW6c4kbVmBJ+4=J2WgD8JKv7q_cZqXSE3+EPkWKro0dh1g@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, herton@canonical.com, 
	kernel-team@meta.com, selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 6:32=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, May 12, 2026 at 7:03=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > On 2026/05/09 10:52, Song Liu wrote:
> > > Replace tomoyo_sb_mount() with granular mount hooks. Each hook
> > > reconstructs the MS_* flags expected by tomoyo_mount_permission()
> > > using the original flags parameter where available.
> >
> > Please fold below diff into this patch. Then,
> >
> > Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> >  security/tomoyo/tomoyo.c | 60 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 58 insertions(+), 2 deletions(-)
>
> Thanks Tetsuo.
>
> Song, assuming you have no objections to the comment blocks, please
> fold in Tetsuo's additions in your next version and add his ACK to
> this patch.

Updated 6/7 with these changes. Thanks to both of you!

Song
