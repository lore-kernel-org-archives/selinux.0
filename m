Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB5331EB9;
	Wed, 26 Aug 2026 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749536; cv=none; b=rf6XjvjqdwAyKEmMoH6xxkcHJHyA6pXDl5lWDPqQp5kWdF9nop8Zlga4aNgHBC4GyqlwgXU+6nj9nzK+LgQjPhCBkZp75mCI6uMpLTWkVUeykfYTii4LU42XFPWwjaRiw3eldNnP5i9WCFcfUufYUyE05MUkja6dDmOyKb/Jgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749536; c=relaxed/simple;
	bh=D+jsu0lhi78E5xkQq8F1dBDw1lbQTSSd9M9Up6CaIOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyoJ9R6rFDV6SKrqByaUVGj+LLR6jhd6F8j74Zl0BG2VD11wQyl5/SGbc5dPLTJ9dYAiKJsdn8RTb9KSxYQP5yKeHALoaAlj6m7GrpQAjyOvQowd+gPzwczbxuJ7A6CbkbstCZHN1tEJ4BEpRe2j5o+D92ZParp4/0+UAX23rK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq552cgH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq552cgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F211F000E9;
	Wed, 26 Aug 2026 13:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787749534;
	bh=D+jsu0lhi78E5xkQq8F1dBDw1lbQTSSd9M9Up6CaIOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zq552cgH/fW64rLpHxyP+jZPyvi68lU3UPRiKW3vizebFmpkYA0+o6/BdYm8hZQnc
	 Mcaj5S+qf0xpv+1mXLhFgSbHAZLCNmlfSHz5gGmHZdlnU6e4vnupk1WZZXQIGJ3jYC
	 aPQSRfNK8CFXoHkrZusouFLfgyU0cKd4yL0kc0De+eCBzYKbZ0qz5izyW9sq9XGc01
	 rlfZgCjshr299waJ+mL0SkyS8Lx3aHJuQG9p73ee1k9CTnRqP3GU1DL3bT5HWXKD1h
	 tbNxqCZnGYQUP0JRCGf6XO8XSvFWQmVkz6swit/PDeCQJT2/cqL7v/Ln8PzkKyIM86
	 3UFVDpL4IchqA==
Date: Wed, 26 Aug 2026 14:05:27 +0100
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
Message-ID: <ao7khhTMwYEGLAXC@gremlin>
References: <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org>
 <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin>
 <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
 <aox7tVIQBMuz-xFO@gremlin>
 <CAG48ez2-8UjzOp=St5eTPyG_yd2iBmPF6y7qVBTNaPNJgoX=BA@mail.gmail.com>
 <ao2a33Xf3U0kQmM_@gremlin>
 <CAG48ez00PjoaXt4xJn1DCNdZfmFn4faya++=U2EeW0_vcYXcqg@mail.gmail.com>
 <ao2jfUGzbtlW0LBI@gremlin>
 <CAG48ez1ttTOf6wobCpRK+upYJqU82jgmxGSX_e7xWuxU7xYoYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1ttTOf6wobCpRK+upYJqU82jgmxGSX_e7xWuxU7xYoYg@mail.gmail.com>

On Tue, Aug 25, 2026 at 05:00:59PM +0200, Jann Horn wrote:
> On Tue, Aug 25, 2026 at 4:24 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > On Tue, Aug 25, 2026 at 04:08:42PM +0200, Jann Horn wrote:
> > > On Tue, Aug 25, 2026 at 3:42 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > > > On Mon, Aug 24, 2026 at 07:43:02PM +0200, Jann Horn wrote:
> > > > > On Mon, Aug 24, 2026 at 7:33 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > > > > > On Mon, Aug 24, 2026 at 07:06:04PM +0200, Jann Horn wrote:
> > > > > > > On Fri, Aug 21, 2026 at 8:52 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > > > > > > > The sharing a /proc/mem fd seems like that's a pretty dumb thing to do in
> > > > > > > > general :) but I guess you have to protect against that.
> > > > > > >
> > > > > > > Yeah, it's a kinda weird thing to do...
> > > > > >
> > > > > > Yup :)) but I guess we have to account for people doing weird stuff...
> > > > > >
> > > > > > In this case (I do mention it in a reply elsewhere I think) it does seem
> > > > > > like perhaps you should separately check for current->mm != mm of (what was
> > > > > > originally /proc/self/mm)?
> > > > >
> > > > > I wouldn't want to do it for this access check, since that could lead
> > > > > to "confused deputy" problems.
> > > >
> > > > I guess if it got the decision wrong somehow that'd be a problem? Or wrongly
> > > > OK'd it on one level but then that led to the fd being passed on assumption it
> > > > was OK to do it or something?
> > >
> > > The problematic scenario would be something like:
> > >
> > > 1. process A opens fd1=open("/proc/self/mem",O_RDWR)
> > > 2. process A does lseek(fd1, <address of libc>, SEEK_SET)
> > > 3. A sends fd1 to privileged daemon B as a "log output" FD
> > > 4. privileged daemon B write()s into fd1
> > >
> > > In this scenario, daemon B is just trying to write log output into a
> > > file descriptor. If we checked the current credentials on write(), we
> > > might enable FOLL_FORCE just because daemon B is generally permitted
> > > to use ptrace.
> > >
> > > This illustrates why, in general, the "ambient privilege" that a
> > > process has must not influence write() access decisions.
> >
> > Ahh. That makes sense.
> >
> > But I mean in this case the check would be that the mm is the one belonging to
> > the process in question so wouldn't you need in the first place to have obtained
> > a privileged mm anyway?
> >
> > If the check is literally mm of /proc/$pid/mem == current->mm?
>
> Ah, right, true.
>
> Still, I think I want to generally avoid looking at the current
> process in write(). If I did add such a check, and the check failed,
> I'm also not sure what I'd do with this information.

True it's not a blocker!

>
> > And wouldn't prilileged process -> fd to /proc/$pid/mem -> less privileged
> > process be a fail in itself?
>
> Yes, true.

Yeah just food for thought I guess :)


--
Cheers, Lorenzo
