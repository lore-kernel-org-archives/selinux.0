Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5N383gA023244
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 23:08:03 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5N2vmFC011989
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 02:57:48 GMT
Subject: file contexts and modularity
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 23:00:51 -0400
Message-Id: <1119495651.8194.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So, I know Tresys is working on binary policy modules.

What's the plan for dealing with the file_contexts file?

In particular, will this continue to be stored
as a single giant flat file, or will it be broken up
(or stored differently..)

============

I ask, because I am trying to figure out how to 
recover which contexts belong to which user, when parsing
the file_context.homedirs file, as part of my 
useradd/usermod/userdel patch.

This isn't as simple as it sounds, since
I can't use the user field (<<none>> contexts).
I suppose I could regenerate the right contexts from the
template, but that seems like bad design. Basically
it's exactly the same problem as establishing which
file_contexts relate to which app, so I'm wondering
what's the planned solution for that? Is there a plan?

If we're going to keep this in a big flat file, 
there should be some sort of way to indicate
a container for file contexts... (a dependency
keyword(s) or something)... or we could split it up
into multiple files.

Reminds me of the XML thread for some reason :)
But on the other hand XML-style requires strict nesting
relationship, while it would seem better to just do something like:

regexp class context [ dep_keyword1 dep_keyword2... ] 
(same row, brackets required).

Keywords could be users, applications, booleans, tunables, whatever..

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
