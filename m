Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8733EE1C8
	for <selinux@vger.kernel.org>; Thu, 19 Mar 2026 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935811; cv=pass; b=r4I9hf7awdvipdq1ga27tUvJNfdawYoQYabLfv54dBHQ6rN0wIAjjfYeIT3ACLrkrfE84XjFXoArWQ3WxgYu0iHDC2z5Q46wlF4lLyCAKd50RYfmlyxvvGLl7w/i0+hev5Sl6hT3w96nHnbXxYjUiocwZ8s3R96XWTgfNtJkmW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935811; c=relaxed/simple;
	bh=venfIdcDoNMJAHTl0dBp32zf9R0qjSHwm3If9NHEtBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKF4NQUIfQDD1dadnyY3XJcGh9Zvvzc4h6IeGm5mFIUpUsQ5hKx9FRS97MnW0eC5au/+jWi/zFTafV/DhlBbCm9aOmpx0axXU2f8MzsPQJHNGMyb7FZHKeNa5ZUi2pbb0MDj3PE+FUhPTo9psk3erAQE8QECmsyQQN5NVcIsnbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DykLok8S; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DykLok8S"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a8fba3f769so4145395ad.2
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2026 08:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773935810; cv=none;
        d=google.com; s=arc-20240605;
        b=FzBJV2wg2hupvtLaHEONJaGTNSuQEvQKdFxvr0cfXg17hyzhz23Wv73ePgLx6bhojj
         ploBPNTQTblzNjA2i+keo5X/Kbk+N+vScghxN82hsPPM+xbNSDBtsFLqWJP8NaS4l+i6
         jU4U/ljN3KgyeVc5RMv86ts9KakEbfL96fT4ahpv+jShYrHYDRmYSc37Y9+Pt6vf3fTm
         TjVhE+RgsQxxrsMvrL8rWvMZwQPJ4YpKCd8koU3LQ6KhT9jjXPcaSZzDiPq+sCACHxnZ
         VywBa5oBztXKqisQlybKcyaw/IyCrzC7Lcbdllraq5kDKAnBcrhS6/fEvUW5i+9bQaCO
         eaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TpNQ4RrfxDr8OIdp6sqWlPi70JqpMY9icBlXfAIsbA8=;
        fh=thwOnr3ctyXS2zEbbeBkH214izw1QJ0rPX7yVh3YXNY=;
        b=DcV7eMHMfX2n9rZjogVpRj70IEyi22ZY47JtOEwuW6zVPNUSxTiXxOfexjK37gBjch
         X5kdW5HnQMkaeOkzwRhHuzjWUhFsD4J36M3SNY8kvyTz8WLZCSAX+YuH2WvBrVJjC3w3
         XbVd8UBEm9s/trwlJ+CNMiPtDGwrzluhcKlG+ZBTQFS//lF7wwFK+GqUyZqJKovCnssH
         F1/1NX42Ybc4eJnO4bYZwN6Ij/ccIyqFGhpY2dW+6v8a5ctxyfh1azRI4FD4et46+7DW
         rx80hjLrWxQevEn3R9sCJUb1vaiDri9x2KcIkkkN05wchvZHXD5GuVibYxW9JcwrTbFs
         DooA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773935810; x=1774540610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpNQ4RrfxDr8OIdp6sqWlPi70JqpMY9icBlXfAIsbA8=;
        b=DykLok8SsbPuq+JrybVVuynmBc8i6t1bhey9okzn1CetJdy9MzCBXvv4ZfsvnlyFwh
         qWh4iHHNLfOzlH60EadF7cwaVNVZ55yFjuUWkCFtr6mrDRffjdYC/nF7lTMZ1EMNY7/a
         jNEvFB6mlX4v9Vyrtp++TcJ2fdxVY2okPOmOp+TptqhCJrfJTGY4im+/N5RUHF8l4/2A
         Fpq9ISSsGQvoPlkHJNMhlabngLG8Xkn0lUfQAtFCxuj7y0fFHRKoq4XgdriTZndnT5d6
         DZg/WcxcP/TVZedeaT6tufUe1FKDfcXtnkElvzrqpBM2Ynyu7X5Hk6ZH4U6IIGCsJf70
         tUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935810; x=1774540610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpNQ4RrfxDr8OIdp6sqWlPi70JqpMY9icBlXfAIsbA8=;
        b=g4/53yz+GONkwUfeZJUwLIM5F62MPLqTCWA4nyLh7UlDrSaHUFzdzjQAg71Hlzp2VO
         hp8dOuoFTEuMOMSZ31J/hzyf/qqrQpCK0ApBCVLkr/nzmY2LuJKpvTgaYqD6ccB98lvZ
         GrOCvGUac29GX3A7V6eu+r6d9XxsoXmsgF0s0FfcrDFogTQc4EruXq+BEAFymdzNYcFx
         4Duk13UDXr+/5RVGcdVGm2cAVD1v2NkZ7h6Hsfnqy/lIra0M4tfB98UQ4D76pkQSQsVX
         BZ7IfrgVJJTYIwZn+BS3q9+g8ROjOnwsGJ+/+L5ha90l9Z/sSXuQfu9oZcsnelSLVFAE
         7hHw==
X-Forwarded-Encrypted: i=1; AJvYcCUJx6j9DhXNfd6pk9Dhm0aOQzyUlJDRerQBd+D1tqPQkqHVCiwDW5VgklbJVNsu9lPqcV8aggEO@vger.kernel.org
X-Gm-Message-State: AOJu0YzxNhjh+/xRWHyVDwIut1NVgxBzghLhsHG2MhQGM+jGyr6wXQjH
	FPuIBmfOO47KaIC6DT5zOyv6DfyoN+F6K9+FgGOso0zj94zNS6W35xZB0MFHx2VbmvjEiIXnPy7
	VGx33sXSjsWqCUnOVPl2m9i0s6eFlcTTEma30Fln+t4nw8qvjSvg=
X-Gm-Gg: ATEYQzwoTt2DRpIS5OIvr8QE7ki1TOksrXec7OTw3+X8s19vyDj6cdlpKxhHq9gJ+Ch
	GlYcTBT//NuxRkPta7Ld+Y8dpxmd8sTeOBIbkGGmAEQeX5V1s872QD1Q09VPcrDAaanpqxDpaKm
	MBSFX7FTSio8TqDqh2VUQWimu/Jei0J/E8g6cVT3trwgxw0qnwVMji/4fI7+Q4bKQ0QZ3TXP9sF
	r7vok3p2iIK2tCkaIp5nIq7Up1PLhdqTvsZGwDIriepBJ0cRn6C3oAgTUWRJhKGX3J4nY3DM2ss
	Z9KTeYc=
X-Received: by 2002:a17:903:1c3:b0:2ae:478f:2ec with SMTP id
 d9443c01a7336-2b06e3dd59emr76386305ad.29.1773935809817; Thu, 19 Mar 2026
 08:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318131258.1457101-1-amir73il@gmail.com> <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
 <CAOQ4uxj8SZqaFbrVifw0uw7skbUvJP1_nLWj4PYCeZuaLy5t_A@mail.gmail.com>
In-Reply-To: <CAOQ4uxj8SZqaFbrVifw0uw7skbUvJP1_nLWj4PYCeZuaLy5t_A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Mar 2026 11:56:37 -0400
X-Gm-Features: AaiRm50nhjVBL81kDULwvCn8PsB2aebm_MIqZayk9nG17bPp4IlB5KlFJeWc6p4
Message-ID: <CAHC9VhTXfiENo3MVSv+LZFx4VJGTDqErMBKx0wx+jKNOc=NjSQ@mail.gmail.com>
Subject: Re: [PATCH v6] backing_file: store user_path_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 10:54=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
> On Thu, Mar 19, 2026 at 12:47=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Wed, Mar 18, 2026 at 9:13=E2=80=AFAM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > Instead of storing the user_path, store an O_PATH file for the
> > > user_path with the original user file creds and a security context.
> > >
> > > The user_path_file is only exported as a const pointer and its refcnt
> > > is initialized to FILE_REF_DEAD, because it is not a refcounted objec=
t.
> > >
> > > The file_ref_init() helper was changed to accept the FILE_REF_ consta=
nt
> > > instead of the fake +1 integer count.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Christian,
> > >
> > > My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
> > > Here are the changes you requested.
> > >
> > > I removed the ACKs and Tested-by because of the changes.
> > >
> > > Thanks,
> > > Amir.
> > >
> > > Changes since v5:
> > > - Restore file_ref_init() helper without refcnt -1 offset
> > > - Future proofing errors from backing_file_open_user_path()
> > >
> > > [1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore=
.com/
> > >
> > >  fs/backing-file.c            | 26 ++++++++++--------
> > >  fs/erofs/ishare.c            | 13 +++++++--
> > >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++------=
--
> > >  fs/fuse/passthrough.c        |  3 +-
> > >  fs/internal.h                |  5 ++--
> > >  fs/overlayfs/dir.c           |  3 +-
> > >  fs/overlayfs/file.c          |  1 +
> > >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> > >  include/linux/file_ref.h     |  4 +--
> > >  9 files changed, 103 insertions(+), 34 deletions(-)
> >
> > Still works for me.  I'm going to update lsm/stable-7.0 with this
> > patch so we can get some more linux-next testing.
> >
> > Tested-by: Paul Moore <paul@paul-moore.com>
> >
>
> Paul,
>
> As you saw, syzbot found a nasty bug in this patch and it is too hard
> to fix it without introducing more hazards.
>
> Therefore, per Christian's request I am withdrawing this patch.
>
> Please see compile tested alternative solution for selinux without
> intrusive vfs change at:
> https://github.com/amir73il/linux/commits/user_path_file/

Let's let this thread die in favor of the other.  I'll already
commented there, but the quick summary is that pushing the ugliness
into an individual LSM, or the LSM framework itself, is not a
solution.

--=20
paul-moore.com
