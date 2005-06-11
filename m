Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5BI3WgA027478
	for <selinux@tycho.nsa.gov>; Sat, 11 Jun 2005 14:03:32 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5BHtIfO012754
	for <selinux@tycho.nsa.gov>; Sat, 11 Jun 2005 17:55:18 GMT
Message-Id: <200506111755.j5BHtY5F009857@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>, <selinux@tycho.nsa.gov>
Subject: RE: Nested Booleans
Date: Sat, 11 Jun 2005 13:55:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1118450947.31022.11.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Ivan Gyurdiev
> Sent: Friday, June 10, 2005 8:49 PM
> To: selinux@tycho.nsa.gov
> Subject: Re: Nested Booleans
> 
> On Fri, 2005-06-10 at 20:38 -0400, Ivan Gyurdiev wrote:
> > Why is it not possible to nest booleans - this is always causing
> > problems for me. For example, right now I can't compile my policy,
> > because it contains code like this:
> 
> On second thought this is poorly structured, and doesn't make
> sense - will fix. However, I still think that it would be nice
> if I could nest booleans..

Me too - if you squint at the patches that Josh sent for modules you will see
the infrastructure to support this. The goal is to transform nested conditionals
into non-nested conditionals with appropriate expressions (so that the kernel
will not need changes to understand the nesting). For example:

if (foo) {
	allow a . . .
	if (bar) {
		allow b
	}
}

Would become:

if (foo) {
	allow a . . .
}

if (foo && bar) {
	allow b . . .
}

The fun really starts when you consider type transition rules and arbitrary
nesting with optional blocks for modules (both nesting conditional blocks in
optional blocks and optional blocks in conditionals at arbitrary depths). The
infrastructure we have submitted (and will resubmit with fixes next week) should
handle all of that with some parsing magic. Not certain when we will be able to
create that parsing magic, though, as it is not in our short term plans.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134
 
> --
> Ivan Gyurdiev <ivg2@cornell.edu>
> Cornell University
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
