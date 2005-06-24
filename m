Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OGT4gA007701
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 12:29:04 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OGT3UD021109
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 16:29:03 GMT
Message-Id: <200506241628.j5OGSpqc016758@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Fri, 24 Jun 2005 12:28:52 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119628980.30464.28.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Friday, June 24, 2005 12:03 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> 
> > What's wrong with:
> >
> > 1) Read file contexts with ROLE, etc. still present.
> > 2) Extract all context lines with ROLE.
> 
> Okay..
> 
> > 3) Write all plain context lines to new file.
> 
> There should be none of those...
> 
> > 4) Iterate through users and append to the new file all of the extracted
> context
> > lines with ROLE, etc statements replaced.
> 
> The replace is a pain to do... and if there's a whole lot
> of users I have to do it a whole lot of times.
> 

This is a performance objection? I can't believe that it will be slow enough to
matter and the tradeoff for obvious correctness seems worth it to me.

> Furthermore I may or may not want to affect other users
> with modifications to my single user that I'm interested in.

? What effect could there be? This file should be reproducible at all times and
should accurately reflect a) the current file contexts as defined by the policy
and b) the current users and their data (home dir, etc).

> Right now I will validate all users when passing through the file,
> but will not modify anything that does not concern me,
> whether there's an error or not.
> 
> Also, there's no reason why delete should have to gather data like
> add for expansions - I don't want to require the same interface
> for delete as for add... you're saying I should require information on
> all home directories (and/or any future expansion that we may
> decide to add) just to delete some user...
> 

Yep. Also, to bring this in line with my other suggestion about how to handle
users in general, it seems like the way to go is to have a chunk of file
contexts for each SELinux user (what I am calling user roles) that is generated
at policy development time. This can be applied to each home directory at user
add/change time. That means that genhomedircon can basically stick around - it
is only a build requirement. This just means we have to have a special setfiles
mode for home directory labeling that uses the correct home directory file
contexts.

Karl

> > 5) Replace old file contexts file with new one.
> 
> Yes... I was appending to the old file previously, but
> copy/modify and replace is the way to go.

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
