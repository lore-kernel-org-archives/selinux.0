Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8C36EA8E
	for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420485; cv=pass; b=EuZt0nIYO5cjkgkCixcemmPjZOzhev/askenD7zGt13JGSyISMZFdGzl9WtMds6KRA7AamW5A2FnKsZdfHW7bbD3ADjUssPZEmFuDBcuxy0C5ir3zFidr+hCk4UfoLf24mw48gxn+J9XsGfu07jBp1xLsha0sfAwltHb/DR8sPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420485; c=relaxed/simple;
	bh=f0Ceifmdtd+icWZEIGznyRsCS3GvzZoATmFU82jVusM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP0KRlnYu6vKZFQojDS+Cy90Gx33O/DENJsvCHED4dmi5Ueu8IcsNMlClB+fvsHsVAMHO2P/LGODnyVmLcbVVTpjnsRFwB9NwKbqnh8A3+Spsv/GP94w+iBg0i+nuJQh9wTt/VUP5xmrAdt3Ck1IcyAi7xFkW5FNIt8uynqEV9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fGKpDWF+; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fGKpDWF+"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c890110acdaso107160a12.3
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 13:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782420483; cv=none;
        d=google.com; s=arc-20260327;
        b=Y7G6WrifVZMtACGBxpyHbV5Y4q1CXkkvTE8lrUiKDhcehkYK4kOhFaJshaN+Wg5Fw6
         WQG8NT2/U40+IfIvlF+bEJ+nzEiln3Vhx36RpBJPWOhY+yj8gVSGIscRac+9c/qkUSaR
         9wTuyK+Rt2gFnh8bKjNNMFmnHq6FEIPYpY9/fLv9HVNl3eZEd9axDk4SDSYtv2D4rxtN
         b2N3ODxThTeay9AXn2+PDhZVWOZUN/MIX1OSeZEbn9IWK5Bam8PqeOTBEsQUFt1FEfdn
         OX/8d9/f0wlAvZWxZumuM/uqRdD+AFRgPucDfgl9WsKslNrs/oG489RSPHNfArCjz4P1
         r2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=azFpD8w+2tmcQpqU30ws2iQaaMKt3MV7jEBsuDhiaTo=;
        fh=EPqbAGJtjPF3330l2pf/yNDaIuFJtpB7JJtRhaWrsZw=;
        b=J6peYKLlSmy/+QuHmtcLEZF0EJSV5Knu9Eki8ZUKFzPd6m+zl5qVEQSRjoT6Thv7G4
         VjdShVxSKkSBfiCDVRP69qkr5WYQcwakMXA0MmOABm5X8p2Yo3k2SxeSPryJ2k7h7sDo
         v7e9Zzka1aDYFdi3pQyjHG7SIrTAL0j792A0Vqq666UdGXUrsPNJN4ZCfUS9XVr24a6H
         MLQiSmB6K6reVB9iFUG5+QKphncZIIFmk0z15OvXz/d+FI1SxyfTzjVzp3R+IFdixMLS
         my3psXcfNxOBbT4WiUFwniLjZGfW74wLC5EUI2bbXDaHT9PHrLpBt5RY0/J80Ywp7YbK
         K9XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782420483; x=1783025283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azFpD8w+2tmcQpqU30ws2iQaaMKt3MV7jEBsuDhiaTo=;
        b=fGKpDWF+vWPIG/vytG8etsjCv8EuM35t5u73k2ZExHfdTKfjs0WH9aQUC+5SHQsTXU
         7XKkjqAFI+No2YeGYhxhXEpWdy+tkgGTMtrHEVo/P7M1ItNdX75HD6ENzdFCPDenV0mu
         sNYTvX1XnP6xn4Kg8p4s1pxGT/G7wJtrroM7U9UQTbckWpT0IgzCLsGEfFfuWLIAtaru
         NrCMb0Fk8COwaKcl6t7hrzjxdR0/6klXEduISzHACggR1j9s/V+bFEtowjy2qh6wMXJD
         WcpTH+TrEiEiseu7pBceKl7/cy/MCNUvK11lmrdpupjfNRr9LKd3wXEY57fXp2XVzWGb
         xUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782420483; x=1783025283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azFpD8w+2tmcQpqU30ws2iQaaMKt3MV7jEBsuDhiaTo=;
        b=daUVA4/P1Q2HQoTfvTyOZwk6hXZ72kKO83qdw1ogZ1KEF5N0IRoXDrAeAUo/c3W/0R
         B48jCUW83vb1DcStIumCQFgkWNsdNDlLa+EO2748pzMXSa8MyIaXfprd8j8HbvPe7ZeX
         KOWwlO2cFNFl5DUqiQdQkPvCosDtkeBxm9L4iLBrlh66UCV+Cl35eOfdZeAPlRc0uA5I
         DUOxIJh3mUCmKZDg/iLsjhY+g27OLP4vZzdh48XJFllheuTx5pxT29Q/+WfSFKtJEc4E
         53klLepkRVVwa2b0MVYi3hDYodQ1x1aupJz2BUDak1Ka70dTxaqJboxhPhFixwMbFYdS
         I4PQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IhzDeNLTXDzU0/mApcJs8WBjyr0XCT13bVnb1cYyKSWYE363O/C/ZczHiM2awL2MMfNyP9Ukd@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwAfCn3vJ+PmwZR5CLMlPCfArx8S0l6poFqJL4dIu/TXnFde9
	0t9bJZBWBkM5rxRwBTGYbZUocAFtHDyeb7vkQltQVyXBXjlhXY8dfScfChmwTxjSGo+sagtRMjE
	PbtSXilO7Wmhth0UFlOsiNZP6naORgHq2uaRtibxO
X-Gm-Gg: AfdE7clgcNbv4bgb9aqdBotsvDV2uYQ6F6/Spj9vReDmm9qs9rcEgkIcWOHoQY1ThUU
	EQaX3X7WSjTlo8vPEfmzPSvsGK7FLoNh41yAxnLsf4Gh8EYutHJYUbsqCQehAe/9/4o+snCrdVW
	1y1MHPlE1VPn25ZlmYpTvGNpaxzDbEQrG1l4BdKFJdtQXoC4hVnv7SUHzNrcLZ8pVtBO5ab6j8b
	U+ZxBEtAcwf5hHq6FrQcPC+a+XeSfaGZUK5JiC0bbFEju1hla2pspRKEGabqmLeoEu+28mq
X-Received: by 2002:a05:6a20:258f:b0:398:bda8:d8cd with SMTP id
 adf61e73a8af0-3bd4ac850b6mr4962108637.7.1782420483450; Thu, 25 Jun 2026
 13:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
 <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com>
 <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com> <CAADnVQJM15E0PwomdTiz8zvVMGkqs9mTSjYRdPBF6fgE=tsPCQ@mail.gmail.com>
In-Reply-To: <CAADnVQJM15E0PwomdTiz8zvVMGkqs9mTSjYRdPBF6fgE=tsPCQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jun 2026 16:47:51 -0400
X-Gm-Features: AVVi8CeSCq01YuOttlTLlYK8mdjCXHKn7_tsxEH2h9SOetfWd3DVlVdhg7KLIyU
Message-ID: <CAHC9VhSm_yC7f1FRHJn0NE1-UwCOx7Nhc9dxVJXs8DFzzxNKQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>, selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 4:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Jun 25, 2026 at 1:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Jun 25, 2026 at 3:58=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > > On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > > > > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> > > > >
> > > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomic=
ally set
> > > > > > xattrs via the inode_init_security hook using lsm_get_xattr_slo=
t().
> > > > > >
> > > > > > The inode_init_security hook previously took the xattr array an=
d count
> > > > > > as two separate output parameters (struct xattr *xattrs, int
> > > > > > *xattr_count), which BPF programs cannot write to. Pass the xat=
tr state
> > > > > > as a single context object (struct xattr_ctx) instead, and have
> > > > > > bpf_init_inode_xattr() take that context directly. Update the e=
xisting
> > > > > > in-tree callers of inode_init_security to take and forward the =
new
> > > > > > xattr_ctx.
> > > > > >
> > > > > > A previous attempt [1] required a kmalloc string output protoco=
l for
> > > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all=
 LSMs to
> > > > > > provide xattrs for inode_init_security hook") [2], the xattr na=
me is no
> > > > > > longer allocated; it is a static constant.
> > > > > >
> > > > > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > > > > restricted to lsm/inode_init_security. Restrict the xattr names=
 that
> > > > > > may be set via this kfunc to the bpf.* namespace.
> > > > > >
> > > > > > Link: https://kernsec.org/pipermail/linux-security-module-archi=
ve/2022-October/034878.html [1]
> > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > > ---
> > > > > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++=
+++++++-
> > > > > >  include/linux/bpf.h               |   1 +
> > > > > >  include/linux/bpf_lsm.h           |   3 +
> > > > > >  include/linux/evm.h               |   9 +--
> > > > > >  include/linux/lsm_hook_defs.h     |   4 +-
> > > > > >  include/linux/lsm_hooks.h         |  16 ++---
> > > > > >  include/linux/security.h          |   5 ++
> > > > > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > > > > >  kernel/bpf/trampoline.c           |   3 +
> > > > > >  security/bpf/hooks.c              |   1 +
> > > > > >  security/integrity/evm/evm_main.c |   8 ++-
> > > > > >  security/security.c               |   7 +-
> > > > > >  security/selinux/hooks.c          |   4 +-
> > > > > >  security/smack/smack_lsm.c        |  27 ++++----
> > > > > >  14 files changed, 166 insertions(+), 38 deletions(-)
> > > > >
> > > > > I have a few specific comments below, inline with the patch, but =
I wanted
> > > > > to make some general comments too.
> > > > >
> > > > > The kfunc additions really don't belong in the VFS kfunc file, pl=
ease
> > > > > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and a=
dd the
> > > > > kfunc code to this new file.
> > > >
> > > > We expose a bunch of VFS heavy operations for various security modu=
les
> > > > and this is really not different. For xattrs we have it all central=
ized
> > > > in the VFS and in general all VFS related bpf kfuncs should continu=
e
> > > > living there and be registered there. Anything that's just bpf infr=
a
> > > > specific can go to security/bpf/kfuncs.c instead. But anyway, it's =
a bpf
> > > > specific helper so it's the bpf maintainer's call.
> > >
> > > Completely agree. This is vfs related kfunc and has to be
> > > in fs/bpf_fs_kfuncs.c to make sure vfs maintainers review it now
> > > and all future changes to it.
> >
> > *laughs*
> >
> > Okay, then split out the LSM specific stuff into
> > security/bpf_lsm_kfuncs.c; all the LSM macros/defines/calls should be
> > in the LSM kfuncs file.
>
> Paul,
>
> I'm sorry, but you didn't demonstrate the level of understanding
> of bpf to be trusted to maintain any piece of it.

Alexei,

You haven't demonstrated the understanding or decorum necessary to be
entrusted with any part of the LSM framework.

--=20
paul-moore.com
