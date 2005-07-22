Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MI6MgA008120
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:06:22 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MI1YYP012206
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 18:01:34 GMT
Subject: RE: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507221631.j6MGVYvx018288@gotham.columbia.tresys.com>
References: <200507221631.j6MGVYvx018288@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 13:59:06 -0400
Message-Id: <1122055146.29328.22.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > (2) I have to rewrite my code to use it, while my API seems better.
> > What's your objection?
> 
> 1) Very difficult to use for a multi-threaded application. How do I know what
> function call by which thread generated the error?

The function name is actually passed back by the error system I have.
I suppose you could have your callback write the thread id (can't
remember if pthread api provides that), although if RPC gets involved
with scheme starts not to make sense.

> 2) Possibly difficult to implement if the the API is making RPC calls to a
> remote server. In that case the underlying implementation will look like what we
> have proposed and will simply strip the error, make the callback, and then
> return normally - all with the same delay as if the api looks like our proposal.

That's a valid argument, I hadn't thought about that issue.
Ok I will alter my code to use your buffer system.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
