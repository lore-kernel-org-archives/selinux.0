Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA08952
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 18:39:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA18554
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 22:38:35 GMT
Received: from EXCH-FE-AB.EXCHPROD.USA.NET ([165.212.49.201])
	by jazzband.ncsc.mil  with ESMTP id WAA18549
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 22:38:34 GMT
From: "Phillip H. Zakas" <pzakas@toucancapital.com>
To: "Justin R. Smith" <jsmith@mcs.drexel.edu>, <selinux@tycho.nsa.gov>
Subject: RE: A notion
Date: Mon, 1 Oct 2001 18:43:08 -0400
Message-ID: <GPEALCPFLNHDAABJENOFOEJGCIAA.pzakas@toucancapital.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1002012173.1248.12.camel@vorpal>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

that's not a bad idea, though the solution addresses a limited number of
attacks. you can insert, for Intel and Athlon-based machines, NOPs
(assembler for No Operation) to pad the code.  To randomize the
number/position of NOPs inserted one could use a perl script to identify
begin and end-points in a c program and have it insert the NOPs randomly
before compilation.  In the case of optimizing compilers you may have to use
dummy instructions such as SHL then SHR on some variable, or conditional
jumps leading to a NOP, etc.
phillip

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Justin R. Smith
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
> You have received this message because you are subscribed to the
> selinux list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
