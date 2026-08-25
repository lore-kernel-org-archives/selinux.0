Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8A42589C;
	Tue, 25 Aug 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667877; cv=none; b=mo7fjPJM2AjOFKxx1YXnlVM2YdkCC53qlPYR3glb6/NxS9Jqf67l5mCi58mb/d0g4LiMiMEwL+jFH/6A2xuaqsJiYXXGeY5m4327nrtObPQVt91lJOG8Cm972CnkjUfO4wzEnrhFAhge6YhLJPoF1lOwac8Lhzuq/HGtYuShqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667877; c=relaxed/simple;
	bh=qjHXTa0s8zvN8eWbsgZQbbsnAvUJrCviQOkjU8WoR6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz6FTkHOYhRzomhxW/JH+DYlB72QPRhyPRo5mm26aoBcHVnZdXybK8FTAOU43pQJ+3n16miY53+68QHDFMKbdHQV1523BsrSLW9fxzRx00NsKi1BA5tXXiJtycgWtiHDlC6H2NLO9IWL+WnbubFrxDI4rlIXxbExATlrlTFITFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSJuJPMk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSJuJPMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C5F1F000E9;
	Tue, 25 Aug 2026 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787667875;
	bh=qjHXTa0s8zvN8eWbsgZQbbsnAvUJrCviQOkjU8WoR6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cSJuJPMkWhZS4E2xMS/50Ko0vEa6gX59SNuYWUKf/rZlhN6uiK7pfq4bT2DZWA5gO
	 RDAgnPa4GZV0irpj8/69hCLcQUcqKtnbqd497v4e7hcPVE7SXltC4RIBI9AumZbfrQ
	 EYlEDD//W1f2zayHjmjmDYXqqmlpdJi8ND3upHF+CJNXYJ47dZATgpllmSFLIeugxc
	 oOg+IaNv+SPZc+7MJmp0l58vCg79Ncp0EFwjUAF2kGmA8VqcHXLKouMrhv6/IpEinf
	 fKdWXnPqsVh6HCggLLWZfYIk+dUmUX5fQ/ppQfjCW80/9CsduRnztcPGU/3mKUQXTE
	 Jrfk2DhjJ3qHA==
Date: Tue, 25 Aug 2026 15:24:28 +0100
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
Message-ID: <ao2jfUGzbtlW0LBI@gremlin>
References: <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org>
 <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin>
 <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
 <aox7tVIQBMuz-xFO@gremlin>
 <CAG48ez2-8UjzOp=St5eTPyG_yd2iBmPF6y7qVBTNaPNJgoX=BA@mail.gmail.com>
 <ao2a33Xf3U0kQmM_@gremlin>
 <CAG48ez00PjoaXt4xJn1DCNdZfmFn4faya++=U2EeW0_vcYXcqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez00PjoaXt4xJn1DCNdZfmFn4faya++=U2EeW0_vcYXcqg@mail.gmail.com>

On Tue, Aug 25, 2026 at 04:08:42PM +0200, Jann Horn wrote:
> On Tue, Aug 25, 2026 at 3:42 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > On Mon, Aug 24, 2026 at 07:43:02PM +0200, Jann Horn wrote:
> > > On Mon, Aug 24, 2026 at 7:33 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > > > On Mon, Aug 24, 2026 at 07:06:04PM +0200, Jann Horn wrote:
> > > > > On Fri, Aug 21, 2026 at 8:52 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > > > > > The sharing a /proc/mem fd seems like that's a pretty dumb thing to do in
> > > > > > general :) but I guess you have to protect against that.
> > > > >
> > > > > Yeah, it's a kinda weird thing to do...
> > > >
> > > > Yup :)) but I guess we have to account for people doing weird stuff...
> > > >
> > > > In this case (I do mention it in a reply elsewhere I think) it does seem
> > > > like perhaps you should separately check for current->mm != mm of (what was
> > > > originally /proc/self/mm)?
> > >
> > > I wouldn't want to do it for this access check, since that could lead
> > > to "confused deputy" problems.
> >
> > I guess if it got the decision wrong somehow that'd be a problem? Or wrongly
> > OK'd it on one level but then that led to the fd being passed on assumption it
> > was OK to do it or something?
>
> The problematic scenario would be something like:
>
> 1. process A opens fd1=open("/proc/self/mem",O_RDWR)
> 2. process A does lseek(fd1, <address of libc>, SEEK_SET)
> 3. A sends fd1 to privileged daemon B as a "log output" FD
> 4. privileged daemon B write()s into fd1
>
> In this scenario, daemon B is just trying to write log output into a
> file descriptor. If we checked the current credentials on write(), we
> might enable FOLL_FORCE just because daemon B is generally permitted
> to use ptrace.
>
> This illustrates why, in general, the "ambient privilege" that a
> process has must not influence write() access decisions.

Ahh. That makes sense.

But I mean in this case the check would be that the mm is the one belonging to
the process in question so wouldn't you need in the first place to have obtained
a privileged mm anyway?

If the check is literally mm of /proc/$pid/mem == current->mm?

And wouldn't prilileged process -> fd to /proc/$pid/mem -> less privileged
process be a fail in itself?

>
> For a similar historical example, see
> https://project-zero.issues.chromium.org/issues/42450869 where we used
> to do capability checks in the old expand_downwards() logic, which
> could be reached by writing into /proc/$pid/mem. That made it possible
> for an unprivileged process to map virtual address 0 by providing
> /proc/$pid/mem as stderr to a setuid root binary.

This does raise questions about /proc/$pid/mm as a whole but I guess that ship
sailed long ago...

--
Cheers, Lorenzo
