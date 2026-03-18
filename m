Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3E33F7E78
	for <selinux@vger.kernel.org>; Wed, 18 Mar 2026 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864054; cv=pass; b=Y8ikznmT0H+6F/F0HTe4oc7UpwWi6TNQjW7Dt1pWli4tQrxluPSK1UGf7nFczTK1VJYvRn5Z+Knm4roMZVhqmdvYbh1kwP1ghgs4JXtf2xS5JyzbaN/F3nqXcInx2gCswweeNWC9ngjW/fu4fjVJsa6iyoAGacpi798oWxO039I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864054; c=relaxed/simple;
	bh=HHWKUxL2f5dmXpuQep9FKj2ZGNOpjWa4Ggq5Y+nPWh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGy1X4QGn9C2bpshyXJfeL6cohrRh1JJdMUhBLxuzikaT/Uuz+pUAlGM3FdcM3/xcDG8mgxHAR3XIL3WVLo0dJqlMpZUnMtt/YB4hTIYvJK3grQJHCh9A5ce5zPbsMvF4B1gpfUENTmQnJfZxsZ+rUoeyI0bTlH7T/m+jRXsobE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NtwOi+jN; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NtwOi+jN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b05fd1d147so887215ad.2
        for <selinux@vger.kernel.org>; Wed, 18 Mar 2026 13:00:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773864051; cv=none;
        d=google.com; s=arc-20240605;
        b=Y1Qdb+w43f0fl7cweHEpjqfoBWX1rH/SPbHVrhXdv3fMdAHmSsHNM39kr35KlzJonz
         kUfe6hIO34MJiBwo1hwV7Ok2+7L3dDFDNoAlolV3yHdEUw0sRQD6yBNAD03ncU8iujKq
         yLQ+LdZ96FnDXgMLxhtQiQnBhob6D0m6bLpx3uinUMH0TbEzOZydYy7e9twdJkhZOo8t
         +TR0vIrbw7M330rgmR6KA/YOmIx5jhKf4vcBAROnXAwkoSYz0IA6LQjwfbYxCo/erctV
         0D4T85YbPpBxIwbD52DSAgjRXp53nHucM/UPkDBAvgOPLbO+StmP7smNXipqOIeJU6m5
         ZQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=71OKjSWJ7h2Q1GFZJc35pK1JHDHtKN/E4Pws9ixreXc=;
        fh=M5Lclw8OutGMSOjXmVBzdN2rpgxmOqT4zXMd1rX1lJ8=;
        b=X03ZmUnCZLDuq0nKm6AgwyvrzRpbOWKgkLg79jrLGXYNg0s9xHvtiNEgFQYffSXGxo
         VqfJpVWPN05wmV1JqYA/iNiegWStg2wblaLvgFeGzkbanORgJNOev/Tcc0EiJemwwSJA
         2wZItU1Uzma63Ujw8iB/KTyRr1kQNSvLK8gzIH8Ea5SgbQAtNYFyQZ5cpxX61LNQEyZW
         zLdZbo74vvpCl6uKXF/4Ecc8lP0DltrTFXuYEpd5T7GQjoW85JfDcCtfG925xVxB9cGD
         pAqn57yotrB1oT99VBAMEl/QEtXpVo3xIAQadMMreYGEZSyJ5UPAmiMZjP4goC+rkLT3
         fyhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773864051; x=1774468851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71OKjSWJ7h2Q1GFZJc35pK1JHDHtKN/E4Pws9ixreXc=;
        b=NtwOi+jNDtF28Lhp8zGgTXUoZzr9e02O6NwxhSgbyWpLMh0MupV0xrLqemnvKhLS3J
         rtyyDMWJSCQhHtqkRPtdZxjfzYIYUM74b2KcbuePULFo19uyVNn5uynjiB2q9ZITTDTS
         2iLUShgjm9S1UTUxzM2pHSUAR2UrdAS7ZDs8HiWNL/4wGmYTHhNDL9hPJYt3kr+BlQu+
         NiP/F9WLBbVaygTC5oayHgRS32WWHywEpUfj4AuICWV78LkO+zHe2bcSG71MtnNEgVBR
         EGVRRiOp7aKS/N5iNqHgIba5qLwpg35V14/As+qmTFQw/4Y5UXrbV4nccbqL8QVsN99V
         84gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864051; x=1774468851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71OKjSWJ7h2Q1GFZJc35pK1JHDHtKN/E4Pws9ixreXc=;
        b=G9pVv58m9Lk7DYo3yWW30akRbSJn1mcPpOFefvcvuf6meLn56dmaBf3Y5JGBQxI/KK
         0CUGwek59H2yfZyZ/lAI8Dxqyzi6Y3B8SpCLsT+GHm5/wIRZsGeEW3lwmsOJFTUDc5m4
         xljvSQDZriVDq7FefzHN2yt3tyoFOO4fVYZ8Wk/ExIuPtj6Ou0cgi1VQI/kJMye2477Q
         0GzzThrC74Wi0XzHIolwBmhUtIHV9vtUMJRPKkQm7ukjZBpJbowFFaGTdXLI5OeKkvK4
         eUzh0pQAKT86ZNuvy6cK7LgQNZ8YZcmAgLgtzXHsBMi5KeEdD7vdHSRDHRhV0Py+d2nE
         iuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0yqgW5WahQOJ28j6mw3G+tICSwWa4rg9fP4pS3hQqP2qhcLSGVgdPHO/riimaTdhgzkMg17VI@vger.kernel.org
X-Gm-Message-State: AOJu0YzPL5rLOqiTuepLx0AnNZMzHShSbwlFlf5B7GzLYukcJSLG0Rsa
	RekUgiILWx3/mkD02vOjtjUMLUUrLTkKjdAY2NVamtZli7GLhfwAUrywA0ZrAlEpcFnhNZvRIyS
	W93Qa4RCVve+G7hCwjkgzmBDQJJ1XOrvWnixMOVvo
X-Gm-Gg: ATEYQzwqGEQu7De0FJ4OtIux1v89npg7LCeYE6765gQAwcMDp/rFCvJCnE4ssFTiiPu
	yQYI9ekBzxA7jefcwkHGx9SCDLkq+wvkZvrcjdlWiV5FrLXLkceqHTGrmRxQ4vaXtQrAuwqgjwc
	E6nXmuCtJPqLl9B0ftyFrIJ8q7gSpIDvNQo0O7YBcaFwLTiifwCHCFKnuaFfUa8zarpnMdM/EIj
	DnKxbyMQG3IA13Ny4qHzo9ONLw4AM/wHfiAwCqVJWAOeKyIdr4nx7i22tjkp68iaSkCmJmDcwZN
	m+6LRiy/1dXpVsMyyg==
X-Received: by 2002:a17:903:2a90:b0:2b0:4158:c9d1 with SMTP id
 d9443c01a7336-2b06e3e5bacmr54910065ad.36.1773864050852; Wed, 18 Mar 2026
 13:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com> <20260316213606.374109-6-paul@paul-moore.com>
 <20260318-einsam-sellerie-2d547dd338ee@brauner> <CAOQ4uxhfvS1SCkp504uDuBmgqSEBYaQDDVAm+JY=w_2fKLbQsQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhfvS1SCkp504uDuBmgqSEBYaQDDVAm+JY=w_2fKLbQsQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 16:00:39 -0400
X-Gm-Features: AaiRm50bTirLC51vuYEkGlExlBIJP04T2IlKkXqzaEFW_Rpzh7aQ_TFopQtvPJk
Message-ID: <CAHC9VhS+83FZoyVOV_tKHOBtVSwK76TS-gbc=cKzL5QK1P21Mg@mail.gmail.com>
Subject: Re: [PATCH 1/3] backing_file: store user_path_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 8:07=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Wed, Mar 18, 2026 at 11:57=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > On Mon, Mar 16, 2026 at 05:35:56PM -0400, Paul Moore wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Instead of storing the user_path, store an O_PATH file for the
> > > user_path with the original user file creds and a security context.
> > >
> > > The user_path_file is only exported as a const pointer and its refcnt
> > > is initialized to FILE_REF_DEAD, because it is not a refcounted objec=
t.
> > >
> > > The only caller of file_ref_init() is now open coded, so the helper
> > > is removed.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > Tested-by: Paul Moore <paul@paul-moore.com> (SELinux)
> > > Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com> (EROFS)
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  fs/backing-file.c            | 20 ++++++++------
> > >  fs/erofs/ishare.c            |  6 ++--
> > >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++------=
--
> > >  fs/fuse/passthrough.c        |  3 +-
> > >  fs/internal.h                |  5 ++--
> > >  fs/overlayfs/dir.c           |  3 +-
> > >  fs/overlayfs/file.c          |  1 +
> > >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> > >  include/linux/file_ref.h     | 10 -------
> > >  9 files changed, 90 insertions(+), 40 deletions(-)

...

> > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > index aaa5faaace1e..b7dc94656c44 100644
> > > --- a/fs/file_table.c
> > > +++ b/fs/file_table.c
> > > @@ -56,24 +57,44 @@ struct backing_file {
> > >
> > >  const struct path *backing_file_user_path(const struct file *f)
> > >  {
> > > -     return &backing_file(f)->user_path;
> > > +     return &backing_file(f)->user_path_file.f_path;
> > >  }
> > >  EXPORT_SYMBOL_GPL(backing_file_user_path);
> > >
> > > -void backing_file_set_user_path(struct file *f, const struct path *p=
ath)
> > > +const struct file *backing_file_user_path_file(const struct file *f)
> > >  {
> > > -     backing_file(f)->user_path =3D *path;
> > > +     return &backing_file(f)->user_path_file;
> > > +}
> > > +EXPORT_SYMBOL_GPL(backing_file_user_path_file);
> > > +
> > > +void backing_file_open_user_path(struct file *f, const struct path *=
path)
> >
> > I think this is a bad idea. This should return an error but still
> > WARN_ON(). Just make callers handle that error just like we do
> > everywhere else.
>
> OK.

That's good, I can remove the FMODE_OPENED sanity check in
selinux_file_mprotect() now.

> > > +{
> > > +     /* open an O_PATH file to reference the user path - cannot fail=
 */
> > > +     WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
> > > +}
> > > +EXPORT_SYMBOL_GPL(backing_file_open_user_path);
> > > +
> > > +static void destroy_file(struct file *f)
> > > +{
> > > +     security_file_free(f);
> > > +     put_cred(f->f_cred);
> >
> > Note that calling destroy_file() in this way bypasses
> > security_file_release(). Presumably this doesn't matter because no LSM
> > does a security_alloc_file() for this but it adds a nother wrinkly into
> > the cleanup path.

The alloc_empty_backing_file() function will call init_file() on the
O_PATH file which in turnwill call security_file_alloc().  We depend
on that behavior as we need to set the creds properly on the file.

The tricky bit is that security_file_release() is currently only used
by IMA/EVM; it was created when we folded IMA/EVM into the LSM
framework, making them proper LSMs and cleaning up a lot of the hook
calls in the VFS.  The commit description provides some info on the
hook:

   IMA calculates at file close the new digest of the file content
   and writes it to security.ima, so that appraisal at next file
   access succeeds.

   The new hook cannot return an error and cannot cause the operation
   to be reverted.

As O_PATH files never go through the
security_file_open()/security_file_post_open() path, O_PATH files
should be ignored by IMA/EVM (which makes sense, as there is no data
or xattrs to measure, update, etc.).  For that reason, skipping
security_file_release() should be okay in this particular case.

Other LSMs which allocate file specific state, e.g. AppArmor, in
security_file_alloc() should free that state in security_file_free()
which is handled in Amir's patch.

> This is for Paul to comment on.
> The way I see it, security_file_open() was not called on the user path fi=
le,
> so no reason to call security_file_release()?
>
> It is very much a possibility that LSM would want to allocate security
> context for the user path file during backing_file_mmap, when both files
> are available in context, so that later mprotect() will have this stored
> information in the user path file security context.
>
> But in this case, wouldn't security_file_free() be enough?

See my comments above.  If we wanted to look into removing the
destroy_file() special case for the user_path file hanging off the
backing file I'm happy to work with you guys in the future to sort
that out, but I'd prefer to tackle that at a later date as it could
potentially have a much larger footprint than this patchset.

--=20
paul-moore.com
