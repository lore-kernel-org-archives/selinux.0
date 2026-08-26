Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018853C060F;
	Wed, 26 Aug 2026 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740163; cv=none; b=gnkLjaT0Lh2fo3iJhbgGihgQfagV+9o7RULr7RRV/ljHHZApFkuVkFc0VSClzDF911w+lK6XvSVvc47AFgunQLxsPrv0tCAb20ursWPq8IsD1asAdvzPN5/RVxcJJRV8VRadzRCqmndzfEgp5bdWULEdDPfTG4uulnBkBEqT0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740163; c=relaxed/simple;
	bh=WAMY8rvhu5HBggds9yQV6ybnU0Jj5dXbebrUkG8R5Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4KBYDwlZYqjcJuaEqwgti6US5FoDcFSPr595mJ0P17Plvj7fVMAuWsKGYhh+BhN62/1nVhK2U/q/TCU5t/KZQnKklrHiOyTIEUfzKZI9J/LRqAaY7TuScPVz54nDJ871qLVYx9Kv7UsZuVK6Cfg7RuSFUYK9r0ayYsePjnwuVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pjahm2Tn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pjahm2Tn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B251F00A3D;
	Wed, 26 Aug 2026 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740161;
	bh=avVgzSrE2MWkMOJSSk+2BWcmErJRBoIA1/Sx++WOC9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pjahm2Tnm2ufdabqqoC/oGBW+/G1OnTO+3WwxoNiJfWxuwuEklqQpt8ro7mw8Tuib
	 wSCbhS1ROT+yNdXqbgBA7f7m7d4YYawLqwq+7CgCg8RVky3Ba3GEH+m3RHykPt2hUV
	 nmvaWnnjLqOMVC1uZCad7zK/9tmkcxhPImTQcqZtaBZVT145ooJHGsaj+RQaYfPRn6
	 xhy3Ehp2u2zzDoq8NaKxXWPiOT/vqjSvrSwHhOl4ixvYwVvYjsrrduwgfJtW+PVrFq
	 +m16gKo52jp4Bc0IK/O1s5GOs+aahq0EC/xPoqJ8KvUy4PzHJt4m2ABxV+1JbDC89N
	 cnSregFOsc0QQ==
Date: Wed, 26 Aug 2026 12:29:14 +0200
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
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Message-ID: <20260826-juror-energetisch-hackordnung-83810c82adcf@brauner>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
 <20260825-unweigerlich-biotechnologie-abnormal-accff844337f@brauner>
 <CAG48ez14F42BgHm5dKeP4g8D_6CNhnAfF7BXdcBwa4NdtFiaiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez14F42BgHm5dKeP4g8D_6CNhnAfF7BXdcBwa4NdtFiaiw@mail.gmail.com>

On Tue, Aug 25, 2026 at 04:00:40PM +0200, Jann Horn wrote:
> On Tue, Aug 25, 2026 at 3:19 PM Christian Brauner <brauner@kernel.org> wrote:
> > On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
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
> > > ---
> > >  fs/proc/base.c                |  6 ++++++
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  6 ++++++
> > >  security/security.c           | 15 +++++++++++++++
> > >  4 files changed, 28 insertions(+)
> > >
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index bec6197329dc..3dfaef49bb70 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
> > >  /* private_data for proc_mem_operations */
> > >  struct mem_private {
> > >       struct mm_struct *mm;
> > > +     /* Was the ptrace access check bypassed due to introspection? */
> > > +     bool introspection;
> > >  };
> > >
> > >  static int mem_open(struct inode *inode, struct file *file)
> > > @@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct file *file)
> > >       priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
> > >       if (IS_ERR_OR_NULL(priv->mm))
> > >               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > > +     priv->introspection = priv->mm == current->mm;
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
> > > @@ -886,6 +890,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
> > >               }
> > >               return ptrace_active;
> > >       default:
> > > +             if (priv->introspection)
> > > +                     return security_introspect_mem_foll_force(file->f_cred) == 0;
> >
> > Hm. Why not pass the reason to security_introspect_mem_foll_force() and
> > call it unconditionally? Similarly it could also be called for the
> > active ptracer case. Then you'd just need to pass a flag to the security
> > hook and the LSM can decide based on that.
> 
> A process which is attached as a ptracer can modify memory with (for
> example) PTRACE_POKETEXT and registers with (for example)
> PTRACE_SETREGS. LSMs that want to prevent such debugging operations
> are supposed to prevent ptrace attachment with the ptrace_access_check
> hook.

Yeah, but as I said elsewhere that is very very coarse and you can't
differentiate between the different operations performed on the other
task.

> I am just trying to plug the enforcement hole where ptrace-style
> modification of process state is possible without going through
> ptrace_access_check - which means just looking at these
> "introspection" cases.

It seems odd to just call a hook when it's introspection denied.
And if that's the case why not also have a general hook in
ptrace_may_access() itself in the introspection branch?

I would actually have use-cases for this btw.
