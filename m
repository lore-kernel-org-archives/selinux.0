Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MI2CgA008078
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:02:12 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MHvNYP011562
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 17:57:23 GMT
Subject: Re: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Jason Tang <jtang@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1122053292.32644.51.camel@localhost.localdomain>
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
	 <1122039886.24847.6.camel@celtics.boston.redhat.com>
	 <42E10804.5030401@tresys.com>
	 <1122046798.25951.27.camel@celtics.boston.redhat.com>
	 <1122053292.32644.51.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 13:54:55 -0400
Message-Id: <1122054896.29328.16.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> On Fri, 2005-07-22 at 12:14 -0400, Ivan Gyurdiev wrote: 
> > (1) The errors are buffered, and not displayed as they occur, so you
> > don't know what is happening if something hangs
> 
> As Karl mentioned, callbacks (and other asynchronous events) in
> multi-threaded programs are dangerous.  

I admit that I haven't thought much about the implications
of doing a callback over the wire. For this kind of thing,
it would seem appropriate to buffer error output.

> In addition some programs might
> not want immediate feedback for various reasons or designs. 

You can buffer the feedback in the callback function if you wish.

> In what manner could a program "hang" without affording the possibility
> of reporting an error?  Suppose that your _debug() callback scheme were
> to be employed.  At some point in time the program recognizes an error
> and invokes the callback.  Now instead one were to use our proposed
> error handling scheme.  Instead of making the callback it merely returns
> an error code.  Either way program execution has not hung.

I was thinking of status output, and not error output, so you are
correct that this is not an issue. In the case of status output, it is
easy to tell where a loop/hang may occur, because you can see the 
messages prior.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
