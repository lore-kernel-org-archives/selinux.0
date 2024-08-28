Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552A71AD9FA
	for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879133; cv=none; b=UPA5B0CDrtZk7bWuVJsCHIIze2QwE951+FnrG6uFIyCPisuJ4lX5wP0uqUG/Q6XZsR8jG0y4k5Ge5ws4QaIfawz4O9Ty1V/Wb6Uav2ZXXMxD5KNtJ4jUhahPqv6QADsEBxmhpSpriUegqei6v/2xOic5qrlU8kUQu81l3YjGTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879133; c=relaxed/simple;
	bh=YkFFzt10FeRHRuYn4BTPENvDBVqrvdETzu5ZljVqWPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hi3Ssha8gL98Pc+iTeLq8+9GhzUcF6B2vQTYwYZKDa9UMaEjz0D1bZYaaeklmE+oDuVjf879G01NsNheIUb1tLbWr55Gd4nXTZZ1AWKad2Oa0MjpJpcAqAZ+ZH3khElkZ22ZIhO3bNHcnNYOqlsLpHeaeWMfZp0HYd1glcPpwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nxh6ztjH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nxh6ztjH"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6c91f9fb0acso17017b3.2
        for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724879130; x=1725483930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wL2mXtPHo9Bukf4HhYOY4xrUEL3mq1g3DGDrYTrepE=;
        b=Nxh6ztjHrkP/YyMLW7x88YgppYUNibc9+OY1T+6LG1H2zgOSBp+aw6NjrXRxKbiIEd
         NtOJwU8f3dlsYzXUyXs/YnC5PEqtUeiuoxJnuxL7NO4VrpQw05J1w5hVcstn2ypzbX3f
         AVqnmj+HLmK/CpmC8h9Zeir1ZOgd3PM/cswPJmYuSP6BXiN5KeTouXmb0X0tC7cXU7CN
         5o8pVu43/rxyAP0ry5+YGnwJ7QQk4P6G2uiTggIejUHEU+T7EuoQmCy7bm1iDQNwr9MU
         +us9ecddB6u5kjXWQz1zNzauwai70LZixo+k527MPOa37xgEzskHHle6hI7OLA9+4Gvl
         YwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879130; x=1725483930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wL2mXtPHo9Bukf4HhYOY4xrUEL3mq1g3DGDrYTrepE=;
        b=CaK/vvDG3Is60cmiU5c1ZfXwGECt3qtKe/V98jxz2Ls+A/umiiNexL2Wn5nnKK4k6k
         1WPlOvz3hDwqwWEj2qD7VxnTYAxB/agK9+uL2C1YxRdoFCjbKgjgfWw2Ps5J8mM8iFe/
         cgiX7LRbKFsSQniFxzp6zCjUtoq3/gyyUlV5ARB+E1nASmkXA0PkOErESfNbeME2dKXd
         B+SexB6680wg4cBLKyg2YlfU7hwxCqzE1pTPsnPcyX3QkqKwbtajrdyFapOLULdN6TdN
         qpFGFTBBADpNKrDJUkoNJfipDP+SUmxYgpUmL6A0wte75rxgEoRRBV+UID8HJMMH7PIO
         rfsg==
X-Forwarded-Encrypted: i=1; AJvYcCWxHICfKbItExsy+5Z+2GkhDvd0eQpatCifAxEyCtvyumLL5uPHq5rG0CsLgJc3G+4WPtQ62C68@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mtwzTh/jpWTabAhRprVOvvNjrm8C9aMXbStR0uDGYxZe+pvr
	MDJ6MDmOgGc0yfLq0H6DOa84OqC5AVYmce0synV37hanPuPUWi8YNUQwXDK49bNWU6ZkzHa5PGp
	22QYyaHkoBsN0vM1p9mVS6PhPMT6xM9FE2v6W
X-Google-Smtp-Source: AGHT+IEIyYng4v70mcuJouYb30fO+4gyzftvumKtAVxTh1vagwdm2yPBUr2X42XT4oZUyT7+ext0tcufIahHxizXGA4=
X-Received: by 2002:a05:690c:e1d:b0:65f:8209:3ede with SMTP id
 00721157ae682-6d278333eb9mr8422387b3.44.1724879130242; Wed, 28 Aug 2024
 14:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828195129.223395-1-smayhew@redhat.com> <20240828195129.223395-2-smayhew@redhat.com>
In-Reply-To: <20240828195129.223395-2-smayhew@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 28 Aug 2024 17:05:19 -0400
Message-ID: <CAHC9VhTCpm0=QrvBq_rHaRXNqu7iRcW7kqxjL8Jq9g=ZypfzsQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux,smack: don't bypass permissions check in
 inode_setsecctx hook
To: Scott Mayhew <smayhew@redhat.com>
Cc: stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	chuck.lever@oracle.com, marek.gresko@protonmail.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:51=E2=80=AFPM Scott Mayhew <smayhew@redhat.com> w=
rote:
>
> Marek Gresko reports that the root user on an NFS client is able to
> change the security labels on files on an NFS filesystem that is
> exported with root squashing enabled.
>
> The end of the kerneldoc comment for __vfs_setxattr_noperm() states:
>
>  *  This function requires the caller to lock the inode's i_mutex before =
it
>  *  is executed. It also assumes that the caller will make the appropriat=
e
>  *  permission checks.
>
> nfsd_setattr() does do permissions checking via fh_verify() and
> nfsd_permission(), but those don't do all the same permissions checks
> that are done by security_inode_setxattr() and its related LSM hooks do.
>
> Since nfsd_setattr() is the only consumer of security_inode_setsecctx(),
> simplest solution appears to be to replace the call to
> __vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
> fixes the above issue and has the added benefit of causing nfsd to
> recall conflicting delegations on a file when a client tries to change
> its security label.
>
> Reported-by: Marek Gresko <marek.gresko@protonmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218809
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  security/selinux/hooks.c   | 4 ++--
>  security/smack/smack_lsm.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Thanks Scott, this looks good to me, but since it touches Smack too
I'd also like to get Casey's ACK on this patch; if for some reason we
don't hear from Casey after a bit I'll go ahead and merge it.
Speaking of merging, since this touches both SELinux and Smack I'll
likely pull this in via the LSM tree, with a marking for the stable
kernels, if anyone has any objections to that please let me know.

--=20
paul-moore.com
