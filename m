Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1OMpRRb026916
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 17:51:27 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1OMnqlK018220
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 22:49:52 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i1OMnpOX018170
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 22:49:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@redhat.com>
Subject: Re: identity
Date: Wed, 25 Feb 2004 09:50:00 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Xine.LNX.4.44.0402240945330.24455-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0402240945330.24455-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402250950.00790.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Feb 2004 01:47, James Morris <jmorris@redhat.com> wrote:
> On Mon, 23 Feb 2004, Russell Coker wrote:
> > The idea is to have something like rjc#10.0.0.1:user_r:user_t to indicate
> > that I logged in from IP address 10.0.0.1.
>
> How would the kernel know the IP address you're logged in from?

The login application would tell it.

> Would you
> also want to log the serial device if that's how the user logged in?

Sure.  That would be easy to do if the kernel supported arbitary text appended 
to the identity.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
