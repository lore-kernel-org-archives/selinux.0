Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA09826
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 23:21:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA28992
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 03:21:01 GMT
Received: from mail.windowpane.com (ip57.gte1.rb1.bel.nwlink.com [209.20.131.57])
	by jazzband.ncsc.mil  with ESMTP id DAA28988
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 03:20:59 GMT
Received: from ip57.gte1.rb1.bel.nwlink.com (ip57.gte1.rb1.bel.nwlink.com [209.20.131.57])
	by mail.windowpane.com (Postfix) with ESMTP id 893DA804F
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2001 19:40:26 -0700 (PDT)
Date: Mon, 1 Oct 2001 19:40:26 -0700 (PDT)
From: Conan Callen <ccallen@windowpane.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: A notion
In-Reply-To: <007301c14ad4$f2188560$36a3533e@s5u0t0>
Message-ID: <Pine.LNX.4.33.0110011931000.15881-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Oct 2001, Javier wrote:

I was wondering about the possiblity of moving the return addresses out of
the stack completely (even hashed & check summed so that its not a simple
matter of just writing a new return address over the existing one).
Im not a complier or assembler writer, but it seems that this should
be possible. Of course, as soon as it was made public exploits could be
immediatly developed.

> For exploit buffer overflow you needn't know the distances you say, it helps
> but it's not essential. Once you know (or suspect) the program is weak you
> can try with differet sizes till you get the good one. If you want keep
> yourself safe from this kind of exploiting, make sure that you control
> buffer sizes. It is a simple and efficient method.
>
> PD: Excuse my english but it is not my parent tongue.
>
> ----- Original Message -----
> From: "Justin R. Smith" <jsmith@mcs.drexel.edu>
> To: <selinux@tycho.nsa.gov>
> Sent: Tuesday, October 02, 2001 10:42 AM
> Subject: A notion
>
>
> > It occurred to me that custom versions of software can be more secure
> > than standard versions because various exploits (like stack smashing,
> > etc.) require precise knowledge of certain sizes and distances in RAM
> > (for instance, the distance from the end of a buffer to the return
> > point...).
> >
> > Isn't it possible to develop a "randomizing C compiler" that randomly
> > varies these distances every time it compiles a program? No two compiles
> > of the same source code would be exactly the same (but they would
> > execute the same way).
> >
> > This might involve inserting small random-sized blocks of dead code, or
> > doing returns from subroutines through a level of indirection (i.e.,
> > putting the actual return at some random location in the object code
> > with a branch to it).
> >
> > Done right, this might not degrade performance significantly.
> >
> >
> > --
> >
> >
> > --
> > You have received this message because you are subscribed to the selinux
> list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> > the words "unsubscribe selinux" without quotes as the message.
>
>
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
