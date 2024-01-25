Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47763417
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195708; cv=none; b=oBFSMD4EOUSE8ySJhKcWX1299UMtWGzBG20DrzrXj+2CTs+G6loR4QXf8l72yisvGw0rdvtgo8Dt580JCi/LSYWlA1tMxCdiNAKNlCJOpodgxjHl6nHG3sRZ/daQ5hqObRZR1rpVco41bC28lKGZxQQFUsI8RAYfeVk3iGwFWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195708; c=relaxed/simple;
	bh=Ybx65MnTEZUWWw+mgkUY+7njv2BJTaZYzKubiJMykwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5vhvPpee3xzQEmvEjmTJpajMVjRuW+71BXuwNVcgSXtgViKMNIlvHVLx8SEobIKtQMxVRo0yJ6LArDkjY6cZXDQp48I5KGPDKvVLr5UZpqYE5rKuuz0opptAon/GRmolT+IWp/WFM3Thi9k5wQ8qro0x5i1mp0V5HIKfg+fV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RM+MCfxR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RM+MCfxR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706195705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut52KKcTMMVsw1qT+/NcVtBJW8FfgJmMHIHNb9UkamU=;
	b=RM+MCfxRFbgq5sxShlpW0qEQrtciLSgUml/bJXdTVgKie6KFPuZAkvAKYWke/lpLjLkJk8
	b2oQ9O/vLO4uIJzY8o41N0XXK70i/PUMZtVaeRfORXDsXSg7uD5PYZpuY8kd39Lb1NXaIu
	2Ykcl9veMgfGXpqZgB0vhQ0RRg6AG+M=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-De7LrKejN5qDbFs-o8Or7A-1; Thu, 25 Jan 2024 10:15:03 -0500
X-MC-Unique: De7LrKejN5qDbFs-o8Or7A-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ca5b61c841so2879083a12.3
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 07:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195702; x=1706800502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ut52KKcTMMVsw1qT+/NcVtBJW8FfgJmMHIHNb9UkamU=;
        b=qj0IkreSYBaPY3Cdr4osqoNio/2pmve4sQGkPSt6jDYKzzdfUL2v7nguCyU8VyLTc3
         jD5OUAgXP8lshPNLGOq4rb79NvXXjV2CjuFU2O/pp6eCBNzXueLnbUxGGSwm63eU2IWM
         mVR0VDdM617JlhidnWrbrkejKPAZCgkaSU+dAwjBQW9WGG+T4N6Uq/lG1b5cKFDLeiVw
         GlrOSdgJ+W/QU30KR8GDjGPHctHixg+wlbt4bWOPzwFyhPoGmYVXlaxIK4SZESiWQyCs
         QbsDI9hNQe/D6eRVRQszWHqVvLVdhjRHV+DmXb2bghWDEI+w8ZzYYADTdr3oVexFELG2
         tvGg==
X-Gm-Message-State: AOJu0Yx/pShp3+sr5su90X9wUBo+hoNccILXJ7kzMEAElm9pjaQbsK9Y
	skV77cL3+T/HoY6mFrWb19FWIC2Lr1UCqGgrCcy43PsWaVYiTe9SQCJ9kOMfUBt8al6uDFS6afL
	HUPYyi7p2aumXJfHYQ/o4oF0fqg9eFv5tfd5jJo12Zg0I4d9z+MfMQ8/u2Todec5lcQCsMHQmHo
	7p8pu4mSb/rmm8XIUjBuFsMrEMP7ZmuVK2gfqLoIQT
X-Received: by 2002:a17:90a:9f82:b0:28e:740b:6680 with SMTP id o2-20020a17090a9f8200b0028e740b6680mr861407pjp.61.1706195702254;
        Thu, 25 Jan 2024 07:15:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiESCT6CsRwn0tJgHbUadVBNggybS7IIFT0isYHEo67SU+Blxc1FCqYwpA47ZwJjN1Air2/Rjt2NKWl7F89go=
X-Received: by 2002:a17:90a:9f82:b0:28e:740b:6680 with SMTP id
 o2-20020a17090a9f8200b0028e740b6680mr861393pjp.61.1706195701922; Thu, 25 Jan
 2024 07:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
 <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
 <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com>
 <CAEjxPJ4czKz+4SfTo6g3s6ztSRbfyOv_GBkgp=k38nGDFssRiw@mail.gmail.com>
 <CAEjxPJ5_SQDmR9b-+0woBLg25omtERSLBKawTV9AqLpZAHFvcg@mail.gmail.com> <CAHC9VhT_zOjJpg-JOaJQ4s9ybArfq2Ez_OiFAk0siPiqEC0KiQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT_zOjJpg-JOaJQ4s9ybArfq2Ez_OiFAk0siPiqEC0KiQ@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 25 Jan 2024 16:14:50 +0100
Message-ID: <CAFqZXNvSn-Ct04ghSxiceKkRBgfyUeWJc3J0tjnU-Mm8mfPtAg@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jan 25, 2024 at 9:25=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Jan 25, 2024 at 8:32=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Jan 24, 2024 at 6:59=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > On Wed, Jan 24, 2024 at 3:13=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > On Wed, Jan 24, 2024 at 1:42=E2=80=AFPM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > So the recent discussion regarding questionable setting of
> > > > > > isec->sclass in inode_setxattr and inode_setsecurity that was
> > > > > > introduced by the labeled NFS support patch made me wonder abou=
t the
> > > > > > state of the selinux-testsuite nfs tests. Trying to run those o=
n a
> > > > > > current kernel fails even before getting to the tests themselve=
s
> > > > > > because the attempt to relabel the files to test_file_t fails w=
ith
> > > > > > Operation not supported errors. Anyone know when this last work=
ed?
> > > > >
> > > > > Looks like this has been reported for Fedora kernels here,
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=3D2257983
> > > > > as a regression from 6.6.2 to 6.6.3 and later.
> > > >
> > > > Thanks for looking into this Stephen.  Unfortunately I can't seem t=
o
> > > > access that BZ right now (the FAS login page is hanging for me), ha=
s a
> > > > root cause been identified?
> > >
> > > So far the bug only contains info from the bug reporter, who narrowed
> > > it to a change between the 6.6.2 and 6.6.3 kernels but isn't sure wha=
t
> > > changes would be relevant there. Looking at the ChangeLog, the one
> > > that looks most likely to me is:
> > >
> > > commit 37dab33f754abd24b384d2b7b07349dc6611381b
> > > Author: Ondrej Mosnacek <omosnace@redhat.com>
> > > Date:   Tue Oct 31 13:32:07 2023 +0100
> > >
> > >     lsm: fix default return value for inode_getsecctx
> > >
> > >     commit b36995b8609a5a8fe5cf259a1ee768fcaed919f8 upstream.
> > >
> > >     -EOPNOTSUPP is the return value that implements a "no-op" hook, n=
ot 0.
> > >
> > >     Without this fix having only the BPF LSM enabled (with no program=
s
> > >     attached) can cause uninitialized variable reads in
> > >     nfsd4_encode_fattr(), because the BPF hook returns 0 without touc=
hing
> > >     the 'ctxlen' variable and the corresponding 'contextlen' variable=
 in
> > >     nfsd4_encode_fattr() remains uninitialized, yet being treated as =
valid
> > >     based on the 0 return value.
> > >
> > >     Cc: stable@vger.kernel.org
> > >     Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks=
")
> > >     Reported-by: Benjamin Coddington <bcodding@redhat.com>
> > >     Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > >     Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > Could that be overriding the SELinux return value and thereby
> > > preventing encoding of the SELinux context in the NFS fattr structure
> > > returned by the server to the clients?
> >
> > To answer my own question, yes that's exactly what is happening. In
> > every other hook that returns a non-zero default value, we have
> > special handling in the security_() wrapper, but
> > security_inode_getsecctx() just calls call_int_hook(), which treats
> > any non-zero return as failure. So in kernels that enable
> > SELinux+BPF-LSM with no BPF program attached to that hook, it will
> > always return -EOPNOTSUPP and NFS and any other callers won't use the
> > SELinux-provided attribute.
>
> Thanks Stephen.  I will admit that it is slightly amusing that a patch
> intending to fix NFS ends up breaking NFS; clearly some additional
> testing was needed here.
>
> Ondrej, are you able to post a fix for this?

Yes, I'm on it. I already have a candidate fix, but my kernel building
infra is currently acting up, so it might take a while before I'm able
to test & post it.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

