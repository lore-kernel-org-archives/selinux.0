Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEE34503E3
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922248; cv=pass; b=SN2eivMb3ISlXX1mmqDgiapMafgrju1LFwerVH6aY+qcDPCvjg6HyNdCyxd23T3n7BnExpmvkhuJL5pJsXxcBjfsnpi5KpRorfIGaN5+0Dt9rcinYcjcAnPYUMcnZWl9Bixi1YVws2rT3FE2xUhILqpBtdGNo42lI8qRUI2qH2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922248; c=relaxed/simple;
	bh=1Or7Yk4K+PY44II/C+RDLMa76t8c/i3h+x9+k7dnu84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGHZjGkN8EiN1f6VKtXMIisTmTqCR0u7JVPl8vAHvmOSCL4Ge8GIJ+Z6wH3lEEAByinBWEDT/fromAsmcWMzG1mPXpbarnQhIcPpxFqcgmu704J7a5bfAVudKTm3Is/dNZXoEOux2cFpxHhVtyfglViBAp2bcaNq1jFcYkMgepc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u665zmZF; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u665zmZF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccdf36f63dso113935ad.0
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 06:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787922245; cv=none;
        d=google.com; s=arc-20260327;
        b=Q3zkgEXR0ia0quSirwKA5ONru3SO40aN/BDGE2c3Pj/VVZesRJ+S/gF1o0gh3IGuTn
         GQXiZ0AUrEa1Jc6HVDGPZXX8CH46NMdLRG6VKsTmwDIB8duZFjFPrtXMCQ4HbvMLBdEN
         UqzdLGCnDjKl2QhElt/HvI6KBwCC623vkE4tjKe5O2v5MX2D/wIZGD6tMiRxW/lG2TvJ
         qCGv94MTnjTbjfgjPFuuFWvAG1JebTrY8plBnlv61M4CS1OKru7ap7tS+sVcFnovkN8g
         DD5CsRcU+TO200PiYZOTyLu4NALG9GTa4QCZO95hQZC5oid6u25TS9qnJHz/uHMNQ2mf
         W4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AGNsWwS32agEvYOtAgbeI1ZzpY28DdOxNCH4H2BS0Ww=;
        fh=ky5+7qO0BFN+YWWqdOffS0vBm6+UTuEstupgL4RkNME=;
        b=DRBtY9eHqAIugprzJQm7i0ORJ/48eFIusMrs/H1wX+zXAblEIXJ7brIKE0bpLfNaWO
         q7IfgBtedCaxruq7shri1jEpHfpmogMQA+Xg7zhkYr3+UlJOx8yz8b4aIZcbULaSwmFQ
         ByvMFEsLFfeYYrggxwbz2qpiSOq22o3lkmC40Ld9jgQKki3bOACYGAkznO2tPMQiUoyu
         SmP3rrK9nRe/+Y6O4URaLDhf4VjMRbwslDgEZvH84CC52E8qQg640Knjd1qYWWjMfp+0
         eKKqh5OrEi0fvkkQE+gbG8VaYM9NimyqzrwWWT5EuKHz+3WLS2tSiBdvzD9mGNUApVOV
         U7yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787922245; x=1788527045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AGNsWwS32agEvYOtAgbeI1ZzpY28DdOxNCH4H2BS0Ww=;
        b=u665zmZF/0xyEKSpEUeig5u1rrZu0obH5B1WsKOsz1Izg/YPeqnkSncVDlgPPPIzgX
         CjEjcJzJoX5Yb9sTDNJvIy9qLHX+LlAY289I2zh9U393V7fe+hJKaxEviL+yW3LnQyDC
         8byiEmjYFyu1v4dOgMjJf0zWwYtwnLtiWbEd86mWCcJQqSyN8IyRpijZ+t2D702KyrpG
         GBfLWb4+j8TAXGY3wJr02VHt3VOwzmDogBhQkuSCI3/zuowFNJ4tPOWmTchoaouMuwKB
         PUTzdXrJPd0ZVAiAoykHqz/I3qhMzKvLUEm6rwDZPf9abuQZ7Xfm/0Yx6uXJ+jMOvD9d
         /EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922245; x=1788527045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AGNsWwS32agEvYOtAgbeI1ZzpY28DdOxNCH4H2BS0Ww=;
        b=gcv8mk63ZfMrrdXxT5VTcMGzG3u4A0JOX5aaUhIdsCVxfjSGxAgZuT76K5yVbcxW4w
         y+orexU/90d1zljjm2U/QwfU7C33UkIAL3RV5L1HSp35zaX+BYsGIAhR9EouJQegcSVy
         nf3Hm/SBeXehNpYfScIwX6HIaglX1NGJfF6hA79i0vWuPl0i1BLQixJuwHX8uBK5SjOh
         L/y09QSy5P6zWdyT0Bc19MCm/UH12fN9sb5AUh1bmnDLmkRk5cfqAEZIHYI6KQzvgZWr
         oWCwsIJl4kr9eW0RYqgpYa2TzRjWdXp+s7PCd7dxDgHhY7e8vrdLzHZ2kNKpKDqL/Prv
         3Htg==
X-Forwarded-Encrypted: i=1; AHgh+RoZhMQskrRzO9aBvnx1QvzVzebDsRYvvzE6zWy0RFniMJM17lqKp9jBewEHDI0dd2ifE53kv4J5@vger.kernel.org
X-Gm-Message-State: AFuF++l4aMXVltbWXCEIyezolMfG03nojNaPZitEIV29hx+89068LTa6
	ko8MLj6zlUNQoKvpkKQqYyxyshcUNmnyxn0/T1WV69xJjDhgJfPjZ/pY6lwUjokJNzi+JSLYBp9
	mGg/GFjmmspy0bwun1Ox8jRKc6HNuRESI4Mzs5870
X-Gm-Gg: AR+sD11DlYnFJxltZ092Zu8C1FJOerGo3R/yTLwXeUIi+dxnJj3xwfZ/r0Oud8RLkMl
	6zwtBonwE+lQIXB+Edm1AJ7VPn/u4SFyQ04Mvs6U1vtpVEBkOB9YuZWemMQRC6ySAS6fIzLFsBS
	RpbhbpCbohVrCWNY3ywCwqqOBiGsoVD70xlUtFXu1/SDM3DdDdh/ko255esJ9tQXp3CcMWq6LnW
	aZ06j4d5RoHhi/h4akASLuSS1Rr4Ght8qlB2MO5xI+0YVvORG2achSQJZjcGi97aQKqzV4O24Ig
	MeIlpekZ+zBQcvVE463/GRMnQmY5Xss0fZFLCqtGVnfS6tDrum+sUnOz//3jOtrFNJfyezHv+Bj
	wAKplq2s/fM0dAFu8vSCJmqPijLEB9J3dGQC3z2gS
X-Received: by 2002:a17:902:d2c7:b0:2d3:153d:acae with SMTP id
 d9443c01a7336-2d74f1898edmr6942445ad.0.1787922244063; Fri, 28 Aug 2026
 06:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com> <82929c994076d95f99560ecc67f6cfce@paul-moore.com>
In-Reply-To: <82929c994076d95f99560ecc67f6cfce@paul-moore.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 28 Aug 2026 15:03:26 +0200
X-Gm-Features: AcwNN1XrNltc_VuHQhdOWGeareZ_mPOwkDqM-dog-6Ggxhiy2PpwWw0NSSm2Yn8
Message-ID: <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:10=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug 25, 2026 Jann Horn <jannh@google.com> wrote:
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
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  fs/proc/base.c                |  9 +++++++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 ++++++
> >  security/security.c           | 20 ++++++++++++++++++++
> >  4 files changed, 36 insertions(+)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index bec6197329dc..dc6fdcb47b79 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -851,6 +851,11 @@ static int __mem_open(struct inode *inode, struct =
file *file, unsigned int mode)
> >  /* private_data for proc_mem_operations */
> >  struct mem_private {
> >       struct mm_struct *mm;
> > +     /*
> > +      * Was the ptrace access check on open bypassed because the opene=
r used
> > +      * the same MM (introspection)?
> > +      */
> > +     bool opened_by_owner;
> >  };
> >
> >  static int mem_open(struct inode *inode, struct file *file)
> > @@ -864,12 +869,14 @@ static int mem_open(struct inode *inode, struct f=
ile *file)
> >       priv->mm =3D proc_mem_open(inode, PTRACE_MODE_ATTACH);
> >       if (IS_ERR_OR_NULL(priv->mm))
> >               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > +     priv->opened_by_owner =3D priv->mm =3D=3D current->mm;
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
> > @@ -886,6 +893,8 @@ static bool proc_mem_foll_force(struct file *file, =
struct mm_struct *mm)
> >               }
> >               return ptrace_active;
> >       default:
> > +             if (priv->opened_by_owner)
> > +                     return security_mem_foll_force_opened_by_owner(fi=
le->f_cred) =3D=3D 0;
> >               return true;
> >       }
> >  }
>
> First things first, we've got to shorten that hook name :)  What do you
> think of security_proc_mem_foll_force()?

If we move the "opened_by_owner" part into a flag then I guess that
works... will do.

> Beyond that, we really try to avoid making LSM hook calls conditional.  I=
t
> can limit what an LSM can enforce, it tends to be a bit more fragile, and
> it adds some unnecessary work in the case where CONFIG_SECURITY is
> disabled.  I would suggest passing 'opened_by_owner' flag as a second
> parameter to the LSM hook and calling the hook unconditionally in the
> default switch case as a replacement for the 'return true;' statement.  I
> understand it may seem a bit odd, but we try to make the LSM interface as
> generic as possible with respect to different models and this is one way

I guess I can do that, but then the question becomes, what other modes
of using the LSM hook that don't currently exist in the kernel should
I be supporting with this? I can make this a parameter, but any LSM
policy that actually uses the parameter in a different way would
probably be buggy/inconsistent, unless other new LSM hooks are added.

If your intent is to make the hook work for any /proc/$pid/mem access,
including when the caller is ptrace-attached, then I guess I have to
move around the security hook call in proc_mem_foll_force() a little
bit. I guess I'll do that in v3, though I really don't like trying to
come up with a reasonable in-kernel API contract for a scenario that
currently has zero users.

> we do that.  It also ensures we don't have to process the 'opened_by_owne=
r'
> check in that case where the LSM is disabled.

(I don't think that's an improvement - we have to do the comparison
either way, but in the current version, we then use it to
conditionally branch to a security hook, while the v3 patch will
instead unconditionally call into the security hook.)

> >  LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_=
t *effective,
> >        kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 153e9043058f..74eb876054b0 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -338,6 +338,7 @@ int security_binder_transfer_file(const struct cred=
 *from,
> >                                 const struct cred *to, const struct fil=
e *file);
> >  int security_ptrace_access_check(struct task_struct *child, unsigned i=
nt mode);
> >  int security_ptrace_traceme(struct task_struct *parent);
> > +int security_mem_foll_force_opened_by_owner(const struct cred *subject=
);
> >  int security_capget(const struct task_struct *target,
> >                   kernel_cap_t *effective,
> >                   kernel_cap_t *inheritable,
> > @@ -676,6 +677,11 @@ static inline int security_ptrace_traceme(struct t=
ask_struct *parent)
> >       return cap_ptrace_traceme(parent);
> >  }
> >
> > +static inline int security_mem_foll_force_opened_by_owner(const struct=
 cred *subject)
> > +{
> > +     return 0;
> > +}
>
> With proc_mem_foll_force() currently returning true/1 in this case,
> shouldn't the LSM hook return true/1 when disabled?

No, I have proc_mem_foll_force() doing:
"return security_mem_foll_force_opened_by_owner(file->f_cred) =3D=3D 0;"

So returning 0 means "allowed", returning an error code means "denied".
