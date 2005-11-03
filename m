Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA3InxMA018182
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 13:49:59 -0500 (EST)
Received: from e6.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA3IichI010049
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 18:44:38 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id jA3IidKi017519
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 13:44:39 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id jA3Iibg6089020
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 13:44:39 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id jA3IibTC030593
	for <selinux@tycho.nsa.gov>; Thu, 3 Nov 2005 13:44:37 -0500
Subject: Re: A question on integrating IPSec to Selinux
From: Joy Latten <latten@austin.ibm.com>
To: Wei Shen <cquark@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e12e59640511021904y1940f1a1i140aabff7f857f0b@mail.gmail.com>
References: <e12e59640511020830q18817c3dsb01d3051970baf9f@mail.gmail.com>
	 <WSNCEXC0010dSHpVyLr00001d77@wsncexc001.silkroadtech.com>
	 <e12e59640511021904y1940f1a1i140aabff7f857f0b@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 12:41:34 -0600
Message-Id: <1131043294.2653.83.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The current implementation does not accommodate for MLS, in regards to
your example of different levels. But I do think someone is looking into
it.

Regards,
Joy

On Thu, 2005-11-03 at 11:04 +0800, Wei Shen wrote:
> Dear Remmolt,
> 
> I do not quite understand your reply. Do you mean the space in a
> playload is too precious to insert in any other information?
> 
> I know the contents of a payload. Now that a local MAC label is
> already added in current implementation, why will an "optional" remote
> label cause significant problems? If one desires not to request a
> expected label, the responder just chooses a default one for him as in
> current way.
> 
> In fact, I think it's a cheap method comparing to in which a client
> must prepare different payloads to meet the requirement of his
> expected label in the server side (he then must know more details
> about the IPSec policy configuration of the server), or modifying each
> application protocol and server individually.
> 
> Thanks!
> 
> Wei
> 
> On 11/3/05, Remmolt Zwartsenberg <remmolt.zwartsenberg@silkroadtech.com> wrote:
> >
> > You need to backtrack to the bowels of the origin of the TCP/IP protocol!
> >
> > A payload inside an IP packet can get as small as a datagram...
> >
> > The datagram may be a very significant public or private key in a 2, 3 or 4
> > way constellation.
> >
> > Of course the protocol is important, but equally so are the peers behind
> > the  handshakes.
> >
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
