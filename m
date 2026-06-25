Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9623128CC
	for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420297; cv=pass; b=qGz316hBhLLL+tYqS+itXpdZ8H7H0CEj6JYGR4End3hs6h3TDsShLgWZEVltffyXllGr+04HRXEqkcFbsIF9RzrlmAKYoqHobX0ip6nowAARNWNfvUDdW49DBmq4hNN9pCkDMcyN7odAc5Uk0GtgwqsA33HMCns+MXJI28CXEeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420297; c=relaxed/simple;
	bh=N9Dq4DwFj346OsehhL6Mi2d0QMKVNJTttDz0kqTp1YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn/CFvdcl45raJRmD4D9a4VdGiX0kSCeLQGFc73CGP/5ojCvaS4V7Sl7P+3CBgSqJRGzWwcC0fCQUWGKVUDnaUlDKy8xvv7ocIkjuEIpGg/i9Z4qD8ThipdSJcCBhIRb/cxPsbgfWMznB4wBsHKRleI7GF65/lL31r6ke16Gy+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVt9QOH8; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVt9QOH8"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so229011a12.0
        for <selinux@vger.kernel.org>; Thu, 25 Jun 2026 13:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782420295; cv=none;
        d=google.com; s=arc-20260327;
        b=ZBtJEjJnUQxuhVXdVLzuJcM9fbqgtNCAr1U0zRM0AGf2rz8Y+Jqcl4XVtMfPN+0/7n
         ISyA+PFbU9fca16Cm7HBqLIhiMMwaBfFQzlcDpf6LZmvB7A+hRWPKvndMZ8xdzYfXE7U
         k9dOIsk1ENPn5JQebxGxWHN6+8hvBstB/tEbTvWHa0iL3I5scyhKdzWYKCBQm+9FR0Qc
         dIYfo2o0omf16m7eT3/lMtUNm4J7Gvl9PR1/I1AZvLK2v+dklGKPODwOejmDgOFefBJO
         ifmd3lfHzO8DzYOQ2yQ1T2nGhu3rbpqKOZ+fswjjowRyVkH2aRet6MRqQA2IW6kFnsJC
         T7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        fh=YnibztPOy8tMjJcPUXkb+lUeX33xDIKrg9bQrCUgMPs=;
        b=CUoj927hKZ+rMu7Yj/TowKLg6LpTmrTN1l/DR/xMPCeTWucMdin3JzY4+GHUjLmjo8
         NCQ5Nnx5mQqWRsg4WhH2Fh0eGh41inGs1GkgYOJoDxVFZ1F8ZOac1wF7TwLMCfiZuU/7
         o1sgAe5MaHYZCGhE2zt8CvK5USQL7hcmIo0/ynGJyvfk10vk33FSKT6zTgOrm2YiNCrA
         G6KyYhJcVIN4HNyBZLrk4MihSCksniUME/XEzYrAE61gk5eHG2a4NlsclHtHmDWUW0qx
         xMqrFa1JsUdSWepKye7yC3eRJ3DozLfMI8misw66wElc6y+9htXd4bPaaDK7Tnbugxmz
         cPtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782420295; x=1783025095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        b=cVt9QOH85TZczzIKAW32WQbCke6oi2BzExTRrguWXJ53mLBPCyqikD/7rXtPYAYUE4
         RY0xEqimDJNhH/F/QZxsbtL2c/8Zct/VDrSkf17c/4VgQ518x5S+ao6WHbl6O8raGuVc
         IvuFjmRU97QWlC4wwkKSWHn0qi2wzUNT8Oe0hRoz3jXa/PAVLo7mYg1WKMfa0FrjHSuZ
         NCuOFwoRtUN2p/TrQ+uIoNs3dx7lNlnfIihxVAujVQ3NavHtOhH1KnY14YIV0RPZP371
         bDc3BlbBqVKeTW4+R9tCFGpP5eEVSBDqSQlZ+3MD17Rk14y9t75m1fL393UV1vgHlc0g
         6lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782420295; x=1783025095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4nuJamRLnRW/kvnyuggLvvM8UuA505yMAZohH7ph0w=;
        b=Kaa6aHIoHSX837rJK0ZcqLeGyawxhvo1fsrztJiE1XB3sEqU1AhRm0VB8ZiwxXq7gF
         +ASWpc0qhpInwvJsvMzcHRSaKAOVUOEHOHp45P2uZmhe4zpcJ2IWhW4kKqxSTBbWRCuH
         GtwkhiHEKETD4Y6fYFFOri1cCkjaNCc6J/xi/pHDWORt/YWSJbUfhyIjjE5sKCKAc94x
         7hVikgX622n5XBWKq188hFWQZFtvodU74FUKkQ+ImxKqe6T7wa2p3jnjWSXs0tzUfJiF
         g5Nn5ljIpgmE1j+H1Nn3OSX/tPKjxZhYulHnmiLO0cdH+f1Vvplq/+ZwWWSXAIoQM6Dk
         eSow==
X-Forwarded-Encrypted: i=1; AFNElJ+0KxlKrMCojylaVQSDg20JBtDoGst4fE52ClbGLlBRqv1AXmVqrKePrIdKbsNhzrrLKBTPR8Dp@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYZo+84Q0NrakPZ+D+ycozwLKkCvhyRlcQtLiXeQtGJ6WhmLy
	V+O5xuoSKywkUdQm3BsxHByL87mG3625wQGPw2Z+xWuySXhveZF70Tm8ci2142Wj1WaLWK70Jal
	2K4Oea2PCucZVIsIgj0NsaNS99pCSBlM=
X-Gm-Gg: AfdE7ckuNjNoVVTEosSC3gMOCb8lSKdnTjO1PNvI4ZbaqlJe01eIT5oOzeVs3zgPeyu
	ljLVYZGP/GR4Q9allDzhiRyZoU8qfPrLS1XKmY5viCUI6ex5eHTFApAVLUGS8HyfFP9JGe8tFKS
	Hk9eXQPVK6aV7KQm+jmtMxU6C+D15QEMeR4aKizslDwgBolB+vr1YDkptYc7eWtN2MdXF68zM6E
	QH/Z41Ynnc0UT2lzyVSyiOrF8DyFTavdZoYBD9I3dNOiEM8njC9qFPm1yQpBBfE8iDgDkepUO2e
	TIJ0pKH9QXVuT8jKaVVsh/trvFMHhH2xwa9x+ZVRGJRfbGGzECqknyaF5hlUB7DgP+6XWwM4vg9
	S4uowGbFnIKbO
X-Received: by 2002:a05:6a20:144f:b0:3b4:84de:aa79 with SMTP id
 adf61e73a8af0-3bd4b064fcdmr5342275637.44.1782420294988; Thu, 25 Jun 2026
 13:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
 <CAADnVQKKr5cCYTj8qS7tU-Aeda1iexYUp5aquTjYXMEL656cJQ@mail.gmail.com> <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com>
In-Reply-To: <CAHC9VhSXXHGRUmJ4YjQ6uEh6dbq7+h_0TwWiV+W5dUWXCTFcfg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jun 2026 13:44:42 -0700
X-Gm-Features: AVVi8Cd1aiwx-Wi0FGOZBeYqi53u50Be8i1kd9zEsWrT9afz6qquacMnoCzNbM8
Message-ID: <CAADnVQJM15E0PwomdTiz8zvVMGkqs9mTSjYRdPBF6fgE=tsPCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Paul Moore <paul@paul-moore.com>
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

On Thu, Jun 25, 2026 at 1:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 25, 2026 at 3:58=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Thu, Jun 25, 2026 at 7:23=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > > > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> > > >
> > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomical=
ly set
> > > > > xattrs via the inode_init_security hook using lsm_get_xattr_slot(=
).
> > > > >
> > > > > The inode_init_security hook previously took the xattr array and =
count
> > > > > as two separate output parameters (struct xattr *xattrs, int
> > > > > *xattr_count), which BPF programs cannot write to. Pass the xattr=
 state
> > > > > as a single context object (struct xattr_ctx) instead, and have
> > > > > bpf_init_inode_xattr() take that context directly. Update the exi=
sting
> > > > > in-tree callers of inode_init_security to take and forward the ne=
w
> > > > > xattr_ctx.
> > > > >
> > > > > A previous attempt [1] required a kmalloc string output protocol =
for
> > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all L=
SMs to
> > > > > provide xattrs for inode_init_security hook") [2], the xattr name=
 is no
> > > > > longer allocated; it is a static constant.
> > > > >
> > > > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > > > restricted to lsm/inode_init_security. Restrict the xattr names t=
hat
> > > > > may be set via this kfunc to the bpf.* namespace.
> > > > >
> > > > > Link: https://kernsec.org/pipermail/linux-security-module-archive=
/2022-October/034878.html [1]
> > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > ---
> > > > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++++=
+++++-
> > > > >  include/linux/bpf.h               |   1 +
> > > > >  include/linux/bpf_lsm.h           |   3 +
> > > > >  include/linux/evm.h               |   9 +--
> > > > >  include/linux/lsm_hook_defs.h     |   4 +-
> > > > >  include/linux/lsm_hooks.h         |  16 ++---
> > > > >  include/linux/security.h          |   5 ++
> > > > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > > > >  kernel/bpf/trampoline.c           |   3 +
> > > > >  security/bpf/hooks.c              |   1 +
> > > > >  security/integrity/evm/evm_main.c |   8 ++-
> > > > >  security/security.c               |   7 +-
> > > > >  security/selinux/hooks.c          |   4 +-
> > > > >  security/smack/smack_lsm.c        |  27 ++++----
> > > > >  14 files changed, 166 insertions(+), 38 deletions(-)
> > > >
> > > > I have a few specific comments below, inline with the patch, but I =
wanted
> > > > to make some general comments too.
> > > >
> > > > The kfunc additions really don't belong in the VFS kfunc file, plea=
se
> > > > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add=
 the
> > > > kfunc code to this new file.
> > >
> > > We expose a bunch of VFS heavy operations for various security module=
s
> > > and this is really not different. For xattrs we have it all centraliz=
ed
> > > in the VFS and in general all VFS related bpf kfuncs should continue
> > > living there and be registered there. Anything that's just bpf infra
> > > specific can go to security/bpf/kfuncs.c instead. But anyway, it's a =
bpf
> > > specific helper so it's the bpf maintainer's call.
> >
> > Completely agree. This is vfs related kfunc and has to be
> > in fs/bpf_fs_kfuncs.c to make sure vfs maintainers review it now
> > and all future changes to it.
>
> *laughs*
>
> Okay, then split out the LSM specific stuff into
> security/bpf_lsm_kfuncs.c; all the LSM macros/defines/calls should be
> in the LSM kfuncs file.

Paul,

I'm sorry, but you didn't demonstrate the level of understanding
of bpf to be trusted to maintain any piece of it.
