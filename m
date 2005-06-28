Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5SJYSgA006841
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 15:34:28 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5SJX8xl028841
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 19:33:08 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506281347.j5SDlCqc027855@gotham.columbia.tresys.com>
References: <200506281347.j5SDlCqc027855@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 15:31:25 -0400
Message-Id: <1119987085.4806.42.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > Does switching policies require changing the file contexts?
> > I typically use strict policy, so I'm not sure...
> > I suppose this file could be re-generated?
> > 
> 
> Yes - the two policies could potentially have no types in common.

So the file would be regenerated when switching policies.
You have to relabel the filesystem anyway - I don't
see why you can't run genhomedircon or whatever 
in the process.

> > > How would network home directories work?
> > 
> > The same way they work right now?
> > I didn't realize network home dirs support xattr..
> > 
> 
> They don't, but they will. And they don't really work right now.

I still don't understand the problem with network home dirs.
How do they require expansion handling inside matchpathcon?

===============

I've started to implement some of this new scheme for users - 
I've moved most of my code into libselinux,
and now I'm trying to get it to work again. However, I am not 
clear on how groups will work with this new map file (see other
message), and I'm also not clear on how to get the default
role from libselinux, since there is no such thing - 
what should ROLE expand to - do I have to assume the
first role of the users file is appropriate? 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
