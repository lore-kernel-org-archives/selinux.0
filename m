Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80021353A94;
	Fri, 21 Aug 2026 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338340; cv=none; b=APPXUQakv9c6f1CPAiHY3yawbgjyKWqYV3J1d6Qn6qQtFP72Io5ve39gSEDZ2ZFM6o/4nKHnPGwehMcTSJRDc8T/R3wkbGWvirLxLsWPQDDnZ1NHRGN7Jw5QzacHNER4iLYqojq6mRhZvt8p5+0NX3qRprn8F5jkDaUVXqjBLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338340; c=relaxed/simple;
	bh=0IWfNo1+XuQTGbNEsw1+XMJXWhiirRyaeGwj6vWcv7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjAYw9tB3uDfaymXX36tk2uYMfiM9+78Oyg5bG1An8Ko5DZs2SZGGH8Q8RrytYEjpWNMIjDQJkVXRqcFiQhs25hUqcURDab3aSLbar9ewaKuRUvIWLuWtZCkoAdQBSp0P3mHMEVFSdgvvG9PR2Z5jaIk2gi3HnDHaMtFxEefdc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk6QCGUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk6QCGUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FDB1F000E9;
	Fri, 21 Aug 2026 18:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787338339;
	bh=b1BHtoNef4td6Og2iN6g1HbZL10mPM2Ly/XyYiAnVCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rk6QCGUzCZBsasCr/5vVPikhT1k7x2I/nEl+6mwH3QqZ1LsZqAktAG9teYTJW/0Yf
	 rQgob+ZL0jX4pwL7soVlD0N6QpwSGKyD/ixmIP/zx274iknFX2G+3qo1r1ekFrsPnz
	 IThkxrEQPLRhMukqYrxLSenuQ3iWYu2HZ+PW97vI8/Ar6c2HoWQfaTsTX62UAv9348
	 u1FoWSqxGLWXqPtmc0ncBX6onVTxn04mHQNzkB/r2zrJ4joBxRduJPW1rdt4J5hOwn
	 KmRIWkYTD+3PRbVlx0NdK9o5eUgVGbl0a62Ev+k78ABMvBtZwY8p+YpcKo+1GbSdX0
	 XEecZhcBdhdnw==
Date: Fri, 21 Aug 2026 19:52:11 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Message-ID: <aoibvf6CY99IXynk@gremlin>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
 <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org>
 <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>

On Fri, Aug 21, 2026 at 04:48:32PM +0200, Jann Horn wrote:
> On Fri, Aug 21, 2026 at 4:19 PM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> > On 8/20/26 20:44, Jann Horn wrote:
> > > On Thu, Aug 20, 2026 at 7:22 PM David Hildenbrand (Arm)
> > > <david@kernel.org> wrote:
> > >> On 8/18/26 21:51, Jann Horn wrote:
> > >>> If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently have no
> > >>> good opportunity to block a process from overwriting read-only code in its
> > >>> own address space through FOLL_FORCE writes via /proc/self/mem.
> > >>> The security_ptrace_access_check() LSM hook is bypassed when a process
> > >>> opens /proc/self/mem because this is considered "introspection".
> > >>>
> > >>> This causes a hole in SELinux EXECMEM enforcement, which tries to ensure
> > >>> that a process cannot create executable anonymous pages.
> > >>>
> > >>> PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> > >>> accesses are only possible when the LSM allows ptrace() attachment; but it
> > >>> is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> > >>> environments running lots of third-party code, such as Android.
> > >>>
> > >>> So, introduce a new LSM hook that can forbid FOLL_FORCE specifically for
> > >>> such "introspective" accesses.
> > >>>
> > >>> Signed-off-by: Jann Horn <jannh@google.com>
> > >>> ---
> > >>>  fs/proc/base.c                |  6 ++++++
> > >>>  include/linux/lsm_hook_defs.h |  1 +
> > >>>  include/linux/security.h      |  6 ++++++
> > >>>  security/security.c           | 15 +++++++++++++++
> > >>>  4 files changed, 28 insertions(+)
> > >>>
> > >>> diff --git a/fs/proc/base.c b/fs/proc/base.c
> > >>> index bec6197329dc..3dfaef49bb70 100644
> > >>> --- a/fs/proc/base.c
> > >>> +++ b/fs/proc/base.c
> > >>> @@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
> > >>>  /* private_data for proc_mem_operations */
> > >>>  struct mem_private {
> > >>>       struct mm_struct *mm;
> > >>> +     /* Was the ptrace access check bypassed due to introspection? */
> > >>> +     bool introspection;
> > >>>  };
> > >>>
> > >>>  static int mem_open(struct inode *inode, struct file *file)
> > >>> @@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct file *file)
> > >>>       priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
> > >>>       if (IS_ERR_OR_NULL(priv->mm))
> > >>>               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > >>> +     priv->introspection = priv->mm == current->mm;
> > >>
> > >> Is the feat that the fd could be passed to someone else that would then not be
> > >> detected as introspection?
> > >
> > > Yes, exactly, that's the primary reason why I did it this way.
> >
> > Okay, would "opened_by_owner" or something like that be clearer? At least
> > "introspection" is less intuitive for me.
>
> Ack, I'll rename it to something like that for the next version.

I agree the naming is confusing.

OK so the whole thing is:

mem_open()
  -> __mem_open()
    -> proc_mem_open()
      -> mm_access()
        -> may_access_mm()

And:

static bool may_access_mm(struct mm_struct *mm, struct task_struct *task, unsigned int mode)
{
	if (mm == current->mm)
		return true;
	...
}

And what this flag is carrying is 'hey the reason we allowed the _open_ is
because it's looking at its own address space'.

I did wonder if what you're protecting against is even a process updating
execmem _it_ owns, no fd shared anywhere, as something LSM might want to
prevent even so?

The sharing a /proc/mem fd seems like that's a pretty dumb thing to do in
general :) but I guess you have to protect against that.

But TL;DR I agree with David on the naming, opened_by_owner is probably the
least-worst way of saying it very plainly and covers both cases.

--
Cheers, Lorenzo
