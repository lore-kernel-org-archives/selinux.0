Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98HYGWt020940
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 13:34:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h98HYF6g005149
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 17:34:15 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
        by jazzband.ncsc.mil  with ESMTP id h98HY8dq005146 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 17:34:14 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by a141.shuttle.de (Postfix) with SMTP id 1B7B5170021
	for <selinux@tycho.nsa.gov>; Wed,  8 Oct 2003 19:44:00 +0200 (CEST)
Date: Wed, 8 Oct 2003 19:34:16 +0200
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Warnings and 64bit
Message-ID: <20031008173416.GB3537@hydra.joerghoh.de>
References: <20031004231832.GE3573@hydra.joerghoh.de> <1065467759.3919.121.camel@moss-spartans.epoch.ncsc.mil> <20031007213151.GG4359@hydra.joerghoh.de> <1065619026.8181.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1065619026.8181.83.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 08, 2003 at 09:17:06AM -0400, Stephen Smalley wrote:
> On Tue, 2003-10-07 at 17:31, Joerg Hoh wrote:
> > _Why_ are there casts to void*. We haven't tracked the data flow through
> > all the modules and functions, we only enabled all compiler warnings. And
> > the gcc sent a warning while casting from int (32 bit) to void-Pointer (64
> > bit).
> 
> I didn't view that as unsafe, as there is no possibility of truncation.

Hm, let my explain.

IMHO it isn't defined how a cast between a 32bit and 64bit value behaves.
Are the 32bit moved into the lower 32bit of that 64bit or into the higher
ones? And the second problem is the different endianess on different
machines. So the (physical) lower 32 bit can be the higher ones if you
consider the value of that number. And the cast vice versa also isn't clearly 
defined. 

Sure, if you want that
void* only as a transfer parameter (first store your int there and in
another function retrieve a int from that parameter) most time you won't
encounter any problem. But this isn't good software, as I expect in a void*
parameter (to be honest: I don't want to use any void* pointer, since that
shows me, that the author doesn't know, what data he's passing. Yes, in C
you can do all this a lot of ugly stuff more, but I learned programming
with Ada; there you cannot do such things, and that's imho really good) a
pointer and no integer, which I had to cast to use it properly.

That's the cause for changing so many parameters.


> Did you actually test the existing checkpolicy to see if it worked, or
> did you just assume that the warnings indicated an error?

These warnings soon becomes errors if you go off your 32bit plattform. The
unpatched policy loader simply crashed because of such errors.

> define_cexpr() is called by the parser to build up the constraint
> boolean expression.  The first argument is always an integer indicating
> the expression type, but the remaining arguments may either be simple
> integers (for a primitive) or pointers to sub-expressions (for a boolean
> operator like AND, OR, or NOT).  So the remaining arguments are void*,
> and the simple integers are cast to void* as appropriate.  We could make
> the remaining arguments uintptr_t as in your patch, but we still
> ultimately want to extract them back to 32 bit integers in
> define_cexpr() when dealing with a primitive for storage in the
> constraint_expr structure, so I don't see how that helps.  Changing the
> fields in constraint_expr to uintptr_t as in your patch causes their
> size to vary depending on the architecture, which means that we can't
> use a single binary policy on both 32 bit and 64 bit machines.  

That's true. But you've only done this for simplicity. Why don't you store
every argument in that sub-expression structure, even it's a simple
expression (like true or false)? I see here a very small speed and space
penalty, but I think, I can live with that.


> > > to libselinux and the kernel code.
> > 
> > Hm, why does this work an the alpha (with a slightly patched kernel 2.6)? I
> > had to check this later. Perphaps this is due to the endianess of the alpha
> > (little endian, I think), so some cast, alltough they should fail, work. I
> > will try selinux on a z-series (little-endian).
> 
> You didn't send us any kernel patches, so I don't know what you did on
> the kernel side.  But take a look at libselinux/src/compute_relabel.c as
> one example and note that it snprintf's the security class with %hu as
> the format to convey it to the kernel via selinuxfs, and that the kernel
> selinuxfs code uses %hu to extract it.

The only patch was a small patch which made the kernel compile properly. No
patch on the side of selinux.

Joerg

-- 
...Wenn man sich bei NetBSD auf eines verlassen kann, dann: Egal, WAS[...]
man updated, mplayer hat mit Sicherheit dependencies drauf.
  Rene Schickbauer, news:2591532.ZKZXAUW3eG@gandalf.grumpfzotz.org

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
