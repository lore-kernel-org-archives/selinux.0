Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2ULpqDo019392
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 16:51:53 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2ULm0ph013859
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 21:48:00 GMT
Date: Wed, 30 Mar 2005 23:00:18 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050330220018.GA9752@lkcl.net>
References: <20050330170426.86197.qmail@web31606.mail.mud.yahoo.com> <20050330172630.GA10139@lkcl.net> <1112204662.8592.42.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112204662.8592.42.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 30, 2005 at 12:44:22PM -0500, Ivan Gyurdiev wrote:
> On Wed, 2005-03-30 at 18:26 +0100, Luke Kenneth Casson Leighton wrote:
> > On Wed, Mar 30, 2005 at 09:04:26AM -0800, Casey Schaufler wrote:
> > 
> > > Yes, and I'm sure that you can do a configuration
> > > of most application defaults that will be good
> > > enough to demo. Application developers tend to
> > > have their own ideas regarding data storage and
> > > it is a bad idea for a system developer to
> > > interfere with said application developer's
> > > freedom to inovate.
> > 
> >  ... application developer's freedom to impose insecurity,
> >  through ignorance on the part of the app-developer, upon
> >  the users?
> > 
> >  no offense intended: freedom in an abstract concept [e.g. "the american
> >  way"] _always_ has limits - laws / rules / policy is defined to confine
> >  that freedom, for good or worse.
> 
> I don't understand what this has to do with the application developer.
 
 i must not understand the point, then.

> This is a discussion of desktop applications that manipulate content
> relevant to the user - not internal settings. 

 i believe it started out as internal settings [someone
 suggested a ~/.etc / registry etc solution e.g. gconfd]
 or maybe that was a different thread.  ... anyway.

> All those apps *ask* you where to store the content. 


 not necessarily - and, additionally, they typically have
 default locations where the content is asked to be stored,
 and the majority of users go "duhhhhhh, *click*".

 esp. windows users, for whom "duhhhh, *click*" means it ends
 up in "My Documents", or "The Desktop", etc. etc. and then
 they bitch like hell because they can't _find_ anything.


> Ok, some apps like gift don't ask where to save the content, 
> but that's the exception and not the rule. 

 some apps don't ask - but the "default" location is just as
 important, imo, as not being asked at all.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
