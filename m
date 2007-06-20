Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5KDrfiS021660
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 09:53:41 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5KDreAt014652
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 13:53:40 GMT
Subject: Re: [PATCH 1/5] Use the netmsg initial SID for NetLabel connections
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200706191101.51123.paul.moore@hp.com>
References: <20070614195502.420663549@hp.com>
	 <20070614200057.176682747@hp.com> <1182262382.4077.111.camel@gorn>
	 <200706191101.51123.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 09:52:00 -0400
Message-Id: <1182347520.16539.27.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-19 at 11:01 -0400, Paul Moore wrote:
> On Tuesday 19 June 2007 10:13:02 am Christopher J. PeBenito wrote:
> > On Thu, 2007-06-14 at 15:55 -0400, Paul Moore wrote:
> > > plain text document attachment (netlabel-netmsg_update)
> > > This patch changes the policy to use the netmsg initial SID as the "base"
> > > SID/context for NetLabel packets which only have MLS security attributes.
> > > Currently we use the unlabeled initial SID which makes it very difficult
> > > to distinquish between actual unlabeled packets and those packets which
> > > have MLS security attributes.
> >
> > I've been thinking more about unifying the ipsec and netlabel interfaces
> > where possible, looking forward to when labeled ipsec is working.
> >
> > However, I think the ipsec control will be with associations, so they'll
> > be protocol inspecific (from a policy perspective).  The question is do
> > we really care which protocol a labeled packet comes over?
> 
> I assume by protocol you mean UDP, TCP, etc. and not labeled IPsec, CIPSO, 
> etc. ?

Sorry, Yes, I mean UDP, TCP, etc.

> If that is the case NetLabel/CIPSO does care about the upper layer transport 
> protocol because the permissions are based around the different socket 
> classes.

I know the mechanism can differentiate, but do policy writers care?  In
a completeness sense there should be separate interfaces, but I think
the common case is they they don't care.

>   Labeled IPsec doesn't have this level of granularity so that camp 
> most likely doesn't care.
> 
> If we are talking about labeling protocols, I'm not sure we care how a 
> packet/connection/SA is labeled as long as it is labeled.  For example, I'm 
> okay with having the following policy interfaces (or something similar):
> 
>  corenet_{tcp,udp,raw,etc}_recv_labeled
>  corenet_{tcp,udp,raw,etc}_send_labeled
>  corenet_{tcp,udp,raw,etc}_recv_unlabeled
>  corenet_{tcp,udp,raw,etc}_send_unlabeled
> 
> This is what I was trying to get at earlier with my RFC patch questions, 
> perhaps I just worded it poorly.

I don't think the send interfaces are needed since netlabel doesn't
support it, and eventually ipsec will drop it.

> > If not we 
> > can collapse the netlabel rules.  Since we already have the regular
> > networking controls that are protocol-aware, it seems ok to not care
> > about the protocol of a labeled packet.
> >
> > Also interesting is that the current association controls have a sendto,
> > though that will eventually be dropped, so the unlabeled recvfrom will
> > have to include the sendto rule for now.
> 
> Okay, I think I see what you are getting at but just so I'm clear can you give 
> me a quick example?  This is a _very_ big patch (even though the changes are 
> small, there are a lot of them) and I'd like to minimize the number of times 
> I have to rewrite it ;)

abbreviated examples:

interface(`corenet_tcp_recvfrom_unlabeled',`
	kernel_tcp_recvfrom_unlabeled($1)

	# send will eventually be dropped, but need
	# it for systems that still have the
	# send check
	kernel_sendrecv_unlabeled_association($1)
')

interface(`corenet_tcp_recvfrom_netlabel',`
	# no association since this is netlabel-specific
	allow $1 netlabel_peer_t:tcp_socket recvfrom;
')

interface(`apache_tcp_recvfrom',`
	allow $1 httpd_t:{ tcp_socket association } recvfrom;
')

Note the verb in the interface name should be recvfrom.  Then the
corenet_non_ipsec_sendrecv() can be dropped out of the modules since
you're adding corenet_*_recvfrom_unlabeled().  I don't think that there
will be problems fixing up the patches, its just some tweaks on this one
(1/5), and the others can be fixed with sed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
