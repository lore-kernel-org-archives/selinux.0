Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UHeUDo016756
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 12:40:30 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UHZtph027542
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 17:35:55 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
In-Reply-To: <20050330172630.GA10139@lkcl.net>
References: <20050330170426.86197.qmail@web31606.mail.mud.yahoo.com>
	 <20050330172630.GA10139@lkcl.net>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 12:44:22 -0500
Message-Id: <1112204662.8592.42.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-30 at 18:26 +0100, Luke Kenneth Casson Leighton wrote:
> On Wed, Mar 30, 2005 at 09:04:26AM -0800, Casey Schaufler wrote:
> 
> > Yes, and I'm sure that you can do a configuration
> > of most application defaults that will be good
> > enough to demo. Application developers tend to
> > have their own ideas regarding data storage and
> > it is a bad idea for a system developer to
> > interfere with said application developer's
> > freedom to inovate.
> 
>  ... application developer's freedom to impose insecurity,
>  through ignorance on the part of the app-developer, upon
>  the users?
> 
>  no offense intended: freedom in an abstract concept [e.g. "the american
>  way"] _always_ has limits - laws / rules / policy is defined to confine
>  that freedom, for good or worse.

I don't understand what this has to do with the application developer.
This is a discussion of desktop applications that manipulate content
relevant to the user - not internal settings. The settings that go
under /home are another issue - that would require changing the app,
but they don't have to be changed all at the same time. 

All those apps *ask* you where to store the content. You create a
document of some sort, and you have a choice of where to put it.
This has nothing to do with the app developer. It's just another
restriction imposed on the user. Hopefully there's a way to get 
away with it, while staying user-friendly. That's why I'm suggesting
content folders be introduced and integrated w/ GNOME's Places
menu, for example. That seems like a small first step to improving
things... no?

Ok, some apps like gift don't ask where to save the content, 
but that's the exception and not the rule. 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
