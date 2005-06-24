Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OHwwgA008667
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 13:58:58 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OHwM2B029014
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 17:58:23 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506241628.j5OGSpqc016758@gotham.columbia.tresys.com>
References: <200506241628.j5OGSpqc016758@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 13:56:28 -0400
Message-Id: <1119635788.31852.25.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > Also, there's no reason why delete should have to gather data like
> > add for expansions - I don't want to require the same interface
> > for delete as for add... you're saying I should require information on
> > all home directories (and/or any future expansion that we may
> > decide to add) just to delete some user...
> > 
> 
> Yep.

...why? this seems like a bad idea...
gathering this information may or may not be trivial/cheap 
in the future... what if you have 100000 users, and their
/etc/passwd data is kept in LDAP. 

Delete should not require info that does not pertain to 
its designated operation (removing contexts for a single user,
not adding contexts for *all* users in the process)

>  Also, to bring this in line with my other suggestion about how to handle
> users in general, it seems like the way to go is to have a chunk of file
> contexts for each SELinux user (what I am calling user roles) that is generated
> at policy development time. 

You can't generate per user contexts at policy development time - the
users can and will change after that time.

> This can be applied to each home directory at user
> add/change time. 
> 
That sounds like the template system that we have currently - how 
is this proposal different? 

> That means that genhomedircon can basically stick around - it
> is only a build requirement. This just means we have to have a special setfiles
> mode for home directory labeling that uses the correct home directory file
> contexts.

So you're saying that the per user contexts shouldn't even be 
*generated* - you should interpret the expansions in matchpathcon?

This is making matchpathcon too smart...but I haven't looked
at that code, so I don't know if that's a good idea.

Please don't assume path expansions have anything to do with the home
dir. I've already added one that expands to the user name, and may
add others in the future. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
