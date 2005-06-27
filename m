Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5RHxVgA026542
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 13:59:31 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5RHwNMC025508
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 17:58:23 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506271725.j5RHP9qc019649@gotham.columbia.tresys.com>
References: <200506271725.j5RHP9qc019649@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 13:56:20 -0400
Message-Id: <1119894980.26533.33.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> How would a non-home directory expansion work?

I can't answer this question, but I think claiming that such use
cases will not exist in the future is not warranted.

Why do expansions exist? Because we can't hardcode user information,
and this information has to be extracted as the users are created.

What makes you think this can't occur in other situations in the future.
Consider a scenario where you don't know the locations of things
in advance, and you have to query some sort of external source
to find that out... say GNOME implements a download folder, like 
I've been saying they should. I remember someone on the usability
list argued that it might be a smart idea to have its name be
configurable via GConf key. I don't know how good of an idea that is,
but now you have another thing which doesn't have a fixed name, and
you have to extract from an external source. I can easily see 
something like this being used in the future:

HOME_DIR/GNOME_MEDIA -- gnome_media_content_t
HOME_DIR/GNOME_...blah

and that's just one scenario.

Consider that one of the major problems of SELinux today is how
location-oriented labeling is - it's focused on where the data
is, not what the data is. Those two things don't always match - 
people use nonstandard locations all the time, and expansions
may be one way to deal with that in the future.

> Without a compelling use case I think that this is a slippery slope
> that could cause problems.

I realize this is not a compelling use case right now, but 
I'm just saying it should be a consideration before we go
and put expansion-handling code into matchpathcon.

> I more concerned about the other questions - how would a user switch policies
> with this scheme? 

Does switching policies require changing the file contexts?
I typically use strict policy, so I'm not sure... 
I suppose this file could be re-generated?

> How would network home directories work?

The same way they work right now?
I didn't realize network home dirs support xattr..

>  Tying the creation of
> the labeling information to calling adduser seems fragile.

Perhaps... 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
