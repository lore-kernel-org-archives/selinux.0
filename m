Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255943935C
	for <selinux@vger.kernel.org>; Wed,  8 Jul 2026 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536892; cv=pass; b=BiwaNgHdj42txfvDY0tqDd1jM6487HQYoILqp2guNeU+5zEgZEt+Q8mSgiduVRn/Z+urLZJxG0tkspHePeGK33ci3b8JBs6kIn9BJEETunE+3fhYIrS3Jzby6b3osLNWKiteEbnFezrS76UGxyiCQD7NeyMexd1uIAGfNSQCmPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536892; c=relaxed/simple;
	bh=HIp2gn9sh7sB0Bb61etjWKhYAyLkUkA04rRyBq8mqLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrM/Y0soNdsZ9nejobqdg9zbgsVqHTNjrO7oIvc61L/PuwGfN21U28H6sNP3AJDGODNOWXmilIsbGe+XxyNvhwmzu2MZ1FfGXzbablL4Eys/y5dDlDiKiKuoy/+eicL4m6rEsFj9Eh8b69we0gvwXaF43Vyjla0LFf0jFU6Exlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa8s5DZH; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa8s5DZH"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848468368c8so620538b3a.1
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2026 11:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783536890; cv=none;
        d=google.com; s=arc-20260327;
        b=J2p4By15Za+/6y8rw8jTf04yjHTWD4atEqEhLJf5QjlczZe28Aj0VOCEQG+gGY10ay
         ghO9YWVAa+pVP3MdZHO+iQurHBqfEYqvIn6123MUto7zJSr8rWRzRlXW2qp9/3NaKayw
         a5L5+GOcnk5O5ef8OS6LHJIkQ20MDMvftNCNT+v/b5lHSW7plNLJCVguTwiLPz9zKuFA
         SfAo5C/7REWhkIjJH0VpaEI9jToWXHS/K0GwNPwNuo8ijzGvKkNx5kbN0Rfx9viL8/9H
         lg37RcOlvm/L1nxzdMSpQ3Ko1a1RWI6D3Z2KzdOhn5f9TgbKzDVNXfaJ3lB75anGNUKx
         28BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7lKMvsHAdlcJL6bttrObkjfzU3lsz5RawqcSntxvxnU=;
        fh=bsgug6c4MImEf5KPrjKlThY5JkbNbndgK5XBHpRLr6M=;
        b=PuFcJgkhocNdTrs3boH961pT07k/cxk8+9SDBH6uEPYbSzr5DQI+LOmY4hhmt06JrL
         iXBPRuqLAJ8cL0vjXLWQMt56Szcn+9k1DkHC44jvdbCWNuuzTey15iIwnBKBfBpI8qYp
         2CYC1A1GzbwmZzfDvYoGyVXljvHjUQskL5+qdPxFJ9NtpApu1nYknl7BQ5ybXhUsI3y5
         YJdLShIGQDFUScg6boILk+6RQNWL0JNfhqp/eiOv7NjwHoaoiRYSlVn4kMD4vE3aFkID
         2SMJJKOQ61w7Ibl9NR9ae5Qr7PZT4THYyrMqdrx4PF+hGY9Fgu75tBiFQkL9aUzMRe17
         3ygA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783536890; x=1784141690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7lKMvsHAdlcJL6bttrObkjfzU3lsz5RawqcSntxvxnU=;
        b=Sa8s5DZH6SObVhV9JF7GuREEHXd5fbZYLVFJ8WqJnwmPCZ9+YplxU1p2KNE9//wFgp
         LibaQT/mjE67u4DIEVIBNosAXw4A67HSDgtsI7Xwh1+D7x2y6UBL5dcLTIfsGEq1g2WK
         5pwLtEU/xFAgaRLhkD9fLns2J37SYjQndn5RzgoUp3WjNwzYFIGjrj8aveJePf2ECTnl
         FimhM/vM4RvoqmVaGFjLAciFC/HkRkRjQtxbZ9CES+n0CeGcZjshH+FBu2gGwHAf1RgG
         6AOrrF0wYYSYqkPQd0TlvxxbBONV2JW02Hzbyec95kRYulxl1mvRV2bH0jevmZHsT+y7
         vMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783536890; x=1784141690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lKMvsHAdlcJL6bttrObkjfzU3lsz5RawqcSntxvxnU=;
        b=pZgk0k5x26crJrv5/iYno79XNLkS25y7KqD9iA1b2Srey5H/GoZ1RKFmDaxshvZEg9
         XjIHDpqE33v4/OopKAtN3HEGG5CtrnpqFmpm/H/itOxnxiLWjMW5MU35oDG01yXwzqlv
         gurUI8+MCs4zJXyFIcjSJ22ddbIGg0jaUjWZeFUF1VxQc26aXVFx006aHUoOr1JD4XaD
         4AEWA5g5jDPuzFcEXDQ6SzzfWJxTIPsdJ1fcmEIPeKCWlvXHLIul8Z2jGeXWwtu1qteL
         DsXmt2dFhlKIkoB+fltaNfx1z8udo4ApBy4dQo3b5lvdb1JA6lkPsSjQYc9yD+Cvtdlv
         Ow6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpC5/+RvXWZYiryD88wvezNwTdXalkcvhVumpVyDNLp0EIPjHaMc9KRSe4xeP5UC2jFV2l3HNrt@vger.kernel.org
X-Gm-Message-State: AOJu0YzsR2HbDfrLIFW1UUiGtP3TIZCMKOXRnCAUWz98kDOl7Vyo9mkw
	xZrB1KUxb0NrpZp81mn0Wz5hwChDO6+Wdfv7nTfLYE60xBk4yLctIa+eQ5eff0KTBtLDEFDz1sM
	Bh9VhCFSB5Zr8y7m8De7kTtUEGTvhOhU=
X-Gm-Gg: AfdE7ckBXyecJiHx2A9/17CVlZ8eowDQBL1MvccBX5ODQfkfidbuWBZleh1uPSibYGs
	vHCnVac9MXLm82/hXlOge93tuQIPJdFJkIRITeR618V5gUFB1UImgq9TmjKM2b5bM46nNPm2sit
	kCjN0YJJmyP8hEoInyxxW47JpoJmjmP6tqBWJP2KrC9yc7AWkJ79q9cqKPG3j/b8FVmDRfHQF2k
	GZ11Gs1srjHhNjb2NCHdFiDkcta1whc2Oe2aByat1fsraUPD8p9rW/OFEhTgiCz1THRjDV0
X-Received: by 2002:a05:6a20:2591:b0:3c0:9c19:6598 with SMTP id
 adf61e73a8af0-3c0bd1b0c2emr4467346637.64.1783536890086; Wed, 08 Jul 2026
 11:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
In-Reply-To: <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 8 Jul 2026 14:54:39 -0400
X-Gm-Features: AVVi8CeDAYkaxOnVyk4GN4AJWFNgHCAUe8gsZ6CyBP4XvVdF15boW7cTak8LeSY
Message-ID: <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Paul Moore <paul@paul-moore.com>
Cc: Anna Schumaker <anna@kernel.org>, Achilles Gaikwad <achillesgaikwad@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.org> w=
rote:
> > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > <achillesgaikwad@gmail.com> wrote:
> > >>
> > >> A call to listxattr() with a buffer size of 0 returns the actual
> > >> size of the buffer needed for a subsequent call. On an NFSv4.2
> > >> mount this triggers the following oops:
> > >>
> > >>   [  399.768687] BUG: kernel NULL pointer dereference, address: 0000=
000000000000
> > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > >>   [  399.768722] Call Trace:
> > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > >>   [  399.768736]  listxattr+0x23/0x160
> > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > >>
> > >> security_inode_listsecurity() (via the xattr_list_one() helper) now
> > >> decrements the remaining size even when the buffer pointer is NULL, =
so
> > >> in the size-query case, 'left' underflows to a huge size_t value. As=
 a
> > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a real =
one,
> > >> leading to a NULL pointer dereference in _copy_from_pages().
> > >>
> > >> security_inode_listsecurity() does not return the number of bytes
> > >> it added to the list, so the code derived it as
> > >> 'size - error - left'. That is also wrong in the size-query case:
> > >> the generic_listxattr() contribution is only subtracted from 'left'
> > >> when a buffer is present. Thus, the query result comes up short by
> > >> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
> > >> ACL support), and a caller that allocates the returned size gets
> > >> -ERANGE on the subsequent call.
> > >>
> > >> Declare 'left' as ssize_t, use a scratch copy to measure security
> > >> hook consumption, and only decrement 'left' if a buffer is present.
> > >>
> > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_lis=
tsecurity() interface")
> > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > >> ---
> > >> Changes in v2:
> > >>  - Use a scratch variable to track security label size directly,
> > >>    replacing the old formula that undercounted the size-query case.
> > >>  - Drop the now-unneeded NULL-buffer special case for
> > >>    nfs4_listxattr_nfs4_user().
> > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> > >>    (the same accounting bug caused both the oops and the undercount)=
.
> > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achilles=
gaikwad@gmail.com/
> > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > [CC'd the LSM and SELinux lists for visibility]
> > >
> > > Unfortunately my testing was unsuccessful due to an NFS problem that
> > > started with the v7.2 merge window that I haven't had the time to
> > > bisect yet.  Assuming the NFS folks are okay with this change, I
> > > figure they will want to send it up to Linus via their tree, if not
> > > let me know and I can send this up via the LSM tree.
> >
> > Yeah, we'll send it through the NFS tree.
>
> Thanks Anna.
>
> > I'll be curious to hear
> > what problem you're hitting, and what patch is the culprit once you
> > do that bisect!
>
> Yes, me too :)
>
> I'm still working through a review backlog so it might be a bit before
> I have a chance, but in case anyone wants to test it out, it's easily
> reproduced using the selinux-testsuite and the NFS tests:
>
> https://github.com/SELinuxProject/selinux-testsuite#nfs

They seem to pass for me with and without the patch (they don't
exercise listxattr AFAIK).
This was on the current selinux/dev branch, v7.2-rc1 based.
