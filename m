Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2VG7BDo026130
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 11:07:11 -0500 (EST)
Received: from web31615.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j2VG5oiv017594
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 16:05:51 GMT
Message-ID: <20050331160546.36303.qmail@web31615.mail.mud.yahoo.com>
Date: Thu, 31 Mar 2005 08:05:46 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Desktop apps interoperability
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> On Wed, 2005-03-30 at 09:58 -0800, Casey Schaufler
> wrote:
> > --- Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > 
> > > Ok, some apps like gift don't ask where to save
> the
> > > content, 
> > > but that's the exception and not the rule. 
> > 
> > I challenge you to back up this claim.
> 
> I don't need to back up this claim, because:

Of course you don't need to back up the claim.

> 1) Apps that don't let you configure where to save
> your content are
> badly designed.

This may be true, but the quality of design
is not an issue.

> 2) They can be changed

Look here, sonny, I've been doing MLS systems
since 1986 and the One Truth You Must Learn
is that applications can not be changed. No.
Don't even consider thinking in this direction.
This is wrong. Sometimes all that's available
is the binary. Sometimes they like the way it
works.

> 3) If they're not changed, it doesn't matter,
> because what I'm proposing
> is backwards compatible. User_t will still have
> access to all content
> types, and can write stuff to /home as user_home_t.

But ...

> Apps will have to be
> specifically confined in order not to be able to
> write to user_home_t.
> If some app is a problem, it can be left to run at
> user_home_t for now.

... then what's your whole point? I mean,
why this whole line about structuring where
user data goes?

> 4) If apps store stuff in a hardcoded location, we
> can label that easily
> with the proper context, unless it's hardcoded to
> /home or some other
> shared place. 

You're right. 

> Anyway, I am starting to get a better idea as to how
> this might work - 
> see my response to Luke's message.

Will have a look. BTW, good work.
Don't let a dinosaur like me get in
your way of making things work right.


Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
