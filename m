Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MGaXgA007252
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 12:36:34 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MGVkYP002461
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 16:31:46 GMT
Message-Id: <200507221631.j6MGVYvx018288@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Subject: RE: Iptables discussion
Date: Fri, 22 Jul 2005 12:31:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1122048896.26463.20.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, July 22, 2005 12:15 PM
> To: Karl MacMillan
> Cc: 'Joshua Brindle'; 'Daniel J Walsh'; selinux@tycho.nsa.gov
> Subject: RE: Iptables discussion
> 
> 
> > I think that the caller should be able to chose how to display errors - that
> is
> > what this api is for and it seems straight forward to me. What is your
> > objection? Not that may be separate from a logging mechanism that sends
> errors
> > to a log file.
> 
> (1) The errors are buffered, and not displayed as they occur, so you
> don't know what is happening if something hangs
> 

Ok - that makes sense, but see below for how that may not always work. This can
also be solved by careful api design that gives the caller the choice of
immediately aborting on error (which I think is true of the current api
suggestions).

> (2) I have to rewrite my code to use it, while my API seems better.
> What's your objection?

1) Very difficult to use for a multi-threaded application. How do I know what
function call by which thread generated the error?

2) Possibly difficult to implement if the the API is making RPC calls to a
remote server. In that case the underlying implementation will look like what we
have proposed and will simply strip the error, make the callback, and then
return normally - all with the same delay as if the api looks like our proposal.

3) Again, in the server case I don't think that I want to trust the remote
server to pass back a format and a string that I interpret locally. Seems like a
vector for format string vulnerabilities.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
