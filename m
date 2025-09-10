Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7391EDA1E
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468239; cv=none; b=M2DVkR3TllEZGR8jq1xdP1jpaubAm6ndJXmQZBsnpFhOt0Z9btwAoaE6OZPPJ4OqI9QUjNY4LMYQqM4B1knHURyVZKXCVx1rXpIApVsaToaIZWk/d8sYYHHs6g1TQFg8EsXKD5UDIh/cXDaPtIZ4Ad1eQSk6Pd0Cg/Br3iZveZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468239; c=relaxed/simple;
	bh=t7G69Nv9hUI9mVUISgtnvvEgRP65zBBXJns/biCPOSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTCzO29YnVoucbUfCwYOOujF8YHVZhTqXKcYXfCl6bpejy1anCPQDmOywY68GTHarJkMVX+tbj6Q6pFb1uYzJdR7YqaivTERmg1j9x6JCrtDiArqXFXoxYwcJ1ceSLpaWGfF368T+GLhKjrpWyHfeb8E50+IP9PDAeZUrOo79ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C8clL4Zi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C8clL4Zi"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-772481b2329so6535953b3a.2
        for <selinux@vger.kernel.org>; Tue, 09 Sep 2025 18:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757468235; x=1758073035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrvI2YaQ8i20cuiILhZq1TdGHsEC/HcyBDRJG5iBwU0=;
        b=C8clL4ZiQB7fvv92iNZ1dAbNx28JECJazfyXb4T9ats6kXiE8dtnGUJEhjbEZKy8kX
         V0zUJhaqeDaD/td9ee+VrcrVJQPz6TopmZC2SIczqmQ4geYP/RkojhA5c2HWAU1FieMx
         8Nww9n0uwygR0lsa7MrJ/IHSyeHR6BuDdIOb51nfMsTF+Nh1ub1tyhlDbtfG1ZaIfyaS
         A3WET70kMxgvB3yeWSXwXl6N1otVtFPhC7P6KT6WP9jeZ/MFJmQVbFbUW3NA+PTy2pgK
         1jn5NTXTU+mc0svIte0mZzPe94BKc7OwRSyssTBWVErYT/QsaJtdGI1p5R8QZbT/5cN6
         rlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757468235; x=1758073035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrvI2YaQ8i20cuiILhZq1TdGHsEC/HcyBDRJG5iBwU0=;
        b=KeveJYXd+iRM0dXeH6PDu3cQ66EahOlU3ZKYgncfnqUacTjsDe+Nuy0kjQWm86Q0Nr
         WeOpvEIcGK1ieB5kYZRFu474p5mjM3IMEjZ2704mWd8ihOYAskKY7gzQ4KNkdLKvThlt
         g7jkkw8IeBQ5ZBT7AbT3rr20PSs4F4ev5EYcOiF6UjIRUyF6//fCBz+qaDGYVt29V9LN
         G/+scbO1j+VqEEM4yN1b5OV3/x4IFGC8PPI+/hlIKUgiP1XjxG8wmRYFJ9E6Qht0FfLq
         4+UOP96SxnrZMBb5HY6Jk5DD43pYcm6vSqW6WZB39dPTi0BKXMB4i/ALt91WnShi4zfK
         Porg==
X-Gm-Message-State: AOJu0YwMUuy01CKmAf5F60YssXlPZhU6y/hoeJdbcyySW4IQe7xIJGCH
	1ezrOeERQ89BMDCt+2BHoWr9Ew3AqyT2NK8wcv6M5X9Urs7eLBlZ7A6XD2RZXDX7oVuhJSB0ZaM
	LTZ+98ho11Vh59kXLMIPk6kvPZLbRGKwV1EztdR8lew/qclFGFS4=
X-Gm-Gg: ASbGncsBQleQ5rCayz1cydw9zBC0ZL4fatLblBhKZ/95q1YeDhEi6RsGH2t13Tfa9ip
	/30rD6LS4ysOK8z2uhRsOr5mAi+pdTB6BAzDe3SZdNxe6tnkubiGnzuf71aL/zYnuSAqmk0wzXs
	DL4IxHJDtJnkDhBefgO7aWhyPxmU4j4lklCRA6WjA61k4irVnbVpwX5f2d64w8a+2u6daUncs2R
	3lvhHY=
X-Google-Smtp-Source: AGHT+IHPesPpMRM54j5CkGUkL9rLmO8Dz6+MWhXKQTybD7i/QvXIGgUU+aIH+cicxA4ny2Q3dHDf8Q6oi+7ziSd0/4Q=
X-Received: by 2002:a05:6300:218f:b0:250:b053:53c5 with SMTP id
 adf61e73a8af0-253466eca5fmr18132354637.51.1757468234926; Tue, 09 Sep 2025
 18:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAHC9VhR+5+B4Kx0zxFvZaiTM8Uw55fdA5d63+D7PV7Bj3tKPdw@mail.gmail.com>
In-Reply-To: <CAHC9VhR+5+B4Kx0zxFvZaiTM8Uw55fdA5d63+D7PV7Bj3tKPdw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Sep 2025 21:37:03 -0400
X-Gm-Features: Ac12FXz1sUEPKgxTZKaZLN2lKW1t9bQcI7JAroD62hSeqhwDOWwiLEioSMLqcCI
Message-ID: <CAHC9VhRXQWz4A5pN-y_nmgBC+Vwu0Qi6_Pb4ec4k3gEc1sgVOQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: selinux@vger.kernel.org
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:33=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
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
> >
> > Fixes: 084f547bd8e3 ("memfd,selinux: call security_inode_init_security_=
anon()")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/hooks.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>
> FYI, as of right now this is untested, but a test kernel is building
> as I write this ...

I was delayed slightly as it turns out the latest Rawhide dracut
packages are broken, but kernel boots and passes the (unmodified)
selinux-testsuite.  If anyone who has an updated/patched toolchain,
policy, test suite, etc. can verify everything is still okay when the
new policy capability is enabled I would appreciate it.

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

--=20
paul-moore.com
