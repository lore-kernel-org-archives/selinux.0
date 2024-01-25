Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BE6EB45
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194373; cv=none; b=f5QmYAKBJvli0NPMDfMFbP0zu7/BaMce/8/alF0NmT912UNkQOGI8ngmTnje3Jvv7ZJLHsZuyWMA27vdy1mEeuELcyGHi5aaZvmqe/WUc6yQOTfMnfKHxsrj9qH8na9GfQOqh2Uf0T7SYWcX+/XwuQJqHh9JSuZx+W0BgsPvcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194373; c=relaxed/simple;
	bh=bzgDu7vIp9CVUqJ982yZiZXMLUe7xrk0A4XDNHejxUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XR+67DOlvmYjSHdHmBkoD7D+l7FiG2nu1PMCleuKgxsMtMaB05nSIX8Q1Xpr3+7o0xzZ5coLU6DFL3r54WDuoKqizHVN5woEl+EbpxKBoVuSIa4xtJncZOkp625IQRneS146wE5FvS3ALoSXUWhYOrAtXVW94UVhIIVS9XNqXpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CE2wERg9; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CE2wERg9"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc2308fe275so5863496276.1
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 06:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706194370; x=1706799170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtnPi1WC9u7crr86e0OGQ24VkQkJWMAthFpFqPZkYPA=;
        b=CE2wERg93579aBglxbSmtApYYW71/y+RZdaGO91SHm7mPTOpnClpFSzC1B3QFQ4bB0
         5cbKd2tp+ST69nn1mLGfQ8HnymmtE3XfhvBKiih4HIGN+unSHaWBRJguztgfEZB0BRY4
         8oA887RpVYHBMxwaezrHeFC+VqqC0c72EWdNfYn+DD9yz7WBbwWcUZzhtH0ndMF5XSRi
         ZrJS6s4ruVRW83adL2X7ErqENFv8mGMB5uAR45I3YIhW18CoaU6IRs39bkuyQ8/++iwi
         8erkVkU9HLibkx5OgPDIBkKA3wfvyj2ZIcH5rE67SqWZiQZT6yAJ/i4ym/CX/gOhdCYT
         OJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194370; x=1706799170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtnPi1WC9u7crr86e0OGQ24VkQkJWMAthFpFqPZkYPA=;
        b=br/jCuspkg3F5fW2TrufSorm1v3J2hdF7CJk5DzxHvCH/GUBtY0q8Wq2vv+9AGpaAc
         4UMn73fpMH/FFgOEoE7jP0ij/xbZbUDO6ceZj3rViQ8AjL+ohVx00sd1r5dmJuHGFv67
         gg1zun2w9paYK01EHiyQ+IBn9EmuGB5I29ES6v/rOqLk6+nBAo/jHBJlFxgZsjTiIGo2
         NbqWct92jD7GLIu+XZypBYonzDJV8z6fksWDY+Vbsmhb9o8Dxl6hDE/0R/dDi/wOt050
         S/0bFMhzsz+0DPmIMkoA8G/90FQu+rEtF023w5q/GokIErwadLfr6PEoFQ2Nh62MEYgR
         5MDA==
X-Gm-Message-State: AOJu0Yxf+Ta5DqVHm5WkF59lcD2WBkr2jYyGUgA2TUMU5Trsu54f2P0I
	vCwCfLJT9U+2T+Ozd+z5RI2grphIxGRHPhIfyLuvSHgfMvLM6JF5mfPCCAponsUpD6njVqPSjem
	MPpoljtUYciph6yKWR7s8HjD4NFf4UX8C0ihFoJGvP3qYEME=
X-Google-Smtp-Source: AGHT+IF0YhPz/X/2UXKbNilPpSOQvfHBZDGBHIsx6f0GNOzYNipX90Lb3oJIFNmVFUaTleUxvzyICIxzOYxTHfWbTLE=
X-Received: by 2002:a5b:bce:0:b0:dc2:2c01:4c6b with SMTP id
 c14-20020a5b0bce000000b00dc22c014c6bmr858569ybr.122.1706194369841; Thu, 25
 Jan 2024 06:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
 <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
 <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com>
 <CAEjxPJ4czKz+4SfTo6g3s6ztSRbfyOv_GBkgp=k38nGDFssRiw@mail.gmail.com> <CAEjxPJ5_SQDmR9b-+0woBLg25omtERSLBKawTV9AqLpZAHFvcg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5_SQDmR9b-+0woBLg25omtERSLBKawTV9AqLpZAHFvcg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jan 2024 09:52:38 -0500
Message-ID: <CAHC9VhT_zOjJpg-JOaJQ4s9ybArfq2Ez_OiFAk0siPiqEC0KiQ@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 9:25=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Jan 25, 2024 at 8:32=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Jan 24, 2024 at 6:59=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > On Wed, Jan 24, 2024 at 3:13=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Wed, Jan 24, 2024 at 1:42=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > So the recent discussion regarding questionable setting of
> > > > > isec->sclass in inode_setxattr and inode_setsecurity that was
> > > > > introduced by the labeled NFS support patch made me wonder about =
the
> > > > > state of the selinux-testsuite nfs tests. Trying to run those on =
a
> > > > > current kernel fails even before getting to the tests themselves
> > > > > because the attempt to relabel the files to test_file_t fails wit=
h
> > > > > Operation not supported errors. Anyone know when this last worked=
?
> > > >
> > > > Looks like this has been reported for Fedora kernels here,
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=3D2257983
> > > > as a regression from 6.6.2 to 6.6.3 and later.
> > >
> > > Thanks for looking into this Stephen.  Unfortunately I can't seem to
> > > access that BZ right now (the FAS login page is hanging for me), has =
a
> > > root cause been identified?
> >
> > So far the bug only contains info from the bug reporter, who narrowed
> > it to a change between the 6.6.2 and 6.6.3 kernels but isn't sure what
> > changes would be relevant there. Looking at the ChangeLog, the one
> > that looks most likely to me is:
> >
> > commit 37dab33f754abd24b384d2b7b07349dc6611381b
> > Author: Ondrej Mosnacek <omosnace@redhat.com>
> > Date:   Tue Oct 31 13:32:07 2023 +0100
> >
> >     lsm: fix default return value for inode_getsecctx
> >
> >     commit b36995b8609a5a8fe5cf259a1ee768fcaed919f8 upstream.
> >
> >     -EOPNOTSUPP is the return value that implements a "no-op" hook, not=
 0.
> >
> >     Without this fix having only the BPF LSM enabled (with no programs
> >     attached) can cause uninitialized variable reads in
> >     nfsd4_encode_fattr(), because the BPF hook returns 0 without touchi=
ng
> >     the 'ctxlen' variable and the corresponding 'contextlen' variable i=
n
> >     nfsd4_encode_fattr() remains uninitialized, yet being treated as va=
lid
> >     based on the 0 return value.
> >
> >     Cc: stable@vger.kernel.org
> >     Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> >     Reported-by: Benjamin Coddington <bcodding@redhat.com>
> >     Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >     Signed-off-by: Paul Moore <paul@paul-moore.com>
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Could that be overriding the SELinux return value and thereby
> > preventing encoding of the SELinux context in the NFS fattr structure
> > returned by the server to the clients?
>
> To answer my own question, yes that's exactly what is happening. In
> every other hook that returns a non-zero default value, we have
> special handling in the security_() wrapper, but
> security_inode_getsecctx() just calls call_int_hook(), which treats
> any non-zero return as failure. So in kernels that enable
> SELinux+BPF-LSM with no BPF program attached to that hook, it will
> always return -EOPNOTSUPP and NFS and any other callers won't use the
> SELinux-provided attribute.

Thanks Stephen.  I will admit that it is slightly amusing that a patch
intending to fix NFS ends up breaking NFS; clearly some additional
testing was needed here.

Ondrej, are you able to post a fix for this?

--=20
paul-moore.com
