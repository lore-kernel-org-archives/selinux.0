Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85D44D020
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033486; cv=pass; b=e73l3F6M8bmIGRrW1gpgdwh0qzdlgFPzA9QkXR9zLXCL3rDdr2+mBjMBmJ5FPjUiTMkqrNJEnA1pPFk30Ems7vaFfnz8ykiXOnwl/o1CSRgFJTOjnp+9eZQi0CZnAK73whbpW7+SMHaAOxh+jMFU5aFNJ6TbnVqeVPdGkir8y5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033486; c=relaxed/simple;
	bh=xMoUgN15xleiLnqYdHWTZOIfOUukA3nDykU5x7/6Z30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkluAQze4hNwavu4c54yenJYtqH2ARJ2D69JuIBq6gp94k9/48YwBaUqaqF2pPFubUp5I6gz7oVbG4iANIwfN4Eb9OwsWB7uaI3uHEUHr8E4te6yQ9hvg5QJBBdROK0jx9HSZGBY+UFAJIKtp9/MknenF3+udcmfHl/or66jQqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmMVJ/ZJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFGBFSfP; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmMVJ/ZJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFGBFSfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784033483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKvsaCFPRUFFmK/V3zdnhQnXrfEi6+6psRpCtWTwSfI=;
	b=hmMVJ/ZJiC+IjFlmXJ4fOzyLEhU7FVns/u1q1FvTROpoApcbz0hxEgzbAdFKbfW2td5lcD
	E4xSdaDMXlUm3JiPB6HcFLEMk4Z0P5IZ0GQ+wfJvpX0O8CjfM3fODvMk2o973AZR4ok/v/
	v8Zi8fgnnso/hIUx95JdeR57yp7x22c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-neQd-B75PxuRtKWyaWO7nw-1; Tue, 14 Jul 2026 08:51:21 -0400
X-MC-Unique: neQd-B75PxuRtKWyaWO7nw-1
X-Mimecast-MFC-AGG-ID: neQd-B75PxuRtKWyaWO7nw_1784033481
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso1067802a91.2
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 05:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784033481; cv=none;
        d=google.com; s=arc-20260327;
        b=G2wsKwVruRvONOfmwLyO8/0FGkI/DTSIu6fK1z6NNRaqukPIu/WtS5uMlaAmNCl3dq
         mnciQ5QDq9NTEUYasNUQ5XZK0onpUp5KauSaydfo9SXevc3xMRF/0ISpKRX3JY+jHubj
         rQ/T0gbQsLzOZCcyDW5GtTX3EYamXojkZ9RRiFdki+wa6i000q7BDRFrLGhj8uGVTxl2
         nHX+czYdjv5adxs/byHRrh2eT6m88zIoR20n+NhEHUFzYTOE5kmXlBaogR6V38WqEMjt
         b0DVfs+nXtXoQ5PBnUPUcDHt+cEQkXtfW+/f7IDOz1s60b9a5IlvUEwi7rINVG+tqRrL
         hf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dKvsaCFPRUFFmK/V3zdnhQnXrfEi6+6psRpCtWTwSfI=;
        fh=P6GFKZYqBY0vUePYUQy4qQoXh7sYpHn7cBQUjfGCMm0=;
        b=nyIYelo/+alYLCGI5QShmgLzEz6CvB5aC+++MswjRhjRKGzVW3MfzKC9CkgAt2g4kA
         6YsMiPOnf834h1jtXNjw6Pr2IwqXjUvll6SkPKpbIclJeJdhA6fxeNNNulRXS6E3KjEa
         YG6Qsv6c/6C8gfAwfWrhDVmhJZRZXoVE0uLQ4KkyzjYWyqiPspoTCNbqF18aaqE2gKM6
         nk06q1M00MdF0Vn1SK+nGDyJImJRK7rtNWd98/0IbUCWEfDiAe3uUGzL4EDluNQWYVpS
         O3dY2tovPIdlfgHp6Luue96Lj0SZJzd/RPyiMaLs5lwo0V4p9hOIewNc9tEgl/gXR7LK
         gN6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784033481; x=1784638281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dKvsaCFPRUFFmK/V3zdnhQnXrfEi6+6psRpCtWTwSfI=;
        b=VFGBFSfP3VqIH8OrrDcUgUiCJRDNRp0yW2qUHs8CvGgxlfMr9Kk1MsFtUGXJ504ZgR
         giGaRvxAWh885e8YNNqo0RO0+TbpTZ2bieZvkjWNlBPhO4I8GkYTguXzmr0IOX9YE0BW
         eNyOKRuMt23LewD1eu1OTksKxxB6dhLn5AwrewwI6Nmz8bbhbodaaN1vP7XYKV3yzvUT
         cWTGfjJk0XhJhWuJmWrYMdWaQaTfEpNVMfOtag8vua5jtUfd5BUmvZ3ZJekO4LKvW5h6
         k5Q9RnmuJoX+P25x0Z0e2t7rsrH3D0OjyyaCIheOee6oifIEcwuvC08Sj9qeCR0S/to5
         IKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784033481; x=1784638281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dKvsaCFPRUFFmK/V3zdnhQnXrfEi6+6psRpCtWTwSfI=;
        b=hpYhd7T+qYWux33C+/EX02KpW6sCMvKAQK9J7dZzqO9w9SqbF4Aq/xlUXl7Og0p1mN
         SQMrLYr4GjMO+jplRgQPw0Ogy5kbpJyWlVHqGITxUrJFiw7KPnF2GGzly7cf7+Dtyuu+
         FdlHBKRNeRr6nFzG+BKa3sAVwFUtOGApEzZRt3wiznNkY42iLMGQQYywf8sCmYSc6fGD
         Z0qfE3sCb/SJEY+vbDlHDVilMhBAVEuwR+MIUe8rjQirncKZml93HTx6wPIoYxI9a37i
         A0Ng6x2H8ZTo1Aez/YqmBbaJuZtEDUn/9x4wMbJVmd2DzGBwezWl1qCFocUT5wvALJ1d
         yvSw==
X-Gm-Message-State: AOJu0Yy85fdUIlJNkGeYTaO5RCOJuuLdLsVaWZaUXZ072QzQpF5+7m30
	gofcdCAMLVcPNq6aSlVXggLS0qi8xDGcNlIyuND1ejGXc7JJWCK3lByAZ7ow79oXhMCpv6qvi9T
	WSVmx41XAdPrPS9Xgwxrz9M05oz7podR2A27sZs1mVwxXzmUK8EwLg5wwIsixLod8GBvWHlKZI0
	fLpLnfCSCRJMr97/KjMXiSzn/Q5Vvk64zdJr7qIB/61g==
X-Gm-Gg: AfdE7cmEHejkUsGuAQBQYCfQdBsrVT++xjvYy/PBfGvgEws+LKR5wgC6zi3Wv7pOEja
	1Z3OYZqcJx53uQYgEZDuQZGVNdaVmjlvQfMhqcS9agb6uUgDOx628lqMHAQ3kxA37hgV1Ft3b7R
	BHOOxJUM3IO1jS8J/z+hqtZEL7k70UUGg6btAv+KInFyVp6tX/UtMKEVjUJ1ypT18eTPg=
X-Received: by 2002:a17:90b:224c:b0:381:b64b:5a28 with SMTP id 98e67ed59e1d1-38dc779eb0bmr10738697a91.30.1784033480626;
        Tue, 14 Jul 2026 05:51:20 -0700 (PDT)
X-Received: by 2002:a17:90b:224c:b0:381:b64b:5a28 with SMTP id
 98e67ed59e1d1-38dc779eb0bmr10738664a91.30.1784033480036; Tue, 14 Jul 2026
 05:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703114733.1243995-1-omosnace@redhat.com> <20260703115632.0761F1F000E9@smtp.kernel.org>
In-Reply-To: <20260703115632.0761F1F000E9@smtp.kernel.org>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 14 Jul 2026 14:51:07 +0200
X-Gm-Features: AUfX_mzIhLonpFxwa-SGutB3olap4kAGAGg8ITrb_wbekx7fRndFBruXmDdqBSQ
Message-ID: <CAFqZXNvckJRNYahj_wpoZ8zyt-PLug1+CA=CQpKaKZ7MVo6QoQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix incorrect execmem checks on overlayfs
To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 2:05=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] SELinux uses `vma->vm_file` instead of `vma_is_anonymous()` to c=
lassify anonymous VMAs, leading to incorrect permission checks.
> --
>
> commit 2446671db8e6a83fbf4c3451f231d685bec26e4e
> Author: Ondrej Mosnacek <omosnace@redhat.com>
>
> selinux: fix incorrect execmem checks on overlayfs
>
> This commit fixes overlayfs mmap() and mprotect() access checks by skippi=
ng
> the execmem check in __file_map_prot_check() during a "mounter check". It
> introduces a boolean to indicate this state, ensuring the check is only
> performed against the calling task's credentials.
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 0f704380a8c81..fca310b7270f3 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> [ ... ]
> > @@ -3988,7 +3989,7 @@ static int __file_map_prot_check(const struct cre=
d *cred,
> >                       inode =3D file_inode(file);
> >       }
> >
> > -     if (default_noexec && prot_exec &&
> > +     if (!mounter_check && default_noexec && prot_exec &&
> >           (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {
>
> [Severity: High]
> This isn't a bug introduced by this patch, but is it correct to rely on
> !file to identify anonymous mappings here?
>
> Using a file pointer to check for anonymous VMAs instead of
> vma_is_anonymous() can misclassify mappings. A private mapping of /dev/ze=
ro
> has vma->vm_file !=3D NULL but is functionally an anonymous mapping. This=
 could
> allow an anonymous mapping to bypass the PROCESS__EXECMEM check.

I don't think this is a problem. There are only a few places where
vma_set_anonymous() is called:
1. mmap_zero_private_success()/mmap_zero_prepare() - this is only
called for MAP_PRIVATE mappings of /dev/zero, where execmem will be
checked if the mapping is writable. If it's not writable, it's the
same situation as creating an RX MAP_PRIVATE mapping of a file that
contains zeros - i.e. the ability to do this will be evaluated by
checking read+execute perms on the /dev/zero inode, which seems better
than treating it as an anonymous mapping.
2. do_mmap_private() - here it is only called when vma->vm_file is NULL.
3. __mmap_new_vma() - here it is only called when vma->vm_file is set to NU=
LL.
4. do_brk_flags() - here it is called for the heap VMA, which is never
file-backed.
5. create_init_stack_vma() - here it is called for the initial stack
VMA, which is never file-backed.

> This same pre-existing pattern appears in selinux_file_mprotect(), which =
uses
> !file to check for anonymous stack mappings:
>
> security/selinux/hooks.c:selinux_file_mprotect() {
>     ...
>     } else if (!file && (vma_is_initial_stack(vma) ||
>                 vma_is_stack_for_current(vma))) {
>     ...
> }

Initial stack shouldn't be file-backed, so that's a non-issue.

> It also applies the FILE__EXECMOD check to the backing file if vma->anon_=
vma
> is set, which would incorrectly check the backing device for /dev/zero:
>
> security/selinux/hooks.c:selinux_file_mprotect() {
>     ...
>     } else if (file && vma->anon_vma) {
>         /* ... */
>         rc =3D __file_has_perm(cred, file, FILE__EXECMOD,
>                              backing_file);
>     ...
> }

The LLM seems to be a bit confused here... The quoted code would check
against the user file (not backing file), and IMHO correctly so. If
the user privately mmaps /dev/zero RW, then modifies the mapping, and
then makes the region executable, it *is* essentially "executing" a
modified version of (possibly overlayed) /dev/zero. And the subsequent
check would then check mounter creds against the backing /dev/zero,
which is also correct.

I don't know, maybe mapping /dev/zero is so close to just doing an
anonymous mapping that it's a bit pointless to take its inodes into
account, but it doesn't seem outright incorrect to me, either.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

