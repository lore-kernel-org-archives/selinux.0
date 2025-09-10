Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81B35335D
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515113; cv=none; b=ju5f+FpYgnTDGJBezdGfyvTph9JpILRL/WUz3udDaE1hH8/82f4Wojg3gqxwqpW0gtRet0yzZB6YGjXd9GeBbWiJ/QBrAKcbcMjuNXKrXS69VZQ4qt9Q9oFaqgYnkbbNmPI3bFpQ0LCAa8oc3fljcZ3541GyjnpyXefGfAapwUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515113; c=relaxed/simple;
	bh=UrbZ69PsxU9Tel3GiMjGh8ut4dePB6lEf7CCjg6nvu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAzywSn7Hn8Mm6hrAWqIvqPAks+VFbYIS5muDMHnudeYvDBnE6DP+jNFOal2oVm6hF7ddW5DfZzC4gw2yP8M8Mvze+zIo+QW2+ZX2ajTsmUDyDiK2Tsi12hK2xLlCHGovAHwuGeEAiKw16F3q6bMRfiK4id3ZMcp14D9Yy83XTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4POal9U; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4POal9U"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32d3e17d95dso3570377a91.3
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757515111; x=1758119911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2mNJjll4C1soQHODTdxOu9ZP3XEkQbgfWPvZ39lzfw=;
        b=g4POal9U4bHA2jt4KFHsD2eU7Sk54iY17/zbuNWZp9/k/6igqyJORNuwnlVrpYuwlp
         9W8tuvUwk/YKJXfwhfZjVO4xpQQKsBvKqe6JLVDKS0mFrYBOoP7HdVfzO1KggUNthfUJ
         op07Co+iilw5sYNSXGshKX4SsWJO0aS3qJVh79Eg2oajFMQ5vD2y8UY3lth2z+hKMFp5
         C8XhrAznGo/7YlpxZntoSZ5L+jZ8oHC8LAwlBeMD++sn5TbaOT/2Dn38gvqgOoJ6KFML
         9h2nSm1Ql7vk1ENHveDI0nFkwODKi/MqO6H+7ya9Ao/94Faf5Xh7C36+0b6oYHDORu3w
         kqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757515111; x=1758119911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2mNJjll4C1soQHODTdxOu9ZP3XEkQbgfWPvZ39lzfw=;
        b=m2rnu46WsyTCAds8ol3zkLSCSl8A0GU+Z0rLTnxm8mY18ZV7HaaN0IxkFuuFGa3RLs
         U6l/jd9c9tAwAiMMa5FkQGUY0TL9NyA5PoaSvUynl7P7W2AS8lwEJLPO9cGNXcDoLxpw
         emJUBk2Xt0hzhZ34ynYUaOtn5Zpl/3XUmnTT1bd2PMG5Bhwn7ltfHQ1W02NV9patU6AT
         iUk5ya2eduDgggDj1mU7CH3GQ/sr77/TEI9/3mKCeK4DpcOEu7yz1xZ2lOJxeIOn005T
         I2LnhQQChg7jfshX94rKKfGxOdmrFOmtBwZOctJY9j2DmWJUyyX+s0Osub3KX0AR4CYQ
         9krQ==
X-Gm-Message-State: AOJu0YwCBpJeAXl7gbQh5q7j8tbzjLYZ/iNFpi1gNIT6bp7uzrYPUI2o
	1PJKxwauT2U/4Rylt2xTDpLPY18PvrMSUAP8uUMMzBRVMFc9Wc4YHeaz1ein4h3rp4UsWinOmzH
	XVUAcFeLgWTwt99rK+z6/DNA06CVBgbw=
X-Gm-Gg: ASbGncsQ5q89C3fVPg831YbMjzjjGl4ME5QYg+gCRoDbusISg6/lgcqlnTNiD30yLA0
	CJXGLDc9GcQcYAWx89Lw1KRaInhK3k7HzV1bfMOqM5UgKrQAI3YvqJnUaTJJF4/URPW+/g1i7P/
	KCG4Q3ksihQb4uHoiz1VebMatGMDzWo8Kxv+Fzf49l/k1G90RCuoSqP5QazEXqDfCPkBPpyOCYx
	36l/vU7OOu2EBwwLw==
X-Google-Smtp-Source: AGHT+IF0Y6I10ks/EEySimVyRbu/DuJeWBSazZdo3baFvINf5VR7xNRU+ooMT7dWLc55v48HjO9kDFcvRDUeA/M563A=
X-Received: by 2002:a17:90b:5284:b0:32c:2cd:4d67 with SMTP id
 98e67ed59e1d1-32d43f00845mr19673673a91.13.1757515111312; Wed, 10 Sep 2025
 07:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 10:38:19 -0400
X-Gm-Features: Ac12FXxf_EdQFFMDMhhGzNV5noAe7Q8GxJt7h6wR1MhgqCdydmgvjJKCPWNtR2M
Message-ID: <CAEjxPJ495KMrS3GBk+LdKfLXeMjsRdiwhf2CVOm2BZtE-K7ycA@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:05=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > A prior commit, see the 'Fixes:' tag below, added support for a new
> > object class, memfd_file.  As part of that change, support for the
> > new object class was added to selinux_bprm_creds_for_exec() to
> > facilitate execution of memfd_file objects using fexecvc(2), or
> > similar.  This patch adjusts some of the sanity checking added in that
> > commit to avoid a "silent denial" in the case of a kernel bug as well
> > as return -EACCES instead of -EPERM so that we can more easily
> > distinguish between a permission denial and a fault in the code.
>
> Technically, this doesn't make it easier to distinguish because we
> usually return -EACCES from avc_has_perm() and friends, but return
> -EPERM for capability denials and in certain other cases (not always
> clear why, arguably a bug unless we were just replicating the error
> number for some existing check that also returned -EPERM). My
> suggestion to use -EACCES was because that is more consistent with how
> we report denials outside of capability checks.
> To actually test this, would need an updated libsepol patch that deals
> with the fact that the policy capability number changed on merge, or
> re-basing the original patch on top. Otherwise,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Ok, I re-based and applied the libsepol patch, ran the memfd tests
(which passed), and confirmed that the WARN_ON() didn't trigger.
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>


>
> >
> > Fixes: 084f547bd8e3 ("memfd,selinux: call security_inode_init_security_=
anon()")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/hooks.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index b2ad83353c17..2b685f9dd61d 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2320,8 +2320,9 @@ static int selinux_bprm_creds_for_exec(struct lin=
ux_binprm *bprm)
> >         new_tsec =3D selinux_cred(bprm->cred);
> >         isec =3D inode_security(inode);
> >
> > -       if (isec->sclass !=3D SECCLASS_FILE && isec->sclass !=3D SECCLA=
SS_MEMFD_FILE)
> > -               return -EPERM;
> > +       if (WARN_ON(isec->sclass !=3D SECCLASS_FILE &&
> > +                   isec->sclass !=3D SECCLASS_MEMFD_FILE))
> > +               return -EACCES;
> >
> >         /* Default to the current task SID. */
> >         new_tsec->sid =3D old_tsec->sid;
> > --
> > 2.51.0
> >
