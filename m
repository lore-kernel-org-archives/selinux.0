Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0BF3C0623;
	Wed, 26 Aug 2026 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740023; cv=none; b=NZFoTx9EgHdtFLSiC+aPn9ftGmmUoM0uw/5XGv1NdjV+5wSAd77BDoF3oLLa0eqVgMI7E6dEKz5JAH8sZ7xl35zP3r/CPhP38X7zuiNfU+v4BYvVZz0igeHRfCPg91q38Gp3Q/R/B3/FiZmGUMS2ovPRnSGB7lwkkUvRKRCVtfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740023; c=relaxed/simple;
	bh=hcX0bXn0Fkv2WPOtX09uU++J+uNrLoPSk/jQ2JtQ89c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSSUdjUPbCh4O12lHk3/8CB4SG4Vt7fqsq5UpH8tkfNpzfdjhrOkbcbDYu7ocGbAisfgwwWynlP1vBGY9WZCnkXovngoIdpFPhgRwTkKzxtUABXxbBeb8lNW1YDrVjcv02SO+/ycM9Lf86L4egNrzw8oSZFT7MgW0eSNlZp6eNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNGEHSCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNGEHSCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332DB1F000E9;
	Wed, 26 Aug 2026 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740012;
	bh=+T9apJN+jyTN6a6IUkbzHwV2sRP7V+n7AL7iT54GeKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YNGEHSCOS9VijyeMWszSZJT8Fx0pJ+dSCcQUBKcEy73C3jvCS3Z+Sw5bRDsd88kaa
	 g5lymxlbgSUPpuQSmVrVyMSOYbGSbgY2ecQx3KFZ21BUnGCwu4BQY/XarUA8rpzIt7
	 fMYpYprfVeJUkzrKtykSh8FamU/JkWdYbV1XhsSjIBaWxURZJc9Av/4ZVkAoVDoGJc
	 SYGhhFo6mFdNki4p+xWxm9h43YILjEvd1V8Kp3SIrR8jsGaX5UrTYO3igvjhsVkwS8
	 UsxVaCvfQwreicdVqO/h8MzROS8YY1SrVCQmcCKdNRy1kJkwbfrMIDgXEUIKhF0ITc
	 TjANFOACnZ3gw==
Date: Wed, 26 Aug 2026 12:26:44 +0200
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
Message-ID: <20260826-allseits-winzig-hypochonder-1b36f3af087c@brauner>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
 <20260825-passt-semmel-primitiv-37712c04e6c6@brauner>
 <CAG48ez22J6tYZv6cG0TEoUFBrbhtWh6BHrZYBWuD-ee1hVr4ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez22J6tYZv6cG0TEoUFBrbhtWh6BHrZYBWuD-ee1hVr4ZA@mail.gmail.com>

On Tue, Aug 25, 2026 at 03:46:50PM +0200, Jann Horn wrote:
> On Tue, Aug 25, 2026 at 3:13 PM Christian Brauner <brauner@kernel.org> wrote:
> > On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
> > > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently have no
> > > good opportunity to block a process from overwriting read-only code in its
> > > own address space through FOLL_FORCE writes via /proc/self/mem.
> > > The security_ptrace_access_check() LSM hook is bypassed when a process
> > > opens /proc/self/mem because this is considered "introspection".
> >
> > Useful. I ran into this issue just yesterday in:
> >
> > https://github.com/systemd/systemd/pull/43511
> >
> > Btw, it's kinda annoying that PTRACE_POKE{TEXT,DATA} still allows foll
> > force writes even if PROC_MEM_FORCE_NEVER is enabled. So ideally there'd
> > also be a hook for that option.
> 
> You need either /proc/$pid/mem or PTRACE_POKETEXT for installing
> software breakpoints. I think if you want to completely block

This won't be enabled for general-purpose systems. But for a lot of
other systems with a lot stricter requirements this is very useful. And
you can always allow a mode where you intentionally degrade to an
audited "debug" mode where you can turn of the restrictions. Which btw,
isn't possible with seccomp.

> FOLL_FORCE through ptrace, you're probably in a scenario where ptrace
> should either be blocked completely, or at least restricted to
> mostly-read-only operations?

Yes but the list of ptrace() options is prctl()-like. They even have
interactions. Also seccomp isn't necessarily the right tool for this
because it doesn't allow dynamic policies. That would be lsm territory.

> 
> > The other thing - though not directly FOLL_FORCE related - is that
> > process_vm_writev() isn't subject to any security restrictions other
> > than seccomp filtering either.
> 
> It does go through mm_access() and ptrace_may_access() unless the
> access is same-MM, so it can be blocked by LSMs like Yama.

I think ptrace_may_access() is way to coarse to be really useful. It's a
very frustrating tool. It's easy to use because everyone knows "you need
to access properties of another task, ptrace_may_access() is your guy".
But it prevents better policies. TL;DR you never know _why_ you were
called specifically.
