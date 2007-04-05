Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l35HgQft007004
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2007 13:42:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l35HgOAI021770
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2007 17:42:24 GMT
Subject: Re: secmark integration
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1175792799.17676.10.camel@sgc>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
	 <1175284031.3602.24.camel@localhost.localdomain>
	 <1175286309.20396.13.camel@localhost.localdomain>
	 <Line.LNX.4.64.0703302201520.29742@d.namei>  <46111709.9060402@redhat.com>
	 <1175525718.20396.46.camel@localhost.localdomain>
	 <1175526952.14681.44.camel@sgc>
	 <1175534120.5433.2.camel@localhost.localdomain>
	 <1175707323.11382.25.camel@sgc.columbia.tresys.com>
	 <1175717294.3191.2.camel@localhost.localdomain>
	 <46140FCA.5020901@redhat.com>
	 <1175788131.3174.4.camel@localhost.localdomain>
	 <1175792799.17676.10.camel@sgc>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 13:40:00 -0400
Message-Id: <1175794800.2902.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-05 at 13:06 -0400, Christopher J. PeBenito wrote:
> On Thu, 2007-04-05 at 11:48 -0400, Karl MacMillan wrote:
> > On Wed, 2007-04-04 at 16:51 -0400, Daniel J Walsh wrote:
> > > Karl MacMillan wrote:
> > > > On Wed, 2007-04-04 at 17:22 +0000, Christopher J. PeBenito wrote:
> > > >> On Mon, 2007-04-02 at 13:15 -0400, Karl MacMillan wrote:
> > > >>> I don't think that there are particularly good restrictions that we can
> > > >>> do out of the box. I think that we should instead focus on making it
> > > >>> fairly easy to do customization with some documentation / recipes that
> > > >>> people can follow.
> > > >>>       
> > > >> I still think the set that refpolicy can generate is fine.  It provides
> > > >> the default ports for services on all interfaces.  This is better than
> > > >> almost unconfined as it is now.  The incoming connections rules mirror
> > > >> the name_bind rules, and the outgoing connections mirrors the
> > > >> name_connect rules.  Since UDP doesn't have a connect we can cover that
> > > >> reasonably too.  Then we get the connection tracking on all these too.
> > > >
> > > > The problem is moving from this default to a customized version. How
> > > > will a packet type be redefined? Additive rules are fine, but changing
> > > > or removing rules is problematic.
> 
> These are two separate issues.  My argument was about the quality of the
> default rules, not about how well they could be managed.
> 

Ok - but you still seem to be suggesting generating defaults from
reference policy, which is what I think is basically unworkable.

As for the defaults themselves - there seems to be a decent chance that
adding restrictions will cause breakage. I'm ok with that as long as
there is a clear mechanism for users to relax the restrictions or go
back to the same restrictions that we have today (i.e., just name_bind
and name_connect).

That's why I keep talking about these issues together - our ability to
have tighter defaults depends, I think, on our ability to manage the
rules.

> > 
> > I think it is going to have to be all of these - basically any app that,
> > by default, can receive unlabeled packets. BTW, we are going to need the
> > interface that grants access to unlabeled packets but has a boolean and
> > an interface that unconditionally allows that access (for use during
> > customizations).
> 
> No, two interfaces aren't going to be needed.  If you go the negation
> route, then users will be putting the interface call that gets the
> confined_networking_domain attribute in their local.te when they want to
> confine it.  If you go with my original idea, then the tunable will be
> in the module itself.  The closest thing I can think of to what you're
> saying would be to make a template that declares a tunable and then
> encases a call to corenet_sendrecv_unlabeled_packets() inside of it,
> which would be useful for my idea.
> 

That sounds fine to me (assuming I understand), but I thought people
were concerned about the number of booleans.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
