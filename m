Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97LVvWt015264
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 17:31:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h97LVv7d024856
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 21:31:57 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
        by jazzband.ncsc.mil  with ESMTP id h97LVuRn024852 for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 21:31:56 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by a141.shuttle.de (Postfix) with SMTP id 5926A170021
	for <selinux@tycho.nsa.gov>; Tue,  7 Oct 2003 23:41:21 +0200 (CEST)
Date: Tue, 7 Oct 2003 23:31:51 +0200
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Warnings and 64bit
Message-ID: <20031007213151.GG4359@hydra.joerghoh.de>
References: <20031004231832.GE3573@hydra.joerghoh.de> <1065467759.3919.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1065467759.3919.121.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 06, 2003 at 03:16:00PM -0400, Stephen Smalley wrote:

[I haven't the code here right now, so I try to answer from memory]

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

_Why_ are there casts to void*. We haven't tracked the data flow through
all the modules and functions, we only enabled all compiler warnings. And
the gcc sent a warning while casting from int (32 bit) to void-Pointer (64
bit).  

> - The diffs to libselinux/src/*getfilecon.c introduces a bug.   Look
> again to see how 'ret' and 'size' are being used.  On a failure to get
> the attribute value due to the initial buffer being too small, the code
> is querying the kernel for the actual size of the buffer, resizing the
> buffer accordingly, and getting the attribute value into the resized
> buffer.  Your change from 'size' to 'ret' breaks this logic; the
> subsequent code will use the wrong value for size and will likely fail
> again.

Ups, can you correct this?

> - Changing the security class type changes the kernel API; the security
> class is passed to the kernel via selinuxfs, so this requires changes
> to libselinux and the kernel code.

Hm, why does this work an the alpha (with a slightly patched kernel 2.6)? I
had to check this later. Perphaps this is due to the endianess of the alpha
(little endian, I think), so some cast, alltough they should fail, work. I
will try selinux on a z-series (little-endian).

> - I'd think that ~0U would be preferable to (unsigned) -1.

Is bitwise negation of an unsigned int defined in the C Standard? I'm not
sure.

> - The patch needs a small tweak to even compile on x86, and still yields
> plenty of warnings.  However, the patched checkpolicy does yield an
> identical binary policy file to the one produced by the unpatched
> checkpolicy with the current example policy on x86, so that is good.

The warnings should be fixed :-) 

Joerg


-- 
...Wenn man sich bei NetBSD auf eines verlassen kann, dann: Egal, WAS[...]
man updated, mplayer hat mit Sicherheit dependencies drauf.
  Rene Schickbauer, news:2591532.ZKZXAUW3eG@gandalf.grumpfzotz.org

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
