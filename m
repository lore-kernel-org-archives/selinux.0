Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642324ACC74
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493083; cv=pass; b=HEly04xDdpQmro3Nw2BlbG7vwzYczt2bf+IYg0C+gTZS43BP69hsdTahGl4FWsn74LWZLB4eL59vatFEImjelK4eWRXvtG7ZmJ6+pyrwPUkafh/uk9mSAiCYlYLpU5BWSpiG10aZ1fDVxDiXd/PsWsNcjwWJaiA14T9ak/ctBbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493083; c=relaxed/simple;
	bh=YK5Wharn3MvhXziVkzSATMwWQgMc1QJoA1IBgFlVnow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urZVuqKBfTIa76F7POlkNIyrIdgdsiLIT0rPbhUC4PhvAU3XfipH0fsR/svZeNGuZBClRU5j9R9FbYpcEL0UESS8LwWyszX+MZTMRPwjajzZyKbhXR4rpt2yZCSL/uQPWkK+gi/NIyUILfFw243YcTIfkKoNS5HMcjJt2h31bYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BBMAX2bw; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BBMAX2bw"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed1368so315055ad.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 10:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789493080; cv=none;
        d=google.com; s=arc-20260327;
        b=NCs63I1BpV6eHGRLjk6Fl2aICznUBUxrH8LvW5AUXIcmIRNoELDtk2FQH8CuLFxZO9
         /WVNtWePQoM5IO/LEX7ejIJ0ZY7XBEEwzeW9wCMbU1554I7bEs8yL59ubCuy8PB9/PXa
         rKNUUBwQAkFhZdKRoFMoTDlOeBH/4h9X1qHl98tQ6CAknZ+UhlmdXwVAkGiZKkdIk8Xk
         xxBBdk1qW6lgUqaAb5FuYB/CoQLQKtE7DamxF+vW3I64WI/iQzkwEL2MvceJk+Zf7Qtt
         puPqfBIQPcWoUSw+yyeDvzsl8fgKW9i9zidMq6afqT63V6UFAEgPpX22VaiKOS7OnQ0E
         1p3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o7oag7tiLT9gQ7HZpXwTqWFezAuLM/E3QUVZxySQWaQ=;
        fh=y16EEVNIZZFKPmyt+BZ5fxXjxU77JuXcZ1MXyJZxwfI=;
        b=fp23Et6NRxi6lj642ewzEY1bsvHFmizsITT0rDYCJtoE1iYVr+QjhucXiGUllTilc6
         XkcDYb7z5KbpRMYf/mEg4VseOVCiS1vRCXl6gUgexC/OlmgXNa1OcjVUcPRiCSeM/Q3t
         PEYlPjVvoWrS9IGisGxsnPpxw6FUIPuxhfMtcVhJUmqacq2T332areybt25JDjNsgoU8
         o3N7Im3OfIzX20CJpl1/kPLnzbnuzSkXDPxj4CgJOqYCbTaLZZSMnknKQY8+kbGiaVWc
         N1VrvSGafJOPpYhqqyf+a5LOP7NN40HMtKMtyFgHNfS0+ZglpigtQc09fBFLeWpOCYuL
         PNuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789493080; x=1790097880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o7oag7tiLT9gQ7HZpXwTqWFezAuLM/E3QUVZxySQWaQ=;
        b=BBMAX2bw5EeGurrd/QnGsKlGFtaRiTPpaxZKh+yLe47ZwOYOprejq/jhzZSgYGhMuj
         1Ng6/qZd82evfIFQR1isM0C2li89khhnvDdPgC9a6CzBa9zDLQxvYNnyOTkzzYIfDCWt
         YtKhqCqcWfIZMWr/xQjwtVaLSydxOsurYv7DFTPN2wQ58zTC/5iUYlfEuDFQ4KsglHC+
         +77XxEAGDtKWu54YWvZamSpIqK+jpIIuut8NDMBVtplQMWQzAp+RtzKD/KXm0Epivsoh
         ozsTGTcCAC55j50oK3bV+F3h1ivhrwYl8WFdALqQY/PB8rrp7EfLLTxDeQTvd6pugT0S
         xqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493080; x=1790097880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7oag7tiLT9gQ7HZpXwTqWFezAuLM/E3QUVZxySQWaQ=;
        b=DTKG5phpdKjsbceXE48+1DuTzF71+Tn6i/h8x50T1YPWkDlXP0+CyB07M9tiSBlzty
         sjOGRwLIfQ6kTGSfqSFbUAESU8X48dqZb6DBAog/F7t1R8fnrjtZEOQTW0qDbnkMvKFi
         YU93eUTJMeGFmBrgheaOR46maFwEDagvsQekSn/bIn5ZMJFwdwpqlDcMtS8iAf4n8PGh
         aMEVepvHi/scxC895Z4zEs5MR3lHDy2mSWG+sJZ+OEJ0DzNQhiyg8KuPmBgDX+JKRpN9
         wKMGgbPJYCExpYPLvfTUYXcSiOvZDFuU/nD36BFp7885szivC1DF/szT4+YqSINGWl90
         R4OQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2aWvglMCNlu5Ge/Dsm6/L3phOYCUsm2OjyGoH1USjpyESe8pGKnoJ+HqtGJU7cEVBprgC9S7T@vger.kernel.org
X-Gm-Message-State: AFuF++kgiCekWI0fhp7HsNYiEWP7LtGj9cH23Wx+IWBWqj2fxfukJoY9
	AtCUgXYz1yt4Q7UuHYfEzhOYkyjRhDfJR1TTqs4WkaxJ78/OZKMcAl3kdH+VRWCb6tHZZJxg6Zu
	QtfjG4I96V2CHx/ZdUJcT8T4EOvotXpvK4hVhtL96
X-Gm-Gg: AYBFou1lPIkmQa0qfmMswWFjgvC8wSMwoQuuF2Nn+9HQDOw2V42o2RJ8ahde8+tsYE3
	uxjtdNB73/pqrNbjIefaz+1cUHEyT4N0AxxxkNd5Qv+/yNXDoyuMDAlIYaweuJye3UzBCHfVKXM
	AxNGkvhjlyBs6UMsWhJl6yC8+uUbyjLCB7i8bC7RvkhNt3zgoNXxwG40XglszKxS06brd1Seo15
	OBmS2AKRIzYxHCHMOynqcAkZW22mQoMFlrFk2JI+TGNIVTbUHqT7dMvbx8Q7SoWLkiknZN2Cznd
	ngZ5wxBNCBvgKfk3sL3axTQCwHunTPejREAv0G+KHOInKM8UAUfXQrZ421Z/ncXvjxUraHw4OH5
	3+cBrQJ1eRNMEV2pO9AgbwA==
X-Received: by 2002:a17:903:17c3:b0:2d8:d4d0:7930 with SMTP id
 d9443c01a7336-2dd6c774465mr154307025ad.20.1789493080252; Tue, 15 Sep 2026
 10:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com> <aql6gyQJoxEjx0xY@shallyn-amd>
In-Reply-To: <aql6gyQJoxEjx0xY@shallyn-amd>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 15 Sep 2026 13:24:27 -0400
X-Gm-Features: AcwNN1WSVv7LZW6UVyRb9JR3csRFIsKvXqH5B9SYVb6JqyH17r20MARaxjq7-ak
Message-ID: <CAHC9VhTjo+znkxBmvseCH1K3aJN18ZO7+6QGE-a+Sy6XN=uaMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Serge Hallyn (AMD)" <sergeh@kernel.org>
Cc: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:04=E2=80=AFPM Serge Hallyn (AMD) <sergeh@kernel.o=
rg> wrote:
> On Mon, Sep 07, 2026 at 11:00:17PM +0200, Jann Horn wrote:
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
> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  fs/proc/base.c                | 14 ++++++++++++--
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  7 +++++++
> >  security/security.c           | 25 +++++++++++++++++++++++++
> >  4 files changed, 45 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index bec6197329dc..295b21203c7f 100644
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
> > @@ -884,10 +891,13 @@ static bool proc_mem_foll_force(struct file *file=
, struct mm_struct *mm)
> >                                       READ_ONCE(task->parent) =3D=3D cu=
rrent;
> >                       put_task_struct(task);
> >               }
> > -             return ptrace_active;
> > +             if (!ptrace_active)
> > +                     return false;
> > +             break;
> >       default:
> > -             return true;
> > +             break;
> >       }
> > +     return security_mem_foll_force(file->f_cred, priv->opened_by_owne=
r) =3D=3D 0;
> >  }
> >
> >  static ssize_t mem_rw(struct file *file, char __user *buf,
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index 65c9609ec207..12f84a1e6fab 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -36,6 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct c=
red *from,
> >  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
> >        unsigned int mode)
> >  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> > +LSM_HOOK(int, 0, mem_foll_force, const struct cred *subject, bool open=
ed_by_owner)
> >  LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_=
t *effective,
> >        kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 153e9043058f..e8bc2e644241 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -338,6 +338,7 @@ int security_binder_transfer_file(const struct cred=
 *from,
> >                                 const struct cred *to, const struct fil=
e *file);
> >  int security_ptrace_access_check(struct task_struct *child, unsigned i=
nt mode);
> >  int security_ptrace_traceme(struct task_struct *parent);
> > +int security_mem_foll_force(const struct cred *subject, bool opened_by=
_owner);
> >  int security_capget(const struct task_struct *target,
> >                   kernel_cap_t *effective,
> >                   kernel_cap_t *inheritable,
> > @@ -676,6 +677,12 @@ static inline int security_ptrace_traceme(struct t=
ask_struct *parent)
> >       return cap_ptrace_traceme(parent);
> >  }
> >
> > +static inline int security_mem_foll_force(const struct cred *subject,
> > +                                       bool opened_by_owner)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline int security_capget(const struct task_struct *target,
> >                                  kernel_cap_t *effective,
> >                                  kernel_cap_t *inheritable,
> > diff --git a/security/security.c b/security/security.c
> > index 71aea8fdf014..2cde1efdb7a6 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -595,6 +595,31 @@ int security_ptrace_traceme(struct task_struct *pa=
rent)
> >       return call_int_hook(ptrace_traceme, parent);
> >  }
> >
> > +/**
> > + * security_mem_foll_force() - Check if FOLL_FORCE is allowed
> > + * @subject: credentials using which /proc/$pid/mem was opened
> > + * @opened_by_owner: whether checks on open() were bypassed because th=
e opener
> > + *                   has the same MM as the target
> > + *
> > + * Check if FOLL_FORCE is allowed for accessing process memory through
> > + * /proc/$pid/mem. opened_by_owner signals whether the opener's MM was=
 the same
> > + * as the target MM, meaning the security_ptrace_access_check() hook w=
as
> > + * bypassed on open().
> > + * (Current current->mm does not matter for this; for example, if writ=
e() is
> > + * called on an FD that was received from another process which obtain=
ed it with
> > + * open("/proc/self/mem"), @opened_by_owner is still true.)
> > + *
> > + * Note that this hook is only designed to be useful in the opened_by_=
owner
> > + * case, where the subject credentials effectively also describe the o=
bject.
>
> Given this, would it make more sense to call the hook something
> like `security_mem_foll_force_self()` and only call it in the
> opened_by_owner=3D=3Dtrue case?

Sometimes we can't avoid it, but in general I'd like to see us avoid
calling LSM hooks conditionally, I'd much prefer the hook
implementation (either at the LSM framework level or the individual
LSM) do the conditional check.  See my comments on the previous
revision.

> I only suggest it because it seems to lower the cognitive load
> when looking at this code, so it might make it easier to maintain.

--=20
paul-moore.com
