Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA09179
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 19:46:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA21669
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 23:45:47 GMT
Received: from relay.cigital.com (relay.cigital.com [64.80.176.5])
	by jazzband.ncsc.mil  with ESMTP id XAA21665
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 23:45:46 GMT
Message-ID: <4BC10D47D7ACD3119FA800104B1F8836C4AA6D@exchange.cigital.com>
From: Tim Hollebeek <thollebeek@cigital.com>
To: "'Justin R. Smith'" <jsmith@mcs.drexel.edu>, selinux@tycho.nsa.gov
Subject: RE: A notion
Date: Mon, 1 Oct 2001 19:46:10 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I don't know if Crispin Cowan watches the selinux list, but this is
exactly the sort of thinking that inspired stackguard.  To paraphrase
a recent comment of his, it seems that whenever you investigate a method
of enhancing security using randomization, similar thinking will provide a
protection mechanism which will perform even better than the randomization.

> -----Original Message-----
> From: Justin R. Smith [mailto:jsmith@mcs.drexel.edu]
> Sent: Tuesday, October 02, 2001 4:43 AM
> To: selinux@tycho.nsa.gov
> Subject: A notion
> 
> 
> It occurred to me that custom versions of software can be more secure
> than standard versions because various exploits (like stack smashing,
> etc.) require precise knowledge of certain sizes and distances in RAM
> (for instance, the distance from the end of a buffer to the return
> point...).
> 
> Isn't it possible to develop a "randomizing C compiler" that randomly
> varies these distances every time it compiles a program? No 
> two compiles
> of the same source code would be exactly the same (but they would
> execute the same way).
> 
> This might involve inserting small random-sized blocks of 
> dead code, or
> doing returns from subroutines through a level of indirection (i.e.,
> putting the actual return at some random location in the object code
> with a branch to it).
> 
> Done right, this might not degrade performance significantly.
> 
> 
> -- 
> 
> 
> --
> You have received this message because you are subscribed to 
> the selinux list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
