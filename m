Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MIdigA008463
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:39:44 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MIYtYP015967
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 18:34:55 GMT
Subject: Re: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Jason Tang <jtang@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1122056898.32644.60.camel@localhost.localdomain>
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
	 <1122039886.24847.6.camel@celtics.boston.redhat.com>
	 <42E10804.5030401@tresys.com>
	 <1122046798.25951.27.camel@celtics.boston.redhat.com>
	 <1122053292.32644.51.camel@localhost.localdomain>
	 <1122054896.29328.16.camel@celtics.boston.redhat.com>
	 <1122056898.32644.60.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 14:32:28 -0400
Message-Id: <1122057148.29328.42.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> No, buffering in callbacks is also dangerous in multi-threaded programs.
> The callback function, if not properly written, is no longer MT-safe nor
> reentrant.

So what you're saying that "a piece of software, if not properly
written, can have bugs". I definitely agree with that :)

> On Fri, 2005-07-22 at 13:59 -0400, Ivan Gyurdiev wrote: 
> > The function name is actually passed back by the error system I have.
> 
> Having a function name is not sufficient for multi-threaded programs.

You can get the thread id via pthread_self(), but this wouldn't work
with RPC.

====

Let's end this discussion here, because I've agreed to use your 
non-callback system, on the grounds that eventually libsemanage
will need to work over the network, where callback error reporting
is probably a mistake.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
