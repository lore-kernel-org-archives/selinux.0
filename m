Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5KGugfL001928
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 12:56:42 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5KGufe3027687
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 16:56:42 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 1/5] Use the netmsg initial SID for NetLabel connections
Date: Wed, 20 Jun 2007 12:55:56 -0400
Cc: selinux@tycho.nsa.gov
References: <20070614195502.420663549@hp.com> <200706191101.51123.paul.moore@hp.com> <1182347520.16539.27.camel@gorn>
In-Reply-To: <1182347520.16539.27.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706201255.56983.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, June 20 2007 9:52:00 am Christopher J. PeBenito wrote:
> On Tue, 2007-06-19 at 11:01 -0400, Paul Moore wrote:
> > If that is the case NetLabel/CIPSO does care about the upper layer
> > transport protocol because the permissions are based around the different
> > socket classes.
>
> I know the mechanism can differentiate, but do policy writers care?  In
> a completeness sense there should be separate interfaces, but I think
> the common case is they they don't care.

Okay, then perhaps the best route is to have a low level interface which 
differentiates between the transport protocol (similar to what was originally 
proposed in this patch) as well as a higher-level interface which does not 
distinguish (like proposed below).  For the basic reference policy modules we 
would use the higher level interfaces but leave the lower level interfaces 
for third parties that might care.

> > If we are talking about labeling protocols, I'm not sure we care how a
> > packet/connection/SA is labeled as long as it is labeled.  For example,
> > I'm okay with having the following policy interfaces (or something
> > similar):
> >
> >  corenet_{tcp,udp,raw,etc}_recv_labeled
> >  corenet_{tcp,udp,raw,etc}_send_labeled
> >  corenet_{tcp,udp,raw,etc}_recv_unlabeled
> >  corenet_{tcp,udp,raw,etc}_send_unlabeled
> >
> > This is what I was trying to get at earlier with my RFC patch questions,
> > perhaps I just worded it poorly.
>
> I don't think the send interfaces are needed since netlabel doesn't
> support it, and eventually ipsec will drop it.

That is fine with me, I'm not sure a send interface makes much sense anyway.  
I just wanted to make sure I wasn't shortchanging the labeled IPsec policy.

> > > If not we
> > > can collapse the netlabel rules.  Since we already have the regular
> > > networking controls that are protocol-aware, it seems ok to not care
> > > about the protocol of a labeled packet.
> > >
> > > Also interesting is that the current association controls have a
> > > sendto, though that will eventually be dropped, so the unlabeled
> > > recvfrom will have to include the sendto rule for now.
> >
> > Okay, I think I see what you are getting at but just so I'm clear can you
> > give me a quick example?  This is a _very_ big patch (even though the
> > changes are small, there are a lot of them) and I'd like to minimize the
> > number of times I have to rewrite it ;)
>
> abbreviated examples:
>
> interface(`corenet_tcp_recvfrom_unlabeled',`
> 	kernel_tcp_recvfrom_unlabeled($1)
>
> 	# send will eventually be dropped, but need
> 	# it for systems that still have the
> 	# send check
> 	kernel_sendrecv_unlabeled_association($1)
> ')
>
> interface(`corenet_tcp_recvfrom_netlabel',`
> 	# no association since this is netlabel-specific
> 	allow $1 netlabel_peer_t:tcp_socket recvfrom;
> ')
>
> interface(`apache_tcp_recvfrom',`
> 	allow $1 httpd_t:{ tcp_socket association } recvfrom;
> ')
>
> Note the verb in the interface name should be recvfrom.  Then the
> corenet_non_ipsec_sendrecv() can be dropped out of the modules since
> you're adding corenet_*_recvfrom_unlabeled(). 

Great, that is what I was looking for, thank you.  I'm a bit tied up right now 
but give me a few days and I'll submit a revised patchset for you to review.

> I don't think that there
> will be problems fixing up the patches, its just some tweaks on this one
> (1/5), and the others can be fixed with sed.

Yes, I just find it easier/faster to discuss it like this via email instead of 
the patch, comment, wash, rinse, repeat cycle :)

Thanks for your help, I'll have something out in another few days.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
