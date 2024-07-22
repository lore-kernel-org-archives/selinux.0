Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422116EBFA
	for <selinux@vger.kernel.org>; Mon, 22 Jul 2024 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721677610; cv=none; b=fjfnBmbvOQovdzEyArpO+PiqPlFMUaJdt74HrfTXrbIGWJRlcLGKchfZ4rDEkbQmGvwBTcBljYbrakucYRQA1u7rSjbxkqrJtpkNX3glqEgg8GFizhLk0ff254Vab+j393UeqTfkGDlWf1q86+HQJBBnJ7NMnSC0n899gcaIw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721677610; c=relaxed/simple;
	bh=rvq+CWJ7KyybcI/TZ7Cso/tA/xiqNuIasYSqFhXRoLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/HHLDqE9RtRwbksfc7Cy1Wfljq1R6tv+jWHvXkM8GSJa+esTIbwNAk3VqvXRyuB7azrOxqGjf/LxKcBCiBCEKZQKX9ABHjIDphlpjhKMJEnmTLN52UGvKfjJrj+J/76unPr2whcjMCZebn9UhpUgQWPzrAAJ/Ih2R3UI3VIZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z3xKcnac; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z3xKcnac"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e05ebd3d607so4654340276.3
        for <selinux@vger.kernel.org>; Mon, 22 Jul 2024 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721677607; x=1722282407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlsyLoJ7kHoM0a0Ziou/1J4ZDEbSzOtiEJ45NJYR1HE=;
        b=Z3xKcnacnNYEnUivQss7OoF1tXOKKEk3IK8WPgDhOkqUN0ovgfnUes5Le80Czsmu02
         d51qiqb9WvOannd/N2Zo//Z80GV77GvabkjJp4y0Oo2+csI8wpy4jpTnyNfiDNcZPBET
         8Jfg0ViUl9Kgi9xMcg7+b7ox9KQGYTkXszLqtakw+/mnC6MgnHPAcvnpSB7PkNVOlZ2w
         I+ZeWpp98GBFVjbRLI99AqJqmQILyCM4EaFBvNNXn83Oxa+NbM80j12rxaaIu9Vlm1V1
         pwWABf5pfQNdYjEw502Sg8wsGEnsCUSoi7vp1EWmm/v5VIzgZ21slF8sU4hVBF2DX+Zl
         cW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721677607; x=1722282407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlsyLoJ7kHoM0a0Ziou/1J4ZDEbSzOtiEJ45NJYR1HE=;
        b=Of7y5Jwjp9szeQ3x4sK2miGiuJ5Yk5mVm2TnkKJ+HwRp2nBvwz2QK6ipdy6HCa1iAW
         C+PAnSRPtrUt9ykRSWhEGvozjYLcF9ndMnmNJlTTmpQACFeeZrZnQgek9I+pAoTocmVL
         GMV0vtuOTeg+PQb6+IoGBcpV1CJn9xjzwxpRwUVi6E4qvFKH8Z38KyMr/XzdaSxF+tRG
         SiR0JUmGW7suLY2woVhSWkmKEeb3LxALCH3Ee1/KAdxNJOuAuTSgjhPJfonwgD+sVTjk
         AAymK5lTh0mwixj0OFF8OiIE2pTZI/nDH02r48a0NI5qdcCRJFyC1U3JX9+QgdMsJoma
         0gtw==
X-Forwarded-Encrypted: i=1; AJvYcCUbhoEwHBWY+l3Q7CoqzgEBwMv0mmRdt7PPAACKhqkx9MqQ/H2swYuAKcybcy9fwgTUgSG5ktv3CXBvZ9DL4+Jc+cALeaXfFg==
X-Gm-Message-State: AOJu0YzQmhWDKzWsXp6+EG9KxYGsS9kRwmTh03LUSDwxZmEJeHk6O4bH
	i6cwbnJrAx2bWtNF6+dG1dwYDAcqPshNOSdHyPGPUDyKZEy7i75Ku5CtOZrR3D2URnI+fJIjLRM
	5OBG3ISEzbFjtPxCBEG7sKoSk6oWR8OqN/dIS
X-Google-Smtp-Source: AGHT+IEOsMZxw0Xw68qGvDBWu3kZ+3yQnbvGHXg/Ez4wSvfzxgZSKczbqq9vqe5RMMTqlPlW8aYSoANyjDSjpwD5OvM=
X-Received: by 2002:a05:6902:150a:b0:e05:fdbe:bbec with SMTP id
 3f1490d57ef6-e086fe55573mr10735481276.9.1721677607589; Mon, 22 Jul 2024
 12:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com> <20240710.peiDu2aiD1su@digikod.net>
 <ad6c7b2a-219e-4518-ab2d-bd798c720943@stuba.sk>
In-Reply-To: <ad6c7b2a-219e-4518-ab2d-bd798c720943@stuba.sk>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Jul 2024 15:46:36 -0400
Message-ID: <CAHC9VhRsZBjs2MWXUUotmX_vWTUbboyLT6sR4WbzmqndKEVe8Q@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: Matus Jokay <matus.jokay@stuba.sk>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 8:30=E2=80=AFAM Matus Jokay <matus.jokay@stuba.sk> =
wrote:
> On 10. 7. 2024 12:40, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
> >> The LSM framework has an existing inode_free_security() hook which
> >> is used by LSMs that manage state associated with an inode, but
> >> due to the use of RCU to protect the inode, special care must be
> >> taken to ensure that the LSMs do not fully release the inode state
> >> until it is safe from a RCU perspective.
> >>
> >> This patch implements a new inode_free_security_rcu() implementation
> >> hook which is called when it is safe to free the LSM's internal inode
> >> state.  Unfortunately, this new hook does not have access to the inode
> >> itself as it may already be released, so the existing
> >> inode_free_security() hook is retained for those LSMs which require
> >> access to the inode.
> >>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > I like this new hook.  It is definitely safer than the current approach=
.
> >
> > To make it more consistent, I think we should also rename
> > security_inode_free() to security_inode_put() to highlight the fact tha=
t
> > LSM implementations should not free potential pointers in this blob
> > because they could still be dereferenced in a path walk.
> >
> >> ---
> >>  include/linux/lsm_hook_defs.h     |  1 +
> >>  security/integrity/ima/ima.h      |  2 +-
> >>  security/integrity/ima/ima_iint.c | 20 ++++++++------------
> >>  security/integrity/ima/ima_main.c |  2 +-
> >>  security/landlock/fs.c            |  9 ++++++---
> >>  security/security.c               | 26 +++++++++++++-------------
> >>  6 files changed, 30 insertions(+), 30 deletions(-)

...

> Sorry for the questions, but for several weeks I can't find answers to tw=
o things related to this RFC:
>
> 1) How does this patch close [1]?
>    As Micka=C3=ABl pointed in [2], "It looks like security_inode_free() i=
s called two times on the same inode."
>    Indeed, it does not seem from the backtrace that it is a case of race =
between destroy_inode and inode_permission,
>    i.e. referencing the inode in a VFS path walk while destroying it...
>    Please, can anyone tell me how this situation could have happened? May=
be folks from VFS... I added them to the copy.

The VFS folks can likely provide a better, or perhaps a more correct
answer, but my understanding is that during the path walk the inode is
protected by a RCU lock which allows for multiple threads to access
the inode simultaneously; this could result in some cases where one
thread is destroying the inode while another is accessing it.
Changing this would require changes to the VFS code, and I'm not sure
why you would want to change it anyway, the performance win of using
RCU here is likely significant.

> 2) Is there a guarantee that inode_free_by_rcu and i_callback will be cal=
led within the same RCU grace period?

I'm not an RCU expert, but I don't believe there are any guarantees
that the inode_free_by_rcu() and the inode's own free routines are
going to be called within the same RCU grace period (not really
applicable as inode_free_by_rcu() isn't called *during* a grace
period, but *after* the grace period of the associated
security_inode_free() call).  However, this patch does not rely on
synchronization between the inode and inode LSM free routine in
inode_free_by_rcu(); the inode_free_by_rcu() function and the new
inode_free_security_rcu() LSM callback does not have a pointer to the
inode, only the inode's LSM blob.  I agree that it is a bit odd, but
freeing the inode and inode's LSM blob independently of each other
should not cause a problem so long as the inode is no longer in use
(hence the RCU callbacks).

>    If not, can the security context be released earlier than the inode it=
self?

Possibly, but it should only happen after the inode is no longer in
use (the call_rcu () callback should ensure that we are past all of
the currently executing RCU critical sections).

> If yes, can be executed
>    inode_permission concurrently, leading to UAF of inode security contex=
t in security_inode_permission?

I do not believe so, see the discussion above, but I welcome any correction=
s.

>    Can fsnotify affect this (leading to different RCU grace periods)? (Ag=
ain probably a question for VFS people.)

If fsnotify is affecting this negatively then I suspect that is a
reason for much larger concern as I believe that would indicate a
problem with fsnotify and the inode locking scheme.

--=20
paul-moore.com
