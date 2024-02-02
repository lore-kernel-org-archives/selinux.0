Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA0BE73
	for <selinux@vger.kernel.org>; Fri,  2 Feb 2024 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842249; cv=none; b=ArCRlVcX9OOcQ9ZUZojrvvyyP70zvZVRhQ83PKmDPWHpFCcjX8Pba0VS8vyb8DhnxG6bJJRBuQ7b9l6PpqayjfgOJA/jptIwQ5vFQv0+awrCcHs6tCtejF27Vht4qWy817nQkNuNer0GYDwRupXiWVCSPO4T+9wnf7SKVT+4a8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842249; c=relaxed/simple;
	bh=BBczSnSvmRMNE9RXn4zXZYd5DCduKaY1tzfn/e/tSqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjFMIVkqWkMLeOHWjrWJtry0voViFJ869ktwVOn+iT1/jSdtRvRAAk9ngE6nyip5CMvTFqFYvbZCLUJek1TvYsAloViNOh6igUWKXlKBovfHRvmy4IkSCEIeyugpLEEzUYYgokzmqQUvNpA6Ci4s4WIJLy8BlFCr4M2W5ODDdNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M6gPBM+H; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M6gPBM+H"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6d5267cceso1517256276.1
        for <selinux@vger.kernel.org>; Thu, 01 Feb 2024 18:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706842246; x=1707447046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWD+cRf26gUxdoUczPHqIEoaH880ytNGYXoUS2sodZs=;
        b=M6gPBM+HzXkQkUk+sGfiSniomhhR8HQglvQGlhZebEzSTS6xkZkwPQpgmdkXwc2LeB
         OFAD5lj7UY1JrCwuelhpfmw+zpjaCl3qkk6WiTLZsVsIHywhMrNzmunP1WRfALJ6GC1U
         5hWzJwv6u36GdiNyt1spHKsRBuSKwylRDr9xChMJghKgRFu5FfO+nYwM7OWUrsl4euze
         zQKEmd/iEteZ664HF5bS/AxJEGGz5bWqShRwLG1jvRzB2T7GS/ir3ABo/z9E3ZcODjLX
         0P1FpFPOQg9xEy5gzROEgo5n0CyBe2IYvuXYHrcgXlQ9S8bRuAePU2gPZNqmkeOl6bNj
         czDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706842246; x=1707447046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWD+cRf26gUxdoUczPHqIEoaH880ytNGYXoUS2sodZs=;
        b=K2gPQkE5CFEN5eq7DOAdiOTRtNvAxNFA+WDLX2TlmwlGlg4KASFUSAxa0N7RqouOho
         dBFA2a4856EchZJstVA5rZChkRhXAdygsZAWG+EsAhfOUDJ2zNCIkALLNI97JvazDGDq
         +lp2XWl7uH3ih7s6Bjq1wHDSBaWHDMYSxbr4tkTV7grRqvLIJrpg2E2vV7F/gp5ignQu
         /YH6L+msCbAvrNCnL/8JpRTjPuA6EX6yT0MMm+WWfAHhqFWcMPNLSzgau2A5CPVwZNpg
         qHXanQrwWZcb8TxjhdBH9gwiZUx9aQoCxLky2kC9yuyhpf/JI2OMRIHvHLSJhVa0SOVC
         eYZw==
X-Gm-Message-State: AOJu0YxzsdJLCF4hvWGC2m5+IMjQkJYzJW7tIg3aZkfHMFQVS5SYDyjp
	YTSEuuJ81Cu5GYqswSYbOWfY31/tpmHFkfbULO8kuLxB+B7ycZdmzuTN4c9HOgf2J7fAIwpS3TE
	Gr8kBQCt6BYqL7f5/73VDOkDUULx8bBAJIsIm
X-Google-Smtp-Source: AGHT+IHxT07F5IDoqnhbZAtp2BV2w8zWgefrW2z5PLxz9TfOx3FeJZV9tcS1vQ46fTVgHpakkEDRBKzXz9CXfw/9aLU=
X-Received: by 2002:a25:2786:0:b0:dc6:bb4c:9386 with SMTP id
 n128-20020a252786000000b00dc6bb4c9386mr6298275ybn.49.1706842246664; Thu, 01
 Feb 2024 18:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129133058.1627971-1-omosnace@redhat.com> <CAHC9VhSzdvJ2DAgV75Tdxk+tOLuhY-vM+BTT--Mfn6xoxVKbxQ@mail.gmail.com>
 <CAHC9VhQRSWMRAg=y5cUx9+XLG4A2_+WSqJN1RgQQ8bF=VDwnWw@mail.gmail.com>
 <CAHC9VhRa5q3fvWUD-Dh-d5Udq18XqFwR4AGUzSow6Ur+_TmFrQ@mail.gmail.com>
 <CAHC9VhSyNPd4rK+oZE6cDwZTCb3Km_eu-+K8s+X73BJwt8ynuA@mail.gmail.com> <0e5dd86d-bdc4-4ef0-a9bd-d883227102ca@schaufler-ca.com>
In-Reply-To: <0e5dd86d-bdc4-4ef0-a9bd-d883227102ca@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Feb 2024 21:50:35 -0500
Message-ID: <CAHC9VhR1aLrXdwTR-qMLD+o51d3UDx49aPTb2aNnw7T6sBuX1A@mail.gmail.com>
Subject: Re: [PATCH] security: fix no-op hook logic in security_inode_{set,remove}xattr()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:11=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 2/1/2024 3:52 PM, Paul Moore wrote:
> > On Tue, Jan 30, 2024 at 9:19=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> I'll come back to this tomorrow with some fresh eyes.
> > My apologies, "tomorrow" turned into "the day after tomorrow" (as it
> > often does) ...
> >
> > I've been struggling with the idea that there are individual LSMs
> > still calling into the capability hooks instead of leveraging the LSM
> > stacking infrastructure, and the "magic" involved to make it all work.
> > While your patch looks like it should restore proper behavior - that's
> > good! - I keep thinking that we can, and should, do better.
>
> Apology for attaching a patch rather than inlining it.
> I've attached patch #38 from the current stacking set.
> It addresses the issue.

Archive link:
https://lore.kernel.org/linux-security-module/20231215221636.105680-39-case=
y@schaufler-ca.com/

It still relies on checking for special return values, which I'm
starting to sour on as it has been the source of problems in the past.
At some point in the future (likely distant future) I want to spend a
day to see what sort of changes it would take to convert all of the
LSM hooks that return an int value into a 0-on-success,
negative-errno-otherwise format where the negative error codes have no
special meaning to the LSM layer ... and if that would even be
desirable in each case.

> > The only thing that I coming up with is to create two new LSM hooks,
> > in addition to the existing 'inode_setxattr' hook.  The new LSM hooks
> > would be 'inode_setxattr_owned' and 'inode_setxattr_cap'.  The _owned
> > hook would simply check the xattr name and return a positive value if
> > the LSM "owned" the xattr, e.g. XATTR_NAME_SELINUX for SELinux, and
> > zero otherwise.  The _cap hook would only be used by the capabilities
> > code (or something similar), and would match up with
> > cap_inode_setxattr().  With these two new hooks I think we could do
> > something like this:
> >
> > int security_inode_setxattr(...)
> > {
> >   owned =3D false
> >   hook_loop(inode_setxattr_owned) {
> >     trc =3D hook->inode_setxattr_owned(name);
> >     if (trc > 0) {
> >       owned =3D true;
> >       break;
> >     }
> >   }
> >   if (owned) {
> >     hook_loop(inode_setxattr) {
> >       /* run the existing inode_setxattr hooks, e.g. SELinux and Smack =
*/
> >     }
> >   } else {
> >     hook_loop(inode_setxattr_cap) {
> >       /* run the capability setxattr hooks, e.g. commoncap.c */
> >     }
> >   }
> > }
> >
> > .. with security_inode_removexattr() following a similar pattern.
> >
> > I will admit that there is some duplication in having to check the
> > xattr twice (once in _owned, again in inode_setxattr), and the
> > multiple hook approach is less than ideal, but this seems much less
> > fragile to me.
> >
> > Thoughts?
> >

--=20
paul-moore.com
