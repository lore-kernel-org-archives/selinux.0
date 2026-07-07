Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B713CF695
	for <selinux@vger.kernel.org>; Tue,  7 Jul 2026 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454516; cv=pass; b=ZwfI4JSpfKzKq6sNn5GgxKYZM9KfA+HUJniF7d1u/+UVOb5HzMUdKnySrlpmdiZHvAid7thKVVHDuTIVKADVuBlwIw/g4vZW+SIt4XDiL5VrPjN+x6q/wjHXEus8Fcq85V356+yGpLLQkfZrbjTZTzekfgeLfm7RBVJ4RKMAZqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454516; c=relaxed/simple;
	bh=CQw7pbBPSsQXtU1Uj2PUzAdATT3DC/fTZSmkVK5/zlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf30KZUghZaiQp5O5m+Vp1mAOgYZZcVUXwXGvUKFziappS76sz6V0c07UGN/fw65ch2Yf+vos1z/5WNaR5r10ock8JO8GK29gL4xONe8CiSs7dKrek/t6KX8G8f0vS1ZZb9Qv8JlqhEo/gBkyczC9CI9HuzKFRi/p+6DR+gOaQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rzy56A06; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rzy56A06"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-383cb94f742so2835770a91.3
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 13:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783454515; cv=none;
        d=google.com; s=arc-20260327;
        b=pfNtjoyNEgYBnonR66kkVL4NurJJdF4fWc69AHgPkGUOPPej7c/SvuGNs9yhnTtm5L
         /vdaCqvfjFprrjiV6m/n+mYNCAKEAm+olktAGL7X0a4byCEveNb+yAqKLKyNyl37LPW4
         vEjnni52zu5ThzoTxi+vRO1htzRN72s1+XTibuSqjcTUsR5zQeoH1lbNSoTPh+PpENSf
         JVhFv0iuDbTXnzDQ+5Pz3EX9DuAO+Wi5AhoGU9FApattBaxRDwfjxz9bZGZQpE0ASMl4
         lPMVIf4Ipolm47g3NIqsHgv76SiWr2KM242Ozy37dTZsk4zh8AlQS1AtMATezokorJ+c
         xrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKHaKGkq7zit82xHzq3cQSvjgYMyfS0+fVrI7chNkuQ=;
        fh=JzBVm95QS9AWS0J6Pn9u+F3TxMZFSAZYARSCb1wzDjU=;
        b=Rtnx6+IweBpgjZGEVqVltdbDHgQRt7aKGVnam4wIfhrXmAOgSWJ61hIp26//GfHpqC
         GPbvRASk0sGRfMmO97z9vYIOiLgE3+kPBmX6OBSjKjYG2rRhu6uaUMeJfunMsLSf+Z4h
         hqyMn62hd6OPtkAsahNjG8xzXZYt+bLWtE55aNIy88RsANdz1HOLESAWKqAhE/3xHLHt
         Pb/NSAuwiFPsqJOyYb9cvf+9MuE3DtFQ9a90PC5IoByUd3B29fqbvQlBy4S+TkbiswLm
         Zv0FwLGZMhvE4u0JnjIkltbJLbX5dC5eRhn2DFsrsVYFXdr4O1UmLWDTT3Gkd+F/8c5L
         rhLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783454515; x=1784059315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKHaKGkq7zit82xHzq3cQSvjgYMyfS0+fVrI7chNkuQ=;
        b=Rzy56A06EuG/557lKXbZj5FzisJs/VspFSC0lA9XwefOL1CiMcLL092fxKJxi8vel5
         q6uFqfoyiy9cS5EmZlVctMrdZt/IlrZKXzLTm6hGDQgfuG01NEI5CPqRE/mjiCEyKHOY
         lyCEYFc1GVDoVD7BNn9nGYhmmIVkW65A5E8e0uXTcCm911FASOXz1nupXw4CHxUkECDS
         xAsQ2XLCzsVeWjzEGnVWn/iiTfMSJr5HygLH8e7S4P3Ty3BxyZJH3qwih3y/ZBLuViRY
         BQmqmu0IlIp6+o0ngXd1D1sL30x9CRmVA88OZSK9UnudGv5km6dBExhAS1GurTUlZMNt
         RqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783454515; x=1784059315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKHaKGkq7zit82xHzq3cQSvjgYMyfS0+fVrI7chNkuQ=;
        b=hITer3E1KFa7tuRfv3itBdf8oQtigUworlKWpvU523v3ZYfgCvSJl51lMCV/5YQRMD
         qvm9fJORrPDpmv+BZIyCiUfs27J/7hGj2EKjeKpjofWx0FnNj+Y0Sc6gp6fx1AviVXRO
         fj7Akk/Lgvdlbf4xImZVSyPPuc9+YmL78tmwEyUOW1n4H/JeFZQMaKZ+F8mAsU09pMQn
         DVwYb5woKPFZetemU2estKYUkCQxtu+wk8NBiRRke+f7iT30hwpraX8yeVjeGhdOXqhc
         Ffipj1yFR/jveMUsAZnvN37yTUjMXaHIeDZH92fU9KzrkIGaIOdpOZkkuxDOObwX55yj
         5QSg==
X-Forwarded-Encrypted: i=1; AHgh+RqPCnegeZ9ZLjmrTWZ2NNOUqfgkj24/ejjTEgETLvxG1vas3bBYLwZ8CKI1arr76LpKkrb8K29J@vger.kernel.org
X-Gm-Message-State: AOJu0YwNU0rOtu0sr+RMESyLLzc0JrryWXYrtwCDbGBs8+nfWRJWO4+F
	WCY4aUPIyKRjztVqtR+V/qldHt2bi8TiybFBi4raywSMeYsd/zaB3gFyhzWKXzIu3luttY76qQr
	PokBEasjiapRwlajOYxtGBZKETSVbMQ11hZlp72kR
X-Gm-Gg: AfdE7cmTGXlvkVVfo7uVbKddZoB+33ikEbQL6oR9MffhZP/A0TwGr27dknCkKN2bvjt
	PhqBH8Ju9nUDCO96QzINlM9Xkc+Ksne4m5tIt6U3EBdVPL5fiRPCtnS0qLDh6noYAxFctwmhMDt
	rMrDR8ckSAfVX2sEPvFPXl95PXX/Kh6FZT0Rr2DMABgNDighO0JiiYzOb0+mFDK+RNwC4VEhFv2
	iaHTegt77oWy0fHI73EF455/wcebUnh9FIE9G/A9b4arPPnQvz3nqEQLACeTuzsZysI10VH
X-Received: by 2002:a17:90a:b108:b0:381:5ede:1296 with SMTP id
 98e67ed59e1d1-3875547805amr4916450a91.11.1783454514983; Tue, 07 Jul 2026
 13:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com>
In-Reply-To: <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Jul 2026 16:01:42 -0400
X-Gm-Features: AVVi8Cc7whlyPeGuIcUVaMUhLCElVCGHeTQu6aN6Xlm0ZbpD5vFbi_OphdfvdLo
Message-ID: <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Anna Schumaker <anna@kernel.org>
Cc: Achilles Gaikwad <achillesgaikwad@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	stephen.smalley.work@gmail.com, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.org> wro=
te:
> On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > <achillesgaikwad@gmail.com> wrote:
> >>
> >> A call to listxattr() with a buffer size of 0 returns the actual
> >> size of the buffer needed for a subsequent call. On an NFSv4.2
> >> mount this triggers the following oops:
> >>
> >>   [  399.768687] BUG: kernel NULL pointer dereference, address: 000000=
0000000000
> >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> >>   [  399.768722] Call Trace:
> >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> >>   [  399.768736]  listxattr+0x23/0x160
> >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> >>   [  399.768739]  do_syscall_64+0xe2/0x680
> >>
> >> security_inode_listsecurity() (via the xattr_list_one() helper) now
> >> decrements the remaining size even when the buffer pointer is NULL, so
> >> in the size-query case, 'left' underflows to a huge size_t value. As a
> >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a real on=
e,
> >> leading to a NULL pointer dereference in _copy_from_pages().
> >>
> >> security_inode_listsecurity() does not return the number of bytes
> >> it added to the list, so the code derived it as
> >> 'size - error - left'. That is also wrong in the size-query case:
> >> the generic_listxattr() contribution is only subtracted from 'left'
> >> when a buffer is present. Thus, the query result comes up short by
> >> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
> >> ACL support), and a caller that allocates the returned size gets
> >> -ERANGE on the subsequent call.
> >>
> >> Declare 'left' as ssize_t, use a scratch copy to measure security
> >> hook consumption, and only decrement 'left' if a buffer is present.
> >>
> >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_lists=
ecurity() interface")
> >> Suggested-by: Paul Moore <paul@paul-moore.com>
> >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> >> ---
> >> Changes in v2:
> >>  - Use a scratch variable to track security label size directly,
> >>    replacing the old formula that undercounted the size-query case.
> >>  - Drop the now-unneeded NULL-buffer special case for
> >>    nfs4_listxattr_nfs4_user().
> >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> >>    (the same accounting bug caused both the oops and the undercount).
> >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achillesga=
ikwad@gmail.com/
> >>  fs/nfs/nfs4proc.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > [CC'd the LSM and SELinux lists for visibility]
> >
> > Unfortunately my testing was unsuccessful due to an NFS problem that
> > started with the v7.2 merge window that I haven't had the time to
> > bisect yet.  Assuming the NFS folks are okay with this change, I
> > figure they will want to send it up to Linus via their tree, if not
> > let me know and I can send this up via the LSM tree.
>
> Yeah, we'll send it through the NFS tree.

Thanks Anna.

> I'll be curious to hear
> what problem you're hitting, and what patch is the culprit once you
> do that bisect!

Yes, me too :)

I'm still working through a review backlog so it might be a bit before
I have a chance, but in case anyone wants to test it out, it's easily
reproduced using the selinux-testsuite and the NFS tests:

https://github.com/SELinuxProject/selinux-testsuite#nfs

--=20
paul-moore.com
