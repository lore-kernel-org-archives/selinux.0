Subject: Re: port of procps patch to acahalan procps
From: Colin Walters <walters@verbum.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1057805552.751.1243.camel@cube>
References: <1057776906.28674.262.camel@columbia>
	 <1057805552.751.1243.camel@cube>
Content-Type: text/plain
Message-Id: <1057950856.1327.90.camel@columbia>
Mime-Version: 1.0
Date: 11 Jul 2003 15:14:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-07-09 at 22:52, Albert Cahalan wrote:

> OK. I'll get most of that into the 3.1.10 release.

Cool.  Note however that it won't currently run on 2.4 SELinux, so you
should probably warn your users about this.

> I need to know more about a security context.
> I need to know how big it is today (variable?)
> and how, if at all, you intend to keep the size
> from ever changing. I'm working toward a stable
> ABI for procps, meaning that compile-time choices
> can't make the library incompatible with the apps.

It's basically just a char *, and I don't think that will ever change.

> +#ifdef WITH_SELINUX
> +    int selinux_enabled = is_selinux_enabled();
> +#endif
> 
> Is that going to be slow? You're making this call
> for every process.

It shouldn't be too slow, no; basically it is implemented by reading
/proc/self/attr/current and seeing if it works.  But it would be a good
idea to factor the code out into an initialization section.

> -    if (!p)
> +    if (!p) {
>         p = xcalloc(p, sizeof *p); /* passed buf or alloced mem */
> +       memset(p, 0, sizeof(p));
> +    }
> 
> Why? I notice elsewhere that you seem to expect
> readproc() to get called with a security context
> already allocated. Hmmm...

The reason I did this was because the patch for the other procps does:
	if (p->scontext) {
	    freecon(p->scontext);
	    p->scontext=NULL;
	}

But this might be something that was only needed for the other procps. 
It does look like when readproc is called, the proc_t * is always
freshly allocated, and is later freed with freeproc, which will
correctly free the context.  So you could probably just delete both the
freecon code and the memset code in readproc.

> +#ifdef WITH_SELINUX
> +#define PROC_CONTEXT 0x8000 
> +#endif
> 
> no need to #ifdef that

Ok.

> 
> -  memset(&buf, '#', sizeof(proc_t));
> +  memset(&buf, 0, sizeof(proc_t));
> 
> This is debug code. It's used to help catch
> uninitialized memory. (did it catch you?)

Yes, because of the above code that checked whether p->scontext was
nonzero, and freed it if not.

This is unrelated to the SELinux patch, but: I personally find valgrind
to be a far more effective way to debug memory allocation errors.  Also,
I think it would be better to memset it to 0 in released code, but have
a debugging mode which uses '#'.  This is a kind of defensive
programming; if a bug could be avoided by memsetting a buffer to 0, then
it's not really even a bug in the first place in my opinion.  You don't
want procps to segfault on the user's computer just because they hit a
strange codepath.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
