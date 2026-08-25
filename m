Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B514A619
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666482; cv=pass; b=XF/UWAsJkUlhpDelW6xDujZPubglqJ4vXM1GkwEL0EolfYhWT/Vpr/yTMDbiQUOrtIGVSy88bPES6eRNbdVErNrUGWcrQDYMBCHFUfo7lXKeoO+kFUCLkt4Qnd3f3ELxHnWp944ch7XZ8BB8ocQXZAKioRF9rdyJO64tdAZRRr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666482; c=relaxed/simple;
	bh=pL5MtX5pBfqar5x9PgpB5R/pSJ/FKbRaufhUQePnTTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVg/53ghVTL6/C31659ivxzVF5GQtHkl0aWqwsWNUENC795ATgrprrnk4iJ8anSPduAtJ2MU6t4VXaQj0s7E5LDH6eauyaj4PBeA7TQZZD50U+OAnCDhsHIFIop1nV/QwBJrvzs+iqRSxjy4WnzLfJbr8ewSBQVfnvmlYW2E+6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlCFwgmT; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlCFwgmT"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d3b445a84fso94435ad.1
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 07:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787666480; cv=none;
        d=google.com; s=arc-20260327;
        b=fFVC5w4KDEWGzsq50bEL9bv6NS1edZftLciTYhTC6UXUYECg6F3bX4a93+gdGFYZ5r
         IbYf+HBIi8NQAvI1JH7ZHcETJpgPctBkNMTPv9PBNukUb9713ILEl3N76ZAqVtCFbF+q
         29RWiZr8ou7Dze/rpkWQ/7Ol/zAHR2El24cR1f/tgf5MNqSKPUUeZ8Of9yU5kFFcufG7
         blyy/ZwsSm5XBZ9JMPoR93TknJgZFnJaUplQDfwRq2j+iV30vxLy+XwyVXfzTYvHY+oC
         APb4A2Jl1NpwKbBFFoo8FHK885K7yrHSaPnUDec/F1Did//eHCN86RbQxmOT4qVGd9WN
         nLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XkjZxCxJdfT2LMn1D0Amm2coBqwtgPaPywf77Df6Gqc=;
        fh=XR4vONhlui6Piy7SYUCQl+QnV0iSNe36g0rauKXmBXk=;
        b=MEbF4owwPne+dOSlw3r5wvrhkSR9JWw8gfaYjUdw3nAoliQpMUmG9F2IwKw6wYMveT
         6zA1eL0llfxiDFtXQlXVRlbmEoHRyKIWY/fyxGxnlvNhauCKB/dH6Nx2jLE01lUu+r9Z
         VGrs9/Mea1BXWkIjMHy7qmKtdRVNs5xwMULoMiXYsnPRWLt5Zad8/horJWls+J6SZyjJ
         rtFpdEAQioHxtd91S8rlq4hoe3XzYVaQSeLYu650fQzqnmqLRrHigsdrBvkizLUItLjj
         69yzboEDZApxGfr8sRWfhnpath/Y3p4uVCdXVejVYWlxbrihXEJS1pNs1KvmxKdxsY+I
         tLgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787666480; x=1788271280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XkjZxCxJdfT2LMn1D0Amm2coBqwtgPaPywf77Df6Gqc=;
        b=qlCFwgmTd/AGLejg7DbPMG1scCcQhjLgx+t6nHQQ6ydMQZ4YkKX4rwutV0o4BghWtD
         9k4bOOZzzQatc+o0cd8eQH6dU/HTw/hv8hnEfgWJ9FDBnSPq6rCnE1uzXWkszpA+X5cL
         Zy/MplCq+UjtcSZMCJMY9ezFC34DsY54uaAPRRCu8pprFcRJyDetHwL8K17Wcd3EtNnO
         zLOwUbkZ1VpPMtWpOGys3IpBtR+29ut+pi0MNb6M4KF8Eow/nt+iSLBXDIM3AwoqgJTt
         2m4xj9bsTxrbkup5GRPEBrX7icbW+JIwiH/lh4S1IelEa82muMiYFasilMnvF7IVnHEe
         Y/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787666480; x=1788271280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XkjZxCxJdfT2LMn1D0Amm2coBqwtgPaPywf77Df6Gqc=;
        b=RCeKwEx+r8i+WqLpftzMqTkyEQwjVpS9mzI2pRJKaI9MR6oELsKYvbkqw0KgkNCt6/
         r3Pkwr92thRi4ETvJESHja5hhkJeP9M5garHqkVC3cOmRHP3DFL/qVqmsE3akJFZuEUU
         DvPLGxrnxqACQQykpwMfTmW59nV0A+N1H8ac4T1oJshYz91h8gmqB8PnFAzcra7Tn6gc
         SLG9XjZOVgeA1DXpDLDeJ2k4kQBvjtam3xGCw7XzeAipG9HfnFAkYK6l9lNQo709MB8v
         jsHH5f+EiL244Xc4aXElqqHbv9hudnXC0RfNNR9MVLU14djBmfhtpa8j+Wz5D1QHEpI+
         6VIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrkj9U5mAiaUNEUs0H126V9GoJomq5yOkG11pgRQGFN6uqiNisQL6H6SjY3W1H23SYYX5EAIXND@vger.kernel.org
X-Gm-Message-State: AFuF++ldWZr+F3cFOgPofb70zWYmpp7e+NkzM2MtvYv2pbTTGJgiNXXZ
	ntpvJCGOSRhE2j1csTmTGHgUGCXDtfjkWMOVlmTi9QtGdRFEAegzofiqm4zdeC1pa7j4ELlrPa5
	Q2ZyObwENRNFA8IkA3igrw+gbjUCDOtIbSoEuylnS
X-Gm-Gg: AR+sD108quJD07RvO+Qb9IMw3lUOoHi57jv+Z73H56O6xQKw9BgFMHDEHg1cZ4zWNC8
	UnwuHfmx4+HkKohFO26Pq57YI3NBroxnSDMdWCuJsbdLWtjit4gg9v/6X0kr8q4CcCqbDF6clZ4
	KWvmZjiuLK7pmt8LlmGF9cfUL38TqFCis2qIU0wWW0LX3G5YARZCJLHjqv6HPpNEW0y/Zf837Vm
	AwjbPfI2blqzGZkbkxtVqGZcgN7PfmsL1FNZzNoI98qfqk9ti0nns4nZcBaoz1mud8Uf25Y9v1s
	iP3wUavfg0Xu0J/eAviIxTF4eV5MO1pyEWEZ/8K1eidfFb5VbXTMz00GeLuw1TmgiqRZ6/y2Laq
	4Xdqng02JFK/TWr5yOcxC2Hj/Uyh5yw==
X-Received: by 2002:a17:903:98b:b0:2ce:b436:272a with SMTP id
 d9443c01a7336-2d6e07f16dfmr936545ad.3.1787666479395; Tue, 25 Aug 2026
 07:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <20260825-unweigerlich-biotechnologie-abnormal-accff844337f@brauner>
In-Reply-To: <20260825-unweigerlich-biotechnologie-abnormal-accff844337f@brauner>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 16:00:40 +0200
X-Gm-Features: AcwNN1Vfg8wgAQZTxYtddPbSXEdmTL4JLXmxKeMr_IG98S_z91XZ1jHBOrg8fJk
Message-ID: <CAG48ez14F42BgHm5dKeP4g8D_6CNhnAfF7BXdcBwa4NdtFiaiw@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:19=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
> > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently hav=
e no
> > good opportunity to block a process from overwriting read-only code in =
its
> > own address space through FOLL_FORCE writes via /proc/self/mem.
> > The security_ptrace_access_check() LSM hook is bypassed when a process
> > opens /proc/self/mem because this is considered "introspection".
> >
> > This causes a hole in SELinux EXECMEM enforcement, which tries to ensur=
e
> > that a process cannot create executable anonymous pages.
> >
> > PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> > accesses are only possible when the LSM allows ptrace() attachment; but=
 it
> > is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> > environments running lots of third-party code, such as Android.
> >
> > So, introduce a new LSM hook that can forbid FOLL_FORCE specifically fo=
r
> > such "introspective" accesses.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  fs/proc/base.c                |  6 ++++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 ++++++
> >  security/security.c           | 15 +++++++++++++++
> >  4 files changed, 28 insertions(+)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index bec6197329dc..3dfaef49bb70 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct f=
ile *file, unsigned int mode)
> >  /* private_data for proc_mem_operations */
> >  struct mem_private {
> >       struct mm_struct *mm;
> > +     /* Was the ptrace access check bypassed due to introspection? */
> > +     bool introspection;
> >  };
> >
> >  static int mem_open(struct inode *inode, struct file *file)
> > @@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct f=
ile *file)
> >       priv->mm =3D proc_mem_open(inode, PTRACE_MODE_ATTACH);
> >       if (IS_ERR_OR_NULL(priv->mm))
> >               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > +     priv->introspection =3D priv->mm =3D=3D current->mm;
> >       file->private_data =3D no_free_ptr(priv);
> >       return 0;
> >  }
> >
> >  static bool proc_mem_foll_force(struct file *file, struct mm_struct *m=
m)
> >  {
> > +     struct mem_private *priv =3D file->private_data;
> >       struct task_struct *task;
> >       bool ptrace_active =3D false;
> >
> > @@ -886,6 +890,8 @@ static bool proc_mem_foll_force(struct file *file, =
struct mm_struct *mm)
> >               }
> >               return ptrace_active;
> >       default:
> > +             if (priv->introspection)
> > +                     return security_introspect_mem_foll_force(file->f=
_cred) =3D=3D 0;
>
> Hm. Why not pass the reason to security_introspect_mem_foll_force() and
> call it unconditionally? Similarly it could also be called for the
> active ptracer case. Then you'd just need to pass a flag to the security
> hook and the LSM can decide based on that.

A process which is attached as a ptracer can modify memory with (for
example) PTRACE_POKETEXT and registers with (for example)
PTRACE_SETREGS. LSMs that want to prevent such debugging operations
are supposed to prevent ptrace attachment with the ptrace_access_check
hook.

I am just trying to plug the enforcement hole where ptrace-style
modification of process state is possible without going through
ptrace_access_check - which means just looking at these
"introspection" cases.

If I wanted to provide LSMs with a more granular ability to do some
PTRACE_MODE_ATTACH operations (like attaching via ptrace) while
blocking other operations (like PTRACE_POKETEXT or changing register
values), that would require more plumbing, so I'm not trying to do
that here.
