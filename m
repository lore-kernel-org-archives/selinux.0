Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080655821E
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189556; cv=none; b=sB6qSzi1Jd9Ti+Di9yJ/9fJNfKxNye0P82q+baE76lTFOMn1pav8K3E8cXDGQXeQh51D17gnJWn3Dd9ribHDCOU/dVB1iMlovpztITXPl4awMjPep+RUKIiXD9ax7t74OUPWcGZrsPxzMS5b7MoIvVpwq1ZcphU74ZiS6aCcvRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189556; c=relaxed/simple;
	bh=8waWGY8r4X/FK85QZr7EGvS4Tx984MKYLSt8kstFxXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Khzb0Hu2P2DcMYA+e85FBycv8FHivw//7nKdapZ/kJYsUBcWPyJtvIbkZK5ngFfQ/3EapEJpDyoqK/nvpc7HUTPr4tHnK9+m5HrfzDDfy/zDuF6y6CG53q/2ZsXjTd53ITLKCV9yHiN4F8M75yu0/lv9+j4uijhP6KVg5iv7PpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCJKMut8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCJKMut8"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so3795535a12.1
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 05:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706189554; x=1706794354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9S/tWJ8nzO8BPaw4y6Ahghp9FYTENcATlHwo6skYXc=;
        b=aCJKMut835Mgxezcd96uw4A9K18hunh2UjELF0nuRJ8qGKowqAL5X9uTr3DC5dOSqU
         Ktf8Ixd+95rcSocSC/+V5YIgOBBu2hFIxFE5/7EDNngW0jcavM3YUcddZCJ98mjKZcfa
         zdONUSfowWHQ32JzMcsZE2625eRCkfGDvfUU77v1AQFj3WkbrEVOuuZMjAKmzEJsN21g
         ggQYug41P6PCmB9tox0I1a8L6yResUex17I+AisUIP6srDc/eRuY96UgYr32I+pMmS7Y
         MjAwbRIRlw/VXhkm6a1KP6LPu03TCEEz4tQVmOEL+RidW2f3hfDc1rc8xi8So7UL6vE+
         fXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706189554; x=1706794354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9S/tWJ8nzO8BPaw4y6Ahghp9FYTENcATlHwo6skYXc=;
        b=tB5+RxhvkBeutObYGeSZfXsUNZ9FoW1tQc5uRME6eGR5frehqEfx5Vff59v+5yoFe9
         MBqPPKJsSGDYID3YU3ytKUwYdkKXXsg8kMbpOxAYDMcRoXOaX3nM8ujikXkCdcahB5Op
         1Q4XCINrJ1qGhrS+H4En3qrG/hVYb3H0YbKVLnoQqW0oDQ9adGhTlne6InWPMND4vWTw
         6QIDLtCUHGIcDDwryDMYPf5H5/pxbI8/IU7l+B/MgTUGNzjeqxpyepY1FIAUt3w6nofI
         T7T+ZyI+j6QMxuB4wYOr1mKgX0BviQboHlJ7PlXEba8GfjeuYIRpNm0wR/4lvJH6wMXm
         WxpA==
X-Gm-Message-State: AOJu0YzARrE/MuvL5Foe3Jl9K4fCA/X88n80b56GKBORSLmtRq1mzUwn
	RyfXELGzxUnZTcMcFW91zMfHbWBK+53OJnhNDiYdLgRECm2417GyGIPLsf4E71OM87v1Gjf8YJ1
	Z7ymd02XwLSZj7KFuGvdkkPpW3M8=
X-Google-Smtp-Source: AGHT+IGg56wS4fCZzCIKgBUVwJTB0xvcVJbeDr2yjbXk7v6A6djvkQ0ZYUJedcuhT2DeBJ0uI4htjI9mPAhe7Zijna8=
X-Received: by 2002:a17:90b:11d4:b0:28c:2b2b:3151 with SMTP id
 gv20-20020a17090b11d400b0028c2b2b3151mr498525pjb.48.1706189554187; Thu, 25
 Jan 2024 05:32:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
 <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com> <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 25 Jan 2024 08:32:23 -0500
Message-ID: <CAEjxPJ4czKz+4SfTo6g3s6ztSRbfyOv_GBkgp=k38nGDFssRiw@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 6:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jan 24, 2024 at 3:13=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Jan 24, 2024 at 1:42=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > So the recent discussion regarding questionable setting of
> > > isec->sclass in inode_setxattr and inode_setsecurity that was
> > > introduced by the labeled NFS support patch made me wonder about the
> > > state of the selinux-testsuite nfs tests. Trying to run those on a
> > > current kernel fails even before getting to the tests themselves
> > > because the attempt to relabel the files to test_file_t fails with
> > > Operation not supported errors. Anyone know when this last worked?
> >
> > Looks like this has been reported for Fedora kernels here,
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2257983
> > as a regression from 6.6.2 to 6.6.3 and later.
>
> Thanks for looking into this Stephen.  Unfortunately I can't seem to
> access that BZ right now (the FAS login page is hanging for me), has a
> root cause been identified?

So far the bug only contains info from the bug reporter, who narrowed
it to a change between the 6.6.2 and 6.6.3 kernels but isn't sure what
changes would be relevant there. Looking at the ChangeLog, the one
that looks most likely to me is:

commit 37dab33f754abd24b384d2b7b07349dc6611381b
Author: Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue Oct 31 13:32:07 2023 +0100

    lsm: fix default return value for inode_getsecctx

    commit b36995b8609a5a8fe5cf259a1ee768fcaed919f8 upstream.

    -EOPNOTSUPP is the return value that implements a "no-op" hook, not 0.

    Without this fix having only the BPF LSM enabled (with no programs
    attached) can cause uninitialized variable reads in
    nfsd4_encode_fattr(), because the BPF hook returns 0 without touching
    the 'ctxlen' variable and the corresponding 'contextlen' variable in
    nfsd4_encode_fattr() remains uninitialized, yet being treated as valid
    based on the 0 return value.

    Cc: stable@vger.kernel.org
    Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
    Reported-by: Benjamin Coddington <bcodding@redhat.com>
    Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
    Signed-off-by: Paul Moore <paul@paul-moore.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Could that be overriding the SELinux return value and thereby
preventing encoding of the SELinux context in the NFS fattr structure
returned by the server to the clients?
