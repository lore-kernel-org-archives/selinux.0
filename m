Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4PFxkEE009209
	for <selinux@tycho.nsa.gov>; Fri, 25 May 2007 11:59:47 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4PFxkoG010608
	for <selinux@tycho.nsa.gov>; Fri, 25 May 2007 15:59:46 GMT
Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Mark Goldman <mgoldman@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1180034401.3930.203.camel@tresys-winxppro>
References: <20070521095414.832619201@tresys.com>
	 <20070521095518.515998898@tresys.com>
	 <1179868119.9092.38.camel@localhost.localdomain>
	 <1180015458.3930.173.camel@tresys-winxppro>
	 <1180017921.2940.24.camel@localhost.localdomain>
	 <1180034401.3930.203.camel@tresys-winxppro>
Content-Type: text/plain
Date: Fri, 25 May 2007 11:52:49 -0400
Message-Id: <1180108369.6331.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-24 at 15:20 -0400, Mark Goldman wrote:
> On Thu, 2007-05-24 at 10:45 -0400, Karl MacMillan wrote:
> > On Thu, 2007-05-24 at 10:04 -0400, Mark Goldman wrote:
> > > On Tue, 2007-05-22 at 17:08 -0400, Karl MacMillan wrote:

<snip>

> > I think the behavior should be similar, but there is no reason that we
> > can't make changes to corner case behavior if we think it would be
> > better. So I don't think an _exact_ port is necessary.
> I didn't know if this particular instance was, in fact, a corner case.
> I'd be just as happy for it to error if it is truly a rare condition.
> Comments?
> 

I say make it an error but will defer to others.

> > > > > +	list_t *list = NULL;
> > > > 
> > > > Why are you adding another list type when we just merged one into
> > > > libsepol? If you want this merged into trunk before policyrep let's move
> > > > the list type over early.
> > > I'm working off of trunk.  If it isn't in trunk it I can't use it.
> > > 
> > 
> > I think another list type is unacceptable so you can either work off
> > policyrep or propose early merging of the list types. Either one is fine
> > with me.
> If you would like to move the list types out of policyrep and into
> trunk, I'll be happy to use it.  Otherwise it is out of the scope of
> this patch.
> 

Please rebase against the policyrep branch - we can then consider
merging the list types and this patch to trunk if desired. I will NACK
this patch if it contains the additional list types.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
