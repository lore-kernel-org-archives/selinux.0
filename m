Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98DHJWt018799
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 09:17:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h98DHE0p022892
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 13:17:14 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h98DHCr7022885
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 13:17:12 GMT
Subject: Re: [PATCH] Warnings and 64bit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <20031007213151.GG4359@hydra.joerghoh.de>
References: <20031004231832.GE3573@hydra.joerghoh.de>
	 <1065467759.3919.121.camel@moss-spartans.epoch.ncsc.mil>
	 <20031007213151.GG4359@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1065619026.8181.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 08 Oct 2003 09:17:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 17:31, Joerg Hoh wrote:
> _Why_ are there casts to void*. We haven't tracked the data flow through
> all the modules and functions, we only enabled all compiler warnings. And
> the gcc sent a warning while casting from int (32 bit) to void-Pointer (64
> bit).

I didn't view that as unsafe, as there is no possibility of truncation.
Did you actually test the existing checkpolicy to see if it worked, or
did you just assume that the warnings indicated an error?

define_cexpr() is called by the parser to build up the constraint
boolean expression.  The first argument is always an integer indicating
the expression type, but the remaining arguments may either be simple
integers (for a primitive) or pointers to sub-expressions (for a boolean
operator like AND, OR, or NOT).  So the remaining arguments are void*,
and the simple integers are cast to void* as appropriate.  We could make
the remaining arguments uintptr_t as in your patch, but we still
ultimately want to extract them back to 32 bit integers in
define_cexpr() when dealing with a primitive for storage in the
constraint_expr structure, so I don't see how that helps.  Changing the
fields in constraint_expr to uintptr_t as in your patch causes their
size to vary depending on the architecture, which means that we can't
use a single binary policy on both 32 bit and 64 bit machines.  

James, correct me if I'm wrong here, but this is my understanding.

So if passing 32 bit integers via a void* is considered harmful (which
I'm not convinced of), then the only clean solution would seem to be to
split define_cexpr into two functions with different interfaces, one
used for the primitives and one used for the boolean operator.

> > - The diffs to libselinux/src/*getfilecon.c introduces a bug.   Look
> > again to see how 'ret' and 'size' are being used.  On a failure to get
> > the attribute value due to the initial buffer being too small, the code
> > is querying the kernel for the actual size of the buffer, resizing the
> > buffer accordingly, and getting the attribute value into the resized
> > buffer.  Your change from 'size' to 'ret' breaks this logic; the
> > subsequent code will use the wrong value for size and will likely fail
> > again.
> 
> Ups, can you correct this?

I think that you just want to change the type of size to avoid your
warning, not replace it with ret.

> > - Changing the security class type changes the kernel API; the security
> > class is passed to the kernel via selinuxfs, so this requires changes
> > to libselinux and the kernel code.
> 
> Hm, why does this work an the alpha (with a slightly patched kernel 2.6)? I
> had to check this later. Perphaps this is due to the endianess of the alpha
> (little endian, I think), so some cast, alltough they should fail, work. I
> will try selinux on a z-series (little-endian).

You didn't send us any kernel patches, so I don't know what you did on
the kernel side.  But take a look at libselinux/src/compute_relabel.c as
one example and note that it snprintf's the security class with %hu as
the format to convey it to the kernel via selinuxfs, and that the kernel
selinuxfs code uses %hu to extract it.

> > - I'd think that ~0U would be preferable to (unsigned) -1.
> 
> Is bitwise negation of an unsigned int defined in the C Standard? I'm not
> sure.

I see plenty of uses of ~0U and ~0UL in the kernel sources.  I would
expect this to be more portable than (unsigned) -1, but I don't truly
know.

> > - The patch needs a small tweak to even compile on x86, and still yields
> > plenty of warnings.  However, the patched checkpolicy does yield an
> > identical binary policy file to the one produced by the unpatched
> > checkpolicy with the current example policy on x86, so that is good.
> 
> The warnings should be fixed :-) 

Yes, I don't intend to merge the patch until they are.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
