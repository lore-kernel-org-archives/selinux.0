Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133E41DEE5;
	Wed, 26 Aug 2026 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749293; cv=none; b=qmVjYLAL3mIa0swJu16TlGNgiW5jpWds77qX7Pbs+46QrN4PVdErtoBPwrHgI/K3yp4AHCpNVKg1QD9lOGK0vrmHNdu6bGKCURfJyEnMtR1xCHfitgmwKvZg/miklh30mNUmPIe1QLe+qN2GzE8o/+GGg7iEW3KxLEYAgMso+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749293; c=relaxed/simple;
	bh=AYFyTq94qRpcRHhSpB8wJkEYJdVK5QmqOCxSGkLYxoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0ekAjSvUrNbIvINRXdzv68TSrRvre7oIY/t2WGGzK6igX8k+lpCYFKk+nVTz9kr/RmuCXiRhfHwRa3HODUPwf2b5xESm8xgXnPqHLkpuOdrcherczF6siQd1srdR5VEO6R1BWgPCCDZSuKzVH7pQWe9yoFDCvxjF0kycG4hB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Deau/1hd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Deau/1hd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85E11F000E9;
	Wed, 26 Aug 2026 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787749288;
	bh=i7OqggJ1fEHcFpexMbhQr1tq9t2PX/2Yu/4dFGYaW10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Deau/1hdi71/TOvis/j3rQ6M5DSNtC+Kpb0/4DLYBDHfMXUUwrKHVpPabqpUJDPtS
	 NHVrY//f44lEJXjWKB0PXAG5QIUAG0304rpz3nGYnEOfCNaiExxKEAURMcUHdvT5oy
	 LzQpmPMtkJO/r+WlXV24XgkReQb9hpVH/HU1lDUrXhUHWecsnf+KBhcz85XyL5VftT
	 tBV5WEiYNpA96+w3fsyTK+zu41Qw3lM5ogZkrVsBURYTeXNxv5QpUxim8yuOJkQt/u
	 OYe8lRx9cHBWu+Blgo8xD745UPdnEgCfM25pZ4Gb+bEFmXWRU6OgD6LbAVRW+0nNft
	 cwFTYvzm8dD+A==
Date: Wed, 26 Aug 2026 15:01:21 +0200
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
Message-ID: <20260826-rotor-heterogen-wollust-2091c20f5e30@brauner>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
 <20260825-unweigerlich-biotechnologie-abnormal-accff844337f@brauner>
 <CAG48ez14F42BgHm5dKeP4g8D_6CNhnAfF7BXdcBwa4NdtFiaiw@mail.gmail.com>
 <20260826-juror-energetisch-hackordnung-83810c82adcf@brauner>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-juror-energetisch-hackordnung-83810c82adcf@brauner>

On Wed, Aug 26, 2026 at 12:29:14PM +0200, Christian Brauner wrote:
> On Tue, Aug 25, 2026 at 04:00:40PM +0200, Jann Horn wrote:
> > On Tue, Aug 25, 2026 at 3:19 PM Christian Brauner <brauner@kernel.org> wrote:
> > > On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
> > > > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently have no
> > > > good opportunity to block a process from overwriting read-only code in its
> > > > own address space through FOLL_FORCE writes via /proc/self/mem.
> > > > The security_ptrace_access_check() LSM hook is bypassed when a process
> > > > opens /proc/self/mem because this is considered "introspection".
> > > >
> > > > This causes a hole in SELinux EXECMEM enforcement, which tries to ensure
> > > > that a process cannot create executable anonymous pages.
> > > >
> > > > PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> > > > accesses are only possible when the LSM allows ptrace() attachment; but it
> > > > is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> > > > environments running lots of third-party code, such as Android.
> > > >
> > > > So, introduce a new LSM hook that can forbid FOLL_FORCE specifically for
> > > > such "introspective" accesses.
> > > >
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > ---
> > > >  fs/proc/base.c                |  6 ++++++
> > > >  include/linux/lsm_hook_defs.h |  1 +
> > > >  include/linux/security.h      |  6 ++++++
> > > >  security/security.c           | 15 +++++++++++++++
> > > >  4 files changed, 28 insertions(+)
> > > >
> > > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > > index bec6197329dc..3dfaef49bb70 100644
> > > > --- a/fs/proc/base.c
> > > > +++ b/fs/proc/base.c
> > > > @@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
> > > >  /* private_data for proc_mem_operations */
> > > >  struct mem_private {
> > > >       struct mm_struct *mm;
> > > > +     /* Was the ptrace access check bypassed due to introspection? */
> > > > +     bool introspection;
> > > >  };
> > > >
> > > >  static int mem_open(struct inode *inode, struct file *file)
> > > > @@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct file *file)
> > > >       priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
> > > >       if (IS_ERR_OR_NULL(priv->mm))
> > > >               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > > > +     priv->introspection = priv->mm == current->mm;
> > > >       file->private_data = no_free_ptr(priv);
> > > >       return 0;
> > > >  }
> > > >
> > > >  static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
> > > >  {
> > > > +     struct mem_private *priv = file->private_data;
> > > >       struct task_struct *task;
> > > >       bool ptrace_active = false;
> > > >
> > > > @@ -886,6 +890,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
> > > >               }
> > > >               return ptrace_active;
> > > >       default:
> > > > +             if (priv->introspection)
> > > > +                     return security_introspect_mem_foll_force(file->f_cred) == 0;
> > >
> > > Hm. Why not pass the reason to security_introspect_mem_foll_force() and
> > > call it unconditionally? Similarly it could also be called for the
> > > active ptracer case. Then you'd just need to pass a flag to the security
> > > hook and the LSM can decide based on that.
> > 
> > A process which is attached as a ptracer can modify memory with (for
> > example) PTRACE_POKETEXT and registers with (for example)
> > PTRACE_SETREGS. LSMs that want to prevent such debugging operations
> > are supposed to prevent ptrace attachment with the ptrace_access_check
> > hook.
> 
> Yeah, but as I said elsewhere that is very very coarse and you can't
> differentiate between the different operations performed on the other
> task.
> 
> > I am just trying to plug the enforcement hole where ptrace-style
> > modification of process state is possible without going through
> > ptrace_access_check - which means just looking at these
> > "introspection" cases.
> 
> It seems odd to just call a hook when it's introspection denied.
> And if that's the case why not also have a general hook in
> ptrace_may_access() itself in the introspection branch?
> 
> I would actually have use-cases for this btw.

To be clear: I have no quarrels with this going in as is. I'm just
interested in how policy decision such as this can be made more
meaningful in general. If you have thoughts around this you want to
share, please do.
