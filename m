Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97JT8Wt014244
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:29:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h97JT50p000966
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 19:29:05 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by jazzswing.ncsc.mil  with ESMTP id h97JT3r7000957
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 19:29:04 GMT
Date: Tue, 7 Oct 2003 21:29:03 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Joerg Hoh <joerg@devone.org>, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] Warnings and 64bit
Message-ID: <20031007192903.GA22645@suse.de>
References: <20031004231832.GE3573@hydra.joerghoh.de> <1065467759.3919.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1065467759.3919.121.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 06, Stephen Smalley wrote:

> On Sat, 2003-10-04 at 19:18, Joerg Hoh wrote:
> > We've managed to run SELinux on an alpha (Kernel 2.6.0test6). Before that 
> > we've done lot of patching (the policy compiler was really messy).
> > 
> > Most patches are concerning type conversions (a lot of int -> size_t 
> > conversion) and invalid comparisons of int (4 byte) and long (8 byte 
> > on alpha). We also patched the Makefiles, so all files are build with
> > "-Wall -W -Werror" (most files compile now without warnings, except
> > for the lexx generated ones):also all utils can built in the source tree.
> > 
> > The probably most intrusive part:
> > 
> > -typedef unsigned int access_vector_t;
> > -typedef unsigned short security_class_t;
> > +typedef uint32_t access_vector_t;
> > +typedef uint32_t security_class_t;
> > 
> > We made security_class_t 32bit. There is probably a problem with 16 Bit
> > parameters on alpha, I will check this and report here.
> > 
> > The patch is against the latest cvs-version on sourceforge.
> 
> Thanks for your patch.  A few questions and observations about it (after
> just a moment of looking at it, so no thorough analysis yet) are below:
> 
> - Can you explain some of your changes from integer types to uintptr_t,
> even when a pointer is not stored in the field?  The changes to
> constraint.h are surprising to me, as is the change to the %union in
> policy_parse.y.  Likewise for define_*_context; why make these use
> uintptr_t when the %type declaration specifies <val>?  The whole point
> of the %union and %type declarations is to correctly handle returning
> integers or pointers as appropriate in a safe manner.  I'm not sure why
> your changes are necessary there.  There is some casting to void* and
> back again for integers across define_cexpr(), but note that we are not
> passing pointers as integer parameters, returning them via integer
> return codes, or storing them in integer fields, so there shouldn't be
> any pointer truncation occurring.

Maybe in theory, but in practice you will get a lot of compiler
warnings on 64it archs like AMD64:

policy_parse.y: In function `define_cexpr':
policy_parse.y:2644: warning: cast from pointer to integer of different size
policy_parse.y:2645: warning: cast from pointer to integer of different size
policy_parse.y:2648: warning: cast from pointer to integer of different size
policy_parse.y:2649: warning: cast from pointer to integer of different size

while it may be the case, that in this case we know that nothing can
happen, in 95% of all cases where I saw this warnings the code was
really broken and needs to be fixed.

So we should make sure that we don't get this warnings, they show
there can be something go wrong.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
