Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LIYbgA028940
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:34:37 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LITDBa003061
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:29:13 GMT
Subject: Re: [ libsepol 2/6] Ports
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42DFE3B6.7070402@tresys.com>
References: <1121967601.9844.26.camel@celtics.boston.redhat.com>
	 <42DFE3B6.7070402@tresys.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 14:27:30 -0400
Message-Id: <1121970450.9844.72.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> This probably belongs in libsemanage. I'm trying to get a comprehensive 
> API and set of structs so that you can start writing the port and user 
> code with respect to it. I'll try to get this out later today.

I already have a whole bunch of code written that has to do with
parsing things. I need to do a better job with transactions in
that code, but hopefully I won't need to go and rewrite all of it.

The code is based on the wrapper structures that I showed you earlier - 
they are called records. Then I have record_iterate_file() and
record_modify_file() that can be made to work on any type
of record. They handle record creation/destruction/parsing
according to an object table that you pass in. They
invoke an arbitrary handler to process each record, 
which can send signals, such as 
SIGADD, SIGDEL, SIGERR, SIGOK... The handler can
also send back a feedback record in addition
to the one being processed (for add).
Then record_modify_file() can act upon those signals 
by exiting the iteration loop, or skipping the user 
from writing to the modified stream, or adding a new 
user, etc...

So basically, it comes down to writing a bunch of handlers
that signal the iterator functions. For a different backend,
obviously you'd implement this very differently, since
you don't need to iterate things.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
