Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UIB7Do017269
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 13:11:07 -0500 (EST)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UI7Hph029709
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 18:07:17 GMT
Received: by wproxy.gmail.com with SMTP id 40so238300wri
        for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 10:09:57 -0800 (PST)
Message-ID: <ae023b60050330100976b46528@mail.gmail.com>
Date: Wed, 30 Mar 2005 13:09:57 -0500
From: Jim McCullough <jim.mccullough@gmail.com>
Reply-To: Jim McCullough <jim.mccullough@gmail.com>
To: ivg2@cornell.edu
Subject: Re: Desktop apps interoperability
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
In-Reply-To: <1112204662.8592.42.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050330170426.86197.qmail@web31606.mail.mud.yahoo.com>
	 <20050330172630.GA10139@lkcl.net>
	 <1112204662.8592.42.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There as been multiple instances on other lists where an "admin" or
"developer" has been totally ignorant of any type of security
practices.  Cases of do as I will and roll with the punches.  This
occurs on all platforms of development.   Freedom of implementation
should also require some common sense.  I like the content folders
Ivan suggested.   That would save people like me who are attention
defficiet a more structured schema for their fresh systems ( and prob.
save me a couple of hours on my own each build i have to do for myself
).
  
-- 
Jim McCullough

On Wed, 30 Mar 2005 12:44:22 -0500, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
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
> This is a discussion of desktop applications that manipulate content
> relevant to the user - not internal settings. The settings that go
> under /home are another issue - that would require changing the app,
> but they don't have to be changed all at the same time.
> 
> All those apps *ask* you where to store the content. You create a
> document of some sort, and you have a choice of where to put it.
> This has nothing to do with the app developer. It's just another
> restriction imposed on the user. Hopefully there's a way to get
> away with it, while staying user-friendly. That's why I'm suggesting
> content folders be introduced and integrated w/ GNOME's Places
> menu, for example. That seems like a small first step to improving
> things... no?
> 
> Ok, some apps like gift don't ask where to save the content,
> but that's the exception and not the rule.
> 
> --
> Ivan Gyurdiev <ivg2@cornell.edu>
> Cornell University
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
