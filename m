Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5THVegA014366
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 13:31:40 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5THUl79013665
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 17:30:47 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1119987085.4806.42.camel@celtics.boston.redhat.com>
References: <200506281347.j5SDlCqc027855@gotham.columbia.tresys.com>
	 <1119987085.4806.42.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 13:28:29 -0400
Message-Id: <1120066109.20484.19.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The more I think about this, the more it seems to me that:

1) Expansions are important, and not to be considered a hack - 
they're our only way to create configurable locations,
which we need, since users don't like to comply with our
standard locations. Expansions don't necessarily relate to home
directories, as I've pointed out.

2) We need a generic mechanism for installing
such expansions, and checking those...

3) Performing expansion of template in matchpathcon seems 
fundamentally wrong to me. The expansion would be performed 
on every invocation, and that would be slow, and unnecessary -
if it's already computed, why not use it? 

4) A context file for each user? Hmm...
500 users...500 files...concat those together?
A large context file with all the users in it doesn't
seem a whole lot better.

[root@celtics files]# cat file_contexts|wc
   2384    6045  102497

[root@celtics files]# cat file_contexts.homedirs|grep root|wc
     47     118    2755

So... say we have a machine with 500 users.
500 * 47 = 23500 lines, or 10 times the size of the current
file_contexts file, which takes forever to read (that's
why install is so slow, right?)

I don't think the current file_contexts approach scales too
well with lots of users...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
