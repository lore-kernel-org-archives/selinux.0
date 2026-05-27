Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141A383C66
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916150; cv=none; b=TqJ/0U25HokLhkgwTZC+qtJ6CaPwWewkoD8Fq+edvFkR/cnMXWrpRRdD0bQgZQB6OsflBgOZqOcR4ZoEFJNRc7yOjjPmqpr3ysUDFicslmJ5M1/a4FdUgjXuepO5+YCs5J/1TethGFPzLlsvibL/ntr/PW8DJc6xqElquD/z0gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916150; c=relaxed/simple;
	bh=GEKS06uuuAqcjSg8ihpyB/cxnmd0DZZbElkKKpaHokU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5FhaevH1eiTOXXMgTkGvGWPDfKzkAzPA5C9qJumDvTbAZdDp4BRY1LNX3frjjXgNl7ZnzHyVRD1ftO43XGLVFTJ2PzBSsskHjXZhkOJoxPEOO0jhZ2XEy+2TMgGSDMHEDlWNjfNC0Djjm+datrGFi99MvFPhXCkzwXffahZtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYbl47tS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYbl47tS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0540C1F00A3F
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 21:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779916149;
	bh=SGNQeth4C737npdaj8qyPJlkY2CV1woEfMjV+LyPpKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YYbl47tSWadaLp25wNd29TyEhD4mDuRPA28dakOeAUi2bdlKLPhX785Mg1CaYsLVE
	 sD2/UqQMwyaKYORziMsp06JC0jnVFXsmv28Cq6AUsef4IIA4og8Jp30IHGFpcDCxmh
	 TIH1q1zW3VniIGan5y6fvFl8fQkRzkWDwZ3OHjKXax0ebudOFasMJQQa23pSLWcf/R
	 qoyK3Q/TewfmY7g3nmlToY+2U48SfjZPF15+bF6ESDIbdeyvyqu5Lw8dU03J7LZzUP
	 YeJJxhVvVPKVl39qKuc06tiwWWPMT2IgRsnRwrT1bjnpvpOlrVaFq6LhYVYJvPA38H
	 h0l76bbb6sc0Q==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-914cf9248ceso376157785a.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 14:09:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8zek/wJsjQxyloAt7rSCygBLl9wln8kwARyrLLMDzqorIPpLkhjg6WGL6ZcARAGtNIryPm4Y6a@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7hBbHrRfjDxDY/TXPoN2FdxhSU10lx9gKRPqhw3TD7aTuN60
	7YuJPrebLSehgsq2wwSWHVVhIoQ2lYJGoixlmh6tq45olLqVs0wIhn+CJun6xQr3Lm0uZSLpgqt
	uOn+ZQbHZAm9TdMyCR5xmauYQDeIQ8j8=
X-Received: by 2002:a05:620a:408f:b0:90c:a08f:c5f0 with SMTP id
 af79cd13be357-914b49cd89fmr3578191385a.33.1779916148247; Wed, 27 May 2026
 14:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515200158.4081915-1-song@kernel.org> <20260515200158.4081915-2-song@kernel.org>
 <177944135249.2871055.11361892114499566606.b4-review@b4> <CAPhsuW4BVSQ6oqyk=kExuZUkB9PWRRqUf_EJ=x3mNmtkT4oH4g@mail.gmail.com>
 <20260527-landen-bahnfahren-eckpfeiler-c1e1e9cb73aa@brauner>
In-Reply-To: <20260527-landen-bahnfahren-eckpfeiler-c1e1e9cb73aa@brauner>
From: Song Liu <song@kernel.org>
Date: Wed, 27 May 2026 14:08:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4bwf=G--_gfMZOOAkpRJDfC0FSv=Tq+UAdAOY0euDamg@mail.gmail.com>
X-Gm-Features: AVHnY4JoTXa2GC7TLUEwE7AqXzVEqSqzeUkn5eeygD5_8kZaIgsnYmpV6LQtVMg
Message-ID: <CAPhsuW4bwf=G--_gfMZOOAkpRJDfC0FSv=Tq+UAdAOY0euDamg@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] lsm: Add granular mount hooks to replace security_sb_mount
To: Christian Brauner <brauner@kernel.org>, paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, jmorris@namei.org, 
	serge@hallyn.com, viro@zeniv.linux.org.uk, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 5:17=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
[...]
> > 1/7 adds new hooks:
> >   lsm: Add granular mount hooks to replace security_sb_mount
> > 2/7 through 6/7 migrate LSMs from old hooks to new hooks:
> >   apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount
> >   apparmor: Convert from sb_mount to granular mount hooks
> >   selinux: Convert from sb_mount to granular mount hooks
> >   landlock: Convert from sb_mount to granular mount hooks
> >   tomoyo: Convert from sb_mount to granular mount hooks
> > 7/7 removes old hooks:
> >   lsm: Remove security_sb_mount and security_move_mount
> >
> > Some ideas to change this:
>
> My thought had been:
>
> * Add the new hooks to security/.
> * add the individual lsm implementations.
> * Now replace the old hooks with the new hooks in fs/namespace.c
> * Delete the old hooks in security/
>
> IOW, why the migration step? It is a full replacement anyway.

I think having a migration like this doesn't really make
review more difficult. But I am OK refactoring the patches
as requested.

Paul, do you have a strong preference either way?

Thanks,
Song
