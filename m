Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AC43FD26;
	Fri,  4 Sep 2026 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514278; cv=none; b=P16pGKZVgW7UtRTUzaBp7GaSqUJ+4EwdrF0hv8v8gjViK5PzasoWaWaKXaPaKsDad726jfH0JYYD2bAT7YaECw4I38wxtoIfiOo1Bc6ugB+GeaRS/oBNJAOB4TIwosXadTwBr50pd1zxzWM1sbQFt17GmhYwsY89Cv8vNW9XGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514278; c=relaxed/simple;
	bh=4pI1zl/5U8YQGo1XRj3s+biapuquKidjKhumAVkEY7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMud5HKajZyjKDFX5j2NBlqD4Yt12O2eNFz2Xd/aELclJtc0dO73ZANl4j4/AWe21bz3acKT1/wYtrEmu1BqDg+936FQGX5od+qcG+CrhUgYYrtVUmEglLWVQLBYhQLGZeA6+HgS5V8TuffklO961txpyxpjYKlhcNDjml6CFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnF573Ue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnF573Ue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4991F00A3D;
	Fri,  4 Sep 2026 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788514276;
	bh=ntGqMbIytPTwLlJR1fA/xTB+g7J2BTUkRTGlMKhEpBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EnF573UetbEzUTlGgz4Tk/HQtIPjMLYjCzaINKkr83N0oVneVEIXv2SAaw7NFguOD
	 HszNUHvb6pel1Q8+9mMkTNoN8ouZCDDtIWGnq+Y7SdT/t755RNwfjkCOWxii5TURV7
	 1cmDnH1wsJ6kUAzaR33Y7Zw5Q/I/X7pg6LgaikJ/PPdtiAcvZemp4uuIH0q2gcj1dH
	 WYujHcCSYUyZD+GzDq/eM9lmkPQHH/4CwFRz47OAM+WgM7PIXRzOn0nIL2JXHc3CKz
	 p7NOLDy38otOuXtrAUkU0o6muWT3qYtTElKJDUSH1H4HEyXqaVIghB3GDP4zRdL4Sc
	 Wz/r90OEWi/ug==
Date: Fri, 4 Sep 2026 11:31:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Message-ID: <20260904-busfahren-klarkommen-kodex-da59b836bef2@brauner>
References: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
 <82929c994076d95f99560ecc67f6cfce@paul-moore.com>
 <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>

On Fri, Aug 28, 2026 at 03:03:26PM +0200, Jann Horn wrote:
> On Fri, Aug 28, 2026 at 3:10 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Aug 25, 2026 Jann Horn <jannh@google.com> wrote:
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
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > ---
> > >  fs/proc/base.c                |  9 +++++++++
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  6 ++++++
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 36 insertions(+)
> > >
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index bec6197329dc..dc6fdcb47b79 100644
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
> > > @@ -886,6 +893,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
> > >               }
> > >               return ptrace_active;
> > >       default:
> > > +             if (priv->opened_by_owner)
> > > +                     return security_mem_foll_force_opened_by_owner(file->f_cred) == 0;
> > >               return true;
> > >       }
> > >  }
> >
> > First things first, we've got to shorten that hook name :)  What do you
> > think of security_proc_mem_foll_force()?
> 
> If we move the "opened_by_owner" part into a flag then I guess that
> works... will do.
> 
> > Beyond that, we really try to avoid making LSM hook calls conditional.  It
> > can limit what an LSM can enforce, it tends to be a bit more fragile, and
> > it adds some unnecessary work in the case where CONFIG_SECURITY is
> > disabled.  I would suggest passing 'opened_by_owner' flag as a second
> > parameter to the LSM hook and calling the hook unconditionally in the
> > default switch case as a replacement for the 'return true;' statement.  I
> > understand it may seem a bit odd, but we try to make the LSM interface as
> > generic as possible with respect to different models and this is one way
> 
> I guess I can do that, but then the question becomes, what other modes
> of using the LSM hook that don't currently exist in the kernel should
> I be supporting with this? I can make this a parameter, but any LSM
> policy that actually uses the parameter in a different way would
> probably be buggy/inconsistent, unless other new LSM hooks are added.
> 
> If your intent is to make the hook work for any /proc/$pid/mem access,
> including when the caller is ptrace-attached, then I guess I have to
> move around the security hook call in proc_mem_foll_force() a little
> bit. I guess I'll do that in v3, though I really don't like trying to
> come up with a reasonable in-kernel API contract for a scenario that
> currently has zero users.

So we effectively landed on what I proposed in the first version... 
