Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02911
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 14:12:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA24071
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 19:10:34 GMT
Received: from biocserver.BIOC.CWRU.Edu (biocserver.BIOC.CWRU.Edu [129.22.208.36])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA24067
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 19:10:33 GMT
Date: Wed, 10 Jan 2001 14:15:50 -0500 (EST)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: Andi Kleen <ak@suse.de>
cc: "Belmonte, Christopher" <cbelmonte@dit.state.va.us>,
        "'Johnathon Day'" <jcday@mail.thesportsregister.com>,
        <selinux@tycho.nsa.gov>
Subject: Re: SELinux and covert channels
In-Reply-To: <20010110192931.A3665@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0101101414520.31913-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Wed, 10 Jan 2001, Andi Kleen wrote:

> If you want no or at least better controllable covert channels use
> vmware or simply two different PCs.

how would this stop them? unless network enforcement is there (local
enforcement is absent as of yet), this is still a channel to send
information between two parties who are not authorized to share it.

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
