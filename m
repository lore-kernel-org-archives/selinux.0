Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l34KAWKh028001
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 16:10:32 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l34KAV60005030
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 20:10:31 GMT
Subject: Re: secmark integration
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1175707323.11382.25.camel@sgc.columbia.tresys.com>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
	 <1175284031.3602.24.camel@localhost.localdomain>
	 <1175286309.20396.13.camel@localhost.localdomain>
	 <Line.LNX.4.64.0703302201520.29742@d.namei>  <46111709.9060402@redhat.com>
	 <1175525718.20396.46.camel@localhost.localdomain>
	 <1175526952.14681.44.camel@sgc>
	 <1175534120.5433.2.camel@localhost.localdomain>
	 <1175707323.11382.25.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 16:08:14 -0400
Message-Id: <1175717294.3191.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-04 at 17:22 +0000, Christopher J. PeBenito wrote:
> On Mon, 2007-04-02 at 13:15 -0400, Karl MacMillan wrote:
> > On Mon, 2007-04-02 at 15:15 +0000, Christopher J. PeBenito wrote:
> > > On Mon, 2007-04-02 at 10:55 -0400, Eric Paris wrote:
> > > > 
> > > > Good idea.  Can anyone help me come up with any way in which we can use
> > > > secmark 'by default' and gain any greater protections than we already
> > > > have with name_{bind,connect}
> > > > 
> > > > Seems to me that port number is the only thing we can label based on for
> > > > everyone out of the box.  Any more complex labeling scheme is going to
> > > > require network specific information, right?
> > > 
> > > Right.  Refpolicy already can create a set of iptables rules based on
> > > the ports defined in the policy, but its not currently shipped (which
> > > was decided at the summit).
> > > 
> > 
> > I don't think that there are particularly good restrictions that we can
> > do out of the box. I think that we should instead focus on making it
> > fairly easy to do customization with some documentation / recipes that
> > people can follow.
> 
> I still think the set that refpolicy can generate is fine.  It provides
> the default ports for services on all interfaces.  This is better than
> almost unconfined as it is now.  The incoming connections rules mirror
> the name_bind rules, and the outgoing connections mirrors the
> name_connect rules.  Since UDP doesn't have a connect we can cover that
> reasonably too.  Then we get the connection tracking on all these too.
> 

The problem is moving from this default to a customized version. How
will a packet type be redefined? Additive rules are fine, but changing
or removing rules is problematic.

Anyway - I thought that this decision was already made. Are people
wanting to discuss this again?

> > To that end, Chris / Dan, can you comment on my policy example? What I
> > posted doesn't exactly work now and I would like to know what the
> > suggested method for allowing almost all network facing daemons to
> > receive unlabeled_t packets is going to be.
> 
> Actually, my current idea is to make a tunable for each domain that
> networks.  If we were to go the negation route, it would be something
> like this in corenetwork:
> 
> corenet_sendrecv_unlabeled_packets({ networking_domain -confined_networking_domain })
> 
> Then corenetwork would provide interfaces to gain these attributes.

Is this actively being worked on?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
