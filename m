Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA09196
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 19:48:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA21860
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 23:48:21 GMT
Received: from taxismtp2.alchemyfx.com (taxismtp2.alchemy.net [209.132.220.152])
	by jazzband.ncsc.mil  with ESMTP id XAA21856
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 23:48:20 GMT
Received: from s5u0t0 (54-MAD2-X72.libre.retevision.es [62.83.163.54])
	by taxismtp2.alchemyfx.com (8.9.3/8.9.3) with SMTP id QAA28311
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 16:48:20 -0700
Message-ID: <007301c14ad4$f2188560$36a3533e@s5u0t0>
From: "Javier" <fulgor@nettaxi.com>
To: <selinux@tycho.nsa.gov>
References: <1002012173.1248.12.camel@vorpal>
Subject: Re: A notion
Date: Tue, 2 Oct 2001 01:58:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For exploit buffer overflow you needn't know the distances you say, it helps
but it's not essential. Once you know (or suspect) the program is weak you
can try with differet sizes till you get the good one. If you want keep
yourself safe from this kind of exploiting, make sure that you control
buffer sizes. It is a simple and efficient method.

PD: Excuse my english but it is not my parent tongue.

----- Original Message -----
From: "Justin R. Smith" <jsmith@mcs.drexel.edu>
To: <selinux@tycho.nsa.gov>
Sent: Tuesday, October 02, 2001 10:42 AM
Subject: A notion


> It occurred to me that custom versions of software can be more secure
> than standard versions because various exploits (like stack smashing,
> etc.) require precise knowledge of certain sizes and distances in RAM
> (for instance, the distance from the end of a buffer to the return
> point...).
>
> Isn't it possible to develop a "randomizing C compiler" that randomly
> varies these distances every time it compiles a program? No two compiles
> of the same source code would be exactly the same (but they would
> execute the same way).
>
> This might involve inserting small random-sized blocks of dead code, or
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
> You have received this message because you are subscribed to the selinux
list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
