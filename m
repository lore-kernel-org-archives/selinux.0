Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MIXPgA008378
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:33:25 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MISbYP015179
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 18:28:37 GMT
Subject: Re: Iptables discussion
From: Jason Tang <jtang@tresys.com>
To: gyurdiev@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1122054896.29328.16.camel@celtics.boston.redhat.com>
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
	 <1122039886.24847.6.camel@celtics.boston.redhat.com>
	 <42E10804.5030401@tresys.com>
	 <1122046798.25951.27.camel@celtics.boston.redhat.com>
	 <1122053292.32644.51.camel@localhost.localdomain>
	 <1122054896.29328.16.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 14:28:18 -0400
Message-Id: <1122056898.32644.60.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-22 at 13:54 -0400, Ivan Gyurdiev wrote:
> You can buffer the feedback in the callback function if you wish.

No, buffering in callbacks is also dangerous in multi-threaded programs.
The callback function, if not properly written, is no longer MT-safe nor
reentrant.

On Fri, 2005-07-22 at 13:59 -0400, Ivan Gyurdiev wrote: 
> The function name is actually passed back by the error system I have.

Having a function name is not sufficient for multi-threaded programs.

> I suppose you could have your callback write the thread id (can't
> remember if pthread api provides that),

The function is pthread_self().


-- 
Jason Tang / jtang@tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
