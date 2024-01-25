Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319C6634E0
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192723; cv=none; b=YuRwaRV+OWGLPCOUp9ytObtTqvpTin64X4wz9gT+ROzORlBpApe68Xr2MvV+LcOLjuzQr2EWnw4yvx7YBvVYpxa2XMnJhiYrmMPBynA8dUWMwoZmfbtisQEK+wXAszzordn34j3CxXKXkL7Vo9qieCtsxNiZFc+IqVSM9UkytDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192723; c=relaxed/simple;
	bh=+lMBXlyvVKex6Wd6nwqXoXdFbeHp2mduX9erQX0h878=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkoXyU/eEs3SaXtWpdp2DgtW2s2Ka795uL+88PLc/wu+ICZTDoFL4YztcwBr7KfUX6rqj7Xj4Ep2DFuKYacrYKUXW21AwvtgR1ilzWwpN3C1f1N02JbGYW8tVcFKD7buijspahyUOg8ABlsQA2I8gxQjcT3H8+GgY4ErlJQTPmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngcQ9Hso; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngcQ9Hso"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2901ac9ba23so3885534a91.3
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 06:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706192721; x=1706797521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUF013xhWGdCC19obLwDlMD+Ett8F9qkr3pq43xi2nE=;
        b=ngcQ9Hso3qlgMqaXqoXEWJI8pw8AYmTPiLAC/wO5Gu+cYMPWD2pkut+GaTeTiYMeJq
         nZQrYIJXyF2ngDDiqT8sasB17O4Rn+MJK0LGiLxe+zvBvlY6qPr8hvHoCyqdQOobfi+P
         wM0oQvjfRbxv6POUROUrwaQlL29q4tKnof5RP2U1uwTN5mnpV66TyaipvNjx7/x7+z4F
         6vZ4lKY2m0GSBal4SusHp5jDtOjcYi8VHqeCPxSyusq5SEQqcZ3/FnioauGL0rOsRABx
         WUP72yBn94t20uNgVeWgCMRMDkD5WiGzJRNZSXzB8MLTxUkZiXNGc2S8RmQmNXYBvITS
         /ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706192721; x=1706797521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUF013xhWGdCC19obLwDlMD+Ett8F9qkr3pq43xi2nE=;
        b=mvsSRNKjS9BYIy5H5qo+IhF3nuYRPAUwUP5Zg0aalQ3e4MD89GXWaZCbHfRlaYgsU8
         Y1ZYvh6d8UcNgqHLBQcae7PB9uMKXVtWCFonGX8bvVaxXmS1uB4PMDd0WRok/Txw8ERb
         j/15mdR3AZKfV9pbPXSNLEGXcOn89wV+aQm6fDXj/lTuCVvEbEpRBW64fzqW7kZgQIDi
         EGgkTlVYh/Kt3I0s7QEymGxgqQb4AHxACt+BR2pU1PyXuZDKhKwp20Ir2VgXhUBnrcFv
         hipjG09C9QKctBJaJ7ieHzU1tGZ3XxTgKro9N5gdPNPIQInHC2FyJ3t372ckqbTeNbt6
         3mVw==
X-Gm-Message-State: AOJu0YwpzFg2hIXM+Gf+CZ10ZwhlOrrdZEhfrvRVf2OVQihFIsezigdD
	ohYVZCE6bMmo1JWOS08HXf5qLEBZZUEFFoVUY/DOHH02FIJx5ADjp5zZCsHgm2rH66LFkSnHg1r
	/JBxpcg8uE/wt+frpiIqEHBC5FPs=
X-Google-Smtp-Source: AGHT+IFkCx2sfZbAg2FNkijMA0qTkqe91+xvKEp1x6NpL2ieqk/3EXv+HNn6l4VXkmWNVuIr48FROHQH+BYnv1MdUv0=
X-Received: by 2002:a17:90b:515:b0:28c:15dc:c13f with SMTP id
 r21-20020a17090b051500b0028c15dcc13fmr636876pjz.10.1706192721387; Thu, 25 Jan
 2024 06:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
 <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
 <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com> <CAEjxPJ4czKz+4SfTo6g3s6ztSRbfyOv_GBkgp=k38nGDFssRiw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4czKz+4SfTo6g3s6ztSRbfyOv_GBkgp=k38nGDFssRiw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 25 Jan 2024 09:25:10 -0500
Message-ID: <CAEjxPJ5_SQDmR9b-+0woBLg25omtERSLBKawTV9AqLpZAHFvcg@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:32=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jan 24, 2024 at 6:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Wed, Jan 24, 2024 at 3:13=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Jan 24, 2024 at 1:42=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > So the recent discussion regarding questionable setting of
> > > > isec->sclass in inode_setxattr and inode_setsecurity that was
> > > > introduced by the labeled NFS support patch made me wonder about th=
e
> > > > state of the selinux-testsuite nfs tests. Trying to run those on a
> > > > current kernel fails even before getting to the tests themselves
> > > > because the attempt to relabel the files to test_file_t fails with
> > > > Operation not supported errors. Anyone know when this last worked?
> > >
> > > Looks like this has been reported for Fedora kernels here,
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D2257983
> > > as a regression from 6.6.2 to 6.6.3 and later.
> >
> > Thanks for looking into this Stephen.  Unfortunately I can't seem to
> > access that BZ right now (the FAS login page is hanging for me), has a
> > root cause been identified?
>
> So far the bug only contains info from the bug reporter, who narrowed
> it to a change between the 6.6.2 and 6.6.3 kernels but isn't sure what
> changes would be relevant there. Looking at the ChangeLog, the one
> that looks most likely to me is:
>
> commit 37dab33f754abd24b384d2b7b07349dc6611381b
> Author: Ondrej Mosnacek <omosnace@redhat.com>
> Date:   Tue Oct 31 13:32:07 2023 +0100
>
>     lsm: fix default return value for inode_getsecctx
>
>     commit b36995b8609a5a8fe5cf259a1ee768fcaed919f8 upstream.
>
>     -EOPNOTSUPP is the return value that implements a "no-op" hook, not 0=
.
>
>     Without this fix having only the BPF LSM enabled (with no programs
>     attached) can cause uninitialized variable reads in
>     nfsd4_encode_fattr(), because the BPF hook returns 0 without touching
>     the 'ctxlen' variable and the corresponding 'contextlen' variable in
>     nfsd4_encode_fattr() remains uninitialized, yet being treated as vali=
d
>     based on the 0 return value.
>
>     Cc: stable@vger.kernel.org
>     Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
>     Reported-by: Benjamin Coddington <bcodding@redhat.com>
>     Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>     Signed-off-by: Paul Moore <paul@paul-moore.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Could that be overriding the SELinux return value and thereby
> preventing encoding of the SELinux context in the NFS fattr structure
> returned by the server to the clients?

To answer my own question, yes that's exactly what is happening. In
every other hook that returns a non-zero default value, we have
special handling in the security_() wrapper, but
security_inode_getsecctx() just calls call_int_hook(), which treats
any non-zero return as failure. So in kernels that enable
SELinux+BPF-LSM with no BPF program attached to that hook, it will
always return -EOPNOTSUPP and NFS and any other callers won't use the
SELinux-provided attribute.
