Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940D14DFD6
	for <selinux@vger.kernel.org>; Fri, 23 Feb 2024 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726898; cv=none; b=iA3fGj5j6VagJLYrhnAUXhIUUWrGsTYZUySB6SnM8q6ZvYpPPvANnvAMwhmDLzX2ij8xpx3ycy2rOabb+dZGzLltPYd5O/1pXNMCI4i8vyNUTkvIq2P6dv9YMp02aE+SR6rEcCS1UR2Ydz6IHgiBudzXMWXdFEm7c5Y1wT7lKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726898; c=relaxed/simple;
	bh=tCxLkZaiXV0zdt3VLXgnun/1lqJgVCO7ceU56CFwRpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqGMrPYQeuRjp7ZjjqHxsj5wcLJTOauzpeRg1fmAMYa/yeJHl9wSNGWnV8vMFEFSgbVybhEgfzJ4dtyXSXgLXtTMe5AcM21GeFYHvStlywNcxODvH2NtGZiKzH2ZIbObscbu8q+EAlGQanUYewKMAJyCoFe0PTdraonXx+8ibdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DGeG1NJ2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DGeG1NJ2"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so1440697276.0
        for <selinux@vger.kernel.org>; Fri, 23 Feb 2024 14:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708726892; x=1709331692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSHK5epAuKvdBFEuYnQb3nyTXVxrBoDNXBYJr9NtKwo=;
        b=DGeG1NJ2i9WQOHMWBbz9z8nrmtXaogxgI5TGhyK4p/hjJMW8UG7NVPc/g7B467Iihv
         yuIQvf/mi1PSkisYQja3NlvZP/ibnX59/wVuAXrotALE5Rml7Cr2RMT7TJYtszr0xzpc
         Xz7bSENYj9Ebn6oiSA9GzRUx7TvCbCspCQG/KunAEF2QghjvI+o5GirNRqaL63z8x7J8
         NCMCe4PhEVJj5lntgr6zco47iNn6EAEbFIAd8XBrHXJkZeZY+kwjmSGdgp+XTlhZu0sE
         yMs+M7TvEMAQ3jYyBcnK1cTplkAmac6d6fjlYAXbK4rjAfpNVTOw7X2wQ5INnUqVFlzG
         CK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726892; x=1709331692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSHK5epAuKvdBFEuYnQb3nyTXVxrBoDNXBYJr9NtKwo=;
        b=xEBtbhvPlJ0ktYMmoJrYukc1cJ5l7LXAaqxGtrko4Y6saXqJql0wJpsfdCCTNR3+Ds
         owZdY9/9+Gro/CtmHCM8cGXRNiERiGq7ooNehrk30wAkKttoNCGK5vDtpSXU8Do2k4JS
         UkxZDJIvfav7PQCWIBqSb+JR+n6j0fbuTMTipB9i1ddmgM600EFYw/mTMvMtoroXSG4B
         FRpO5sEAaGzlBPBuZF0rq+yGJH6gt2j0Fh0u7px8yVcG+IDjOGl+pKvDp0l6OP7n5Jj9
         D1E3kXJcRpBVZZe2JBJPSQEhd7K3i2tv738RFURTA95Vv9EIAyGto86n2pIIqi7E+NYW
         9asQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj/ciiUEXNVhPcrukjTtGPCBQeHYMWNFFMx7/bBfB80uhPo3xUNf0OIehImPxlft819raK7OJlBtr2XLGaQGGbGpdiHmqoNA==
X-Gm-Message-State: AOJu0Yws82w0sKBUOrQMjCniPF36bL2ROw9gb6NPZaa0nQzuwIjDWT1C
	HhWkzal5mbxetnA+0BzZEi7usedDMYTJ1gDOp31dBgRZVnENIA7rbu//6gt2iU0E1QQiGSxG9l9
	VXpLdapFxFtgxMTgwT83SlXLpVeJFx3iE93hk
X-Google-Smtp-Source: AGHT+IHoS06SEmuSwB42FEj2Tv0jydKO5BLvQbKa4zVmj3/4z7CKsbNK/04Q5C3FEGLnLUWZFAf1+v3Y+5eZxxScozA=
X-Received: by 2002:a25:d0d4:0:b0:dcc:9dcc:a433 with SMTP id
 h203-20020a25d0d4000000b00dcc9dcca433mr1335893ybg.54.1708726891747; Fri, 23
 Feb 2024 14:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223.ieSh2aegurig@digikod.net>
 <20240223.eij0Oudai0Ia@digikod.net> <CAHC9VhRdRK3FztE-Th=3M+0ZjCZQJ+5sTiXPwfK6xXX_=SFHhA@mail.gmail.com>
 <20240223.goo9Xei0xa9S@digikod.net>
In-Reply-To: <20240223.goo9Xei0xa9S@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 17:21:20 -0500
Message-ID: <CAHC9VhQh4R6x7+giLBQV_YvRconZAqjW=vRBrzwVw2jzYqFu+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 5:03=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Fri, Feb 23, 2024 at 04:05:16PM -0500, Paul Moore wrote:
> > On Fri, Feb 23, 2024 at 3:04=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Fri, Feb 23, 2024 at 08:59:34PM +0100, Micka=C3=ABl Sala=C3=BCn wr=
ote:
> > > > On Fri, Feb 23, 2024 at 08:05:45PM +0100, Micka=C3=ABl Sala=C3=BCn =
wrote:
> > > > > selinux_lsm_getattr() may not initialize the value's pointer in s=
ome
> > > > > case.  As for proc_pid_attr_read(), initialize this pointer to NU=
LL in
> > > > > selinux_getselfattr() to avoid an UAF in the kfree() call.
> > > >
> > > > Not UAF but NULL pointer dereference (both patches)...
> > >
> > > Well, that may be the result (as observed with the kfree() call), but
> > > the cause is obviously an uninitialized pointer.
> >
> > Adding the SELinux list to the CC line; SELinux folks the original post=
 is here:
> >
> > * https://lore.kernel.org/all/20240223190546.3329966-1-mic@digikod.net
> >
> > Thanks for finding this and testing the patch, based on our off-list
> > discussion, do you mind if I add a Suggested-by?  Looking at this a
>
> Sure! I was in a hurry and didn't give it the attention it needed...
>
> > bit more I think we'll want to make a few changes to
> > selinux_lsm_getattr() later, but this patch is a good one for stable
> > as it not only fixes the bug, but it is a trivial one-liner with very
> > low risk.
> >
> > I do think we need to tweak the commit description a bit, what do you
> > think of the following?
> >
> >   "selinux_getselfattr() doesn't properly initialize the string
> >    pointer it passes to selinux_lsm_getattr() which can cause a
> >    problem when an attribute hasn't been explicitly set;
> >    selinux_lsm_getattr() returns 0/success, but does not set or
> >    initialize the string label/attribute.  Failure to properly
> >    initialize the string causes problems later in
> >    selinux_getselfattr() when the function attempts to kfree()
> >    the string."
>
> Much better!

Great :)  I just went ahead and merged this into the lsm/stable-6.8
branch to get this some testing in linux-next, although I'm going to
be *shocked* if this commit causes a regression.  I'll send this up to
Linus early next week, and if John wants me to send the AppArmor patch
I'll do that at the same time.

--=20
paul-moore.com
