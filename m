Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAD3FF1A9;
	Tue, 25 Aug 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666586; cv=none; b=abmjBzGdZu4IJ9cJj8yLcLOsFzQpH/PYHTH8EIfyJUFqps55IU6ARGc7WyA+UD7krW/Dh1Kct2OeVhUoooe/cXs0OMTfCDK7zSogehM34l2m37BuyaMfcO6ApBS6pWQgzjv59E/qcAQuh/xAj5bnLd3pu2ovfY2JpTqaEv0jdic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666586; c=relaxed/simple;
	bh=OYfjDIKe6jN+TIxjMbu/Xu2hZCdsjjIn2TXHLHGljlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrr5k05s0rXcD7KYuAcj4a4DpRwsridHcn95cZcCluEpbDo12kDkjFhdjSKCaADKLnxwy0JNKX8vrkAXDQEXOj0NHNJxFARIwO9PgI87joyODFXyHVervoI8YNqPGcxWLFALCv1kLVzRBskcKu+Y5PnnwupIAnWeHDSTdXsPunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7veB8l2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7veB8l2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20AF1F000E9;
	Tue, 25 Aug 2026 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787666584;
	bh=T32td7y5ccdnhZesB3Pf8GJA69ToD/C95AdlirXQkOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h7veB8l2u74wR/f36KIFQZSKVtGKq+qmae6kMloaQFEc/ao1ue4iTX/6IJbhtJcy4
	 0snjrsBT3sbND7D++wQlUx8vx5FUwua8SYx9Q1ad0PfZAS3at5Jk6BEtvXG403jgpV
	 lhnQ2fTG+jNRM6oyw8O5UM3GTaxsclZjpPOqcjSVCvg70tbK8yUPjDD7cg8sSjP7Dc
	 Ld28Mn87ZSdFL8iEHOYTFNcti3FSy0slLpAZOpC8RIRaTQdG51gVvpy+SJ0X7vE9YE
	 gO991L1ntARaAvWczPLf+mbv32ln2bNQcbPoFrChaUM1xaKUr47Mm8lHFvvqT7NvqE
	 0OLUod+yYUvQg==
Date: Tue, 25 Aug 2026 15:02:57 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Message-ID: <ao2gZQuyfegmotS8@gremlin>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
 <aoifijlkCRzeO4bj@gremlin>
 <CAG48ez1HA30JUi-R=6KydkQy2P3_ineM1ZzRMQC6QP1UAwjewg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1HA30JUi-R=6KydkQy2P3_ineM1ZzRMQC6QP1UAwjewg@mail.gmail.com>

On Mon, Aug 24, 2026 at 07:28:24PM +0200, Jann Horn wrote:
> On Fri, Aug 21, 2026 at 9:00 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
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
>
> > > @@ -886,6 +890,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
> > >               }
> > >               return ptrace_active;
> > >       default:
> > > +             if (priv->introspection)
> > > +                     return security_introspect_mem_foll_force(file->f_cred) == 0;
> >
> > As per 3/3 I wonder if you need an additional parameter to cover the fd -> some
> > other process case?
> >
> > Like:
> >         if (priv->owned_by_owner) {
> >                 const bool is_remote = current->mm != priv->mm;
> >
> >                 return !security_fd_from_owner_mem_foll_force(file->f_cred,
> >                                 is_remote);
> >         }
> >
> > (I'm not sure how LSM hooks are supposed to look :)
>
> We could do that if we wanted to treat cases differently based on the
> identity of the writer, but I think in general that's not a good idea.
>
> In general, if you send an FD to some daemon, and the daemon writes
> into the FD, this should not cause access control decisions based on
> the identity of the daemon, because it can cause "confused deputy"
> bugs - the daemon might think it is just writing log output into a
> normal file, or something like that.

Ack yup, variations of a theme of this, I think I was overly confused by
the fd-passing stuff vs. the key reason for the series.

In general the thing LGTM other than the naming so a respin should be good!

>
> > > diff --git a/security/security.c b/security/security.c
> > > index 71aea8fdf014..d0f790a534eb 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -595,6 +595,21 @@ int security_ptrace_traceme(struct task_struct *parent)
> > >       return call_int_hook(ptrace_traceme, parent);
> > >  }
> > >
> > > +/**
> > > + * security_introspect_mem_foll_force() - Check if introspective FOLL_FORCE is allowed
> > > + * @subject: credentials of the process accessing its own memory
> > > + *
> > > + * Check if FOLL_FORCE is allowed for a process accessing its own memory, which
> > > + * bypasses the security_ptrace_access_check() hook.
> >
> > This should be updated to also explicitly mention the fd case. As surely in that
> > case this is not true? Unless I'm missing something.
>
> Yeah, I'll clarify this comment.

--
Cheers, Lorenzo
