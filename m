Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA09796
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 23:13:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA28785
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 03:12:41 GMT
Received: from mail.landeretreat.com (DT1-A-hfc-0251-d1da5405.rdc1.sdca.coxatwork.com [209.218.84.5])
	by jazzband.ncsc.mil  with ESMTP id DAA28771
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 03:12:40 GMT
Reply-To: <lmcphail@landeretreat.com>
From: "Lon McPhail" <lmcphail@landeretreat.com>
To: <selinux@tycho.nsa.gov>
Subject: FW: A notion
Date: Mon, 1 Oct 2001 20:12:25 -0700
Message-ID: <003d01c14af0$100cdf10$0564a8c0@cerver011>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


From: 	Lon McPhail [mailto:lmcphail@landeretreat.com]
Sent:	Monday, October 01, 2001 8:07 PM
To:	'owner-selinux@tycho.nsa.gov'
Subject:	RE: A notion

How about if you ran the code on a VMware GSX server farm?  Consider;
* Take, say, twenty boxes running VMware GSX.
* On nineteen of them, establish a Beowulf server cluster operating on a
192.168.*.* address set.
* The twentieth node as the head unit on a 10.*.*.* address.
* Run all VM thread instances in real-time to afford the highest Mflops
clocking.
* The nineteen boxes running SELinux on a, say, 205.*.*.*-type address
scheme, hosting the VMware Slave nodes running SELinux could be configured
to only accept non-local interactions from the head node.
* The head box running SELinux, hosting the VMware head node running SELinux
could be configured to Polymorph the code itself, accepting only local
entries from a Bio-keyed workstation.
* The instances of SELinux VM files could be numbered sequentially, and
after every, say, 17 hours, the scripts would load the next sequential
instance.  The purpose of shifting files would be that each instance would
have a different key-pair with the head unit.  After 17 hours of work units,
any hack would have to restart the attack on one of 18 remaining key-pair
sets.  (If they even knew what the total count was).



Lon McPhail
Lon@MacMailbox.com
Phone:  (619) 840-7600
FAX:    (619) 230-1932

-----Original Message-----
From:	owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]  On
Behalf Of Phillip H. Zakas
Sent:	Monday, October 01, 2001 3:43 PM
To:	Justin R. Smith; selinux@tycho.nsa.gov
Subject:	RE: A notion

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
> From:	owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Justin R. Smith
> Sent:	Tuesday, October 02, 2001 4:43 AM
> To:	selinux@tycho.nsa.gov
> Subject:	A notion
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
You have received this message because you are subscribed to the selinux
list.  If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
