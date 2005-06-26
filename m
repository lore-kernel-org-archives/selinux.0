Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5QLgPgA019939
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 17:42:25 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5QLfQqP022634
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 21:41:26 GMT
Subject: Execmem boolean
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sun, 26 Jun 2005 17:42:42 -0400
Message-Id: <1119822163.4357.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Something needs to be done about the allow_execmem boolean - 
the default strict policy configuration on Fedora disables it,
which causes X not to work out of the box under strict policy. 
I think this is highly undesirable.

Should allow_execmem be enabled by default?

I know Stephen was asking about more fine-grained control
over allow_execmem and allow_execmod.

How can we combine those two requirements to come up with
a better solution?

Perhaps have allow_execmem turned on by default,
and then and-ed with per application booleans, we can
turn it off for selected applications?

The opposite approach (off by default, turn on
per application) doesn't work quite so well, beause
then you have per application booleans not respecting
the value of a global allow_execmem...

Or, we could get rid of allow_execmem completely, and
have only per application booleans...

--------

P.S. Please remove the gift port from types/network.te,
because otherwise the gift domain won't compile - this port is 
restricted to gift.te.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
