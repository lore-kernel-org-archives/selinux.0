Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m91GblLF010877
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 12:37:47 -0400
Received: from g5t0009.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m91GahYT005372
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 16:36:43 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v6 02/16] selinux: Correctly handle IPv4 packets on IPv6 sockets in all cases
Date: Wed, 1 Oct 2008 12:37:44 -0400
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125601.17132.61002.stgit@flek.lan> <alpine.LRH.1.10.0810011136230.5277@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0810011136230.5277@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810011237.44688.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 30 September 2008 9:36:57 pm James Morris wrote:
> On Tue, 16 Sep 2008, Paul Moore wrote:
> > We did the right thing in a few cases but there were several areas
> > where we determined a packet's address family based on the socket's
> > address family which is not the right thing to do since we can get
> > IPv4 packets on IPv6 sockets. This patch fixes these problems by
> > either taking the address family directly from the packet.
> >
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
>
> Acked-by: James Morris <jmorris@namei.org>

Thanks for taking the time to review and comment on the patches, again.  
I'm adding all of your acks/review to the patches and will post an 
updated patchset once I've had the chance to sanity check the fixes.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
