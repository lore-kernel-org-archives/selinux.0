Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA08975
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 18:43:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA21285
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 22:42:02 GMT
Received: from EXCH-FE-AB.EXCHPROD.USA.NET ([165.212.49.201])
	by jazzswing.ncsc.mil  with ESMTP id WAA21281
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 22:42:02 GMT
From: "Phillip H. Zakas" <pzakas@toucancapital.com>
To: "Jose Nazario" <jose@biocserver.bioc.cwru.edu>,
        "Justin R. Smith" <jsmith@mcs.drexel.edu>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: A notion
Date: Mon, 1 Oct 2001 18:47:49 -0400
Message-ID: <GPEALCPFLNHDAABJENOFCEJHCIAA.pzakas@toucancapital.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <Pine.LNX.4.30.0110011734330.20148-100000@biocserver.BIOC.CWRU.Edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


polymorphic code usually follows one (or a combo) of three paths: 1)
randomly insert NOPs into the code; 2) break codes into pieces (sort of like
objects) and randomize placement and use JMP commands to keep the code in
proper order; 3) develop a 'translation' mechanism and use tokens to
represent code instructions...as code is executed, the translation code
interprets and translates each token.  not sure this is completely on-topic
for SELINUX, but it does have application.

cheers-
phillip

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Jose Nazario
> Sent: Monday, October 01, 2001 5:36 PM
> To: Justin R. Smith
> Cc: selinux@tycho.nsa.gov
> Subject: Re: A notion
>
>
> On 2 Oct 2001, Justin R. Smith wrote:
>
> > Isn't it possible to develop a "randomizing C compiler" that randomly
> > varies these distances every time it compiles a program? No two
> > compiles of the same source code would be exactly the same (but they
> > would execute the same way).
>
> to the best of my knowledge morphing code, in a variety of fashions (stuff
> that changes every time it compiles, every time it runs, while it runs) is
> a hot topic of DARPA research right now. as such, look around various
> sites doing research for DARPA and see who is doing what, publicly. a lot
> of the technology may be hidden behind various closed doors (ie commercial
> interests).
>
> ____________________________
> jose nazario						     jose@cwru.edu
> 	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
> 				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)
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
