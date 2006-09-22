Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MGFJ9G024784
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 12:15:19 -0400
Message-ID: <36282A1733C57546BE392885C061859201573509@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley
	 <sds@epoch.ncsc.mil>, Paul Moore <paul.moore@hp.com>,
        latten@austin.ibm.com, jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Fri, 22 Sep 2006 12:14:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Fri, 2006-09-22 at 11:21 -0400, Venkat Yekkirala wrote:
> 
> > > I don't know about this either. I was under the impression that
> > > reconciliation was for multiple *data* labels (e.g., 
> using ipsec and
> > > cipso at the same time). I don't know how secmark ever got pulled
> > into
> > > this mess, secmark is for labeling packet objects, we 
> never ask (or
> > > probably care) what the label on an individual packet is.
> > 
> > For the sake of asking, why wouldn't you care that you have 
> receieved
> > a packet of Type sysadm_pkt_t vs. secadm_pkt_t?
> > 
> > 
> 
> For starters I want the domain which would be sysadm_t or secadm_t,
> which I can actually use in avc queries without having to do 
> yet another
> transformation. Second differentiating them like that 
> requires netfilter
> to know the difference, which can't happen, its coming from 
> machine X on
> port Y and it'll always be policy_server_packet_t. 

You could also say its sysadm_polsvr_packet_t, transitioning to
sysadm_t, can't you?

> 
> Throwing ipsec associations into the mix just makes a management
> nightmare by requiring people to have SA and secmark pairs for every
> single possible domain

I am not getting this. Why would it be for every SA, secmark pair?
It would only be per need. And what is so sacrosant about domain
vs. Type any way? Your avc check will work either way wouldn't it?

> that could talk to every single other 
> machine is
> simply absurd. We are trying to make network management of selinux
> simpler
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
