Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7234229C9
	for <selinux@vger.kernel.org>; Thu,  9 Jul 2026 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600391; cv=pass; b=ElKot2JAdHZEGOvjyPGdcJ5dIc4oL3HhzbKdqVzOQ2748TjNwiFBQT7rdBYooW+DNvT54uLl30OlEJ/giZkwCR229cF3KYAwx0VWkYm5MsEShUHqWh3kKcz5P/OUu7vU3UFbXXDBBQghQvQFMstwZxw92zFuWW0gwNsSxxSBZL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600391; c=relaxed/simple;
	bh=TZ4/MUsld9BeNU5QPGcKumrNi2uJrTMz7CYtcX2ZYPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVmqxKHC09TXD1FhArDPnAmiS+9PrbG9c1uWiXaQczIN3DE5hvX5xIHV5WzEigtlgZplZtWahO7ECx7D9Yll04/mcVAGKvbxREtCquo3gWaprdcW52Q1Qz00U8iWNM0AmZg3No6zaVCuJIo828P4OmLOzqwAOi5Pw/hjgWnLCl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN20nwGU; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN20nwGU"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacd69a9c0so21769635ad.1
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2026 05:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783600389; cv=none;
        d=google.com; s=arc-20260327;
        b=e/Rl7q9jIGDVGALKrHMp3Oyn+LbZlWpJeK17r3l0EZeGoTJZHiVOkXaI5V2B0mW6RV
         xLtjefa9QGAS/8Xn3KbQTq2wk768EZiiX9aLWFjU+APJBmCsOqSuHjsgT1pynj8jx+cI
         J3ueMSiRRdHLbFNJH8zTtYDskUPHddSz6XG8rLT5uq6lDUEqUzvkGDN1mUQ45e9u0unq
         aW1yyiXUDoGk7h+LvpHcZX8odliRBwnEjYUE9fRXqIT7ISL925Xb44q6NIu/wk4WL6yh
         hMs5HhcUHI8Qz0ynFJygxzjTU6J4ClVBNG4CRpn4Narqxv1MuSAoOuUrJ7LNoTspNGJh
         vZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wEznrTgLikCU91TRmqiWgIn6d7+4evlXZ/ukCLbpHQY=;
        fh=NDPu9b0Jctd3ZGoY1XpbtI2aPuDXzWUnZm0urJ9b8bQ=;
        b=VkqwdcQIphF5lF+mOZKSeEvLGmMCGnOB5EXJ7dM+hoT6FSFhQNvYt2874VHdhVMJKW
         xjJRiCzCAwdGOicCeB5ZMCSbDi0qFV/OGmQ0RtunOUXoGeCWAmprpT0kUxjASwgPJGwk
         gzocww4HqdHVn2DVDI2w1B4tcjjockga2xwDsRXdrtk/7vW6rptJ9w+6y6cq+5D9wwcB
         4wXVPU2kFPg2a1LUZIO5Xhz/w16drjo7bqSn6HJlql6Wft0046XrKqp/N95MSkIeTVpJ
         iE/0KRPi8+i4Fa4QZ/nTb2+YaCanlW1yI1WK/NBaEc4ngc5yLmZDZL5o68NkDTZTMLNS
         jnUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783600389; x=1784205189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wEznrTgLikCU91TRmqiWgIn6d7+4evlXZ/ukCLbpHQY=;
        b=HN20nwGUQhAlIoFLQB2Y24qqbP6XBylsYfXwv5i/Gq6nh362O9PoY07rXep5aiX4Ja
         A/e5/TLrPEry5ib+HqsNe+m3DTGh2P5PTardH7W8Fg1dWyKoewyzajmz/mvRmOy4uK7v
         IHFLHt2w64+PgFbQj/D4O79bDHxCcv26+AlzLg5XPaGg6A5g6dOM5ipc0dyOGhouczqB
         hAi0ljDFpeMzjj6fg+4Eyw2mCY62fDYeJB9K0V6HRDyfkDbKyGzu7A9UX4evukNTzwuh
         YhqNEgD2bT5xirBqw+jC2+8lEBZx3jCxiLoCFCE0fRgAmz9I2MxGWFC6el6oCjGItdvP
         CJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600389; x=1784205189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wEznrTgLikCU91TRmqiWgIn6d7+4evlXZ/ukCLbpHQY=;
        b=BOUZgYj8U23eLIl6rJ8fdneoBWpe4eicJ7Oi2TglQAMVeRH329Jq9BR7QHpZZpL0vq
         czjTnOshTJDXPdtOxJP54mAIoTVed5ARHZ9erESfqrEG7r4L7IxxyZGNw5KQQA0Ogqpq
         amwL0FJONvZeBZ2ZIgMMF9mpq+FPFORmPkPVSIq8ASBRFNrFxarp9dt9/Cx4QvKHTgrd
         30TVcUgqTKdQlYNT9hDmtLpp5OLCZYq9WCf1s8UvTWOuoDbBTeJqLGx7NOELOU5r0ybM
         jgO3DAA+WNhcPCbCMILc50pPsQLPwOVdcyKtVUI3A2diQPpIZxpM3lTmFepcHaoz4H6S
         ZRkQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQfpoJ0a2voAXkXOSa1p8nPMo0fDBQrh/lP09CWP7jjgAUbVqpbVZU0IiACOrC312WITbcKxMs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9ED85rr8cuat+Jnk08KDGk/Jjk53CE1BWgp9TSBbtxrcFVZX
	FvDtxCSuqkgA7AVlyKnaonIEQMY6Q8OYwTmHRB2Sj24aJjv3t183dAKAqton0XMaxcXOxcW7jTZ
	2jgwkgiU55e9/Ho/GdA+YOi6xSMCgTVM=
X-Gm-Gg: AfdE7cnR5ecDiYrmlIp+sY7SWan25thSJ65weugCaSvHelRf3MUSEHCqIAmuf0tjhpg
	DbOLf8K4VvbkmUlyboARyPrtFB9WeHF5COF5GpPpDZJtgHhzYA4j23JoXjW5Fq6n4Lb2nEFgwsX
	cVh2pXPBhgVBqxGSf0TLtixxzXeA8pWDpPZ3hhKTPQEJB/+BUe2IM4z9aG2sPvd5a+nIkHpOFNK
	s9we50WhdY9sausIBZ8+zthN2d9+JGqNTNtnklGioggMC0Muw6CsjOkGd+cdOjTtqO866TN
X-Received: by 2002:a17:902:fb0d:b0:2ca:f21a:a6c5 with SMTP id
 d9443c01a7336-2ccea34857fmr53376045ad.1.1783600388853; Thu, 09 Jul 2026
 05:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
 <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com> <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Jul 2026 08:32:57 -0400
X-Gm-Features: AVVi8Cd4uZMDN1rLABDX_bWMI0FuplRTPn2H59VH4Frrquyfh8DPbM0M13o1E7I
Message-ID: <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Paul Moore <paul@paul-moore.com>
Cc: Anna Schumaker <anna@kernel.org>, Achilles Gaikwad <achillesgaikwad@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 4:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Jul 8, 2026 at 2:54=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.or=
g> wrote:
> > > > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > > > <achillesgaikwad@gmail.com> wrote:
> > > > >>
> > > > >> A call to listxattr() with a buffer size of 0 returns the actual
> > > > >> size of the buffer needed for a subsequent call. On an NFSv4.2
> > > > >> mount this triggers the following oops:
> > > > >>
> > > > >>   [  399.768687] BUG: kernel NULL pointer dereference, address: =
0000000000000000
> > > > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > > > >>   [  399.768722] Call Trace:
> > > > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > > > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > > > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > > > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > > > >>   [  399.768736]  listxattr+0x23/0x160
> > > > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > > > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > > > >>
> > > > >> security_inode_listsecurity() (via the xattr_list_one() helper) =
now
> > > > >> decrements the remaining size even when the buffer pointer is NU=
LL, so
> > > > >> in the size-query case, 'left' underflows to a huge size_t value=
. As a
> > > > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a r=
eal one,
> > > > >> leading to a NULL pointer dereference in _copy_from_pages().
> > > > >>
> > > > >> security_inode_listsecurity() does not return the number of byte=
s
> > > > >> it added to the list, so the code derived it as
> > > > >> 'size - error - left'. That is also wrong in the size-query case=
:
> > > > >> the generic_listxattr() contribution is only subtracted from 'le=
ft'
> > > > >> when a buffer is present. Thus, the query result comes up short =
by
> > > > >> exactly that contribution (e.g., "system.nfs4_acl" on a mount wi=
th
> > > > >> ACL support), and a caller that allocates the returned size gets
> > > > >> -ERANGE on the subsequent call.
> > > > >>
> > > > >> Declare 'left' as ssize_t, use a scratch copy to measure securit=
y
> > > > >> hook consumption, and only decrement 'left' if a buffer is prese=
nt.
> > > > >>
> > > > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode=
_listsecurity() interface")
> > > > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > > > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > > > >> ---
> > > > >> Changes in v2:
> > > > >>  - Use a scratch variable to track security label size directly,
> > > > >>    replacing the old formula that undercounted the size-query ca=
se.
> > > > >>  - Drop the now-unneeded NULL-buffer special case for
> > > > >>    nfs4_listxattr_nfs4_user().
> > > > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> > > > >>    (the same accounting bug caused both the oops and the underco=
unt).
> > > > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achi=
llesgaikwad@gmail.com/
> > > > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > > > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > >
> > > > > [CC'd the LSM and SELinux lists for visibility]
> > > > >
> > > > > Unfortunately my testing was unsuccessful due to an NFS problem t=
hat
> > > > > started with the v7.2 merge window that I haven't had the time to
> > > > > bisect yet.  Assuming the NFS folks are okay with this change, I
> > > > > figure they will want to send it up to Linus via their tree, if n=
ot
> > > > > let me know and I can send this up via the LSM tree.
> > > >
> > > > Yeah, we'll send it through the NFS tree.
> > >
> > > Thanks Anna.
> > >
> > > > I'll be curious to hear
> > > > what problem you're hitting, and what patch is the culprit once you
> > > > do that bisect!
> > >
> > > Yes, me too :)
> > >
> > > I'm still working through a review backlog so it might be a bit befor=
e
> > > I have a chance, but in case anyone wants to test it out, it's easily
> > > reproduced using the selinux-testsuite and the NFS tests:
> > >
> > > https://github.com/SELinuxProject/selinux-testsuite#nfs
> >
> > They seem to pass for me with and without the patch (they don't
> > exercise listxattr AFAIK).
> > This was on the current selinux/dev branch, v7.2-rc1 based.
>
> They work for me on vanilla v7.1 and fail somewhere before vanilla
> v7.2-rc1 (still bisecting).
>
> I wonder if there is an interaction problem with a recent userspace
> update.  What distro/userspace are you running for your tests?  I'm
> doing my testing on a relatively recent Rawhide.

I was on F44, so yes, it could be a difference in e.g. coreutils or
other userspace on rawhide that is tickling this particular bug.
