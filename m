Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OG5TgA007388
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 12:05:29 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OG5SUD020006
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 16:05:28 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506241539.j5OFd8qc016279@gotham.columbia.tresys.com>
References: <200506241539.j5OFd8qc016279@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 12:03:00 -0400
Message-Id: <1119628980.30464.28.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> What's wrong with:
> 
> 1) Read file contexts with ROLE, etc. still present.
> 2) Extract all context lines with ROLE.

Okay..

> 3) Write all plain context lines to new file.

There should be none of those...

> 4) Iterate through users and append to the new file all of the extracted context
> lines with ROLE, etc statements replaced.

The replace is a pain to do... and if there's a whole lot
of users I have to do it a whole lot of times.

Furthermore I may or may not want to affect other users
with modifications to my single user that I'm interested in.
Right now I will validate all users when passing through the file,
but will not modify anything that does not concern me, 
whether there's an error or not.

Also, there's no reason why delete should have to gather data like
add for expansions - I don't want to require the same interface
for delete as for add... you're saying I should require information on
all home directories (and/or any future expansion that we may 
decide to add) just to delete some user...

> 5) Replace old file contexts file with new one.

Yes... I was appending to the old file previously, but
copy/modify and replace is the way to go.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
