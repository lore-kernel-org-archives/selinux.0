Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h96JG8Wt007404
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 15:16:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h96JG70p004032
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 19:16:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h96JG6r7004029
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 19:16:07 GMT
Subject: Re: [PATCH] Warnings and 64bit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <20031004231832.GE3573@hydra.joerghoh.de>
References: <20031004231832.GE3573@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1065467759.3919.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 06 Oct 2003 15:16:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-10-04 at 19:18, Joerg Hoh wrote:
> We've managed to run SELinux on an alpha (Kernel 2.6.0test6). Before that 
> we've done lot of patching (the policy compiler was really messy).
> 
> Most patches are concerning type conversions (a lot of int -> size_t 
> conversion) and invalid comparisons of int (4 byte) and long (8 byte 
> on alpha). We also patched the Makefiles, so all files are build with
> "-Wall -W -Werror" (most files compile now without warnings, except
> for the lexx generated ones):also all utils can built in the source tree.
> 
> The probably most intrusive part:
> 
> -typedef unsigned int access_vector_t;
> -typedef unsigned short security_class_t;
> +typedef uint32_t access_vector_t;
> +typedef uint32_t security_class_t;
> 
> We made security_class_t 32bit. There is probably a problem with 16 Bit
> parameters on alpha, I will check this and report here.
> 
> The patch is against the latest cvs-version on sourceforge.

Thanks for your patch.  A few questions and observations about it (after
just a moment of looking at it, so no thorough analysis yet) are below:

- Can you explain some of your changes from integer types to uintptr_t,
even when a pointer is not stored in the field?  The changes to
constraint.h are surprising to me, as is the change to the %union in
policy_parse.y.  Likewise for define_*_context; why make these use
uintptr_t when the %type declaration specifies <val>?  The whole point
of the %union and %type declarations is to correctly handle returning
integers or pointers as appropriate in a safe manner.  I'm not sure why
your changes are necessary there.  There is some casting to void* and
back again for integers across define_cexpr(), but note that we are not
passing pointers as integer parameters, returning them via integer
return codes, or storing them in integer fields, so there shouldn't be
any pointer truncation occurring.

- The diffs to libselinux/src/*getfilecon.c introduces a bug.   Look
again to see how 'ret' and 'size' are being used.  On a failure to get
the attribute value due to the initial buffer being too small, the code
is querying the kernel for the actual size of the buffer, resizing the
buffer accordingly, and getting the attribute value into the resized
buffer.  Your change from 'size' to 'ret' breaks this logic; the
subsequent code will use the wrong value for size and will likely fail
again.

- Changing the security class type changes the kernel API; the security
class is passed to the kernel via selinuxfs, so this requires changes
to libselinux and the kernel code.

- I'd think that ~0U would be preferable to (unsigned) -1.

- The patch needs a small tweak to even compile on x86, and still yields
plenty of warnings.  However, the patched checkpolicy does yield an
identical binary policy file to the one produced by the unpatched
checkpolicy with the current example policy on x86, so that is good.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
