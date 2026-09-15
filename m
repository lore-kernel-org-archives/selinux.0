Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5243E48B;
	Tue, 15 Sep 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494873; cv=none; b=Kc6B/v3/QQ16b3Ir3sHO81Iauyq6LDq6A/n0Jg9pLgdh6Y0LOC5+GIFaA39h4JYRZq+d+c64WrjZQt2LMbIZ++JRsgwr47OAE5h53ng4Q3sQP58iYjzdrT82Z8UqQyv5QPs2Of+7dAGa5LQUgO4PuZYu9rjqlEkwbOpwoXBhcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494873; c=relaxed/simple;
	bh=v63FY1fnrEkx7QXoR+GSQJrHmBwDUBI7qUvyhgXbjJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLM3JaSuf92L3BJGp4iRYllH6psad6XOH7xwNB2xyDtJCY18HU+xKWW9AqXdpvKf3FVAdNy08jWIaEysqSkbIXoQJbQqfwJvzo0SdkZJzviaKGm9sG1OMNs0kMIPiJxsGRgByGcNxf1zypeST5Z0DfDgyX7mvYP4p6thqKclKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=unknown smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=PmIGImVV; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="PmIGImVV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1789494867; bh=v63FY1fnrEkx7QXoR+GSQJrHmBwDUBI7qUvyhgXbjJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PmIGImVVPLzOWAumb6PW4gmlneVv+6xM1ssscap9T86yUWBljn+p2Oe4CIeuTNomy
	 R4XRJJzbs/FHPhGufWGaj99v8F+0jNMEZR9RzNk06ts81sf+zoQMwDJY+zcgm8G6cG
	 gABgIEWhRHDeodGimlEH6KvdGSxsw/csqozdOy8UBNUlPxB1dBOb4nzjGcuQT6kEJc
	 UjwPqdVsqPdB/CKRGB4hODB73ZpqHpi+SpHqg2xATLd6qEeXP2LjMeqajlTf/Jzmzi
	 fiL8M2Q3os1jyaxpNS+cBkHGFPtj4pzkCY7a0M5IfkU9ChBuWtkG8io1mgHQ6xOC81
	 O8SwtEMelSm0w==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 080F9D83; Tue, 15 Sep 2026 12:54:27 -0500 (CDT)
Date: Tue, 15 Sep 2026 12:54:27 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge Hallyn (AMD)" <sergeh@kernel.org>, Jann Horn <jannh@google.com>,
	James Morris <jmorris@namei.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Jeff Xu <jeffxu@google.com>,
	=?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Message-ID: <aqmGU4rylUsH9LqA@hallyn.com>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com>
 <aql6gyQJoxEjx0xY@shallyn-amd>
 <CAHC9VhTjo+znkxBmvseCH1K3aJN18ZO7+6QGE-a+Sy6XN=uaMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTjo+znkxBmvseCH1K3aJN18ZO7+6QGE-a+Sy6XN=uaMQ@mail.gmail.com>

On Tue, Sep 15, 2026 at 01:24:27PM -0400, Paul Moore wrote:
> On Tue, Sep 15, 2026 at 1:04 PM Serge Hallyn (AMD) <sergeh@kernel.org> wrote:
> > On Mon, Sep 07, 2026 at 11:00:17PM +0200, Jann Horn wrote:
> > > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently have no
> > > good opportunity to block a process from overwriting read-only code in its
> > > own address space through FOLL_FORCE writes via /proc/self/mem.
> > > The security_ptrace_access_check() LSM hook is bypassed when a process
> > > opens /proc/self/mem because this is considered "introspection".
> > >
> > > This causes a hole in SELinux EXECMEM enforcement, which tries to ensure
> > > that a process cannot create executable anonymous pages.
> > >
> > > PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> > > accesses are only possible when the LSM allows ptrace() attachment; but it
> > > is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> > > environments running lots of third-party code, such as Android.
> > >
> > > So, introduce a new LSM hook that can forbid FOLL_FORCE specifically for
> > > such "introspective" accesses.
> > >
> > > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > >  fs/proc/base.c                | 14 ++++++++++++--
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  7 +++++++
> > >  security/security.c           | 25 +++++++++++++++++++++++++
> > >  4 files changed, 45 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index bec6197329dc..295b21203c7f 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -851,6 +851,11 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
> > >  /* private_data for proc_mem_operations */
> > >  struct mem_private {
> > >       struct mm_struct *mm;
> > > +     /*
> > > +      * Was the ptrace access check on open bypassed because the opener used
> > > +      * the same MM (introspection)?
> > > +      */
> > > +     bool opened_by_owner;
> > >  };
> > >
> > >  static int mem_open(struct inode *inode, struct file *file)
> > > @@ -864,12 +869,14 @@ static int mem_open(struct inode *inode, struct file *file)
> > >       priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
> > >       if (IS_ERR_OR_NULL(priv->mm))
> > >               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > > +     priv->opened_by_owner = priv->mm == current->mm;
> > >       file->private_data = no_free_ptr(priv);
> > >       return 0;
> > >  }
> > >
> > >  static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
> > >  {
> > > +     struct mem_private *priv = file->private_data;
> > >       struct task_struct *task;
> > >       bool ptrace_active = false;
> > >
> > > @@ -884,10 +891,13 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
> > >                                       READ_ONCE(task->parent) == current;
> > >                       put_task_struct(task);
> > >               }
> > > -             return ptrace_active;
> > > +             if (!ptrace_active)
> > > +                     return false;
> > > +             break;
> > >       default:
> > > -             return true;
> > > +             break;
> > >       }
> > > +     return security_mem_foll_force(file->f_cred, priv->opened_by_owner) == 0;
> > >  }
> > >
> > >  static ssize_t mem_rw(struct file *file, char __user *buf,
> > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > > index 65c9609ec207..12f84a1e6fab 100644
> > > --- a/include/linux/lsm_hook_defs.h
> > > +++ b/include/linux/lsm_hook_defs.h
> > > @@ -36,6 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
> > >  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
> > >        unsigned int mode)
> > >  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> > > +LSM_HOOK(int, 0, mem_foll_force, const struct cred *subject, bool opened_by_owner)
> > >  LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
> > >        kernel_cap_t *inheritable, kernel_cap_t *permitted)
> > >  LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
> > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > index 153e9043058f..e8bc2e644241 100644
> > > --- a/include/linux/security.h
> > > +++ b/include/linux/security.h
> > > @@ -338,6 +338,7 @@ int security_binder_transfer_file(const struct cred *from,
> > >                                 const struct cred *to, const struct file *file);
> > >  int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
> > >  int security_ptrace_traceme(struct task_struct *parent);
> > > +int security_mem_foll_force(const struct cred *subject, bool opened_by_owner);
> > >  int security_capget(const struct task_struct *target,
> > >                   kernel_cap_t *effective,
> > >                   kernel_cap_t *inheritable,
> > > @@ -676,6 +677,12 @@ static inline int security_ptrace_traceme(struct task_struct *parent)
> > >       return cap_ptrace_traceme(parent);
> > >  }
> > >
> > > +static inline int security_mem_foll_force(const struct cred *subject,
> > > +                                       bool opened_by_owner)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > >  static inline int security_capget(const struct task_struct *target,
> > >                                  kernel_cap_t *effective,
> > >                                  kernel_cap_t *inheritable,
> > > diff --git a/security/security.c b/security/security.c
> > > index 71aea8fdf014..2cde1efdb7a6 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -595,6 +595,31 @@ int security_ptrace_traceme(struct task_struct *parent)
> > >       return call_int_hook(ptrace_traceme, parent);
> > >  }
> > >
> > > +/**
> > > + * security_mem_foll_force() - Check if FOLL_FORCE is allowed
> > > + * @subject: credentials using which /proc/$pid/mem was opened
> > > + * @opened_by_owner: whether checks on open() were bypassed because the opener
> > > + *                   has the same MM as the target
> > > + *
> > > + * Check if FOLL_FORCE is allowed for accessing process memory through
> > > + * /proc/$pid/mem. opened_by_owner signals whether the opener's MM was the same
> > > + * as the target MM, meaning the security_ptrace_access_check() hook was
> > > + * bypassed on open().
> > > + * (Current current->mm does not matter for this; for example, if write() is
> > > + * called on an FD that was received from another process which obtained it with
> > > + * open("/proc/self/mem"), @opened_by_owner is still true.)
> > > + *
> > > + * Note that this hook is only designed to be useful in the opened_by_owner
> > > + * case, where the subject credentials effectively also describe the object.
> >
> > Given this, would it make more sense to call the hook something
> > like `security_mem_foll_force_self()` and only call it in the
> > opened_by_owner==true case?
> 
> Sometimes we can't avoid it, but in general I'd like to see us avoid
> calling LSM hooks conditionally, I'd much prefer the hook
> implementation (either at the LSM framework level or the individual
> LSM) do the conditional check.  See my comments on the previous
> revision.

Ah.  Sorry, I had missed that.  +1.
