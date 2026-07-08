Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602123E5ED1
	for <selinux@vger.kernel.org>; Wed,  8 Jul 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541476; cv=pass; b=mM7xBARY+ADWhKrJU8v2iKOM4ls00UX5cF6SeWE12Pgw0Cr04c1/rEM5nC3k+YR/stbLaZD+5P4SU4bgrHzghVsuos6h4BSjQuGVbEFp+2jrCSKErwkSuLLzDJTsqTwfMZhalWiVsmqQAAagZAznPzU61pSzUpVR0A6IMDS/hCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541476; c=relaxed/simple;
	bh=Fy6qHwAxMBKgI4ys2Q4APPGANBPucrsGbSz4jBFobcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/BOUFRHwr7vbUhMmeAZW7cs9hnQyMG3lz0oQ63Uy0ql8vIywKfCGiPFW0jwY1Wetxy/zlpdITIliXTYrQ5CYcJY4nmAWDEB22vd9U8IhrNKorKN+Ats1/yGpvZS5wcjOGpJql8yLU6VBS8y6HIxT/PKryzyT3e5gkaH8Fcrk54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z4Uw7QTh; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z4Uw7QTh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caed617615so11418625ad.3
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2026 13:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783541468; cv=none;
        d=google.com; s=arc-20260327;
        b=IVGlyQbbinBc+4qsp7pHiPmJOT4aheBe6O9XNPIcrWq8gbjjAr0tyhIqZeZO6BITKB
         nT0JFf3C5JLvwWgo7Hg4Ytc3CXWXoav9kZ4ADjgwgXWmygKnAkCn08Yz5ZXsIKGMw+jz
         X6gsnKoVreT2htehI4lmbrAMfB/ooH0HnYIN+lopaRcgHwtvY6rgRGuOuMbWAjERGD+D
         ACjZ8Pk5Rkxk6G5yWAFj4Qv3YAYo5zhTuRxfCVyEgg8914dnBS6NAzaYQb/FPcSLfeKK
         989tbgXz8PZffWg4lJ3Tt0gD3io3MqfQtuRc5xRjox9gftbf+cSpzDN5YxbqOQlnOgy+
         Hbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SX6q4fztsZP6iSk58v5T5RdgQrRxRC3vIHoyseYXr/w=;
        fh=4etn5tUA28GrffUAuUm5zLtYQL3GsDrJKajQrgdtcNU=;
        b=gsJ8nZi+Idlfo8FGpn9Tqd5bCSlg6j52cQ0TAq9nx05UsDZrRGkF9zQ2Ip2pKsQwnH
         2BO2tFbLre2Nb8mSj0Rdi2uQy8ed/+yKYd2d6w4m3wSro1tStebSbb7gRu0VHm6eYmyK
         GbW+pGUZc+11U4e/WeCHxIL7KvVwP39OGXoa2dgLnxQBKSgPhaJpZygY4jH7ISa62kzt
         pNsr2xNaoUYp+R9ZTvnz2n/po8DD8RwfB4f0H+IEol4f5tCxzenkb/r1P53ZjKByNEEJ
         QiRmUcJjxodmo7eKgX3cojcvgVkvrWN5sLS08ehuzA+PdCZUBmbayOBKsutSGSds3J6S
         YXjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783541468; x=1784146268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SX6q4fztsZP6iSk58v5T5RdgQrRxRC3vIHoyseYXr/w=;
        b=Z4Uw7QThiTeLmGGlWNX9W5FqapTdXmaSETNDj1euK/4eD+uHj0wF+eJ7QiN+Z9Zb2n
         NklKrHPmx95uaXG2dMJzd6/wLBTcE48GXp8e8wEhjurUdaF2di8b8a1sNz636/+2ZZU5
         lXxbUSQRdvpvAqa4MDFpM2ZScMaVOwu7pDCZegINDpA60wtt2sxzY+6r1zW0EDjis3Zv
         7twndEUexWygWWqdo8PDnjz2v81gxchpJ9gE7asxoGmMxvUWwGc/Gs5zKs7+EsJG8b2E
         9rqIxygMv4BhV2W1dDC7hFH8qi1nZv0kEiaJkvHVY7iZrY902kd34zRyvjiyvRWY9nxC
         Ymyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783541468; x=1784146268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SX6q4fztsZP6iSk58v5T5RdgQrRxRC3vIHoyseYXr/w=;
        b=E4GFfK2RopiGTVxiaMNtXWH2tYN/tivkC9iNJsIn5Lq6hOJytErlqQcFH0R8Tpmg3z
         IIpT8pZD571x2UE98uevzgvZ1VHDBudbZGXaR0I/5xDXIOIyElhmpeoMOgLbRpcjq8BO
         TvXhYQvQSXDP799surKp5ychMcye1AEsY3FpwVxYuHqumxumrEjyq/bQymPHFmM8xc0y
         QiOXO2CmwjIE7ebNgZ6EH7N5/rL9RZGyOV5P04Yeuu3f+1VB1UouHX5rp3gOmz07BoMo
         Ewj7qPHiSZIGfpQ6DteAGngI2GPuvtmwJmx5UkpRJTdxwILKJRi8w7O+lwU+lZpCOOdv
         /lLw==
X-Forwarded-Encrypted: i=1; AHgh+RoLWpXeQ7u3H+xtJ+1JYx3MXnJFsF4vN7MjAWWsz2B9qXcRm4w1fNQWiH7AXh5651biqh6VmVPU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9aEX9GOJb6mTo1Y7FbLIHVNmyHX4IOorHRVKjEhu2w7ZEJWL
	vW3sdzo+lJz7nVY31BGLVUpTeIMYie8ncCnrj50z50cxePCLFBHUQcGjB4OtUET1URLLPechDHo
	prhH6drH6sR358CL/vqWgr6/CfDOw/Xt3mJwv8pCQ
X-Gm-Gg: AfdE7ckWfiF2YxcB8uBjKvzIW6vQuElKWfrGykfnvHvu6L0BlxtX1JHAljk5OwTL12X
	Nhkvcvf77LuRTMLGoyzyMF99H5lKllvd8rxsZvwxMqGxmYc/bPUUDse4qKhJ4l5A0nLyFbcopkG
	xAn1+Rg5L6lqyM1TMTbsecMfxxgfvvGBpygoYk0QVT3xWCJxv8HyAOi+V3TR9MzhzCKWnS4xrP4
	DR4lpKItFmdBn7+/pKnd6tfJyCqg6/ZtCx+Askk9pgQCgSaeJ2CtGcKBHH2z/BG17OGXcZl
X-Received: by 2002:a17:902:eccb:b0:2ca:d7a0:1318 with SMTP id
 d9443c01a7336-2ccea3ab636mr36736505ad.11.1783541467977; Wed, 08 Jul 2026
 13:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
 <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Jul 2026 16:10:55 -0400
X-Gm-Features: AVVi8Cd4qoj8FowNXz9SQ-0VNk5KpjXCV9um-QDkJOYlORaYRve8VAb1A0UZ88M
Message-ID: <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Anna Schumaker <anna@kernel.org>, Achilles Gaikwad <achillesgaikwad@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 2:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.org>=
 wrote:
> > > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > > <achillesgaikwad@gmail.com> wrote:
> > > >>
> > > >> A call to listxattr() with a buffer size of 0 returns the actual
> > > >> size of the buffer needed for a subsequent call. On an NFSv4.2
> > > >> mount this triggers the following oops:
> > > >>
> > > >>   [  399.768687] BUG: kernel NULL pointer dereference, address: 00=
00000000000000
> > > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > > >>   [  399.768722] Call Trace:
> > > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > > >>   [  399.768736]  listxattr+0x23/0x160
> > > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > > >>
> > > >> security_inode_listsecurity() (via the xattr_list_one() helper) no=
w
> > > >> decrements the remaining size even when the buffer pointer is NULL=
, so
> > > >> in the size-query case, 'left' underflows to a huge size_t value. =
As a
> > > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a rea=
l one,
> > > >> leading to a NULL pointer dereference in _copy_from_pages().
> > > >>
> > > >> security_inode_listsecurity() does not return the number of bytes
> > > >> it added to the list, so the code derived it as
> > > >> 'size - error - left'. That is also wrong in the size-query case:
> > > >> the generic_listxattr() contribution is only subtracted from 'left=
'
> > > >> when a buffer is present. Thus, the query result comes up short by
> > > >> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
> > > >> ACL support), and a caller that allocates the returned size gets
> > > >> -ERANGE on the subsequent call.
> > > >>
> > > >> Declare 'left' as ssize_t, use a scratch copy to measure security
> > > >> hook consumption, and only decrement 'left' if a buffer is present=
.
> > > >>
> > > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_l=
istsecurity() interface")
> > > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > > >> ---
> > > >> Changes in v2:
> > > >>  - Use a scratch variable to track security label size directly,
> > > >>    replacing the old formula that undercounted the size-query case=
.
> > > >>  - Drop the now-unneeded NULL-buffer special case for
> > > >>    nfs4_listxattr_nfs4_user().
> > > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> > > >>    (the same accounting bug caused both the oops and the undercoun=
t).
> > > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achill=
esgaikwad@gmail.com/
> > > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > [CC'd the LSM and SELinux lists for visibility]
> > > >
> > > > Unfortunately my testing was unsuccessful due to an NFS problem tha=
t
> > > > started with the v7.2 merge window that I haven't had the time to
> > > > bisect yet.  Assuming the NFS folks are okay with this change, I
> > > > figure they will want to send it up to Linus via their tree, if not
> > > > let me know and I can send this up via the LSM tree.
> > >
> > > Yeah, we'll send it through the NFS tree.
> >
> > Thanks Anna.
> >
> > > I'll be curious to hear
> > > what problem you're hitting, and what patch is the culprit once you
> > > do that bisect!
> >
> > Yes, me too :)
> >
> > I'm still working through a review backlog so it might be a bit before
> > I have a chance, but in case anyone wants to test it out, it's easily
> > reproduced using the selinux-testsuite and the NFS tests:
> >
> > https://github.com/SELinuxProject/selinux-testsuite#nfs
>
> They seem to pass for me with and without the patch (they don't
> exercise listxattr AFAIK).
> This was on the current selinux/dev branch, v7.2-rc1 based.

They work for me on vanilla v7.1 and fail somewhere before vanilla
v7.2-rc1 (still bisecting).

I wonder if there is an interaction problem with a recent userspace
update.  What distro/userspace are you running for your tests?  I'm
doing my testing on a relatively recent Rawhide.

--=20
paul-moore.com
