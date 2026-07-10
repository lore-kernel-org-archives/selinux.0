Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FEC3E7BB6
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720513; cv=pass; b=aOPy2wwu84PMVY6JIHMFKVgIkUq5gRraZRCNA1HYda8uDw27FQk1AEKP7BbLDFXM6KpfaIkkuGciFvyy/OLvq7I3oMkDTx+iQaiu5Ety5sf34di1TOHlHfI3RUKDig1rz6mQzow0G7ogJz+EMvXRsje3S6Jr1wBalV/xhgED9WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720513; c=relaxed/simple;
	bh=XtQaNN92G4Sy5XjgYZ7PtznLtjfPFcMPMPm+5XwS9R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+kWUznxfs3gtNynOpAgc4wJ0zoBGZpIUsIiPQ684BpRjzHq4A2l2Q1ATxa/IRw97FSz178LFhXeAfGChbqcgxWjtNjlIHJTohYGD9PwPjqRNvPmIn10uVDunVabbpVHgMYbd8v206j3K/fNoxXX663ouqivBzVJ6qFYwmk1U0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FI/MELPu; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FI/MELPu"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b9d265355so1230350a91.2
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 14:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783720510; cv=none;
        d=google.com; s=arc-20260327;
        b=HvBfG+2uyuS2kI7SdSk8IX71Gqo48GwWpV4RM306UNczLeue7jmNP7OPIDgXCG8HKZ
         t7xM9FN8fZOYK/1KyZQEZvYpMboSdvGv6/QUKvFSUEJJ7MtBFRV05b+d84fxV0K/00Vl
         aKEJee0D0fV1D6eeHzj+83QeEdAcG1qBevKJytEzBu9EdEi5h8obPOHW6PRDOXs6b0M1
         BEnZiDgNOEJ6Ux0TNCMtNh08heXBbvmdgJEPiMszI3ArfUwtsz8dk/4QQMREboa/TBOA
         BU0cpK85iDk995hAdHBWoFnOht15CZdRYOGjIfmtxdiQUCSFFFEs0iBAplj+9CnqbEvR
         u9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6XeOo/ULnXcigTrjbn+2fwnIM1ZI1Z5B9LAbPypSswc=;
        fh=sq3DOy8211uKZxHsQt5rct/8rTa51mriGmW+cNxYPrk=;
        b=hDTb9/5IV3YA7P+Did1vXCO9HoMK80EncSAY/b5kUOvoMT0jSkxbT8/5fgwgdGDQ3y
         4E8+BVFLqvTB5vYNQRRrFeNPwHONtqhYtpAPVzomJKD1KTobFtRs/YQCFya5KjbTfKOc
         GAGeJqAIC/U9wEzImjsmllnmTFuiI+s66VKmRJV4yZxlbw6Cc2Cr5gwbXsizeLpP40Tq
         FGifXjXg5t1F+UUIZga1aUMosNb/lQZBlcWalqzjoLm5Rn5yUQUmlBi0hVOZiAtP7VAD
         vUGTBLlEo2K3p8Y2WWniqSGqZ4G8hi9DueeWzpuDc/TRNvV2VrG8JBe2dBzPtkDNh6/Q
         7oSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783720510; x=1784325310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6XeOo/ULnXcigTrjbn+2fwnIM1ZI1Z5B9LAbPypSswc=;
        b=FI/MELPuvbsA1fG989djyLNjUqJc3PlF0fZ1oPQktcwCjeDXAg9UjP1eSdhVEsGQgU
         dlV9yAtCAxvJjj9ZCmY/uUXyenX7q4T/+htznt0c/KXs2bemmUazkAjxmeXETWtSRHdu
         Ehdonvz5GUg2cx3MBNZlXS7WWH+eBuaDomuXzsBMWxlJ5/uOXsugA53vfjXc88AKIaqa
         8fNeNAJh6FMI4aweHxnWTPulLhe2gqTKFRiAfT+IkBjkx03ItSUQGqDPEYhBgyr7qGaI
         /18I7QLn4qmfI/el1RoZw6DTYWgB26J4aHYXSeWflcPrVRgvU4eslZ1ht+hWZ5erwbad
         BuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783720510; x=1784325310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6XeOo/ULnXcigTrjbn+2fwnIM1ZI1Z5B9LAbPypSswc=;
        b=LIpN5DDGLphvfsxLh333siw6BqZEEZaV9aRe+jfGVkzZ1XQtLii7YYddt1d233l9Aq
         qCmh/FAtKFalC9p0WhtiKCwfZxgR5cxZzipQDBBUaUa042ie5CgmSFZ9vDs/dflaGyZT
         fpisDAlcLdb3QQ7DW+b09uEMwuGWgWOZwrwyP6P1lw3XfyatmZhnRQCm++jKs9GUybD0
         bjiHmvSaWJVclMx0GiHbh+8YUQ7wemRWvodzuSWZEP1Icr4yEMqOJG2xl+eepy8unZxG
         GnPj8KEOnRmvXl3ffFSrl+XxtoaiHZpo4MrWwruS26PqJ9JnQylaeKC5k4slOVFAuZdu
         fkbQ==
X-Forwarded-Encrypted: i=1; AHgh+RoD6SKRNpSDcjAdDvfHiDtLfqLSpes/cwKGpvZJhkAAR79Th5RN6kCeu7wJVydaHQiQaqw1ECoK@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSkMsZabv+p0pp9B5HORyt1zBz92MSj+t22eDZn8I9EgGO/Hc
	srVRXI3SHrtdWnDTDFsYu2XWVblltmF4yiokrhHJ4gghQHKKCdbWjaEfbWzjVsaLKCf8/M8IxRf
	5ohaX0V+NW9wKgzG+Pe8CRkmpPeGJ1owgASam3KeqsvY7K7MxyBLyvbiK
X-Gm-Gg: AfdE7cnqgq7Q5eeytRQMRtgdLzZ9udURMeYtqRRT0a4H8zfMD2P7HGc/tOmfIlxGprF
	L/gVQ6I3wV8hYkU5Ou91snFUSqa5wz9JBRKZHw10K5DynJbH2u795IsuwGfo6dszXMpvrgyKMov
	KvU4nDxGV4UaGFiz5OE9YeTvnm9ftnJgRZjA4Fd1kYwLhsFZtDgLQ0QbZ37zVPIZBfa+4yF70NH
	sxoKbu1eeZRN78oTbbt7JFlf3CF84cSu5ysERxFze4NTcO7gqTZIpCL1WZSrChxhjHUISa8
X-Received: by 2002:a17:90b:3d89:b0:381:2811:e8ad with SMTP id
 98e67ed59e1d1-38dc7777abcmr646036a91.23.1783720509556; Fri, 10 Jul 2026
 14:55:09 -0700 (PDT)
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
 <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com> <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Jul 2026 17:54:57 -0400
X-Gm-Features: AVVi8CeXE7oLDsWTKiw8a4raGtdwgg-BRS7l6ETRD_v0qIyJINJnj45P77RcbOM
Message-ID: <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Anna Schumaker <anna@kernel.org>, Achilles Gaikwad <achillesgaikwad@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 8:33=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jul 8, 2026 at 4:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Wed, Jul 8, 2026 at 2:54=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > >
> > > > On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.=
org> wrote:
> > > > > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > > > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > > > > <achillesgaikwad@gmail.com> wrote:
> > > > > >>
> > > > > >> A call to listxattr() with a buffer size of 0 returns the actu=
al
> > > > > >> size of the buffer needed for a subsequent call. On an NFSv4.2
> > > > > >> mount this triggers the following oops:
> > > > > >>
> > > > > >>   [  399.768687] BUG: kernel NULL pointer dereference, address=
: 0000000000000000
> > > > > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > > > > >>   [  399.768722] Call Trace:
> > > > > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > > > > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > > > > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > > > > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > > > > >>   [  399.768736]  listxattr+0x23/0x160
> > > > > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > > > > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > > > > >>
> > > > > >> security_inode_listsecurity() (via the xattr_list_one() helper=
) now
> > > > > >> decrements the remaining size even when the buffer pointer is =
NULL, so
> > > > > >> in the size-query case, 'left' underflows to a huge size_t val=
ue. As a
> > > > > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a=
 real one,
> > > > > >> leading to a NULL pointer dereference in _copy_from_pages().
> > > > > >>
> > > > > >> security_inode_listsecurity() does not return the number of by=
tes
> > > > > >> it added to the list, so the code derived it as
> > > > > >> 'size - error - left'. That is also wrong in the size-query ca=
se:
> > > > > >> the generic_listxattr() contribution is only subtracted from '=
left'
> > > > > >> when a buffer is present. Thus, the query result comes up shor=
t by
> > > > > >> exactly that contribution (e.g., "system.nfs4_acl" on a mount =
with
> > > > > >> ACL support), and a caller that allocates the returned size ge=
ts
> > > > > >> -ERANGE on the subsequent call.
> > > > > >>
> > > > > >> Declare 'left' as ssize_t, use a scratch copy to measure secur=
ity
> > > > > >> hook consumption, and only decrement 'left' if a buffer is pre=
sent.
> > > > > >>
> > > > > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_ino=
de_listsecurity() interface")
> > > > > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > > > > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > > > > >> ---
> > > > > >> Changes in v2:
> > > > > >>  - Use a scratch variable to track security label size directl=
y,
> > > > > >>    replacing the old formula that undercounted the size-query =
case.
> > > > > >>  - Drop the now-unneeded NULL-buffer special case for
> > > > > >>    nfs4_listxattr_nfs4_user().
> > > > > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> > > > > >>    (the same accounting bug caused both the oops and the under=
count).
> > > > > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-ac=
hillesgaikwad@gmail.com/
> > > > > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > > > > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > [CC'd the LSM and SELinux lists for visibility]
> > > > > >
> > > > > > Unfortunately my testing was unsuccessful due to an NFS problem=
 that
> > > > > > started with the v7.2 merge window that I haven't had the time =
to
> > > > > > bisect yet.  Assuming the NFS folks are okay with this change, =
I
> > > > > > figure they will want to send it up to Linus via their tree, if=
 not
> > > > > > let me know and I can send this up via the LSM tree.
> > > > >
> > > > > Yeah, we'll send it through the NFS tree.
> > > >
> > > > Thanks Anna.
> > > >
> > > > > I'll be curious to hear
> > > > > what problem you're hitting, and what patch is the culprit once y=
ou
> > > > > do that bisect!
> > > >
> > > > Yes, me too :)
> > > >
> > > > I'm still working through a review backlog so it might be a bit bef=
ore
> > > > I have a chance, but in case anyone wants to test it out, it's easi=
ly
> > > > reproduced using the selinux-testsuite and the NFS tests:
> > > >
> > > > https://github.com/SELinuxProject/selinux-testsuite#nfs
> > >
> > > They seem to pass for me with and without the patch (they don't
> > > exercise listxattr AFAIK).
> > > This was on the current selinux/dev branch, v7.2-rc1 based.
> >
> > They work for me on vanilla v7.1 and fail somewhere before vanilla
> > v7.2-rc1 (still bisecting).
> >
> > I wonder if there is an interaction problem with a recent userspace
> > update.  What distro/userspace are you running for your tests?  I'm
> > doing my testing on a relatively recent Rawhide.
>
> I was on F44, so yes, it could be a difference in e.g. coreutils or
> other userspace on rawhide that is tickling this particular bug.

I haven't had a chance to look into this yet, but the git bisect just
produced the commit below as the offending commit:

   commit 01c2305795a3b6b164df48e72b12022a68fd60c1
   Author: Jeff Layton <jlayton@kernel.org>
   Date:   Wed Mar 25 10:40:32 2026 -0400

   nfsd: add netlink upcall for the nfsd.fh cache

   Add netlink-based cache upcall support for the expkey (nfsd.fh) cache,
   following the same pattern as the existing svc_export netlink support.

   Add expkey to the cache-type enum, a new expkey attribute-set with
   client, fsidtype, fsid, negative, expiry, and path fields, and the
   expkey-get-reqs / expkey-set-reqs operations to the nfsd YAML spec
   and generated headers.

   Implement nfsd_nl_expkey_get_reqs_dumpit() which snapshots pending
   expkey cache requests and sends each entry's seqno, client name,
   fsidtype, and fsid over netlink.

   Implement nfsd_nl_expkey_set_reqs_doit() which parses expkey cache
   responses from userspace (client, fsidtype, fsid, expiry, and path
   or negative flag) and updates the cache via svc_expkey_lookup() /
   svc_expkey_update().

   Wire up the expkey_notify() callback in svc_expkey_cache_template
   so cache misses trigger NFSD_CMD_CACHE_NOTIFY multicast events with
   NFSD_CACHE_TYPE_EXPKEY.

   Signed-off-by: Jeff Layton <jlayton@kernel.org>
   Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

--=20
paul-moore.com
