Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LKoLWt000132
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 16:50:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LKoKIE019517
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 20:50:20 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
        by jazzband.ncsc.mil  with ESMTP id h9LKoJ1J019513 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 20:50:19 GMT
Date: Tue, 21 Oct 2003 22:50:52 +0200
From: Joerg Hoh <joerg@devone.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: [Patch] checkpolicy (3)
Message-ID: <20031021205052.GC3638@hydra.joerghoh.de>
References: <20031020212056.GF3579@hydra.joerghoh.de> <1066738297.27065.9.camel@moss-spartans.epoch.ncsc.mil> <20031021154814.GA3638@hydra.joerghoh.de> <1066762919.27065.207.camel@moss-spartans.epoch.ncsc.mil> <20031021195947.GB3638@hydra.joerghoh.de> <1066767195.27065.227.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066767195.27065.227.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 21, 2003 at 04:13:15PM -0400, Stephen Smalley wrote:
> On Tue, 2003-10-21 at 15:59, Joerg Hoh wrote:
> > The gcc on my alpha produces warnings, so there is no implicit conversion.
> > We should make it explicit. 
> 
> What is the warning?  And what warning flags are you using?
> 
>Warnings are not errors.

For better checking we temporarily enabled -Wconversion:

write.c: In function `class_write':
write.c:405: warning: passing arg 3 of `fwrite' with different width due to prototype
write.c:409: warning: passing arg 2 of `fwrite' with different width due to prototype
write.c:409: warning: passing arg 3 of `fwrite' with different width due to prototype
write.c:414: warning: passing arg 2 of `fwrite' with different width due to prototype
write.c:414: warning: passing arg 3 of `fwrite' with different width due to prototype
write.c:428: warning: passing arg 3 of `fwrite' with different width due to prototype
write.c:436: warning: passing arg 3 of `fwrite' with different width due to prototype
(and many more warnings)

These switch isn't enabled with -Wall.

(from the manpage:)
-Wconversion
   Warn if a prototype causes a type conversion that is different from what would happen to the same argument in
   the absence of a prototype.  This includes conversions of fixed point to floating and vice versa, and conver-
   sions changing the width or signedness of a fixed point argument except when the same as the default promo-
   tion.
 
   Also, warn if a negative integer constant expression is implicitly converted to an unsigned type.  For exam-
   ple, warn about the assignment "x = -1" if "x" is unsigned.  But do not warn about explicit casts like
   "(unsigned) -1".

The compiler itself does the this automatic cast (and only warns about
that); yeah, we may exclude this patch.

Joerg


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
